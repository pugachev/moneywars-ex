-- phpMyAdmin SQL Dump
-- version 5.2.1-1.el7.remi
-- https://www.phpmyadmin.net/
--
-- ホスト: localhost
-- 生成日時: 2025 年 1 月 25 日 09:55
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
(114, '2025-01-24', 1013, 1, 'りんごとヨーグルト', '2025-01-24 12:05:07', '2025-01-24 12:05:07');

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=115;

--
-- テーブルの AUTO_INCREMENT `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
