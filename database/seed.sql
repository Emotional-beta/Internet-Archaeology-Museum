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
