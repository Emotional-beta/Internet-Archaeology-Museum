# Product Requirements Document / 产品需求文档

**Internet Archaeology Museum / 互联网考古博物馆**

Version / 版本: `0.1`  
Status / 状态: Draft / 草稿

---

## 1. Product Vision / 产品愿景

### 1.1 Core Idea / 核心理念

The Internet Archaeology Museum is a digital museum dedicated to preserving and presenting Internet history and collective digital memory.

互联网考古博物馆是一个专注于保存和呈现互联网历史与集体数字记忆的数字博物馆。

The central question the product answers is not "What was this website?" but:

产品回答的核心问题不是"这个网站是什么？"而是：

> **"Why did people of that era use it, and what did it mean to them?"**
>
> **"那个时代的人为什么使用它，它对他们意味着什么？"**

### 1.2 Target Audience / 目标用户

- People who grew up with the early Internet and want to revisit digital memories / 伴随早期互联网成长、希望重温数字记忆的人
- Researchers and students interested in Internet history and digital culture / 对互联网历史和数字文化感兴趣的研究者和学生
- Curious visitors who want to understand how the Internet evolved / 好奇了解互联网演变历史的普通访客
- Contributors who want to preserve Internet history / 希望保存互联网历史的贡献者

---

## 2. Core Features / 核心功能

### 2.1 Internet Artifacts / 互联网文物

The artifact is the fundamental unit of the museum.

文物是博物馆的基本单位。

Each artifact represents a piece of Internet history: a website, platform, game, community, cultural phenomenon, or digital device.

每件文物代表互联网历史的一部分：网站、平台、游戏、社区、文化现象或数字设备。

**An artifact should answer / 一件文物应该能够回答：**

| Question | 问题 |
|---|---|
| What was it? | 它是什么？ |
| When did it exist? | 它存在于什么年代？ |
| Who used it? | 谁在使用它？ |
| Why was it important? | 它为什么重要？ |
| What did people do there? | 人们在那里做什么？ |
| What did it change? | 它改变了什么？ |
| Why did it disappear? | 它为什么消失？ |
| What do people remember? | 人们记得什么？ |

**Artifact categories / 文物分类：**

- Websites / 网站
- Forums & Communities / 论坛与社区
- Social Networks / 社交网络
- Online Games / 网络游戏
- Messaging & Communication / 即时通讯
- Digital Devices / 数字设备
- Internet Culture / 网络文化
- Software & Tools / 软件与工具
- Search & Navigation / 搜索与导航
- E-commerce / 电子商务
- Media & Entertainment / 媒体与娱乐

### 2.2 Timeline / 时间轴

Users can explore Internet history chronologically.

用户可以按时间顺序探索互联网历史。

The timeline spans major eras / 时间轴覆盖主要时代：

```text
1990–1999  The Early Web / 早期互联网
2000–2009  The Broadband Era / 宽带时代
2010–2019  The Mobile Era / 移动互联网时代
2020–      The Present Era / 当代
```

### 2.3 Exhibitions / 展览

Curated thematic exhibitions group artifacts around a shared theme.

策划的主题展览将文物围绕共同主题进行分组。

Examples / 示例：

- China's Early Internet / 中国互联网早期
- The Forum Era / 论坛时代
- Flash Games / Flash 游戏
- The Rise of Mobile / 移动互联网的崛起
- Lost Social Networks / 消失的社交网络

### 2.4 Digital Ghosts / 数字幽灵

A dedicated section for Internet products and communities that have permanently disappeared.

专门展示已永久消失的互联网产品和社区的版块。

Digital Ghosts have: a memorial page, a timeline of their existence, community memories, and final archival records.

数字幽灵拥有：纪念页面、存在时间轴、社区记忆和最终归档记录。

### 2.5 I Remember / 我记得

Users can submit personal memories associated with artifacts.

用户可以提交与文物相关的个人记忆。

Memories are tied to specific artifacts and displayed alongside historical information.

记忆与特定文物关联，与历史信息一起展示。

### 2.6 Archaeology / 考古

An interactive system where users can earn recognition for contributing historical research and artifacts.

一个交互系统，用户可以通过贡献历史研究和文物获得认可。

Users complete archaeology tasks to help expand the museum's collection.

用户完成考古任务，帮助扩展博物馆的馆藏。

### 2.7 Letters to the Future / 写给未来的信

Users can write messages about today's Internet to be displayed at a future date.

用户可以撰写关于今日互联网的信息，在未来某一天展示。

---

## 3. Non-Goals / 非目标

The following are explicitly out of scope / 以下明确不在范围内：

- Link aggregator or bookmark service / 链接聚合器或书签服务
- General web archive (that is what the Wayback Machine is for) / 通用网络存档（那是 Wayback Machine 做的事）
- Social media platform / 社交媒体平台
- Monetization, advertising, or paid tiers / 变现、广告或付费层级
- Enterprise or business features / 企业或商业功能

---

## 4. User Roles / 用户角色

| Role | Description | 描述 |
|---|---|---|
| Visitor | Browse without account | 无账号浏览 |
| Member | Registered user, can submit memories and contributions | 注册用户，可提交记忆和贡献 |
| Contributor | Trusted member with content submission rights | 可信任成员，有内容提交权限 |
| Curator | Can publish and edit artifacts | 可发布和编辑文物 |
| Admin | Full system access | 完整系统访问权限 |

---

## 5. Key User Stories / 关键用户故事

### Visitor / 访客

- As a visitor, I want to browse Internet artifacts by era, so I can explore Internet history chronologically. / 作为访客，我希望按时代浏览互联网文物，以便按时间顺序探索互联网历史。
- As a visitor, I want to search for a specific website or product, so I can find what I remember. / 作为访客，我希望搜索特定网站或产品，以便找到我记得的东西。
- As a visitor, I want to view an exhibition, so I can understand a specific period or theme. / 作为访客，我希望浏览展览，以便了解特定时期或主题。

### Member / 会员

- As a member, I want to submit a memory about an artifact, so I can contribute to the collective history. / 作为会员，我希望提交关于文物的记忆，以便为集体历史做贡献。
- As a member, I want to save artifacts to my collection, so I can revisit them. / 作为会员，我希望将文物保存到收藏中，以便重新访问。
- As a member, I want to contribute a new artifact, so I can preserve something that isn't yet in the museum. / 作为会员，我希望贡献一件新文物，以便保存博物馆中尚未有的内容。

---

## 6. MVP Scope / 最小可行产品范围

**Phase 1 — Museum Foundation / 阶段一：博物馆基础**

- [ ] Museum homepage / 博物馆首页
- [ ] Artifact detail page / 文物详情页
- [ ] Artifact listing with category and era filters / 带分类和时代筛选的文物列表
- [ ] Timeline view / 时间轴视图
- [ ] Basic search / 基础搜索
- [ ] User registration and login / 用户注册与登录

**Phase 2 — Memory and Community / 阶段二：记忆与社区**

- [ ] Memory submission / 记忆提交
- [ ] Memory display on artifact pages / 文物页面的记忆展示
- [ ] Collections / 收藏
- [ ] Comments / 评论

**Phase 3 — Exhibitions and Ghosts / 阶段三：展览与幽灵**

- [ ] Exhibition pages / 展览页面
- [ ] Digital Ghosts section / 数字幽灵版块
- [ ] Archaeology system / 考古系统

**Phase 4 — Contribution System / 阶段四：贡献系统**

- [ ] Artifact submission workflow / 文物提交流程
- [ ] Curator review interface / 策展人审核界面
- [ ] Letters to the Future / 写给未来的信
