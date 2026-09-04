-- Internet Archaeology Museum / 互联网考古博物馆
-- Database Schema / 数据库结构
-- Version: 0.1

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- -----------------------------------------------------------
-- artifact_category / 文物分类
-- -----------------------------------------------------------
CREATE TABLE IF NOT EXISTS artifact_category (
    id              BIGINT UNSIGNED     AUTO_INCREMENT PRIMARY KEY,
    name            VARCHAR(100)        NOT NULL,
    name_zh         VARCHAR(100)        NULL,
    slug            VARCHAR(100)        NOT NULL UNIQUE,
    description     TEXT                NULL,
    description_zh  TEXT                NULL,
    icon            VARCHAR(100)        NULL,
    sort_order      SMALLINT            NOT NULL DEFAULT 0,
    created_at      DATETIME(3)         NOT NULL DEFAULT CURRENT_TIMESTAMP(3)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------
-- artifact / 互联网文物
-- -----------------------------------------------------------
CREATE TABLE IF NOT EXISTS artifact (
    id              BIGINT UNSIGNED     AUTO_INCREMENT PRIMARY KEY,
    slug            VARCHAR(200)        NOT NULL UNIQUE,
    name            VARCHAR(200)        NOT NULL,
    name_zh         VARCHAR(200)        NULL,
    category_id     BIGINT UNSIGNED     NOT NULL,
    status          TINYINT             NOT NULL DEFAULT 1 COMMENT '1=active 2=ghost 3=draft',
    founded_year    SMALLINT            NULL,
    closed_year     SMALLINT            NULL,
    founded_date    DATE                NULL,
    closed_date     DATE                NULL,
    country         VARCHAR(10)         NULL COMMENT 'ISO 3166-1 alpha-2',
    description     TEXT                NULL,
    description_zh  TEXT                NULL,
    significance    TEXT                NULL,
    significance_zh TEXT                NULL,
    what_happened   TEXT                NULL,
    what_happened_zh TEXT               NULL,
    cover_image_url VARCHAR(500)        NULL,
    website_url     VARCHAR(500)        NULL,
    archive_url     VARCHAR(500)        NULL,
    view_count      INT UNSIGNED        NOT NULL DEFAULT 0,
    memory_count    INT UNSIGNED        NOT NULL DEFAULT 0,
    created_by      BIGINT UNSIGNED     NULL,
    created_at      DATETIME(3)         NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    updated_at      DATETIME(3)         NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
    deleted_at      DATETIME(3)         NULL,
    INDEX idx_category_id (category_id),
    INDEX idx_status (status),
    INDEX idx_founded_year (founded_year),
    INDEX idx_closed_year (closed_year),
    INDEX idx_deleted_at (deleted_at),
    FULLTEXT INDEX ft_name (name, name_zh)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------
-- artifact_tag / 文物标签
-- -----------------------------------------------------------
CREATE TABLE IF NOT EXISTS artifact_tag (
    id          BIGINT UNSIGNED     AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(100)        NOT NULL UNIQUE,
    name_zh     VARCHAR(100)        NULL,
    slug        VARCHAR(100)        NOT NULL UNIQUE,
    created_at  DATETIME(3)         NOT NULL DEFAULT CURRENT_TIMESTAMP(3)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------
-- artifact_tag_rel / 文物标签关联
-- -----------------------------------------------------------
CREATE TABLE IF NOT EXISTS artifact_tag_rel (
    artifact_id BIGINT UNSIGNED     NOT NULL,
    tag_id      BIGINT UNSIGNED     NOT NULL,
    PRIMARY KEY (artifact_id, tag_id),
    INDEX idx_tag_id (tag_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- -----------------------------------------------------------
-- artifact_image / 文物图片
-- -----------------------------------------------------------
CREATE TABLE IF NOT EXISTS artifact_image (
    id          BIGINT UNSIGNED     AUTO_INCREMENT PRIMARY KEY,
    artifact_id BIGINT UNSIGNED     NOT NULL,
    url         VARCHAR(500)        NOT NULL,
    caption     VARCHAR(500)        NULL,
    caption_zh  VARCHAR(500)        NULL,
    year        SMALLINT            NULL,
    sort_order  SMALLINT            NOT NULL DEFAULT 0,
    created_at  DATETIME(3)         NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    INDEX idx_artifact_id (artifact_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------
-- artifact_source / 文物来源
-- -----------------------------------------------------------
CREATE TABLE IF NOT EXISTS artifact_source (
    id          BIGINT UNSIGNED     AUTO_INCREMENT PRIMARY KEY,
    artifact_id BIGINT UNSIGNED     NOT NULL,
    title       VARCHAR(500)        NOT NULL,
    url         VARCHAR(1000)       NULL,
    type        TINYINT             NOT NULL DEFAULT 1 COMMENT '1=website 2=news 3=book 4=archive 5=interview',
    year        SMALLINT            NULL,
    created_at  DATETIME(3)         NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    INDEX idx_artifact_id (artifact_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------
-- artifact_timeline_event / 文物时间轴事件
-- -----------------------------------------------------------
CREATE TABLE IF NOT EXISTS artifact_timeline_event (
    id              BIGINT UNSIGNED     AUTO_INCREMENT PRIMARY KEY,
    artifact_id     BIGINT UNSIGNED     NOT NULL,
    event_date      DATE                NULL,
    event_year      SMALLINT            NOT NULL,
    event_month     TINYINT             NULL,
    title           VARCHAR(500)        NOT NULL,
    title_zh        VARCHAR(500)        NULL,
    description     TEXT                NULL,
    description_zh  TEXT                NULL,
    type            TINYINT             NOT NULL DEFAULT 1 COMMENT '1=launch 2=milestone 3=decline 4=closure',
    sort_order      SMALLINT            NOT NULL DEFAULT 0,
    created_at      DATETIME(3)         NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    INDEX idx_artifact_id (artifact_id),
    INDEX idx_event_year (event_year)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------
-- digital_ghost / 数字幽灵
-- -----------------------------------------------------------
CREATE TABLE IF NOT EXISTS digital_ghost (
    id              BIGINT UNSIGNED     AUTO_INCREMENT PRIMARY KEY,
    artifact_id     BIGINT UNSIGNED     NOT NULL UNIQUE,
    closure_reason  TINYINT             NULL COMMENT '1=shutdown 2=acquired 3=pivoted 4=bankruptcy',
    closure_note    TEXT                NULL,
    closure_note_zh TEXT                NULL,
    memorial_text   TEXT                NULL,
    memorial_text_zh TEXT               NULL,
    created_at      DATETIME(3)         NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    INDEX idx_artifact_id (artifact_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------
-- exhibition / 展览
-- -----------------------------------------------------------
CREATE TABLE IF NOT EXISTS exhibition (
    id              BIGINT UNSIGNED     AUTO_INCREMENT PRIMARY KEY,
    slug            VARCHAR(200)        NOT NULL UNIQUE,
    title           VARCHAR(300)        NOT NULL,
    title_zh        VARCHAR(300)        NULL,
    subtitle        VARCHAR(500)        NULL,
    subtitle_zh     VARCHAR(500)        NULL,
    description     TEXT                NULL,
    description_zh  TEXT                NULL,
    cover_image_url VARCHAR(500)        NULL,
    status          TINYINT             NOT NULL DEFAULT 1 COMMENT '1=published 2=draft',
    era_start       SMALLINT            NULL,
    era_end         SMALLINT            NULL,
    sort_order      SMALLINT            NOT NULL DEFAULT 0,
    view_count      INT UNSIGNED        NOT NULL DEFAULT 0,
    created_by      BIGINT UNSIGNED     NULL,
    created_at      DATETIME(3)         NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    updated_at      DATETIME(3)         NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
    deleted_at      DATETIME(3)         NULL,
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------
-- exhibition_artifact / 展览文物关联
-- -----------------------------------------------------------
CREATE TABLE IF NOT EXISTS exhibition_artifact (
    exhibition_id   BIGINT UNSIGNED     NOT NULL,
    artifact_id     BIGINT UNSIGNED     NOT NULL,
    sort_order      SMALLINT            NOT NULL DEFAULT 0,
    note            TEXT                NULL,
    note_zh         TEXT                NULL,
    PRIMARY KEY (exhibition_id, artifact_id),
    INDEX idx_artifact_id (artifact_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- -----------------------------------------------------------
-- user / 用户
-- -----------------------------------------------------------
CREATE TABLE IF NOT EXISTS user (
    id              BIGINT UNSIGNED     AUTO_INCREMENT PRIMARY KEY,
    username        VARCHAR(50)         NOT NULL UNIQUE,
    email           VARCHAR(200)        NOT NULL UNIQUE,
    password_hash   VARCHAR(255)        NOT NULL COMMENT 'Bcrypt hash',
    display_name    VARCHAR(100)        NULL,
    avatar_url      VARCHAR(500)        NULL,
    bio             TEXT                NULL,
    role            TINYINT             NOT NULL DEFAULT 1 COMMENT '1=member 2=contributor 3=curator 4=admin',
    status          TINYINT             NOT NULL DEFAULT 1 COMMENT '1=active 2=suspended',
    last_login_at   DATETIME(3)         NULL,
    created_at      DATETIME(3)         NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    updated_at      DATETIME(3)         NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
    deleted_at      DATETIME(3)         NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------
-- user_collection / 用户收藏
-- -----------------------------------------------------------
CREATE TABLE IF NOT EXISTS user_collection (
    user_id     BIGINT UNSIGNED     NOT NULL,
    artifact_id BIGINT UNSIGNED     NOT NULL,
    created_at  DATETIME(3)         NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    PRIMARY KEY (user_id, artifact_id),
    INDEX idx_artifact_id (artifact_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- -----------------------------------------------------------
-- memory / 用户记忆
-- -----------------------------------------------------------
CREATE TABLE IF NOT EXISTS memory (
    id          BIGINT UNSIGNED     AUTO_INCREMENT PRIMARY KEY,
    artifact_id BIGINT UNSIGNED     NOT NULL,
    user_id     BIGINT UNSIGNED     NOT NULL,
    content     TEXT                NOT NULL,
    year        SMALLINT            NULL,
    like_count  INT UNSIGNED        NOT NULL DEFAULT 0,
    status      TINYINT             NOT NULL DEFAULT 1 COMMENT '1=published 2=pending 3=hidden',
    created_at  DATETIME(3)         NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    updated_at  DATETIME(3)         NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
    deleted_at  DATETIME(3)         NULL,
    INDEX idx_artifact_id (artifact_id),
    INDEX idx_user_id (user_id),
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------
-- memory_like / 记忆点赞
-- -----------------------------------------------------------
CREATE TABLE IF NOT EXISTS memory_like (
    memory_id   BIGINT UNSIGNED     NOT NULL,
    user_id     BIGINT UNSIGNED     NOT NULL,
    created_at  DATETIME(3)         NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    PRIMARY KEY (memory_id, user_id),
    INDEX idx_user_id (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- -----------------------------------------------------------
-- contribution / 用户贡献
-- -----------------------------------------------------------
CREATE TABLE IF NOT EXISTS contribution (
    id              BIGINT UNSIGNED     AUTO_INCREMENT PRIMARY KEY,
    user_id         BIGINT UNSIGNED     NOT NULL,
    type            TINYINT             NOT NULL COMMENT '1=new_artifact 2=edit 3=source 4=image',
    artifact_id     BIGINT UNSIGNED     NULL,
    payload         JSON                NOT NULL,
    status          TINYINT             NOT NULL DEFAULT 1 COMMENT '1=pending 2=approved 3=rejected',
    reviewer_id     BIGINT UNSIGNED     NULL,
    reviewer_note   TEXT                NULL,
    reviewed_at     DATETIME(3)         NULL,
    created_at      DATETIME(3)         NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    updated_at      DATETIME(3)         NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
    INDEX idx_user_id (user_id),
    INDEX idx_status (status),
    INDEX idx_type (type)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------
-- archaeology_task / 考古任务
-- -----------------------------------------------------------
CREATE TABLE IF NOT EXISTS archaeology_task (
    id              BIGINT UNSIGNED     AUTO_INCREMENT PRIMARY KEY,
    title           VARCHAR(300)        NOT NULL,
    title_zh        VARCHAR(300)        NULL,
    description     TEXT                NULL,
    description_zh  TEXT                NULL,
    artifact_id     BIGINT UNSIGNED     NULL,
    type            TINYINT             NOT NULL COMMENT '1=verify_info 2=find_source 3=add_memory',
    difficulty      TINYINT             NOT NULL DEFAULT 1 COMMENT '1=easy 2=medium 3=hard',
    status          TINYINT             NOT NULL DEFAULT 1 COMMENT '1=open 2=completed 3=closed',
    created_at      DATETIME(3)         NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    INDEX idx_artifact_id (artifact_id),
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SET FOREIGN_KEY_CHECKS = 1;
