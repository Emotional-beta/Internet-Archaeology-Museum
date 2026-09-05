# Changelog / 更新日志

All notable changes to this project will be documented in this file.

本项目的所有重要变更都将记录在此文件中。

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

格式基于 [Keep a Changelog](https://keepachangelog.com/en/1.0.0/)。

---

## [Unreleased] / 未发布

---

## [0.2.0] / 前端初始版本

### Added / 新增

- Vue 3 + TypeScript + Vite frontend scaffold / Vue 3 + TypeScript + Vite 前端骨架
- Element Plus component library integration / Element Plus 组件库集成
- Museum homepage with artifact grid, era filter, category filter, keyword search, pagination / 博物馆首页：文物卡片网格、时代筛选、分类筛选、关键词搜索、分页
- Artifact detail page with cover, timeline, gallery, sources, sidebar / 文物详情页：封面、时间轴、图片画廊、来源、侧边信息栏
- Centralized API module (`src/api/artifact.ts`) / 集中式 API 模块
- TypeScript type definitions matching backend VOs / 与后端 VO 对应的 TypeScript 类型定义
- Vite proxy configuration for local backend / 本地开发 Vite 代理配置
- Museum design tokens and global CSS (color palette, typography, spacing) / 博物馆设计变量和全局样式

---

## [0.1.0] / 后端基础版本

### Added / 新增

- Bilingual (Chinese/English) project documentation / 双语（中英文）项目文档
- `docs/` directory: PRD, ARCHITECTURE, DATABASE, API, UI, DEPLOYMENT / `docs/` 目录：六份技术文档
- `.github/` issue templates and pull request template / `.github/` Issue 模板和 PR 模板
- Spring Boot 3 backend project (Java 17, MyBatis-Plus, Spring Security) / Spring Boot 3 后端项目
- Artifact module: entity, mapper, service, controller, DTO/VO / 文物模块：实体、Mapper、Service、Controller、DTO/VO
- `database/schema.sql` and `seed.sql` / 数据库建表脚本和种子数据
- 7 unit tests for ArtifactService / ArtifactService 7 个单元测试
- `.gitignore` covering Java, Node.js, IDE files, secrets / 完整的 `.gitignore`

---

## [0.0.1] / 仓库初始化

### Added / 新增

- Initial repository / 仓库初始化
- Project concept and vision / 项目概念与愿景
- `README.md` · `PROJECT_RULES.md` · `CONTRIBUTING.md` · `CODE_OF_CONDUCT.md` · `SECURITY.md` · `LICENSE`
- `.editorconfig` · `.gitattributes`

