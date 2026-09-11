-- Internet Archaeology Museum / 互联网考古博物馆
-- Seed Data / 种子数据
-- Version: 0.1
--
-- This file contains initial data for development and demonstration.
-- 此文件包含用于开发和演示的初始数据。

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- -----------------------------------------------------------
-- Categories / 分类
-- -----------------------------------------------------------
INSERT INTO artifact_category (id, name, name_zh, slug, icon, sort_order) VALUES
(1,  'Websites',               '网站',       'websites',       'icon-globe',     1),
(2,  'Forums & Communities',   '论坛与社区',  'forums',         'icon-forum',     2),
(3,  'Social Networks',        '社交网络',    'social',         'icon-social',    3),
(4,  'Online Games',           '网络游戏',    'games',          'icon-game',      4),
(5,  'Messaging & Chat',       '即时通讯',    'messaging',      'icon-chat',      5),
(6,  'Digital Devices',        '数字设备',    'devices',        'icon-device',    6),
(7,  'Internet Culture',       '网络文化',    'culture',        'icon-culture',   7),
(8,  'Software & Tools',       '软件与工具',  'software',       'icon-tool',      8),
(9,  'Search & Navigation',    '搜索与导航',  'search',         'icon-search',    9),
(10, 'Media & Entertainment',  '媒体与娱乐',  'media',          'icon-media',    10),
(11, 'E-Commerce',             '电子商务',    'ecommerce',      'icon-cart',     11),
(12, 'Blogs & Publishing',     '博客与发布',  'blogs',          'icon-blog',     12);

-- -----------------------------------------------------------
-- Tags / 标签
-- -----------------------------------------------------------
INSERT INTO artifact_tag (id, name, name_zh, slug) VALUES
(1,  'china',       '中国',     'china'),
(2,  'global',      '全球',     'global'),
(3,  'free',        '免费',     'free'),
(4,  'flash',       'Flash',    'flash'),
(5,  'mobile',      '移动端',   'mobile'),
(6,  'web20',       'Web 2.0',  'web20'),
(7,  'portal',      '门户',     'portal'),
(8,  'p2p',         'P2P',      'p2p'),
(9,  'mmo',         'MMO',      'mmo'),
(10, 'blog',        '博客',     'blog'),
(11, 'community',   '社区',     'community'),
(12, 'messaging',   '即时通讯', 'messaging');

-- -----------------------------------------------------------
-- Sample Artifacts / 示例文物
-- (Development examples only — not final museum content)
-- （仅用于开发示例，非最终博物馆内容）
-- -----------------------------------------------------------

-- 人人网 (Renren) — China's Facebook-era social network
INSERT INTO artifact (id, slug, name, name_zh, category_id, status, founded_year, closed_year, country, description, description_zh, significance, significance_zh)
VALUES (
    1,
    'renren',
    'Renren',
    '人人网',
    3,
    2, -- ghost
    2005,
    2022,
    'CN',
    'Renren (formerly Xiaonei) was a Chinese social networking website that became known as "China''s Facebook" during its peak years between 2008 and 2012. It was particularly popular among Chinese university students.',
    '人人网（前身为校内网）是一个中国社交网络网站，在2008年至2012年的鼎盛时期被称为"中国的Facebook"。它在中国大学生群体中尤其受欢迎。',
    'Renren was the first large-scale social network in China to enable real-identity connections between students. At its peak it had over 100 million registered users.',
    '人人网是中国第一个让学生之间进行实名社交连接的大规模社交网络。在鼎盛时期，它拥有超过1亿注册用户。'
);

-- Flash游戏平台示例 — Generic Flash game portal
INSERT INTO artifact (id, slug, name, name_zh, category_id, status, founded_year, closed_year, country, description, description_zh, significance, significance_zh)
VALUES (
    2,
    'flash-game-era',
    'The Flash Game Era',
    'Flash 游戏时代',
    4,
    2, -- ghost
    1996,
    2020,
    NULL,
    'Adobe Flash enabled a generation of browser-based games accessible to anyone with a web browser. Flash games defined online entertainment for millions of people from the late 1990s through the 2010s.',
    'Adobe Flash 使一代基于浏览器的游戏成为可能，任何拥有网络浏览器的人都可以访问。从1990年代末到2010年代，Flash 游戏定义了数百万人的网络娱乐方式。',
    'Flash democratized game creation and distribution. Anyone could make a game and share it without publishing deals or app stores. Flash''s end-of-life in 2020 marked the permanent closure of an era.',
    'Flash 使游戏创作和发行民主化。任何人都可以制作游戏并分享，无需发行协议或应用商店。Flash 于2020年停止支持，标志着一个时代的永久终结。'
);

-- -----------------------------------------------------------
-- Extended Artifacts / 扩充文物数据
-- -----------------------------------------------------------

-- 3. AltaVista — 1990s search pioneer
INSERT INTO artifact (id, slug, name, name_zh, category_id, status, founded_year, closed_year, country,
    description, description_zh, significance, significance_zh, what_happened, what_happened_zh, website_url)
VALUES (
    3, 'altavista', 'AltaVista', 'AltaVista', 9, 2, 1995, 2013, 'US',
    'AltaVista was one of the first full-text search engines on the Web, launched by Digital Equipment Corporation in 1995. Before Google, AltaVista was the search engine millions of people relied on daily. Its interface was simple, its index enormous for its time, and the experience of typing a query and seeing the web open up felt genuinely new.',
    'AltaVista 是最早的全文网络搜索引擎之一，1995年由数字设备公司推出。在 Google 出现之前，AltaVista 是数百万人每天依赖的搜索引擎。输入一个词，整个互联网就仿佛在眼前展开——那是一种真正的新奇体验。',
    'AltaVista demonstrated that the entire Web could be indexed and made searchable in real time. It laid the conceptual foundation for modern search.',
    'AltaVista 证明了整个互联网可以被实时索引和搜索。它为现代搜索奠定了概念基础。',
    'Acquired by Yahoo in 2003, AltaVista was gradually eclipsed by Google''s superior relevance ranking. Yahoo shut it down in July 2013.',
    '2003年被雅虎收购后，AltaVista 被 Google 更优越的相关性排名逐渐取代，雅虎于2013年7月正式关闭了它。',
    NULL
);

-- 4. GeoCities — the original user-generated web
INSERT INTO artifact (id, slug, name, name_zh, category_id, status, founded_year, closed_year, country,
    description, description_zh, significance, significance_zh, what_happened, what_happened_zh, website_url)
VALUES (
    4, 'geocities', 'GeoCities', 'GeoCities', 1, 2, 1994, 2009, 'US',
    'GeoCities was a web hosting service where anyone could build their own homepage — complete with under-construction GIFs, MIDI music that played on load, and guestbooks. Before social media, this was how ordinary people staked out a piece of the internet and said: this is who I am.',
    'GeoCities 是一项网页托管服务，任何人都可以在上面建立自己的主页——配上"建设中"的动图、页面加载时自动播放的 MIDI 音乐，以及留言本。在社交媒体出现之前，普通人就是这样在互联网上占据一块地方，告诉世界：这就是我。',
    'GeoCities was the first mass-participation web publishing platform. At its peak it was the third most visited site on the web. It gave millions of people their first experience of putting themselves online.',
    'GeoCities 是第一个大规模参与的网络发布平台。在鼎盛时期，它是全球访问量第三大的网站，让数百万人第一次体验到把自己放到网上是什么感觉。',
    'Yahoo acquired GeoCities in 1999 for $3.57 billion. In 2009, Yahoo shut down the US service entirely, deleting hundreds of millions of personal pages. The Japanese version survived until 2019.',
    '雅虎于1999年以35.7亿美元收购 GeoCities。2009年，雅虎彻底关闭了美国服务，删除了数亿个个人页面。日本版本一直存活到2019年。',
    NULL
);

-- 5. ICQ — the original internet messenger
INSERT INTO artifact (id, slug, name, name_zh, category_id, status, founded_year, closed_year, country,
    description, description_zh, significance, significance_zh, what_happened, what_happened_zh, website_url)
VALUES (
    5, 'icq', 'ICQ', 'ICQ', 5, 2, 1996, 2024, 'IL',
    'ICQ — "I Seek You" — was the first widely adopted instant messaging application for ordinary consumers. The flower icon, the distinctive "uh-oh" notification sound, and the random numeric UINs became cultural touchstones of late 1990s internet culture. For a generation, ICQ was what staying connected online meant.',
    'ICQ——"I Seek You"——是第一个被普通消费者广泛采用的即时通讯软件。那朵花的图标、标志性的"哦哦"提示音，以及随机的数字 UIN 账号，成为1990年代末互联网文化的标志。对于一代人来说，ICQ 就是"在线保持联系"的意义本身。',
    'ICQ invented the paradigm of the buddy list, the away message, and real-time peer-to-peer messaging that every subsequent chat application has followed.',
    'ICQ 发明了好友列表、离开状态，以及实时点对点消息这套范式，此后每一款聊天应用都沿用了这一框架。',
    'Acquired by AOL in 1998, then sold to a Russian firm in 2010. ICQ lost users steadily to WhatsApp and Telegram. The service was officially shut down in June 2024.',
    '1998年被 AOL 收购，2010年转售给一家俄罗斯公司。ICQ 的用户持续流失给 WhatsApp 和 Telegram，并于2024年6月正式关闭。',
    NULL
);

-- 6. Napster — peer-to-peer music sharing
INSERT INTO artifact (id, slug, name, name_zh, category_id, status, founded_year, closed_year, country,
    description, description_zh, significance, significance_zh, what_happened, what_happened_zh, website_url)
VALUES (
    6, 'napster', 'Napster', 'Napster', 10, 2, 1999, 2001, 'US',
    'Napster was a peer-to-peer file sharing service that let users share MP3 files directly with each other. In its brief peak in 2000 and 2001, it had over 80 million registered users. For the first time, a teenager anywhere in the world could access what felt like every song ever recorded — for free.',
    'Napster 是一项点对点文件共享服务，让用户可以直接互相共享 MP3 文件。在2000至2001年的短暂巅峰期，它拥有超过8000万注册用户。第一次，世界上任何地方的青少年都能获取感觉像是"所有录制过的歌曲"——而且免费。',
    'Napster forced the music industry to confront the digital future. Its shutdown and the lawsuits that followed reshaped copyright law, and ultimately led to the creation of iTunes and later streaming services.',
    'Napster 迫使音乐产业直面数字化未来。它的关闭和随之而来的诉讼重塑了版权法，并最终导致了 iTunes 乃至后来流媒体服务的诞生。',
    'The RIAA sued Napster in 2000. A federal court ordered it to shut down in 2001. The brand was later sold multiple times and became a streaming service with no connection to the original.',
    '美国唱片工业协会于2000年起诉 Napster，联邦法院于2001年下令其关闭。该品牌后来被多次转售，成为一个与原版毫无关联的流媒体服务。',
    NULL
);

-- 7. Amazon (1990s context — early e-commerce)
INSERT INTO artifact (id, slug, name, name_zh, category_id, status, founded_year, closed_year, country,
    description, description_zh, significance, significance_zh, what_happened, what_happened_zh, website_url)
VALUES (
    7, 'amazon-early', 'Amazon (The Everything Store Begins)', '亚马逊（万货商店的起点）', 11, 1, 1994, NULL, 'US',
    'When Amazon launched in 1994 as an online bookstore, buying something through a website and having it arrive at your door still felt like a minor miracle. Jeff Bezos chose books because there were too many titles for any physical store to stock. The site''s early interface was functional and plain — and it worked.',
    '1994年亚马逊以在线书店起家时，通过网站购物并送货上门仍然像是一件不可思议的事。贝佐斯选择图书，因为书目品种太多，任何实体店都无法全部备货。网站早期界面简洁实用——但它就是能用。',
    'Amazon proved that e-commerce was viable at scale. Its 1-Click ordering patent, customer review system, and obsessive focus on logistics became the template for modern online retail.',
    '亚马逊证明了电商在规模上的可行性。它的一键下单专利、用户评价系统，以及对物流的极致执着，成为现代网络零售的模板。',
    'Amazon expanded from books to CDs, DVDs, electronics, and eventually everything. It became the world''s largest online retailer and cloud computing provider — still very much active today.',
    '亚马逊从图书扩展到 CD、DVD、电子产品，最终扩展到一切商品。它成为全球最大的在线零售商和云计算提供商，至今仍非常活跃。',
    'https://www.amazon.com'
);

-- 8. MSN Messenger
INSERT INTO artifact (id, slug, name, name_zh, category_id, status, founded_year, closed_year, country,
    description, description_zh, significance, significance_zh, what_happened, what_happened_zh, website_url)
VALUES (
    8, 'msn-messenger', 'MSN Messenger', 'MSN Messenger', 5, 2, 1999, 2013, 'US',
    'MSN Messenger was the chat application that defined adolescence for millions of people in the 2000s. Every night, teenagers would log on after school, update their display names with song lyrics, set their status to "busy" while actually doing anything but, and conduct entire relationships through a blinking chat window.',
    'MSN Messenger 是那个让数百万人的青少年时代有了定义的聊天软件。2000年代，每天放学后，青少年们纷纷上线，把歌词写进显示名，把状态设成"忙碌"但其实什么都在干，在一个闪烁的聊天窗口里经历整段感情。',
    'MSN Messenger normalized always-on personal communication for a generation that had grown up with landlines. The nudge feature, display picture, and personal message became a new language of self-expression.',
    'MSN Messenger 让"永远在线的个人通讯"成为了一代从固定电话成长起来的人的日常。抖动提醒、头像、个性签名，成为一种新的自我表达语言。',
    'Microsoft replaced MSN Messenger with Skype in 2013, retiring the service that had once had hundreds of millions of users. The transition was widely mourned online.',
    '微软于2013年用 Skype 取代了 MSN Messenger，退役了这款曾拥有数亿用户的服务。这次告别在网上引发了广泛的惋惜之情。',
    NULL
);

-- 9. MySpace
INSERT INTO artifact (id, slug, name, name_zh, category_id, status, founded_year, closed_year, country,
    description, description_zh, significance, significance_zh, what_happened, what_happened_zh, website_url)
VALUES (
    9, 'myspace', 'MySpace', 'MySpace', 3, 2, 2003, NULL, 'US',
    'MySpace was the dominant social network from roughly 2005 to 2008. Every profile was customizable with HTML and CSS — chaotic, personal, and completely yours. It was where bands connected with fans before Spotify, where teenagers discovered subcultures, and where the concept of the "Top 8 Friends" caused more social anxiety than anything before it.',
    'MySpace 在2005年至2008年间是占主导地位的社交网络。每个主页都可以用 HTML 和 CSS 自定义——混乱、个性，完全是你的。在 Spotify 之前，这里是乐队与歌迷相连的地方，是青少年发现亚文化的地方，"最佳好友8人名单"造成的社交焦虑也是前所未有的。',
    'MySpace was the proof of concept for social networking at scale. It showed that people would spend hours managing their online identity and that music discovery could be social.',
    'MySpace 是社交网络大规模运作的概念验证。它证明了人们愿意花数小时管理自己的网络身份，也证明了音乐发现可以是社交化的。',
    'News Corp acquired MySpace in 2005 for $580 million. Facebook overtook it in users by 2008. Sold for just $35 million in 2011, MySpace relaunched as a music platform but never regained relevance.',
    '新闻集团于2005年以5.8亿美元收购 MySpace。Facebook 在2008年用户数量上超越它。2011年以仅3500万美元出售后，MySpace 以音乐平台的身份重新亮相，但再未恢复往日影响力。',
    'https://myspace.com'
);

-- 10. 天涯社区 (Tianya)
INSERT INTO artifact (id, slug, name, name_zh, category_id, status, founded_year, closed_year, country,
    description, description_zh, significance, significance_zh, what_happened, what_happened_zh, website_url)
VALUES (
    10, 'tianya', 'Tianya Club', '天涯社区', 2, 2, 1999, NULL, 'CN',
    'Tianya Club was one of China''s most influential online forums, a vast digital agora where millions debated politics, shared gossip, told stories, and lived out an entire public life in text. Threads on Tianya could run to thousands of replies and spark national conversations. The phrase "Tianya netizens" once meant the vanguard of Chinese internet opinion.',
    '天涯社区是中国最具影响力的网络论坛之一，一个庞大的数字广场，数百万人在这里辩论时政、分享八卦、讲述故事，用文字过着一种完整的公共生活。天涯上的帖子可以延伸数千楼，引发全国性讨论。"天涯网友"这个词，曾经代表中国互联网舆论的先锋。',
    'Tianya was the primary space for long-form user-generated discourse in China for over a decade. It hosted the first wave of viral stories, whistleblowing, and grassroots journalism before WeChat and Weibo.',
    '天涯是十余年间中国长篇用户生成话语的主要空间，在微信和微博兴起之前，它承载了第一批病毒式传播的故事、举报事件和草根新闻。',
    'Mobile social media gradually pulled attention away from PC-based forums. Tianya''s servers went offline in 2023 due to funding issues, taking millions of posts with it — though partial backups were later restored.',
    '移动社交媒体逐渐将注意力从基于 PC 的论坛上抢走。2023年，天涯因资金问题服务器下线，数百万帖子随之消失——尽管后来部分备份得到恢复。',
    NULL
);

-- 11. 猫扑 (Mop)
INSERT INTO artifact (id, slug, name, name_zh, category_id, status, founded_year, closed_year, country,
    description, description_zh, significance, significance_zh, what_happened, what_happened_zh, website_url)
VALUES (
    11, 'mop', 'Mop', '猫扑', 2, 2, 1997, NULL, 'CN',
    'Mop (猫扑, literally "cat step") was one of the earliest and most influential Chinese online communities. It was where internet culture in China was invented — the original source of memes, slang, and collective humor that defined Chinese internet identity in the 2000s. Terms like "囧" (jiong) and countless early internet phrases originated or spread through Mop.',
    '猫扑是中国最早、最具影响力的网络社区之一，也是中国互联网文化的诞生地——2000年代定义中国网络身份的表情包、网络用语和集体幽默，都发源于此。"囧"等无数早期网络用语，都是从猫扑起源或传播的。',
    'Mop created the template for Chinese internet humor and community culture. Its "MOP体" posting style and the anonymous, anarchic energy of its users shaped a generation of Chinese netizens.',
    '猫扑创造了中国互联网幽默和社区文化的模板。它的"猫扑体"发帖风格以及用户匿名、无拘无束的精神，塑造了一代中国网民。',
    'Mop was acquired by ChinaNet in 2007. After a series of ownership changes, it survived in diminished form but never recovered the cultural centrality of its peak years.',
    '猫扑于2007年被中国网络收购，经过一系列所有权更迭后以削减的形式存活下来，但再未恢复鼎盛时期的文化核心地位。',
    NULL
);

-- 12. Winamp
INSERT INTO artifact (id, slug, name, name_zh, category_id, status, founded_year, closed_year, country,
    description, description_zh, significance, significance_zh, what_happened, what_happened_zh, website_url)
VALUES (
    12, 'winamp', 'Winamp', 'Winamp', 8, 2, 1997, 2013, 'US',
    'Winamp whipped the llama''s ass — and it was the best music player the desktop ever had. In the late 1990s and 2000s, customizing your Winamp skin was a form of self-expression. The visualizer was hypnotic. The playlist management was elegant. For anyone who grew up in this era, the five-note startup jingle is permanently imprinted.',
    'Winamp 是桌面时代最好的音乐播放器。在1990年代末和2000年代，自定义 Winamp 皮肤是一种自我表达方式。可视化效果令人着迷，播放列表管理优雅流畅。对于在这个时代成长的人来说，那段五音节启动提示音已永久刻入记忆。',
    'Winamp pioneered the MP3 player interface that all subsequent media players would follow. It also helped establish the concept of user-created skins and plugins, an early form of open software culture.',
    'Winamp 开创了所有后续媒体播放器都会沿用的 MP3 播放器界面，也确立了用户创建皮肤和插件的概念——这是早期开放软件文化的一种形式。',
    'AOL acquired Nullsoft (Winamp''s maker) in 1999 and shut down development. The final Winamp 5.6 was released in 2013. Radionomy later acquired the brand and relaunched it, but the spirit was gone.',
    'AOL于1999年收购了 Winamp 的开发商 Nullsoft 并停止开发，最终版 Winamp 5.6 于2013年发布。Radionomy 后来收购了该品牌并重新发布，但那种精神已经消失。',
    NULL
);

-- 13. Internet Explorer
INSERT INTO artifact (id, slug, name, name_zh, category_id, status, founded_year, closed_year, country,
    description, description_zh, significance, significance_zh, what_happened, what_happened_zh, website_url)
VALUES (
    13, 'internet-explorer', 'Internet Explorer', 'Internet Explorer', 8, 2, 1995, 2022, 'US',
    'Internet Explorer was for many years simply what "the internet" meant. You clicked the blue E, and you were online. During its monopoly years in the early 2000s, IE had over 95% market share. Every web developer had a complicated, often bitter relationship with it — especially with IE6, whose rendering quirks required entire libraries of workarounds.',
    '对许多人来说，Internet Explorer 就是"互联网"本身的含义。点击那个蓝色的 E，你就上网了。在2000年代初的垄断期间，IE 的市场份额超过95%。每一位网络开发者都与它有着复杂、往往充满苦涩的关系——尤其是 IE6，其渲染问题需要整套变通库来应对。',
    'IE''s dominance shaped — and constrained — the early web. Its eventual defeat by Firefox and Chrome forced Microsoft to rethink its browser strategy entirely.',
    'IE 的主导地位塑造了——也限制了——早期网络的发展。它最终被 Firefox 和 Chrome 击败，迫使微软彻底重新思考其浏览器策略。',
    'Microsoft retired IE 11 in June 2022, replacing it with Edge. The browser that once defined the web was quietly put down after 27 years.',
    '微软于2022年6月退役了 IE 11，以 Edge 取而代之。这款曾经定义了网络的浏览器，在27年后悄然落幕。',
    NULL
);

-- 14. Blogger
INSERT INTO artifact (id, slug, name, name_zh, category_id, status, founded_year, closed_year, country,
    description, description_zh, significance, significance_zh, what_happened, what_happened_zh, website_url)
VALUES (
    14, 'blogger', 'Blogger', 'Blogger', 12, 1, 1999, NULL, 'US',
    'Blogger, launched in 1999 by Pyra Labs, was the tool that democratized online writing. Before Blogger, publishing on the web required knowing HTML and FTP. Blogger let anyone type a post and hit Publish. The result was the blogging explosion of the early 2000s — millions of personal diaries, opinion columns, and niche communities that had no precedent.',
    'Blogger 由 Pyra Labs 于1999年推出，是让网络写作走向大众的工具。在 Blogger 之前，在网上发布内容需要了解 HTML 和 FTP。Blogger 让任何人都可以打一篇帖子，点击"发布"。结果是2000年代初的博客爆炸——数百万个个人日记、评论专栏和小众社区，前所未有。',
    'Blogger proved that user-generated text content at scale was viable and desirable. It directly inspired the blog culture that preceded social media and shaped what we now call "content creation".',
    'Blogger 证明了用户生成文字内容的大规模可行性和可取性，直接催生了先于社交媒体的博客文化，并塑造了我们今天所说的"内容创作"。',
    'Google acquired Blogger in 2003 for an undisclosed sum. It has remained operational with minimal updates, a relic that Google has chosen not to kill but also not to evolve.',
    '谷歌于2003年以未披露的金额收购了 Blogger，此后以极少的更新维持运营——一个谷歌选择不关闭但也不再发展的遗迹。',
    'https://www.blogger.com'
);

-- 15. 淘宝 (Taobao)
INSERT INTO artifact (id, slug, name, name_zh, category_id, status, founded_year, closed_year, country,
    description, description_zh, significance, significance_zh, what_happened, what_happened_zh, website_url)
VALUES (
    15, 'taobao', 'Taobao', '淘宝', 11, 1, 2003, NULL, 'CN',
    'Taobao launched in 2003 as Alibaba''s answer to eBay''s entry into China. What made Taobao different wasn''t just its free listings — it was the culture it created. Sellers were individuals, not corporations. The live chat with the shopkeeper, the personalized packaging, the tiny "thank you" notes inside parcels — Taobao made shopping feel personal in ways no physical market ever had.',
    '淘宝于2003年推出，是阿里巴巴对 eBay 进入中国市场的回应。让淘宝与众不同的不只是免费刊登——而是它创造的文化。卖家是个人，不是企业。与店主的实时聊天、个性化的包装、包裹里小小的"谢谢"卡片——淘宝让购物拥有了任何实体市场都未曾有过的人情味。',
    'Taobao beat eBay out of China by understanding local social dynamics better. It became the engine of China''s e-commerce revolution and spawned an entire generation of online entrepreneurs.',
    '淘宝通过更好地理解本土社会动态将 eBay 赶出中国，成为中国电商革命的引擎，并催生了整整一代网络创业者。',
    'Taobao remains one of the world''s largest e-commerce platforms, though facing increasing competition from Pinduoduo, JD.com, and short-video commerce on Douyin.',
    '淘宝仍是全球最大的电商平台之一，尽管正面临拼多多、京东以及抖音短视频电商越来越大的竞争压力。',
    'https://www.taobao.com'
);

-- 16. Club Penguin
INSERT INTO artifact (id, slug, name, name_zh, category_id, status, founded_year, closed_year, country,
    description, description_zh, significance, significance_zh, what_happened, what_happened_zh, website_url)
VALUES (
    16, 'club-penguin', 'Club Penguin', 'Club Penguin', 4, 2, 2005, 2017, 'CA',
    'Club Penguin was a browser-based virtual world where children controlled penguin avatars on a snowy island, played minigames, decorated igloos, and socialized in a moderated environment. For an entire generation of children in the mid-2000s, it was their first experience of online community — their first username, their first virtual friend.',
    'Club Penguin 是一个基于浏览器的虚拟世界，孩子们在一座雪岛上操控企鹅角色，玩迷你游戏、装饰冰屋，在有监管的环境中社交。对于2000年代中期的整整一代孩子来说，这是他们第一次体验网络社区——第一个用户名，第一个虚拟朋友。',
    'Club Penguin showed that children could be a viable audience for online social spaces with the right safety design. It influenced every subsequent kids'' platform.',
    'Club Penguin 证明了只要有合适的安全设计，儿童可以成为在线社交空间的可行用户群，并影响了此后每一个儿童平台。',
    'Disney acquired Club Penguin in 2007 for $350 million. It was shut down in March 2017. The shutdown caused a wave of nostalgic grief online, with children and now-teenagers mourning the end.',
    '迪士尼于2007年以3.5亿美元收购 Club Penguin，并于2017年3月将其关闭。关闭引发了网络上的怀旧浪潮，孩子们和已长大的青少年纷纷哀悼这一结局。',
    NULL
);

-- 17. QQ宠物 (QQ Pet)
INSERT INTO artifact (id, slug, name, name_zh, category_id, status, founded_year, closed_year, country,
    description, description_zh, significance, significance_zh, what_happened, what_happened_zh, website_url)
VALUES (
    17, 'qq-pet', 'QQ Pet', 'QQ宠物', 4, 2, 2003, 2013, 'CN',
    'QQ Pet was a virtual pet feature integrated into Tencent''s QQ platform. Your pet lived inside your QQ client, grew hungry and lonely if you didn''t tend to it, and became a constant companion of your online life. To feed your pet, you bought QQ coins — a pivotal moment in virtual economy history in China.',
    'QQ宠物是内嵌于腾讯 QQ 平台的虚拟宠物功能。你的宠物住在 QQ 客户端里，如果你不照料它就会饥饿和孤独，成为你网络生活的恒常伙伴。为了喂养宠物，你需要购买 Q 币——这是中国虚拟经济史上的一个关键时刻。',
    'QQ Pet was one of the first successful virtual goods economies in China, training a generation of users to spend real money on digital items. It foreshadowed the entire mobile game monetization model.',
    'QQ宠物是中国最早成功的虚拟商品经济之一，训练了一代用户为数字物品花费真钱，预示了整个移动游戏商业化模式的到来。',
    'QQ Pet was discontinued in 2013 as mobile apps replaced desktop-based social features. Millions of virtual pets simply vanished.',
    'QQ宠物于2013年停服，移动应用取代了桌面社交功能，数百万虚拟宠物就此消失。',
    NULL
);

-- 18. Vine
INSERT INTO artifact (id, slug, name, name_zh, category_id, status, founded_year, closed_year, country,
    description, description_zh, significance, significance_zh, what_happened, what_happened_zh, website_url)
VALUES (
    18, 'vine', 'Vine', 'Vine', 10, 2, 2012, 2017, 'US',
    'Vine was a six-second looping video app that invented a new form of comedy and creativity. The constraint of six seconds forced a kind of genius — timing had to be perfect, every frame had to count. Vine produced a generation of creators who became YouTube stars and eventually mainstream celebrities, and invented the template that TikTok would later perfect.',
    'Vine 是一款六秒循环视频应用，发明了一种新的喜剧和创意形式。六秒的限制催生了一种天才——时机必须完美，每一帧都必须有价值。Vine 培养了一代创作者，他们后来成为 YouTube 明星乃至主流名人，并发明了 TikTok 后来完善的模板。',
    'Vine proved the short-form video format and the creator economy at the same time. Its closure is one of the most-cited examples of a tech company destroying a thriving community.',
    'Vine 同时证明了短视频格式和创作者经济的可行性。它的关闭是科技公司摧毁繁荣社区最常被引用的案例之一。',
    'Twitter acquired Vine before its launch for $30 million. In October 2016, Twitter announced it was shutting Vine down. The app went dark in January 2017. Many creators never fully recovered.',
    'Twitter 在 Vine 上线前以3000万美元将其收购。2016年10月，Twitter 宣布关闭 Vine，应用于2017年1月停止运行，许多创作者从此再未完全恢复。',
    NULL
);

-- 19. Google+
INSERT INTO artifact (id, slug, name, name_zh, category_id, status, founded_year, closed_year, country,
    description, description_zh, significance, significance_zh, what_happened, what_happened_zh, website_url)
VALUES (
    19, 'google-plus', 'Google+', 'Google+', 3, 2, 2011, 2019, 'US',
    'Google+ was Google''s attempt to challenge Facebook''s social dominance. Circles, Hangouts, and a clean interface that felt years ahead of Facebook''s cluttered design. Launched with enormous hype in 2011, it gained 400 million accounts. But most people never really used it — they logged in, looked around, and quietly never went back.',
    'Google+ 是谷歌挑战 Facebook 社交主导地位的尝试。Circles 功能、Hangouts 视频通话，以及比 Facebook 混乱界面超前数年的简洁设计。2011年以巨大声势推出，获得了4亿账号。但大多数人从未真正使用它——他们登录进去，环顾四周，然后悄悄地再也没有回来。',
    'Google+ failure demonstrated that network effects in social media are nearly impossible to overcome — even with Google''s resources and reach.',
    'Google+ 的失败证明了社交媒体中的网络效应几乎无法被超越——即便是拥有谷歌的资源和影响力也不行。',
    'Google shut down the consumer version of Google+ in April 2019 following a data breach disclosure. A corporate version (Google Workspace) continued, but the social network was gone.',
    '谷歌在披露一次数据泄露事件后，于2019年4月关闭了 Google+ 消费者版本。企业版（Google Workspace）得以延续，但这个社交网络已经消失。',
    NULL
);

-- 20. Tumblr
INSERT INTO artifact (id, slug, name, name_zh, category_id, status, founded_year, closed_year, country,
    description, description_zh, significance, significance_zh, what_happened, what_happened_zh, website_url)
VALUES (
    20, 'tumblr', 'Tumblr', 'Tumblr', 12, 1, 2007, NULL, 'US',
    'Tumblr was the internet''s most vivid subculture incubator. Fandoms, LGBTQ+ communities, aesthetic movements, weird humor, political radicalization, and genuine art — all collided in a chaotic, highly visual dashboard of reblogged content. For many young people in the 2010s, Tumblr was where they figured out who they were.',
    'Tumblr 是互联网最鲜活的亚文化孵化器。粉丝圈、LGBTQ+ 社群、美学运动、奇怪的幽默、政治激进化，以及真正的艺术——一切都在混乱而高度视觉化的转发信息流中碰撞。对许多2010年代的年轻人来说，Tumblr 是他们弄清楚自己是谁的地方。',
    'Tumblr created communities and aesthetics that outlived the platform itself. Terms, memes, and entire worldviews that originated on Tumblr have since spread across the internet.',
    'Tumblr 创造了超越平台本身而存续的社群和美学。起源于 Tumblr 的用语、梗和整套世界观此后传遍了整个互联网。',
    'Yahoo acquired Tumblr in 2013 for $1.1 billion. The December 2018 adult content ban caused a mass exodus. Automattic (WordPress) acquired it in 2019 for under $3 million. It continues in a much reduced form.',
    '雅虎于2013年以11亿美元收购 Tumblr。2018年12月的成人内容禁令引发了大规模用户出走。Automattic（WordPress）于2019年以不足300万美元将其收购，Tumblr 以大幅缩水的形式延续至今。',
    'https://www.tumblr.com'
);

-- 21. 新浪博客 (Sina Blog)
INSERT INTO artifact (id, slug, name, name_zh, category_id, status, founded_year, closed_year, country,
    description, description_zh, significance, significance_zh, what_happened, what_happened_zh, website_url)
VALUES (
    21, 'sina-blog', 'Sina Blog', '新浪博客', 12, 2, 2005, 2020, 'CN',
    'Sina Blog (新浪博客) was China''s dominant blog platform in the late 2000s. Celebrities, columnists, and ordinary people flocked to it. A well-known writer''s Sina Blog could attract millions of readers. It felt like a public square where the voices of the era were published — raw, immediate, and uncurated in a way that felt genuinely new.',
    '新浪博客是2000年代末中国最主流的博客平台。名人、专栏作家和普通人纷纷涌入。一位知名写手的新浪博客可以吸引数百万读者。那感觉像是一个公共广场，时代的声音在此刊发——直接、即时，以一种前所未有的方式未经筛选。',
    'Sina Blog defined the Chinese blogging era and gave a public voice to millions who had no platform before. It was the intermediate form between traditional media and social media.',
    '新浪博客定义了中国的博客时代，让数百万此前没有平台的人拥有了公共发言权，是传统媒体与社交媒体之间的过渡形态。',
    'Weibo''s rise after 2009 made the blog format feel slow and heavy. Sina stopped actively developing the blog product, and it gradually became a ghost of its former self — still accessible but no longer vital.',
    '微博在2009年后的兴起让博客形式显得迟缓而沉重。新浪停止了对博客产品的积极开发，它逐渐成为昔日自我的幽灵——仍可访问，但不再充满活力。',
    NULL
);

-- 22. 微博 (Weibo) — early form
INSERT INTO artifact (id, slug, name, name_zh, category_id, status, founded_year, closed_year, country,
    description, description_zh, significance, significance_zh, what_happened, what_happened_zh, website_url)
VALUES (
    22, 'weibo', 'Weibo', '微博', 3, 1, 2009, NULL, 'CN',
    'Sina Weibo launched in 2009, during the same year Twitter was blocked in China. It became China''s de facto public square — a place where news broke, celebrities managed their image, and ordinary people occasionally went viral. At its early peak, Weibo felt genuinely open: officials and activists shared the same platform, and conversations could spiral unexpectedly.',
    '新浪微博于2009年推出，恰好在 Twitter 被中国屏蔽的同年。它成为了中国事实上的公共广场——新闻在此爆发，名人在此经营形象，普通人偶尔在此走红。在早期鼎盛时期，微博感觉真正开放：官员和维权人士共享同一平台，讨论可能出人意料地蔓延。',
    'Weibo was the first platform that gave ordinary Chinese citizens the infrastructure for real-time public speech at scale. Its early years remain a landmark in Chinese internet history.',
    '微博是第一个给予普通中国公民大规模实时公共发言基础设施的平台，其早年经历仍是中国互联网史上的一个里程碑。',
    'Weibo remains active but is significantly more controlled than its early years. It has lost youth share to Douyin and Bilibili, and its freewheeling early culture is largely gone.',
    '微博仍然活跃，但比早年受到更多管控。它的年轻用户份额已流失给抖音和哔哩哔哩，早年那种随性的文化基本上已经消失。',
    'https://weibo.com'
);

-- 23. Bilibili (early form)
INSERT INTO artifact (id, slug, name, name_zh, category_id, status, founded_year, closed_year, country,
    description, description_zh, significance, significance_zh, what_happened, what_happened_zh, website_url)
VALUES (
    23, 'bilibili', 'Bilibili', '哔哩哔哩', 10, 1, 2009, NULL, 'CN',
    'Bilibili started as an ACG (anime, comics, games) video site with a distinctive danmaku (bullet comment) interface — floating text scrolling across the video, creating a shared experience of watching with thousands of strangers. What began as a niche fandom site became China''s version of YouTube, home to documentaries, study vlogs, tech reviews, and a generation that grew up calling it "B站".',
    '哔哩哔哩（B站）起步于一个 ACG（动画、漫画、游戏）视频网站，配备独特的弹幕界面——飘过屏幕的滚动文字，营造出与数千陌生人共同观看的体验。从一个小众粉丝网站，它成长为中国版 YouTube，承载着纪录片、学习 vlog、科技评测，以及称它为"B站"长大的整整一代人。',
    'Bilibili preserved and grew a distinct internet subculture through the transition from PC to mobile. Its danmaku format created a form of social viewing that had no Western equivalent.',
    'B站在从 PC 向移动端过渡期间保护并壮大了一种独特的网络亚文化。其弹幕形式创造了一种西方没有对应物的社交观看方式。',
    'Bilibili went public on NASDAQ in 2018 and on the Hong Kong Stock Exchange in 2021. It has expanded far beyond its ACG roots but retains a distinct community culture.',
    'B站于2018年在纳斯达克上市，2021年在香港交易所上市，发展远超 ACG 起点，但仍保留着独特的社区文化。',
    'https://www.bilibili.com'
);

-- 24. Clubhouse
INSERT INTO artifact (id, slug, name, name_zh, category_id, status, founded_year, closed_year, country,
    description, description_zh, significance, significance_zh, what_happened, what_happened_zh, website_url)
VALUES (
    24, 'clubhouse', 'Clubhouse', 'Clubhouse', 3, 2, 2020, NULL, 'US',
    'Clubhouse was an audio-only social network that launched in the spring of 2020, just as the world went into lockdown. For a brief, vivid period in 2020 and early 2021, it felt like the most exciting thing on the internet — invite-only, iOS-only, full of tech luminaries and cultural figures talking live in rooms you could drop into and leave silently.',
    'Clubhouse 是一款纯音频社交应用，于2020年春季上线，恰好赶上全球封锁。在2020年至2021年初的短暂而鲜活的时期，它感觉像是互联网上最令人兴奋的事物——仅限邀请、仅限 iOS，充满了科技名人和文化人士在你可以悄然进入和离开的房间里进行的现场对话。',
    'Clubhouse sparked a wave of audio social features across every major platform. Twitter Spaces, Spotify Greenroom, LinkedIn Audio — all were built in direct response to Clubhouse.',
    'Clubhouse 在每个主要平台上掀起了一波音频社交功能浪潮。Twitter Spaces、Spotify Greenroom、LinkedIn Audio——都是直接回应 Clubhouse 而构建的。',
    'When COVID restrictions lifted and Clubhouse opened to Android and removed invite requirements, the magic evaporated. By 2022 it was largely forgotten. Laid off most of its staff in 2023.',
    '当新冠限制解除，Clubhouse 向安卓开放并取消邀请要求后，那种魔力消散了。到2022年，它已基本被遗忘，并于2023年裁减了大部分员工。',
    NULL
);

-- 25. 百度贴吧 (Baidu Tieba)
INSERT INTO artifact (id, slug, name, name_zh, category_id, status, founded_year, closed_year, country,
    description, description_zh, significance, significance_zh, what_happened, what_happened_zh, website_url)
VALUES (
    25, 'baidu-tieba', 'Baidu Tieba', '百度贴吧', 2, 1, 2003, NULL, 'CN',
    'Baidu Tieba is a keyword-based discussion forum system attached to China''s dominant search engine. Search for anything on Baidu and a Tieba community likely exists for it — every fandom, every city, every hobby, every illness, every obscure interest has its own board. At its peak it was China''s largest online community by sheer volume of content.',
    '百度贴吧是附属于中国最主要搜索引擎的关键词式讨论论坛系统。在百度上搜索任何东西，很可能存在对应的贴吧——每个粉丝圈、每个城市、每个爱好、每种疾病、每种小众兴趣都有自己的版块。在鼎盛时期，它是中国按内容总量计算最大的网络社区。',
    'Tieba created a unique model of interest-based online community tied to search behavior — a structure that no major Western platform ever replicated.',
    '贴吧创造了一种独特的、与搜索行为挂钩的兴趣型网络社区模式——这一结构从未被任何主要西方平台复制。',
    'Tieba remains operational but has declined significantly following multiple controversies, including the 2016 blood disease Tieba scandal. Its young user base has migrated to Bilibili, Douyin, and interest-based apps.',
    '贴吧仍在运营，但经历多次争议后显著衰落，其中包括2016年血友病吧丑闻。其年轻用户群已迁移至 B站、抖音和各类兴趣社区应用。',
    'https://tieba.baidu.com'
);

-- 26. Snapchat
INSERT INTO artifact (id, slug, name, name_zh, category_id, status, founded_year, closed_year, country,
    description, description_zh, significance, significance_zh, what_happened, what_happened_zh, website_url)
VALUES (
    26, 'snapchat', 'Snapchat', 'Snapchat', 3, 1, 2011, NULL, 'US',
    'Snapchat introduced the idea that messages could disappear — a radical departure from the permanent, searchable archives of Facebook and email. The snap, the story, the streak: these were new social primitives. Teenagers adopted it precisely because parents and employers couldn''t monitor it, and because impermanence felt honest in a way that curated profiles did not.',
    'Snapchat 引入了消息可以消失的理念——与 Facebook 和电子邮件的永久、可搜索档案截然不同。"快照"、"故事"、"连续天数"——这些是全新的社交基本单元。青少年之所以采用它，恰恰是因为父母和雇主无法监控，也因为转瞬即逝在精心策划的主页面前显得格外真实。',
    'Snapchat invented Stories — the format that Instagram, Facebook, WhatsApp, and YouTube all subsequently copied. It redefined the grammar of mobile social media.',
    'Snapchat 发明了"故事"格式——Instagram、Facebook、WhatsApp 和 YouTube 随后都进行了复制。它重新定义了移动社交媒体的语法。',
    'Snapchat remains active but has struggled to grow beyond its core teenage demographic. Its IPO in 2017 was followed by years of stagnant user growth as Instagram cloned its Stories feature.',
    'Snapchat 仍然活跃，但在核心青少年用户群之外的增长一直举步维艰。2017年 IPO 后，随着 Instagram 复制其"故事"功能，多年来用户增长停滞不前。',
    'https://www.snapchat.com'
);

-- 27. Periscope
INSERT INTO artifact (id, slug, name, name_zh, category_id, status, founded_year, closed_year, country,
    description, description_zh, significance, significance_zh, what_happened, what_happened_zh, website_url)
VALUES (
    27, 'periscope', 'Periscope', 'Periscope', 10, 2, 2015, 2021, 'US',
    'Periscope let anyone broadcast live video from a smartphone to the world. In 2015, this felt genuinely new — citizen journalism, live concerts from bedrooms, unmediated connection. Hearts floated up the screen as viewers sent appreciation in real time. For a brief period it was the most electric place on the internet.',
    'Periscope 让任何人都可以从智能手机向全世界直播视频。在2015年，这感觉是真正的新鲜事物——公民新闻、卧室里的现场音乐会、不加中介的连接。当观众实时送出喜爱时，爱心从屏幕上飘升而起。有那么短暂的一段时间，它是互联网上最充满活力的地方。',
    'Periscope pioneered the live mobile video format that would later define TikTok livestreams, Instagram Live, and a generation of creator monetization tools.',
    'Periscope 开创了直播移动视频格式，这一格式后来定义了 TikTok 直播、Instagram Live，以及一整代创作者变现工具。',
    'Twitter acquired Periscope before its launch for $100 million. As live video became a commodity feature on every platform, Periscope lost its reason to exist. Twitter shut it down in March 2021.',
    'Twitter 在 Periscope 上线前以1亿美元将其收购。随着直播视频成为每个平台的标配功能，Periscope 失去了存在的意义，Twitter 于2021年3月将其关闭。',
    NULL
);

-- 28. Musical.ly
INSERT INTO artifact (id, slug, name, name_zh, category_id, status, founded_year, closed_year, country,
    description, description_zh, significance, significance_zh, what_happened, what_happened_zh, website_url)
VALUES (
    28, 'musically', 'Musical.ly', 'Musical.ly', 10, 2, 2014, 2018, 'CN',
    'Musical.ly was a short-form lip-sync video app built by a Shanghai startup that accidentally became a global phenomenon among teenagers. The formula was simple: pick a song, lip-sync, add effects. But the creator tools were surprisingly deep, and the algorithm surfaced content to anyone regardless of follower count. Sound familiar?',
    'Musical.ly 是一款由上海创业公司打造的短视频对口型应用，意外地在全球青少年中引发了现象级传播。公式很简单：选一首歌，对口型，加特效。但创作工具出人意料地丰富，算法可以让任何内容被任何人看到，无论粉丝数量多少。是不是很眼熟？',
    'Musical.ly was the direct precursor to TikTok. ByteDance acquired it in 2017 and merged it with Douyin to create TikTok in 2018. Without Musical.ly''s Western user base and creator culture, TikTok''s global takeover would have been far slower.',
    'Musical.ly 是 TikTok 的直接前身。字节跳动于2017年将其收购，并与抖音合并创建了 TikTok（2018年）。没有 Musical.ly 在西方积累的用户基础和创作者文化，TikTok 的全球扩张会缓慢得多。',
    'ByteDance acquired Musical.ly in November 2017 for up to $1 billion. In August 2018, it was merged into TikTok, effectively ending its separate existence.',
    '字节跳动于2017年11月以最高10亿美元收购 Musical.ly，并于2018年8月将其并入 TikTok，其独立存在就此终结。',
    NULL
);

-- 29. TikTok / 抖音
INSERT INTO artifact (id, slug, name, name_zh, category_id, status, founded_year, closed_year, country,
    description, description_zh, significance, significance_zh, what_happened, what_happened_zh, website_url)
VALUES (
    29, 'tiktok', 'TikTok / Douyin', 'TikTok / 抖音', 10, 1, 2016, NULL, 'CN',
    'TikTok (called Douyin in China) is the platform that redefined how video content is discovered and consumed. Its For You Page algorithm delivers an endless personalized feed that requires no social graph — you don''t need friends, followers, or curation. A video made in a bedroom can reach a hundred million people. No previous platform concentrated so much attention so efficiently.',
    'TikTok（在中国称为抖音）是重新定义视频内容发现和消费方式的平台。它的"为你推荐"算法提供无尽的个性化信息流，无需社交关系图谱——你不需要朋友、粉丝或策划。一个在卧室里拍的视频可以触达一亿人。此前没有任何平台以如此高效的方式集中如此多的注意力。',
    'TikTok fundamentally changed content discovery, creator economics, and the attention economy. It forced every other social platform to rebuild around short-form video and algorithmic feeds rather than social graphs.',
    'TikTok 从根本上改变了内容发现、创作者经济和注意力经济。它迫使每个其他社交平台围绕短视频和算法推送进行重建，而非依赖社交关系图谱。',
    'TikTok faces ongoing regulatory scrutiny in the US and elsewhere over its Chinese ownership. As of 2024, it remains one of the world''s most downloaded and used applications.',
    'TikTok 因其中资背景在美国等地持续面临监管审查。截至2024年，它仍是全球下载量和使用量最高的应用之一。',
    'https://www.tiktok.com'
);

-- -----------------------------------------------------------
-- Sample Exhibition / 示例展览
-- -----------------------------------------------------------
INSERT INTO exhibition (id, slug, title, title_zh, subtitle, subtitle_zh, description, description_zh, status, era_start, era_end)
VALUES (
    1,
    'china-early-internet',
    'China''s Early Internet',
    '中国互联网的早期岁月',
    'Before WeChat and Weibo, there was a different world',
    '在微信和微博之前，有一个不同的世界',
    'This exhibition explores the formative years of China''s Internet ecosystem — the portals, forums, games, and communities that connected a generation before smartphones.',
    '本展览探索中国互联网生态系统的形成岁月——那些在智能手机出现之前连接了一代人的门户网站、论坛、游戏和社区。',
    1,
    1994,
    2010
);

SET FOREIGN_KEY_CHECKS = 1;
