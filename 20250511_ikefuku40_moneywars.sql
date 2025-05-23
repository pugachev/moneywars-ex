-- phpMyAdmin SQL Dump
-- version 5.2.1-1.el7.remi
-- https://www.phpmyadmin.net/
--
-- ホスト: localhost
-- 生成日時: 2025 年 5 月 11 日 15:13
-- サーバのバージョン： 10.5.13-MariaDB-log
-- PHP のバージョン: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- データベース: `ikefuku40_moneywars`
--

-- --------------------------------------------------------

--
-- テーブルの構造 `amazon_usage_history`
--

CREATE TABLE `amazon_usage_history` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `is_used` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- テーブルのデータのダンプ `amazon_usage_history`
--

INSERT INTO `amazon_usage_history` (`id`, `date`, `is_used`, `created_at`, `updated_at`) VALUES
(6, '2025-04-30', 1, '2025-04-30 04:40:12', '2025-04-30 04:40:12'),
(7, '2025-04-29', 1, '2025-04-30 12:09:54', '2025-04-30 12:09:54'),
(8, '2025-05-01', 1, '2025-05-01 00:55:22', '2025-05-01 00:55:22'),
(9, '2025-05-02', 1, '2025-05-02 11:28:27', '2025-05-02 11:28:27'),
(10, '2025-05-03', 0, '2025-05-02 14:48:55', '2025-05-02 14:48:56'),
(11, '2025-05-04', 1, '2025-05-03 22:11:54', '2025-05-03 22:11:54'),
(12, '2025-05-05', 1, '2025-05-04 21:47:08', '2025-05-04 21:47:08'),
(13, '2025-05-06', 1, '2025-05-06 17:26:27', '2025-05-06 17:26:27'),
(14, '2025-05-07', 0, '2025-05-06 17:26:29', '2025-05-06 17:26:30'),
(15, '2025-05-08', 0, '2025-05-07 19:55:21', '2025-05-07 19:55:23'),
(16, '2025-05-09', 1, '2025-05-09 07:31:43', '2025-05-09 07:31:43'),
(17, '2025-05-10', 0, '2025-05-09 22:41:03', '2025-05-09 22:41:04'),
(18, '2025-05-11', 1, '2025-05-10 19:48:41', '2025-05-10 19:48:41');

-- --------------------------------------------------------

--
-- テーブルの構造 `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `items`
--

CREATE TABLE `items` (
  `code` int(11) NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- テーブルのデータのダンプ `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, 'xxxx_xx_xx_create_items_table', 1),
(6, 'xxxx_xx_xx_create_spendings_table', 1),
(7, '2024_03_XX_XXXXXX_add_description_to_spendings_table', 2);

-- --------------------------------------------------------

--
-- テーブルの構造 `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `spendings`
--

CREATE TABLE `spendings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tgtdate` date NOT NULL,
  `tgtmoney` int(11) NOT NULL,
  `tgtitem` int(11) NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- テーブルのデータのダンプ `spendings`
--

INSERT INTO `spendings` (`id`, `tgtdate`, `tgtmoney`, `tgtitem`, `description`, `created_at`, `updated_at`) VALUES
(39, '2025-01-01', 880, 1, '寿司12貫', '2024-12-31 10:53:58', '2025-01-02 14:51:43'),
(40, '2025-01-01', 1480, 1, '寿司20貫', '2024-12-31 10:55:09', '2025-01-02 14:51:56'),
(41, '2025-01-01', 1999, 2, NULL, '2024-12-31 14:51:30', '2024-12-31 14:51:30'),
(42, '2025-01-02', 2640, 1, '豚しゃぶと白菜を蒸したました', '2025-01-01 10:04:12', '2025-01-02 11:38:23'),
(43, '2025-01-03', 1000, 5, NULL, '2025-01-02 17:37:36', '2025-01-02 17:37:36'),
(44, '2025-01-03', 1400, 5, NULL, '2025-01-02 17:38:02', '2025-01-02 17:38:02'),
(45, '2025-01-03', 1300, 5, NULL, '2025-01-02 17:38:25', '2025-01-02 17:38:25'),
(46, '2025-01-03', 2760, 1, NULL, '2025-01-02 17:38:53', '2025-01-02 17:38:53'),
(47, '2025-01-04', 500, 5, NULL, '2025-01-04 13:43:40', '2025-01-04 13:43:40'),
(48, '2025-01-04', 300, 5, NULL, '2025-01-04 13:44:04', '2025-01-04 13:44:04'),
(49, '2025-01-04', 4080, 1, NULL, '2025-01-04 13:44:53', '2025-01-04 13:44:53'),
(50, '2025-01-05', 3900, 5, NULL, '2025-01-04 18:47:22', '2025-01-04 18:47:22'),
(51, '2025-01-05', 1168, 1, NULL, '2025-01-04 18:47:58', '2025-01-04 18:47:58'),
(52, '2025-01-06', 711, 2, 'Amazon カレンダースタンド', '2025-01-05 19:16:34', '2025-01-06 19:27:08'),
(53, '2025-01-06', 3960, 1, 'Amazon お茶漬けセット', '2025-01-05 19:17:14', '2025-01-06 19:27:52'),
(54, '2025-01-06', 3575, 3, 'Amazon プーマ', '2025-01-05 21:45:42', '2025-01-06 19:26:50'),
(55, '2025-01-06', 2228, 1, 'りんごとバナナとトリスハイボール等', '2025-01-05 23:55:39', '2025-01-06 19:28:24'),
(56, '2025-01-06', 272, 2, 'ファミリマート 入浴剤', '2025-01-05 23:56:33', '2025-01-06 19:29:17'),
(57, '2025-01-06', 1683, 2, 'Amazon 頭皮マッサージ', '2025-01-06 03:27:02', '2025-01-06 19:26:31'),
(58, '2025-01-07', 1317, 1, 'りんごとバナナとトリスハイボール', '2025-01-06 19:16:21', '2025-01-06 19:28:43'),
(59, '2025-01-07', 362, 1, 'ファミリマート 水2本', '2025-01-06 19:16:54', '2025-01-06 19:28:58'),
(60, '2025-01-07', 3400, 2, 'Amazon トイレットペーパー', '2025-01-06 20:11:55', '2025-01-06 20:11:55'),
(62, '2025-01-08', 2114, 5, 'Amazon キンドル 漫画', '2025-01-07 12:54:59', '2025-01-07 12:54:59'),
(63, '2025-01-08', 1099, 1, 'りんごとヨーグルト', '2025-01-08 12:00:54', '2025-01-08 12:00:54'),
(64, '2025-01-08', 386, 1, 'グミとのど飴', '2025-01-08 12:01:30', '2025-01-08 12:01:30'),
(65, '2025-01-09', 999, 2, 'Amazon 靴擦れ防止パッド', '2025-01-08 17:18:34', '2025-01-08 17:18:34'),
(66, '2025-01-10', 3390, 2, 'Amazon 枕', '2025-01-09 17:44:51', '2025-01-09 17:44:51'),
(67, '2025-01-10', 2231, 1, 'りんごとバナナ、トリスハイボール等', '2025-01-09 20:37:21', '2025-01-09 20:37:21'),
(68, '2025-01-11', 3960, 1, 'Amazon お茶漬け', '2025-01-10 12:14:11', '2025-01-10 12:14:11'),
(69, '2025-01-11', 1452, 2, '入浴剤とかドリエル等', '2025-01-10 20:31:30', '2025-01-10 20:31:30'),
(70, '2025-01-11', 1764, 1, 'りんごと翠ソーダや角ハイボール等', '2025-01-10 20:32:13', '2025-01-10 20:32:13'),
(71, '2025-01-12', 775, 1, '中華そば', '2025-01-11 23:22:52', '2025-01-11 23:22:52'),
(72, '2025-01-12', 500, 5, '銀閣寺拝観料', '2025-01-11 23:23:17', '2025-01-11 23:23:17'),
(73, '2025-01-12', 300, 5, '御朱印料', '2025-01-11 23:23:38', '2025-01-11 23:23:38'),
(75, '2025-01-13', 2280, 1, 'ドリップコーヒー', '2025-01-12 14:21:19', '2025-01-12 14:21:19'),
(76, '2025-01-12', 1984, 2, 'ぬくぽかスリッパ', '2025-01-12 14:22:07', '2025-01-12 14:22:07'),
(77, '2025-01-13', 2488, 1, 'りんごとヨーグルト', '2025-01-12 18:43:41', '2025-01-12 18:43:41'),
(78, '2025-01-13', 1500, 5, 'コインランドリー 追加の乾燥を含む', '2025-01-12 18:44:20', '2025-01-12 18:44:20'),
(79, '2025-01-15', 2118, 2, 'Amazon クナイプ', '2025-01-14 16:36:30', '2025-01-14 16:36:30'),
(80, '2025-01-14', 1110, 1, '白菜等', '2025-01-14 16:37:11', '2025-01-14 16:37:11'),
(81, '2025-01-15', 2045, 1, 'りんごとヨーグルト等', '2025-01-14 21:33:49', '2025-01-14 21:33:49'),
(82, '2025-01-16', 1390, 1, 'Amazon お茶漬け・味噌汁等', '2025-01-15 13:21:02', '2025-01-15 13:21:02'),
(83, '2025-01-16', 730, 1, 'ファミマ グミやウェットティッシュ等', '2025-01-15 19:13:11', '2025-01-15 19:13:11'),
(84, '2025-01-16', 1819, 1, 'りんごとヨーグルト等', '2025-01-16 03:31:55', '2025-01-16 03:31:55'),
(85, '2025-01-17', 719, 1, 'おにぎり等', '2025-01-16 21:11:45', '2025-01-16 21:11:45'),
(86, '2025-01-17', 405, 1, 'グミ等', '2025-01-16 21:12:09', '2025-01-16 21:12:09'),
(87, '2025-01-17', 869, 1, '野菜を多数', '2025-01-17 02:40:16', '2025-01-17 02:40:16'),
(89, '2025-01-18', 1469, 2, 'Amazon Galaxyケース', '2025-01-17 14:58:37', '2025-01-17 14:58:37'),
(90, '2025-01-18', 660, 2, 'キャンドゥー ランチョンマットやキッチンスポンジ等', '2025-01-17 19:17:48', '2025-01-17 19:17:48'),
(91, '2025-01-18', 1155, 1, 'リンゴとハイボール等', '2025-01-17 19:18:15', '2025-01-17 19:18:15'),
(92, '2025-01-19', 1322, 5, 'Amazon 猫ステッカー', '2025-01-18 08:53:46', '2025-01-18 08:53:46'),
(93, '2025-01-19', 2317, 1, 'お寿司', '2025-01-18 17:33:26', '2025-01-18 17:33:26'),
(94, '2025-01-19', 1100, 5, 'コインランドリー', '2025-01-18 17:33:50', '2025-01-18 17:33:50'),
(95, '2025-01-20', 1980, 5, 'Amazon グリシン', '2025-01-19 10:10:01', '2025-01-19 10:10:01'),
(96, '2025-01-20', 2080, 1, 'りんごとヨーグルトと角ハイボール', '2025-01-20 00:48:29', '2025-01-20 00:48:29'),
(97, '2025-01-20', 2046, 5, 'めぐりズムとルル', '2025-01-20 00:49:02', '2025-01-20 00:49:02'),
(98, '2025-01-21', 1184, 1, 'Amazon 鮭茶漬け', '2025-01-20 17:08:21', '2025-01-20 17:08:21'),
(99, '2025-01-21', 1473, 1, 'Amazon カレーカップ', '2025-01-20 17:08:55', '2025-01-20 17:08:55'),
(100, '2025-01-21', 2850, 2, 'Amazon スリッポン', '2025-01-20 17:09:23', '2025-01-20 17:09:23'),
(101, '2025-01-21', 709, 1, 'ファミマ  おにぎり', '2025-01-20 19:23:33', '2025-01-20 19:23:33'),
(102, '2025-01-21', 294, 1, 'グミ', '2025-01-20 19:23:58', '2025-01-20 19:23:58'),
(103, '2025-01-21', 1572, 1, 'リンゴ等', '2025-01-21 01:20:55', '2025-01-21 01:20:55'),
(104, '2025-01-22', 1950, 5, 'MacBookProケース', '2025-01-21 13:18:21', '2025-01-21 13:18:21'),
(105, '2025-01-22', 797, 1, 'おにぎり', '2025-01-21 19:31:53', '2025-01-21 19:31:53'),
(106, '2025-01-22', 1700, 1, 'りんごとヨーグルト', '2025-01-22 03:36:55', '2025-01-22 03:36:55'),
(107, '2024-12-25', 3756, 5, 'めぐリズム', '2025-01-24 12:00:14', '2025-01-24 12:00:14'),
(108, '2024-12-10', 185, 1, 'ファミマ グミ', '2025-01-24 12:00:59', '2025-01-24 12:00:59'),
(109, '2024-12-30', 2721, 5, '京都お土産 渡辺向け', '2025-01-24 12:01:39', '2025-01-24 12:01:39'),
(110, '2025-01-14', 408, 1, 'ファミマ グミ', '2025-01-24 12:02:11', '2025-01-24 12:02:11'),
(111, '2025-01-24', 575, 1, 'ファミマ ラムネ', '2025-01-24 12:02:42', '2025-01-24 12:02:42'),
(112, '2025-01-24', 185, 1, 'ファミマ おにぎり', '2025-01-24 12:03:46', '2025-01-24 12:03:46'),
(113, '2025-01-22', 570, 1, 'ファミマ タンスティック', '2025-01-24 12:04:38', '2025-01-24 12:04:38'),
(114, '2025-01-24', 1013, 1, 'りんごとヨーグルト', '2025-01-24 12:05:07', '2025-01-24 12:05:07'),
(115, '2025-01-26', 3566, 1, '焼き肉セット', '2025-01-25 23:23:56', '2025-01-25 23:23:56'),
(116, '2025-01-26', 1100, 5, 'コインランドリー', '2025-01-25 23:24:38', '2025-01-25 23:24:38'),
(117, '2025-01-26', 1024, 1, 'ファミマ お酒', '2025-01-26 12:17:15', '2025-01-26 12:17:15'),
(118, '2025-01-27', 853, 1, 'ファミリーマート おにぎり', '2025-01-26 18:38:24', '2025-01-26 18:38:24'),
(119, '2025-01-27', 1594, 1, 'りんごとヨーグルト', '2025-01-27 04:12:26', '2025-01-27 04:12:26'),
(120, '2025-01-27', 701, 1, 'ファミマ グミ', '2025-01-27 17:45:28', '2025-01-27 17:45:28'),
(121, '2025-01-29', 2422, 1, 'しゃぶしゃぶ等', '2025-01-28 22:35:39', '2025-01-28 22:35:39'),
(122, '2025-01-29', 330, 2, 'DAISO 鍋つかみ等', '2025-01-28 22:36:08', '2025-01-28 22:36:08'),
(123, '2025-01-23', 1728, 1, 'りんごとバナナ、ヨーグルト等', '2025-01-28 22:36:44', '2025-01-28 22:36:44'),
(124, '2025-01-28', 991, 1, 'りんごとヨーグルト等', '2025-01-28 22:37:20', '2025-01-28 22:37:20'),
(125, '2025-01-28', 518, 1, 'ファミマ トリスハイボール等', '2025-01-28 22:38:01', '2025-01-28 22:38:01'),
(126, '2025-01-31', 2360, 1, 'りんごとヨーグルト等', '2025-01-30 13:09:02', '2025-01-30 13:09:02'),
(127, '2025-01-30', 3980, 1, 'Amazon マンナンライフ', '2025-01-30 13:10:13', '2025-01-30 13:10:13'),
(128, '2025-01-31', 1999, 2, 'Amazon AppleWatch革バンド', '2025-01-30 13:10:59', '2025-01-30 13:10:59'),
(129, '2025-01-31', 991, 1, 'トリスハイボール', '2025-01-31 00:03:00', '2025-01-31 00:03:00'),
(130, '2025-01-29', 976, 1, 'ファミマ トリスハイボール', '2025-01-31 00:03:30', '2025-01-31 00:03:30'),
(131, '2025-02-01', 899, 5, 'Amazon キンドル本', '2025-01-31 20:05:16', '2025-01-31 20:05:16'),
(132, '2025-02-01', 1980, 5, 'Amazon 渡邊渚', '2025-01-31 20:07:21', '2025-01-31 20:07:21'),
(133, '2025-02-02', 1645, 1, 'うどんや白菜等', '2025-02-01 20:10:45', '2025-02-01 20:10:45'),
(134, '2025-02-03', 2842, 1, 'りんごとヨーグルト等', '2025-02-03 00:56:51', '2025-02-03 00:56:51'),
(135, '2025-02-05', 675, 1, 'ファミマ おにぎり', '2025-02-04 16:01:27', '2025-02-04 16:01:27'),
(136, '2025-02-05', 704, 1, 'ファミマ グミ', '2025-02-04 19:38:03', '2025-02-04 19:38:03'),
(137, '2025-02-05', 1130, 1, 'ふりかけ', '2025-02-05 00:16:28', '2025-02-05 00:16:28'),
(138, '2025-02-06', 5098, 1, 'Amazon なす味噌汁等', '2025-02-05 14:14:23', '2025-02-05 14:14:23'),
(139, '2025-02-06', 3683, 1, 'りんごとヨーグルト等', '2025-02-05 23:58:57', '2025-02-05 23:58:57'),
(140, '2025-02-07', 3199, 1, 'Amazon リュック', '2025-02-06 19:47:12', '2025-02-06 19:47:12'),
(141, '2025-02-08', 2171, 5, 'ココカラファイン めぐリズムとリシュテリン', '2025-02-07 20:45:13', '2025-02-07 20:45:13'),
(142, '2025-02-08', 2371, 1, 'りんごとヨールグト等', '2025-02-07 20:45:56', '2025-02-07 20:45:56'),
(143, '2025-02-09', 2234, 1, 'Amazon ドリップコーヒー', '2025-02-08 20:26:57', '2025-02-08 20:26:57'),
(144, '2025-02-09', 3289, 1, 'りんごとヨーグルト', '2025-02-09 01:26:46', '2025-02-09 01:26:46'),
(145, '2025-02-11', 1286, 5, 'Amazon ApplePencil替芯', '2025-02-10 07:29:43', '2025-02-10 07:29:43'),
(146, '2025-02-11', 1980, 2, 'Amazon 洗顔石鹸', '2025-02-10 15:49:01', '2025-02-10 15:49:01'),
(147, '2025-02-11', 4105, 1, 'りんごとバナナ、トリスハイボール等', '2025-02-10 20:38:11', '2025-02-10 20:38:11'),
(148, '2025-02-12', 723, 1, 'ファミマ おにぎり', '2025-02-11 15:23:29', '2025-02-11 15:23:29'),
(149, '2025-02-12', 9999, 2, 'Amazon 炬燵', '2025-02-11 17:28:07', '2025-02-11 17:28:07'),
(150, '2025-02-12', 405, 1, 'ファミマ グミ', '2025-02-11 20:04:56', '2025-02-11 20:04:56'),
(151, '2025-02-12', 2668, 1, 'りんごとバナナ等', '2025-02-12 00:39:32', '2025-02-12 00:39:32'),
(152, '2025-02-13', 990, 1, 'ファミマ おにぎり', '2025-02-13 01:14:48', '2025-02-13 01:14:48'),
(153, '2025-02-13', 3500, 5, '散髪', '2025-02-13 01:15:06', '2025-02-13 01:15:06'),
(154, '2025-02-13', 1722, 1, 'りんごとバナナ', '2025-02-13 01:15:26', '2025-02-13 01:15:26'),
(155, '2025-02-13', 2162, 1, 'Amazon お茶漬け', '2025-02-13 01:48:54', '2025-02-13 01:48:54'),
(156, '2025-02-14', 3493, 2, 'Amazon 半纏', '2025-02-13 19:09:31', '2025-02-13 19:09:31'),
(157, '2025-02-14', 811, 1, 'ファミマ おにぎり', '2025-02-13 19:09:50', '2025-02-13 19:09:50'),
(158, '2025-02-14', 436, 2, 'CanDo ランチョンマット', '2025-02-14 00:39:38', '2025-02-14 00:39:38'),
(159, '2025-02-14', 737, 1, 'りんご', '2025-02-14 00:40:07', '2025-02-14 00:40:07'),
(160, '2025-02-14', 1599, 5, 'Amazon パソコンスタンド', '2025-02-14 00:51:57', '2025-02-14 00:51:57'),
(161, '2025-02-15', 2282, 1, 'お肉', '2025-02-14 20:14:39', '2025-02-14 20:14:39'),
(162, '2025-02-15', 220, 2, 'ランチョンマット', '2025-02-14 20:15:06', '2025-02-14 20:15:06'),
(163, '2025-02-15', 166, 2, '燃えるゴミ袋', '2025-02-14 20:15:44', '2025-02-14 20:15:44'),
(164, '2025-02-16', 2986, 1, 'りんごとヨーグル等', '2025-02-16 07:28:22', '2025-02-16 07:28:22'),
(165, '2025-02-17', 2324, 1, 'りんごとヨーグル等', '2025-02-17 01:46:22', '2025-02-17 01:46:22'),
(166, '2025-02-18', 1216, 1, 'りんごとヨーグルト等', '2025-02-17 23:50:35', '2025-02-17 23:50:35'),
(167, '2025-02-19', 486, 1, 'ファミマ グミ', '2025-02-18 17:05:39', '2025-02-18 17:05:39'),
(168, '2025-02-19', 7988, 5, 'Amazon キーボード', '2025-02-18 22:09:20', '2025-02-18 22:09:20'),
(169, '2025-02-19', 4712, 1, 'お茶づけ', '2025-02-19 15:15:25', '2025-02-19 15:15:25'),
(170, '2025-02-20', 1980, 5, 'Amazon トリプトファン', '2025-02-19 15:16:21', '2025-02-19 15:16:21'),
(171, '2025-02-20', 767, 1, 'ファミマ ラムネ菓子等', '2025-02-19 20:13:48', '2025-02-19 20:13:48'),
(172, '2025-02-20', 1605, 1, 'りんごとヨーグルト等', '2025-02-20 01:25:19', '2025-02-20 01:25:19'),
(173, '2025-02-19', 3661, 1, '焼き肉セット', '2025-02-20 01:25:55', '2025-02-20 01:25:55'),
(174, '2025-02-21', 882, 2, NULL, '2025-02-22 01:30:17', '2025-02-22 01:30:17'),
(175, '2025-02-21', 437, 1, NULL, '2025-02-22 01:30:49', '2025-02-22 01:30:49'),
(176, '2025-02-21', 1289, 1, NULL, '2025-02-22 01:31:22', '2025-02-22 01:31:22'),
(177, '2025-02-22', 2675, 2, NULL, '2025-02-22 01:32:30', '2025-02-22 01:32:30'),
(178, '2025-02-22', 8800, 5, NULL, '2025-02-22 01:33:03', '2025-02-22 01:33:03'),
(179, '2025-02-21', 2699, 5, NULL, '2025-02-22 01:33:36', '2025-02-22 01:33:36'),
(180, '2025-02-22', 7480, 5, NULL, '2025-02-22 02:30:28', '2025-02-22 02:30:28'),
(181, '2025-02-23', 600, 2, NULL, '2025-02-22 21:21:52', '2025-02-22 21:21:52'),
(182, '2025-02-23', 2028, 1, NULL, '2025-02-22 21:22:07', '2025-02-22 21:22:07'),
(183, '2025-02-25', 2573, 1, NULL, '2025-02-24 19:36:10', '2025-02-24 19:36:10'),
(184, '2025-02-25', 2680, 1, NULL, '2025-02-24 21:21:56', '2025-02-24 21:21:56'),
(185, '2025-02-25', 290, 1, NULL, '2025-02-25 02:45:04', '2025-02-25 02:45:04'),
(186, '2025-02-25', 553, 2, NULL, '2025-02-25 02:45:52', '2025-02-25 02:45:52'),
(187, '2025-02-25', 1553, 1, NULL, '2025-02-25 02:47:31', '2025-02-25 02:47:31'),
(188, '2025-02-27', 497, 1, NULL, '2025-02-27 13:04:09', '2025-02-27 13:04:09'),
(189, '2025-02-27', 1414, 1, NULL, '2025-02-27 13:04:45', '2025-02-27 13:04:45'),
(190, '2025-02-26', 2241, 1, NULL, '2025-02-27 13:05:17', '2025-02-27 13:05:17'),
(191, '2025-02-28', 1379, 1, NULL, '2025-02-27 19:50:33', '2025-02-27 19:50:33'),
(192, '2025-03-01', 1200, 1, NULL, '2025-03-01 02:04:47', '2025-03-01 02:04:47'),
(193, '2025-03-02', 4361, 1, NULL, '2025-03-02 00:02:35', '2025-03-02 00:02:35'),
(194, '2025-03-03', 2053, 1, NULL, '2025-03-02 20:03:14', '2025-03-02 20:03:14'),
(195, '2025-03-04', 35820, 5, 'Amazon 外部接続ドック', '2025-03-04 16:40:38', '2025-03-11 02:21:20'),
(196, '2025-03-05', 821, 1, NULL, '2025-03-04 19:07:45', '2025-03-04 19:07:45'),
(197, '2025-03-04', 613, 2, NULL, '2025-03-04 19:09:05', '2025-03-04 19:09:05'),
(198, '2025-03-04', 1173, 5, NULL, '2025-03-04 19:09:32', '2025-03-04 19:09:32'),
(199, '2025-03-05', 1962, 5, 'Amazon Macbookケース', '2025-03-04 20:17:09', '2025-03-11 02:24:32'),
(200, '2025-03-05', 2062, 1, NULL, '2025-03-05 02:26:16', '2025-03-05 02:26:16'),
(201, '2025-03-06', 1116, 1, NULL, '2025-03-05 19:09:11', '2025-03-05 19:09:11'),
(202, '2025-03-07', 2840, 1, 'Amazon　ボカロ焼きそば', '2025-03-06 16:35:44', '2025-03-11 02:24:02'),
(203, '2025-03-07', 1069, 1, NULL, '2025-03-07 02:10:10', '2025-03-07 02:10:10'),
(205, '2025-03-08', 2118, 2, 'Amazon クナイプバスソルト', '2025-03-07 16:07:24', '2025-03-11 02:23:22'),
(206, '2025-03-08', 2034, 1, NULL, '2025-03-07 19:14:34', '2025-03-07 19:14:34'),
(207, '2025-03-05', 3900, 5, 'NHK料金', '2025-03-07 19:15:05', '2025-03-11 02:25:11'),
(208, '2025-03-03', 990, 2, NULL, '2025-03-07 19:15:37', '2025-03-07 19:15:37'),
(209, '2025-03-01', 173, 2, NULL, '2025-03-07 19:16:13', '2025-03-07 19:16:13'),
(210, '2025-03-09', 2128, 2, 'Amazon 当帰の力 歯磨き粉', '2025-03-08 14:57:33', '2025-03-11 02:22:50'),
(212, '2025-03-09', 1024, 1, 'コーヨー なめこ茸とふりかけ', '2025-03-08 22:33:40', '2025-03-08 22:33:40'),
(213, '2025-03-10', 1622, 1, 'Amazon もちスープ', '2025-03-09 15:14:58', '2025-03-09 15:14:58'),
(214, '2025-03-10', 846, 1, 'コーヨー バナナとヨーグルト', '2025-03-09 19:20:29', '2025-03-09 19:20:29'),
(215, '2025-03-10', 488, 1, 'ファミマ アルコール', '2025-03-09 19:20:45', '2025-03-09 19:20:45'),
(216, '2025-03-10', 3628, 1, 'Amazon なす味噌汁', '2025-03-10 03:49:12', '2025-03-10 03:49:12'),
(217, '2025-03-11', 1382, 5, 'Amazon エビオス', '2025-03-10 15:30:03', '2025-03-10 15:30:03'),
(218, '2025-03-11', 886, 1, 'コーヨー キャベツともやし等', '2025-03-11 01:34:32', '2025-03-11 01:34:32'),
(219, '2025-03-11', 108, 1, 'CanDo カレー粉', '2025-03-11 01:34:56', '2025-03-11 01:34:56'),
(220, '2025-03-13', 998, 1, 'バナナとヨーグルト', '2025-03-12 19:17:37', '2025-03-12 19:17:37'),
(221, '2025-03-13', 228, 1, 'トリスハイボール', '2025-03-12 19:18:05', '2025-03-12 19:18:05'),
(222, '2025-03-14', 4500, 5, '御金神社 御札', '2025-03-14 00:16:19', '2025-03-14 00:16:19'),
(223, '2025-03-14', 600, 5, '大谷廟堂 お花', '2025-03-14 00:16:40', '2025-03-14 00:16:40'),
(224, '2025-03-14', 2643, 1, 'コーヨー キャベツなど', '2025-03-14 00:17:08', '2025-03-14 00:17:08'),
(225, '2025-03-14', 254, 1, '京都 セブンイレブン ぷっちょ', '2025-03-14 00:17:54', '2025-03-14 00:17:54'),
(226, '2025-03-15', 1538, 1, 'コーヨー バナナとヨーグルト', '2025-03-14 20:27:53', '2025-03-14 20:27:53'),
(227, '2025-03-15', 1100, 2, 'CanDo スポンジキューブ等', '2025-03-14 20:28:24', '2025-03-14 20:28:24'),
(228, '2025-03-15', 330, 2, 'CanDo 食器用洗剤等', '2025-03-14 20:28:56', '2025-03-14 20:28:56'),
(229, '2025-03-16', 3707, 1, 'コーヨー 焼き肉セット', '2025-03-15 22:22:47', '2025-03-15 22:22:47'),
(230, '2025-03-16', 368, 2, 'サンディ ゴミ袋等', '2025-03-15 22:23:18', '2025-03-15 22:23:18'),
(231, '2025-03-16', 991, 1, 'サンディ ハイボールとお菓子等', '2025-03-15 22:51:48', '2025-03-15 22:51:48'),
(232, '2025-03-17', 1750, 1, 'コーヨー りんごとヨーグルト等', '2025-03-17 17:54:04', '2025-03-17 17:54:04'),
(233, '2025-03-18', 2859, 5, 'めぐりズムとアパガード', '2025-03-18 02:24:44', '2025-03-18 02:24:44'),
(234, '2025-03-18', 649, 1, 'コーヨー キャベツなど', '2025-03-18 02:25:30', '2025-03-18 02:25:30'),
(235, '2025-03-18', 1100, 1, 'ファミマ おにぎり等', '2025-03-18 02:26:18', '2025-03-18 02:26:18'),
(236, '2025-03-18', 1584, 5, 'Amazon クリプトファン', '2025-03-18 02:29:43', '2025-03-18 02:29:43'),
(237, '2025-03-19', 1478, 2, 'Amazon パームレスト', '2025-03-18 12:39:57', '2025-03-18 12:39:57'),
(238, '2025-03-19', 4299, 5, 'Amazon Mac用キーボードクリアケース', '2025-03-18 17:46:49', '2025-03-18 17:46:49'),
(239, '2025-03-19', 715, 1, 'ファミマ おにぎり', '2025-03-18 19:17:00', '2025-03-18 19:17:00'),
(240, '2025-03-19', 402, 1, 'ファミマ グミ', '2025-03-18 19:17:13', '2025-03-18 19:17:13'),
(241, '2025-03-19', 2036, 1, 'コーヨー りんごとバナナとヨーグルト等', '2025-03-19 03:02:15', '2025-03-19 03:02:15'),
(242, '2025-03-21', 18800, 5, 'Amazon Fujitsuキーボード', '2025-03-20 17:08:14', '2025-03-20 17:08:14'),
(243, '2025-03-21', 840, 1, 'ファミマ おにぎり', '2025-03-21 02:23:12', '2025-03-21 02:23:12'),
(244, '2025-03-21', 1784, 1, 'コーヨー りんごとバナナとヨーグルト等', '2025-03-21 02:23:45', '2025-03-21 02:23:45'),
(253, '2025-03-22', 2220, 1, 'コーヨー りんごとバナナとヨーグルト等', '2025-03-21 21:01:16', '2025-03-21 21:01:16'),
(254, '2025-03-22', 3117, 1, '鮭茶漬けとコーヒー', '2025-03-22 00:21:52', '2025-03-22 00:21:52'),
(255, '2025-03-23', 2450, 1, 'コーヨー キャベツなど', '2025-03-22 21:38:59', '2025-03-22 21:38:59'),
(256, '2025-03-24', 3150, 1, 'Amazon カレースープとチキン', '2025-03-23 08:52:31', '2025-03-23 08:52:31'),
(257, '2025-03-24', 1977, 1, 'コーヨー りんごとヨーグルト等', '2025-03-24 02:43:13', '2025-03-24 02:43:13'),
(258, '2025-03-24', 5128, 1, 'Amazon マンナンライフ', '2025-03-24 04:11:08', '2025-03-24 04:11:08'),
(259, '2025-03-25', 845, 1, 'コーヨー キャベツなど', '2025-03-25 03:38:35', '2025-03-25 03:38:35'),
(260, '2025-03-25', 940, 1, 'ファミマ おにぎり', '2025-03-25 03:38:50', '2025-03-25 03:38:50'),
(261, '2025-03-26', 18800, 5, 'Amazon keycronキーボード', '2025-03-26 04:49:36', '2025-03-26 04:49:36'),
(262, '2025-03-26', 940, 1, 'ファミマ おにぎり', '2025-03-26 04:49:55', '2025-03-26 04:49:55'),
(263, '2025-03-26', 430, 1, 'ファミマ ぷっちょ', '2025-03-26 04:50:13', '2025-03-26 04:50:25'),
(264, '2025-03-26', 1880, 1, 'コーヨー りんごとバナナとヨーグルト等', '2025-03-26 04:50:43', '2025-03-26 04:50:43'),
(265, '2025-03-28', 1767, 1, 'コーヨー りんごとバナナとヨーグルト等', '2025-03-27 20:26:15', '2025-03-27 20:26:15'),
(266, '2025-03-27', 850, 1, 'コーヨー 白菜・キャベツ等', '2025-03-27 20:27:11', '2025-03-27 20:27:11'),
(267, '2025-03-27', 994, 1, 'ファミマ グミ・おにぎり', '2025-03-27 20:27:40', '2025-03-27 20:27:40'),
(268, '2025-03-28', 1100, 5, 'コインランドリー', '2025-03-27 20:28:50', '2025-03-27 20:28:50'),
(269, '2025-03-29', 1354, 1, 'コーヨー りんごとバナナ、トリスハイボール等', '2025-03-28 20:27:19', '2025-03-28 20:27:19'),
(270, '2025-03-31', 2520, 1, 'Amazon おからクッキー', '2025-03-30 19:22:40', '2025-03-30 19:22:40'),
(271, '2025-03-28', 400, 1, 'コーヨー 水', '2025-03-30 21:26:56', '2025-03-30 21:26:56'),
(272, '2025-03-30', 830, 1, 'サンディ お菓子と角ハイボール', '2025-03-30 23:35:46', '2025-03-30 23:35:46'),
(273, '2024-12-28', 1325, 2, 'DAISO ランチョンマット等', '2025-03-30 23:36:24', '2025-03-30 23:36:24'),
(274, '2025-03-31', 1763, 1, 'コーヨー りんごとバナナとヨーグルト等', '2025-03-31 03:38:46', '2025-03-31 03:38:46'),
(275, '2025-04-02', 594, 1, 'ファミマ おにぎり', '2025-04-02 01:19:22', '2025-04-02 01:19:22'),
(276, '2025-04-02', 1022, 1, 'コーヨー キャベツなど', '2025-04-02 01:19:41', '2025-04-02 01:19:41'),
(277, '2025-04-02', 5860, 5, 'Amazon トイレットペーパー、軟膏、チーズスープ', '2025-04-02 06:09:03', '2025-04-02 06:09:03'),
(278, '2025-04-04', 1814, 1, 'コーヨー りんごとハイボールとヨーグルト', '2025-04-04 04:09:59', '2025-04-04 04:09:59'),
(279, '2025-04-04', 4856, 1, 'Amazon ドリップコーヒーとフロス', '2025-04-04 04:10:57', '2025-04-04 04:10:57'),
(280, '2025-04-06', 1062, 5, 'Amazon キーボードケース', '2025-04-05 21:41:17', '2025-04-05 21:41:17'),
(281, '2025-04-05', 1800, 1, 'コーヨー りんごとバナナとヨーグルト等', '2025-04-05 21:41:33', '2025-04-05 21:41:33'),
(282, '2025-04-06', 3456, 1, 'Amazon ふりかけと辛スープ', '2025-04-06 05:58:47', '2025-04-06 05:58:47'),
(283, '2025-04-07', 2650, 1, 'コーヨー バナナとヨーグルト', '2025-04-07 02:40:28', '2025-04-07 02:40:28'),
(284, '2025-04-08', 794, 1, 'ファミマ おにぎり', '2025-04-08 01:50:07', '2025-04-08 01:50:07'),
(285, '2025-04-08', 499, 1, 'ファミマ グミ', '2025-04-08 01:50:19', '2025-04-08 01:50:19'),
(286, '2025-04-08', 1499, 1, 'ファミマ お酒', '2025-04-08 01:50:42', '2025-04-08 01:50:42'),
(287, '2025-04-08', 1280, 5, 'Amazon ハミガキ粉', '2025-04-08 02:32:00', '2025-04-08 02:32:00'),
(288, '2025-04-09', 845, 1, 'コーヨー キャベツなど', '2025-04-09 05:26:55', '2025-04-09 05:26:55'),
(289, '2025-04-09', 1200, 1, 'ファミマ おにぎり', '2025-04-09 05:27:09', '2025-04-09 05:27:09'),
(290, '2025-04-12', 952, 1, 'コーヨー バナナとヨーグルト等', '2025-04-11 23:09:55', '2025-04-11 23:09:55'),
(291, '2025-04-16', 1573, 1, 'コーヨー りんごとバナナとヨーグルト等', '2025-04-16 00:22:52', '2025-04-16 00:22:52'),
(292, '2025-04-17', 1429, 1, 'コーヨー りんごとバナナとヨーグルト等', '2025-04-16 20:00:34', '2025-04-16 20:00:34'),
(293, '2025-04-16', 883, 1, 'コーラZERO等', '2025-04-16 20:01:11', '2025-04-16 20:01:11'),
(294, '2025-04-18', 2515, 1, 'りんごとヨーグル等', '2025-04-17 22:52:37', '2025-04-17 22:52:37'),
(295, '2025-04-20', 3215, 1, 'コーヨー お肉', '2025-04-20 03:36:11', '2025-04-20 03:36:11'),
(296, '2025-04-09', 413, 1, 'ファミマ ぷっちょ', '2025-04-20 03:36:57', '2025-04-20 03:36:57'),
(297, '2025-04-16', 3777, 2, 'ココカラファイン ひげそりとマスク', '2025-04-20 03:39:12', '2025-04-20 03:39:12'),
(298, '2025-04-21', 2599, 1, 'コーヨー バナナとヨーグルト', '2025-04-20 19:31:32', '2025-04-20 19:31:32'),
(299, '2025-04-21', 1303, 2, 'コクミン 風呂洗剤', '2025-04-20 19:32:00', '2025-04-20 19:32:00'),
(300, '2025-04-22', 347, 2, '洗浄タブレットとウィスキー', '2025-04-22 00:29:41', '2025-04-22 00:29:41'),
(301, '2025-04-22', 944, 1, 'コーヨー ヨーグルトと水', '2025-04-22 00:30:11', '2025-04-22 00:30:11'),
(302, '2025-04-22', 1500, 1, 'ファミマ おにぎりとグミ', '2025-04-22 00:30:29', '2025-04-22 00:30:29'),
(303, '2025-04-23', 220, 2, 'CanDo ランチョンマット', '2025-04-23 01:38:57', '2025-04-23 01:38:57'),
(304, '2025-04-23', 1814, 1, 'コーヨー お肉と野菜', '2025-04-23 01:39:17', '2025-04-23 01:39:30'),
(305, '2025-04-23', 834, 1, 'ファミマ グミ', '2025-04-23 01:39:51', '2025-04-23 01:39:51'),
(306, '2025-04-25', 597, 1, 'ファミマ グミ', '2025-04-25 04:08:40', '2025-04-25 04:08:40'),
(307, '2025-04-25', 1054, 1, 'コーヨー りんごとハイボール等', '2025-04-25 04:09:29', '2025-04-25 04:09:29'),
(308, '2025-04-26', 1758, 1, 'ココカラファイン ウィスキー', '2025-04-25 22:09:07', '2025-04-25 22:09:07'),
(309, '2025-04-26', 1136, 1, 'コーヨー りんごとバナナとヨーグルト等', '2025-04-25 22:09:44', '2025-04-25 22:09:44'),
(310, '2025-04-27', 1250, 1, '寿司セット等', '2025-04-26 15:04:08', '2025-04-26 15:04:08'),
(311, '2025-04-28', 2394, 1, 'コーヨー バナナとヨーグルト', '2025-04-28 03:19:16', '2025-04-28 03:19:16'),
(312, '2025-04-28', 627, 1, 'ファミマ サイダー系', '2025-04-28 03:19:42', '2025-04-28 03:19:42'),
(313, '2025-04-28', 5900, 5, 'Amazon macキーボードケース', '2025-04-28 13:58:26', '2025-04-28 13:58:26'),
(314, '2025-04-29', 1101, 1, 'コーヨー もやしとシャウエッセン', '2025-04-28 17:03:21', '2025-04-28 17:03:21'),
(315, '2025-04-30', 924, 1, NULL, '2025-04-29 21:37:39', '2025-04-29 21:37:39'),
(316, '2025-05-01', 2447, 1, NULL, '2025-05-01 00:55:16', '2025-05-01 00:55:16'),
(317, '2025-05-03', 1485, 5, 'Amazon kindle', '2025-05-02 14:48:40', '2025-05-02 21:40:12'),
(318, '2025-05-03', 2462, 2, 'Amazon', '2025-05-02 14:49:47', '2025-05-02 14:49:47'),
(319, '2025-05-03', 2094, 1, 'コーヨー バナナとヨーグルト', '2025-05-02 21:38:37', '2025-05-02 21:38:37'),
(320, '2025-05-03', 540, 1, 'コメダ アイスコーヒー', '2025-05-02 21:38:59', '2025-05-02 21:38:59'),
(321, '2025-05-04', 1354, 1, 'コーヨー もやしとウィンナー等', '2025-05-03 22:11:24', '2025-05-03 22:11:24'),
(322, '2025-05-04', 346, 1, 'サンディ ダイエットコーラ', '2025-05-03 22:11:49', '2025-05-03 22:11:49'),
(323, '2025-05-04', 658, 1, 'ココカラファイン アルコール', '2025-05-03 23:04:46', '2025-05-03 23:04:46'),
(324, '2025-05-04', 924, 2, 'サンディ アルコールティッシュ等', '2025-05-03 23:05:31', '2025-05-03 23:05:31'),
(325, '2025-05-05', 581, 1, 'コーヨー もやし等', '2025-05-04 21:47:04', '2025-05-04 21:47:04'),
(326, '2025-05-06', 1395, 1, 'コーヨー バナナとヨーグルト', '2025-05-05 20:29:29', '2025-05-05 20:29:29'),
(327, '2025-05-07', 2340, 5, 'Amazon ダイエットとお茄子汁', '2025-05-06 17:26:22', '2025-05-06 17:26:22'),
(328, '2025-05-07', 899, 1, 'コーヨー りんごとバナナとヨーグルト等', '2025-05-07 01:18:11', '2025-05-07 01:18:11'),
(329, '2025-05-07', 8592, 5, 'Amazon クナイプ・マンナンライフ・時計ベルト', '2025-05-07 02:26:19', '2025-05-07 02:26:19'),
(330, '2025-05-08', 874, 1, 'ファミマ おにぎり', '2025-05-07 18:03:20', '2025-05-07 18:03:20'),
(331, '2025-05-08', 261, 1, 'ファミマ グミ', '2025-05-07 19:06:16', '2025-05-07 19:06:16'),
(332, '2025-05-08', 3980, 1, 'Amazon りんご', '2025-05-07 19:55:17', '2025-05-07 19:55:17'),
(333, '2025-05-08', 1567, 1, 'コーヨー バナナとヨーグルト', '2025-05-08 01:44:18', '2025-05-08 01:44:18'),
(334, '2025-05-08', 990, 5, 'Amazon kindle本 思考の5分間ドリル', '2025-05-08 01:48:33', '2025-05-08 01:48:33'),
(335, '2025-05-08', 1871, 5, 'Amazon kindle本 構造化', '2025-05-08 03:55:59', '2025-05-08 03:55:59'),
(336, '2025-05-10', 591, 1, 'コーヨー トリスハイボールともやし', '2025-05-09 22:40:14', '2025-05-09 22:40:14'),
(337, '2025-05-10', 2956, 1, 'Amazon コーヒーとふりかけ', '2025-05-09 22:40:54', '2025-05-09 22:40:54'),
(338, '2025-05-11', 985, 1, 'コーヨー ウィンナー', '2025-05-10 19:46:12', '2025-05-10 19:46:12');

-- --------------------------------------------------------

--
-- テーブルの構造 `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- ダンプしたテーブルのインデックス
--

--
-- テーブルのインデックス `amazon_usage_history`
--
ALTER TABLE `amazon_usage_history`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- テーブルのインデックス `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`code`);

--
-- テーブルのインデックス `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- テーブルのインデックス `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- テーブルのインデックス `spendings`
--
ALTER TABLE `spendings`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- ダンプしたテーブルの AUTO_INCREMENT
--

--
-- テーブルの AUTO_INCREMENT `amazon_usage_history`
--
ALTER TABLE `amazon_usage_history`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- テーブルの AUTO_INCREMENT `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- テーブルの AUTO_INCREMENT `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `spendings`
--
ALTER TABLE `spendings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=339;

--
-- テーブルの AUTO_INCREMENT `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
