# UI Design Guidelines / 界面设计规范

**Internet Archaeology Museum / 互联网考古博物馆**

Version / 版本: `0.1`

---

## 1. Visual Identity / 视觉标识

### 1.1 Design Language / 设计语言

The visual language of the Internet Archaeology Museum is:

互联网考古博物馆的视觉语言是：

> **Modern Digital Archive × Internet Archaeology × Retro Web**
>
> **现代数字档案馆 × 互联网考古 × 复古网络**

The UI should feel like standing in a **museum of the Internet** — not a tech product, not a social media feed, not a web archive tool.

界面应该让人感觉像站在**互联网的博物馆**里——不是科技产品，不是社交媒体，不是网络存档工具。

### 1.2 What the UI should feel like / 界面应该有的感觉

- A physical museum that has been thoughtfully digitized / 一个被认真数字化的实体博物馆
- Historical, but not dusty / 有历史感，但不陈旧
- Warm reference to the past, not nostalgia overload / 对过去的温暖参考，而非过度怀旧
- Calm, readable, content-first / 平静、易读、内容优先

### 1.3 What to avoid / 需要避免的风格

| Avoid / 避免 | Reason / 原因 |
|---|---|
| Cyberpunk / 赛博朋克 | Not historically grounded, too trendy |
| Neon sci-fi / 霓虹科幻 | Distracts from the archive feeling |
| Windows XP simulation / Windows XP 模拟 | Novelty wears off quickly, hard to read |
| Excessive CRT / glitch effects / 过度 CRT 故障效果 | Fatiguing, inaccessible |
| Generic SaaS dashboard / 通用 SaaS 仪表板 | Cold, wrong tone for a museum |
| Pure dark mode only / 纯深色模式 | Hard to read long-form history |

Retro elements are valid as **accent details** — not as the entire interface.

复古元素作为**点缀细节**是合理的——而不是整个界面。

---

## 2. Color Palette / 色彩规范

### 2.1 Primary Palette / 主色调

| Token | Value | Usage |
|---|---|---|
| `--color-bg` | `#F8F6F2` | Main background — warm off-white |
| `--color-bg-alt` | `#EFECE5` | Subtle section dividers |
| `--color-surface` | `#FFFFFF` | Cards, panels |
| `--color-text-primary` | `#1A1A1A` | Body text |
| `--color-text-secondary` | `#555555` | Captions, labels |
| `--color-text-muted` | `#999999` | Timestamps, meta |
| `--color-accent` | `#2B5F8E` | Links, interactive elements |
| `--color-accent-warm` | `#8B4513` | Historical era accents |
| `--color-ghost` | `#888888` | Digital Ghosts, faded elements |
| `--color-border` | `#E0DDD5` | Subtle borders |

### 2.2 Era Colors / 时代配色

Each Internet era has a subtle color accent used on timeline elements:

每个互联网时代在时间轴元素上有一个细微的配色：

| Era | Color | Notes |
|---|---|---|
| 1990s | `#4A6741` | Early green-screen echoes |
| 2000s | `#5B7FA6` | Cool blue broadband era |
| 2010s | `#7B5EA7` | Social/mobile purple |
| 2020s | `#3D7A6E` | Contemporary teal |

---

## 3. Typography / 字体规范

### 3.1 Font Stack / 字体列表

```css
/* English body / 英文正文 */
font-family: 'Georgia', 'Times New Roman', serif;

/* English headings / 英文标题 */
font-family: 'Inter', 'Helvetica Neue', sans-serif;

/* Chinese body / 中文正文 */
font-family: 'Noto Serif SC', 'Source Han Serif SC', serif;

/* Chinese headings / 中文标题 */
font-family: 'Noto Sans SC', 'PingFang SC', sans-serif;

/* Monospace (dates, codes, technical labels) */
font-family: 'JetBrains Mono', 'Courier New', monospace;
```

### 3.2 Scale / 字号规范

| Token | Size | Usage |
|---|---|---|
| `--text-xs` | 12px | Timestamps, fine print |
| `--text-sm` | 14px | Captions, labels |
| `--text-base` | 16px | Body text |
| `--text-lg` | 18px | Lead paragraphs |
| `--text-xl` | 22px | Section headings |
| `--text-2xl` | 28px | Page headings |
| `--text-3xl` | 36px | Hero/exhibit titles |

---

## 4. Layout / 布局规范

### 4.1 Grid / 网格

The layout uses a centered max-width content column.

布局使用居中的最大宽度内容列。

```css
.content-column {
  max-width: 860px;
  margin: 0 auto;
  padding: 0 24px;
}

.wide-column {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 32px;
}
```

### 4.2 Spacing Scale / 间距规范

Use a consistent 8px base unit.

使用一致的 8px 基础单位。

| Token | Value |
|---|---|
| `--space-1` | 4px |
| `--space-2` | 8px |
| `--space-3` | 12px |
| `--space-4` | 16px |
| `--space-6` | 24px |
| `--space-8` | 32px |
| `--space-12` | 48px |
| `--space-16` | 64px |

---

## 5. Key Pages / 关键页面

### 5.1 Museum Homepage / 博物馆首页

The homepage should feel like the entrance hall of a museum.

首页应该像博物馆的入口大厅一样。

Sections / 版块：

1. Hero — tagline and era selector / 英雄区——标语和时代选择器
2. Featured artifacts / 精选文物
3. Current exhibition / 当前展览
4. Timeline preview / 时间轴预览
5. Recent memories / 最近的记忆
6. Digital Ghosts teaser / 数字幽灵预告

### 5.2 Artifact Detail Page / 文物详情页

The most important page in the museum.

博物馆中最重要的页面。

Sections / 版块：

1. Cover image with era badge / 封面图片和时代徽章
2. Name, dates, category / 名称、时间、分类
3. Description / 描述
4. Historical significance / 历史意义
5. Timeline of events / 事件时间轴
6. Gallery / 图片画廊
7. "What happened to it" / 最终命运
8. Sources / 来源
9. User memories / 用户记忆
10. Related artifacts / 相关文物

### 5.3 Timeline View / 时间轴视图

A visual timeline showing Internet history by decade.

显示互联网历史按十年划分的可视化时间轴。

Users can zoom into specific years or eras.

用户可以放大到特定年份或时代。

### 5.4 Digital Ghost Page / 数字幽灵页面

A solemn, memorial-feeling layout.

庄重、纪念馆感觉的布局。

Emphasizes: what was lost, when it closed, why people miss it.

强调：失去了什么，何时关闭，为什么人们怀念它。

---

## 6. Accessibility / 无障碍

- Minimum contrast ratio: 4.5:1 for body text, 3:1 for large text / 最低对比度：正文 4.5:1，大文本 3:1
- All interactive elements must be keyboard navigable / 所有交互元素必须支持键盘导航
- Images must have meaningful `alt` text / 图片必须有有意义的 `alt` 文本
- Focus states must be visible / 焦点状态必须可见
- Avoid relying on color alone to convey information / 避免仅依靠颜色传达信息

Full accessibility validation requires manual testing with assistive technologies.

完整的无障碍验证需要借助辅助技术进行手动测试。

---

## 7. Responsive Design / 响应式设计

| Breakpoint | Width | Target |
|---|---|---|
| Mobile | < 768px | Single column, touch-friendly |
| Tablet | 768px – 1024px | Two-column where appropriate |
| Desktop | > 1024px | Full layout |

Timeline and exhibition layouts must degrade gracefully on mobile.

时间轴和展览布局必须在移动端优雅降级。
