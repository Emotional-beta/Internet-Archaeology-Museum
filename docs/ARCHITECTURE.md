# Architecture / 架构文档

**Internet Archaeology Museum / 互联网考古博物馆**

Version / 版本: `0.1`

---

## 1. Overview / 概述

The application uses a **modular monolithic** architecture.

应用程序采用**模块化单体**架构。

This means the entire application is deployed as one unit, but the internal code is organized into clearly separated modules. This keeps the system simple while still maintaining clean separation of concerns.

这意味着整个应用程序作为一个单元部署，但内部代码被组织成清晰分离的模块。这在保持代码关注点清晰分离的同时，让系统保持简单。

Microservices are intentionally deferred. If scaling requirements emerge later, the modular structure makes extraction straightforward.

有意推迟微服务。如果后来出现扩展需求，模块化结构使服务拆分变得简单。

---

## 2. System Architecture / 系统架构

```text
                         Internet / 互联网
                               │
                               ▼
                     ┌─────────────────────┐
                     │     Nginx / CDN      │
                     │  (Reverse proxy /    │
                     │   Static files)      │
                     └─────────┬───────────┘
                               │
              ┌────────────────┴────────────────┐
              │                                 │
              ▼                                 ▼
   ┌─────────────────────┐          ┌──────────────────────┐
   │   Vue 3 Frontend     │          │    Static Storage    │
   │   (SPA, served by    │          │  (Images, media,     │
   │    Nginx)            │          │   archive files)     │
   └──────────┬──────────┘          └──────────────────────┘
              │
              │ REST API / JSON
              ▼
   ┌─────────────────────┐
   │  Spring Boot API     │
   │  (Java 21)           │
   └─────┬──────┬────────┘
         │      │
    ┌────┘      └──────┐
    ▼                  ▼
┌───────┐         ┌─────────┐
│ MySQL │         │  Redis  │
│  (DB) │         │ (Cache) │
└───────┘         └─────────┘
```

---

## 3. Frontend Architecture / 前端架构

### Technology / 技术

- **Vue 3** with Composition API
- **TypeScript** for type safety
- **Vite** as the build tool
- **Vue Router** for client-side routing
- **Pinia** for state management
- **Element Plus** as the component library
- **ECharts** for timeline and data visualization
- **GSAP** for animations

### Directory Structure / 目录结构

```text
frontend/
├── src/
│   ├── api/              # API call modules / API 调用模块
│   │   ├── artifact.ts
│   │   ├── exhibition.ts
│   │   ├── memory.ts
│   │   ├── user.ts
│   │   └── archaeology.ts
│   │
│   ├── assets/           # Static assets / 静态资源
│   ├── components/       # Shared components / 共享组件
│   │   ├── artifact/
│   │   ├── timeline/
│   │   ├── exhibition/
│   │   └── common/
│   │
│   ├── composables/      # Reusable composition logic / 可复用组合逻辑
│   ├── layouts/          # Page layouts / 页面布局
│   ├── router/           # Route definitions / 路由定义
│   ├── stores/           # Pinia stores / Pinia 状态
│   ├── types/            # TypeScript types / TypeScript 类型
│   ├── utils/            # Utility functions / 工具函数
│   │
│   └── views/            # Page views / 页面视图
│       ├── home/
│       ├── artifact/
│       ├── timeline/
│       ├── exhibition/
│       ├── ghost/
│       ├── memory/
│       ├── archaeology/
│       └── user/
│
├── public/
├── index.html
├── vite.config.ts
├── tsconfig.json
└── package.json
```

### Key Design Rules / 关键设计规则

- All API calls go through `api/` modules — never call Axios directly in components / 所有 API 调用通过 `api/` 模块，不在组件中直接调用 Axios
- Components handle UI only; business logic goes in composables or stores / 组件只处理 UI，业务逻辑放在 composables 或 stores 中
- Use TypeScript types for all API responses and shared data structures / 所有 API 响应和共享数据结构使用 TypeScript 类型

---

## 4. Backend Architecture / 后端架构

### Technology / 技术

- **Java 21**
- **Spring Boot 3**
- **Spring Security** for authentication and authorization
- **MyBatis-Plus** for database access
- **Maven** for build management

### Directory Structure / 目录结构

```text
backend/
└── src/main/java/com/museum/
    ├── common/                # Shared utilities / 共享工具
    │   ├── response/          # Unified response wrapper / 统一响应包装
    │   ├── exception/         # Global exception handling / 全局异常处理
    │   ├── config/            # Spring configuration / Spring 配置
    │   └── utils/
    │
    ├── module/
    │   ├── artifact/          # Artifact module / 文物模块
    │   │   ├── controller/
    │   │   ├── service/
    │   │   ├── mapper/
    │   │   ├── entity/
    │   │   ├── dto/
    │   │   ├── vo/
    │   │   └── enums/
    │   │
    │   ├── exhibition/        # Exhibition module / 展览模块
    │   ├── memory/            # Memory module / 记忆模块
    │   ├── archaeology/       # Archaeology module / 考古模块
    │   ├── ghost/             # Digital Ghosts module / 数字幽灵模块
    │   ├── contribution/      # Contribution module / 贡献模块
    │   ├── user/              # User module / 用户模块
    │   └── admin/             # Admin module / 管理模块
    │
    └── MuseumApplication.java
```

### Layer Responsibilities / 各层职责

| Layer | Responsibility | 职责 |
|---|---|---|
| Controller | HTTP in/out, parameter validation, auth check | HTTP 输入输出、参数校验、权限检查 |
| Service | Business logic, transaction management | 业务逻辑、事务管理 |
| Mapper | Database queries via MyBatis-Plus | MyBatis-Plus 数据库查询 |
| Entity | Database table mapping | 数据库表映射 |
| DTO | Inbound data transfer objects | 入参数据传输对象 |
| VO | Outbound view objects | 出参视图对象 |

### Unified API Response / 统一 API 响应

All API responses use this wrapper / 所有 API 响应使用此包装：

```java
public class Result<T> {
    private int code;       // 0 = success
    private String message;
    private T data;
}
```

---

## 5. Database / 数据库

See `docs/DATABASE.md` for the full schema.

完整数据库结构见 `docs/DATABASE.md`。

- **MySQL 8** as the primary database
- **Redis** for session cache and hot-data caching
- All timestamps use `DATETIME(3)`
- All primary keys use `BIGINT UNSIGNED`
- Soft deletes using `deleted_at` where applicable

---

## 6. Caching Strategy / 缓存策略

| Data | Cache | TTL |
|---|---|---|
| Artifact detail / 文物详情 | Redis | 10 min |
| Exhibition list / 展览列表 | Redis | 30 min |
| Timeline summary / 时间轴摘要 | Redis | 60 min |
| User session / 用户会话 | Redis | 7 days |
| Search results / 搜索结果 | Redis | 5 min |

---

## 7. Authentication / 认证

- JWT-based stateless authentication
- Refresh token stored in Redis
- Sensitive admin routes require elevated role verification

基于 JWT 的无状态认证，刷新令牌存储在 Redis 中，敏感管理路由需要角色权限验证。

---

## 8. Deployment / 部署

See `docs/DEPLOYMENT.md` for full details.

完整部署说明见 `docs/DEPLOYMENT.md`。

Local development uses Docker Compose.

本地开发使用 Docker Compose。

```text
docker-compose up -d
```

---

## 9. Development Principles / 开发原则

- Keep the architecture simple and understandable / 保持架构简单可理解
- Prefer boring technology over trendy technology / 优先选择成熟技术而非流行技术
- Every module should be independently testable / 每个模块应可独立测试
- Database schema is the source of truth — update `DATABASE.md` when it changes / 数据库结构是真理的来源，变更时更新 `DATABASE.md`
