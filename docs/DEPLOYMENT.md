# Deployment Guide / 部署指南

**Internet Archaeology Museum / 互联网考古博物馆**

Version / 版本: `0.1`

---

## 1. Overview / 概述

The application consists of three runtime components:

应用程序由三个运行时组件组成：

| Component | Technology | Port |
|---|---|---|
| Frontend / 前端 | Vue 3 (Nginx) | 80 / 443 |
| Backend API / 后端 API | Spring Boot (Java 21) | 8080 |
| Database / 数据库 | MySQL 8 | 3306 |
| Cache / 缓存 | Redis 7 | 6379 |

---

## 2. Local Development / 本地开发

### 2.1 Requirements / 环境要求

```text
Java 21+
Node.js 20+
Maven 3.9+
Docker
Docker Compose
Git
```

### 2.2 Start with Docker Compose / 使用 Docker Compose 启动

The fastest way to start the full stack locally:

本地启动完整技术栈最快的方式：

```bash
# Clone the repository / 克隆仓库
git clone https://github.com/your-org/internet-archaeology-museum.git
cd internet-archaeology-museum

# Copy environment config / 复制环境配置
cp .env.example .env

# Start all services / 启动所有服务
docker-compose -f docker/docker-compose.yml up -d
```

Services will be available at / 服务将在以下地址可用：

- Frontend / 前端: `http://localhost:3000`
- Backend API / 后端 API: `http://localhost:8080`
- MySQL: `localhost:3306`
- Redis: `localhost:6379`

### 2.3 Backend Only / 仅后端

```bash
cd backend

# Create application-local.yml with your DB credentials
# 创建包含数据库凭证的 application-local.yml
cp src/main/resources/application-example.yml src/main/resources/application-local.yml

mvn spring-boot:run -Dspring-boot.run.profiles=local
```

### 2.4 Frontend Only / 仅前端

```bash
cd frontend
npm install
npm run dev
```

Frontend dev server runs at `http://localhost:5173` with API proxy to `localhost:8080`.

前端开发服务器运行在 `http://localhost:5173`，API 代理到 `localhost:8080`。

---

## 3. Environment Variables / 环境变量

Copy `.env.example` to `.env` and fill in values. Never commit `.env`.

将 `.env.example` 复制到 `.env` 并填写值。不要提交 `.env`。

```bash
# Database / 数据库
DB_HOST=localhost
DB_PORT=3306
DB_NAME=museum
DB_USERNAME=museum_user
DB_PASSWORD=             # Fill in / 填写

# Redis
REDIS_HOST=localhost
REDIS_PORT=6379
REDIS_PASSWORD=          # Fill in if set / 如有设置则填写

# JWT
JWT_SECRET=              # Use a long random string / 使用长随机字符串
JWT_EXPIRY_HOURS=24
JWT_REFRESH_EXPIRY_DAYS=7

# File Storage / 文件存储
STORAGE_TYPE=local        # local or s3
STORAGE_LOCAL_PATH=./uploads
# STORAGE_S3_BUCKET=
# STORAGE_S3_REGION=
# AWS_ACCESS_KEY_ID=
# AWS_SECRET_ACCESS_KEY=

# Application / 应用
APP_ENV=development       # development | production
APP_BASE_URL=http://localhost:8080
```

---

## 4. Database Setup / 数据库初始化

### 4.1 Create Database / 创建数据库

```sql
CREATE DATABASE museum
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

CREATE USER 'museum_user'@'%' IDENTIFIED BY 'your_password';
GRANT ALL PRIVILEGES ON museum.* TO 'museum_user'@'%';
FLUSH PRIVILEGES;
```

### 4.2 Run Schema / 运行建表脚本

The `--default-character-set=utf8mb4` flag is required — without it the MySQL client may corrupt multibyte (Chinese) characters mid-statement and throw a syntax error.

必须加 `--default-character-set=utf8mb4`，否则 MySQL 客户端在传输多字节中文字符时可能截断，导致 SQL 语法错误。

```bash
mysql --default-character-set=utf8mb4 -u museum_user -p museum < database/schema.sql
```

### 4.3 Run Seed Data / 运行种子数据

```bash
mysql --default-character-set=utf8mb4 -u museum_user -p museum < database/seed.sql
```

---

## 5. Building for Production / 生产构建

### 5.1 Backend / 后端

```bash
cd backend
mvn clean package -DskipTests
# Output: target/museum-api.jar
```

### 5.2 Frontend / 前端

```bash
cd frontend
npm run build
# Output: dist/
```

The built `dist/` folder is served by Nginx.

构建好的 `dist/` 目录由 Nginx 提供服务。

---

## 6. Production Deployment / 生产部署

### 6.1 Recommended Stack / 推荐技术栈

```text
                    Nginx (SSL termination, reverse proxy)
                         │
          ┌──────────────┴──────────────┐
          │                             │
    Vue 3 (static)              Spring Boot API
                                       │
                          ┌────────────┴────────────┐
                          │                         │
                        MySQL                     Redis
```

### 6.2 Nginx Configuration / Nginx 配置

Example Nginx config for production:

生产环境 Nginx 配置示例：

```nginx
server {
    listen 80;
    server_name your-domain.com;
    return 301 https://$server_name$request_uri;
}

server {
    listen 443 ssl;
    server_name your-domain.com;

    ssl_certificate     /etc/ssl/certs/museum.crt;
    ssl_certificate_key /etc/ssl/private/museum.key;

    # Frontend static files
    location / {
        root /var/www/museum/frontend/dist;
        try_files $uri $uri/ /index.html;
        expires 1d;
    }

    # Backend API
    location /api/ {
        proxy_pass http://127.0.0.1:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    # Uploaded files
    location /uploads/ {
        root /var/www/museum;
        expires 30d;
    }
}
```

### 6.3 Backend Service (systemd) / 后端服务

```ini
# /etc/systemd/system/museum-api.service

[Unit]
Description=Internet Archaeology Museum API
After=network.target mysql.service redis.service

[Service]
Type=simple
User=museum
WorkingDirectory=/var/www/museum/backend
ExecStart=/usr/bin/java -jar museum-api.jar --spring.profiles.active=production
Restart=on-failure
RestartSec=10
StandardOutput=journal
StandardError=journal

[Install]
WantedBy=multi-user.target
```

```bash
systemctl enable museum-api
systemctl start museum-api
```

---

## 7. Health Check / 健康检查

Spring Boot Actuator provides a health endpoint:

Spring Boot Actuator 提供健康检查端点：

```
GET /actuator/health
```

For production, restrict Actuator access to internal networks only.

生产环境中，将 Actuator 访问限制为仅限内部网络。

---

## 8. Security Checklist for Production / 生产安全检查清单

- [ ] HTTPS enabled with valid SSL certificate / 已启用 HTTPS 和有效的 SSL 证书
- [ ] `.env` not committed to repository / `.env` 未提交到仓库
- [ ] Database password is strong and unique / 数据库密码强且唯一
- [ ] JWT secret is long (≥ 64 chars) and random / JWT 密钥足够长（≥ 64 字符）且随机
- [ ] Actuator endpoints restricted to localhost / Actuator 端点限制为 localhost
- [ ] MySQL only accessible from application server / MySQL 只能从应用服务器访问
- [ ] Redis is password protected if exposed / 如 Redis 对外暴露则设置密码
- [ ] File upload directory is outside web root / 文件上传目录在 web 根目录之外
- [ ] Production logs do not contain secrets / 生产日志不包含密钥
