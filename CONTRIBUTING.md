# Contributing / 贡献指南

Thank you for your interest in the Internet Archaeology Museum.

感谢你对互联网考古博物馆的关注。

This project is built around a simple idea:

本项目围绕一个简单的理念构建：

> The Internet has a history, and that history deserves to be remembered.
>
> 互联网有历史，那段历史值得被记住。

Contributions of all kinds are welcome.

欢迎各种形式的贡献。

---

## What You Can Contribute / 你可以贡献什么

### Internet Artifacts / 互联网文物

You can contribute information about:

你可以贡献关于以下内容的信息：

- Websites / 网站
- Forums / 论坛
- Games / 游戏
- Social networks / 社交网络
- Online communities / 网络社区
- Internet products / 互联网产品
- Digital devices / 数字设备
- Internet culture / 网络文化
- Online events / 网络事件

### Personal Memories / 个人记忆

You can contribute personal experiences.

你可以贡献个人经历。

For example / 例如：

> "I remember using this website when I was in middle school."
>
> "我记得初中的时候经常上这个网站。"

Personal memories are valuable even when they are not historical sources. However, they must be clearly presented as personal memories rather than objective historical facts.

个人记忆即使不是历史来源也很有价值，但必须明确标注为个人记忆而非客观历史事实。

### Historical Sources / 历史来源

Useful sources include / 有价值的来源包括：

- Official announcements / 官方公告
- Archived websites / 存档网站
- News articles / 新闻文章
- Books / 书籍
- Academic papers / 学术论文
- Interviews / 访谈
- Screenshots / 截图
- Videos / 视频
- Technical documentation / 技术文档

---

## Code Contributions / 代码贡献

Before making a significant change, read:

在进行重大变更之前，请阅读：

```text
PROJECT_RULES.md
docs/ARCHITECTURE.md
docs/DATABASE.md
docs/API.md
```

---

## Development Workflow / 开发流程

### 1. Fork the repository / Fork 仓库

Create your own fork on GitHub.

在 GitHub 上创建你自己的 Fork。

### 2. Create a branch / 创建分支

```bash
git checkout -b feat/artifact-timeline
git checkout -b fix/search-pagination
git checkout -b docs/update-api
```

### 3. Make changes / 进行修改

Keep changes focused on one task at a time.

每次保持变更聚焦在一个任务上。

### 4. Run tests / 运行测试

Backend / 后端：

```bash
mvn test
```

Frontend / 前端：

```bash
npm run build
npm run type-check
```

### 5. Commit / 提交

Use a meaningful commit message / 使用有意义的提交信息：

```text
feat: add artifact timeline
fix: resolve search pagination issue
docs: update contributing guide
```

### 6. Open a Pull Request / 提交 PR

Explain what changed, why it changed, how it was tested, and whether database or API changes are involved.

说明改了什么、为什么改、如何测试，以及是否涉及数据库或 API 变更。

---

## Commit Convention / 提交规范

| Prefix | Use case | 用途 |
|---|---|---|
| `feat:` | New feature | 新功能 |
| `fix:` | Bug fix | 错误修复 |
| `docs:` | Documentation | 文档 |
| `refactor:` | Code restructuring | 代码重构 |
| `test:` | Tests | 测试 |
| `style:` | Formatting only | 仅格式调整 |
| `chore:` | Build / maintenance | 构建或维护 |

---

## Adding an Artifact / 添加文物

When adding an artifact, provide as much information as possible:

添加文物时，请尽量提供以下信息：

```text
Name / 名称:
Category / 分类:
Active period / 活跃时期:
Description / 描述:
Historical significance / 历史意义:
Cultural significance / 文化意义:
Technical significance / 技术意义:
What happened to it / 最终命运:
Sources / 来源:
Personal memories / 个人记忆:
```

Do not invent historical information. If a fact is uncertain, mark it as uncertain.

不得编造历史信息。如果一个事实不确定，请标注为不确定。

---

## Images and Copyright / 图片与版权

Only submit images you have permission to redistribute or that are legally usable under the applicable license.

只提交你有权重新分发的图片，或在适用许可证下可合法使用的图片。

Whenever possible, record / 尽量记录：

- Original source / 原始来源
- Creator / 创作者
- License / 许可证
- Date accessed / 访问日期

Do not upload copyrighted material simply because it can be found online.

不要仅仅因为可以在网上找到就上传受版权保护的材料。

---

## Pull Request Checklist / PR 检查清单

Before submitting / 提交前：

- [ ] The change follows `PROJECT_RULES.md` / 变更遵循 `PROJECT_RULES.md`
- [ ] Existing functionality was not unnecessarily removed / 未不必要地删除现有功能
- [ ] Tests were added or updated where appropriate / 适当添加或更新了测试
- [ ] Documentation was updated if necessary / 必要时更新了文档
- [ ] No secrets were committed / 未提交任何密钥
- [ ] Database changes are documented / 数据库变更已记录
- [ ] API changes are documented / API 变更已记录
- [ ] The project builds successfully / 项目构建成功

---

## Questions / 疑问

If you are unsure whether something belongs in the museum, ask:

如果你不确定某些内容是否属于博物馆，请问自己：

> Does this help us understand how people experienced the Internet?
>
> 这能帮助我们理解人们曾经如何体验互联网吗？

If the answer is yes, it is probably worth discussing.

如果答案是肯定的，那它很可能值得讨论。
