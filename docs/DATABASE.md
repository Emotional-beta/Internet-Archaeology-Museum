# Database Design / 数据库设计

**Internet Archaeology Museum / 互联网考古博物馆**

Version / 版本: `0.1`

---

## 1. Conventions / 约定

| Convention | Rule | 规则 |
|---|---|---|
| Primary key | `BIGINT UNSIGNED AUTO_INCREMENT` | 主键 |
| Foreign key naming | `<table>_id` | 外键命名 |
| Table naming | `snake_case` | 表名 |
| Column naming | `snake_case` | 字段名 |
| Timestamps | `DATETIME(3)` | 时间戳 |
| Soft delete | `deleted_at DATETIME(3) NULL` | 软删除 |
| Passwords | Bcrypt hash, never plaintext | 密码存储 |

---

## 2. Core Tables / 核心表

### 2.1 `artifact` — Internet Artifact / 互联网文物

The central content table of the museum.

博物馆的核心内容表。

```sql
CREATE TABLE artifact (
    id              BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    slug            VARCHAR(200)    NOT NULL UNIQUE,  -- URL-friendly identifier
    name            VARCHAR(200)    NOT NULL,
    name_zh         VARCHAR(200)    NULL,             -- Chinese name
    category_id     BIGINT UNSIGNED NOT NULL,
    status          TINYINT         NOT NULL DEFAULT 1, -- 1=active, 2=ghost, 3=draft
    founded_year    SMALLINT        NULL,
    closed_year     SMALLINT        NULL,
    founded_date    DATE            NULL,
    closed_date     DATE            NULL,
    country         VARCHAR(10)     NULL,             -- ISO 3166-1 alpha-2
    description     TEXT            NULL,
    description_zh  TEXT            NULL,
    significance    TEXT            NULL,             -- Historical significance
    significance_zh TEXT            NULL,
    what_happened   TEXT            NULL,             -- Why it closed/changed
    what_happened_zh TEXT           NULL,
    cover_image_url VARCHAR(500)    NULL,
    website_url     VARCHAR(500)    NULL,
    archive_url     VARCHAR(500)    NULL,             -- Wayback Machine link
    view_count      INT UNSIGNED    NOT NULL DEFAULT 0,
    memory_count    INT UNSIGNED    NOT NULL DEFAULT 0,
    created_by      BIGINT UNSIGNED NULL,
    created_at      DATETIME(3)     NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    updated_at      DATETIME(3)     NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
    deleted_at      DATETIME(3)     NULL,
    INDEX idx_category (category_id),
    INDEX idx_status (status),
    INDEX idx_founded_year (founded_year),
    INDEX idx_closed_year (closed_year),
    FULLTEXT INDEX ft_name (name, name_zh)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

### 2.2 `artifact_category` — Category / 分类

```sql
CREATE TABLE artifact_category (
    id          BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(100)    NOT NULL,
    name_zh     VARCHAR(100)    NULL,
    slug        VARCHAR(100)    NOT NULL UNIQUE,
    description TEXT            NULL,
    description_zh TEXT         NULL,
    icon        VARCHAR(100)    NULL,
    sort_order  SMALLINT        NOT NULL DEFAULT 0,
    created_at  DATETIME(3)     NOT NULL DEFAULT CURRENT_TIMESTAMP(3)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

### 2.3 `artifact_tag` — Tag / 标签

```sql
CREATE TABLE artifact_tag (
    id          BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(100)    NOT NULL UNIQUE,
    name_zh     VARCHAR(100)    NULL,
    slug        VARCHAR(100)    NOT NULL UNIQUE,
    created_at  DATETIME(3)     NOT NULL DEFAULT CURRENT_TIMESTAMP(3)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

### 2.4 `artifact_tag_rel` — Artifact ↔ Tag Relation / 文物标签关联

```sql
CREATE TABLE artifact_tag_rel (
    artifact_id BIGINT UNSIGNED NOT NULL,
    tag_id      BIGINT UNSIGNED NOT NULL,
    PRIMARY KEY (artifact_id, tag_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

### 2.5 `artifact_image` — Artifact Images / 文物图片

```sql
CREATE TABLE artifact_image (
    id          BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    artifact_id BIGINT UNSIGNED NOT NULL,
    url         VARCHAR(500)    NOT NULL,
    caption     VARCHAR(500)    NULL,
    caption_zh  VARCHAR(500)    NULL,
    year        SMALLINT        NULL,           -- Year the screenshot was taken
    sort_order  SMALLINT        NOT NULL DEFAULT 0,
    created_at  DATETIME(3)     NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    INDEX idx_artifact (artifact_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

### 2.6 `artifact_source` — Sources / 来源

```sql
CREATE TABLE artifact_source (
    id          BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    artifact_id BIGINT UNSIGNED NOT NULL,
    title       VARCHAR(500)    NOT NULL,
    url         VARCHAR(1000)   NULL,
    type        TINYINT         NOT NULL DEFAULT 1, -- 1=website,2=news,3=book,4=archive
    year        SMALLINT        NULL,
    created_at  DATETIME(3)     NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    INDEX idx_artifact (artifact_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

---

## 3. Timeline / 时间轴

### 3.1 `artifact_timeline_event` — Timeline Events / 时间轴事件

```sql
CREATE TABLE artifact_timeline_event (
    id          BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    artifact_id BIGINT UNSIGNED NOT NULL,
    event_date  DATE            NULL,
    event_year  SMALLINT        NOT NULL,
    event_month TINYINT         NULL,
    title       VARCHAR(500)    NOT NULL,
    title_zh    VARCHAR(500)    NULL,
    description TEXT            NULL,
    description_zh TEXT         NULL,
    type        TINYINT         NOT NULL DEFAULT 1, -- 1=launch,2=milestone,3=decline,4=closure
    sort_order  SMALLINT        NOT NULL DEFAULT 0,
    created_at  DATETIME(3)     NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    INDEX idx_artifact (artifact_id),
    INDEX idx_year (event_year)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

---

## 4. Exhibitions / 展览

### 4.1 `exhibition` — Exhibition / 展览

```sql
CREATE TABLE exhibition (
    id              BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    slug            VARCHAR(200)    NOT NULL UNIQUE,
    title           VARCHAR(300)    NOT NULL,
    title_zh        VARCHAR(300)    NULL,
    subtitle        VARCHAR(500)    NULL,
    subtitle_zh     VARCHAR(500)    NULL,
    description     TEXT            NULL,
    description_zh  TEXT            NULL,
    cover_image_url VARCHAR(500)    NULL,
    status          TINYINT         NOT NULL DEFAULT 1, -- 1=published,2=draft
    era_start       SMALLINT        NULL,
    era_end         SMALLINT        NULL,
    sort_order      SMALLINT        NOT NULL DEFAULT 0,
    view_count      INT UNSIGNED    NOT NULL DEFAULT 0,
    created_by      BIGINT UNSIGNED NULL,
    created_at      DATETIME(3)     NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    updated_at      DATETIME(3)     NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
    deleted_at      DATETIME(3)     NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

### 4.2 `exhibition_artifact` — Exhibition ↔ Artifact Relation / 展览文物关联

```sql
CREATE TABLE exhibition_artifact (
    exhibition_id   BIGINT UNSIGNED NOT NULL,
    artifact_id     BIGINT UNSIGNED NOT NULL,
    sort_order      SMALLINT        NOT NULL DEFAULT 0,
    note            TEXT            NULL,
    note_zh         TEXT            NULL,
    PRIMARY KEY (exhibition_id, artifact_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

---

## 5. Digital Ghosts / 数字幽灵

### 5.1 `digital_ghost` — Digital Ghost / 数字幽灵

Extends `artifact` for permanently disappeared Internet entities.

扩展 `artifact` 表，用于永久消失的互联网实体。

```sql
CREATE TABLE digital_ghost (
    id              BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    artifact_id     BIGINT UNSIGNED NOT NULL UNIQUE,
    closure_reason  TINYINT         NULL, -- 1=shutdown,2=acquired,3=pivoted,4=bankruptcy
    closure_note    TEXT            NULL,
    closure_note_zh TEXT            NULL,
    memorial_text   TEXT            NULL,
    memorial_text_zh TEXT           NULL,
    created_at      DATETIME(3)     NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    INDEX idx_artifact (artifact_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

---

## 6. Memory System / 记忆系统

### 6.1 `memory` — User Memory / 用户记忆

```sql
CREATE TABLE memory (
    id          BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    artifact_id BIGINT UNSIGNED NOT NULL,
    user_id     BIGINT UNSIGNED NOT NULL,
    content     TEXT            NOT NULL,
    year        SMALLINT        NULL,     -- Approximate year of the memory
    like_count  INT UNSIGNED    NOT NULL DEFAULT 0,
    status      TINYINT         NOT NULL DEFAULT 1, -- 1=published,2=pending,3=hidden
    created_at  DATETIME(3)     NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    updated_at  DATETIME(3)     NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
    deleted_at  DATETIME(3)     NULL,
    INDEX idx_artifact (artifact_id),
    INDEX idx_user (user_id),
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

### 6.2 `memory_like` — Memory Likes / 记忆点赞

```sql
CREATE TABLE memory_like (
    memory_id   BIGINT UNSIGNED NOT NULL,
    user_id     BIGINT UNSIGNED NOT NULL,
    created_at  DATETIME(3)     NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    PRIMARY KEY (memory_id, user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

---

## 7. User System / 用户系统

### 7.1 `user` — User Account / 用户账户

```sql
CREATE TABLE user (
    id              BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    username        VARCHAR(50)     NOT NULL UNIQUE,
    email           VARCHAR(200)    NOT NULL UNIQUE,
    password_hash   VARCHAR(255)    NOT NULL,    -- Bcrypt
    display_name    VARCHAR(100)    NULL,
    avatar_url      VARCHAR(500)    NULL,
    bio             TEXT            NULL,
    role            TINYINT         NOT NULL DEFAULT 1, -- 1=member,2=contributor,3=curator,4=admin
    status          TINYINT         NOT NULL DEFAULT 1, -- 1=active,2=suspended
    last_login_at   DATETIME(3)     NULL,
    created_at      DATETIME(3)     NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    updated_at      DATETIME(3)     NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
    deleted_at      DATETIME(3)     NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

### 7.2 `user_collection` — User Collections / 用户收藏

```sql
CREATE TABLE user_collection (
    user_id     BIGINT UNSIGNED NOT NULL,
    artifact_id BIGINT UNSIGNED NOT NULL,
    created_at  DATETIME(3)     NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    PRIMARY KEY (user_id, artifact_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

---

## 8. Contribution System / 贡献系统

### 8.1 `contribution` — User Contribution / 用户贡献

```sql
CREATE TABLE contribution (
    id              BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id         BIGINT UNSIGNED NOT NULL,
    type            TINYINT         NOT NULL, -- 1=new_artifact,2=edit,3=source,4=image
    artifact_id     BIGINT UNSIGNED NULL,     -- NULL if creating new artifact
    payload         JSON            NOT NULL, -- Submitted data
    status          TINYINT         NOT NULL DEFAULT 1, -- 1=pending,2=approved,3=rejected
    reviewer_id     BIGINT UNSIGNED NULL,
    reviewer_note   TEXT            NULL,
    reviewed_at     DATETIME(3)     NULL,
    created_at      DATETIME(3)     NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    updated_at      DATETIME(3)     NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
    INDEX idx_user (user_id),
    INDEX idx_status (status),
    INDEX idx_type (type)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

---

## 9. Archaeology System / 考古系统

### 9.1 `archaeology_task` — Task / 考古任务

```sql
CREATE TABLE archaeology_task (
    id              BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    title           VARCHAR(300)    NOT NULL,
    title_zh        VARCHAR(300)    NULL,
    description     TEXT            NULL,
    description_zh  TEXT            NULL,
    artifact_id     BIGINT UNSIGNED NULL,     -- Task associated with a specific artifact
    type            TINYINT         NOT NULL, -- 1=verify_info,2=find_source,3=add_memory
    difficulty      TINYINT         NOT NULL DEFAULT 1, -- 1=easy,2=medium,3=hard
    status          TINYINT         NOT NULL DEFAULT 1, -- 1=open,2=completed,3=closed
    created_at      DATETIME(3)     NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    INDEX idx_artifact (artifact_id),
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

---

## 10. Table Dependency Summary / 表依赖关系摘要

```text
artifact_category
      └── artifact ──────────────────────────────────────────┐
            ├── artifact_tag_rel ── artifact_tag              │
            ├── artifact_image                                │
            ├── artifact_source                               │
            ├── artifact_timeline_event                       │
            ├── digital_ghost                                 │
            ├── exhibition_artifact ── exhibition             │
            ├── memory ── memory_like                         │
            ├── user_collection                               │
            ├── contribution                                  │
            └── archaeology_task                              │
                                                              │
user ─────────────────────────────────────────────────────────┘
  (user_id references: memory, memory_like, user_collection,
   contribution, archaeology_task results)
```
