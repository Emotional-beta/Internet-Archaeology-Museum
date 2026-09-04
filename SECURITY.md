# Security Policy / 安全政策

## Supported Versions / 支持的版本

During early development, security fixes are applied to the latest development version only.

早期开发阶段，安全修复仅适用于最新开发版本。

| Version / 版本 | Supported / 受支持 |
|---|---|
| Latest / 最新版 | Yes / 是 |
| Older versions / 旧版本 | No / 否 |

---

## Reporting a Vulnerability / 报告漏洞

Please do not publicly disclose a serious security vulnerability before it has been investigated.

请勿在漏洞被调查之前公开披露严重的安全漏洞。

For serious issues, contact the project maintainers privately.

对于严重问题，请私下联系项目维护者。

When reporting a vulnerability, include / 报告漏洞时，请包含：

- Description / 描述
- Affected component / 受影响的组件
- Steps to reproduce / 复现步骤
- Potential impact / 潜在影响
- Suggested mitigation, if known / 已知的缓解建议（如有）

Do not include real user passwords, access tokens, API keys, or other sensitive credentials in your report.

报告中不要包含真实的用户密码、访问令牌、API 密钥或其他敏感凭证。

---

## Security Principles / 安全原则

The project must / 项目必须：

- Never store plaintext passwords / 不明文存储密码
- Validate all user input / 验证所有用户输入
- Sanitize user-generated content / 净化用户生成的内容
- Protect administrative APIs / 保护管理 API
- Use authentication and authorization / 使用认证和授权
- Avoid exposing sensitive configuration / 避免暴露敏感配置
- Keep secrets outside source control / 将密钥排除在源代码管理之外
- Apply appropriate database access controls / 应用适当的数据库访问控制

---

## Secrets / 密钥管理

Never commit the following to the repository / 不得将以下内容提交到仓库：

```text
.env
private keys / 私钥
API tokens / API 令牌
database passwords / 数据库密码
production credentials / 生产环境凭证
```

Use environment variables instead. `.env.example` may be committed as a template. `.env` must not be committed.

使用环境变量代替。`.env.example` 可以作为模板提交，`.env` 不得提交。
