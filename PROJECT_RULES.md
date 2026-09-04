# Project Rules / 项目规则

> Rules for development of the Internet Archaeology Museum.
>
> 互联网考古博物馆的开发规则。

---

## 1. Project Philosophy / 项目理念

This project is an interest-driven open-source project.

本项目是一个兴趣驱动的开源项目。

The primary goal is:

核心目标是：

> Preserve and present Internet history and collective digital memory.
>
> 保存和呈现互联网历史与集体数字记忆。

Do not optimize for commercial purposes. Do not introduce:

不要为商业目的进行优化，不要引入：

- Monetization / 变现
- Advertising / 广告
- Subscription systems / 订阅系统
- Payment systems / 支付系统
- Marketing automation / 营销自动化
- Business intelligence / 商业智能
- Enterprise features / 企业功能

unless explicitly requested.

除非明确要求。

---

## 2. Technology Stack / 技术栈

The current technology stack is fixed. Do not replace it without explicit approval.

当前技术栈是固定的，未经明确批准不得替换。

Do not introduce a new framework merely because it is popular.

不要仅仅因为某个框架流行就引入它。

### Frontend / 前端

- Vue 3
- TypeScript
- Vite
- Vue Router
- Pinia
- Element Plus
- ECharts
- GSAP

### Backend / 后端

- Java 21
- Spring Boot 3
- Spring Security
- MyBatis-Plus
- Maven

### Database / 数据库

- MySQL 8

### Infrastructure / 基础设施

- Redis
- Docker
- Docker Compose
- Nginx

---

## 3. Architecture / 架构

The project uses a **modular monolithic** architecture.

项目使用**模块化单体**架构。

Do not introduce microservices in the initial version.

初始版本不引入微服务。

Avoid unnecessary infrastructure such as:

避免引入不必要的基础设施，例如：

- Kubernetes
- Kafka
- RabbitMQ
- Elasticsearch
- GraphQL
- Service discovery / 服务发现
- Distributed configuration systems / 分布式配置系统

unless there is a demonstrated requirement.

除非有明确需求。

---

## 4. Backend Rules / 后端规则

Controllers should only handle:

Controller 层只负责：

- HTTP requests / HTTP 请求
- Parameter validation / 参数校验
- Authentication information / 认证信息
- Calling services / 调用 Service
- Returning responses / 返回响应

Controllers must not contain business logic.

Controller 层不得包含业务逻辑。

Business logic belongs in services. Database access belongs in mapper/repository layers.

业务逻辑属于 Service 层，数据库访问属于 Mapper 层。

Recommended module structure / 推荐模块结构：

```text
module/
├── controller/
├── service/
├── mapper/
├── entity/
├── dto/
├── vo/
└── enums/
```

---

## 5. API Rules / API 规则

All APIs must use the prefix:

所有 API 必须使用前缀：

```
/api/v1/
```

Examples / 示例：

```
GET    /api/v1/artifacts
GET    /api/v1/artifacts/{id}
POST   /api/v1/artifacts
PUT    /api/v1/artifacts/{id}
DELETE /api/v1/artifacts/{id}
```

API responses must use a unified structure:

API 响应必须使用统一结构：

```json
{
  "code": 0,
  "message": "success",
  "data": {}
}
```

Pagination must use a consistent structure across all modules.

分页必须在所有模块中使用一致的结构。

Do not create inconsistent response formats between modules.

不要在模块之间创建不一致的响应格式。

---

## 6. Database Rules / 数据库规则

Naming conventions / 命名规范：

- Table names: `snake_case` / 表名：`snake_case`
- Column names: `snake_case` / 字段名：`snake_case`
- Primary key: `id` / 主键：`id`
- Foreign key: `<table>_id` / 外键：`<table>_id`

Use `BIGINT UNSIGNED` for primary identifiers.

主键使用 `BIGINT UNSIGNED`。

Use `DATETIME(3)` for timestamps.

时间戳使用 `DATETIME(3)`。

Do not store passwords in plaintext. Use secure password hashes.

不得明文存储密码，必须使用安全的密码哈希。

---

## 7. Database Modification Rules / 数据库变更规则

Never modify the database schema casually.

不得随意修改数据库结构。

Before changing any table, you must:

修改任何表之前，必须：

1. Explain why the change is necessary / 说明变更原因
2. Identify affected APIs / 确认受影响的 API
3. Identify affected frontend components / 确认受影响的前端组件
4. Identify migration requirements / 确认迁移需求
5. Update `docs/DATABASE.md` / 更新 `docs/DATABASE.md`
6. Add migration scripts if applicable / 添加迁移脚本（如适用）

Do not silently change database fields.

不得静默修改数据库字段。

---

## 8. Frontend Rules / 前端规则

Frontend API calls must be centralized. Do not call Axios directly inside Vue components.

前端 API 调用必须集中管理，不得在 Vue 组件内直接调用 Axios。

Required structure / 必需结构：

```text
api/
├── artifact.ts
├── exhibition.ts
├── memory.ts
├── user.ts
└── archaeology.ts
```

Components should focus on presentation and interaction.

组件只负责展示和交互。

Business logic belongs in:

业务逻辑应放在：

- `composables/`
- `stores/`
- `services/`
- `utils/`

---

## 9. UI Rules / 界面规则

The visual language of the project is:

项目的视觉语言是：

> **Modern Digital Archive × Internet Archaeology × Retro Web**
>
> **现代数字档案馆 × 互联网考古 × 复古网络**

The UI should feel like a digital museum.

界面应该有数字博物馆的感觉。

Avoid making the entire interface feel like:

避免让整个界面变成：

- Cyberpunk / 赛博朋克
- Neon sci-fi / 霓虹科幻
- Windows XP simulation / Windows XP 模拟
- Excessive CRT effects / 过度 CRT 效果
- Excessive glitch effects / 过度故障艺术效果
- Generic SaaS dashboard / 通用 SaaS 仪表板
- Purple AI interface / 紫色 AI 界面

Retro elements are historical references, not the entire visual identity.

复古元素是历史参考，而不是整体视觉标识。

---

## 10. Artifact Rules / 文物规则

The artifact is the central content entity of the museum.

文物是博物馆的核心内容实体。

An artifact must have historical context.

文物必须有历史背景。

Whenever possible, an artifact should answer:

文物应尽可能回答：

```text
What?         它是什么？
When?         它存在于什么年代？
Who?          谁在使用它？
Why?          为什么重要？
How?          人们如何使用它？
What changed? 它改变了什么？
Why gone?     为什么消失？
Remembered?   人们记住了什么？
```

Do not create artifacts that are merely random links.

不要创建仅仅是随机链接的文物。

---

## 11. Content Rules / 内容规则

Historical claims should be traceable to sources whenever practical.

历史陈述应尽可能有来源可溯。

Sources may include / 来源可以包括：

- Official websites / 官方网站
- Archived websites / 存档网站
- News reports / 新闻报道
- Books / 书籍
- Academic publications / 学术出版物
- Interviews / 访谈
- Reliable historical documentation / 可靠的历史文献
- User memories / 用户记忆

Personal memories must be clearly distinguished from verified historical facts.

个人记忆必须与经过验证的历史事实明确区分。

---

## 12. AI Development Rules / AI 开发规则

AI coding agents working on this project must:

在本项目工作的 AI 编程助手必须：

1. Read relevant existing code before modifying it / 修改前阅读相关现有代码
2. Understand the current architecture / 了解当前架构
3. Avoid unnecessary refactoring / 避免不必要的重构
4. Avoid deleting existing functionality / 避免删除现有功能
5. Avoid changing unrelated files / 避免修改无关文件
6. Explain significant architectural changes / 解释重大架构变更
7. Keep changes focused / 保持变更聚焦
8. Run relevant tests after modification / 修改后运行相关测试
9. Report unresolved problems honestly / 诚实报告未解决的问题
10. Never invent APIs, database fields, or functions that don't exist / 不要凭空捏造不存在的 API、字段或函数

Do not rewrite the entire project to solve a local problem.

不要为了解决局部问题而重写整个项目。

---

## 13. Testing / 测试

Important business logic must have tests.

重要的业务逻辑必须有测试。

At minimum, test / 最低测试范围：

- Authentication / 认证
- Artifact creation / 文物创建
- Artifact retrieval / 文物查询
- Artifact search / 文物搜索
- Collection / 收藏
- Memory creation / 记忆创建
- Contribution workflow / 贡献流程
- Permission checks / 权限校验

Tests must be added alongside important features.

重要功能必须同步添加测试。

---

## 14. Security / 安全

Never commit / 不得提交：

- Passwords / 密码
- API keys / API 密钥
- Access tokens / 访问令牌
- Private certificates / 私钥证书
- Production credentials / 生产环境凭证
- `.env` files containing secrets / 含有密钥的 `.env` 文件

Use environment variables. `.env.example` may be committed. `.env` must not.

使用环境变量。`.env.example` 可以提交，`.env` 不得提交。

---

## 15. Git Rules / Git 规则

Use meaningful commit messages / 使用有意义的提交信息：

```text
feat:     new feature / 新功能
fix:      bug fix / 错误修复
docs:     documentation / 文档
refactor: code refactoring / 代码重构
test:     tests / 测试
style:    formatting / 格式
chore:    maintenance / 维护
```

Examples / 示例：

```text
feat: add artifact timeline
fix: resolve artifact search pagination
docs: update database documentation
refactor: simplify artifact service
test: add artifact service tests
```

Avoid vague commits like `update`, `fix`, `aaa`, `final`, `final2`.

避免模糊提交，如 `update`、`fix`、`aaa`、`final`、`final2`。

---

## 16. Pull Request Rules / PR 规则

A pull request must explain / PR 必须说明：

- What changed / 改了什么
- Why it changed / 为什么改
- How it was implemented / 如何实现
- How it was tested / 如何测试
- Whether database changes are involved / 是否涉及数据库变更
- Whether API changes are involved / 是否涉及 API 变更
- Whether UI changes are involved / 是否涉及界面变更

Large unrelated changes must be split into multiple pull requests.

大型无关变更必须拆分为多个 PR。

---

## 17. Feature Development Order / 功能开发顺序

Before implementing a major feature, follow this order:

在实现重要功能前，遵循以下顺序：

```text
Requirement / 需求
      ↓
Design / 设计
      ↓
Database / 数据库
      ↓
API / 接口
      ↓
Backend / 后端
      ↓
Frontend / 前端
      ↓
Testing / 测试
      ↓
Documentation / 文档
```

Do not start by immediately writing hundreds of lines of code.

不要一开始就直接写几百行代码。

---

## 18. Scope Control / 范围控制

The project should prioritize / 项目应优先考虑：

1. Museum experience / 博物馆体验
2. Internet artifacts / 互联网文物
3. Timeline / 时间轴
4. Historical context / 历史背景
5. Collective memories / 集体记忆
6. Exhibitions / 展览
7. Archaeology experience / 考古体验

Reject or postpone features that significantly increase complexity without improving the museum experience.

拒绝或推迟那些大幅增加复杂度但不能改善博物馆体验的功能。

---

## 19. Versioning / 版本控制

Current development version: `0.x`

当前开发版本：`0.x`

The project is experimental until the core museum experience is stable.

核心博物馆体验稳定之前，项目处于实验阶段。

Breaking changes are acceptable during early development but must be documented.

早期开发阶段可以接受破坏性变更，但必须记录在文档中。

---

## 20. Final Principle / 最终原则

When deciding between two implementations, prefer:

在两种实现方案之间做选择时，优先选择：

> The simpler implementation that preserves the intended experience.
>
> 能够保留预期体验的更简单实现方案。

The goal is not to build the largest system.

目标不是构建最大的系统。

The goal is to build a system worth remembering.

目标是构建一个值得被记住的系统。
