# Internet Archaeology Museum / 互联网考古博物馆

> **The Internet is not without memory. Its memory is simply disappearing.**
>
> **互联网不是没有记忆，只是它的记忆正在消失。**

**Internet Archaeology Museum / 互联网考古博物馆** is a digital museum dedicated to recording, organizing, and presenting the history of the Internet.

**互联网考古博物馆**是一个专注于记录、整理和展示互联网历史的数字博物馆。

We preserve not just screenshots of websites, but:

我们保存的不仅是网站截图，而是：

> **How people once used the Internet.**
>
> **人们曾经如何使用互联网。**

A website, a game, a forum, a meme, an internet culture, a device that once changed how people lived online — even a single person's remembered moment — can all become an artifact in this museum.

一个网站、一款游戏、一个论坛、一个表情包、一种网络文化、一台曾经改变互联网生活的设备，甚至一个普通人记忆中的互联网瞬间，都可能成为这个博物馆中的一件"互联网文物"。

---

## About / 关于

The Internet changes very fast.

互联网变化得非常快。

Websites you visited every day may have closed. Forums you once knew have gone unmaintained. Social platforms that were once popular have quietly disappeared. Game servers that accompanied a generation have been shut down.

曾经每天访问的网站可能已经关闭，曾经熟悉的论坛已经无人维护，曾经流行的社交平台逐渐消失，曾经陪伴一代人的游戏服务器已经关闭。

Much of the Internet's history has not been recorded completely enough.

很多互联网内容没有留下足够完整的历史记录。

The Internet Archaeology Museum aims to be an open digital archive — a place that tries to preserve these Internet memories before they disappear entirely.

互联网考古博物馆希望成为一个开放的数字档案馆，尝试保存这些正在消失的互联网记忆。

The question we want to answer is not:

我们希望回答的问题不是：

> "What was this website?"
>
> "这个网站是什么？"

But rather:

而是：

> "Why did people of that era use it?"
>
> "那个时代的人，为什么会使用它？"

---

## Core Concepts / 核心概念

### Time Machine / 时间机器

Explore the Internet across different eras through a timeline.

通过时间轴探索不同年代的互联网。

```text
1990s  ──────────────────────────────────────────────────
2000s  ──────────────────────────────────────────────────
2010s  ──────────────────────────────────────────────────
2020s  ──────────────────────────────────────────────────
```

Users can enter Internet history by era.

用户可以按照时间进入互联网历史。

---

### Internet Artifacts / 互联网文物

Internet Artifacts are the central content of this project.

互联网文物是本项目的核心内容。

Examples / 例如：

- Websites that have disappeared / 已消失的网站
- Forums that were once popular / 曾经流行的论坛
- Online games / 网络游戏
- Social platforms / 社交平台
- Online communities / 网络社区
- Internet culture / 网络文化
- Internet slang / 网络流行语
- Digital devices / 数字设备
- Internet products / 互联网产品
- Personal Internet memories / 个人互联网记忆

---

### Digital Ghosts / 数字幽灵

Some Internet products have disappeared.

有些互联网产品已经消失。

They may have:

它们可能：

- Closed / 关闭
- Been acquired / 被收购
- Been replaced / 被替代
- Gone unmaintained / 停止维护
- Faded from public view / 从大众视野中消失

We call them:

我们称它们为：

> **Digital Ghosts / 数字幽灵**

Things from Internet history that have disappeared, but still exist in people's memories.

它们是互联网历史中已经消失，但仍然存在于人们记忆中的事物。

---

### I Remember / 我记得

Internet history doesn't only belong to companies and products.

互联网历史并不只属于公司和产品。

Everyone who has used the Internet may have witnessed a moment in history.

每一个使用过互联网的人，都可能见证过某一段历史。

Users can submit their own memories:

用户可以提交自己的记忆：

> "I remember..."
>
> "我记得……"

These personal memories can be linked to Internet artifacts, gradually forming a collective Internet memory.

这些个人记忆可以与互联网文物建立关联，逐渐形成集体互联网记忆。

---

### Exhibitions / 展览

The museum not only displays individual artifacts, but also organizes thematic exhibitions.

博物馆不仅展示单独的互联网文物，也会组织专题展览。

Examples / 例如：

- The Early Days of China's Internet / 中国互联网的早期岁月
- The Disappearing Social Networks / 消失的社交网络
- The Age of Online Games / 互联网游戏时代
- The Era of QQ and MSN / QQ 与 MSN 的时代
- The Flash Game Museum / Flash 游戏博物馆
- The Forum Era / 论坛时代
- How Smartphones Changed the Internet / 智能手机改变互联网
- The Rise and Fall of Online Communities / 网络社区的兴衰

---

## Project Status / 项目状态

Current version: **v0.1 — Foundation / 基础版本**

当前版本：**v0.1 — Foundation / 基础版本**

The project is currently under active development.

项目正在积极开发中。

Initial development focuses on / 初始开发重点：

- Project architecture / 项目架构
- Database design / 数据库设计
- Museum interface / 博物馆界面
- Artifact system / 文物系统
- Timeline / 时间轴
- Search / 搜索
- User system / 用户系统
- Memory system / 记忆系统

Advanced features will be introduced gradually.

高级功能将逐步引入。

---

## Technology Stack / 技术栈

### Frontend / 前端

| Technology | Purpose |
|---|---|
| Vue 3 | UI framework |
| TypeScript | Type-safe JavaScript |
| Vite | Build tool |
| Vue Router | Routing |
| Pinia | State management |
| Element Plus | Component library |
| ECharts | Data visualization |
| GSAP | Animation |

### Backend / 后端

| Technology | Purpose |
|---|---|
| Java 21 | Runtime |
| Spring Boot 3 | Application framework |
| Spring Security | Authentication & authorization |
| MyBatis-Plus | ORM / data access |
| Maven | Build tool |

### Infrastructure / 基础设施

| Technology | Purpose |
|---|---|
| MySQL 8 | Primary database |
| Redis | Cache |
| Docker | Containerization |
| Docker Compose | Local orchestration |
| Nginx | Reverse proxy / static files |

---

## Architecture / 架构

```text
                         Internet / 互联网
                               │
                               ▼
                          Nginx / CDN
                               │
                ┌──────────────┴──────────────┐
                │                             │
                ▼                             ▼
          Vue 3 Frontend               Static Storage
                │
                │ HTTP / JSON
                ▼
          Spring Boot API
                │
       ┌────────┼─────────┐
       │        │         │
       ▼        ▼         ▼
     MySQL    Redis    File Storage
```

The application uses a **modular monolithic** architecture.

应用程序采用**模块化单体**架构。

Microservices are intentionally not used in the initial version.

初始版本有意不使用微服务。

---

## Main Modules / 主要模块

```text
Museum / 博物馆
├── Artifacts / 文物
├── Categories / 分类
├── Tags / 标签
├── Timeline / 时间轴
├── Exhibitions / 展览
└── Sources / 来源

Memory / 记忆
├── Memories / 记忆
├── Comments / 评论
├── Likes / 点赞
└── Collections / 收藏

Archaeology / 考古
├── Tasks / 任务
├── Records / 考古记录
└── User Progress / 用户进度

Extinction / 消亡
└── Digital Ghosts / 数字幽灵

Contribution / 贡献
└── User Contributions / 用户贡献

Future / 未来
└── Letters to the Future / 写给未来的信

Administration / 管理
├── Content Management / 内容管理
├── Moderation / 内容审核
└── User Management / 用户管理
```

---

## Repository Structure / 仓库结构

```text
internet-archaeology-museum/
│
├── frontend/            # Vue 3 application / Vue 3 前端应用
├── backend/             # Spring Boot application / Spring Boot 后端应用
│
├── database/            # Database scripts / 数据库脚本
│   ├── schema.sql
│   ├── seed.sql
│   └── migration/
│
├── docs/                # Project documentation / 项目文档
│   ├── PRD.md
│   ├── ARCHITECTURE.md
│   ├── DATABASE.md
│   ├── API.md
│   ├── UI.md
│   └── DEPLOYMENT.md
│
├── docker/              # Docker configuration / Docker 配置
├── scripts/             # Utility scripts / 工具脚本
│
├── .github/
│   ├── workflows/
│   ├── ISSUE_TEMPLATE/
│   └── PULL_REQUEST_TEMPLATE.md
│
├── README.md
├── LICENSE
├── CONTRIBUTING.md
├── CODE_OF_CONDUCT.md
├── SECURITY.md
├── PROJECT_RULES.md
├── CHANGELOG.md
├── .gitignore
├── .editorconfig
└── .gitattributes
```

---

## Development / 开发

### Requirements / 环境要求

```text
Java 21+
Node.js 20+
MySQL 8+
Redis 7+
Maven 3.9+
Git
Docker
Docker Compose
```

### Backend / 后端

```bash
cd backend
mvn spring-boot:run
```

### Frontend / 前端

```bash
cd frontend
npm install
npm run dev
```

---

## Philosophy / 设计理念

This project is not intended to become another website directory.

本项目不打算成为另一个网站目录。

It is also not a conventional content management system.

也不是一个传统的内容管理系统。

The core idea is:

核心理念是：

> **Preserve the experience and culture surrounding the Internet, not merely its technical existence.**
>
> **保存围绕互联网的体验和文化，而不仅仅是它的技术存在。**

An artifact should ideally answer:

一件文物理想情况下应该能回答：

- What was it? / 它是什么？
- When did it exist? / 它存在于什么时代？
- Who used it? / 谁在使用它？
- Why was it important? / 它为什么重要？
- What did people do there? / 人们在那里做什么？
- What did it change? / 它改变了什么？
- Why did it disappear? / 它为什么消失？
- What do people remember about it? / 人们对它有什么记忆？

---

## Contributing / 贡献

Contributions are welcome.

欢迎贡献。

You can contribute:

你可以贡献：

- Internet artifacts / 互联网文物
- Historical information / 历史信息
- Personal memories / 个人记忆
- Sources / 来源
- Screenshots / 截图
- Research / 研究
- Bug fixes / 错误修复
- Features / 功能
- UI improvements / 界面改进
- Documentation / 文档

Before contributing, please read `PROJECT_RULES.md` and `CONTRIBUTING.md`.

贡献之前，请阅读 `PROJECT_RULES.md` 和 `CONTRIBUTING.md`。

---

## License / 许可证

Released under the MIT License. See `LICENSE` for details.

基于 MIT 许可证发布。详见 `LICENSE`。

---

## A Final Note / 最后

The Internet is changing faster than we can remember it.

互联网变化的速度，比我们记忆的速度还要快。

Somewhere, a website is disappearing.

某处，一个网站正在消失。

Somewhere, a community is going silent.

某处，一个社区正在沉寂。

Somewhere, someone is remembering something that nobody else has written down.

某处，有人正在回忆一段没有人记录下来的事情。

Maybe it belongs here.

也许它属于这里。

> **互联网不是没有记忆，只是它的记忆正在消失。**
> **The Internet is not without memory. Its memory is simply disappearing.**
