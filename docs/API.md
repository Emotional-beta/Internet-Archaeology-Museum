# API Documentation / API 文档

**Internet Archaeology Museum / 互联网考古博物馆**

Version / 版本: `v1`  
Base URL / 基础路径: `/api/v1`

---

## 1. Conventions / 约定

### Response Format / 响应格式

All responses use a unified wrapper:

所有响应使用统一包装：

```json
{
  "code": 0,
  "message": "success",
  "data": {}
}
```

| `code` | Meaning | 含义 |
|---|---|---|
| `0` | Success | 成功 |
| `400` | Bad request | 请求参数错误 |
| `401` | Unauthorized | 未认证 |
| `403` | Forbidden | 无权限 |
| `404` | Not found | 资源不存在 |
| `500` | Server error | 服务器错误 |

### Pagination / 分页

Paginated responses return:

分页响应返回：

```json
{
  "code": 0,
  "message": "success",
  "data": {
    "list": [],
    "total": 100,
    "page": 1,
    "pageSize": 20
  }
}
```

Pagination parameters / 分页参数：

| Parameter | Type | Default | Description |
|---|---|---|---|
| `page` | int | 1 | Page number / 页码 |
| `pageSize` | int | 20 | Items per page / 每页数量 |

### Authentication / 认证

Protected endpoints require a JWT token in the Authorization header:

受保护的接口需要在 Authorization 头中提供 JWT 令牌：

```
Authorization: Bearer <token>
```

---

## 2. Artifacts / 文物

### GET `/api/v1/artifacts`

List artifacts with optional filters.

列出文物，支持可选筛选条件。

**Query Parameters / 查询参数:**

| Parameter | Type | Description |
|---|---|---|
| `page` | int | Page number |
| `pageSize` | int | Items per page |
| `category` | string | Category slug |
| `era` | string | Era (e.g. `1990s`, `2000s`) |
| `status` | int | 1=active, 2=ghost |
| `q` | string | Full-text search query |

**Response / 响应:**

```json
{
  "code": 0,
  "message": "success",
  "data": {
    "list": [
      {
        "id": 1,
        "slug": "renren",
        "name": "人人网",
        "nameZh": "人人网",
        "category": { "id": 3, "name": "Social Network", "nameZh": "社交网络" },
        "foundedYear": 2005,
        "closedYear": null,
        "status": 2,
        "coverImageUrl": "...",
        "memoryCount": 248,
        "viewCount": 15230
      }
    ],
    "total": 142,
    "page": 1,
    "pageSize": 20
  }
}
```

---

### GET `/api/v1/artifacts/{slug}`

Get a single artifact by its slug.

通过 slug 获取单个文物。

**Response / 响应:**

```json
{
  "code": 0,
  "message": "success",
  "data": {
    "id": 1,
    "slug": "renren",
    "name": "人人网",
    "nameZh": "人人网",
    "category": { "id": 3, "name": "Social Network", "nameZh": "社交网络" },
    "tags": [{ "id": 1, "name": "china", "nameZh": "中国" }],
    "foundedYear": 2005,
    "closedYear": null,
    "country": "CN",
    "description": "...",
    "descriptionZh": "...",
    "significance": "...",
    "significanceZh": "...",
    "whatHappened": "...",
    "whatHappenedZh": "...",
    "websiteUrl": "...",
    "archiveUrl": "...",
    "images": [...],
    "sources": [...],
    "timelineEvents": [...],
    "memoryCount": 248,
    "viewCount": 15230,
    "isCollected": false
  }
}
```

---

### GET `/api/v1/artifacts/{slug}/memories`

Get memories for an artifact, paginated.

获取文物的用户记忆，分页。

---

### POST `/api/v1/artifacts` *(Curator+)*

Create a new artifact.

创建新文物。（需要策展人权限）

---

### PUT `/api/v1/artifacts/{slug}` *(Curator+)*

Update an artifact.

更新文物。（需要策展人权限）

---

## 3. Timeline / 时间轴

### GET `/api/v1/timeline`

Get a summary of artifacts by era for the timeline view.

获取按时代分组的文物摘要，用于时间轴视图。

**Query Parameters:**

| Parameter | Type | Description |
|---|---|---|
| `era` | string | Filter by era (`1990s`, `2000s`, `2010s`, `2020s`) |

---

## 4. Exhibitions / 展览

### GET `/api/v1/exhibitions`

List all published exhibitions.

列出所有已发布的展览。

### GET `/api/v1/exhibitions/{slug}`

Get a full exhibition with its artifacts.

获取展览及其包含的文物。

---

## 5. Memories / 记忆

### GET `/api/v1/memories`

List memories, optionally filtered by artifact.

列出记忆，可选按文物筛选。

### POST `/api/v1/memories` *(Member+)*

Submit a new memory.

提交新记忆。

```json
{
  "artifactId": 1,
  "content": "I remember creating my account on the first day...",
  "year": 2009
}
```

### POST `/api/v1/memories/{id}/like` *(Member+)*

Like a memory.

点赞记忆。

---

## 6. Search / 搜索

### GET `/api/v1/search`

Search across artifacts, exhibitions, and memories.

跨文物、展览和记忆进行搜索。

**Query Parameters:**

| Parameter | Type | Description |
|---|---|---|
| `q` | string | Search query (required) |
| `type` | string | `artifact`, `exhibition`, `memory` |
| `page` | int | Page number |

---

## 7. Collections / 收藏

### GET `/api/v1/users/me/collections` *(Member+)*

Get the current user's collections.

获取当前用户的收藏。

### POST `/api/v1/artifacts/{slug}/collect` *(Member+)*

Add an artifact to collection.

将文物加入收藏。

### DELETE `/api/v1/artifacts/{slug}/collect` *(Member+)*

Remove an artifact from collection.

从收藏中移除文物。

---

## 8. User / 用户

### POST `/api/v1/auth/register`

Register a new account.

注册新账户。

```json
{
  "username": "explorer",
  "email": "user@example.com",
  "password": "..."
}
```

### POST `/api/v1/auth/login`

Login and receive a JWT token.

登录并获取 JWT 令牌。

```json
{
  "email": "user@example.com",
  "password": "..."
}
```

### POST `/api/v1/auth/refresh`

Refresh the JWT token using a refresh token.

使用刷新令牌刷新 JWT 令牌。

### GET `/api/v1/users/me` *(Member+)*

Get the current user's profile.

获取当前用户的个人资料。

---

## 9. Contributions / 贡献

### POST `/api/v1/contributions` *(Member+)*

Submit a content contribution for review.

提交内容贡献以供审核。

```json
{
  "type": 1,
  "payload": {
    "name": "Kaixin001",
    "nameZh": "开心网",
    "categoryId": 3,
    "foundedYear": 2008,
    "description": "..."
  }
}
```

### GET `/api/v1/contributions` *(Curator+)*

List pending contributions for review.

列出待审核的贡献。（需要策展人权限）

---

## 10. Digital Ghosts / 数字幽灵

### GET `/api/v1/ghosts`

List Digital Ghosts.

列出数字幽灵。

### GET `/api/v1/ghosts/{slug}`

Get a Digital Ghost detail page.

获取数字幽灵详情页。
