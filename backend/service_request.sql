-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Oct 23, 2019 at 02:29 PM
-- Server version: 10.1.37-MariaDB
-- PHP Version: 7.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `service_request`
--

-- --------------------------------------------------------

--
-- Table structure for table `company_has_contractor_users`
--

CREATE TABLE `company_has_contractor_users` (
  `company_user_id` bigint(20) UNSIGNED NOT NULL,
  `contractor_user_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `company_has_contractor_users`
--

INSERT INTO `company_has_contractor_users` (`company_user_id`, `contractor_user_id`) VALUES
(11, 3);

-- --------------------------------------------------------

--
-- Table structure for table `company_has_users`
--

CREATE TABLE `company_has_users` (
  `company_user_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `company_has_users`
--

INSERT INTO `company_has_users` (`company_user_id`, `user_id`) VALUES
(11, 14),
(11, 17),
(17, 18),
(11, 21);

-- --------------------------------------------------------

--
-- Table structure for table `company_users`
--

CREATE TABLE `company_users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0 = Inactive, 1 = Active',
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stripe_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `card_brand` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `card_last_four` varchar(4) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `trial_ends_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `company_users`
--

INSERT INTO `company_users` (`id`, `email`, `password`, `slug`, `status`, `remember_token`, `stripe_id`, `card_brand`, `card_last_four`, `trial_ends_at`, `deleted_at`, `created_at`, `updated_at`) VALUES
(11, 'develop@yopmail.com', '$2y$10$ZLzZ1jBohWIAoQoOgNR2DOLpPJZdsscVHruNku.eWWCW.My93PsCi', 'dasdas', 1, 'G6hlkrpA2SZhgfKmHu8Q02QkPobusj0gqHIAX6oyI6PjxPv250IlHou9I1HX', 'cus_FKZgUOGgqeVFRS', 'Visa', '4242', NULL, NULL, '2019-06-27 04:38:58', '2019-07-31 07:46:23'),
(14, 'ddd@yopmail.com', '$2y$10$ZLzZ1jBohWIAoQoOgNR2DOLpPJZdsscVHruNku.eWWCW.My93PsCi', '', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2019-06-28 07:25:08', '2019-07-29 00:24:25'),
(15, 'rsgrgs@gjkfdjg.gfdsgfd', '$2y$10$5jObKq8UuiLaHx/nO84yvu3QviwQyGBWuQZptGl6XACMSGZrmCxf6', 'testtttt', 0, 'Fmw2fAwvdSy2Hz8GTTteJsSGGzJruGZ3tl0', 'cus_FL07Rd5pZ6Xu9n', 'Visa', '4242', NULL, NULL, '2019-06-28 07:58:13', '2019-06-28 07:58:17'),
(16, 'testr@yopmail.com', '$2y$10$xPpkeBXjVOO6jZINAEkLjeNi30dd0aT8vaGWKpDApOU5foHmoK6ka', 'testett', 0, 'qa11aQU17DF9FjBzqNLhlZtiIxjxV59TdO7', 'cus_FPqZTxP5tcrZXJ', 'MasterCard', '5454', NULL, NULL, '2019-07-11 06:26:09', '2019-07-11 06:26:13'),
(17, 'sitea@yopmail.com', '$2y$10$OadhIvk0y8a/NV.889o3YuOPsDsYhbdBrwbpvheWCIhy5f8WPmr/q', '', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2019-07-13 07:35:00', '2019-07-27 00:09:51'),
(18, 'sites@yopmail.com', '$2y$10$SV665Cf58hqUQeaNGe1xluChG2KgbLCh68MSSJ.n9Fq6tbLmszRZS', '', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2019-07-13 07:37:45', '2019-07-13 08:20:58'),
(19, 'te120@yopmail.com', '$2y$10$t6bNdTdW.11HIhLZ1xEYQO6tOlF8gqA3DkS3WVLk1a0XN2.XSHcQu', 'test1', 0, '6JagJQ04hJUC5PlXRUgEegAqj6Mbzg8f2W4', 'cus_FQdUOQ2kRu9W6p', 'Visa', '4242', NULL, NULL, '2019-07-13 08:59:15', '2019-07-13 08:59:20'),
(21, 'site-admin@yopmail.com', '$2y$10$hbaHeYrjAufI504Qj3lOx.IYfOLvqLrFX.WXKS4DkyConx10zzsxW', '', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2019-07-26 09:04:41', '2019-07-27 00:09:56'),
(22, 'coadmin@yopmail.com', '$2y$10$vj6SwrbgXD/u486HiTN.kOJ1ELrpGsZ/TKAOpT.nu/aEpeilMeW4G', 'company-admin-1', 1, 'hTlvcwqKsXJLV7JORbCoClYIDBlQT6Qg7Z56Txv3FRT56WIWOoNXA16pVg7g', 'cus_FWVxOwxTuPJraz', 'Visa', '4242', NULL, NULL, '2019-07-29 01:35:32', '2019-07-29 01:36:47');

-- --------------------------------------------------------

--
-- Table structure for table `contractor_has_users`
--

CREATE TABLE `contractor_has_users` (
  `contractor_user_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `contractor_has_users`
--

INSERT INTO `contractor_has_users` (`contractor_user_id`, `user_id`) VALUES
(3, 4);

-- --------------------------------------------------------

--
-- Table structure for table `contractor_users`
--

CREATE TABLE `contractor_users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0 = Inactive, 1 = Active',
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'contractor',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `contractor_users`
--

INSERT INTO `contractor_users` (`id`, `email`, `password`, `status`, `remember_token`, `type`, `deleted_at`, `created_at`, `updated_at`) VALUES
(3, 'contract@yopmail.com', '$2y$10$NeVKbx6fRGgKtcOXZxt76eSdpvnhcR.Tuwx.sehd30kWUphwnBZ5S', 1, NULL, 'contractor', NULL, '2019-07-26 06:13:55', '2019-07-26 06:13:55'),
(4, 'cstaff@yopmail.com', '$2y$10$BgRWxZ8VCQ4shDjxDZwx7u4PsdeIjMk0k7rHNeZfdRrxqGJbth2Sa', 1, NULL, 'contractor', NULL, '2019-07-26 06:29:56', '2019-07-26 07:40:37');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2016_06_01_000001_create_oauth_auth_codes_table', 2),
(4, '2016_06_01_000002_create_oauth_access_tokens_table', 2),
(5, '2016_06_01_000003_create_oauth_refresh_tokens_table', 2),
(6, '2016_06_01_000004_create_oauth_clients_table', 2),
(7, '2016_06_01_000005_create_oauth_personal_access_clients_table', 2),
(8, '2019_06_05_121040_create_permission_tables', 3),
(10, '2019_06_07_062237_create_contractor_users_table', 4),
(12, '2017_10_08_000001_create_oauth_access_token_providers_table', 5),
(14, '2019_06_07_062513_create_company_has_contractor_users_table', 6),
(16, '2019_06_07_062554_create_contractor_has_users_table', 6),
(18, '2019_06_07_063645_create_subscription_plans_table', 6),
(19, '2019_06_07_064030_create_user_subscriptions_table', 6),
(20, '2019_06_07_064745_create_transactions_table', 6),
(21, '2019_06_07_070233_create_user_invites_table', 6),
(22, '2019_06_07_070708_create_settings_table', 6),
(26, '2019_06_07_075134_create_work_priorities_table', 6),
(28, '2019_06_19_105601_create_user_profiles_table', 8),
(29, '2019_06_07_070840_create_site_locations_table', 9),
(30, '2019_06_07_071310_create_work_categories_table', 9),
(33, '2019_06_07_062446_create_company_has_users_table', 10),
(34, '2019_06_20_054217_create_subscriptions_table', 10),
(35, '2019_06_07_061253_create_company_users_table', 11),
(39, '2019_06_07_071355_create_work_orders_table', 12),
(40, '2019_06_07_075304_create_work_tasks_table', 12),
(42, '2019_07_16_142553_create_work_task_comments_table', 13),
(43, '2019_07_16_075502_create_work_parts_table', 14),
(44, '2019_07_24_092225_create_task_images_table', 15);

-- --------------------------------------------------------

--
-- Table structure for table `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` int(10) UNSIGNED NOT NULL,
  `model_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `model_has_permissions`
--

INSERT INTO `model_has_permissions` (`permission_id`, `model_type`, `model_id`) VALUES
(1, 'App\\Models\\ContractorUser', 3),
(1, 'App\\Models\\ContractorUser', 4),
(1, 'App\\Models\\CompanyUser', 11),
(1, 'App\\Models\\CompanyUser', 14),
(1, 'App\\Models\\CompanyUser', 15),
(1, 'App\\Models\\CompanyUser', 18),
(1, 'App\\Models\\CompanyUser', 21),
(2, 'App\\Models\\ContractorUser', 3),
(2, 'App\\Models\\ContractorUser', 4),
(2, 'App\\Models\\CompanyUser', 11),
(2, 'App\\Models\\CompanyUser', 14),
(2, 'App\\Models\\CompanyUser', 15),
(2, 'App\\Models\\CompanyUser', 17),
(2, 'App\\Models\\CompanyUser', 18),
(2, 'App\\Models\\CompanyUser', 21),
(3, 'App\\Models\\ContractorUser', 3),
(3, 'App\\Models\\ContractorUser', 4),
(3, 'App\\Models\\CompanyUser', 11),
(3, 'App\\Models\\CompanyUser', 14),
(3, 'App\\Models\\CompanyUser', 17),
(3, 'App\\Models\\CompanyUser', 21);

-- --------------------------------------------------------

--
-- Table structure for table `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` int(10) UNSIGNED NOT NULL,
  `model_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, 'App\\Models\\User', 1),
(2, 'App\\Models\\CompanyUser', 1),
(2, 'App\\Models\\CompanyUser', 3),
(2, 'App\\Models\\CompanyUser', 4),
(2, 'App\\Models\\CompanyUser', 6),
(2, 'App\\Models\\CompanyUser', 7),
(2, 'App\\Models\\CompanyUser', 8),
(2, 'App\\Models\\CompanyUser', 9),
(2, 'App\\Models\\CompanyUser', 10),
(2, 'App\\Models\\CompanyUser', 11),
(2, 'App\\Models\\CompanyUser', 15),
(2, 'App\\Models\\CompanyUser', 16),
(2, 'App\\Models\\CompanyUser', 19),
(2, 'App\\Models\\CompanyUser', 22),
(3, 'App\\Models\\CompanyUser', 2),
(3, 'App\\Models\\CompanyUser', 14),
(4, 'App\\Models\\ContractorUser', 3),
(5, 'App\\Models\\ContractorUser', 2),
(5, 'App\\Models\\ContractorUser', 4),
(6, 'App\\Models\\SiteUser', 1),
(6, 'App\\Models\\CompanyUser', 17),
(6, 'App\\Models\\CompanyUser', 20),
(6, 'App\\Models\\CompanyUser', 21),
(7, 'App\\Models\\SiteUser', 2),
(7, 'App\\Models\\CompanyUser', 18);

-- --------------------------------------------------------

--
-- Table structure for table `oauth_access_tokens`
--

CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_access_tokens`
--

INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
('000559654a3a39878d2de40ba9a6458d3bea5b98034253ab7350a394e10ffdff40af536065e7ee81', 11, 3, 'Secret Token', '[]', 0, '2019-10-16 07:21:47', '2019-10-16 07:21:47', '2020-10-16 12:51:47'),
('004f0769a88393847916faa2592559e8b81f7b880fb8cdd25f30efa41898c039ad0e55daf8918466', 11, 2, 'Secret Token', '[]', 0, '2019-07-27 01:26:53', '2019-07-27 01:26:53', '2020-07-27 06:56:53'),
('010705f20cdf021f3de198f41665e5629d2f49cd24a296d81dc7a980836999cdfff2b0b494a22399', 21, 2, 'Secret Token', '[]', 0, '2019-08-05 04:22:38', '2019-08-05 04:22:38', '2020-08-05 09:52:38'),
('015bf62377ff72f97bfc855661b826b9114b0bc325fb43586d1ba501234e5b2e782abb611a19766b', 11, 3, 'Secret Token', '[]', 0, '2019-10-17 04:38:29', '2019-10-17 04:38:29', '2020-10-17 10:08:29'),
('0315649d5f05aa7d063ce0a65ce8e6ad56176d327c2fa317fd40c54919fed555f796798462973f5d', 11, 2, 'Secret Token', '[]', 0, '2019-07-09 05:04:06', '2019-07-09 05:04:06', '2020-07-09 10:34:06'),
('038b931cb97fb259ac4798c30727b8fc30adcecfb03045159b457cff6c0f459a0fe158c562543f90', 2, 2, 'Secret Token', '[]', 0, '2019-07-26 02:18:05', '2019-07-26 02:18:05', '2020-07-26 07:48:05'),
('03dde96c9f2346efd1febb4b80fe46894e10f0ad1b880e8f262503faabf5059724bd094da371588d', 11, 3, 'Secret Token', '[]', 0, '2019-10-23 04:26:54', '2019-10-23 04:26:54', '2020-10-23 09:56:54'),
('043dec65ecc170f8b8722c39ba74cfc37719354697e43fbec864664304062642afc31ab2b256635d', 11, 3, 'Secret Token', '[]', 0, '2019-09-30 02:50:06', '2019-09-30 02:50:06', '2020-09-30 08:20:06'),
('04552a7e6640d25e87dde9e4a433894f422b394d8a8482fb46d305bd982706f8a10c34df6911cf92', 11, 3, 'Secret Token', '[]', 0, '2019-10-22 01:45:34', '2019-10-22 01:45:34', '2020-10-22 07:15:34'),
('050201f31d54c9a82b83a04fa98b3eac087fbddc2436a417ab356bd8bd857d05001b2cf3be565605', 1, 2, 'Secret Token', '[]', 0, '2019-06-26 00:15:09', '2019-06-26 00:15:09', '2020-06-26 05:45:09'),
('0700cb3edaf22b1567b2041ed50c7caaf43232b7a951f8277e47fa98dd636f595f050d8f09c91d9b', 1, 2, 'Secret Token', '[]', 0, '2019-06-18 01:49:50', '2019-06-18 01:49:50', '2020-06-18 07:19:50'),
('08b912887bb189e9fc86c7ccd3499031b460ac014f88f9055584e9d288a32de7fa41885ffb868094', 1, 2, 'Secret Token', '[]', 0, '2019-07-27 01:17:19', '2019-07-27 01:17:19', '2020-07-27 06:47:19'),
('09052eba2f39ea8497be155cdf4b400d412d3cc4a96baf3b00a0e2ab84de2ea9f0f075dfd5a267b4', 1, 2, 'Secret Token', '[]', 0, '2019-07-25 06:09:16', '2019-07-25 06:09:16', '2020-07-25 11:39:16'),
('090a1c1c7fc88fdba25bf68c15a104a7ff284a3d8e75a9a75c193a2c011cdfcce34e8eacf506fe4d', 11, 2, 'Secret Token', '[]', 0, '2019-07-09 04:34:47', '2019-07-09 04:34:47', '2020-07-09 10:04:47'),
('09cfece0202203127121459a36b4ababb2307ff86dee982f2d7510999152ee1095cc21a700ca02bd', 11, 3, 'Secret Token', '[]', 0, '2019-10-15 04:43:13', '2019-10-15 04:43:13', '2020-10-15 10:13:13'),
('0a71f36ccf1aba96899211ce4147947346f692dc249ad1de72a4da5ea658df3fcc15433a50116f55', 1, 2, 'Secret Token', '[]', 0, '2019-07-25 08:51:57', '2019-07-25 08:51:57', '2020-07-25 14:21:57'),
('0b55d294d939d5e2899b932eebb56dd4ff22b131ca3192c8f93dea313471cbe3383c271ceae9b36c', 2, 2, 'Secret Token', '[]', 0, '2019-07-13 07:18:52', '2019-07-13 07:18:52', '2020-07-13 12:48:52'),
('0bd4ffb8dbde0ba540335b46d6254f257c43132c0a35bb7c699ef0b54db301052f17f14996039eeb', 1, 2, 'Secret Token', '[]', 0, '2019-07-13 08:22:28', '2019-07-13 08:22:28', '2020-07-13 13:52:28'),
('0c3a77040552970949db720e17e4f85dd1102926c919e1c8883d77f389daa34ee601f17927792531', 1, 2, 'Secret Token', '[]', 0, '2019-06-26 00:32:48', '2019-06-26 00:32:48', '2020-06-26 06:02:48'),
('0dc377001b8aa74edf6a3e08e29dc08ccde879d96b293ecf2ecfa3968df1472c516bc206b7f8ef62', 11, 2, 'Secret Token', '[]', 0, '2019-08-02 01:30:40', '2019-08-02 01:30:40', '2020-08-02 07:00:40'),
('0de5054b27c3172f54df58df7937e50c6b6e121092687deac126b241acbadafb584bab423e494ca6', 11, 3, 'Secret Token', '[]', 0, '2019-10-21 05:41:43', '2019-10-21 05:41:43', '2020-10-21 11:11:43'),
('0e59d5e3fc33842a7bab8f101a3556714c54d579aa9128840aeecf29e1b7bae97422b2be34c747ab', 1, 2, 'Secret Token', '[]', 0, '2019-07-12 08:39:43', '2019-07-12 08:39:43', '2020-07-12 14:09:43'),
('1024fb487779fadc301e6b591586742249c5fb361a4b4778e4730dc07e3fd89b6e6e6bf02d30fdea', 11, 2, 'Secret Token', '[]', 0, '2019-07-26 06:12:24', '2019-07-26 06:12:24', '2020-07-26 11:42:24'),
('10bdcad6e079aff6732c83424c6592021758b14d189ee3c19e21c65843565d933621f77509e1d69b', 1, 2, 'Secret Token', '[]', 0, '2019-08-08 00:39:31', '2019-08-08 00:39:31', '2020-08-08 06:09:31'),
('10c77a6ce441f4616f0adaf843d0bd5318368d3fe6fc2ce8b76fc9858c157ca7b380035ef4cdc82e', 12, 2, 'Secret Token', '[]', 0, '2019-06-28 00:39:16', '2019-06-28 00:39:16', '2020-06-28 06:09:16'),
('1205794cad99a08a80d2ad4f0de195c89555f047a38e9b5ebe64df57b3bad80c8295e25457f6d70a', 1, 2, 'Secret Token', '[]', 0, '2019-06-25 08:26:03', '2019-06-25 08:26:03', '2020-06-25 13:56:03'),
('12096b9ee987d2ad10953e60923897e8a5dd5d8f59f69c3127e3c943f81e887dbbe0dfc57c374d07', 1, 2, 'Secret Token', '[]', 0, '2019-07-26 00:33:29', '2019-07-26 00:33:29', '2020-07-26 06:03:29'),
('1298ff292944ba6f7ef941723ee9ad128df558b4bebc8d1a58c827f049677fb9af26d3861156495d', 3, 3, 'Secret Token', '[]', 0, '2019-10-21 01:23:16', '2019-10-21 01:23:16', '2020-10-21 06:53:16'),
('133b67b681d4712d0ae030cfd56647b16f385859ddd22706366762bdf71a4e6defa2bec3aeecc7e2', 1, 3, 'Secret Token', '[]', 0, '2019-10-22 04:25:56', '2019-10-22 04:25:56', '2020-10-22 09:55:56'),
('135a95dc43e066d0fef68fc291f1493a303ccfe7bab3513ac1ffd4e385fe57b6ef001b5a35bdb755', 3, 2, 'Secret Token', '[]', 0, '2019-07-26 06:26:05', '2019-07-26 06:26:05', '2020-07-26 11:56:05'),
('14db95712a7b9b39871aaad4ca5ec47592fe3a122caa5d44cbfd3a6aac02dff212f91b5e318d00ab', 21, 3, 'Secret Token', '[]', 0, '2019-10-21 04:41:14', '2019-10-21 04:41:14', '2020-10-21 10:11:14'),
('15e08746e1c6915e28cc5945d7cbf8b3e91d2c7cce2e10a781ad50d52d33443361ecdc4e5b612161', 1, 2, 'Secret Token', '[]', 0, '2019-06-11 04:04:36', '2019-06-11 04:04:36', '2020-06-11 09:34:36'),
('160471a5940472b2a0348cd719a6e7b13b1ea1ec92f340cb6d6b032e2dd5ef8b484466e7cfd5de5a', 11, 2, 'Secret Token', '[]', 0, '2019-07-27 01:26:52', '2019-07-27 01:26:52', '2020-07-27 06:56:52'),
('16895ae01fc9f847ddf49021d17c4c1997ef49db0d2c1fc7ec7bcb7ea8f97f1e83e92f043105a60c', 11, 2, 'Secret Token', '[]', 0, '2019-07-31 06:09:43', '2019-07-31 06:09:43', '2020-07-31 11:39:43'),
('1691b4411cac672e26b75b0341b4146fc6d98c555af0b4b16645d032317f745a66fc4bc6ee58bde0', 11, 2, 'Secret Token', '[]', 0, '2019-07-09 08:45:17', '2019-07-09 08:45:17', '2020-07-09 14:15:17'),
('17156a59189f572bdb612554ff05cb89034d26c2b406a328e791bcc5426db90ed9e6e7b75bee19ed', 11, 2, 'Secret Token', '[]', 0, '2019-07-26 00:30:51', '2019-07-26 00:30:51', '2020-07-26 06:00:51'),
('17690bd26e9106f2c8d95a2981af3fdd2d52bd9f4eb45a12fabefcec8c197f6f98a67d66845806de', 1, 3, 'Secret Token', '[]', 0, '2019-09-23 04:37:40', '2019-09-23 04:37:40', '2020-09-23 10:07:40'),
('17d8466fc2b1bca564c91da4023b6fbfebacb22c9fee4f93ae6c88d0ae85d9a817360437582036f4', 3, 3, 'Secret Token', '[]', 0, '2019-10-21 05:21:51', '2019-10-21 05:21:51', '2020-10-21 10:51:51'),
('185eb3c6b0743bbbee037d6eb878c38336b6daa0d68c181d707e70a70607f745aaccdc3e31623182', 11, 2, 'Secret Token', '[]', 0, '2019-07-27 01:09:26', '2019-07-27 01:09:26', '2020-07-27 06:39:26'),
('186783692858c7fe0b36c3bee245eea74a05dcd9f26dd1655ed10f3a58568f4a629874c314847885', 3, 3, 'Secret Token', '[]', 0, '2019-10-15 04:29:30', '2019-10-15 04:29:30', '2020-10-15 09:59:30'),
('18b2f6539b86d367c3ee47006e8e9d7a678871d221e8cfe809eefd312816a4ceb022fe5b0339851b', 11, 2, 'Secret Token', '[]', 0, '2019-07-29 04:45:38', '2019-07-29 04:45:38', '2020-07-29 10:15:38'),
('1ae0969b7904d4972563884033928fdda91051e2212d5372a94723077ba49808dccd0860b448def7', 11, 2, 'Secret Token', '[]', 0, '2019-08-08 00:59:43', '2019-08-08 00:59:43', '2020-08-08 06:29:43'),
('1b305f8ff6f15cea0b9b244efa77803c4844d73b012f96d2559520278a0decf7aaaaca65727204ad', 1, 3, 'Secret Token', '[]', 0, '2019-10-23 05:44:25', '2019-10-23 05:44:25', '2020-10-23 11:14:25'),
('1b3114442767d9c74f44d96a499abec19a5d7b2e4728eee4630830348bd6aaeeaf74f942d0fb6eec', 3, 2, 'Secret Token', '[]', 0, '2019-06-27 23:45:01', '2019-06-27 23:45:01', '2020-06-28 05:15:01'),
('1c52a2c4d63f04dcbc77905d4a3d540d4332494a747676d4d994c7e37a309e8b1e56b312c638ca5c', 1, 2, 'Secret Token', '[]', 0, '2019-06-25 01:15:49', '2019-06-25 01:15:49', '2020-06-25 06:45:49'),
('1c982295a438da07bc7807bfdb2e9bc094bf1c7811ecad038d73bdd7d28c4b50f3fec04c7d8f73b2', 11, 2, 'Secret Token', '[]', 0, '2019-07-13 07:32:50', '2019-07-13 07:32:50', '2020-07-13 13:02:50'),
('1ddcaf3615a033b0cef1056e3dab12c58632d3654a867954c784271557ba334f571b10bad79fdf4d', 1, 2, 'Secret Token', '[]', 0, '2019-06-11 07:07:52', '2019-06-11 07:07:52', '2020-06-11 12:37:52'),
('1e0548d5502eb0236c12b8d1141fce7a04fb8838847533e01102edeaae22da27913a564829041225', 1, 2, 'Secret Token', '[]', 0, '2019-06-25 08:36:15', '2019-06-25 08:36:15', '2020-06-25 14:06:15'),
('1e72a57f7e83718a1b640e85d206e0eda1d0cb22debef092886920391701ca53d047f6af5707be5d', 1, 2, 'Secret Token', '[]', 0, '2019-07-26 01:38:45', '2019-07-26 01:38:45', '2020-07-26 07:08:45'),
('1e83fd293b1c3713cda9cc4f3c67b1f07ac9856d8af5d17a4a74d62e5c010ee8d8f6e2811d635ee5', 11, 3, 'Secret Token', '[]', 0, '2019-10-23 06:58:47', '2019-10-23 06:58:47', '2020-10-23 12:28:47'),
('1ed28f4ed2b0b6e55d289946d8f3f4583cf5889eca663c18f49901a6111e5a7c4dbdfcdda5d021b8', 1, 3, 'Secret Token', '[]', 0, '2019-10-22 00:57:40', '2019-10-22 00:57:40', '2020-10-22 06:27:40'),
('1ee33c55240de7aa10da09d85738e8bbfacf65477c16cf5704dbb44d27a8ca376ae82c6bf211b539', 11, 2, 'Secret Token', '[]', 0, '2019-07-27 01:26:52', '2019-07-27 01:26:52', '2020-07-27 06:56:52'),
('1f81577445225687c59a64b9438be130b1b5b254dc2d67e0735202d24340f1721be064ecdfab089f', 1, 2, 'Secret Token', '[]', 0, '2019-06-26 07:39:34', '2019-06-26 07:39:34', '2020-06-26 13:09:34'),
('1fdaccbe0b2f6505db93c4fa240ec13767d7a6ed7c0c64cae724d0dab1f18f8b6a7b747f5b708da7', 11, 2, 'Secret Token', '[]', 0, '2019-07-29 04:33:18', '2019-07-29 04:33:18', '2020-07-29 10:03:18'),
('1fe6436d9ac128866459c9fe69da0b72c4ee330c7387f887d517a490c9189f31a71126e6b475f045', 21, 3, 'Secret Token', '[]', 0, '2019-10-01 07:44:12', '2019-10-01 07:44:12', '2020-10-01 13:14:12'),
('1ff061cbf8b67f62873e0ce618948bb6ad038db5eec34e74e16dc4ac81c777ddd38f6156c58b1511', 11, 2, 'Secret Token', '[]', 0, '2019-07-26 01:29:55', '2019-07-26 01:29:55', '2020-07-26 06:59:55'),
('20181db7569363f1155316dd1e36ba59d6f4065112d13bf808b59085cbcecb602606ab47205163e4', 1, 3, 'Secret Token', '[]', 0, '2019-10-22 02:16:56', '2019-10-22 02:16:56', '2020-10-22 07:46:56'),
('22b78bfc127c56fec513087ce04fe8a80d515a2c1fe0334b645da33fa64d91e57590404e1e8f6374', 1, 3, 'Secret Token', '[]', 0, '2019-09-24 00:00:59', '2019-09-24 00:00:59', '2020-09-24 05:30:59'),
('232e5fb4c04d951afcb85d7e62e014b1d3cae13bbe5b27eb80e4127a9027a96f5a8e3fa3e66d5eb3', 1, 2, 'Secret Token', '[]', 0, '2019-07-26 06:39:59', '2019-07-26 06:39:59', '2020-07-26 12:09:59'),
('2411ca054ddcfad213e7e2cf06213435c2024fab90dd8fd79ecaddeae6a249a61e2cf1b2b5f0f28a', 1, 2, 'Secret Token', '[]', 0, '2019-06-11 01:43:48', '2019-06-11 01:43:48', '2020-06-11 07:13:48'),
('247ee53bcb14ee390798fb64c517db2d4d000ba5182294e0409ef2caf4a22d6f8703e31877265b68', 1, 2, 'Secret Token', '[]', 0, '2019-06-25 01:01:47', '2019-06-25 01:01:47', '2020-06-25 06:31:47'),
('25ba2a51d49e9b6899762f21990a531973f1fcc23102d4064262cd067bbbef9e9ad716b52f80ac57', 11, 3, 'Secret Token', '[]', 0, '2019-10-15 04:18:55', '2019-10-15 04:18:55', '2020-10-15 09:48:55'),
('25f42d59c42472d47c5c38e7197078919a05795cf308bd4af7832aef84bef4b397791aaa8dc18960', 21, 3, 'Secret Token', '[]', 0, '2019-09-30 05:41:21', '2019-09-30 05:41:21', '2020-09-30 11:11:21'),
('262c4f73df5887331be510ee5f4751a328aec2fef986f3afcb9cc6a07095820fec7b62bbc7506704', 11, 2, 'Secret Token', '[]', 0, '2019-07-27 01:26:51', '2019-07-27 01:26:51', '2020-07-27 06:56:51'),
('264d68e4d00ebe4f077bccc9e91832b43e87642f7405df2fcb7878521783f58c525cf8212ab321d6', 11, 3, 'Secret Token', '[]', 0, '2019-09-23 04:39:20', '2019-09-23 04:39:20', '2020-09-23 10:09:20'),
('264f8de556e55293e3c64f6bef8e0f0850b16306da2a5fde09c4d5c9b0ef9da1fab3bf201e71cd88', 1, 2, 'Secret Token', '[]', 0, '2019-06-11 02:56:51', '2019-06-11 02:56:51', '2020-06-11 08:26:51'),
('26f19c0ec15f0721254ccc85d187580d8d8dabccbaf9fb23a8e2da38175bf580d70fd3cafe6132c5', 3, 2, 'Secret Token', '[]', 0, '2019-06-26 07:41:52', '2019-06-26 07:41:52', '2020-06-26 13:11:52'),
('286805d61ffd350b1c1aebde7fd0781d604d8ae7ad06972437ea028d40509ba08f7d22e634490abf', 1, 2, 'Secret Token', '[]', 0, '2019-07-26 02:02:37', '2019-07-26 02:02:37', '2020-07-26 07:32:37'),
('2aa6ae5ca971efce3f82cb1a375616ea26b5a3b9dc2bb548716349d42a361ab0c47547a7fe8ec01c', 11, 2, 'Secret Token', '[]', 0, '2019-06-28 03:51:36', '2019-06-28 03:51:36', '2020-06-28 09:21:36'),
('2b84e223ee78f1acc5afea154f278542b2371518979591244fe0a3a576997bdb4ca83ba48e996b2e', 17, 2, 'Secret Token', '[]', 0, '2019-07-13 07:35:12', '2019-07-13 07:35:12', '2020-07-13 13:05:12'),
('2bb07e161fb0371c75a2e226f1fcd199939ee78114b28da2181990b083a0a36511dc44fac99d8dcf', 11, 2, 'Secret Token', '[]', 0, '2019-08-08 05:00:26', '2019-08-08 05:00:26', '2020-08-08 10:30:26'),
('2bbb62b0e340939d9ab348ea79c5007f9373e98b85969a20093dbfb03e72416fcbc17ea2382d0de4', 14, 2, 'Secret Token', '[]', 0, '2019-06-28 07:43:20', '2019-06-28 07:43:20', '2020-06-28 13:13:20'),
('2cdccdde8a03d387453dbfb49b830fe88a7faa67484b9ba7b1e55bbe5303634923f96662aba21a90', 1, 2, 'Secret Token', '[]', 0, '2019-06-28 02:35:30', '2019-06-28 02:35:30', '2020-06-28 08:05:30'),
('2ce3737249bba71a167343f5b634bd0195fc58dacc701a587ecf993379e06c7a68d7473bc7d8de56', 1, 2, 'Secret Token', '[]', 0, '2019-06-11 01:41:02', '2019-06-11 01:41:02', '2020-06-11 07:11:02'),
('2d5ff752c5f3d2ea82a895a60799f24a207101dc2e29d3db6e1e7e378bb22ffbd15decda3cec8e57', 3, 2, 'Secret Token', '[]', 0, '2019-06-27 23:42:26', '2019-06-27 23:42:26', '2020-06-28 05:12:26'),
('2e8886afc4e4fe07963832e1cce330920453cad7b65144cb1169e20f3bf3074aa959009c325f62a5', 11, 2, 'Secret Token', '[]', 0, '2019-07-02 07:05:16', '2019-07-02 07:05:16', '2020-07-02 12:35:16'),
('2eb0a058df7fb48db4aa51867a02df3361d0376dba310397def5c0e53c8ab8f3c5b7d8497bf2e999', 3, 2, 'Secret Token', '[]', 0, '2019-06-25 08:42:31', '2019-06-25 08:42:31', '2020-06-25 14:12:31'),
('2fbd4c5229c6db0dba6e76b475cf8088d7e38f47263ae52561549f15a2a828c2449e2425f71415c8', 3, 2, 'Secret Token', '[]', 0, '2019-06-25 08:28:58', '2019-06-25 08:28:58', '2020-06-25 13:58:58'),
('3082cbc226eee68c3dfccb92941d522078f2103b2ad4bdd6d135aeba070c835dfd6b12f3adbf8d67', 1, 2, 'Secret Token', '[]', 0, '2019-06-11 02:53:47', '2019-06-11 02:53:47', '2020-06-11 08:23:47'),
('3098e566cfb42be616873a87ca49cca8e4ee3c673cbe89d6dfcb830aef6986545fefc0e88bbf201f', 11, 3, 'Secret Token', '[]', 0, '2019-10-20 23:24:59', '2019-10-20 23:24:59', '2020-10-21 04:54:59'),
('3161773e694cbc38273bdf5e07dc426de2d3cd001931ea30dc5cc1e70dad862d779aa03a577c3112', 21, 3, 'Secret Token', '[]', 0, '2019-10-15 04:13:52', '2019-10-15 04:13:52', '2020-10-15 09:43:52'),
('321a9703eeb75887f23e41c56aedae6f8f0fb45d3e1b94f0df5d7409d38beb3f78ca5a4a9eab12b1', 1, 2, 'Secret Token', '[]', 0, '2019-06-27 00:58:02', '2019-06-27 00:58:02', '2020-06-27 06:28:02'),
('32b59d7e393981179dc1a761eabbe2ca90e198cf1e2c7207ae36e5e53c398a01feaa6c955ad3d426', 11, 3, 'Secret Token', '[]', 0, '2019-10-23 01:41:16', '2019-10-23 01:41:16', '2020-10-23 07:11:16'),
('3321780e9200a433394d0f332f435cb91bc57a3587f0abc6447ed616f0bc27d9cde6181f00129602', 11, 2, 'Secret Token', '[]', 0, '2019-07-25 06:25:41', '2019-07-25 06:25:41', '2020-07-25 11:55:41'),
('333ecbfd43732889c5ab7991800b24419b1a966357ea614f491716639d9c3db1f8afb3fe78514f68', 11, 2, 'Secret Token', '[]', 0, '2019-08-01 01:07:07', '2019-08-01 01:07:07', '2020-08-01 06:37:07'),
('33746bc4b974b7ce09fd9194de9b22b9318a5fe2519ea1132e9bc2442aaae3529f121450db9806c9', 1, 2, 'Secret Token', '[]', 0, '2019-06-18 03:32:48', '2019-06-18 03:32:48', '2020-06-18 09:02:48'),
('3407d428468e26d66aea5719b7aca336b63f2d767512874717a27f1827362bf60fb3691c2f23e926', 11, 2, 'Secret Token', '[]', 0, '2019-07-13 08:48:14', '2019-07-13 08:48:14', '2020-07-13 14:18:14'),
('354c79d39e7fda866be08cf31a964dc614cd0a87d0ababc1263edf78fbfbc2330bb4accb470da432', 11, 2, 'Secret Token', '[]', 0, '2019-07-27 01:26:55', '2019-07-27 01:26:55', '2020-07-27 06:56:55'),
('37064d3ff52f53de6fc4911215edc1700c0a21ef7b3f1ef6e67986c25a641fc00e018241ec70a4e4', 11, 2, 'Secret Token', '[]', 0, '2019-06-29 01:19:24', '2019-06-29 01:19:24', '2020-06-29 06:49:24'),
('379a787d4171daa0598af8e70c9da1a6f978ba8ee9455c9a3ff2cda401c58c2de09d735b873e86cd', 11, 2, 'Secret Token', '[]', 0, '2019-07-27 03:49:25', '2019-07-27 03:49:25', '2020-07-27 09:19:25'),
('39731ab2cf1cd99587be829f9fef6699ea5f890c589d7972b3eaf1b43f6aa1ad6f3949cb0e138b21', 11, 2, 'Secret Token', '[]', 0, '2019-07-27 01:27:40', '2019-07-27 01:27:40', '2020-07-27 06:57:40'),
('3c84935348dd51fef0f25fa4c568371a1bb09f02dd54bbdd0c60eb679b65cd5e205e921a2f615bb0', 1, 3, 'Secret Token', '[]', 0, '2019-09-30 02:21:23', '2019-09-30 02:21:23', '2020-09-30 07:51:23'),
('3d9ced3b92fd624bec27c38a12f3b97261be34006a735eaf453e4b6dd56f75ad28ac9397438490b8', 1, 2, 'Secret Token', '[]', 0, '2019-06-11 02:52:46', '2019-06-11 02:52:46', '2020-06-11 08:22:46'),
('3de33d23f95100f425d4a9136a1ffa2760a601f68ddaef1c6954fb3241bfd14fba8babd90430b673', 1, 2, 'Secret Token', '[]', 0, '2019-06-11 06:05:52', '2019-06-11 06:05:52', '2020-06-11 11:35:52'),
('3e887f99af700fe56ee3d1be67ec8303faceccaa54a5c6b0efefd3112468af07d86cdbfb67d2b4c3', 11, 3, 'Secret Token', '[]', 0, '2019-10-23 06:37:33', '2019-10-23 06:37:33', '2020-10-23 12:07:33'),
('3ed874cccc9fc51d4d1e16bf14a856f7490a99ee2c3322fbdf4c9c57434d073ef23244011e64d204', 11, 2, 'Secret Token', '[]', 0, '2019-07-26 08:21:33', '2019-07-26 08:21:33', '2020-07-26 13:51:33'),
('3fc9f397b06c35a1c4bfe6a0c12ef7613ba03e231d52cf9ea0cca1c8316c6d644df049230730e3ef', 1, 3, 'Secret Token', '[]', 0, '2019-10-15 03:59:45', '2019-10-15 03:59:45', '2020-10-15 09:29:45'),
('404a6b4d1c0e435e837d7dbd2993d1d252a71358f7e5bb780e75056ac9ec7e3c6e798910761eaf65', 1, 2, 'Secret Token', '[]', 0, '2019-06-28 02:37:13', '2019-06-28 02:37:13', '2020-06-28 08:07:13'),
('406c3c40d4e892d9ba5314222334d6e4ff942606d14cac38eb225da3576af191a5fdd8db2cfd6a36', 11, 3, 'Secret Token', '[]', 0, '2019-09-30 04:14:01', '2019-09-30 04:14:01', '2020-09-30 09:44:01'),
('409a5e4990818673c55dce7de9bc304ad79fb0f921615136eebff0f72720224915288101c1792c68', 3, 2, 'Secret Token', '[]', 0, '2019-06-25 08:43:21', '2019-06-25 08:43:21', '2020-06-25 14:13:21'),
('40de3ef72573a126bc2bf5cc1abe9ff28913adce133e384c407ce57085525d1e7fe3e095ca541a97', 11, 2, 'Secret Token', '[]', 0, '2019-07-03 08:40:27', '2019-07-03 08:40:27', '2020-07-03 14:10:27'),
('416d2ace5de97b940db15524eeca4dcd0686d31f54aff9f6f3e0b8f37f9946cfe61dc556b9c223fc', 21, 2, 'Secret Token', '[]', 0, '2019-07-31 00:30:07', '2019-07-31 00:30:07', '2020-07-31 06:00:07'),
('417635bcdc0f372e6f1847a193f3d86b6b71051332dd51741486ea66f54f287fa665f9822f7cf11b', 11, 2, 'Secret Token', '[]', 0, '2019-07-27 01:26:54', '2019-07-27 01:26:54', '2020-07-27 06:56:54'),
('419bbcd89dd62ed1f11ed1b4780f47024e4dc826a112e450033904f31c6ea1f202e5b759fd692d6b', 1, 2, 'Secret Token', '[]', 0, '2019-06-25 08:30:32', '2019-06-25 08:30:32', '2020-06-25 14:00:32'),
('424c8157e3ff7483bb4fad9c8e48af168c7a36ce2ad7c8354b6f6ebf91e72a5bab8c338048208ceb', 11, 2, 'Secret Token', '[]', 0, '2019-07-26 03:40:32', '2019-07-26 03:40:32', '2020-07-26 09:10:32'),
('426269af2821396fee9f3e7ce9806f55c182668934f75a1b5949073e48857217d9eb040a0e1b57b2', 11, 2, 'Secret Token', '[]', 0, '2019-07-29 00:24:09', '2019-07-29 00:24:09', '2020-07-29 05:54:09'),
('42cb606d59cf74e8bf7c5b0c6c2e07794b5330599a04e7fa0fa419eef2c6824503365c3f14ec5711', 11, 2, 'Secret Token', '[]', 0, '2019-07-24 07:36:00', '2019-07-24 07:36:00', '2020-07-24 13:06:00'),
('431dccb9c939054a71819b3a137e379165ca1af2f6a8e1fc937c7c9cb27c98e155e80d49b3bafbbc', 11, 3, 'Secret Token', '[]', 0, '2019-09-30 02:13:21', '2019-09-30 02:13:21', '2020-09-30 07:43:21'),
('441492041a073c853b83526295c8c43712d99c90df86d3ed8caca7c71c3d2c30344fea6bab70bd0c', 1, 2, 'Secret Token', '[]', 0, '2019-06-25 08:23:34', '2019-06-25 08:23:34', '2020-06-25 13:53:34'),
('44c7cfe7b96cfe277a658060d91848def24fcfba359870491583acab8fb271018cb0d3a7d66a7f96', 21, 2, 'Secret Token', '[]', 0, '2019-07-27 06:40:18', '2019-07-27 06:40:18', '2020-07-27 12:10:18'),
('45798843604d5659c332d88189ff6df93ee069492a3e63c9e189e241c9acd61a9058e3eabf090aa7', 11, 2, 'Secret Token', '[]', 0, '2019-06-29 00:10:09', '2019-06-29 00:10:09', '2020-06-29 05:40:09'),
('465f4159efcfed74662a67a0b46d69f5f5842dbadcba58062e7e2abc3ed241fd79768cc9c3d3c3f8', 11, 2, 'Secret Token', '[]', 0, '2019-07-27 01:26:53', '2019-07-27 01:26:53', '2020-07-27 06:56:53'),
('471e5d24d3f600bae2ddbc2367c50674a349c10ee91b6c1c0f1f0ab577df9e38c86c8175c5b0ff55', 11, 3, 'Secret Token', '[]', 0, '2019-09-23 05:22:38', '2019-09-23 05:22:38', '2020-09-23 10:52:38'),
('4732ac319b463133e2eb10c826fdf04745a76d322c0b8fbfeefac358f33d1d8984945c6aacb39ee6', 3, 2, 'Secret Token', '[]', 0, '2019-06-27 23:50:42', '2019-06-27 23:50:42', '2020-06-28 05:20:42'),
('476aab6ff5b3711d727a2e8a6fcacbb80bf83de5323eadc58801e9c1dd62e0a3951171c1555c6bed', 11, 2, 'Secret Token', '[]', 0, '2019-07-29 07:42:12', '2019-07-29 07:42:12', '2020-07-29 13:12:12'),
('48a562686306af42cc23c04d42fb5b225ada5864d1245361586725394fab2013c6acdc78a46755ed', 21, 2, 'Secret Token', '[]', 0, '2019-07-31 00:14:22', '2019-07-31 00:14:22', '2020-07-31 05:44:22'),
('48b21d2c7de45e80184f43f6a55977be16bbb75902f25006a27b492087e4201692c45721de8e8ddf', 1, 2, 'Secret Token', '[]', 0, '2019-06-11 01:48:07', '2019-06-11 01:48:07', '2020-06-11 07:18:07'),
('48eb51799ff1468361b3dfa8404e3350b894e7a66818805c4f1ac00c62bc24e0811b164c1ea3059b', 1, 3, 'Secret Token', '[]', 0, '2019-09-30 07:55:09', '2019-09-30 07:55:09', '2020-09-30 13:25:09'),
('492081f4232255ef56d29c18b25469e01d48f0e0e618c4a10a835b23084db4c3a722795a557a4e7c', 11, 2, 'Secret Token', '[]', 0, '2019-07-25 07:38:37', '2019-07-25 07:38:37', '2020-07-25 13:08:37'),
('4aaa9cc739721b69c8ede3ef19e11d2cb97bddb27aa60cfcdf567d4783e2f0d3545456cd2b4717df', 11, 3, 'Secret Token', '[]', 0, '2019-10-17 04:39:07', '2019-10-17 04:39:07', '2020-10-17 10:09:07'),
('4abb7146fd892c3c4e65831638befa4da0f832d3876b4b83c4d8b912125e25726a180b00b88afc4a', 21, 3, 'Secret Token', '[]', 0, '2019-10-22 00:29:11', '2019-10-22 00:29:11', '2020-10-22 05:59:11'),
('4ad2e993e25397e722ab9676c7e9c8e3dfe9a803c83ab1db90bcf658cb171c2a7dc7b9dfcf27b5e7', 1, 3, 'Secret Token', '[]', 0, '2019-09-23 02:20:02', '2019-09-23 02:20:02', '2020-09-23 07:50:02'),
('4cba96dabdc62341c38813e06fe67de9ca47dc4a4e679782217d3fc7e9dd42c4996ef1c9005524ef', 11, 3, 'Secret Token', '[]', 0, '2019-09-23 02:22:22', '2019-09-23 02:22:22', '2020-09-23 07:52:22'),
('4d6596bd58d9025b2adc74a3809314ff1826f11356bf7c432680ee565db975252542e2cdc9e13b06', 11, 2, 'Secret Token', '[]', 0, '2019-06-28 08:11:09', '2019-06-28 08:11:09', '2020-06-28 13:41:09'),
('4e04cdf5c9f4ef42490da5f9c508a5be98a4f0c145982904ce791f8d6847ebce5168f4fdfa73489a', 1, 3, 'Secret Token', '[]', 0, '2019-09-23 06:22:30', '2019-09-23 06:22:30', '2020-09-23 11:52:30'),
('4ee15dfb2a116042fe17e79387f3444e8b614c7e9993431d34e77b46cb2d8c0737fdcae51331c055', 21, 2, 'Secret Token', '[]', 0, '2019-08-08 00:02:32', '2019-08-08 00:02:32', '2020-08-08 05:32:32'),
('50fe02a75d288792b13cb3d48c8e76c004a01fd637fc3b335f11bfb1e7280af3ce64419e4d2944be', 14, 2, 'Secret Token', '[]', 0, '2019-07-26 07:20:43', '2019-07-26 07:20:43', '2020-07-26 12:50:43'),
('51be3f51fdb1af29b9e8236359e493e5bfd04bda2561a13bea9d9a997bd73bace898e60945297b23', 11, 2, 'Secret Token', '[]', 0, '2019-07-02 06:58:22', '2019-07-02 06:58:22', '2020-07-02 12:28:22'),
('521cead9bcf9f9caeda6b25221de3d8744c43083fcf2a740bf0c78fd4d5587122bbb638ea32455f9', 1, 3, 'Secret Token', '[]', 0, '2019-10-22 03:45:32', '2019-10-22 03:45:32', '2020-10-22 09:15:32'),
('54476ecbc8679695e1b45d131411205ed11f4a32e6bc3e157f16d9f73a3fb525ec5628d12970b5e2', 11, 3, 'Secret Token', '[]', 0, '2019-09-30 02:11:39', '2019-09-30 02:11:39', '2020-09-30 07:41:39'),
('546950d777df3d99974ba9cfff599275b42aefcf9a6e81a7257569f4bb15c79dcfa61093219c121f', 11, 3, 'Secret Token', '[]', 0, '2019-09-30 01:15:59', '2019-09-30 01:15:59', '2020-09-30 06:45:59'),
('54dfdac48d941739fb22fdcc31fd45aec9ab2f6cdc614140bdf9614c35be55b8e3dd8dffccb2c34f', 11, 2, 'Secret Token', '[]', 0, '2019-07-26 08:40:11', '2019-07-26 08:40:11', '2020-07-26 14:10:11'),
('55547575f31d80b3741766ff5c2998bf2c52c133c5c56612104f895b08b9a4011ac59499ba808ec0', 1, 2, 'Secret Token', '[]', 0, '2019-07-09 08:43:59', '2019-07-09 08:43:59', '2020-07-09 14:13:59'),
('5668b46b90e74178af5e0564af3c413077588ed3724cc328faa5785f8edebf3c465e7bc47339f94f', 21, 3, 'Secret Token', '[]', 0, '2019-10-23 04:17:47', '2019-10-23 04:17:47', '2020-10-23 09:47:47'),
('56fa2185db63d14b32ce91b5b8f110a0c6d0d56b623efb627c2ff0687844986ba5ecb3a50071ed7f', 11, 2, 'Secret Token', '[]', 0, '2019-07-31 00:01:42', '2019-07-31 00:01:42', '2020-07-31 05:31:42'),
('57434c1c5d46ac4f16a421513b90c958f04c96d0ee4d809db5f4d39e0399277bdd51bc3b3cf23cb0', 11, 2, 'Secret Token', '[]', 0, '2019-07-27 01:26:54', '2019-07-27 01:26:54', '2020-07-27 06:56:54'),
('58b599a3c940d2285ecb47bad017bd20161e7cfe71a0a0251aa5e98fa07c3db813c98ba51b13b44e', 18, 2, 'Secret Token', '[]', 0, '2019-07-24 06:03:31', '2019-07-24 06:03:31', '2020-07-24 11:33:31'),
('58c3ddeadb06e0e3ab346f8c2f445e31948c373acccf331d55e7a738390af5fb4964f042c2180a2c', 1, 3, 'Secret Token', '[]', 0, '2019-09-30 02:49:20', '2019-09-30 02:49:20', '2020-09-30 08:19:20'),
('58e12cfd75555d1432b8b6825c315e37a217395308d9c0d7b3cdb64e29ea31dd3aee8b718611f0a7', 4, 3, 'Secret Token', '[]', 0, '2019-10-21 05:22:30', '2019-10-21 05:22:30', '2020-10-21 10:52:30'),
('5965ba92d54a16840f0bf03fa51b2073667606fa2dc876b06ea66528a6004b4365a43037ac8c9584', 23, 2, 'Secret Token', '[]', 0, '2019-07-09 08:47:28', '2019-07-09 08:47:28', '2020-07-09 14:17:28'),
('59b3fa1ad185eb683d63b152626f084092d1c76adae984160cd382a5b6585f531c4ebecefcb054aa', 11, 2, 'Secret Token', '[]', 0, '2019-07-09 05:03:39', '2019-07-09 05:03:39', '2020-07-09 10:33:39'),
('5a231f9b156e0c456354a87dec4d16167a10d52f94b71dcefec823cde083bf821b3711347616e40f', 11, 2, 'Secret Token', '[]', 0, '2019-08-08 04:38:12', '2019-08-08 04:38:12', '2020-08-08 10:08:12'),
('5a7d21be25e84d603fcc51ddabe28da1f564d289dfb3badfc3a8006ac32d3572fe50c40706af1133', 11, 2, 'Secret Token', '[]', 0, '2019-07-31 06:09:43', '2019-07-31 06:09:43', '2020-07-31 11:39:43'),
('5a93461523598ff477afd8b0df196b18c07d9cef883af65dd8d8a22547a8707a6c7a281c6a6fc141', 1, 2, 'Secret Token', '[]', 0, '2019-07-26 00:02:36', '2019-07-26 00:02:36', '2020-07-26 05:32:36'),
('5b26213b57dbaceb0e6529ebb1389fdfcbccb9a9c76183658d0456515bf75627dab4341988f3514f', 11, 2, 'Secret Token', '[]', 0, '2019-07-30 05:41:40', '2019-07-30 05:41:40', '2020-07-30 11:11:40'),
('5ba19b3408a615a5daaf6c56f0fd8ea15d56bb82503b4b5fc49ebbfd2f4c89ed3c13ae3e07095cfd', 11, 2, 'Secret Token', '[]', 0, '2019-07-31 06:09:43', '2019-07-31 06:09:43', '2020-07-31 11:39:43'),
('5bd0677a8a0f6f395b42a0c985f5fd508ebe24ab13f314a60619052f327c042df61769269ed1415b', 11, 2, 'Secret Token', '[]', 0, '2019-07-27 01:26:52', '2019-07-27 01:26:52', '2020-07-27 06:56:52'),
('5bd0b7f2d5be3b8dd8102ee765b218e7770e3f66c9915c1a0d0c22d93fd9ad13a76e52e5d2db97eb', 11, 2, 'Secret Token', '[]', 0, '2019-07-27 01:26:53', '2019-07-27 01:26:53', '2020-07-27 06:56:53'),
('5cac073a5cfaa174dddcbeefc9ea96745e4dfb683b209c6cbf22ac04d0fda6b76de956c6c861bf30', 1, 3, 'Secret Token', '[]', 0, '2019-09-30 04:41:08', '2019-09-30 04:41:08', '2020-09-30 10:11:08'),
('5e25c78d3bdbf9136431532163ed43b1e377cdaf72d1c2883b3be0d393dcb2e575c1905adc85fda1', 1, 2, 'Secret Token', '[]', 0, '2019-06-11 02:22:07', '2019-06-11 02:22:07', '2020-06-11 07:52:07'),
('5e9d6bbecec584a7144dfaf6ff678599a66d140c3e1da148f5eed3bb264935eff1bde02e1dbcdc23', 1, 2, 'Secret Token', '[]', 0, '2019-06-11 05:35:15', '2019-06-11 05:35:15', '2020-06-11 11:05:15'),
('60a7a1b2ea13f7f66ea771f94071f91a2eab7c2bcb55e9e4286cd9959e26a70d3afb66c9596e13bd', 1, 3, 'Secret Token', '[]', 0, '2019-10-23 01:46:23', '2019-10-23 01:46:23', '2020-10-23 07:16:23'),
('61334e7dcf72e1936770ef933a7be107f26d9c459b8cca8faece4476b690ad6201b43d4c7aa1d4f1', 11, 2, 'Secret Token', '[]', 0, '2019-07-27 01:26:54', '2019-07-27 01:26:54', '2020-07-27 06:56:54'),
('613da49b26b6a3fccbee7f03404d95d829728cee5f9e95e01ed3f62a9532ffc4d9991eac4b0a291c', 11, 3, 'Secret Token', '[]', 0, '2019-10-15 04:36:55', '2019-10-15 04:36:55', '2020-10-15 10:06:55'),
('634035e2c03f1100686ece5a1d0c189b851844554167317ae394b8432908907902d25c7106b126ce', 1, 3, 'Secret Token', '[]', 0, '2019-09-23 23:59:44', '2019-09-23 23:59:44', '2020-09-24 05:29:44'),
('64138da1d519e9ac1a248d72d113a17576dd63f4cfd305e508f9566071586ffe269346ea04fd581d', 11, 2, 'Secret Token', '[]', 0, '2019-07-27 01:26:51', '2019-07-27 01:26:51', '2020-07-27 06:56:51'),
('649bd728fc059b96e777c1b70ba02d53dd5dd725a83486e1be4d3dc6b063f80d142fbb3e05dea627', 21, 3, 'Secret Token', '[]', 0, '2019-09-30 23:32:34', '2019-09-30 23:32:34', '2020-10-01 05:02:34'),
('64d6a9c62eb8b15871193aa061a98716a89045094c2f23b78e81a9d1f87e263eeaf5a91bac9c9190', 1, 2, 'Secret Token', '[]', 0, '2019-07-27 07:01:24', '2019-07-27 07:01:24', '2020-07-27 12:31:24'),
('65bce4e5870238873c6115cc0cd6d5bab125a8efabd4f89055a388844cf4102b89b66ab25b0885d2', 11, 2, 'Secret Token', '[]', 0, '2019-07-26 06:53:24', '2019-07-26 06:53:24', '2020-07-26 12:23:24'),
('65e09fffca12b285e5bcbdd4d7189354b335df509693d7650f964d22b14ee1e0e5282153fafa6261', 11, 2, 'Secret Token', '[]', 0, '2019-06-27 06:11:10', '2019-06-27 06:11:10', '2020-06-27 11:41:10'),
('6720ca362fa10d9bf09f0e2e459145aa7181b9497ee8caedc7640157d8ed33a0fdafec43bcec2253', 3, 3, 'Secret Token', '[]', 0, '2019-10-15 04:41:18', '2019-10-15 04:41:18', '2020-10-15 10:11:18'),
('676f6f381c1c094035248a35539b3d981042e7792cb6d8bdbda8afed0fa9e76246695160463c8026', 1, 3, 'Secret Token', '[]', 0, '2019-10-21 05:30:19', '2019-10-21 05:30:19', '2020-10-21 11:00:19'),
('6832f07576d1e1c1cba2315f157042bd8723aef4c2992b9a38e1416fbd82a1b8b17c834222957d79', 11, 2, 'Secret Token', '[]', 0, '2019-07-24 08:23:45', '2019-07-24 08:23:45', '2020-07-24 13:53:45'),
('6910e9d7f8ba601d382595795f74dce4ea630f073bbf664d45dde513bd50d3759e1c893971992714', 1, 2, 'Secret Token', '[]', 0, '2019-07-12 23:16:21', '2019-07-12 23:16:21', '2020-07-13 04:46:21'),
('6981d3b9b0abff020cafe2d6a5f2cca583505cb8a1b71116ec126fccc99215b8764d712d7e28fb75', 14, 3, 'Secret Token', '[]', 0, '2019-10-21 04:35:02', '2019-10-21 04:35:02', '2020-10-21 10:05:02'),
('69a2c4300bae22a0f3e25cde08891794f523f78d2b9e54626f3b94d6e9f73bb2c70c8adafd838a10', 11, 2, 'Secret Token', '[]', 0, '2019-07-24 07:53:10', '2019-07-24 07:53:10', '2020-07-24 13:23:10'),
('6b0e33d007284a296bfc5bb0ea95ca059e0b47f3c1770e09cb0447e83e332e3234c1f3985780ed47', 21, 3, 'Secret Token', '[]', 0, '2019-09-23 05:46:25', '2019-09-23 05:46:25', '2020-09-23 11:16:25'),
('6c1983a1fb21a9eb18dca581e8cc6f9263665b3d4c27aecd6d69619646f60823e9e88a2986271f99', 11, 2, 'Secret Token', '[]', 0, '2019-07-26 08:59:38', '2019-07-26 08:59:38', '2020-07-26 14:29:38'),
('6d7b9a862181a6afc94c2bda0c2f367fc1a1a353907dc4030a202ae64d92a717c912a8a69d8018f8', 11, 2, 'Secret Token', '[]', 0, '2019-07-27 01:26:54', '2019-07-27 01:26:54', '2020-07-27 06:56:54'),
('6d86923c92fad162097396947506b090de792573331e692c0d6e554d72430a9ceb70bb9bf2400116', 1, 2, 'Secret Token', '[]', 0, '2019-06-25 00:47:49', '2019-06-25 00:47:49', '2020-06-25 06:17:49'),
('6dea621399d56c6a2fa3d4c3afb3b9e5b20799bc95d83a4fee12fdd9cad0af80d2dd61df96c2ebd5', 21, 2, 'Secret Token', '[]', 0, '2019-08-02 01:07:37', '2019-08-02 01:07:37', '2020-08-02 06:37:37'),
('6fb09a83c772c6dca9fd0182ef0dd087797a6f9d24a1b5e8ff5e6a5176b9f79bcfd8e705ae56061f', 1, 2, 'Secret Token', '[]', 0, '2019-07-25 06:03:37', '2019-07-25 06:03:37', '2020-07-25 11:33:37'),
('713975a8a30e0e850aeabbede40d49053a43f4084b445367543eae380fd37304222d8997aeeb4eca', 1, 2, 'Secret Token', '[]', 0, '2019-06-25 02:30:18', '2019-06-25 02:30:18', '2020-06-25 08:00:18'),
('7189080fb3de8a4ed1a94b57039d46388941ebabffdb807bd1bffd395e6f5b6ff3970b55a2f125ca', 11, 2, 'Secret Token', '[]', 0, '2019-07-27 00:09:13', '2019-07-27 00:09:13', '2020-07-27 05:39:13'),
('723d1174c5e270de87ce2ace758561b5047bfbcdde64521e85f36bbc36c98f108241fe2b0b53ccc9', 1, 3, 'Secret Token', '[]', 0, '2019-10-01 07:43:51', '2019-10-01 07:43:51', '2020-10-01 13:13:51'),
('725e9cbf262fe5a71c9d3be1d3ad8c16bd933bb535f06ace337ea4f50fb0a601b47c3539fb45b4be', 11, 2, 'Secret Token', '[]', 0, '2019-07-23 04:18:28', '2019-07-23 04:18:28', '2020-07-23 09:48:28'),
('73291a7670928f28e61e47762e13a348c83e86da709dc28973b8a654451fc86f6a5e72f83f91ea1c', 3, 3, 'Secret Token', '[]', 0, '2019-10-15 04:30:46', '2019-10-15 04:30:46', '2020-10-15 10:00:46'),
('73382fea9a98acc864f7154ef3377a460b4f1d68048bde2fa0fa41347429b2914f850cc68752abdb', 1, 3, 'Secret Token', '[]', 0, '2019-10-23 04:18:04', '2019-10-23 04:18:04', '2020-10-23 09:48:04'),
('741e3dee8a1cd43734de10ea4e0e9d689d908bb13c725cb2f8b23ae5701d43bd0f9fbb23b51e0d6a', 4, 2, 'Secret Token', '[]', 0, '2019-07-26 06:30:14', '2019-07-26 06:30:14', '2020-07-26 12:00:14'),
('7435acdc4fd39fb04da2728dbc3f8176da3c1549f63fd5056390db365cfb8d875b69ec29234bad54', 21, 2, 'Secret Token', '[]', 0, '2019-07-26 09:04:54', '2019-07-26 09:04:54', '2020-07-26 14:34:54'),
('745e553a46a343b1b078880311e61d4abbf172bfd2f0605ceb0e542a7e63a6f9ab685219c92b2522', 1, 2, 'Secret Token', '[]', 0, '2019-06-11 01:30:45', '2019-06-11 01:30:45', '2020-06-11 07:00:45'),
('745ed345897f6547e59137a492f3f6ffb197de0c87a23bdb8484a49a11fd7903300becf69e251740', 1, 2, 'Secret Token', '[]', 0, '2019-06-28 08:14:11', '2019-06-28 08:14:11', '2020-06-28 13:44:11'),
('758a66918db19849d6fafc5bcb6ab5ba3a1bfccf959c67f321c31cacb1e8096f75511d6fc1745e88', 11, 3, 'Secret Token', '[]', 0, '2019-09-23 04:45:35', '2019-09-23 04:45:35', '2020-09-23 10:15:35'),
('7657fc1dc183c6248f1a669e37f25bed073dde9e7b8ad6ba1ff04ed6c83a93cc1fd874c46e0c1084', 3, 3, 'Secret Token', '[]', 0, '2019-10-17 05:00:50', '2019-10-17 05:00:50', '2020-10-17 10:30:50'),
('778dc8d6013edf3dd65c17c6571ece99dfbcee281e8c28635b455c39ac88489ea7a7a1f3f583c8a6', 3, 3, 'Secret Token', '[]', 0, '2019-10-21 01:34:05', '2019-10-21 01:34:05', '2020-10-21 07:04:05'),
('78653871e9d13b62dbd420d42d6059808f8d782500d653cb7bef8d8fee937dba9d1dfd493cdcfee7', 11, 2, 'Secret Token', '[]', 0, '2019-08-08 05:23:43', '2019-08-08 05:23:43', '2020-08-08 10:53:43'),
('790858bbe4aff2f40528025e57dad253fe2dac0096e4bddb594def685653ee0846257f9a37515cbe', 2, 2, 'Secret Token', '[]', 0, '2019-07-13 06:46:19', '2019-07-13 06:46:19', '2020-07-13 12:16:19'),
('793bbbd7994b5e4096c3484d9b4bde279885d8fa8179bfc13ef3b1f7190ee6c2be641cc287dbd8e4', 3, 3, 'Secret Token', '[]', 0, '2019-10-15 04:44:39', '2019-10-15 04:44:39', '2020-10-15 10:14:39'),
('7948dacb89efd031d3fe2918e367cfe2c3dd2362c4769e2bfbd5d9e9ababd333bd8e26b486d68a1f', 1, 2, 'Secret Token', '[]', 0, '2019-07-26 01:30:18', '2019-07-26 01:30:18', '2020-07-26 07:00:18'),
('7aaf5748c2aa9685859e433e70f1051fa81f4f62282b125aa106d06a7ea2ecb868b59a94a2360c4e', 17, 2, 'Secret Token', '[]', 0, '2019-07-23 04:32:23', '2019-07-23 04:32:23', '2020-07-23 10:02:23'),
('7ad70d815b0b39e5ab172fad4e2c1cb1419018e0f76a1e5af2968a928ffabc7e8a60f3e552cebb80', 1, 2, 'Secret Token', '[]', 0, '2019-07-25 07:18:39', '2019-07-25 07:18:39', '2020-07-25 12:48:39'),
('7b0f9073fc7ca5e87d2c599fe8ebbd9b36eaa1a265838a7e709c0f74e5246db04a1bde4562f8b51d', 11, 2, 'Secret Token', '[]', 0, '2019-07-29 08:16:34', '2019-07-29 08:16:34', '2020-07-29 13:46:34'),
('7b10c7212fdaa16767dc92c069c0e00dd5fc9fd07c960817c388a7aefd545f46483c5c4cd9d01bc7', 3, 3, 'Secret Token', '[]', 0, '2019-10-17 05:09:28', '2019-10-17 05:09:28', '2020-10-17 10:39:28'),
('7ba6460aeed9dd40145196d4b0e4f23814083416bc297a3ff10edab5c21a39fdfb26d0ab0d8d99f5', 11, 2, 'Secret Token', '[]', 0, '2019-07-27 01:26:53', '2019-07-27 01:26:53', '2020-07-27 06:56:53'),
('7bf2bd4554307f19ed4a4c364c3c7b2b8fda559e8ef24f5ebbeb62ef1221292de4d37cc6330f15ff', 3, 2, 'Secret Token', '[]', 0, '2019-06-26 06:24:40', '2019-06-26 06:24:40', '2020-06-26 11:54:40'),
('7c1d866f400e89aad22c6ef0844de48d3a0f6381aa5f58080b0aa20fafe6cf443a399f56f7fd6f1e', 11, 3, 'Secret Token', '[]', 0, '2019-10-23 04:17:18', '2019-10-23 04:17:18', '2020-10-23 09:47:18'),
('7c24d75453ff571f64315e386db532eb639511db91c0ebd049d4ee779828a2dae8c1a2a541296fd5', 1, 2, 'Secret Token', '[]', 0, '2019-06-25 01:06:03', '2019-06-25 01:06:03', '2020-06-25 06:36:03'),
('7cac555db4966fc517c1d28082ada7f286668b3214ffa288223a22d239da838143ce97688e1d9ef0', 17, 2, 'Secret Token', '[]', 0, '2019-07-24 07:50:49', '2019-07-24 07:50:49', '2020-07-24 13:20:49'),
('7d082f347659a7b46feebd8106acdb3adad497f1de6885fb63a03654b822d69fa3d056135a675be8', 11, 2, 'Secret Token', '[]', 0, '2019-07-27 01:26:51', '2019-07-27 01:26:51', '2020-07-27 06:56:51'),
('7d347df9282786cdd46dd700a0aff50aeea6a1cc5c2160105335cc7d6c786fac4084e4272f15064d', 3, 3, 'Secret Token', '[]', 0, '2019-10-21 04:26:42', '2019-10-21 04:26:42', '2020-10-21 09:56:42'),
('7dae3e89ad2fb7b256dc148095a8a81daaf9f0fadc424fc5e4d8f841b550eee060ef39a9cea19f8d', 11, 2, 'Secret Token', '[]', 0, '2019-06-27 23:53:26', '2019-06-27 23:53:26', '2020-06-28 05:23:26'),
('7f6244d1b00f4eaed049a8e9ebc75a289640cf8fa0eeb29fc91da65942ab553112e350b95ee8d7aa', 4, 2, 'Secret Token', '[]', 0, '2019-07-26 06:31:35', '2019-07-26 06:31:35', '2020-07-26 12:01:35'),
('7fd2dbf7f222663f6cb512236a2aa743d13aa365511508399f5ada2becf34cb9fff8dc646d5cfd58', 1, 3, 'Secret Token', '[]', 0, '2019-10-17 04:39:46', '2019-10-17 04:39:46', '2020-10-17 10:09:46'),
('80b8e06aa7ba996bdad76648cbd266d7c85a6cf6b6969e1b346c85588d32fb6eb7b9c7bcc24ae2f3', 3, 3, 'Secret Token', '[]', 0, '2019-10-17 04:38:08', '2019-10-17 04:38:08', '2020-10-17 10:08:08'),
('80f93477731bfdeca14465048ff913be38a535cd7432d01d30ce7438229f8bfb1ee7fe563c5ed509', 1, 2, 'Secret Token', '[]', 0, '2019-06-11 01:18:52', '2019-06-11 01:18:52', '2020-06-11 06:48:52'),
('8165d9fd1921cf295d93350991aa0980e1ba47434a1955df6f2d23c5a001115db50ea61eb216dd29', 21, 3, 'Secret Token', '[]', 0, '2019-10-01 07:08:35', '2019-10-01 07:08:35', '2020-10-01 12:38:35'),
('81d91710be03612e21d40f531ce7b8871d7d2b8dbcbc545a07dd8d290c09b3996bf72d24b6549066', 11, 3, 'Secret Token', '[]', 0, '2019-09-24 03:56:34', '2019-09-24 03:56:34', '2020-09-24 09:26:34'),
('821c778e1494505744140e15974c8feb85b4a698616017f47e8168fdc1bbeddb2449d391ec9cb1d6', 11, 2, 'Secret Token', '[]', 0, '2019-07-26 02:25:24', '2019-07-26 02:25:24', '2020-07-26 07:55:24'),
('83116435e80e5fdda9fbddf8b771eaa81f85f1b95f463c28aa2432eb8a84cfa81e4ae76efb948761', 3, 3, 'Secret Token', '[]', 0, '2019-10-20 23:26:59', '2019-10-20 23:26:59', '2020-10-21 04:56:59'),
('838abbfc5a1671057844c2e4e971529598a664c76067c24ca5fc8aa9fbf8b63e33d760dbd96e1860', 11, 2, 'Secret Token', '[]', 0, '2019-07-26 04:03:02', '2019-07-26 04:03:02', '2020-07-26 09:33:02'),
('83cac983ff87650f71e95e4d99af49508dada1e768a546eb091c269e8ab52b57ec18cdea644260ef', 17, 2, 'Secret Token', '[]', 0, '2019-07-23 07:24:48', '2019-07-23 07:24:48', '2020-07-23 12:54:48'),
('84491e9418772c45b1c943c7daf6cc46a6bb96c912912ead542add222b8589d2b38e4401375f3f68', 11, 3, 'Secret Token', '[]', 0, '2019-09-23 06:21:49', '2019-09-23 06:21:49', '2020-09-23 11:51:49'),
('8480bfe24dc3b639b4ab4604340e4ec1e56aa5610a70a6f182260256dd06d9b5202e33d8c9350463', 18, 2, 'Secret Token', '[]', 0, '2019-07-24 07:35:26', '2019-07-24 07:35:26', '2020-07-24 13:05:26'),
('85eb5fb12b93bdecab00bd7d594596c08e95d9289db5d56d73a0b5cd2fbb98b3a7ff50cf3732206f', 11, 3, 'Secret Token', '[]', 0, '2019-09-30 23:38:21', '2019-09-30 23:38:21', '2020-10-01 05:08:21'),
('863e86380cf58c2de5dfe92b7d50d7fc528cbcc9c9679652f4549a6e8112910b46d147c754d0ae91', 11, 2, 'Secret Token', '[]', 0, '2019-07-30 05:56:33', '2019-07-30 05:56:33', '2020-07-30 11:26:33'),
('8673f10ac532a13a120a430868d2c792917e93ea272cae481112690007978352c9ebca3b56faa6de', 11, 2, 'Secret Token', '[]', 0, '2019-07-10 00:36:45', '2019-07-10 00:36:45', '2020-07-10 06:06:45'),
('880207de083d6aed62462cd52b1d6ba47c235b45df1aecfd4c289dc9f1285cf582b237903cdde0bb', 17, 2, 'Secret Token', '[]', 0, '2019-07-16 04:16:58', '2019-07-16 04:16:58', '2020-07-16 09:46:58'),
('8817687f1ce936d83f0926dcc497168557df7f69dc5201e04fcff538dc600c1a0e631b36b52b4da7', 11, 2, 'Secret Token', '[]', 0, '2019-07-09 05:10:20', '2019-07-09 05:10:20', '2020-07-09 10:40:20'),
('8a24cef08d1cc6ddf403efad27522c9cd1668ca718df020bc24466fd5fe7f980d9a295bfb03e562f', 1, 2, 'Secret Token', '[]', 0, '2019-07-11 00:06:45', '2019-07-11 00:06:45', '2020-07-11 05:36:45'),
('8a5f7e6862dca34fbea2966c9e7135951c069736ae7d9b26ac1c256862d7ce9f20ac9549b67e96f3', 11, 2, 'Secret Token', '[]', 0, '2019-07-09 00:55:17', '2019-07-09 00:55:17', '2020-07-09 06:25:17'),
('8a9da9dc4f4e67de03a10e0d1e32b0accf340f26f34bb3406a7f7981cc2df94e54f2249f7882ed1d', 1, 3, 'Secret Token', '[]', 0, '2019-10-21 23:16:50', '2019-10-21 23:16:50', '2020-10-22 04:46:50'),
('8afa5aa1e0242fbc567859059dcbb45e2146e8caca396d9a7f9fefe5157f94e93169d9ebb0d42575', 11, 2, 'Secret Token', '[]', 0, '2019-07-27 01:26:52', '2019-07-27 01:26:52', '2020-07-27 06:56:52'),
('8b52d029c0fb118950d30a22510a3011819ba4d4b13e29f870972ac6990ddd5c523cfc00031b58cb', 1, 3, 'Secret Token', '[]', 0, '2019-10-22 00:32:10', '2019-10-22 00:32:10', '2020-10-22 06:02:10'),
('8b5e448a1a30877949a2e0f0d340874abc74f4d1c4e5c77fd511a24cdb6c8011a4e01ac3b139d77c', 11, 3, 'Secret Token', '[]', 0, '2019-09-30 23:30:21', '2019-09-30 23:30:21', '2020-10-01 05:00:21'),
('8ca0325314c5d13ad2f9dbb3026a8a5076aef602471f92cc3132a468f09a0d8ba70f24062cedfce5', 11, 2, 'Secret Token', '[]', 0, '2019-07-09 08:06:48', '2019-07-09 08:06:48', '2020-07-09 13:36:48'),
('8cc203ab2538c58a9f18de3eab250a38169beb46c123190ec3046c959b1e00ddf91b5bf3c3f43b31', 1, 2, 'Secret Token', '[]', 0, '2019-07-26 06:32:24', '2019-07-26 06:32:24', '2020-07-26 12:02:24'),
('8d058511e047256e568a552c9e071793c0360c80684e817fe0d67b43e869e49ae0822562d610349d', 3, 3, 'Secret Token', '[]', 0, '2019-10-15 04:36:28', '2019-10-15 04:36:28', '2020-10-15 10:06:28'),
('8d79f40c9864fb6436be434524ba150ba79e4ca7e274e0de578a73adb7e860f258ca3345d6ce249b', 1, 2, 'Secret Token', '[]', 0, '2019-06-18 00:23:29', '2019-06-18 00:23:29', '2020-06-18 05:53:29'),
('8f8a1471b01f1323ae9b0cf6b2538da004e402a0538927d27e5bd930744fe09ef15d6a563cebf44e', 1, 2, 'Secret Token', '[]', 0, '2019-06-18 04:00:10', '2019-06-18 04:00:10', '2020-06-18 09:30:10'),
('90196ddf9d9cc42c8bc2f693365a226031ed6a6e774981010abea28e421c38220e969a4a343ebea6', 1, 3, 'Secret Token', '[]', 0, '2019-10-23 04:17:33', '2019-10-23 04:17:33', '2020-10-23 09:47:33'),
('913086b2e0619584c395d118447ae5ff2f898ec70e2e4297e1c98a42888d2777beed7b2e09b3ce14', 3, 2, 'Secret Token', '[]', 0, '2019-07-26 07:34:36', '2019-07-26 07:34:36', '2020-07-26 13:04:36'),
('913d555cc9aba2ae8918b8ebae528a05b533df8f2f7530938cd36e4bb8951d343751bd3c317d675d', 1, 2, 'Secret Token', '[]', 0, '2019-06-18 00:20:42', '2019-06-18 00:20:42', '2020-06-18 05:50:42'),
('91ccb19a3b243e33473eec0ed9efd0c6dc03c90614509b90c80bf4edde16c7d13b873ba9f3d92b30', 11, 2, 'Secret Token', '[]', 0, '2019-07-09 05:02:24', '2019-07-09 05:02:24', '2020-07-09 10:32:24'),
('91dce4344178548083b488d2938b6e672cde5031d279d2a3408238366e5919fe8522ef204e0f56a3', 11, 2, 'Secret Token', '[]', 0, '2019-07-27 01:26:53', '2019-07-27 01:26:53', '2020-07-27 06:56:53'),
('923cd67facee8aeb60c6eea3564d6a539f2b372607df5746174573f62bf87dc1760bab7879dddc9c', 11, 2, 'Secret Token', '[]', 0, '2019-07-13 08:58:10', '2019-07-13 08:58:10', '2020-07-13 14:28:10'),
('9275ef5e5c39467a87166725156faca7085ce1b43853c9adc1ba7aba9746e304e1b82d54e84f5cc0', 1, 3, 'Secret Token', '[]', 0, '2019-09-30 01:21:22', '2019-09-30 01:21:22', '2020-09-30 06:51:22'),
('92cea7bfcaef00922e8ed5337e33d0d8baf520ccc466f817430f67c9b4588229e30baa19cc08c721', 1, 3, 'Secret Token', '[]', 0, '2019-10-15 04:24:18', '2019-10-15 04:24:18', '2020-10-15 09:54:18'),
('93fe9abeb2c27c3bcd0eb338052f39703ab5f2227985f62bcbb876e647c2d846f133cf591dc6ca6f', 1, 2, 'Secret Token', '[]', 0, '2019-06-11 02:28:10', '2019-06-11 02:28:10', '2020-06-11 07:58:10'),
('9507679a184ef3c042798b8810de5091b60d1d7d350670e8da5af99784348c8090282d32ba377166', 11, 2, 'Secret Token', '[]', 0, '2019-07-11 02:16:18', '2019-07-11 02:16:18', '2020-07-11 07:46:18'),
('95caedcac2b704347cae579e2bcf99e475730987377bfe10f319d9fdb1ef299fd674505624f6bc0c', 18, 2, 'Secret Token', '[]', 0, '2019-07-24 07:51:35', '2019-07-24 07:51:35', '2020-07-24 13:21:35'),
('9650a822fcfe14cfda2613e272b8ac38d5f8ce1308c2770ad80898e2cb31d71f7e52651f754357bc', 21, 2, 'Secret Token', '[]', 0, '2019-07-31 00:14:43', '2019-07-31 00:14:43', '2020-07-31 05:44:43'),
('96cc9156f926dfbd14819d6ff891ac29db665d752c3143cd9dbfb42ab0036089be34c3d11a0852db', 3, 2, 'Secret Token', '[]', 0, '2019-07-27 01:41:14', '2019-07-27 01:41:14', '2020-07-27 07:11:14'),
('97467427b3c1f9ba3f2bed9f68d0a77161c2c68a3960a4eb556ae13184eb313b404b44fce22e41a7', 8, 2, 'Secret Token', '[]', 0, '2019-06-27 04:16:39', '2019-06-27 04:16:39', '2020-06-27 09:46:39'),
('97c727639ef23154bfb4c60e7efd1290f4a6ecfe183dc8e890daa6c9b594b623af59fa6a71534c6c', 11, 3, 'Secret Token', '[]', 0, '2019-09-23 23:59:16', '2019-09-23 23:59:16', '2020-09-24 05:29:16'),
('97d0793233016c43adaf0c729185ff2119da72b4d467f77c59bdc2a30cf15b075bdc5050a120ddd4', 21, 3, 'Secret Token', '[]', 0, '2019-09-30 04:06:07', '2019-09-30 04:06:07', '2020-09-30 09:36:07'),
('97f57e26accf9fbfd821ad48f109a2962e499183572171efaf65070a55bce07b82aea819aa2b0e6e', 1, 2, 'Secret Token', '[]', 0, '2019-06-11 01:11:31', '2019-06-11 01:11:31', '2020-06-11 06:41:31'),
('986a3ddc59c53e586bf223884d31e58dc3250fb93ada900e33c732d8265ecd39a9e6796579aab6c0', 11, 2, 'Secret Token', '[]', 0, '2019-07-25 07:36:32', '2019-07-25 07:36:32', '2020-07-25 13:06:32'),
('9927d45cd68391dfb8341b5f8a00b54811ba3894406d8988638b84243745673b2a6d8fa72829fd51', 11, 3, 'Secret Token', '[]', 0, '2019-10-21 00:02:37', '2019-10-21 00:02:37', '2020-10-21 05:32:37'),
('9931bf44e5eec30a4fa2bcbab23ec4ad257b189435b300996eb8c64dd208e686c9aa2bd4660a7308', 11, 3, 'Secret Token', '[]', 0, '2019-10-01 04:16:37', '2019-10-01 04:16:37', '2020-10-01 09:46:37'),
('9a062261c202ad88f6d98181ec5c5c0024e96ed31b610dce45107a527e32362657ca30d73f8ada7b', 11, 3, 'Secret Token', '[]', 0, '2019-10-21 01:22:29', '2019-10-21 01:22:29', '2020-10-21 06:52:29'),
('9a333ee2282465abfbd43b6e2315334a1ef391bb5273dcb0b0febe9f4b794ecd3feb5baecbd937cf', 11, 2, 'Secret Token', '[]', 0, '2019-07-29 03:23:12', '2019-07-29 03:23:12', '2020-07-29 08:53:12'),
('9a5d86ef7ae219e7791e0f92c9030f3d14515809f4d18d245ea306b88e8f968e2789ef45811e85d4', 1, 3, 'Secret Token', '[]', 0, '2019-10-21 23:43:55', '2019-10-21 23:43:55', '2020-10-22 05:13:55'),
('9a757af8295b4ae2e0d48ab141e312d23b24b819a63324b5bcf6829763ea01953572b534d36ea0f8', 17, 2, 'Secret Token', '[]', 0, '2019-07-24 06:36:10', '2019-07-24 06:36:10', '2020-07-24 12:06:10'),
('9cc2791972e497e9895086f916c36257168427b411d9b608954feb09afb773f3b4b3107598c24e63', 11, 3, 'Secret Token', '[]', 0, '2019-10-22 01:44:33', '2019-10-22 01:44:33', '2020-10-22 07:14:33'),
('9db42e67db7e3d4532d4c6062824009dab14c145dd15f83d3390fde451f615db4e396013d4e57532', 1, 2, 'Secret Token', '[]', 0, '2019-06-11 01:35:45', '2019-06-11 01:35:45', '2020-06-11 07:05:45'),
('9df7036f6dddb09318453b9c037fc404ded3d514c7d643ba2e4bc319cd2d38c6ac8974a7a302718f', 11, 2, 'Secret Token', '[]', 0, '2019-07-09 04:48:41', '2019-07-09 04:48:41', '2020-07-09 10:18:41'),
('9e3bb83f69e7da94e902119832aa77023d081866cccbed87890d282626e74dc6d07b80803eff4e1a', 11, 2, 'Secret Token', '[]', 0, '2019-07-31 00:04:37', '2019-07-31 00:04:37', '2020-07-31 05:34:37'),
('9e49c52e53ba50997d17308293bc7f887dde8a55c24b1b056490eff241c91b1ef7ad8b3052e1fcc6', 18, 2, 'Secret Token', '[]', 0, '2019-07-26 02:24:24', '2019-07-26 02:24:24', '2020-07-26 07:54:24'),
('9e8293a39c1f33911701b170abd402072712c44bc0bd6a506e5c0b73a965bb1f61ccd9ebb406c750', 11, 2, 'Secret Token', '[]', 0, '2019-07-31 06:09:43', '2019-07-31 06:09:43', '2020-07-31 11:39:43'),
('9ee469eb67df2abac3d56cfc471af2d12bb9400507b93370056eb33069adfa25739a606d43037c22', 1, 2, 'Secret Token', '[]', 0, '2019-06-28 08:12:46', '2019-06-28 08:12:46', '2020-06-28 13:42:46'),
('9f2dc6701dd9948d43e56a4bdc6485373649435a13f5886c39d0fe824315d38f047282b54f887819', 1, 2, 'Secret Token', '[]', 0, '2019-08-02 01:32:58', '2019-08-02 01:32:58', '2020-08-02 07:02:58'),
('a08a27d25dc15f2d8bbf3771ba3a9091c604d0b16e0edd1f6f56604feb2c925abb939cf1ef50d32b', 11, 2, 'Secret Token', '[]', 0, '2019-07-09 04:46:12', '2019-07-09 04:46:12', '2020-07-09 10:16:12'),
('a0d931527b1cd293e5cfa77873001b35524aa8c963c30112fa19c8e5a79df2638f018a6f48749723', 11, 2, 'Secret Token', '[]', 0, '2019-07-27 01:26:52', '2019-07-27 01:26:52', '2020-07-27 06:56:52'),
('a12130da0933bc90c9dd07c10bc5873077a936c722926e7cb9e2d8c2b4cad46c75ff14c08cecc592', 3, 3, 'Secret Token', '[]', 0, '2019-10-21 04:22:45', '2019-10-21 04:22:45', '2020-10-21 09:52:45'),
('a3fdf0ae7315d6a7b505304fb172cfe9fd89fb150a4f8c073fea22a8a658b38d9d279540eab24667', 18, 2, 'Secret Token', '[]', 0, '2019-07-13 07:37:57', '2019-07-13 07:37:57', '2020-07-13 13:07:57'),
('a437494fa7f597b9a8f82a0d02255029b513bb39a81e4807a8fbaf61ef9f201c8b5fab8081b18162', 21, 2, 'Secret Token', '[]', 0, '2019-08-03 04:02:10', '2019-08-03 04:02:10', '2020-08-03 09:32:10'),
('a491b4a6dcc0448aaa2b933c732aa7b2c1938ccb7d87f6c0266eacbc683890be421e52ffeef1b07d', 18, 2, 'Secret Token', '[]', 0, '2019-07-26 06:54:59', '2019-07-26 06:54:59', '2020-07-26 12:24:59'),
('a4b809643659cbff5368324dfd61270535b8c86d45077c5926ce1856f68df1fe7727f67a7f97aed2', 1, 2, 'Secret Token', '[]', 0, '2019-07-08 00:56:00', '2019-07-08 00:56:00', '2020-07-08 06:26:00'),
('a4e89f72f6e3bf761718c09949c78cb491e8e080fdb398a123c3b5b9f471261d0168ec8e548e84a6', 11, 2, 'Secret Token', '[]', 0, '2019-07-27 01:26:55', '2019-07-27 01:26:55', '2020-07-27 06:56:55'),
('a68ff2dad309a338401d8b309b30b96c71271d5f7bdf3ff533f07dc159726d95cf108b6b3b5005ae', 11, 3, 'Secret Token', '[]', 0, '2019-10-15 04:29:45', '2019-10-15 04:29:45', '2020-10-15 09:59:45');
INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
('a69353273c4404241c24a663613b55f9873fd17487c6d15b62872c786d8260ca9b9aae104d495e5a', 1, 3, 'Secret Token', '[]', 0, '2019-09-30 01:44:08', '2019-09-30 01:44:08', '2020-09-30 07:14:08'),
('a752386a8efbef67c621db36c35dc54fcbe7687b50c63cfb158621a0dcbfbe3097ab9af76f9f7c97', 11, 3, 'Secret Token', '[]', 0, '2019-10-21 05:29:15', '2019-10-21 05:29:15', '2020-10-21 10:59:15'),
('a841b155abd74c4e484954f7206e3a68c92ab2c75b322091452304af0b2d3645b73c25bf9b812a69', 1, 2, 'Secret Token', '[]', 0, '2019-06-26 04:45:52', '2019-06-26 04:45:52', '2020-06-26 10:15:52'),
('a9436446b7471612841b047abe986e9834d99d78b401ab25f35f72e3ac6049cb2c1282fe18ea7d7c', 21, 3, 'Secret Token', '[]', 0, '2019-09-30 01:37:38', '2019-09-30 01:37:38', '2020-09-30 07:07:38'),
('a99ca705dca32b169e72ad5cb27245f6e05ac16a163dc45ecd5368394d3960878c8356078dc0da32', 11, 3, 'Secret Token', '[]', 0, '2019-10-15 04:30:20', '2019-10-15 04:30:20', '2020-10-15 10:00:20'),
('abc034fdade61e1f8a27a488b51a47d70205551cc16f3bfbe3b6742502f3e8388145021fea8a381d', 1, 2, 'Secret Token', '[]', 0, '2019-06-18 01:48:23', '2019-06-18 01:48:23', '2020-06-18 07:18:23'),
('ac62f764d9ee9c982afeecc9a809d52befc1855cd2bc393292a594724cebcdeb8fb4e50bd674cb20', 1, 2, 'Secret Token', '[]', 0, '2019-06-11 06:35:02', '2019-06-11 06:35:02', '2020-06-11 12:05:02'),
('ac7bc45e259cf4ccef93e923a28eabf82ca8d176a4a3cb226ee57ea79c8937a0361d77aeec3c0358', 11, 3, 'Secret Token', '[]', 0, '2019-10-23 04:33:04', '2019-10-23 04:33:04', '2020-10-23 10:03:04'),
('ad0e77cc6c09ea0dd030c5dadf53c78eebc3705488d84144dc1c0711eeda0a9be0271569b5273aec', 11, 2, 'Secret Token', '[]', 0, '2019-07-07 23:53:50', '2019-07-07 23:53:50', '2020-07-08 05:23:50'),
('ad5eabd2620e43b5e79ca5fad559684fd9fd1de63303fa074a7551295ade05ebfa0737debf9be22f', 11, 3, 'Secret Token', '[]', 0, '2019-09-30 07:29:30', '2019-09-30 07:29:30', '2020-09-30 12:59:30'),
('ae017627277ba8f54a74f20236dc0fcb7e86bba638931313f58232e7006464e7922c403adac24714', 14, 2, 'Secret Token', '[]', 0, '2019-06-28 07:43:20', '2019-06-28 07:43:20', '2020-06-28 13:13:20'),
('af012168fe078da5a8ace4dec878f39d7db5e135bcef5bc713d82b95f5001498f0d8a6e35794482d', 1, 2, 'Secret Token', '[]', 0, '2019-06-26 02:05:44', '2019-06-26 02:05:44', '2020-06-26 07:35:44'),
('af27a9e27ab6a12764e87b589389a7b96100d190fa01df664c2d3f9f54578f838e547545f4e2e30c', 11, 3, 'Secret Token', '[]', 0, '2019-10-23 05:55:22', '2019-10-23 05:55:22', '2020-10-23 11:25:22'),
('af40590e25571094035b70603a68514171da666e9f4bf4b32d3a1f273d7a9a22ecd81434bde6ef00', 11, 2, 'Secret Token', '[]', 0, '2019-07-26 07:02:33', '2019-07-26 07:02:33', '2020-07-26 12:32:33'),
('b0205a665ffc8447bad8196a3a6219c07d5be8c42161481e4fefb0c2854fbc3d2c56f99bbdd68e1f', 11, 3, 'Secret Token', '[]', 0, '2019-10-15 03:35:44', '2019-10-15 03:35:44', '2020-10-15 09:05:44'),
('b0dda895510f2afedae80ece5a1adfa82fc6737dee93b31da83f167fd725c0c098517f908bf14283', 11, 2, 'Secret Token', '[]', 0, '2019-07-27 01:26:54', '2019-07-27 01:26:54', '2020-07-27 06:56:54'),
('b14796e3b1f9fb2d17029b31330bcf57a2599f06a84383f7545c2ebe3801c3bca289077a902adaed', 1, 3, 'Secret Token', '[]', 0, '2019-10-23 01:41:36', '2019-10-23 01:41:36', '2020-10-23 07:11:36'),
('b1609f6fc903a9a29b6ed0a90f96b0b6a31429361b9dd0c1982c7e61e7c776107b3504d7d7394141', 1, 3, 'Secret Token', '[]', 0, '2019-10-15 04:18:38', '2019-10-15 04:18:38', '2020-10-15 09:48:38'),
('b320e37cfd8f34470b5c044e3c53acf321b84eab16b9af87b19d939a379c4a3d8b9fd928783e0775', 11, 3, 'Secret Token', '[]', 0, '2019-09-30 01:43:25', '2019-09-30 01:43:25', '2020-09-30 07:13:25'),
('b3291b538c25599662f50ece8dbd0a7a481215e1bda42f8128d817158d961f83dc7e6a7443290294', 18, 2, 'Secret Token', '[]', 0, '2019-07-26 06:08:11', '2019-07-26 06:08:11', '2020-07-26 11:38:11'),
('b4651d22f5ca4b314f3cf163dcbbd5bbcacf700d75a9542241b7331408da631d3fb05c4f43904f6f', 17, 2, 'Secret Token', '[]', 0, '2019-07-23 07:29:19', '2019-07-23 07:29:19', '2020-07-23 12:59:19'),
('b5b02fa55312c50c41d7a9ed16b23a037ccb5b7e94246543b8b8c1888c02484add3decc05538f5d6', 11, 2, 'Secret Token', '[]', 0, '2019-07-27 01:26:53', '2019-07-27 01:26:53', '2020-07-27 06:56:53'),
('b6503e0a3bfb5134cadf505d05f3168ebbe188eecc1bcd5741a5e764da3cee9f3f7fa40383273362', 11, 2, 'Secret Token', '[]', 0, '2019-06-27 05:21:30', '2019-06-27 05:21:30', '2020-06-27 10:51:30'),
('b66c94a23b0364c46ac9948b429d2914778a886f19b0d36eb5e0ac9d45bdd49d15ed813f60c4b0d7', 11, 2, 'Secret Token', '[]', 0, '2019-07-02 07:31:04', '2019-07-02 07:31:04', '2020-07-02 13:01:04'),
('b779e3d35c4758815681fbea02c2093a523ba9da28f3443a3eb58aa9808931db3a00a0dc27d81f56', 1, 2, 'Secret Token', '[]', 0, '2019-06-25 06:35:23', '2019-06-25 06:35:23', '2020-06-25 12:05:23'),
('b824cc9645532837bd9a483951a023f110eb8996190da2af87647daf48396ddefdcc7568a537f8d3', 11, 2, 'Secret Token', '[]', 0, '2019-07-27 01:26:53', '2019-07-27 01:26:53', '2020-07-27 06:56:53'),
('b86b829918c356fa92efbfde61af2eb61d3d7622a505cfad1cfccc36ceea7d8ec9de4d943f13cc59', 11, 2, 'Secret Token', '[]', 0, '2019-07-25 05:26:01', '2019-07-25 05:26:01', '2020-07-25 10:56:01'),
('b87ab70487adccbaf219556c57369cbd1504718e9da60ec0aa5130041cb9a43b1894a2ec2ad6b7b9', 3, 2, 'Secret Token', '[]', 0, '2019-08-08 04:58:27', '2019-08-08 04:58:27', '2020-08-08 10:28:27'),
('b9d30d3850b3f1ff275f6f9d7f08a9a6ba920e53522c28e6687d1c99a79f6090002e2a5d48871864', 20, 2, 'Secret Token', '[]', 0, '2019-07-26 08:42:33', '2019-07-26 08:42:33', '2020-07-26 14:12:33'),
('ba06928cfe1e6bf92a02884918081cf7e1ff76dee8085ff870cfd8e25437302faa7c083c5dea22f7', 11, 3, 'Secret Token', '[]', 0, '2019-10-15 04:41:00', '2019-10-15 04:41:00', '2020-10-15 10:11:00'),
('bc30bbcbdb2adfd1ddccd3a946fca1e6b76dff6d7bf88c260b9910e55f385ddb779839de38573d99', 1, 2, 'Secret Token', '[]', 0, '2019-06-18 00:14:45', '2019-06-18 00:14:45', '2020-06-18 05:44:45'),
('bc52e421f7d9ba7b082d41a59d6e56b9cb5b7b397935b1b8e2072bae886831bb12a06c200a050461', 3, 2, 'Secret Token', '[]', 0, '2019-07-26 09:09:39', '2019-07-26 09:09:39', '2020-07-26 14:39:39'),
('bd0b82bfe37329176841a7fb84a6d69a8aa73b3b92ee3c4e9c3f1818e745fa72f8968e73f01c1336', 11, 3, 'Secret Token', '[]', 0, '2019-09-23 02:13:22', '2019-09-23 02:13:22', '2020-09-23 07:43:22'),
('bddaa4b446a3aee03bd66e23a9c71253191c7a8f1884e7bcbcddf0389a78424653dbc4fb0cb1bbf3', 11, 2, 'Secret Token', '[]', 0, '2019-07-26 07:14:11', '2019-07-26 07:14:11', '2020-07-26 12:44:11'),
('be8344426fa4ffa4591067c1eac4c31d4c938b8b90535309ddd9b2948b255d3331423e956bc82949', 1, 2, 'Secret Token', '[]', 0, '2019-07-25 08:26:53', '2019-07-25 08:26:53', '2020-07-25 13:56:53'),
('bf6f540ecefb1c9c7664b40f74b3ae2043640ada89df5d950634bef6f8c829547b5305cbafe5cecd', 11, 2, 'Secret Token', '[]', 0, '2019-07-31 06:09:43', '2019-07-31 06:09:43', '2020-07-31 11:39:43'),
('c01f3c715acf1ae2360f601c3d6c1c417595dc43ae8601c8adf4b9e4084714f8aeec2e068a7821c6', 11, 2, 'Secret Token', '[]', 0, '2019-07-30 01:29:15', '2019-07-30 01:29:15', '2020-07-30 06:59:15'),
('c10648b09b3fafbe454e3331d9d08b1593becb22d814a38a091b76bade3898a007ebeb68dee13778', 11, 2, 'Secret Token', '[]', 0, '2019-07-27 01:26:51', '2019-07-27 01:26:51', '2020-07-27 06:56:51'),
('c17df398cce4ea1897c0a4d7d3067d826526e5114d0cf620be9045a7005073f00c25f8cf7d7f7113', 11, 2, 'Secret Token', '[]', 0, '2019-07-11 07:14:38', '2019-07-11 07:14:38', '2020-07-11 12:44:38'),
('c1919127719328feb5e96bc010d814fba4517645aedc076d80a5fee30a9781a1d975b948585cbfd6', 11, 3, 'Secret Token', '[]', 0, '2019-10-17 04:38:45', '2019-10-17 04:38:45', '2020-10-17 10:08:45'),
('c1b751fd7bd2afb2595b02c2bb58c4504dad6557187f1ebe03c7a01a2d9b54623f20750d34930c57', 11, 2, 'Secret Token', '[]', 0, '2019-08-05 06:48:08', '2019-08-05 06:48:08', '2020-08-05 12:18:08'),
('c20aad1a7b0d288bc5bf9a1bda6b6a6b36e281788164c99753204775d2fdc53474e77871b5569aa6', 11, 2, 'Secret Token', '[]', 0, '2019-07-27 01:26:51', '2019-07-27 01:26:51', '2020-07-27 06:56:51'),
('c342a6352628fa31f21a25efff51d1326751d717f86fa415fb5fc61efc2f34cfecc437a56f8c6188', 1, 3, 'Secret Token', '[]', 0, '2019-10-21 06:38:23', '2019-10-21 06:38:23', '2020-10-21 12:08:23'),
('c3cfdc7c9fd8b81b74a08442316739be01323b966d89bdde84344dfb8bc05ebea5e0a6eeaff6f5d9', 11, 2, 'Secret Token', '[]', 0, '2019-06-27 08:25:57', '2019-06-27 08:25:57', '2020-06-27 13:55:57'),
('c547326f983643164025815a6deb98570d93ced32f2c5a60ab827203c43aebe31dc7e08d3cf83e85', 11, 2, 'Secret Token', '[]', 0, '2019-06-29 01:21:29', '2019-06-29 01:21:29', '2020-06-29 06:51:29'),
('c6f0be96cc197964702a4f52b648b898102426b13bbf444f34f269c3bfe2d606372594001aecdc0b', 14, 2, 'Secret Token', '[]', 0, '2019-06-28 07:25:31', '2019-06-28 07:25:31', '2020-06-28 12:55:31'),
('c701d000558511011d173bb1d57da48709a3eefdb5f368090f8ec9033cb0cd6f76adbbca82f54055', 11, 2, 'Secret Token', '[]', 0, '2019-07-27 01:26:53', '2019-07-27 01:26:53', '2020-07-27 06:56:53'),
('c7fa86cc5465bb93a735db628ef9752fb9b9dbc45af148f63ee7cd10e2cc7e701500f30052a428cc', 14, 2, 'Secret Token', '[]', 0, '2019-06-28 07:30:00', '2019-06-28 07:30:00', '2020-06-28 13:00:00'),
('c8938771bf048185fcd68944dfb77fec180daacd0a4a847dabed5b4f5996e166744fc8068cb6b5d8', 11, 2, 'Secret Token', '[]', 0, '2019-07-26 02:21:54', '2019-07-26 02:21:54', '2020-07-26 07:51:54'),
('c89e233a8430eb0bac1341da61cb2c64e05c823d0943d54ddae92d9090d39979c60fd6d287c2c98a', 1, 2, 'Secret Token', '[]', 0, '2019-06-11 04:49:25', '2019-06-11 04:49:25', '2020-06-11 10:19:25'),
('c9b513251034c07f03e747731cadeab69616d69494ddc4f30c8c9be8f5d951c40d181f81d5ea3331', 21, 3, 'Secret Token', '[]', 0, '2019-10-21 05:35:47', '2019-10-21 05:35:47', '2020-10-21 11:05:47'),
('cadf8565953f93cffb42a66ca6a315903312e8530c80b255c990e507fc7c6d32442c4074a53f6f47', 11, 2, 'Secret Token', '[]', 0, '2019-07-27 01:26:50', '2019-07-27 01:26:50', '2020-07-27 06:56:50'),
('cb2d4369e42b868d955564b9c487b9a7d2f404b96e0ae435c727bfe7d19cbab6af7c6a5fe4d59e76', 1, 2, 'Secret Token', '[]', 0, '2019-06-11 02:58:28', '2019-06-11 02:58:28', '2020-06-11 08:28:28'),
('cba4a7128d7d70fd86a5d43d585a275156eb697b90f402c21876c4177d43250a0d71dc35c9688d51', 11, 2, 'Secret Token', '[]', 0, '2019-07-16 08:15:15', '2019-07-16 08:15:15', '2020-07-16 13:45:15'),
('cbc7ff42799693bb2510e2cb736fd4efe05a11ac61deca3c96aefe5302716caf4a44af5f807cbf91', 1, 2, 'Secret Token', '[]', 0, '2019-06-25 06:52:56', '2019-06-25 06:52:56', '2020-06-25 12:22:56'),
('cbdc7716756133dc9e478e66a6b281fed1e2d1f2e6952903ee66d7995c3ec108899c858d82fa162c', 11, 2, 'Secret Token', '[]', 0, '2019-07-27 01:26:52', '2019-07-27 01:26:52', '2020-07-27 06:56:52'),
('cc4702eb2d7a131ef7af5c45fe3a890bffc4e1714a6166a51d5c5f0b465c9ca43d2c12f9f5bdbd9c', 11, 2, 'Secret Token', '[]', 0, '2019-07-26 04:41:44', '2019-07-26 04:41:44', '2020-07-26 10:11:44'),
('cc85f41a8c49bb7a7e1023797a36fb996535994cb50780711cd064b2c85add931f0c2a4d1f926489', 1, 3, 'Secret Token', '[]', 0, '2019-10-22 03:46:08', '2019-10-22 03:46:08', '2020-10-22 09:16:08'),
('cd745b4f20db4b2210ad4eb40ee7b3c504a7ffc1c66f3d948b4507d966b54fcf93e0809f6b98f1f7', 1, 2, 'Secret Token', '[]', 0, '2019-06-11 04:48:00', '2019-06-11 04:48:00', '2020-06-11 10:18:00'),
('ceba28c3d1d5df68e90a13208aca1667d3e6056cf3c4ab007a32f0ad77ff22289a756e7b5f0706c7', 21, 2, 'Secret Token', '[]', 0, '2019-08-08 05:20:23', '2019-08-08 05:20:23', '2020-08-08 10:50:23'),
('cf139509b3486e0e2190fc5333d83451e888ad50c59e16ec4e7652b37de75cdc7cd6a4c8c0b3a988', 3, 2, 'Secret Token', '[]', 0, '2019-07-26 08:53:52', '2019-07-26 08:53:52', '2020-07-26 14:23:52'),
('cf165c4ae970b1c927ec849727ed2e4fbe3757d6710b29ae2e91bf1bc74e62368c52e8ae38d9ef87', 17, 2, 'Secret Token', '[]', 0, '2019-07-26 02:24:00', '2019-07-26 02:24:00', '2020-07-26 07:54:00'),
('cf29b910024198878c2a5ed75ccb87070e020611196567944d0d5d64203c3c859f37ed5d6ae5851c', 11, 2, 'Secret Token', '[]', 0, '2019-07-27 01:26:51', '2019-07-27 01:26:51', '2020-07-27 06:56:51'),
('cfe1fe2ef1b2c7b05b64802c714d34d4fb0664876c3faf6ad787ac4dc0e37160fa95c0984588fe2b', 11, 2, 'Secret Token', '[]', 0, '2019-07-10 04:51:43', '2019-07-10 04:51:43', '2020-07-10 10:21:43'),
('cfe7fb9508da29f47588d29e21277da05f81916875a3235ad8096e9a16e78c4bb5ac9df2126d1a72', 11, 2, 'Secret Token', '[]', 0, '2019-07-26 09:03:38', '2019-07-26 09:03:38', '2020-07-26 14:33:38'),
('d0462c9b6b07134f1bd08ce31e46a37b05bec25e592a9fdad22e48f11a60a6fb3ee35c56503395ba', 11, 2, 'Secret Token', '[]', 0, '2019-07-18 04:43:22', '2019-07-18 04:43:22', '2020-07-18 10:13:22'),
('d06d4b7ecd222aa601250f759fc99f269024b83e5e5b641d1f0fd7f6b35d72b62832e41970eb1ff6', 13, 2, 'Secret Token', '[]', 0, '2019-06-28 00:48:52', '2019-06-28 00:48:52', '2020-06-28 06:18:52'),
('d104aeafa9f51ba277d9712a5b0f202a912398f847a5e4ac9488d5d709757586246c3f69b3eb28aa', 11, 2, 'Secret Token', '[]', 0, '2019-08-02 03:25:21', '2019-08-02 03:25:21', '2020-08-02 08:55:21'),
('d18ba457d5387e4efdbdda215daa0f736dbc70497feb1ec98461f9046c4eadb5e38f8f0c1e46e5d2', 1, 2, 'Secret Token', '[]', 0, '2019-06-26 05:29:18', '2019-06-26 05:29:18', '2020-06-26 10:59:18'),
('d1938f98c2a77496146291754807ac1917a4190cc25021bac065ca094d3595d0ed3918a4200ee73a', 1, 2, 'Secret Token', '[]', 0, '2019-06-11 06:36:12', '2019-06-11 06:36:12', '2020-06-11 12:06:12'),
('d1fb777c51fb6223a07c4cfca91ac180ec0b130d0a99c3f420f6d0a6e85559445d30a453a608431d', 1, 2, 'Secret Token', '[]', 0, '2019-06-25 06:36:57', '2019-06-25 06:36:57', '2020-06-25 12:06:57'),
('d2c1b3e29c70f8f5dbcf9bb57c310de3f7907fad4d75beab3bbaed7814776883fd97e8c15dd4abc3', 11, 2, 'Secret Token', '[]', 0, '2019-07-27 01:26:52', '2019-07-27 01:26:52', '2020-07-27 06:56:52'),
('d520c7f74a30611ed664e15feaae90d4d00017de7ddf76b8874ecc531b50282b23b95fa55f4a723c', 11, 2, 'Secret Token', '[]', 0, '2019-07-25 07:50:51', '2019-07-25 07:50:51', '2020-07-25 13:20:51'),
('d5dfdbf7cd35f5f33cc9e1f7d690fb6771522ee76958d2971ee7d88774a960dbb872e9c85e54d6c6', 1, 2, 'Secret Token', '[]', 0, '2019-06-11 02:23:33', '2019-06-11 02:23:33', '2020-06-11 07:53:33'),
('d61633f25111971bfe1fd5042f9cb39dc430ada9ca0e8e0d0dd942251e2986071c304238ceecc5f5', 11, 2, 'Secret Token', '[]', 0, '2019-07-15 23:44:03', '2019-07-15 23:44:03', '2020-07-16 05:14:03'),
('d64f9298f49f9809fbe6784c87cead9110b82ea900ff7fa7fcf05514d855ef504c910aab1262320d', 1, 2, 'Secret Token', '[]', 0, '2019-07-13 05:50:04', '2019-07-13 05:50:04', '2020-07-13 11:20:04'),
('d6e20b367ed1dfdf75ee9b177275e9e92fabbe5aed21d83d4e635dc19a5ffa54d113bdebc5c9cd69', 11, 2, 'Secret Token', '[]', 0, '2019-07-27 01:26:53', '2019-07-27 01:26:53', '2020-07-27 06:56:53'),
('d7c5a3b2bfbd68ea59f3ba0948ec5f7262c19ff0f367f9f57c1a91476624f6b064e045952ae352cd', 11, 2, 'Secret Token', '[]', 0, '2019-07-27 01:26:50', '2019-07-27 01:26:50', '2020-07-27 06:56:50'),
('d7e03ed4f1376bd3177c6c1e7db78942a7913dabbef3db17972994b81ef670175cccc7da9fbc4a7e', 21, 3, 'Secret Token', '[]', 0, '2019-10-22 00:33:00', '2019-10-22 00:33:00', '2020-10-22 06:03:00'),
('d97e9c96a63e3aef35c9af18bec8e7383a946f7ab4e525b3a197fe7071313e15dab8f17c419e3c89', 1, 2, 'Secret Token', '[]', 0, '2019-06-11 01:45:10', '2019-06-11 01:45:10', '2020-06-11 07:15:10'),
('db5e3989d1cee7408e4309891b515e5d3d906239c084e4c01c26bca02b6498e3dfac604f68b305e9', 11, 2, 'Secret Token', '[]', 0, '2019-07-25 07:40:36', '2019-07-25 07:40:36', '2020-07-25 13:10:36'),
('dd620024d85517163000ecc7768040400caf4d8f0f4b5de144bf12338305bac0630650e96d9527bb', 11, 2, 'Secret Token', '[]', 0, '2019-07-11 04:51:27', '2019-07-11 04:51:27', '2020-07-11 10:21:27'),
('df24df09e3850e9ff3b2c5796f05e23e3d066e6b2e81028f7e74e40e40fdd09e91d39f53832e4991', 1, 2, 'Secret Token', '[]', 0, '2019-06-25 08:42:54', '2019-06-25 08:42:54', '2020-06-25 14:12:54'),
('df41a3e8dc71bf4452b05d2067ac49453fd8d833413ea36eb4b9fb1545a3c7305a71e3d770a5b0f2', 2, 2, 'Secret Token', '[]', 0, '2019-07-26 05:26:14', '2019-07-26 05:26:14', '2020-07-26 10:56:14'),
('df5a57995e5791348221df9121521090da7af25000a602323003ac2915daf40cc5b28abd7b847c2b', 11, 2, 'Secret Token', '[]', 0, '2019-08-01 02:06:56', '2019-08-01 02:06:56', '2020-08-01 07:36:56'),
('df72cecc5076ddd06eadc069ea961c594d069e8f479b06230ce1f9da8d869a41bc16da9f5b085766', 11, 2, 'Secret Token', '[]', 0, '2019-07-31 06:09:44', '2019-07-31 06:09:44', '2020-07-31 11:39:44'),
('e07a2677e2847712ce15c05f49eccb29d79b976c5755ef1bb51b0314c892dd53cd7c87927fcab547', 11, 2, 'Secret Token', '[]', 0, '2019-07-04 23:32:56', '2019-07-04 23:32:56', '2020-07-05 05:02:56'),
('e0bbebf4a7157bdba436f73271d7a53c06011e6a9897d06e4765307bee62354af68d7f0c974b7099', 11, 2, 'Secret Token', '[]', 0, '2019-07-27 01:26:53', '2019-07-27 01:26:53', '2020-07-27 06:56:53'),
('e13ea5ef3a73d7bcbac5cea28fe7fa56e8a94298a448d916ccff8b9b2203ee516697e8a8d152a149', 1, 3, 'Secret Token', '[]', 0, '2019-09-30 23:31:43', '2019-09-30 23:31:43', '2020-10-01 05:01:43'),
('e1780d2502f95511990c19262217d96aa08b19b45890d93d0896455284f185d8c095d4a5a4453779', 1, 2, 'Secret Token', '[]', 0, '2019-08-08 00:22:31', '2019-08-08 00:22:31', '2020-08-08 05:52:31'),
('e180009d919d6e8c172cada071b6a3687ae5b6ef67f1e123fc001ac16173087bbb146e3bab147337', 11, 2, 'Secret Token', '[]', 0, '2019-08-21 05:52:45', '2019-08-21 05:52:45', '2020-08-21 11:22:45'),
('e1d6477ba64e16a8a5e4e73fc6479e9d6e3a94fefa6126aa68761261b5595166253c71e786bbca32', 11, 3, 'Secret Token', '[]', 0, '2019-10-15 04:16:30', '2019-10-15 04:16:30', '2020-10-15 09:46:30'),
('e20a9e3779ee4b398024f5c0e20b609d9dd5d0f43ad17b0b3fbd23500eda9daceac5831a2700acc2', 11, 3, 'Secret Token', '[]', 0, '2019-10-23 04:23:31', '2019-10-23 04:23:31', '2020-10-23 09:53:31'),
('e386f2f72ec373a339040b70e85ffd63a5d57b5ccdf522a8d2b2f0026487c5449ee75dfa22cb28b0', 3, 2, 'Secret Token', '[]', 0, '2019-06-27 23:43:09', '2019-06-27 23:43:09', '2020-06-28 05:13:09'),
('e3b2f680ff231b6e5931cde934d2864999ed9edd4c3694556df035cebe4373849d9bbf0e1a4fb82c', 1, 2, 'Secret Token', '[]', 0, '2019-06-11 07:02:20', '2019-06-11 07:02:20', '2020-06-11 12:32:20'),
('e3e20e7fa10c54c784c9a2e2c7df3db9fa91b6f1cdd9ef2966af9572991cb5910204510a85dc238d', 1, 2, 'Secret Token', '[]', 0, '2019-06-18 00:21:49', '2019-06-18 00:21:49', '2020-06-18 05:51:49'),
('e3e9ebbd712e751351a92e922b75739e970c63571288611f9f432fe6cb582901e994129f4ef33085', 1, 2, 'Secret Token', '[]', 0, '2019-07-08 05:41:55', '2019-07-08 05:41:55', '2020-07-08 11:11:55'),
('e4200ba9af99b6211602c34511cddaa40296f889d73df90d5b8c46ad901a7d166d8dab3595f91182', 21, 3, 'Secret Token', '[]', 0, '2019-09-30 02:12:53', '2019-09-30 02:12:53', '2020-09-30 07:42:53'),
('e47c6c8418797d13e2df7cbacad33f9e9b6bee3924433f7cedd66e3df6d9b42ca6fe3c9aa5dbd56a', 17, 2, 'Secret Token', '[]', 0, '2019-07-24 07:42:52', '2019-07-24 07:42:52', '2020-07-24 13:12:52'),
('e4ea5ea010ee1dc50fb1e8deca64c70a3bba980e8bab72517b87b97ea49dc4f7061a671f479103ad', 11, 2, 'Secret Token', '[]', 0, '2019-07-27 01:26:54', '2019-07-27 01:26:54', '2020-07-27 06:56:54'),
('e90de7bdf3faf52300a443ed2e453ee2fcdee74c88af0227696fbfe80179e7cc99fc02edff065568', 14, 2, 'Secret Token', '[]', 0, '2019-07-26 07:03:53', '2019-07-26 07:03:53', '2020-07-26 12:33:53'),
('e9762a0bc9424ecae8504af362520a36f2a6753e43331eafc0f1daaada8c081030e9648b5192d881', 11, 2, 'Secret Token', '[]', 0, '2019-07-02 07:04:01', '2019-07-02 07:04:01', '2020-07-02 12:34:01'),
('eb23c7eac181ccd5becf6042f2029a0600c4946a6899bd7c9b6f0d1b8a074c70c27cf13951e01b43', 1, 3, 'Secret Token', '[]', 0, '2019-10-22 00:34:03', '2019-10-22 00:34:03', '2020-10-22 06:04:03'),
('ebc9a5bd7dcb99f49bc9f9e7996af26a699e9897568300b7dcf5879359af0f5cc13127bdf92eaf2f', 11, 3, 'Secret Token', '[]', 0, '2019-10-17 05:57:45', '2019-10-17 05:57:45', '2020-10-17 11:27:45'),
('ecc52b8f77087eeb88cbf14981682986b00f50dc4fe15c2f35e174416e114b2eb8e71dacc6e27d52', 3, 2, 'Secret Token', '[]', 0, '2019-07-26 06:27:02', '2019-07-26 06:27:02', '2020-07-26 11:57:02'),
('eddb49f15b3b4e27b7d7c4403e33f2f8051085be70a6f3a1d77ddbb7aa67f5ece0913397cd1941c2', 1, 3, 'Secret Token', '[]', 0, '2019-10-01 07:09:02', '2019-10-01 07:09:02', '2020-10-01 12:39:02'),
('edffaea39df69491dbd58691449a2cdfea736c8990d87d48810201f217d11762fe4d7ab23c68a28a', 1, 2, 'Secret Token', '[]', 0, '2019-06-18 03:32:29', '2019-06-18 03:32:29', '2020-06-18 09:02:29'),
('ee132896dc5417a7a11fed001e1d3bdf5ab5526ce5234ba1546d6e454f0280a15ffc110720966c02', 11, 2, 'Secret Token', '[]', 0, '2019-07-27 07:02:56', '2019-07-27 07:02:56', '2020-07-27 12:32:56'),
('ef5055b3c77345a3cfbfbd1d778891db45987357a7db3a31c48610a2beac818a7c71176b68ae2153', 1, 2, 'Secret Token', '[]', 0, '2019-07-25 05:09:10', '2019-07-25 05:09:10', '2020-07-25 10:39:10'),
('efebdfad3fa4d7d791c70bd23df3f7c65b61de221651286615e3366bc30e197f83c2c21693ebf70d', 11, 2, 'Secret Token', '[]', 0, '2019-07-27 01:26:54', '2019-07-27 01:26:54', '2020-07-27 06:56:54'),
('f0a101cd1c262425ca95961dbebd5663a6b3c1e8eb8f63ca4039ade07ea36ca204a566791db1b7a2', 1, 3, 'Secret Token', '[]', 0, '2019-09-23 05:22:13', '2019-09-23 05:22:13', '2020-09-23 10:52:13'),
('f1726d4be19524b0143d48e6540e49cc7c5d902cad8a3c4751afe58ab9384043cc5cda1b7d491fc4', 1, 2, 'Secret Token', '[]', 0, '2019-07-13 08:49:34', '2019-07-13 08:49:34', '2020-07-13 14:19:34'),
('f1eebd4e8c7fccb008c86f883f21f9ccde5cfa8e1954a23fdb7fec40bc215304a34ec64057bca203', 3, 2, 'Secret Token', '[]', 0, '2019-06-27 00:19:20', '2019-06-27 00:19:20', '2020-06-27 05:49:20'),
('f24c6946c1b4660c6c3e986949b16401b684fb40d49817b26e9c157b354ebc088d168a46b7ff391c', 1, 2, 'Secret Token', '[]', 0, '2019-06-11 05:29:21', '2019-06-11 05:29:21', '2020-06-11 10:59:21'),
('f2dfd99f3a3b0aff8e965f44c8524b43b2cfcdf45d9ac487d82b18eb2767f5fbda4777791de9f0d5', 11, 2, 'Secret Token', '[]', 0, '2019-07-27 00:18:08', '2019-07-27 00:18:08', '2020-07-27 05:48:08'),
('f338f50661b380d41d3e13bac6de6c917014ff716c72b9a09b81f2283a91d560bcd10cd4efc24942', 11, 2, 'Secret Token', '[]', 0, '2019-07-31 06:09:43', '2019-07-31 06:09:43', '2020-07-31 11:39:43'),
('f34215bcf71a564aef8b28bf29f557b2b950bff3afe31c1f8bf85431737787d6e6c004bcae4feab6', 11, 3, 'Secret Token', '[]', 0, '2019-10-23 05:01:02', '2019-10-23 05:01:02', '2020-10-23 10:31:02'),
('f5745d6d92e027a939d4df9f681a1d14a5b281fc6a244a42e209b0d2cb1df587aa80a9c18e55a2e2', 21, 3, 'Secret Token', '[]', 0, '2019-10-21 08:03:33', '2019-10-21 08:03:33', '2020-10-21 13:33:33'),
('f65756318c5113e290adbcb7a0203729caf2cb7c4505664e9fbf5aa0d4518bf86be971c24ce13b32', 11, 2, 'Secret Token', '[]', 0, '2019-07-11 04:08:24', '2019-07-11 04:08:24', '2020-07-11 09:38:24'),
('f68f88bd28ebbcf632ec3836e00f62cadb132e158b7ba3cda44d4191606428aa38346164762bb7e1', 11, 2, 'Secret Token', '[]', 0, '2019-07-13 05:47:19', '2019-07-13 05:47:19', '2020-07-13 11:17:19'),
('f6f204a3bd0b007e185c71c07b1b6ae27cc13b1cfd31a889e48322226ac28c8cf5b14f3e496e55d1', 11, 2, 'Secret Token', '[]', 0, '2019-08-05 04:49:47', '2019-08-05 04:49:47', '2020-08-05 10:19:47'),
('f75f82b7328f78ef04784bc668515d7aefc7eda6bdb0116e2526c74cbe337a8e11464eff2d496d74', 1, 2, 'Secret Token', '[]', 0, '2019-06-11 01:44:28', '2019-06-11 01:44:28', '2020-06-11 07:14:28'),
('f79c3f8b88f7b80aa82a3b8ed524ef209e59327cb737b1f21d44e80c03c13241d4c0a101968f79da', 17, 2, 'Secret Token', '[]', 0, '2019-07-13 07:43:27', '2019-07-13 07:43:27', '2020-07-13 13:13:27'),
('f7e2a5653d5414bd9110dc4a3115b30208582b61a76d0512c078644aebc39f18470b446725a77529', 21, 3, 'Secret Token', '[]', 0, '2019-10-01 04:41:37', '2019-10-01 04:41:37', '2020-10-01 10:11:37'),
('f805fc4d98b20c9c09e6a2532a165ed6eca834d0a299c50546bcc3f624116e91146c4d2691f563ee', 21, 3, 'Secret Token', '[]', 0, '2019-10-21 23:17:09', '2019-10-21 23:17:09', '2020-10-22 04:47:09'),
('f9c47be4cca2e3051049865539b8292239f8a1d699843cfcf3983f5cacb3f4696e9d848e4d461ae1', 11, 3, 'Secret Token', '[]', 0, '2019-10-21 05:30:46', '2019-10-21 05:30:46', '2020-10-21 11:00:46'),
('f9f59241ce31632a87c79cfd2e28d038ca8bceaba1c3b90e1f494e802c08ccd63e2913f6953dbc62', 1, 3, 'Secret Token', '[]', 0, '2019-10-23 04:37:43', '2019-10-23 04:37:43', '2020-10-23 10:07:43'),
('fa083d19e8137f22a817297eca07c3904f1358777485f7916fa7e7766bf52a6886e96a7ada012b3a', 1, 3, 'Secret Token', '[]', 0, '2019-09-23 04:44:19', '2019-09-23 04:44:19', '2020-09-23 10:14:19'),
('fa322df883f9d02e330674cdc5c4a064e8a450eb80820593e5dd1915dddd45957422696fb9587fe4', 11, 2, 'Secret Token', '[]', 0, '2019-07-27 01:26:54', '2019-07-27 01:26:54', '2020-07-27 06:56:54'),
('fad7c78d02d3fd03666ec250c294458855f43f834bcef069e5574bdf347af2f7318743adaff19b9b', 3, 2, 'Secret Token', '[]', 0, '2019-07-27 00:17:28', '2019-07-27 00:17:28', '2020-07-27 05:47:28'),
('fad948b79776a8f6dd110b527d92bf744c4209e239fb04ba1eb37c126096fe8930743f6eca332c58', 1, 2, 'Secret Token', '[]', 0, '2019-06-26 01:48:56', '2019-06-26 01:48:56', '2020-06-26 07:18:56'),
('fb7463e601516e826a3ee8e3471647cb727cbe8b410b4bb698d5ce78a286908ced82c26ae160c4bb', 21, 3, 'Secret Token', '[]', 0, '2019-09-30 04:22:47', '2019-09-30 04:22:47', '2020-09-30 09:52:47'),
('fb9fb82215fa43c7e3b65f128e7f9bd83a848789d94c36f6a166365efba6f5cc55553f5f9e6b98e4', 11, 3, 'Secret Token', '[]', 0, '2019-10-01 06:49:17', '2019-10-01 06:49:17', '2020-10-01 12:19:17'),
('fbc6bede02ad64bc0a4969b4b4fd28201dab79d5b745b21f4fc155bb88cba712f28da28fe7b053c2', 11, 2, 'Secret Token', '[]', 0, '2019-06-28 07:42:00', '2019-06-28 07:42:00', '2020-06-28 13:12:00'),
('fbe846ce9b421776408f0fb8e71bf6350324486c9f33a56f8e25f2546abfe99f0e18622d30a30b3d', 11, 2, 'Secret Token', '[]', 0, '2019-07-27 06:59:05', '2019-07-27 06:59:05', '2020-07-27 12:29:05'),
('fd03713c2de8c1f917efae1913e51a30ee8af73c27483a7167f49aa8958d5a89b9eebb6b92976c2f', 1, 2, 'Secret Token', '[]', 0, '2019-06-18 00:43:36', '2019-06-18 00:43:36', '2020-06-18 06:13:36'),
('fd043281b2eb8e28a6914f2a2e701bdc080d42d94a79d07be7577fa854cd08e464d6b47aa5305bdd', 11, 2, 'Secret Token', '[]', 0, '2019-06-29 06:43:51', '2019-06-29 06:43:51', '2020-06-29 12:13:51'),
('ff24052250c3409c17994ed8e29376e724059b464cd6485a8e743e47e00cd94435a62a0633534c2a', 11, 2, 'Secret Token', '[]', 0, '2019-07-26 01:32:24', '2019-07-26 01:32:24', '2020-07-26 07:02:24'),
('ff6edd9ca5adc2fcc895475e9f3b7ffcc82371f55bbd0b5498bf00874efe990ee9b1f5c44ede380a', 3, 3, 'Secret Token', '[]', 0, '2019-10-15 04:30:06', '2019-10-15 04:30:06', '2020-10-15 10:00:06'),
('ff9951c78564425c19492e0ea1f3fcb0f77ada3a93a1bab2f66fc78b35a8835dd5f789ee06416cda', 1, 2, 'Secret Token', '[]', 0, '2019-06-11 01:45:58', '2019-06-11 01:45:58', '2020-06-11 07:15:58'),
('ffcdc28dac97bfe70cf5a84b1894622f2202cde84696626579f90f6f9ecf9618852c8dc256e3b969', 1, 2, 'Secret Token', '[]', 0, '2019-07-25 07:41:27', '2019-07-25 07:41:27', '2020-07-25 13:11:27');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_access_token_providers`
--

CREATE TABLE `oauth_access_token_providers` (
  `oauth_access_token_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `provider` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_access_token_providers`
--

INSERT INTO `oauth_access_token_providers` (`oauth_access_token_id`, `provider`, `created_at`, `updated_at`) VALUES
('000559654a3a39878d2de40ba9a6458d3bea5b98034253ab7350a394e10ffdff40af536065e7ee81', 'companies', '2019-10-16 07:21:47', '2019-10-16 07:21:47'),
('004f0769a88393847916faa2592559e8b81f7b880fb8cdd25f30efa41898c039ad0e55daf8918466', 'companies', '2019-07-27 01:26:53', '2019-07-27 01:26:53'),
('010705f20cdf021f3de198f41665e5629d2f49cd24a296d81dc7a980836999cdfff2b0b494a22399', 'companies', '2019-08-05 04:22:38', '2019-08-05 04:22:38'),
('015bf62377ff72f97bfc855661b826b9114b0bc325fb43586d1ba501234e5b2e782abb611a19766b', 'companies', '2019-10-17 04:38:29', '2019-10-17 04:38:29'),
('0315649d5f05aa7d063ce0a65ce8e6ad56176d327c2fa317fd40c54919fed555f796798462973f5d', 'companies', '2019-07-09 05:04:06', '2019-07-09 05:04:06'),
('038b931cb97fb259ac4798c30727b8fc30adcecfb03045159b457cff6c0f459a0fe158c562543f90', 'contractors', '2019-07-26 02:18:05', '2019-07-26 02:18:05'),
('03dde96c9f2346efd1febb4b80fe46894e10f0ad1b880e8f262503faabf5059724bd094da371588d', 'companies', '2019-10-23 04:26:54', '2019-10-23 04:26:54'),
('043dec65ecc170f8b8722c39ba74cfc37719354697e43fbec864664304062642afc31ab2b256635d', 'companies', '2019-09-30 02:50:06', '2019-09-30 02:50:06'),
('04552a7e6640d25e87dde9e4a433894f422b394d8a8482fb46d305bd982706f8a10c34df6911cf92', 'companies', '2019-10-22 01:45:34', '2019-10-22 01:45:34'),
('050201f31d54c9a82b83a04fa98b3eac087fbddc2436a417ab356bd8bd857d05001b2cf3be565605', 'users', '2019-06-26 00:15:09', '2019-06-26 00:15:09'),
('0700cb3edaf22b1567b2041ed50c7caaf43232b7a951f8277e47fa98dd636f595f050d8f09c91d9b', 'companies', '2019-06-18 01:49:50', '2019-06-18 01:49:50'),
('08b912887bb189e9fc86c7ccd3499031b460ac014f88f9055584e9d288a32de7fa41885ffb868094', 'users', '2019-07-27 01:17:19', '2019-07-27 01:17:19'),
('09052eba2f39ea8497be155cdf4b400d412d3cc4a96baf3b00a0e2ab84de2ea9f0f075dfd5a267b4', 'contractors', '2019-07-25 06:09:16', '2019-07-25 06:09:16'),
('090a1c1c7fc88fdba25bf68c15a104a7ff284a3d8e75a9a75c193a2c011cdfcce34e8eacf506fe4d', 'companies', '2019-07-09 04:34:47', '2019-07-09 04:34:47'),
('09cfece0202203127121459a36b4ababb2307ff86dee982f2d7510999152ee1095cc21a700ca02bd', 'companies', '2019-10-15 04:43:13', '2019-10-15 04:43:13'),
('0a71f36ccf1aba96899211ce4147947346f692dc249ad1de72a4da5ea658df3fcc15433a50116f55', 'contractors', '2019-07-25 08:51:57', '2019-07-25 08:51:57'),
('0b55d294d939d5e2899b932eebb56dd4ff22b131ca3192c8f93dea313471cbe3383c271ceae9b36c', 'contractors', '2019-07-13 07:18:52', '2019-07-13 07:18:52'),
('0bd4ffb8dbde0ba540335b46d6254f257c43132c0a35bb7c699ef0b54db301052f17f14996039eeb', 'users', '2019-07-13 08:22:28', '2019-07-13 08:22:28'),
('0c3a77040552970949db720e17e4f85dd1102926c919e1c8883d77f389daa34ee601f17927792531', 'companies', '2019-06-26 00:32:48', '2019-06-26 00:32:48'),
('0dc377001b8aa74edf6a3e08e29dc08ccde879d96b293ecf2ecfa3968df1472c516bc206b7f8ef62', 'companies', '2019-08-02 01:30:40', '2019-08-02 01:30:40'),
('0de5054b27c3172f54df58df7937e50c6b6e121092687deac126b241acbadafb584bab423e494ca6', 'companies', '2019-10-21 05:41:43', '2019-10-21 05:41:43'),
('0e59d5e3fc33842a7bab8f101a3556714c54d579aa9128840aeecf29e1b7bae97422b2be34c747ab', 'users', '2019-07-12 08:39:43', '2019-07-12 08:39:43'),
('1024fb487779fadc301e6b591586742249c5fb361a4b4778e4730dc07e3fd89b6e6e6bf02d30fdea', 'companies', '2019-07-26 06:12:24', '2019-07-26 06:12:24'),
('10bdcad6e079aff6732c83424c6592021758b14d189ee3c19e21c65843565d933621f77509e1d69b', 'users', '2019-08-08 00:39:31', '2019-08-08 00:39:31'),
('10c77a6ce441f4616f0adaf843d0bd5318368d3fe6fc2ce8b76fc9858c157ca7b380035ef4cdc82e', 'companies', '2019-06-28 00:39:16', '2019-06-28 00:39:16'),
('1205794cad99a08a80d2ad4f0de195c89555f047a38e9b5ebe64df57b3bad80c8295e25457f6d70a', 'companies', '2019-06-25 08:26:03', '2019-06-25 08:26:03'),
('12096b9ee987d2ad10953e60923897e8a5dd5d8f59f69c3127e3c943f81e887dbbe0dfc57c374d07', 'contractors', '2019-07-26 00:33:29', '2019-07-26 00:33:29'),
('1298ff292944ba6f7ef941723ee9ad128df558b4bebc8d1a58c827f049677fb9af26d3861156495d', 'contractors', '2019-10-21 01:23:16', '2019-10-21 01:23:16'),
('133b67b681d4712d0ae030cfd56647b16f385859ddd22706366762bdf71a4e6defa2bec3aeecc7e2', 'users', '2019-10-22 04:25:56', '2019-10-22 04:25:56'),
('135a95dc43e066d0fef68fc291f1493a303ccfe7bab3513ac1ffd4e385fe57b6ef001b5a35bdb755', 'contractors', '2019-07-26 06:26:05', '2019-07-26 06:26:05'),
('14db95712a7b9b39871aaad4ca5ec47592fe3a122caa5d44cbfd3a6aac02dff212f91b5e318d00ab', 'companies', '2019-10-21 04:41:14', '2019-10-21 04:41:14'),
('15e08746e1c6915e28cc5945d7cbf8b3e91d2c7cce2e10a781ad50d52d33443361ecdc4e5b612161', 'companies', '2019-06-11 04:04:36', '2019-06-11 04:04:36'),
('160471a5940472b2a0348cd719a6e7b13b1ea1ec92f340cb6d6b032e2dd5ef8b484466e7cfd5de5a', 'companies', '2019-07-27 01:26:52', '2019-07-27 01:26:52'),
('16895ae01fc9f847ddf49021d17c4c1997ef49db0d2c1fc7ec7bcb7ea8f97f1e83e92f043105a60c', 'companies', '2019-07-31 06:09:43', '2019-07-31 06:09:43'),
('1691b4411cac672e26b75b0341b4146fc6d98c555af0b4b16645d032317f745a66fc4bc6ee58bde0', 'companies', '2019-07-09 08:45:17', '2019-07-09 08:45:17'),
('17156a59189f572bdb612554ff05cb89034d26c2b406a328e791bcc5426db90ed9e6e7b75bee19ed', 'companies', '2019-07-26 00:30:51', '2019-07-26 00:30:51'),
('17690bd26e9106f2c8d95a2981af3fdd2d52bd9f4eb45a12fabefcec8c197f6f98a67d66845806de', 'users', '2019-09-23 04:37:40', '2019-09-23 04:37:40'),
('17d8466fc2b1bca564c91da4023b6fbfebacb22c9fee4f93ae6c88d0ae85d9a817360437582036f4', 'contractors', '2019-10-21 05:21:51', '2019-10-21 05:21:51'),
('185eb3c6b0743bbbee037d6eb878c38336b6daa0d68c181d707e70a70607f745aaccdc3e31623182', 'companies', '2019-07-27 01:09:26', '2019-07-27 01:09:26'),
('186783692858c7fe0b36c3bee245eea74a05dcd9f26dd1655ed10f3a58568f4a629874c314847885', 'contractors', '2019-10-15 04:29:30', '2019-10-15 04:29:30'),
('18b2f6539b86d367c3ee47006e8e9d7a678871d221e8cfe809eefd312816a4ceb022fe5b0339851b', 'companies', '2019-07-29 04:45:38', '2019-07-29 04:45:38'),
('1ae0969b7904d4972563884033928fdda91051e2212d5372a94723077ba49808dccd0860b448def7', 'companies', '2019-08-08 00:59:43', '2019-08-08 00:59:43'),
('1b305f8ff6f15cea0b9b244efa77803c4844d73b012f96d2559520278a0decf7aaaaca65727204ad', 'users', '2019-10-23 05:44:25', '2019-10-23 05:44:25'),
('1b3114442767d9c74f44d96a499abec19a5d7b2e4728eee4630830348bd6aaeeaf74f942d0fb6eec', 'companies', '2019-06-27 23:45:01', '2019-06-27 23:45:01'),
('1c52a2c4d63f04dcbc77905d4a3d540d4332494a747676d4d994c7e37a309e8b1e56b312c638ca5c', 'users', '2019-06-25 01:15:50', '2019-06-25 01:15:50'),
('1c982295a438da07bc7807bfdb2e9bc094bf1c7811ecad038d73bdd7d28c4b50f3fec04c7d8f73b2', 'companies', '2019-07-13 07:32:50', '2019-07-13 07:32:50'),
('1ddcaf3615a033b0cef1056e3dab12c58632d3654a867954c784271557ba334f571b10bad79fdf4d', 'users', '2019-06-11 07:07:52', '2019-06-11 07:07:52'),
('1e0548d5502eb0236c12b8d1141fce7a04fb8838847533e01102edeaae22da27913a564829041225', 'users', '2019-06-25 08:36:15', '2019-06-25 08:36:15'),
('1e72a57f7e83718a1b640e85d206e0eda1d0cb22debef092886920391701ca53d047f6af5707be5d', 'contractors', '2019-07-26 01:38:45', '2019-07-26 01:38:45'),
('1e83fd293b1c3713cda9cc4f3c67b1f07ac9856d8af5d17a4a74d62e5c010ee8d8f6e2811d635ee5', 'companies', '2019-10-23 06:58:48', '2019-10-23 06:58:48'),
('1ed28f4ed2b0b6e55d289946d8f3f4583cf5889eca663c18f49901a6111e5a7c4dbdfcdda5d021b8', 'users', '2019-10-22 00:57:40', '2019-10-22 00:57:40'),
('1ee33c55240de7aa10da09d85738e8bbfacf65477c16cf5704dbb44d27a8ca376ae82c6bf211b539', 'companies', '2019-07-27 01:26:52', '2019-07-27 01:26:52'),
('1f81577445225687c59a64b9438be130b1b5b254dc2d67e0735202d24340f1721be064ecdfab089f', 'users', '2019-06-26 07:39:34', '2019-06-26 07:39:34'),
('1fdaccbe0b2f6505db93c4fa240ec13767d7a6ed7c0c64cae724d0dab1f18f8b6a7b747f5b708da7', 'companies', '2019-07-29 04:33:18', '2019-07-29 04:33:18'),
('1fe6436d9ac128866459c9fe69da0b72c4ee330c7387f887d517a490c9189f31a71126e6b475f045', 'companies', '2019-10-01 07:44:12', '2019-10-01 07:44:12'),
('1ff061cbf8b67f62873e0ce618948bb6ad038db5eec34e74e16dc4ac81c777ddd38f6156c58b1511', 'companies', '2019-07-26 01:29:55', '2019-07-26 01:29:55'),
('20181db7569363f1155316dd1e36ba59d6f4065112d13bf808b59085cbcecb602606ab47205163e4', 'users', '2019-10-22 02:16:56', '2019-10-22 02:16:56'),
('22b78bfc127c56fec513087ce04fe8a80d515a2c1fe0334b645da33fa64d91e57590404e1e8f6374', 'users', '2019-09-24 00:00:59', '2019-09-24 00:00:59'),
('232e5fb4c04d951afcb85d7e62e014b1d3cae13bbe5b27eb80e4127a9027a96f5a8e3fa3e66d5eb3', 'users', '2019-07-26 06:39:59', '2019-07-26 06:39:59'),
('2411ca054ddcfad213e7e2cf06213435c2024fab90dd8fd79ecaddeae6a249a61e2cf1b2b5f0f28a', 'companies', '2019-06-11 01:43:48', '2019-06-11 01:43:48'),
('247ee53bcb14ee390798fb64c517db2d4d000ba5182294e0409ef2caf4a22d6f8703e31877265b68', 'users', '2019-06-25 01:01:47', '2019-06-25 01:01:47'),
('25ba2a51d49e9b6899762f21990a531973f1fcc23102d4064262cd067bbbef9e9ad716b52f80ac57', 'companies', '2019-10-15 04:18:55', '2019-10-15 04:18:55'),
('25f42d59c42472d47c5c38e7197078919a05795cf308bd4af7832aef84bef4b397791aaa8dc18960', 'companies', '2019-09-30 05:41:21', '2019-09-30 05:41:21'),
('262c4f73df5887331be510ee5f4751a328aec2fef986f3afcb9cc6a07095820fec7b62bbc7506704', 'companies', '2019-07-27 01:26:51', '2019-07-27 01:26:51'),
('264d68e4d00ebe4f077bccc9e91832b43e87642f7405df2fcb7878521783f58c525cf8212ab321d6', 'companies', '2019-09-23 04:39:20', '2019-09-23 04:39:20'),
('264f8de556e55293e3c64f6bef8e0f0850b16306da2a5fde09c4d5c9b0ef9da1fab3bf201e71cd88', 'users', '2019-06-11 02:56:51', '2019-06-11 02:56:51'),
('26f19c0ec15f0721254ccc85d187580d8d8dabccbaf9fb23a8e2da38175bf580d70fd3cafe6132c5', 'companies', '2019-06-26 07:41:52', '2019-06-26 07:41:52'),
('286805d61ffd350b1c1aebde7fd0781d604d8ae7ad06972437ea028d40509ba08f7d22e634490abf', 'contractors', '2019-07-26 02:02:37', '2019-07-26 02:02:37'),
('2aa6ae5ca971efce3f82cb1a375616ea26b5a3b9dc2bb548716349d42a361ab0c47547a7fe8ec01c', 'companies', '2019-06-28 03:51:36', '2019-06-28 03:51:36'),
('2b84e223ee78f1acc5afea154f278542b2371518979591244fe0a3a576997bdb4ca83ba48e996b2e', 'companies', '2019-07-13 07:35:12', '2019-07-13 07:35:12'),
('2bb07e161fb0371c75a2e226f1fcd199939ee78114b28da2181990b083a0a36511dc44fac99d8dcf', 'companies', '2019-08-08 05:00:26', '2019-08-08 05:00:26'),
('2bbb62b0e340939d9ab348ea79c5007f9373e98b85969a20093dbfb03e72416fcbc17ea2382d0de4', 'companies', '2019-06-28 07:43:21', '2019-06-28 07:43:21'),
('2cdccdde8a03d387453dbfb49b830fe88a7faa67484b9ba7b1e55bbe5303634923f96662aba21a90', 'users', '2019-06-28 02:35:30', '2019-06-28 02:35:30'),
('2ce3737249bba71a167343f5b634bd0195fc58dacc701a587ecf993379e06c7a68d7473bc7d8de56', 'companies', '2019-06-11 01:41:02', '2019-06-11 01:41:02'),
('2d5ff752c5f3d2ea82a895a60799f24a207101dc2e29d3db6e1e7e378bb22ffbd15decda3cec8e57', 'companies', '2019-06-27 23:42:27', '2019-06-27 23:42:27'),
('2e8886afc4e4fe07963832e1cce330920453cad7b65144cb1169e20f3bf3074aa959009c325f62a5', 'companies', '2019-07-02 07:05:16', '2019-07-02 07:05:16'),
('2eb0a058df7fb48db4aa51867a02df3361d0376dba310397def5c0e53c8ab8f3c5b7d8497bf2e999', 'companies', '2019-06-25 08:42:31', '2019-06-25 08:42:31'),
('2fbd4c5229c6db0dba6e76b475cf8088d7e38f47263ae52561549f15a2a828c2449e2425f71415c8', 'companies', '2019-06-25 08:28:58', '2019-06-25 08:28:58'),
('3082cbc226eee68c3dfccb92941d522078f2103b2ad4bdd6d135aeba070c835dfd6b12f3adbf8d67', 'users', '2019-06-11 02:53:47', '2019-06-11 02:53:47'),
('3098e566cfb42be616873a87ca49cca8e4ee3c673cbe89d6dfcb830aef6986545fefc0e88bbf201f', 'companies', '2019-10-20 23:24:59', '2019-10-20 23:24:59'),
('3161773e694cbc38273bdf5e07dc426de2d3cd001931ea30dc5cc1e70dad862d779aa03a577c3112', 'companies', '2019-10-15 04:13:52', '2019-10-15 04:13:52'),
('321a9703eeb75887f23e41c56aedae6f8f0fb45d3e1b94f0df5d7409d38beb3f78ca5a4a9eab12b1', 'users', '2019-06-27 00:58:02', '2019-06-27 00:58:02'),
('32b59d7e393981179dc1a761eabbe2ca90e198cf1e2c7207ae36e5e53c398a01feaa6c955ad3d426', 'companies', '2019-10-23 01:41:16', '2019-10-23 01:41:16'),
('3321780e9200a433394d0f332f435cb91bc57a3587f0abc6447ed616f0bc27d9cde6181f00129602', 'companies', '2019-07-25 06:25:41', '2019-07-25 06:25:41'),
('333ecbfd43732889c5ab7991800b24419b1a966357ea614f491716639d9c3db1f8afb3fe78514f68', 'companies', '2019-08-01 01:07:07', '2019-08-01 01:07:07'),
('33746bc4b974b7ce09fd9194de9b22b9318a5fe2519ea1132e9bc2442aaae3529f121450db9806c9', 'users', '2019-06-18 03:32:48', '2019-06-18 03:32:48'),
('3407d428468e26d66aea5719b7aca336b63f2d767512874717a27f1827362bf60fb3691c2f23e926', 'companies', '2019-07-13 08:48:14', '2019-07-13 08:48:14'),
('354c79d39e7fda866be08cf31a964dc614cd0a87d0ababc1263edf78fbfbc2330bb4accb470da432', 'companies', '2019-07-27 01:26:55', '2019-07-27 01:26:55'),
('37064d3ff52f53de6fc4911215edc1700c0a21ef7b3f1ef6e67986c25a641fc00e018241ec70a4e4', 'companies', '2019-06-29 01:19:24', '2019-06-29 01:19:24'),
('379a787d4171daa0598af8e70c9da1a6f978ba8ee9455c9a3ff2cda401c58c2de09d735b873e86cd', 'companies', '2019-07-27 03:49:25', '2019-07-27 03:49:25'),
('39731ab2cf1cd99587be829f9fef6699ea5f890c589d7972b3eaf1b43f6aa1ad6f3949cb0e138b21', 'companies', '2019-07-27 01:27:40', '2019-07-27 01:27:40'),
('3c84935348dd51fef0f25fa4c568371a1bb09f02dd54bbdd0c60eb679b65cd5e205e921a2f615bb0', 'users', '2019-09-30 02:21:23', '2019-09-30 02:21:23'),
('3d9ced3b92fd624bec27c38a12f3b97261be34006a735eaf453e4b6dd56f75ad28ac9397438490b8', 'users', '2019-06-11 02:52:47', '2019-06-11 02:52:47'),
('3de33d23f95100f425d4a9136a1ffa2760a601f68ddaef1c6954fb3241bfd14fba8babd90430b673', 'users', '2019-06-11 06:05:52', '2019-06-11 06:05:52'),
('3e887f99af700fe56ee3d1be67ec8303faceccaa54a5c6b0efefd3112468af07d86cdbfb67d2b4c3', 'companies', '2019-10-23 06:37:33', '2019-10-23 06:37:33'),
('3ed874cccc9fc51d4d1e16bf14a856f7490a99ee2c3322fbdf4c9c57434d073ef23244011e64d204', 'companies', '2019-07-26 08:21:33', '2019-07-26 08:21:33'),
('3fc9f397b06c35a1c4bfe6a0c12ef7613ba03e231d52cf9ea0cca1c8316c6d644df049230730e3ef', 'users', '2019-10-15 03:59:45', '2019-10-15 03:59:45'),
('404a6b4d1c0e435e837d7dbd2993d1d252a71358f7e5bb780e75056ac9ec7e3c6e798910761eaf65', 'users', '2019-06-28 02:37:13', '2019-06-28 02:37:13'),
('406c3c40d4e892d9ba5314222334d6e4ff942606d14cac38eb225da3576af191a5fdd8db2cfd6a36', 'companies', '2019-09-30 04:14:01', '2019-09-30 04:14:01'),
('409a5e4990818673c55dce7de9bc304ad79fb0f921615136eebff0f72720224915288101c1792c68', 'companies', '2019-06-25 08:43:21', '2019-06-25 08:43:21'),
('40de3ef72573a126bc2bf5cc1abe9ff28913adce133e384c407ce57085525d1e7fe3e095ca541a97', 'companies', '2019-07-03 08:40:27', '2019-07-03 08:40:27'),
('416d2ace5de97b940db15524eeca4dcd0686d31f54aff9f6f3e0b8f37f9946cfe61dc556b9c223fc', 'companies', '2019-07-31 00:30:07', '2019-07-31 00:30:07'),
('417635bcdc0f372e6f1847a193f3d86b6b71051332dd51741486ea66f54f287fa665f9822f7cf11b', 'companies', '2019-07-27 01:26:54', '2019-07-27 01:26:54'),
('419bbcd89dd62ed1f11ed1b4780f47024e4dc826a112e450033904f31c6ea1f202e5b759fd692d6b', 'users', '2019-06-25 08:30:32', '2019-06-25 08:30:32'),
('424c8157e3ff7483bb4fad9c8e48af168c7a36ce2ad7c8354b6f6ebf91e72a5bab8c338048208ceb', 'companies', '2019-07-26 03:40:32', '2019-07-26 03:40:32'),
('426269af2821396fee9f3e7ce9806f55c182668934f75a1b5949073e48857217d9eb040a0e1b57b2', 'companies', '2019-07-29 00:24:10', '2019-07-29 00:24:10'),
('42cb606d59cf74e8bf7c5b0c6c2e07794b5330599a04e7fa0fa419eef2c6824503365c3f14ec5711', 'companies', '2019-07-24 07:36:00', '2019-07-24 07:36:00'),
('431dccb9c939054a71819b3a137e379165ca1af2f6a8e1fc937c7c9cb27c98e155e80d49b3bafbbc', 'companies', '2019-09-30 02:13:21', '2019-09-30 02:13:21'),
('441492041a073c853b83526295c8c43712d99c90df86d3ed8caca7c71c3d2c30344fea6bab70bd0c', 'companies', '2019-06-25 08:23:34', '2019-06-25 08:23:34'),
('44c7cfe7b96cfe277a658060d91848def24fcfba359870491583acab8fb271018cb0d3a7d66a7f96', 'companies', '2019-07-27 06:40:18', '2019-07-27 06:40:18'),
('45798843604d5659c332d88189ff6df93ee069492a3e63c9e189e241c9acd61a9058e3eabf090aa7', 'companies', '2019-06-29 00:10:09', '2019-06-29 00:10:09'),
('465f4159efcfed74662a67a0b46d69f5f5842dbadcba58062e7e2abc3ed241fd79768cc9c3d3c3f8', 'companies', '2019-07-27 01:26:53', '2019-07-27 01:26:53'),
('471e5d24d3f600bae2ddbc2367c50674a349c10ee91b6c1c0f1f0ab577df9e38c86c8175c5b0ff55', 'companies', '2019-09-23 05:22:38', '2019-09-23 05:22:38'),
('4732ac319b463133e2eb10c826fdf04745a76d322c0b8fbfeefac358f33d1d8984945c6aacb39ee6', 'companies', '2019-06-27 23:50:42', '2019-06-27 23:50:42'),
('476aab6ff5b3711d727a2e8a6fcacbb80bf83de5323eadc58801e9c1dd62e0a3951171c1555c6bed', 'companies', '2019-07-29 07:42:13', '2019-07-29 07:42:13'),
('48a562686306af42cc23c04d42fb5b225ada5864d1245361586725394fab2013c6acdc78a46755ed', 'companies', '2019-07-31 00:14:22', '2019-07-31 00:14:22'),
('48b21d2c7de45e80184f43f6a55977be16bbb75902f25006a27b492087e4201692c45721de8e8ddf', 'companies', '2019-06-11 01:48:07', '2019-06-11 01:48:07'),
('48eb51799ff1468361b3dfa8404e3350b894e7a66818805c4f1ac00c62bc24e0811b164c1ea3059b', 'users', '2019-09-30 07:55:09', '2019-09-30 07:55:09'),
('492081f4232255ef56d29c18b25469e01d48f0e0e618c4a10a835b23084db4c3a722795a557a4e7c', 'companies', '2019-07-25 07:38:37', '2019-07-25 07:38:37'),
('4aaa9cc739721b69c8ede3ef19e11d2cb97bddb27aa60cfcdf567d4783e2f0d3545456cd2b4717df', 'companies', '2019-10-17 04:39:07', '2019-10-17 04:39:07'),
('4abb7146fd892c3c4e65831638befa4da0f832d3876b4b83c4d8b912125e25726a180b00b88afc4a', 'companies', '2019-10-22 00:29:11', '2019-10-22 00:29:11'),
('4ad2e993e25397e722ab9676c7e9c8e3dfe9a803c83ab1db90bcf658cb171c2a7dc7b9dfcf27b5e7', 'users', '2019-09-23 02:20:02', '2019-09-23 02:20:02'),
('4cba96dabdc62341c38813e06fe67de9ca47dc4a4e679782217d3fc7e9dd42c4996ef1c9005524ef', 'companies', '2019-09-23 02:22:22', '2019-09-23 02:22:22'),
('4d6596bd58d9025b2adc74a3809314ff1826f11356bf7c432680ee565db975252542e2cdc9e13b06', 'companies', '2019-06-28 08:11:09', '2019-06-28 08:11:09'),
('4e04cdf5c9f4ef42490da5f9c508a5be98a4f0c145982904ce791f8d6847ebce5168f4fdfa73489a', 'users', '2019-09-23 06:22:30', '2019-09-23 06:22:30'),
('4ee15dfb2a116042fe17e79387f3444e8b614c7e9993431d34e77b46cb2d8c0737fdcae51331c055', 'companies', '2019-08-08 00:02:32', '2019-08-08 00:02:32'),
('50fe02a75d288792b13cb3d48c8e76c004a01fd637fc3b335f11bfb1e7280af3ce64419e4d2944be', 'companies', '2019-07-26 07:20:43', '2019-07-26 07:20:43'),
('51be3f51fdb1af29b9e8236359e493e5bfd04bda2561a13bea9d9a997bd73bace898e60945297b23', 'companies', '2019-07-02 06:58:22', '2019-07-02 06:58:22'),
('521cead9bcf9f9caeda6b25221de3d8744c43083fcf2a740bf0c78fd4d5587122bbb638ea32455f9', 'users', '2019-10-22 03:45:32', '2019-10-22 03:45:32'),
('54476ecbc8679695e1b45d131411205ed11f4a32e6bc3e157f16d9f73a3fb525ec5628d12970b5e2', 'companies', '2019-09-30 02:11:39', '2019-09-30 02:11:39'),
('546950d777df3d99974ba9cfff599275b42aefcf9a6e81a7257569f4bb15c79dcfa61093219c121f', 'companies', '2019-09-30 01:15:59', '2019-09-30 01:15:59'),
('54dfdac48d941739fb22fdcc31fd45aec9ab2f6cdc614140bdf9614c35be55b8e3dd8dffccb2c34f', 'companies', '2019-07-26 08:40:11', '2019-07-26 08:40:11'),
('55547575f31d80b3741766ff5c2998bf2c52c133c5c56612104f895b08b9a4011ac59499ba808ec0', 'users', '2019-07-09 08:44:00', '2019-07-09 08:44:00'),
('5668b46b90e74178af5e0564af3c413077588ed3724cc328faa5785f8edebf3c465e7bc47339f94f', 'companies', '2019-10-23 04:17:47', '2019-10-23 04:17:47'),
('56fa2185db63d14b32ce91b5b8f110a0c6d0d56b623efb627c2ff0687844986ba5ecb3a50071ed7f', 'companies', '2019-07-31 00:01:42', '2019-07-31 00:01:42'),
('57434c1c5d46ac4f16a421513b90c958f04c96d0ee4d809db5f4d39e0399277bdd51bc3b3cf23cb0', 'companies', '2019-07-27 01:26:54', '2019-07-27 01:26:54'),
('58b599a3c940d2285ecb47bad017bd20161e7cfe71a0a0251aa5e98fa07c3db813c98ba51b13b44e', 'companies', '2019-07-24 06:03:31', '2019-07-24 06:03:31'),
('58c3ddeadb06e0e3ab346f8c2f445e31948c373acccf331d55e7a738390af5fb4964f042c2180a2c', 'users', '2019-09-30 02:49:20', '2019-09-30 02:49:20'),
('58e12cfd75555d1432b8b6825c315e37a217395308d9c0d7b3cdb64e29ea31dd3aee8b718611f0a7', 'contractors', '2019-10-21 05:22:30', '2019-10-21 05:22:30'),
('5965ba92d54a16840f0bf03fa51b2073667606fa2dc876b06ea66528a6004b4365a43037ac8c9584', 'companies', '2019-07-09 08:47:28', '2019-07-09 08:47:28'),
('59b3fa1ad185eb683d63b152626f084092d1c76adae984160cd382a5b6585f531c4ebecefcb054aa', 'companies', '2019-07-09 05:03:39', '2019-07-09 05:03:39'),
('5a231f9b156e0c456354a87dec4d16167a10d52f94b71dcefec823cde083bf821b3711347616e40f', 'companies', '2019-08-08 04:38:12', '2019-08-08 04:38:12'),
('5a7d21be25e84d603fcc51ddabe28da1f564d289dfb3badfc3a8006ac32d3572fe50c40706af1133', 'companies', '2019-07-31 06:09:43', '2019-07-31 06:09:43'),
('5a93461523598ff477afd8b0df196b18c07d9cef883af65dd8d8a22547a8707a6c7a281c6a6fc141', 'contractors', '2019-07-26 00:02:37', '2019-07-26 00:02:37'),
('5b26213b57dbaceb0e6529ebb1389fdfcbccb9a9c76183658d0456515bf75627dab4341988f3514f', 'companies', '2019-07-30 05:41:41', '2019-07-30 05:41:41'),
('5ba19b3408a615a5daaf6c56f0fd8ea15d56bb82503b4b5fc49ebbfd2f4c89ed3c13ae3e07095cfd', 'companies', '2019-07-31 06:09:43', '2019-07-31 06:09:43'),
('5bd0677a8a0f6f395b42a0c985f5fd508ebe24ab13f314a60619052f327c042df61769269ed1415b', 'companies', '2019-07-27 01:26:52', '2019-07-27 01:26:52'),
('5bd0b7f2d5be3b8dd8102ee765b218e7770e3f66c9915c1a0d0c22d93fd9ad13a76e52e5d2db97eb', 'companies', '2019-07-27 01:26:53', '2019-07-27 01:26:53'),
('5cac073a5cfaa174dddcbeefc9ea96745e4dfb683b209c6cbf22ac04d0fda6b76de956c6c861bf30', 'users', '2019-09-30 04:41:08', '2019-09-30 04:41:08'),
('5e25c78d3bdbf9136431532163ed43b1e377cdaf72d1c2883b3be0d393dcb2e575c1905adc85fda1', 'companies', '2019-06-11 02:22:07', '2019-06-11 02:22:07'),
('5e9d6bbecec584a7144dfaf6ff678599a66d140c3e1da148f5eed3bb264935eff1bde02e1dbcdc23', 'companies', '2019-06-11 05:35:15', '2019-06-11 05:35:15'),
('60a7a1b2ea13f7f66ea771f94071f91a2eab7c2bcb55e9e4286cd9959e26a70d3afb66c9596e13bd', 'users', '2019-10-23 01:46:23', '2019-10-23 01:46:23'),
('61334e7dcf72e1936770ef933a7be107f26d9c459b8cca8faece4476b690ad6201b43d4c7aa1d4f1', 'companies', '2019-07-27 01:26:54', '2019-07-27 01:26:54'),
('613da49b26b6a3fccbee7f03404d95d829728cee5f9e95e01ed3f62a9532ffc4d9991eac4b0a291c', 'companies', '2019-10-15 04:36:55', '2019-10-15 04:36:55'),
('634035e2c03f1100686ece5a1d0c189b851844554167317ae394b8432908907902d25c7106b126ce', 'users', '2019-09-23 23:59:44', '2019-09-23 23:59:44'),
('64138da1d519e9ac1a248d72d113a17576dd63f4cfd305e508f9566071586ffe269346ea04fd581d', 'companies', '2019-07-27 01:26:51', '2019-07-27 01:26:51'),
('649bd728fc059b96e777c1b70ba02d53dd5dd725a83486e1be4d3dc6b063f80d142fbb3e05dea627', 'companies', '2019-09-30 23:32:34', '2019-09-30 23:32:34'),
('64d6a9c62eb8b15871193aa061a98716a89045094c2f23b78e81a9d1f87e263eeaf5a91bac9c9190', 'users', '2019-07-27 07:01:24', '2019-07-27 07:01:24'),
('65bce4e5870238873c6115cc0cd6d5bab125a8efabd4f89055a388844cf4102b89b66ab25b0885d2', 'companies', '2019-07-26 06:53:24', '2019-07-26 06:53:24'),
('65e09fffca12b285e5bcbdd4d7189354b335df509693d7650f964d22b14ee1e0e5282153fafa6261', 'companies', '2019-06-27 06:11:10', '2019-06-27 06:11:10'),
('6720ca362fa10d9bf09f0e2e459145aa7181b9497ee8caedc7640157d8ed33a0fdafec43bcec2253', 'contractors', '2019-10-15 04:41:18', '2019-10-15 04:41:18'),
('676f6f381c1c094035248a35539b3d981042e7792cb6d8bdbda8afed0fa9e76246695160463c8026', 'users', '2019-10-21 05:30:19', '2019-10-21 05:30:19'),
('6832f07576d1e1c1cba2315f157042bd8723aef4c2992b9a38e1416fbd82a1b8b17c834222957d79', 'companies', '2019-07-24 08:23:45', '2019-07-24 08:23:45'),
('6910e9d7f8ba601d382595795f74dce4ea630f073bbf664d45dde513bd50d3759e1c893971992714', 'users', '2019-07-12 23:16:21', '2019-07-12 23:16:21'),
('6981d3b9b0abff020cafe2d6a5f2cca583505cb8a1b71116ec126fccc99215b8764d712d7e28fb75', 'companies', '2019-10-21 04:35:02', '2019-10-21 04:35:02'),
('69a2c4300bae22a0f3e25cde08891794f523f78d2b9e54626f3b94d6e9f73bb2c70c8adafd838a10', 'companies', '2019-07-24 07:53:10', '2019-07-24 07:53:10'),
('6b0e33d007284a296bfc5bb0ea95ca059e0b47f3c1770e09cb0447e83e332e3234c1f3985780ed47', 'companies', '2019-09-23 05:46:25', '2019-09-23 05:46:25'),
('6c1983a1fb21a9eb18dca581e8cc6f9263665b3d4c27aecd6d69619646f60823e9e88a2986271f99', 'companies', '2019-07-26 08:59:38', '2019-07-26 08:59:38'),
('6d7b9a862181a6afc94c2bda0c2f367fc1a1a353907dc4030a202ae64d92a717c912a8a69d8018f8', 'companies', '2019-07-27 01:26:54', '2019-07-27 01:26:54'),
('6d86923c92fad162097396947506b090de792573331e692c0d6e554d72430a9ceb70bb9bf2400116', 'users', '2019-06-25 00:47:49', '2019-06-25 00:47:49'),
('6dea621399d56c6a2fa3d4c3afb3b9e5b20799bc95d83a4fee12fdd9cad0af80d2dd61df96c2ebd5', 'companies', '2019-08-02 01:07:37', '2019-08-02 01:07:37'),
('6fb09a83c772c6dca9fd0182ef0dd087797a6f9d24a1b5e8ff5e6a5176b9f79bcfd8e705ae56061f', 'contractors', '2019-07-25 06:03:37', '2019-07-25 06:03:37'),
('713975a8a30e0e850aeabbede40d49053a43f4084b445367543eae380fd37304222d8997aeeb4eca', 'users', '2019-06-25 02:30:18', '2019-06-25 02:30:18'),
('7189080fb3de8a4ed1a94b57039d46388941ebabffdb807bd1bffd395e6f5b6ff3970b55a2f125ca', 'companies', '2019-07-27 00:09:14', '2019-07-27 00:09:14'),
('723d1174c5e270de87ce2ace758561b5047bfbcdde64521e85f36bbc36c98f108241fe2b0b53ccc9', 'users', '2019-10-01 07:43:51', '2019-10-01 07:43:51'),
('725e9cbf262fe5a71c9d3be1d3ad8c16bd933bb535f06ace337ea4f50fb0a601b47c3539fb45b4be', 'companies', '2019-07-23 04:18:28', '2019-07-23 04:18:28'),
('73291a7670928f28e61e47762e13a348c83e86da709dc28973b8a654451fc86f6a5e72f83f91ea1c', 'contractors', '2019-10-15 04:30:46', '2019-10-15 04:30:46'),
('73382fea9a98acc864f7154ef3377a460b4f1d68048bde2fa0fa41347429b2914f850cc68752abdb', 'users', '2019-10-23 04:18:04', '2019-10-23 04:18:04'),
('741e3dee8a1cd43734de10ea4e0e9d689d908bb13c725cb2f8b23ae5701d43bd0f9fbb23b51e0d6a', 'contractors', '2019-07-26 06:30:14', '2019-07-26 06:30:14'),
('7435acdc4fd39fb04da2728dbc3f8176da3c1549f63fd5056390db365cfb8d875b69ec29234bad54', 'companies', '2019-07-26 09:04:54', '2019-07-26 09:04:54'),
('745e553a46a343b1b078880311e61d4abbf172bfd2f0605ceb0e542a7e63a6f9ab685219c92b2522', 'companies', '2019-06-11 01:30:45', '2019-06-11 01:30:45'),
('745ed345897f6547e59137a492f3f6ffb197de0c87a23bdb8484a49a11fd7903300becf69e251740', 'contractors', '2019-06-28 08:14:11', '2019-06-28 08:14:11'),
('758a66918db19849d6fafc5bcb6ab5ba3a1bfccf959c67f321c31cacb1e8096f75511d6fc1745e88', 'companies', '2019-09-23 04:45:35', '2019-09-23 04:45:35'),
('7657fc1dc183c6248f1a669e37f25bed073dde9e7b8ad6ba1ff04ed6c83a93cc1fd874c46e0c1084', 'contractors', '2019-10-17 05:00:50', '2019-10-17 05:00:50'),
('778dc8d6013edf3dd65c17c6571ece99dfbcee281e8c28635b455c39ac88489ea7a7a1f3f583c8a6', 'contractors', '2019-10-21 01:34:05', '2019-10-21 01:34:05'),
('78653871e9d13b62dbd420d42d6059808f8d782500d653cb7bef8d8fee937dba9d1dfd493cdcfee7', 'companies', '2019-08-08 05:23:43', '2019-08-08 05:23:43'),
('790858bbe4aff2f40528025e57dad253fe2dac0096e4bddb594def685653ee0846257f9a37515cbe', 'contractors', '2019-07-13 06:46:19', '2019-07-13 06:46:19'),
('793bbbd7994b5e4096c3484d9b4bde279885d8fa8179bfc13ef3b1f7190ee6c2be641cc287dbd8e4', 'contractors', '2019-10-15 04:44:39', '2019-10-15 04:44:39'),
('7948dacb89efd031d3fe2918e367cfe2c3dd2362c4769e2bfbd5d9e9ababd333bd8e26b486d68a1f', 'contractors', '2019-07-26 01:30:18', '2019-07-26 01:30:18'),
('7aaf5748c2aa9685859e433e70f1051fa81f4f62282b125aa106d06a7ea2ecb868b59a94a2360c4e', 'companies', '2019-07-23 04:32:23', '2019-07-23 04:32:23'),
('7ad70d815b0b39e5ab172fad4e2c1cb1419018e0f76a1e5af2968a928ffabc7e8a60f3e552cebb80', 'contractors', '2019-07-25 07:18:39', '2019-07-25 07:18:39'),
('7b0f9073fc7ca5e87d2c599fe8ebbd9b36eaa1a265838a7e709c0f74e5246db04a1bde4562f8b51d', 'companies', '2019-07-29 08:16:34', '2019-07-29 08:16:34'),
('7b10c7212fdaa16767dc92c069c0e00dd5fc9fd07c960817c388a7aefd545f46483c5c4cd9d01bc7', 'contractors', '2019-10-17 05:09:28', '2019-10-17 05:09:28'),
('7ba6460aeed9dd40145196d4b0e4f23814083416bc297a3ff10edab5c21a39fdfb26d0ab0d8d99f5', 'companies', '2019-07-27 01:26:53', '2019-07-27 01:26:53'),
('7bf2bd4554307f19ed4a4c364c3c7b2b8fda559e8ef24f5ebbeb62ef1221292de4d37cc6330f15ff', 'companies', '2019-06-26 06:24:40', '2019-06-26 06:24:40'),
('7c1d866f400e89aad22c6ef0844de48d3a0f6381aa5f58080b0aa20fafe6cf443a399f56f7fd6f1e', 'companies', '2019-10-23 04:17:18', '2019-10-23 04:17:18'),
('7c24d75453ff571f64315e386db532eb639511db91c0ebd049d4ee779828a2dae8c1a2a541296fd5', 'users', '2019-06-25 01:06:03', '2019-06-25 01:06:03'),
('7cac555db4966fc517c1d28082ada7f286668b3214ffa288223a22d239da838143ce97688e1d9ef0', 'companies', '2019-07-24 07:50:49', '2019-07-24 07:50:49'),
('7d082f347659a7b46feebd8106acdb3adad497f1de6885fb63a03654b822d69fa3d056135a675be8', 'companies', '2019-07-27 01:26:51', '2019-07-27 01:26:51'),
('7d347df9282786cdd46dd700a0aff50aeea6a1cc5c2160105335cc7d6c786fac4084e4272f15064d', 'contractors', '2019-10-21 04:26:42', '2019-10-21 04:26:42'),
('7dae3e89ad2fb7b256dc148095a8a81daaf9f0fadc424fc5e4d8f841b550eee060ef39a9cea19f8d', 'companies', '2019-06-27 23:53:26', '2019-06-27 23:53:26'),
('7f6244d1b00f4eaed049a8e9ebc75a289640cf8fa0eeb29fc91da65942ab553112e350b95ee8d7aa', 'contractors', '2019-07-26 06:31:35', '2019-07-26 06:31:35'),
('7fd2dbf7f222663f6cb512236a2aa743d13aa365511508399f5ada2becf34cb9fff8dc646d5cfd58', 'users', '2019-10-17 04:39:46', '2019-10-17 04:39:46'),
('80b8e06aa7ba996bdad76648cbd266d7c85a6cf6b6969e1b346c85588d32fb6eb7b9c7bcc24ae2f3', 'contractors', '2019-10-17 04:38:08', '2019-10-17 04:38:08'),
('80f93477731bfdeca14465048ff913be38a535cd7432d01d30ce7438229f8bfb1ee7fe563c5ed509', 'companies', '2019-06-11 01:18:52', '2019-06-11 01:18:52'),
('8165d9fd1921cf295d93350991aa0980e1ba47434a1955df6f2d23c5a001115db50ea61eb216dd29', 'companies', '2019-10-01 07:08:35', '2019-10-01 07:08:35'),
('81d91710be03612e21d40f531ce7b8871d7d2b8dbcbc545a07dd8d290c09b3996bf72d24b6549066', 'companies', '2019-09-24 03:56:34', '2019-09-24 03:56:34'),
('821c778e1494505744140e15974c8feb85b4a698616017f47e8168fdc1bbeddb2449d391ec9cb1d6', 'companies', '2019-07-26 02:25:24', '2019-07-26 02:25:24'),
('83116435e80e5fdda9fbddf8b771eaa81f85f1b95f463c28aa2432eb8a84cfa81e4ae76efb948761', 'contractors', '2019-10-20 23:26:59', '2019-10-20 23:26:59'),
('838abbfc5a1671057844c2e4e971529598a664c76067c24ca5fc8aa9fbf8b63e33d760dbd96e1860', 'companies', '2019-07-26 04:03:02', '2019-07-26 04:03:02'),
('83cac983ff87650f71e95e4d99af49508dada1e768a546eb091c269e8ab52b57ec18cdea644260ef', 'companies', '2019-07-23 07:24:48', '2019-07-23 07:24:48'),
('84491e9418772c45b1c943c7daf6cc46a6bb96c912912ead542add222b8589d2b38e4401375f3f68', 'companies', '2019-09-23 06:21:49', '2019-09-23 06:21:49'),
('8480bfe24dc3b639b4ab4604340e4ec1e56aa5610a70a6f182260256dd06d9b5202e33d8c9350463', 'companies', '2019-07-24 07:35:26', '2019-07-24 07:35:26'),
('85eb5fb12b93bdecab00bd7d594596c08e95d9289db5d56d73a0b5cd2fbb98b3a7ff50cf3732206f', 'companies', '2019-09-30 23:38:21', '2019-09-30 23:38:21'),
('863e86380cf58c2de5dfe92b7d50d7fc528cbcc9c9679652f4549a6e8112910b46d147c754d0ae91', 'companies', '2019-07-30 05:56:34', '2019-07-30 05:56:34'),
('8673f10ac532a13a120a430868d2c792917e93ea272cae481112690007978352c9ebca3b56faa6de', 'companies', '2019-07-10 00:36:45', '2019-07-10 00:36:45'),
('880207de083d6aed62462cd52b1d6ba47c235b45df1aecfd4c289dc9f1285cf582b237903cdde0bb', 'companies', '2019-07-16 04:16:58', '2019-07-16 04:16:58'),
('8817687f1ce936d83f0926dcc497168557df7f69dc5201e04fcff538dc600c1a0e631b36b52b4da7', 'companies', '2019-07-09 05:10:20', '2019-07-09 05:10:20'),
('8a24cef08d1cc6ddf403efad27522c9cd1668ca718df020bc24466fd5fe7f980d9a295bfb03e562f', 'users', '2019-07-11 00:06:45', '2019-07-11 00:06:45'),
('8a5f7e6862dca34fbea2966c9e7135951c069736ae7d9b26ac1c256862d7ce9f20ac9549b67e96f3', 'companies', '2019-07-09 00:55:17', '2019-07-09 00:55:17'),
('8a9da9dc4f4e67de03a10e0d1e32b0accf340f26f34bb3406a7f7981cc2df94e54f2249f7882ed1d', 'users', '2019-10-21 23:16:50', '2019-10-21 23:16:50'),
('8afa5aa1e0242fbc567859059dcbb45e2146e8caca396d9a7f9fefe5157f94e93169d9ebb0d42575', 'companies', '2019-07-27 01:26:52', '2019-07-27 01:26:52'),
('8b52d029c0fb118950d30a22510a3011819ba4d4b13e29f870972ac6990ddd5c523cfc00031b58cb', 'users', '2019-10-22 00:32:10', '2019-10-22 00:32:10'),
('8b5e448a1a30877949a2e0f0d340874abc74f4d1c4e5c77fd511a24cdb6c8011a4e01ac3b139d77c', 'companies', '2019-09-30 23:30:21', '2019-09-30 23:30:21'),
('8ca0325314c5d13ad2f9dbb3026a8a5076aef602471f92cc3132a468f09a0d8ba70f24062cedfce5', 'companies', '2019-07-09 08:06:48', '2019-07-09 08:06:48'),
('8cc203ab2538c58a9f18de3eab250a38169beb46c123190ec3046c959b1e00ddf91b5bf3c3f43b31', 'users', '2019-07-26 06:32:24', '2019-07-26 06:32:24'),
('8d058511e047256e568a552c9e071793c0360c80684e817fe0d67b43e869e49ae0822562d610349d', 'contractors', '2019-10-15 04:36:28', '2019-10-15 04:36:28'),
('8d79f40c9864fb6436be434524ba150ba79e4ca7e274e0de578a73adb7e860f258ca3345d6ce249b', 'companies', '2019-06-18 00:23:29', '2019-06-18 00:23:29'),
('8f8a1471b01f1323ae9b0cf6b2538da004e402a0538927d27e5bd930744fe09ef15d6a563cebf44e', 'companies', '2019-06-18 04:00:10', '2019-06-18 04:00:10'),
('90196ddf9d9cc42c8bc2f693365a226031ed6a6e774981010abea28e421c38220e969a4a343ebea6', 'users', '2019-10-23 04:17:33', '2019-10-23 04:17:33'),
('913086b2e0619584c395d118447ae5ff2f898ec70e2e4297e1c98a42888d2777beed7b2e09b3ce14', 'contractors', '2019-07-26 07:34:36', '2019-07-26 07:34:36'),
('913d555cc9aba2ae8918b8ebae528a05b533df8f2f7530938cd36e4bb8951d343751bd3c317d675d', 'companies', '2019-06-18 00:20:42', '2019-06-18 00:20:42'),
('91ccb19a3b243e33473eec0ed9efd0c6dc03c90614509b90c80bf4edde16c7d13b873ba9f3d92b30', 'companies', '2019-07-09 05:02:24', '2019-07-09 05:02:24'),
('91dce4344178548083b488d2938b6e672cde5031d279d2a3408238366e5919fe8522ef204e0f56a3', 'companies', '2019-07-27 01:26:53', '2019-07-27 01:26:53'),
('923cd67facee8aeb60c6eea3564d6a539f2b372607df5746174573f62bf87dc1760bab7879dddc9c', 'companies', '2019-07-13 08:58:10', '2019-07-13 08:58:10'),
('9275ef5e5c39467a87166725156faca7085ce1b43853c9adc1ba7aba9746e304e1b82d54e84f5cc0', 'users', '2019-09-30 01:21:22', '2019-09-30 01:21:22'),
('92cea7bfcaef00922e8ed5337e33d0d8baf520ccc466f817430f67c9b4588229e30baa19cc08c721', 'users', '2019-10-15 04:24:18', '2019-10-15 04:24:18'),
('93fe9abeb2c27c3bcd0eb338052f39703ab5f2227985f62bcbb876e647c2d846f133cf591dc6ca6f', 'companies', '2019-06-11 02:28:10', '2019-06-11 02:28:10'),
('9507679a184ef3c042798b8810de5091b60d1d7d350670e8da5af99784348c8090282d32ba377166', 'companies', '2019-07-11 02:16:18', '2019-07-11 02:16:18'),
('95caedcac2b704347cae579e2bcf99e475730987377bfe10f319d9fdb1ef299fd674505624f6bc0c', 'companies', '2019-07-24 07:51:35', '2019-07-24 07:51:35'),
('9650a822fcfe14cfda2613e272b8ac38d5f8ce1308c2770ad80898e2cb31d71f7e52651f754357bc', 'companies', '2019-07-31 00:14:43', '2019-07-31 00:14:43'),
('96cc9156f926dfbd14819d6ff891ac29db665d752c3143cd9dbfb42ab0036089be34c3d11a0852db', 'contractors', '2019-07-27 01:41:14', '2019-07-27 01:41:14'),
('97467427b3c1f9ba3f2bed9f68d0a77161c2c68a3960a4eb556ae13184eb313b404b44fce22e41a7', 'companies', '2019-06-27 04:16:39', '2019-06-27 04:16:39'),
('97c727639ef23154bfb4c60e7efd1290f4a6ecfe183dc8e890daa6c9b594b623af59fa6a71534c6c', 'companies', '2019-09-23 23:59:16', '2019-09-23 23:59:16'),
('97d0793233016c43adaf0c729185ff2119da72b4d467f77c59bdc2a30cf15b075bdc5050a120ddd4', 'companies', '2019-09-30 04:06:07', '2019-09-30 04:06:07'),
('97f57e26accf9fbfd821ad48f109a2962e499183572171efaf65070a55bce07b82aea819aa2b0e6e', 'companies', '2019-06-11 01:11:31', '2019-06-11 01:11:31'),
('986a3ddc59c53e586bf223884d31e58dc3250fb93ada900e33c732d8265ecd39a9e6796579aab6c0', 'companies', '2019-07-25 07:36:32', '2019-07-25 07:36:32'),
('9927d45cd68391dfb8341b5f8a00b54811ba3894406d8988638b84243745673b2a6d8fa72829fd51', 'companies', '2019-10-21 00:02:37', '2019-10-21 00:02:37'),
('9931bf44e5eec30a4fa2bcbab23ec4ad257b189435b300996eb8c64dd208e686c9aa2bd4660a7308', 'companies', '2019-10-01 04:16:37', '2019-10-01 04:16:37'),
('9a062261c202ad88f6d98181ec5c5c0024e96ed31b610dce45107a527e32362657ca30d73f8ada7b', 'companies', '2019-10-21 01:22:29', '2019-10-21 01:22:29'),
('9a333ee2282465abfbd43b6e2315334a1ef391bb5273dcb0b0febe9f4b794ecd3feb5baecbd937cf', 'companies', '2019-07-29 03:23:12', '2019-07-29 03:23:12'),
('9a5d86ef7ae219e7791e0f92c9030f3d14515809f4d18d245ea306b88e8f968e2789ef45811e85d4', 'users', '2019-10-21 23:43:55', '2019-10-21 23:43:55'),
('9a757af8295b4ae2e0d48ab141e312d23b24b819a63324b5bcf6829763ea01953572b534d36ea0f8', 'companies', '2019-07-24 06:36:10', '2019-07-24 06:36:10'),
('9cc2791972e497e9895086f916c36257168427b411d9b608954feb09afb773f3b4b3107598c24e63', 'companies', '2019-10-22 01:44:33', '2019-10-22 01:44:33'),
('9db42e67db7e3d4532d4c6062824009dab14c145dd15f83d3390fde451f615db4e396013d4e57532', 'companies', '2019-06-11 01:35:45', '2019-06-11 01:35:45'),
('9df7036f6dddb09318453b9c037fc404ded3d514c7d643ba2e4bc319cd2d38c6ac8974a7a302718f', 'companies', '2019-07-09 04:48:41', '2019-07-09 04:48:41'),
('9e3bb83f69e7da94e902119832aa77023d081866cccbed87890d282626e74dc6d07b80803eff4e1a', 'companies', '2019-07-31 00:04:37', '2019-07-31 00:04:37'),
('9e49c52e53ba50997d17308293bc7f887dde8a55c24b1b056490eff241c91b1ef7ad8b3052e1fcc6', 'companies', '2019-07-26 02:24:24', '2019-07-26 02:24:24'),
('9e8293a39c1f33911701b170abd402072712c44bc0bd6a506e5c0b73a965bb1f61ccd9ebb406c750', 'companies', '2019-07-31 06:09:43', '2019-07-31 06:09:43'),
('9ee469eb67df2abac3d56cfc471af2d12bb9400507b93370056eb33069adfa25739a606d43037c22', 'contractors', '2019-06-28 08:12:46', '2019-06-28 08:12:46'),
('9f2dc6701dd9948d43e56a4bdc6485373649435a13f5886c39d0fe824315d38f047282b54f887819', 'users', '2019-08-02 01:32:58', '2019-08-02 01:32:58'),
('a08a27d25dc15f2d8bbf3771ba3a9091c604d0b16e0edd1f6f56604feb2c925abb939cf1ef50d32b', 'companies', '2019-07-09 04:46:12', '2019-07-09 04:46:12'),
('a0d931527b1cd293e5cfa77873001b35524aa8c963c30112fa19c8e5a79df2638f018a6f48749723', 'companies', '2019-07-27 01:26:52', '2019-07-27 01:26:52'),
('a12130da0933bc90c9dd07c10bc5873077a936c722926e7cb9e2d8c2b4cad46c75ff14c08cecc592', 'contractors', '2019-10-21 04:22:45', '2019-10-21 04:22:45'),
('a3fdf0ae7315d6a7b505304fb172cfe9fd89fb150a4f8c073fea22a8a658b38d9d279540eab24667', 'companies', '2019-07-13 07:37:57', '2019-07-13 07:37:57'),
('a437494fa7f597b9a8f82a0d02255029b513bb39a81e4807a8fbaf61ef9f201c8b5fab8081b18162', 'companies', '2019-08-03 04:02:11', '2019-08-03 04:02:11'),
('a491b4a6dcc0448aaa2b933c732aa7b2c1938ccb7d87f6c0266eacbc683890be421e52ffeef1b07d', 'companies', '2019-07-26 06:54:59', '2019-07-26 06:54:59'),
('a4b809643659cbff5368324dfd61270535b8c86d45077c5926ce1856f68df1fe7727f67a7f97aed2', 'users', '2019-07-08 00:56:00', '2019-07-08 00:56:00'),
('a4e89f72f6e3bf761718c09949c78cb491e8e080fdb398a123c3b5b9f471261d0168ec8e548e84a6', 'companies', '2019-07-27 01:26:55', '2019-07-27 01:26:55'),
('a68ff2dad309a338401d8b309b30b96c71271d5f7bdf3ff533f07dc159726d95cf108b6b3b5005ae', 'companies', '2019-10-15 04:29:45', '2019-10-15 04:29:45'),
('a69353273c4404241c24a663613b55f9873fd17487c6d15b62872c786d8260ca9b9aae104d495e5a', 'users', '2019-09-30 01:44:08', '2019-09-30 01:44:08'),
('a752386a8efbef67c621db36c35dc54fcbe7687b50c63cfb158621a0dcbfbe3097ab9af76f9f7c97', 'companies', '2019-10-21 05:29:15', '2019-10-21 05:29:15'),
('a841b155abd74c4e484954f7206e3a68c92ab2c75b322091452304af0b2d3645b73c25bf9b812a69', 'users', '2019-06-26 04:45:52', '2019-06-26 04:45:52'),
('a9436446b7471612841b047abe986e9834d99d78b401ab25f35f72e3ac6049cb2c1282fe18ea7d7c', 'companies', '2019-09-30 01:37:38', '2019-09-30 01:37:38'),
('a99ca705dca32b169e72ad5cb27245f6e05ac16a163dc45ecd5368394d3960878c8356078dc0da32', 'companies', '2019-10-15 04:30:20', '2019-10-15 04:30:20'),
('abc034fdade61e1f8a27a488b51a47d70205551cc16f3bfbe3b6742502f3e8388145021fea8a381d', 'companies', '2019-06-18 01:48:23', '2019-06-18 01:48:23'),
('ac62f764d9ee9c982afeecc9a809d52befc1855cd2bc393292a594724cebcdeb8fb4e50bd674cb20', 'users', '2019-06-11 06:35:02', '2019-06-11 06:35:02'),
('ac7bc45e259cf4ccef93e923a28eabf82ca8d176a4a3cb226ee57ea79c8937a0361d77aeec3c0358', 'companies', '2019-10-23 04:33:04', '2019-10-23 04:33:04'),
('ad0e77cc6c09ea0dd030c5dadf53c78eebc3705488d84144dc1c0711eeda0a9be0271569b5273aec', 'companies', '2019-07-07 23:53:50', '2019-07-07 23:53:50'),
('ad5eabd2620e43b5e79ca5fad559684fd9fd1de63303fa074a7551295ade05ebfa0737debf9be22f', 'companies', '2019-09-30 07:29:30', '2019-09-30 07:29:30'),
('ae017627277ba8f54a74f20236dc0fcb7e86bba638931313f58232e7006464e7922c403adac24714', 'companies', '2019-06-28 07:43:21', '2019-06-28 07:43:21'),
('af012168fe078da5a8ace4dec878f39d7db5e135bcef5bc713d82b95f5001498f0d8a6e35794482d', 'users', '2019-06-26 02:05:44', '2019-06-26 02:05:44'),
('af27a9e27ab6a12764e87b589389a7b96100d190fa01df664c2d3f9f54578f838e547545f4e2e30c', 'companies', '2019-10-23 05:55:22', '2019-10-23 05:55:22'),
('af40590e25571094035b70603a68514171da666e9f4bf4b32d3a1f273d7a9a22ecd81434bde6ef00', 'companies', '2019-07-26 07:02:33', '2019-07-26 07:02:33'),
('b0205a665ffc8447bad8196a3a6219c07d5be8c42161481e4fefb0c2854fbc3d2c56f99bbdd68e1f', 'companies', '2019-10-15 03:35:44', '2019-10-15 03:35:44'),
('b0dda895510f2afedae80ece5a1adfa82fc6737dee93b31da83f167fd725c0c098517f908bf14283', 'companies', '2019-07-27 01:26:54', '2019-07-27 01:26:54'),
('b14796e3b1f9fb2d17029b31330bcf57a2599f06a84383f7545c2ebe3801c3bca289077a902adaed', 'users', '2019-10-23 01:41:36', '2019-10-23 01:41:36'),
('b1609f6fc903a9a29b6ed0a90f96b0b6a31429361b9dd0c1982c7e61e7c776107b3504d7d7394141', 'users', '2019-10-15 04:18:38', '2019-10-15 04:18:38'),
('b320e37cfd8f34470b5c044e3c53acf321b84eab16b9af87b19d939a379c4a3d8b9fd928783e0775', 'companies', '2019-09-30 01:43:25', '2019-09-30 01:43:25'),
('b3291b538c25599662f50ece8dbd0a7a481215e1bda42f8128d817158d961f83dc7e6a7443290294', 'companies', '2019-07-26 06:08:11', '2019-07-26 06:08:11'),
('b4651d22f5ca4b314f3cf163dcbbd5bbcacf700d75a9542241b7331408da631d3fb05c4f43904f6f', 'companies', '2019-07-23 07:29:19', '2019-07-23 07:29:19'),
('b5b02fa55312c50c41d7a9ed16b23a037ccb5b7e94246543b8b8c1888c02484add3decc05538f5d6', 'companies', '2019-07-27 01:26:54', '2019-07-27 01:26:54'),
('b6503e0a3bfb5134cadf505d05f3168ebbe188eecc1bcd5741a5e764da3cee9f3f7fa40383273362', 'companies', '2019-06-27 05:21:30', '2019-06-27 05:21:30'),
('b66c94a23b0364c46ac9948b429d2914778a886f19b0d36eb5e0ac9d45bdd49d15ed813f60c4b0d7', 'companies', '2019-07-02 07:31:04', '2019-07-02 07:31:04'),
('b779e3d35c4758815681fbea02c2093a523ba9da28f3443a3eb58aa9808931db3a00a0dc27d81f56', 'users', '2019-06-25 06:35:23', '2019-06-25 06:35:23'),
('b824cc9645532837bd9a483951a023f110eb8996190da2af87647daf48396ddefdcc7568a537f8d3', 'companies', '2019-07-27 01:26:53', '2019-07-27 01:26:53'),
('b86b829918c356fa92efbfde61af2eb61d3d7622a505cfad1cfccc36ceea7d8ec9de4d943f13cc59', 'companies', '2019-07-25 05:26:01', '2019-07-25 05:26:01'),
('b87ab70487adccbaf219556c57369cbd1504718e9da60ec0aa5130041cb9a43b1894a2ec2ad6b7b9', 'contractors', '2019-08-08 04:58:27', '2019-08-08 04:58:27'),
('b9d30d3850b3f1ff275f6f9d7f08a9a6ba920e53522c28e6687d1c99a79f6090002e2a5d48871864', 'companies', '2019-07-26 08:42:33', '2019-07-26 08:42:33'),
('ba06928cfe1e6bf92a02884918081cf7e1ff76dee8085ff870cfd8e25437302faa7c083c5dea22f7', 'companies', '2019-10-15 04:41:00', '2019-10-15 04:41:00'),
('bc30bbcbdb2adfd1ddccd3a946fca1e6b76dff6d7bf88c260b9910e55f385ddb779839de38573d99', 'companies', '2019-06-18 00:14:45', '2019-06-18 00:14:45'),
('bc52e421f7d9ba7b082d41a59d6e56b9cb5b7b397935b1b8e2072bae886831bb12a06c200a050461', 'contractors', '2019-07-26 09:09:39', '2019-07-26 09:09:39'),
('bd0b82bfe37329176841a7fb84a6d69a8aa73b3b92ee3c4e9c3f1818e745fa72f8968e73f01c1336', 'companies', '2019-09-23 02:13:22', '2019-09-23 02:13:22'),
('bddaa4b446a3aee03bd66e23a9c71253191c7a8f1884e7bcbcddf0389a78424653dbc4fb0cb1bbf3', 'companies', '2019-07-26 07:14:11', '2019-07-26 07:14:11'),
('be8344426fa4ffa4591067c1eac4c31d4c938b8b90535309ddd9b2948b255d3331423e956bc82949', 'contractors', '2019-07-25 08:26:53', '2019-07-25 08:26:53'),
('bf6f540ecefb1c9c7664b40f74b3ae2043640ada89df5d950634bef6f8c829547b5305cbafe5cecd', 'companies', '2019-07-31 06:09:43', '2019-07-31 06:09:43'),
('c01f3c715acf1ae2360f601c3d6c1c417595dc43ae8601c8adf4b9e4084714f8aeec2e068a7821c6', 'companies', '2019-07-30 01:29:15', '2019-07-30 01:29:15'),
('c10648b09b3fafbe454e3331d9d08b1593becb22d814a38a091b76bade3898a007ebeb68dee13778', 'companies', '2019-07-27 01:26:51', '2019-07-27 01:26:51'),
('c17df398cce4ea1897c0a4d7d3067d826526e5114d0cf620be9045a7005073f00c25f8cf7d7f7113', 'companies', '2019-07-11 07:14:38', '2019-07-11 07:14:38'),
('c1919127719328feb5e96bc010d814fba4517645aedc076d80a5fee30a9781a1d975b948585cbfd6', 'companies', '2019-10-17 04:38:45', '2019-10-17 04:38:45'),
('c1b751fd7bd2afb2595b02c2bb58c4504dad6557187f1ebe03c7a01a2d9b54623f20750d34930c57', 'companies', '2019-08-05 06:48:08', '2019-08-05 06:48:08'),
('c20aad1a7b0d288bc5bf9a1bda6b6a6b36e281788164c99753204775d2fdc53474e77871b5569aa6', 'companies', '2019-07-27 01:26:51', '2019-07-27 01:26:51'),
('c342a6352628fa31f21a25efff51d1326751d717f86fa415fb5fc61efc2f34cfecc437a56f8c6188', 'users', '2019-10-21 06:38:23', '2019-10-21 06:38:23'),
('c3cfdc7c9fd8b81b74a08442316739be01323b966d89bdde84344dfb8bc05ebea5e0a6eeaff6f5d9', 'companies', '2019-06-27 08:25:57', '2019-06-27 08:25:57'),
('c547326f983643164025815a6deb98570d93ced32f2c5a60ab827203c43aebe31dc7e08d3cf83e85', 'companies', '2019-06-29 01:21:29', '2019-06-29 01:21:29'),
('c6f0be96cc197964702a4f52b648b898102426b13bbf444f34f269c3bfe2d606372594001aecdc0b', 'companies', '2019-06-28 07:25:31', '2019-06-28 07:25:31'),
('c701d000558511011d173bb1d57da48709a3eefdb5f368090f8ec9033cb0cd6f76adbbca82f54055', 'companies', '2019-07-27 01:26:53', '2019-07-27 01:26:53'),
('c7fa86cc5465bb93a735db628ef9752fb9b9dbc45af148f63ee7cd10e2cc7e701500f30052a428cc', 'companies', '2019-06-28 07:30:00', '2019-06-28 07:30:00'),
('c8938771bf048185fcd68944dfb77fec180daacd0a4a847dabed5b4f5996e166744fc8068cb6b5d8', 'companies', '2019-07-26 02:21:54', '2019-07-26 02:21:54'),
('c89e233a8430eb0bac1341da61cb2c64e05c823d0943d54ddae92d9090d39979c60fd6d287c2c98a', 'companies', '2019-06-11 04:49:25', '2019-06-11 04:49:25'),
('c9b513251034c07f03e747731cadeab69616d69494ddc4f30c8c9be8f5d951c40d181f81d5ea3331', 'companies', '2019-10-21 05:35:47', '2019-10-21 05:35:47'),
('cadf8565953f93cffb42a66ca6a315903312e8530c80b255c990e507fc7c6d32442c4074a53f6f47', 'companies', '2019-07-27 01:26:50', '2019-07-27 01:26:50'),
('cb2d4369e42b868d955564b9c487b9a7d2f404b96e0ae435c727bfe7d19cbab6af7c6a5fe4d59e76', 'users', '2019-06-11 02:58:28', '2019-06-11 02:58:28'),
('cba4a7128d7d70fd86a5d43d585a275156eb697b90f402c21876c4177d43250a0d71dc35c9688d51', 'companies', '2019-07-16 08:15:15', '2019-07-16 08:15:15'),
('cbc7ff42799693bb2510e2cb736fd4efe05a11ac61deca3c96aefe5302716caf4a44af5f807cbf91', 'users', '2019-06-25 06:52:57', '2019-06-25 06:52:57'),
('cbdc7716756133dc9e478e66a6b281fed1e2d1f2e6952903ee66d7995c3ec108899c858d82fa162c', 'companies', '2019-07-27 01:26:52', '2019-07-27 01:26:52'),
('cc4702eb2d7a131ef7af5c45fe3a890bffc4e1714a6166a51d5c5f0b465c9ca43d2c12f9f5bdbd9c', 'companies', '2019-07-26 04:41:44', '2019-07-26 04:41:44'),
('cc85f41a8c49bb7a7e1023797a36fb996535994cb50780711cd064b2c85add931f0c2a4d1f926489', 'users', '2019-10-22 03:46:08', '2019-10-22 03:46:08'),
('cd745b4f20db4b2210ad4eb40ee7b3c504a7ffc1c66f3d948b4507d966b54fcf93e0809f6b98f1f7', 'companies', '2019-06-11 04:48:00', '2019-06-11 04:48:00'),
('ceba28c3d1d5df68e90a13208aca1667d3e6056cf3c4ab007a32f0ad77ff22289a756e7b5f0706c7', 'companies', '2019-08-08 05:20:23', '2019-08-08 05:20:23'),
('cf139509b3486e0e2190fc5333d83451e888ad50c59e16ec4e7652b37de75cdc7cd6a4c8c0b3a988', 'contractors', '2019-07-26 08:53:52', '2019-07-26 08:53:52'),
('cf165c4ae970b1c927ec849727ed2e4fbe3757d6710b29ae2e91bf1bc74e62368c52e8ae38d9ef87', 'companies', '2019-07-26 02:24:00', '2019-07-26 02:24:00'),
('cf29b910024198878c2a5ed75ccb87070e020611196567944d0d5d64203c3c859f37ed5d6ae5851c', 'companies', '2019-07-27 01:26:51', '2019-07-27 01:26:51'),
('cfe1fe2ef1b2c7b05b64802c714d34d4fb0664876c3faf6ad787ac4dc0e37160fa95c0984588fe2b', 'companies', '2019-07-10 04:51:43', '2019-07-10 04:51:43'),
('cfe7fb9508da29f47588d29e21277da05f81916875a3235ad8096e9a16e78c4bb5ac9df2126d1a72', 'companies', '2019-07-26 09:03:38', '2019-07-26 09:03:38'),
('d0462c9b6b07134f1bd08ce31e46a37b05bec25e592a9fdad22e48f11a60a6fb3ee35c56503395ba', 'companies', '2019-07-18 04:43:22', '2019-07-18 04:43:22'),
('d06d4b7ecd222aa601250f759fc99f269024b83e5e5b641d1f0fd7f6b35d72b62832e41970eb1ff6', 'companies', '2019-06-28 00:48:52', '2019-06-28 00:48:52'),
('d104aeafa9f51ba277d9712a5b0f202a912398f847a5e4ac9488d5d709757586246c3f69b3eb28aa', 'companies', '2019-08-02 03:25:21', '2019-08-02 03:25:21'),
('d18ba457d5387e4efdbdda215daa0f736dbc70497feb1ec98461f9046c4eadb5e38f8f0c1e46e5d2', 'companies', '2019-06-26 05:29:18', '2019-06-26 05:29:18'),
('d1938f98c2a77496146291754807ac1917a4190cc25021bac065ca094d3595d0ed3918a4200ee73a', 'users', '2019-06-11 06:36:13', '2019-06-11 06:36:13'),
('d1fb777c51fb6223a07c4cfca91ac180ec0b130d0a99c3f420f6d0a6e85559445d30a453a608431d', 'users', '2019-06-25 06:36:57', '2019-06-25 06:36:57'),
('d2c1b3e29c70f8f5dbcf9bb57c310de3f7907fad4d75beab3bbaed7814776883fd97e8c15dd4abc3', 'companies', '2019-07-27 01:26:52', '2019-07-27 01:26:52'),
('d520c7f74a30611ed664e15feaae90d4d00017de7ddf76b8874ecc531b50282b23b95fa55f4a723c', 'companies', '2019-07-25 07:50:51', '2019-07-25 07:50:51'),
('d5dfdbf7cd35f5f33cc9e1f7d690fb6771522ee76958d2971ee7d88774a960dbb872e9c85e54d6c6', 'companies', '2019-06-11 02:23:33', '2019-06-11 02:23:33'),
('d61633f25111971bfe1fd5042f9cb39dc430ada9ca0e8e0d0dd942251e2986071c304238ceecc5f5', 'companies', '2019-07-15 23:44:04', '2019-07-15 23:44:04'),
('d64f9298f49f9809fbe6784c87cead9110b82ea900ff7fa7fcf05514d855ef504c910aab1262320d', 'contractors', '2019-07-13 05:50:04', '2019-07-13 05:50:04'),
('d6e20b367ed1dfdf75ee9b177275e9e92fabbe5aed21d83d4e635dc19a5ffa54d113bdebc5c9cd69', 'companies', '2019-07-27 01:26:53', '2019-07-27 01:26:53'),
('d7c5a3b2bfbd68ea59f3ba0948ec5f7262c19ff0f367f9f57c1a91476624f6b064e045952ae352cd', 'companies', '2019-07-27 01:26:50', '2019-07-27 01:26:50'),
('d7e03ed4f1376bd3177c6c1e7db78942a7913dabbef3db17972994b81ef670175cccc7da9fbc4a7e', 'companies', '2019-10-22 00:33:00', '2019-10-22 00:33:00'),
('d97e9c96a63e3aef35c9af18bec8e7383a946f7ab4e525b3a197fe7071313e15dab8f17c419e3c89', 'companies', '2019-06-11 01:45:10', '2019-06-11 01:45:10');
INSERT INTO `oauth_access_token_providers` (`oauth_access_token_id`, `provider`, `created_at`, `updated_at`) VALUES
('db5e3989d1cee7408e4309891b515e5d3d906239c084e4c01c26bca02b6498e3dfac604f68b305e9', 'companies', '2019-07-25 07:40:36', '2019-07-25 07:40:36'),
('dd620024d85517163000ecc7768040400caf4d8f0f4b5de144bf12338305bac0630650e96d9527bb', 'companies', '2019-07-11 04:51:27', '2019-07-11 04:51:27'),
('df24df09e3850e9ff3b2c5796f05e23e3d066e6b2e81028f7e74e40e40fdd09e91d39f53832e4991', 'users', '2019-06-25 08:42:54', '2019-06-25 08:42:54'),
('df41a3e8dc71bf4452b05d2067ac49453fd8d833413ea36eb4b9fb1545a3c7305a71e3d770a5b0f2', 'contractors', '2019-07-26 05:26:14', '2019-07-26 05:26:14'),
('df5a57995e5791348221df9121521090da7af25000a602323003ac2915daf40cc5b28abd7b847c2b', 'companies', '2019-08-01 02:06:56', '2019-08-01 02:06:56'),
('df72cecc5076ddd06eadc069ea961c594d069e8f479b06230ce1f9da8d869a41bc16da9f5b085766', 'companies', '2019-07-31 06:09:44', '2019-07-31 06:09:44'),
('e07a2677e2847712ce15c05f49eccb29d79b976c5755ef1bb51b0314c892dd53cd7c87927fcab547', 'companies', '2019-07-04 23:32:56', '2019-07-04 23:32:56'),
('e0bbebf4a7157bdba436f73271d7a53c06011e6a9897d06e4765307bee62354af68d7f0c974b7099', 'companies', '2019-07-27 01:26:53', '2019-07-27 01:26:53'),
('e13ea5ef3a73d7bcbac5cea28fe7fa56e8a94298a448d916ccff8b9b2203ee516697e8a8d152a149', 'users', '2019-09-30 23:31:43', '2019-09-30 23:31:43'),
('e1780d2502f95511990c19262217d96aa08b19b45890d93d0896455284f185d8c095d4a5a4453779', 'users', '2019-08-08 00:22:31', '2019-08-08 00:22:31'),
('e180009d919d6e8c172cada071b6a3687ae5b6ef67f1e123fc001ac16173087bbb146e3bab147337', 'companies', '2019-08-21 05:52:45', '2019-08-21 05:52:45'),
('e1d6477ba64e16a8a5e4e73fc6479e9d6e3a94fefa6126aa68761261b5595166253c71e786bbca32', 'companies', '2019-10-15 04:16:30', '2019-10-15 04:16:30'),
('e20a9e3779ee4b398024f5c0e20b609d9dd5d0f43ad17b0b3fbd23500eda9daceac5831a2700acc2', 'companies', '2019-10-23 04:23:31', '2019-10-23 04:23:31'),
('e386f2f72ec373a339040b70e85ffd63a5d57b5ccdf522a8d2b2f0026487c5449ee75dfa22cb28b0', 'companies', '2019-06-27 23:43:09', '2019-06-27 23:43:09'),
('e3b2f680ff231b6e5931cde934d2864999ed9edd4c3694556df035cebe4373849d9bbf0e1a4fb82c', 'users', '2019-06-11 07:02:20', '2019-06-11 07:02:20'),
('e3e20e7fa10c54c784c9a2e2c7df3db9fa91b6f1cdd9ef2966af9572991cb5910204510a85dc238d', 'companies', '2019-06-18 00:21:49', '2019-06-18 00:21:49'),
('e3e9ebbd712e751351a92e922b75739e970c63571288611f9f432fe6cb582901e994129f4ef33085', 'users', '2019-07-08 05:41:55', '2019-07-08 05:41:55'),
('e4200ba9af99b6211602c34511cddaa40296f889d73df90d5b8c46ad901a7d166d8dab3595f91182', 'companies', '2019-09-30 02:12:53', '2019-09-30 02:12:53'),
('e47c6c8418797d13e2df7cbacad33f9e9b6bee3924433f7cedd66e3df6d9b42ca6fe3c9aa5dbd56a', 'companies', '2019-07-24 07:42:52', '2019-07-24 07:42:52'),
('e4ea5ea010ee1dc50fb1e8deca64c70a3bba980e8bab72517b87b97ea49dc4f7061a671f479103ad', 'companies', '2019-07-27 01:26:54', '2019-07-27 01:26:54'),
('e90de7bdf3faf52300a443ed2e453ee2fcdee74c88af0227696fbfe80179e7cc99fc02edff065568', 'companies', '2019-07-26 07:03:53', '2019-07-26 07:03:53'),
('e9762a0bc9424ecae8504af362520a36f2a6753e43331eafc0f1daaada8c081030e9648b5192d881', 'companies', '2019-07-02 07:04:01', '2019-07-02 07:04:01'),
('eb23c7eac181ccd5becf6042f2029a0600c4946a6899bd7c9b6f0d1b8a074c70c27cf13951e01b43', 'users', '2019-10-22 00:34:03', '2019-10-22 00:34:03'),
('ebc9a5bd7dcb99f49bc9f9e7996af26a699e9897568300b7dcf5879359af0f5cc13127bdf92eaf2f', 'companies', '2019-10-17 05:57:45', '2019-10-17 05:57:45'),
('ecc52b8f77087eeb88cbf14981682986b00f50dc4fe15c2f35e174416e114b2eb8e71dacc6e27d52', 'contractors', '2019-07-26 06:27:02', '2019-07-26 06:27:02'),
('eddb49f15b3b4e27b7d7c4403e33f2f8051085be70a6f3a1d77ddbb7aa67f5ece0913397cd1941c2', 'users', '2019-10-01 07:09:02', '2019-10-01 07:09:02'),
('edffaea39df69491dbd58691449a2cdfea736c8990d87d48810201f217d11762fe4d7ab23c68a28a', 'users', '2019-06-18 03:32:29', '2019-06-18 03:32:29'),
('ee132896dc5417a7a11fed001e1d3bdf5ab5526ce5234ba1546d6e454f0280a15ffc110720966c02', 'companies', '2019-07-27 07:02:56', '2019-07-27 07:02:56'),
('ef5055b3c77345a3cfbfbd1d778891db45987357a7db3a31c48610a2beac818a7c71176b68ae2153', 'contractors', '2019-07-25 05:09:10', '2019-07-25 05:09:10'),
('efebdfad3fa4d7d791c70bd23df3f7c65b61de221651286615e3366bc30e197f83c2c21693ebf70d', 'companies', '2019-07-27 01:26:54', '2019-07-27 01:26:54'),
('f0a101cd1c262425ca95961dbebd5663a6b3c1e8eb8f63ca4039ade07ea36ca204a566791db1b7a2', 'users', '2019-09-23 05:22:13', '2019-09-23 05:22:13'),
('f1726d4be19524b0143d48e6540e49cc7c5d902cad8a3c4751afe58ab9384043cc5cda1b7d491fc4', 'users', '2019-07-13 08:49:34', '2019-07-13 08:49:34'),
('f1eebd4e8c7fccb008c86f883f21f9ccde5cfa8e1954a23fdb7fec40bc215304a34ec64057bca203', 'companies', '2019-06-27 00:19:20', '2019-06-27 00:19:20'),
('f24c6946c1b4660c6c3e986949b16401b684fb40d49817b26e9c157b354ebc088d168a46b7ff391c', 'companies', '2019-06-11 05:29:21', '2019-06-11 05:29:21'),
('f2dfd99f3a3b0aff8e965f44c8524b43b2cfcdf45d9ac487d82b18eb2767f5fbda4777791de9f0d5', 'companies', '2019-07-27 00:18:08', '2019-07-27 00:18:08'),
('f338f50661b380d41d3e13bac6de6c917014ff716c72b9a09b81f2283a91d560bcd10cd4efc24942', 'companies', '2019-07-31 06:09:43', '2019-07-31 06:09:43'),
('f34215bcf71a564aef8b28bf29f557b2b950bff3afe31c1f8bf85431737787d6e6c004bcae4feab6', 'companies', '2019-10-23 05:01:02', '2019-10-23 05:01:02'),
('f5745d6d92e027a939d4df9f681a1d14a5b281fc6a244a42e209b0d2cb1df587aa80a9c18e55a2e2', 'companies', '2019-10-21 08:03:33', '2019-10-21 08:03:33'),
('f65756318c5113e290adbcb7a0203729caf2cb7c4505664e9fbf5aa0d4518bf86be971c24ce13b32', 'companies', '2019-07-11 04:08:24', '2019-07-11 04:08:24'),
('f68f88bd28ebbcf632ec3836e00f62cadb132e158b7ba3cda44d4191606428aa38346164762bb7e1', 'companies', '2019-07-13 05:47:19', '2019-07-13 05:47:19'),
('f6f204a3bd0b007e185c71c07b1b6ae27cc13b1cfd31a889e48322226ac28c8cf5b14f3e496e55d1', 'companies', '2019-08-05 04:49:47', '2019-08-05 04:49:47'),
('f75f82b7328f78ef04784bc668515d7aefc7eda6bdb0116e2526c74cbe337a8e11464eff2d496d74', 'companies', '2019-06-11 01:44:28', '2019-06-11 01:44:28'),
('f79c3f8b88f7b80aa82a3b8ed524ef209e59327cb737b1f21d44e80c03c13241d4c0a101968f79da', 'companies', '2019-07-13 07:43:27', '2019-07-13 07:43:27'),
('f7e2a5653d5414bd9110dc4a3115b30208582b61a76d0512c078644aebc39f18470b446725a77529', 'companies', '2019-10-01 04:41:37', '2019-10-01 04:41:37'),
('f805fc4d98b20c9c09e6a2532a165ed6eca834d0a299c50546bcc3f624116e91146c4d2691f563ee', 'companies', '2019-10-21 23:17:09', '2019-10-21 23:17:09'),
('f9c47be4cca2e3051049865539b8292239f8a1d699843cfcf3983f5cacb3f4696e9d848e4d461ae1', 'companies', '2019-10-21 05:30:46', '2019-10-21 05:30:46'),
('f9f59241ce31632a87c79cfd2e28d038ca8bceaba1c3b90e1f494e802c08ccd63e2913f6953dbc62', 'users', '2019-10-23 04:37:43', '2019-10-23 04:37:43'),
('fa083d19e8137f22a817297eca07c3904f1358777485f7916fa7e7766bf52a6886e96a7ada012b3a', 'users', '2019-09-23 04:44:19', '2019-09-23 04:44:19'),
('fa322df883f9d02e330674cdc5c4a064e8a450eb80820593e5dd1915dddd45957422696fb9587fe4', 'companies', '2019-07-27 01:26:54', '2019-07-27 01:26:54'),
('fad7c78d02d3fd03666ec250c294458855f43f834bcef069e5574bdf347af2f7318743adaff19b9b', 'contractors', '2019-07-27 00:17:28', '2019-07-27 00:17:28'),
('fad948b79776a8f6dd110b527d92bf744c4209e239fb04ba1eb37c126096fe8930743f6eca332c58', 'users', '2019-06-26 01:48:56', '2019-06-26 01:48:56'),
('fb7463e601516e826a3ee8e3471647cb727cbe8b410b4bb698d5ce78a286908ced82c26ae160c4bb', 'companies', '2019-09-30 04:22:47', '2019-09-30 04:22:47'),
('fb9fb82215fa43c7e3b65f128e7f9bd83a848789d94c36f6a166365efba6f5cc55553f5f9e6b98e4', 'companies', '2019-10-01 06:49:17', '2019-10-01 06:49:17'),
('fbc6bede02ad64bc0a4969b4b4fd28201dab79d5b745b21f4fc155bb88cba712f28da28fe7b053c2', 'companies', '2019-06-28 07:42:00', '2019-06-28 07:42:00'),
('fbe846ce9b421776408f0fb8e71bf6350324486c9f33a56f8e25f2546abfe99f0e18622d30a30b3d', 'companies', '2019-07-27 06:59:05', '2019-07-27 06:59:05'),
('fd03713c2de8c1f917efae1913e51a30ee8af73c27483a7167f49aa8958d5a89b9eebb6b92976c2f', 'companies', '2019-06-18 00:43:36', '2019-06-18 00:43:36'),
('fd043281b2eb8e28a6914f2a2e701bdc080d42d94a79d07be7577fa854cd08e464d6b47aa5305bdd', 'companies', '2019-06-29 06:43:51', '2019-06-29 06:43:51'),
('ff24052250c3409c17994ed8e29376e724059b464cd6485a8e743e47e00cd94435a62a0633534c2a', 'companies', '2019-07-26 01:32:24', '2019-07-26 01:32:24'),
('ff6edd9ca5adc2fcc895475e9f3b7ffcc82371f55bbd0b5498bf00874efe990ee9b1f5c44ede380a', 'contractors', '2019-10-15 04:30:06', '2019-10-15 04:30:06'),
('ff9951c78564425c19492e0ea1f3fcb0f77ada3a93a1bab2f66fc78b35a8835dd5f789ee06416cda', 'companies', '2019-06-11 01:45:58', '2019-06-11 01:45:58'),
('ffcdc28dac97bfe70cf5a84b1894622f2202cde84696626579f90f6f9ecf9618852c8dc256e3b969', 'contractors', '2019-07-25 07:41:27', '2019-07-25 07:41:27');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_auth_codes`
--

CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_clients`
--

CREATE TABLE `oauth_clients` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `redirect` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_clients`
--

INSERT INTO `oauth_clients` (`id`, `user_id`, `name`, `secret`, `redirect`, `personal_access_client`, `password_client`, `revoked`, `created_at`, `updated_at`) VALUES
(1, NULL, 'ServiceRequest Password Grant Client', 'AIWCwHahsw7q5Xh8j4tkm1l5wDamLg1WGXMKVfd5', 'http://localhost', 0, 1, 0, '2019-06-11 01:09:52', '2019-06-11 01:09:52'),
(2, NULL, 'admin', 'XxRFNtMuG97EIJQsOxiNmDF77SpPMi9ZscxJdRHB', 'http://localhost', 1, 0, 0, '2019-06-11 01:11:08', '2019-06-11 01:11:08'),
(3, NULL, 'Laravel Personal Access Client', '0zHMu2ZTlJzOADEWSjZ74ue535wlQCVE4kz9mgor', 'http://localhost', 1, 0, 0, '2019-09-22 23:21:49', '2019-09-22 23:21:49'),
(4, NULL, 'Laravel Password Grant Client', 'S1D7BC4PAf7ObitxJFKUXoYhTtCpCsafgTSqC1gq', 'http://localhost', 0, 1, 0, '2019-09-22 23:21:49', '2019-09-22 23:21:49');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_personal_access_clients`
--

CREATE TABLE `oauth_personal_access_clients` (
  `id` int(10) UNSIGNED NOT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_personal_access_clients`
--

INSERT INTO `oauth_personal_access_clients` (`id`, `client_id`, `created_at`, `updated_at`) VALUES
(1, 2, '2019-06-11 01:11:08', '2019-06-11 01:11:08'),
(2, 3, '2019-09-22 23:21:49', '2019-09-22 23:21:49');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_refresh_tokens`
--

CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'work order create', 'web', '2019-06-11 01:02:46', '2019-06-11 01:02:46'),
(2, 'work order edit', 'web', '2019-06-11 01:02:46', '2019-06-11 01:02:46'),
(3, 'work order delete', 'web', '2019-06-11 01:02:46', '2019-06-11 01:02:46');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'Super admin', 'web', '2019-06-11 01:02:46', '2019-06-11 01:02:46'),
(2, 'Company admin', 'web', '2019-06-11 01:02:46', '2019-06-11 01:02:46'),
(3, 'Company editor', 'web', '2019-06-11 01:02:46', '2019-06-11 01:02:46'),
(4, 'Contractor admin', 'web', '2019-06-11 01:02:46', '2019-06-11 01:02:46'),
(5, 'Contractor staff', 'web', '2019-06-11 01:02:46', '2019-06-11 01:02:46'),
(6, 'Site admin', 'web', '2019-06-11 01:02:46', '2019-06-11 01:02:46'),
(7, 'Site staff', 'web', '2019-06-11 01:02:46', '2019-06-11 01:02:46');

-- --------------------------------------------------------

--
-- Table structure for table `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role_has_permissions`
--

INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
(1, 1),
(2, 1),
(3, 1);

-- --------------------------------------------------------

--
-- Table structure for table `servicerequest_images`
--

CREATE TABLE `servicerequest_images` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `path` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `service_request_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `servicerequest_images`
--

INSERT INTO `servicerequest_images` (`id`, `path`, `service_request_id`, `created_at`, `updated_at`) VALUES
(29, 'workorders/15698372175845.jpg', 37, '2019-09-30 04:23:37', '2019-09-30 04:23:37'),
(37, 'workorders/15699355733358.jpg', 39, '2019-10-01 07:42:53', '2019-10-01 07:42:53'),
(38, 'workorders/15699355734642.jpg', 39, '2019-10-01 07:42:53', '2019-10-01 07:42:53'),
(39, 'workorders/15699355733322.jpg', 39, '2019-10-01 07:42:53', '2019-10-01 07:42:53'),
(102, 'workorders/15717305365284.jpg', 41, '2019-10-22 02:18:56', '2019-10-22 02:18:56'),
(103, 'workorders/15717305365163.jpg', 41, '2019-10-22 02:18:56', '2019-10-22 02:18:56');

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `name`, `value`, `created_at`, `updated_at`) VALUES
(1, 'full_page', 'yes', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `site_locations`
--

CREATE TABLE `site_locations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `company_user_id` bigint(20) UNSIGNED NOT NULL,
  `street` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `city` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `postal_code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone_number` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `site_locations`
--

INSERT INTO `site_locations` (`id`, `company_user_id`, `street`, `city`, `postal_code`, `email`, `phone_number`, `created_at`, `updated_at`) VALUES
(3, 11, 'gggdf', 'fddg', '534534', 'develop@yopmail.com', '7600697853', '2019-07-10 08:10:10', '2019-07-10 08:10:29'),
(4, 17, 'Titanium', 'Ahmedabad', '380015', 'sitea@yopmail.com', '7878787878', '2019-07-16 04:17:19', '2019-07-16 04:17:19'),
(5, 17, 'reewr', 'rewr', '234442', 'sitea@yopmail.com', '7878787878', '2019-07-23 05:55:02', '2019-07-23 05:55:02'),
(7, 21, 'titanium', 'ahmedabad', '369633', 'site-admin@yopmail.com', '787787878', '2019-07-26 09:05:30', '2019-07-26 09:05:30');

-- --------------------------------------------------------

--
-- Table structure for table `subscriptions`
--

CREATE TABLE `subscriptions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `company_user_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `stripe_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `stripe_plan` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` int(11) NOT NULL,
  `trial_ends_at` timestamp NULL DEFAULT NULL,
  `ends_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `subscriptions`
--

INSERT INTO `subscriptions` (`id`, `company_user_id`, `name`, `stripe_id`, `stripe_plan`, `quantity`, `trial_ends_at`, `ends_at`, `created_at`, `updated_at`) VALUES
(5, 11, 'main', 'sub_FKZg4C5jeehyfG', 'plan_FHsWXFk3KtxWuJ', 1, NULL, NULL, '2019-06-27 04:39:05', '2019-09-30 04:47:26'),
(8, 15, 'main', 'sub_FL07HBPFcvXen9', 'plan_FHtPedZvovLx78', 1, NULL, NULL, '2019-06-28 07:58:18', '2019-06-28 07:58:18'),
(9, 16, 'main', 'sub_FPqZ2hkP7jHeNm', 'plan_FHsYHWLi0FETWZ', 1, NULL, NULL, '2019-07-11 06:26:15', '2019-07-11 06:26:15'),
(10, 19, 'main', 'sub_FQdVTRhM4TM8eP', 'plan_FHtPedZvovLx78', 1, NULL, NULL, '2019-07-13 08:59:21', '2019-07-13 08:59:21'),
(11, 22, 'main', 'sub_FWVxAGr8ZroGv5', 'plan_FHsWXFk3KtxWuJ', 1, NULL, NULL, '2019-07-29 01:35:40', '2019-07-29 01:35:40');

-- --------------------------------------------------------

--
-- Table structure for table `subscription_plans`
--

CREATE TABLE `subscription_plans` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(8,2) UNSIGNED NOT NULL,
  `interval` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `users` int(191) NOT NULL,
  `work_orders` int(191) NOT NULL,
  `stripe_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `subscription_plans`
--

INSERT INTO `subscription_plans` (`id`, `name`, `amount`, `interval`, `users`, `work_orders`, `stripe_id`, `created_at`, `updated_at`) VALUES
(1, 'Free', '0.00', 'Weekly', 5, 100, 'plan_FHtPedZvovLx78', '2019-06-19 22:41:11', '2019-06-19 18:30:00'),
(2, 'Pro', '10.00', 'Monthly', 100, 1000, 'plan_FHsWXFk3KtxWuJ', '2019-06-20 06:00:24', '2019-06-19 18:30:00'),
(3, 'Premium', '100.00', 'Yearly', 100, 1000, 'plan_FHsYHWLi0FETWZ', '2019-06-12 18:30:00', '2019-06-19 18:30:00');

-- --------------------------------------------------------

--
-- Table structure for table `task_images`
--

CREATE TABLE `task_images` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `path` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `work_task_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `task_images`
--

INSERT INTO `task_images` (`id`, `path`, `work_task_id`, `created_at`, `updated_at`) VALUES
(49, 'tasks/15641518288961.jpg', 32, '2019-07-26 09:07:08', '2019-07-26 09:07:08'),
(50, 'tasks/15641518285235.jpg', 32, '2019-07-26 09:07:08', '2019-07-26 09:07:08'),
(52, 'tasks/15699335651086.jpg', 34, '2019-10-01 07:09:25', '2019-10-01 07:09:25'),
(53, 'tasks/15699335652689.jpg', 34, '2019-10-01 07:09:25', '2019-10-01 07:09:25'),
(54, 'tasks/15699335655370.jpg', 34, '2019-10-01 07:09:25', '2019-10-01 07:09:25'),
(74, 'tasks/15717229645913.jpg', 35, '2019-10-22 00:12:44', '2019-10-22 00:12:44'),
(75, 'tasks/15717383296600.jpg', 36, '2019-10-22 04:28:49', '2019-10-22 04:28:49'),
(76, 'tasks/15717383297304.jpg', 36, '2019-10-22 04:28:49', '2019-10-22 04:28:49'),
(78, 'tasks/15717383293795.jpg', 36, '2019-10-22 04:28:49', '2019-10-22 04:28:49'),
(79, 'tasks/15718246442426.jpg', 37, '2019-10-23 04:27:24', '2019-10-23 04:27:24'),
(80, 'tasks/15718246447325.jpg', 37, '2019-10-23 04:27:24', '2019-10-23 04:27:24'),
(81, 'tasks/15718266916664.jpg', 38, '2019-10-23 05:01:31', '2019-10-23 05:01:31'),
(82, 'tasks/15718266911199.jpg', 38, '2019-10-23 05:01:31', '2019-10-23 05:01:31');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `company_user_id` bigint(20) UNSIGNED NOT NULL,
  `subscription_plan_id` int(10) UNSIGNED NOT NULL,
  `stripe_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(8,2) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Super Admin', 'sadmin@yopmail.com', NULL, '$2y$10$ZLzZ1jBohWIAoQoOgNR2DOLpPJZdsscVHruNku.eWWCW.My93PsCi', NULL, '2019-06-11 01:02:46', '2019-07-11 02:15:31', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_invites`
--

CREATE TABLE `user_invites` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `type` tinyint(4) NOT NULL COMMENT '0 = Company Editor, 1 = Contractor Admin, 2 = Contrctor Staff, 3 = Site Admin, 4 = Site Staff',
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expired_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_invites`
--

INSERT INTO `user_invites` (`id`, `user_id`, `type`, `email`, `slug`, `expired_at`, `created_at`, `updated_at`) VALUES
(20, 11, 3, 'site-admin@yopmail.com', 'ntiRsXN2lz9uCo5J06j5uFyxkQbXI1Yg6HJvPXCnnvSid7wMsEpD8xJE1BaY', '2019-08-25 09:04:03', '2019-07-26 09:04:03', '2019-07-26 09:04:41'),
(21, 11, 0, 'dimple@yopmail.com', '9h5MmFDVNiqpnaemi9weZGnwfTi4ZVxKNTGuTnXTdnovwJKfSOwfnWjz26J3', '2019-10-30 04:47:49', '2019-09-30 04:47:49', '2019-09-30 04:47:49'),
(22, 11, 0, 'dimple@yopmail.com', 'Yb1zTpcLP6traZv90Uiy2tVLzeopOdhiGKvmGf967hYWH6JShnTHlV304NVN', '2019-10-30 05:25:06', '2019-09-30 05:25:06', '2019-09-30 05:25:06'),
(23, 11, 1, 'dimple@yopmail.com', '5wrPAcDue30zu3BcYbLz3tkl7CPwRZ0ZhUjyLOvG4GyzA4obFSdpCpOpCCoD', '2019-10-30 05:26:26', '2019-09-30 05:26:26', '2019-09-30 05:26:26'),
(24, 11, 0, 'dimple@yopmail.com', '1xTd57sbTax1cIoP1Yz7sDb2kwwyYCz4WxiQw0neaaUwPFESoNTZaMCnCFi5', '2019-10-30 05:34:24', '2019-09-30 05:34:24', '2019-09-30 05:34:24'),
(25, 11, 1, 'dimple@yopmail.com', 'SBDB2U2ys1Fdn1gr3qfapcVwNehJc6UbE0o5ITL6aEX65UwzuXBjJULqqjhP', '2019-10-30 05:35:57', '2019-09-30 05:35:57', '2019-09-30 05:35:57'),
(26, 21, 4, 'dimple@yopmail.com', 'ijbtoZnHdZhY5LSm74FBc2nSa4g8Cm0CtzARsNMzaIZnTkMjSBxFkIvubDkG', '2019-10-30 05:44:11', '2019-09-30 05:44:11', '2019-09-30 05:44:11'),
(27, 11, 0, 'contractor@yopmail.com', 'hlW0peTjvcqzchiPthBHheXcgMRS8P2GRVZgQ6Yhl3tnA7uArRyjuI27RGJa', '2019-10-30 23:58:41', '2019-09-30 23:58:41', '2019-09-30 23:58:41');

-- --------------------------------------------------------

--
-- Table structure for table `user_profiles`
--

CREATE TABLE `user_profiles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `photo` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `website` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_profiles`
--

INSERT INTO `user_profiles` (`id`, `user_type`, `user_id`, `name`, `address`, `photo`, `company_name`, `website`, `phone`, `created_at`, `updated_at`) VALUES
(8, 'App\\Models\\CompanyUser', 11, 'Company admin', 'Titanium city centre, Ahmedabad-380015', NULL, 'Teknomines ESolution Pvt Ltd.', 'https://www.teknomines.com', '7600697853', '2019-06-27 04:38:58', '2019-10-01 04:25:45'),
(9, 'App\\Models\\CompanyUser', 12, 'Teknomines', NULL, NULL, NULL, NULL, '7878787877', '2019-06-28 00:38:34', '2019-07-13 04:57:37'),
(10, 'App\\Models\\CompanyUser', 13, 'Teknomines', 'Titanium city centre', NULL, 'Teknomines ESolution Pvt Ltd.', 'https://www.teknomines.com', '789787878', '2019-06-28 00:48:13', '2019-06-28 01:21:43'),
(11, 'App\\Models\\CompanyUser', 14, 'demo', 'test', NULL, 'teknomines', 'adsds', '01234567990', '2019-06-28 07:25:09', '2019-09-30 02:37:18'),
(12, 'App\\Models\\CompanyUser', 15, 'testtttt', NULL, NULL, NULL, NULL, '4234234234', '2019-06-28 07:58:13', '2019-06-28 07:58:13'),
(13, 'App\\Models\\ContractorUser', 1, 'contract11', 'dasd', NULL, 'tesd', NULL, '7878787877', '2019-06-28 08:12:34', '2019-07-26 05:23:00'),
(14, 'App\\Models\\CompanyUser', 22, 'Testtttttt', NULL, NULL, NULL, NULL, '7471101212', '2019-07-03 03:47:11', '2019-07-10 05:59:08'),
(15, 'App\\Models\\CompanyUser', 23, 'testttt', NULL, NULL, NULL, NULL, '31231231', '2019-07-09 08:47:14', '2019-07-09 08:47:14'),
(16, 'App\\Models\\CompanyUser', 16, 'testett', NULL, NULL, NULL, NULL, '7878787878', '2019-07-11 06:26:09', '2019-07-11 06:26:09'),
(17, 'App\\Models\\ContractorUser', 1, 'contract11', 'dasd', NULL, 'tesd', NULL, '7878787877', '2019-07-13 05:49:55', '2019-07-26 05:23:00'),
(18, 'App\\Models\\ContractorUser', 2, 'cstaff1', 'gfd', 'images/NBjpiAVrKHYB311oQ3iAr5jgX9Sm9xl7YGsGK8t5.png', 'dasd', 'dasda', '8777787878', '2019-07-13 06:19:20', '2019-07-26 02:19:15'),
(19, 'App\\Models\\CompanyUser', 17, 'site admin', 'dsa', 'images/VAZdJ4qa9YuTs3B8RJ3dNzvrwpkqJBKo8aiGuklc.png', NULL, NULL, '7878787878', '2019-07-13 07:35:00', '2019-09-30 03:01:40'),
(20, 'App\\Models\\CompanyUser', 18, 'site staff', 'dfds', NULL, '132', 'null', '78787877878', '2019-07-13 07:37:46', '2019-07-24 06:30:15'),
(21, 'App\\Models\\CompanyUser', 19, 'test1', NULL, NULL, NULL, NULL, '7878777888', '2019-07-13 08:59:15', '2019-07-13 08:59:15'),
(22, 'App\\Models\\ContractorUser', 3, 'Contractor admin', 'Ahmedabad', NULL, NULL, NULL, '787878811', '2019-07-26 06:13:55', '2019-09-30 02:16:24'),
(23, 'App\\Models\\ContractorUser', 4, 'Contractor staff', 'test', NULL, NULL, NULL, '872225223', '2019-07-26 06:29:57', '2019-10-21 01:02:00'),
(24, 'App\\Models\\CompanyUser', 20, 'site admin', NULL, NULL, NULL, NULL, '789456123', '2019-07-26 08:42:21', '2019-07-26 08:42:21'),
(25, 'App\\Models\\CompanyUser', 21, 'Site admin', 'Test', NULL, NULL, NULL, '787787878', '2019-07-26 09:04:41', '2019-09-23 08:04:00'),
(26, 'App\\Models\\CompanyUser', 22, 'company admin 1', NULL, NULL, NULL, NULL, '7878787878', '2019-07-29 01:35:33', '2019-07-29 01:35:33'),
(27, 'App\\Models\\User', 1, 'Super Admin', NULL, NULL, NULL, NULL, '7878787878', '2019-07-29 01:35:33', '2019-07-29 01:35:33');

-- --------------------------------------------------------

--
-- Table structure for table `user_subscriptions`
--

CREATE TABLE `user_subscriptions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `company_user_id` bigint(20) UNSIGNED NOT NULL,
  `subscription_plan_id` int(10) UNSIGNED NOT NULL,
  `stripe_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expired_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `work_categories`
--

CREATE TABLE `work_categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `company_user_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `work_categories`
--

INSERT INTO `work_categories` (`id`, `name`, `company_user_id`, `created_at`, `updated_at`) VALUES
(2, 'Floor work', 11, '2019-07-24 07:38:57', '2019-07-24 07:38:57');

-- --------------------------------------------------------

--
-- Table structure for table `work_orders`
--

CREATE TABLE `work_orders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `service_request_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `purchase_order_number` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `site_location_id` bigint(20) UNSIGNED NOT NULL,
  `order_priority_id` int(10) DEFAULT NULL,
  `order_by_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `order_by_id` bigint(20) UNSIGNED NOT NULL,
  `quote_required` tinyint(4) NOT NULL DEFAULT '0',
  `contractor_quote_required` tinyint(4) NOT NULL DEFAULT '0',
  `assign_to` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `company_cost` double(15,2) NOT NULL DEFAULT '0.00',
  `contractor_cost` double(8,2) NOT NULL DEFAULT '0.00',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0 = Processing, 1 = Closed, 2 = Completed',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `work_orders`
--

INSERT INTO `work_orders` (`id`, `service_request_id`, `purchase_order_number`, `title`, `description`, `site_location_id`, `order_priority_id`, `order_by_type`, `order_by_id`, `quote_required`, `contractor_quote_required`, `assign_to`, `company_cost`, `contractor_cost`, `status`, `created_at`, `updated_at`) VALUES
(17, '#5445454656', '', 'Work order', 'I have created migration to create a stored procedure in laravel 5. When I run the migration, it show that the migration has been executed successfully. But it is not visible in PHPMysql!! My migration code is below', 7, 0, 'App\\Models\\CompanyUser', 21, 0, 0, 3, 0.00, 22.00, 1, '2019-07-26 09:05:58', '2019-07-31 06:41:28'),
(37, '#3028169582', '#3343', 'dm2', 'dm2', 7, 3, 'App\\Models\\CompanyUser', 21, 1, 0, 3, 0.00, 0.00, 0, '2019-09-30 04:23:37', '2019-09-30 23:47:28'),
(38, 'RYCI-001000', '#4343', 'dsadsdf', 'dfsfds', 7, 3, 'App\\Models\\CompanyUser', 21, 1, 0, 0, 0.00, 0.00, 0, '2019-10-01 06:25:48', '2019-10-15 04:25:37'),
(39, 'RYCI-001001', '#54354545', 'fbgdfgdfg', 'as', 7, 2, 'App\\Models\\CompanyUser', 21, 1, 0, 0, 0.00, 0.00, 0, '2019-10-01 06:26:13', '2019-10-01 07:42:53'),
(41, 'RYCI-001003', '#54354', 'ds1', 'ds1', 7, 2, 'App\\Models\\CompanyUser', 21, 1, 0, 0, 0.00, 0.00, 0, '2019-10-01 07:47:18', '2019-10-22 02:18:56');

-- --------------------------------------------------------

--
-- Table structure for table `work_parts`
--

CREATE TABLE `work_parts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `work_order_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` double(8,2) NOT NULL,
  `added_by_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `added_by_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `work_parts`
--

INSERT INTO `work_parts` (`id`, `work_order_id`, `name`, `price`, `added_by_type`, `added_by_id`, `created_at`, `updated_at`) VALUES
(38, 17, 'parts 1', 11.00, 'App\\Models\\ContractorUser', 3, '2019-07-27 00:17:46', '2019-07-27 00:17:46'),
(39, 17, 'parts 2', 12.00, 'App\\Models\\ContractorUser', 3, '2019-07-27 00:17:46', '2019-07-27 00:17:46'),
(40, 17, 'parts 3', 13.00, 'App\\Models\\ContractorUser', 3, '2019-07-27 00:17:47', '2019-07-27 00:17:47');

-- --------------------------------------------------------

--
-- Table structure for table `work_priorities`
--

CREATE TABLE `work_priorities` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `work_priorities`
--

INSERT INTO `work_priorities` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES
(1, 'Emergency!', 'Please call Ran at 604 75 75 200', NULL, NULL),
(2, 'Urgent/High priority ', '1-3 days', NULL, NULL),
(3, 'Medium', '3-7 days or next visit', NULL, NULL),
(4, 'Low', 'When possible', NULL, NULL),
(5, 'Very low', 'When possible', NULL, NULL),
(6, 'N/A', 'Not Applicable', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `work_tasks`
--

CREATE TABLE `work_tasks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `work_order_id` bigint(20) UNSIGNED NOT NULL,
  `work_category_id` int(10) UNSIGNED NOT NULL,
  `work_priority_id` int(10) UNSIGNED NOT NULL,
  `added_by_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `added_by_id` bigint(20) UNSIGNED NOT NULL,
  `company_notes` text COLLATE utf8mb4_unicode_ci,
  `contractor_notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `work_tasks`
--

INSERT INTO `work_tasks` (`id`, `title`, `description`, `work_order_id`, `work_category_id`, `work_priority_id`, `added_by_type`, `added_by_id`, `company_notes`, `contractor_notes`, `created_at`, `updated_at`) VALUES
(32, 'Task 2', 'I have created migration to create a stored procedure in laravel 5. When I run the migration, it show that the migration has been executed successfully. But it is not visible in PHPMysql!! My migration code is below', 17, 2, 4, 'App\\Models\\CompanyUser', 21, 'I have created migration to create a', 'But it is not visible in PHPMysql!! My migration code is below', '2019-07-26 09:07:08', '2019-07-26 09:10:02'),
(33, 'dt1', 'dt1', 37, 2, 1, 'App\\Models\\CompanyUser', 11, '', '', '2019-10-01 00:58:41', '2019-10-01 00:58:41'),
(34, 'ghf', 'ghfgh', 39, 2, 2, 'App\\Models\\CompanyUser', 11, '', '', '2019-10-01 07:09:25', '2019-10-01 07:09:25'),
(35, 'test12366', 'test', 41, 2, 1, 'App\\Models\\CompanyUser', 11, '', '', '2019-10-15 03:45:49', '2019-10-23 05:59:56'),
(36, 'sddfs', 'fsdfs', 41, 2, 2, 'App\\Models\\User', 1, '', '', '2019-10-22 04:28:49', '2019-10-22 04:28:49'),
(37, 'test45', 'test45', 41, 2, 2, 'App\\Models\\CompanyUser', 11, '', '', '2019-10-23 04:27:24', '2019-10-23 04:27:24'),
(38, 'asd', 'asdas', 37, 2, 2, 'App\\Models\\CompanyUser', 11, '', '', '2019-10-23 05:01:31', '2019-10-23 05:01:31');

-- --------------------------------------------------------

--
-- Table structure for table `work_task_comments`
--

CREATE TABLE `work_task_comments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `work_task_id` bigint(20) UNSIGNED NOT NULL,
  `message` text COLLATE utf8mb4_unicode_ci,
  `added_by_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `added_by_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `work_task_comments`
--

INSERT INTO `work_task_comments` (`id`, `work_task_id`, `message`, `added_by_type`, `added_by_id`, `created_at`, `updated_at`) VALUES
(1, 35, 'ngn555sssssss', 'App\\Models\\CompanyUser', 21, '2019-10-22 00:29:29', '2019-10-23 04:33:47'),
(2, 35, 'sdd', 'App\\Models\\User', 1, '2019-10-22 00:34:12', '2019-10-22 00:34:12'),
(3, 35, 'nfvbgnbghh', 'App\\Models\\User', 1, '2019-10-22 01:10:07', '2019-10-22 01:10:07'),
(4, 37, 'swdsds', 'App\\Models\\CompanyUser', 11, '2019-10-23 04:27:51', '2019-10-23 04:27:51'),
(5, 37, 'asdsdss', 'App\\Models\\CompanyUser', 11, '2019-10-23 04:27:56', '2019-10-23 04:27:56'),
(6, 37, '32323ddddd', 'App\\Models\\CompanyUser', 11, '2019-10-23 04:34:07', '2019-10-23 04:34:10');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `company_has_contractor_users`
--
ALTER TABLE `company_has_contractor_users`
  ADD KEY `company_has_contractor_users_company_user_id_foreign` (`company_user_id`),
  ADD KEY `company_has_contractor_users_contractor_user_id_foreign` (`contractor_user_id`);

--
-- Indexes for table `company_has_users`
--
ALTER TABLE `company_has_users`
  ADD KEY `company_has_users_company_user_id_foreign` (`company_user_id`),
  ADD KEY `company_has_users_user_id_foreign` (`user_id`);

--
-- Indexes for table `company_users`
--
ALTER TABLE `company_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `company_users_email_unique` (`email`);

--
-- Indexes for table `contractor_has_users`
--
ALTER TABLE `contractor_has_users`
  ADD KEY `contractor_has_users_contractor_user_id_foreign` (`contractor_user_id`),
  ADD KEY `contractor_has_users_user_id_foreign` (`user_id`);

--
-- Indexes for table `contractor_users`
--
ALTER TABLE `contractor_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `contractor_users_email_unique` (`email`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `oauth_access_tokens`
--
ALTER TABLE `oauth_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_access_tokens_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_access_token_providers`
--
ALTER TABLE `oauth_access_token_providers`
  ADD PRIMARY KEY (`oauth_access_token_id`);

--
-- Indexes for table `oauth_auth_codes`
--
ALTER TABLE `oauth_auth_codes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_clients_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_personal_access_clients_client_id_index` (`client_id`);

--
-- Indexes for table `oauth_refresh_tokens`
--
ALTER TABLE `oauth_refresh_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indexes for table `servicerequest_images`
--
ALTER TABLE `servicerequest_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `servicerequest_images_service_request_id_foreign` (`service_request_id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `site_locations`
--
ALTER TABLE `site_locations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `site_locations_company_user_id_foreign` (`company_user_id`);

--
-- Indexes for table `subscriptions`
--
ALTER TABLE `subscriptions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `subscriptions_company_user_id_foreign` (`company_user_id`);

--
-- Indexes for table `subscription_plans`
--
ALTER TABLE `subscription_plans`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `task_images`
--
ALTER TABLE `task_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `task_images_work_task_id_foreign` (`work_task_id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transactions_company_user_id_foreign` (`company_user_id`),
  ADD KEY `transactions_subscription_plan_id_foreign` (`subscription_plan_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indexes for table `user_invites`
--
ALTER TABLE `user_invites`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_invites_slug_unique` (`slug`);

--
-- Indexes for table `user_profiles`
--
ALTER TABLE `user_profiles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_profiles_user_type_user_id_index` (`user_type`,`user_id`);

--
-- Indexes for table `user_subscriptions`
--
ALTER TABLE `user_subscriptions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_subscriptions_company_user_id_foreign` (`company_user_id`),
  ADD KEY `user_subscriptions_subscription_plan_id_foreign` (`subscription_plan_id`);

--
-- Indexes for table `work_categories`
--
ALTER TABLE `work_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `work_categories_company_user_id_foreign` (`company_user_id`);

--
-- Indexes for table `work_orders`
--
ALTER TABLE `work_orders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `work_orders_service_request_id_unique` (`service_request_id`),
  ADD KEY `work_orders_order_by_type_order_by_id_index` (`order_by_type`,`order_by_id`),
  ADD KEY `work_orders_site_location_id_foreign` (`site_location_id`);

--
-- Indexes for table `work_parts`
--
ALTER TABLE `work_parts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `work_parts_added_by_type_added_by_id_index` (`added_by_type`,`added_by_id`),
  ADD KEY `work_parts_work_order_id_foreign` (`work_order_id`);

--
-- Indexes for table `work_priorities`
--
ALTER TABLE `work_priorities`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `work_tasks`
--
ALTER TABLE `work_tasks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `work_tasks_added_by_type_added_by_id_index` (`added_by_type`,`added_by_id`),
  ADD KEY `work_tasks_work_order_id_foreign` (`work_order_id`),
  ADD KEY `work_tasks_work_category_id_foreign` (`work_category_id`),
  ADD KEY `work_tasks_work_priority_id_foreign` (`work_priority_id`);

--
-- Indexes for table `work_task_comments`
--
ALTER TABLE `work_task_comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `work_task_comments_added_by_type_added_by_id_index` (`added_by_type`,`added_by_id`),
  ADD KEY `work_task_comments_work_task_id_foreign` (`work_task_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `company_users`
--
ALTER TABLE `company_users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `contractor_users`
--
ALTER TABLE `contractor_users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `servicerequest_images`
--
ALTER TABLE `servicerequest_images`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=105;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `site_locations`
--
ALTER TABLE `site_locations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `subscriptions`
--
ALTER TABLE `subscriptions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `subscription_plans`
--
ALTER TABLE `subscription_plans`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `task_images`
--
ALTER TABLE `task_images`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=85;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user_invites`
--
ALTER TABLE `user_invites`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `user_profiles`
--
ALTER TABLE `user_profiles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `user_subscriptions`
--
ALTER TABLE `user_subscriptions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `work_categories`
--
ALTER TABLE `work_categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `work_orders`
--
ALTER TABLE `work_orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT for table `work_parts`
--
ALTER TABLE `work_parts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `work_priorities`
--
ALTER TABLE `work_priorities`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `work_tasks`
--
ALTER TABLE `work_tasks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `work_task_comments`
--
ALTER TABLE `work_task_comments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `company_has_contractor_users`
--
ALTER TABLE `company_has_contractor_users`
  ADD CONSTRAINT `company_has_contractor_users_company_user_id_foreign` FOREIGN KEY (`company_user_id`) REFERENCES `company_users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `company_has_contractor_users_contractor_user_id_foreign` FOREIGN KEY (`contractor_user_id`) REFERENCES `contractor_users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `company_has_users`
--
ALTER TABLE `company_has_users`
  ADD CONSTRAINT `company_has_users_company_user_id_foreign` FOREIGN KEY (`company_user_id`) REFERENCES `company_users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `company_has_users_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `company_users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `contractor_has_users`
--
ALTER TABLE `contractor_has_users`
  ADD CONSTRAINT `contractor_has_users_contractor_user_id_foreign` FOREIGN KEY (`contractor_user_id`) REFERENCES `contractor_users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `contractor_has_users_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `contractor_users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `oauth_access_token_providers`
--
ALTER TABLE `oauth_access_token_providers`
  ADD CONSTRAINT `oauth_access_token_providers_oauth_access_token_id_foreign` FOREIGN KEY (`oauth_access_token_id`) REFERENCES `oauth_access_tokens` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `servicerequest_images`
--
ALTER TABLE `servicerequest_images`
  ADD CONSTRAINT `servicerequest_images_service_request_id_foreign` FOREIGN KEY (`service_request_id`) REFERENCES `work_orders` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `site_locations`
--
ALTER TABLE `site_locations`
  ADD CONSTRAINT `site_locations_company_user_id_foreign` FOREIGN KEY (`company_user_id`) REFERENCES `company_users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `subscriptions`
--
ALTER TABLE `subscriptions`
  ADD CONSTRAINT `subscriptions_company_user_id_foreign` FOREIGN KEY (`company_user_id`) REFERENCES `company_users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `task_images`
--
ALTER TABLE `task_images`
  ADD CONSTRAINT `task_images_work_task_id_foreign` FOREIGN KEY (`work_task_id`) REFERENCES `work_tasks` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_company_user_id_foreign` FOREIGN KEY (`company_user_id`) REFERENCES `company_users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `transactions_subscription_plan_id_foreign` FOREIGN KEY (`subscription_plan_id`) REFERENCES `subscription_plans` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_subscriptions`
--
ALTER TABLE `user_subscriptions`
  ADD CONSTRAINT `user_subscriptions_company_user_id_foreign` FOREIGN KEY (`company_user_id`) REFERENCES `company_users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_subscriptions_subscription_plan_id_foreign` FOREIGN KEY (`subscription_plan_id`) REFERENCES `subscription_plans` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `work_categories`
--
ALTER TABLE `work_categories`
  ADD CONSTRAINT `work_categories_company_user_id_foreign` FOREIGN KEY (`company_user_id`) REFERENCES `company_users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `work_orders`
--
ALTER TABLE `work_orders`
  ADD CONSTRAINT `work_orders_site_location_id_foreign` FOREIGN KEY (`site_location_id`) REFERENCES `site_locations` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `work_parts`
--
ALTER TABLE `work_parts`
  ADD CONSTRAINT `work_parts_work_order_id_foreign` FOREIGN KEY (`work_order_id`) REFERENCES `work_orders` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `work_tasks`
--
ALTER TABLE `work_tasks`
  ADD CONSTRAINT `work_tasks_work_category_id_foreign` FOREIGN KEY (`work_category_id`) REFERENCES `work_categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `work_tasks_work_order_id_foreign` FOREIGN KEY (`work_order_id`) REFERENCES `work_orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `work_tasks_work_priority_id_foreign` FOREIGN KEY (`work_priority_id`) REFERENCES `work_priorities` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `work_task_comments`
--
ALTER TABLE `work_task_comments`
  ADD CONSTRAINT `work_task_comments_work_task_id_foreign` FOREIGN KEY (`work_task_id`) REFERENCES `work_tasks` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
