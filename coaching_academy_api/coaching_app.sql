/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.6.2-MariaDB, for osx10.17 (x86_64)
--
-- Host: localhost    Database: caoching_app
-- ------------------------------------------------------
-- Server version	11.6.2-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Table structure for table `bookings`
--

DROP TABLE IF EXISTS `bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bookings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `coach_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `service_name` varchar(255) NOT NULL,
  `price` decimal(8,2) NOT NULL,
  `status` enum('pending','completed','cancelled') NOT NULL,
  `booking_time` datetime NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bookings_coach_id_foreign` (`coach_id`),
  KEY `bookings_user_id_foreign` (`user_id`),
  CONSTRAINT `bookings_coach_id_foreign` FOREIGN KEY (`coach_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `bookings_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookings`
--

LOCK TABLES `bookings` WRITE;
/*!40000 ALTER TABLE `bookings` DISABLE KEYS */;
/*!40000 ALTER TABLE `bookings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coach_services`
--

DROP TABLE IF EXISTS `coach_services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `coach_services` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `service_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `duration` varchar(255) DEFAULT NULL,
  `price` decimal(8,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `coach_services_service_id_foreign` (`service_id`),
  CONSTRAINT `coach_services_service_id_foreign` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coach_services`
--

LOCK TABLES `coach_services` WRITE;
/*!40000 ALTER TABLE `coach_services` DISABLE KEYS */;
INSERT INTO `coach_services` VALUES
(3,70,'name service','2',10.00,'2025-06-23 21:19:03','2025-06-23 21:19:03'),
(4,71,'activity name','3',20.00,'2025-06-23 21:28:38','2025-06-23 21:28:38'),
(5,72,'acitvity','30',100.00,'2025-06-23 21:37:19','2025-06-23 21:37:19'),
(6,73,'acitivity name','20',30.00,'2025-06-23 21:48:08','2025-06-23 21:48:08'),
(7,73,'acitivity name 2','30',100.00,'2025-06-23 21:49:53','2025-06-23 21:49:53'),
(8,73,'acitivity name 2','30',100.00,'2025-06-23 21:50:18','2025-06-23 21:50:18'),
(10,74,'act','6',100.00,'2025-06-23 22:31:10','2025-06-23 22:31:10'),
(11,74,'act','2',100.00,'2025-06-23 22:35:35','2025-06-23 22:35:35'),
(12,74,'act1','8',100.00,'2025-06-23 22:44:03','2025-06-23 22:44:03'),
(13,74,'act1','6',100.00,'2025-06-23 22:44:59','2025-06-23 22:44:59');
/*!40000 ALTER TABLE `coach_services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `content` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `comments_post_id_foreign` (`post_id`),
  KEY `comments_user_id_foreign` (`user_id`),
  CONSTRAINT `comments_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `comments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contact_messages`
--

DROP TABLE IF EXISTS `contact_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contact_messages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `sender_id` bigint(20) unsigned NOT NULL,
  `receiver_id` bigint(20) unsigned NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `contact_messages_sender_id_foreign` (`sender_id`),
  KEY `contact_messages_receiver_id_foreign` (`receiver_id`),
  CONSTRAINT `contact_messages_receiver_id_foreign` FOREIGN KEY (`receiver_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `contact_messages_sender_id_foreign` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact_messages`
--

LOCK TABLES `contact_messages` WRITE;
/*!40000 ALTER TABLE `contact_messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `contact_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `events` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `start_time` timestamp NOT NULL,
  `end_time` timestamp NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `coach_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `events_coach_id_foreign` (`coach_id`),
  CONSTRAINT `events_coach_id_foreign` FOREIGN KEY (`coach_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events`
--

LOCK TABLES `events` WRITE;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
/*!40000 ALTER TABLE `events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `likes`
--

DROP TABLE IF EXISTS `likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `likes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `likes_post_id_foreign` (`post_id`),
  KEY `likes_user_id_foreign` (`user_id`),
  CONSTRAINT `likes_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `likes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes`
--

LOCK TABLES `likes` WRITE;
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
/*!40000 ALTER TABLE `likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `sender_id` bigint(20) unsigned NOT NULL,
  `receiver_id` bigint(20) unsigned NOT NULL,
  `content` text NOT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `messages_sender_id_foreign` (`sender_id`),
  KEY `messages_receiver_id_foreign` (`receiver_id`),
  CONSTRAINT `messages_receiver_id_foreign` FOREIGN KEY (`receiver_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `messages_sender_id_foreign` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES
(1,12,13,'xcbfd sddv dsgd sdvszd',0,'2025-06-21 10:55:17','2025-06-21 10:55:17'),
(2,12,10,'Hi, user name',0,'2025-06-21 12:30:44','2025-06-21 12:30:44'),
(3,12,10,'Where are you?',0,'2025-06-21 12:30:55','2025-06-21 12:30:55'),
(4,12,11,'Salut Test',0,'2025-06-21 19:01:35','2025-06-21 19:01:35'),
(5,12,13,'Salut Coach',0,'2025-06-21 22:07:37','2025-06-21 22:07:37'),
(6,12,13,'fdd dzfzdv dzdz d',0,'2025-06-21 22:18:36','2025-06-21 22:18:36'),
(7,12,13,'v dv',0,'2025-06-21 22:26:40','2025-06-21 22:26:40'),
(8,12,13,'azertyuiop',0,'2025-06-22 18:01:59','2025-06-22 18:01:59'),
(9,12,13,'salut',0,'2025-06-23 23:36:17','2025-06-23 23:36:17'),
(10,12,13,'salut toi',0,'2025-06-23 23:36:51','2025-06-23 23:36:51'),
(11,12,13,'Salut coach',0,'2025-06-23 23:51:21','2025-06-23 23:51:21'),
(12,12,13,'Salut coach',0,'2025-06-23 23:53:51','2025-06-23 23:53:51'),
(13,12,13,'hi',0,'2025-06-23 23:58:57','2025-06-23 23:58:57');
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES
(1,'2014_10_12_000000_create_users_table',1),
(2,'2014_10_12_100000_create_password_reset_tokens_table',1),
(3,'2019_08_19_000000_create_failed_jobs_table',1),
(4,'2019_12_14_000001_create_personal_access_tokens_table',1),
(5,'2025_04_30_165533_add_role_to_users_table',2),
(6,'2025_04_30_180030_create_services_table',3),
(7,'2025_05_01_122033_add_location_fields_to_users_table',4),
(13,'2025_05_05_225857_create_events_table',9),
(14,'2025_05_06_173517_create_posts_table',10),
(15,'2025_05_07_135806_create_bookings_table',10),
(16,'2025_05_07_185955_add_signup_fields_to_users_table',11),
(17,'2025_05_08_003918_create_likes_table',12),
(18,'2025_05_08_003935_create_comments_table',12),
(19,'2025_05_08_210159_create_contact_messages_table',13),
(21,'2025_05_08_212928_create_table_contact_messages',14),
(23,'2025_05_02_013452_create_working_hours_table',16),
(24,'2025_05_05_010013_create_coach_services_table',17),
(26,'2025_05_12_215417_create_table_workspace_medias',18),
(27,'2025_05_16_005205_create_messages_table',19),
(28,'2025_05_16_230333_add_timestamps_to_messages_table',20),
(29,'2025_06_21_201647_create_notification_customs_table',21),
(30,'2025_06_21_232536_add_updated_at_to_notification_customs_table',22),
(31,'2025_06_22_184843_add_sender_info_to_notification_customs_table',23);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification_customs`
--

DROP TABLE IF EXISTS `notification_customs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notification_customs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `sender_id` bigint(20) unsigned DEFAULT NULL,
  `sender_name` varchar(255) DEFAULT NULL,
  `sender_image` varchar(255) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification_customs`
--

LOCK TABLES `notification_customs` WRITE;
/*!40000 ALTER TABLE `notification_customs` DISABLE KEYS */;
INSERT INTO `notification_customs` VALUES
(1,13,NULL,NULL,NULL,'Nouveau message','Vous avez reçu un message de sporty',0,'2025-06-21 22:26:40','2025-06-21 22:26:40'),
(2,13,NULL,NULL,NULL,'Nouveau message','Vous avez reçu un message de sporty',0,'2025-06-22 18:01:59','2025-06-22 18:01:59'),
(3,13,NULL,NULL,NULL,'Nouveau message','Vous avez reçu un message de sporty',0,'2025-06-23 23:53:51','2025-06-23 23:53:51'),
(4,13,NULL,NULL,NULL,'Nouveau message','Vous avez reçu un message de sporty',0,'2025-06-23 23:58:57','2025-06-23 23:58:57');
/*!40000 ALTER TABLE `notification_customs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB AUTO_INCREMENT=269 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
INSERT INTO `personal_access_tokens` VALUES
(1,'App\\Models\\User',1,'mobile_token','ae3ea14886fbf21188c7f5fa9aac769dd6aacd0956f2204cc3270b81ca874692','[\"*\"]',NULL,NULL,'2025-04-29 01:55:27','2025-04-29 01:55:27'),
(2,'App\\Models\\User',1,'mobile_token','d18283d60119442ad35e7ddb8a8b23662540ac9bc14b317bf9c542907d4341d3','[\"*\"]',NULL,NULL,'2025-04-29 01:56:04','2025-04-29 01:56:04'),
(3,'App\\Models\\User',1,'mobile_token','b9111cfdec4e6a5ecfbe9922b7885ff9a942df6cc480a1b11c4e049b1298fa2f','[\"*\"]',NULL,NULL,'2025-04-30 15:24:19','2025-04-30 15:24:19'),
(4,'App\\Models\\User',1,'mobile_token','106b6164f73fb2e1a1aba8fd459941130fd679122a84a826f2a6db2d544bad2c','[\"*\"]',NULL,NULL,'2025-04-30 15:25:08','2025-04-30 15:25:08'),
(5,'App\\Models\\User',1,'mobile_token','3fee753491b0d3d30152e1f5ae90cbb8e0f0a441d495deb6be340e574a2ca86c','[\"*\"]',NULL,NULL,'2025-04-30 15:25:17','2025-04-30 15:25:17'),
(6,'App\\Models\\User',1,'mobile_token','d90a753777f708cb41e02a907c500f9119750f3837bfb0cc3a39a45750ab61ae','[\"*\"]',NULL,NULL,'2025-04-30 15:26:26','2025-04-30 15:26:26'),
(7,'App\\Models\\User',1,'mobile_token','e01a37d3889b0f5c27ac06913dec410f8d6c21ff15176e179ab322f14a21e1ef','[\"*\"]',NULL,NULL,'2025-04-30 15:48:48','2025-04-30 15:48:48'),
(8,'App\\Models\\User',1,'mobile_token','ff2f6788721d7748999879b76891e21acb566da08d3f8656daa90be8bfa0eb6e','[\"*\"]',NULL,NULL,'2025-04-30 16:15:05','2025-04-30 16:15:05'),
(9,'App\\Models\\User',1,'mobile_token','ac54d9d0e83883547f86c387859cb9296c25bd990d89c02cc025a3edeccfdc72','[\"*\"]',NULL,NULL,'2025-04-30 16:18:01','2025-04-30 16:18:01'),
(10,'App\\Models\\User',1,'mobile_token','6a18f6c69b5d0cd7e271692b9d5c1ce165dc424f1e696b70c73d05ed923a8fc8','[\"*\"]',NULL,NULL,'2025-04-30 16:30:39','2025-04-30 16:30:39'),
(11,'App\\Models\\User',1,'mobile_token','00bd5ac946ec50690a01d10bcec09db177b899d2a8ce94f571b0bacc426c39ce','[\"*\"]',NULL,NULL,'2025-04-30 16:36:23','2025-04-30 16:36:23'),
(12,'App\\Models\\User',1,'mobile_token','63859ec2592a5f672e1f006116fb56b78e75875904112d8e269656aa1a35290e','[\"*\"]','2025-04-30 16:38:32',NULL,'2025-04-30 16:38:15','2025-04-30 16:38:32'),
(13,'App\\Models\\User',1,'mobile_token','9267af491b39d38aaadaf652af6378d37ea9a17cd28cf4aaea6d2a14f9c06e86','[\"*\"]','2025-04-30 21:22:36',NULL,'2025-04-30 17:14:05','2025-04-30 21:22:36'),
(14,'App\\Models\\User',1,'mobile_token','baab3de4e3ef7c5db2690b44aeac365090f27c7a3eb297a64dbf47780add310b','[\"*\"]','2025-04-30 21:25:58',NULL,'2025-04-30 21:25:34','2025-04-30 21:25:58'),
(15,'App\\Models\\User',1,'mobile_token','712fa4f1b9c353169820d94fe9ac6933161d6a7df3c26b29de25c88ebed7d602','[\"*\"]','2025-05-01 11:08:27',NULL,'2025-05-01 11:07:53','2025-05-01 11:08:27'),
(16,'App\\Models\\User',1,'mobile_token','af73e645fac6c8cc7a7af3e4beea1afe4903e42c70a4fcb34e6418716115949a','[\"*\"]','2025-05-01 15:18:20',NULL,'2025-05-01 15:17:51','2025-05-01 15:18:20'),
(17,'App\\Models\\User',1,'mobile_token','47882254b92260fbcbcc984f00eaa11978cd513066057d98fbda6108e2aa7f69','[\"*\"]','2025-05-01 15:40:39',NULL,'2025-05-01 15:38:27','2025-05-01 15:40:39'),
(18,'App\\Models\\User',1,'mobile_token','cbec4c5971949cf2dc6c253b54fc2986a6f993857e28843266a2b3b82d3aef5e','[\"*\"]','2025-05-01 16:12:55',NULL,'2025-05-01 16:12:33','2025-05-01 16:12:55'),
(19,'App\\Models\\User',1,'mobile_token','7962437702870c9fdefd91b8aeac22839dbffbad8b043159b9979f7d8aa88ac8','[\"*\"]','2025-05-01 16:15:27',NULL,'2025-05-01 16:15:07','2025-05-01 16:15:27'),
(20,'App\\Models\\User',1,'mobile_token','95cb13fe037273af53ac5ab495776b43e204b0d0c37c934f98b9c08e50919fe7','[\"*\"]','2025-05-01 16:35:35',NULL,'2025-05-01 16:34:52','2025-05-01 16:35:35'),
(21,'App\\Models\\User',1,'mobile_token','fe24901f53c8da801f10d8d2ffbb2d26a0e4b41932c7b2b7ee88fb3c0841784c','[\"*\"]','2025-05-01 16:48:36',NULL,'2025-05-01 16:48:21','2025-05-01 16:48:36'),
(22,'App\\Models\\User',1,'mobile_token','7ac5ea0f208463e9510e9adfc3006b4877be6bd6a8ac0f83a50093b138b8364d','[\"*\"]','2025-05-01 17:00:32',NULL,'2025-05-01 16:59:58','2025-05-01 17:00:32'),
(23,'App\\Models\\User',1,'mobile_token','ba85df79aa1379f77c82152e61837d75bde2a1869592935dad216fc195089c36','[\"*\"]','2025-05-01 17:07:15',NULL,'2025-05-01 17:06:55','2025-05-01 17:07:15'),
(24,'App\\Models\\User',1,'mobile_token','eff9016d7db2731048616f37342b393a3216b63530c8527ee95eda0931353320','[\"*\"]','2025-05-01 17:09:30',NULL,'2025-05-01 17:09:08','2025-05-01 17:09:30'),
(25,'App\\Models\\User',1,'mobile_token','887ef43afbe7ac1052a64b54fbd4e95656efa757d0da4331079daeb8f6e56d02','[\"*\"]','2025-05-01 17:12:50',NULL,'2025-05-01 17:12:26','2025-05-01 17:12:50'),
(26,'App\\Models\\User',1,'mobile_token','fd751ed6e710caf0d59c026736203f7c9242d03cac1d4b26839541f42f4a252a','[\"*\"]','2025-05-01 22:43:16',NULL,'2025-05-01 22:42:56','2025-05-01 22:43:16'),
(27,'App\\Models\\User',1,'mobile_token','68871b08fbb2bf4124cece449860c32e680fb52d0050c6a9466e8792f6746c3e','[\"*\"]','2025-05-02 00:03:16',NULL,'2025-05-02 00:02:40','2025-05-02 00:03:16'),
(28,'App\\Models\\User',1,'mobile_token','bb57c3ae33a62d271e3bab7174e0fb6e1933e097d919f42c621d248a3a747462','[\"*\"]','2025-05-02 01:30:13',NULL,'2025-05-02 01:29:02','2025-05-02 01:30:13'),
(29,'App\\Models\\User',1,'mobile_token','c3c0454137527e519389d18dedb432c0c4b6f6fc0ddebc407c62a32b9b57f20c','[\"*\"]','2025-05-02 02:04:09',NULL,'2025-05-02 02:03:16','2025-05-02 02:04:09'),
(30,'App\\Models\\User',1,'mobile_token','f821a07f13464a64075528f8ed7567fad597ff09453d8fb9d2706d71c22e47bf','[\"*\"]','2025-05-02 08:22:36',NULL,'2025-05-02 08:21:35','2025-05-02 08:22:36'),
(31,'App\\Models\\User',1,'mobile_token','7946deeef88747630c201f960dcf6aa087df6536496cc80c7fb40a21bf05afff','[\"*\"]','2025-05-02 08:28:07',NULL,'2025-05-02 08:27:15','2025-05-02 08:28:07'),
(32,'App\\Models\\User',1,'mobile_token','a23e2bea8a6b1863479398f52c10841efcc59b0e1f769ace9ab8847f93409c5e','[\"*\"]','2025-05-02 08:40:46',NULL,'2025-05-02 08:39:51','2025-05-02 08:40:46'),
(33,'App\\Models\\User',1,'mobile_token','b564723ca46374a14ab73a2e391a7d75c58e00119b3134bdd8eae68db40bbcf1','[\"*\"]','2025-05-02 23:14:52',NULL,'2025-05-02 23:07:45','2025-05-02 23:14:52'),
(34,'App\\Models\\User',1,'mobile_token','9394814c139bf49a89672faa48d58a255792d432faf7fd5f9d203e12db20efb3','[\"*\"]','2025-05-03 00:13:05',NULL,'2025-05-03 00:12:40','2025-05-03 00:13:05'),
(35,'App\\Models\\User',1,'mobile_token','9f11748114c3a54e98e2c76004ec90c757d4b3c41d6be10bafa107e79d33331c','[\"*\"]','2025-05-03 00:18:12',NULL,'2025-05-03 00:17:44','2025-05-03 00:18:12'),
(36,'App\\Models\\User',1,'mobile_token','49301b1ddc01267abe77e9919c486c6ec2b2a3d7a3816b7a6fd4c4f543f5eb6e','[\"*\"]','2025-05-03 00:43:28',NULL,'2025-05-03 00:42:37','2025-05-03 00:43:28'),
(37,'App\\Models\\User',1,'mobile_token','4524218758c88354a0b7a94ff17ba9db16ce6b7e4d0feef3d0cde88d60736f73','[\"*\"]','2025-05-03 01:23:50',NULL,'2025-05-03 00:50:56','2025-05-03 01:23:50'),
(38,'App\\Models\\User',1,'mobile_token','c801d9a2d3ae675f35877c591923125eb499c7942793aa43250feef48522dcb3','[\"*\"]',NULL,NULL,'2025-05-04 18:52:33','2025-05-04 18:52:33'),
(39,'App\\Models\\User',1,'mobile_token','1a705d57097a5049f33dc592e740ae74b4b526c46c26596e7a01b100e433ccb9','[\"*\"]','2025-05-04 18:54:50',NULL,'2025-05-04 18:52:34','2025-05-04 18:54:50'),
(40,'App\\Models\\User',1,'mobile_token','8286500ee9d9193540c5283e3e08671f613069f7394d8142796e67d5640ef0e0','[\"*\"]','2025-05-04 19:01:54',NULL,'2025-05-04 19:00:50','2025-05-04 19:01:54'),
(41,'App\\Models\\User',1,'mobile_token','0dbbc2878fa3b247f5e6f51616ad118c6454246b475f6eb0ffc9b55f60334055','[\"*\"]','2025-05-04 19:03:40',NULL,'2025-05-04 19:02:59','2025-05-04 19:03:40'),
(42,'App\\Models\\User',1,'mobile_token','70b6a7d47b5383a23d56fec4340bccf40b60d40b1d5d9aa553fc372735b54cb7','[\"*\"]','2025-05-04 19:05:50',NULL,'2025-05-04 19:05:01','2025-05-04 19:05:50'),
(43,'App\\Models\\User',1,'mobile_token','a45d9ae3ec1b4ac8a4568c066a917e72e6745364e16fc1e4ac175036938fe365','[\"*\"]','2025-05-04 19:08:07',NULL,'2025-05-04 19:07:15','2025-05-04 19:08:07'),
(44,'App\\Models\\User',1,'mobile_token','2d2a5af9c74294023e4b5c083d760033565e808622d28085ef4583faec4dbed4','[\"*\"]','2025-05-04 19:21:14',NULL,'2025-05-04 19:19:56','2025-05-04 19:21:14'),
(45,'App\\Models\\User',1,'mobile_token','df5df8718554fc15bae6f23b5280c418091f2d5ff8a85b5b5a377f39d5190763','[\"*\"]','2025-05-04 20:46:47',NULL,'2025-05-04 20:07:05','2025-05-04 20:46:47'),
(46,'App\\Models\\User',1,'mobile_token','46bec5e91b67948d2b65375c9cebd031366d1eea19e2e5f41cdf74cace6e98a4','[\"*\"]','2025-05-04 21:22:16',NULL,'2025-05-04 20:51:56','2025-05-04 21:22:16'),
(47,'App\\Models\\User',1,'mobile_token','b72a1a2ac291b4edf0dbd271f4e3de963f9c6136e7311c6d7ba8ce5b177b9eeb','[\"*\"]','2025-05-04 21:29:40',NULL,'2025-05-04 21:28:42','2025-05-04 21:29:40'),
(48,'App\\Models\\User',1,'mobile_token','61075ed489b323f91e181af3df5c1af8679c60b2e0cd54cc5da61de20cb3e7ff','[\"*\"]','2025-05-04 22:01:19',NULL,'2025-05-04 22:00:10','2025-05-04 22:01:19'),
(49,'App\\Models\\User',1,'mobile_token','5e32dd3fcb3edcb91bbe2db8220774dc7df583605cee3cc67d281931a13a8773','[\"*\"]','2025-05-04 22:18:49',NULL,'2025-05-04 22:17:02','2025-05-04 22:18:49'),
(50,'App\\Models\\User',1,'mobile_token','32447d501dfba2b2c3f129079c342f2e1dae2da604388021b3dbbb31cc0c214f','[\"*\"]','2025-05-04 22:27:46',NULL,'2025-05-04 22:26:38','2025-05-04 22:27:46'),
(51,'App\\Models\\User',1,'mobile_token','d093fbd36f2c581e273321e98be6c400a0fd248c9bee417a9fabc5cba4de5d67','[\"*\"]','2025-05-04 22:36:28',NULL,'2025-05-04 22:34:32','2025-05-04 22:36:28'),
(52,'App\\Models\\User',1,'mobile_token','d60eb98f1c49abd16a15d3f0ffefd239ba6fe7ece9149607a048d297e9ca32a5','[\"*\"]','2025-05-04 23:46:30',NULL,'2025-05-04 23:45:01','2025-05-04 23:46:30'),
(53,'App\\Models\\User',1,'mobile_token','5add2b02d39c9bd4f990f63b153f6ae2548550bf40652992bf3ee7e41f0084fa','[\"*\"]','2025-05-05 00:17:29',NULL,'2025-05-04 23:47:44','2025-05-05 00:17:29'),
(54,'App\\Models\\User',1,'mobile_token','ed56c989fdc3816e7ca2ef64b496ec908839d920a00132cbed3c4e9bccade55e','[\"*\"]','2025-05-05 00:23:27',NULL,'2025-05-05 00:19:44','2025-05-05 00:23:27'),
(55,'App\\Models\\User',1,'mobile_token','30e502b2daad2baa1d418756091132f82a15b61b5ceaf10d9feff752f9f9376e','[\"*\"]','2025-05-05 00:31:41',NULL,'2025-05-05 00:25:33','2025-05-05 00:31:41'),
(56,'App\\Models\\User',1,'mobile_token','6d8726a08a751f985f41359f1df084d0e825e149f7c086cb8b1e1c2198385a1b','[\"*\"]','2025-05-05 00:36:04',NULL,'2025-05-05 00:34:50','2025-05-05 00:36:04'),
(57,'App\\Models\\User',1,'mobile_token','b373015410b3b279845ecc00e07786eb1f32586ed282a76681c0589c6b9b93f2','[\"*\"]','2025-05-05 12:24:58',NULL,'2025-05-05 04:10:23','2025-05-05 12:24:58'),
(58,'App\\Models\\User',1,'mobile_token','d56721827dbb5f3f1f21bfc329aed698acf8eeae7eff5018e972dfb3c005c981','[\"*\"]','2025-05-05 20:13:04',NULL,'2025-05-05 19:34:51','2025-05-05 20:13:04'),
(59,'App\\Models\\User',1,'mobile_token','03e97cfaa6c4c922cf564aa2d45edb9c53d3984f768bebf19e62dad0c870db9b','[\"*\"]','2025-05-05 22:13:40',NULL,'2025-05-05 22:12:25','2025-05-05 22:13:40'),
(60,'App\\Models\\User',1,'mobile_token','2bf8a116c5f214747d0089f41f49d6885cdfa1bb4648b7ccea8902e210b23cc2','[\"*\"]','2025-05-05 22:17:15',NULL,'2025-05-05 22:15:57','2025-05-05 22:17:15'),
(61,'App\\Models\\User',1,'mobile_token','867c631327dbdec50fbd876901482448ce94e2a8951b28c6b92a7de258cd90a5','[\"*\"]','2025-05-06 14:12:39',NULL,'2025-05-06 14:11:03','2025-05-06 14:12:39'),
(62,'App\\Models\\User',1,'mobile_token','b006d984862e971a9b4287498484390594727952f0c84074c58f4e238a8d2ad4','[\"*\"]','2025-05-06 14:39:48',NULL,'2025-05-06 14:38:44','2025-05-06 14:39:48'),
(63,'App\\Models\\User',1,'mobile_token','3b5a5073f0b2cdbebc1aaf91515446e6b817941e290fdd1f664bc79c3791f367','[\"*\"]','2025-05-06 15:09:10',NULL,'2025-05-06 15:08:12','2025-05-06 15:09:10'),
(64,'App\\Models\\User',1,'mobile_token','3c7c8eff55f2b88f15c09bb81d97945e7176bbaa33b518deb04272d898a336fe','[\"*\"]','2025-05-06 15:20:23',NULL,'2025-05-06 15:19:16','2025-05-06 15:20:23'),
(65,'App\\Models\\User',1,'mobile_token','cb0b3cedda50bb948eba8d966220d653e0cd75f28bc4983acc1623368fa9f30a','[\"*\"]','2025-05-07 00:35:51',NULL,'2025-05-06 23:46:34','2025-05-07 00:35:51'),
(66,'App\\Models\\User',1,'mobile_token','dbecb5911204a448911787f38187996b495fbed15278caaef27d4ffe437acf50','[\"*\"]','2025-05-07 17:05:28',NULL,'2025-05-07 14:21:37','2025-05-07 17:05:28'),
(67,'App\\Models\\User',1,'mobile_token','82c015f27f58bce71557ec09d851f182db7ccda5fd761c4f82cbd5d4cbc53b0f','[\"*\"]','2025-05-07 14:34:15',NULL,'2025-05-07 14:34:07','2025-05-07 14:34:15'),
(68,'App\\Models\\User',1,'mobile_token','1735335b9719bf037ee2e607e045a9f61b435c970eb9b80e6541a6034f3b379a','[\"*\"]','2025-05-07 15:05:50',NULL,'2025-05-07 15:05:46','2025-05-07 15:05:50'),
(69,'App\\Models\\User',1,'mobile_token','570cf68e32f2da7d2da8f57cd6d343d34009f14657f914e2df97fc03e169f3ba','[\"*\"]','2025-05-07 15:51:19',NULL,'2025-05-07 15:51:17','2025-05-07 15:51:19'),
(70,'App\\Models\\User',1,'mobile_token','15f55c033184760b8b0a0294bba038ba92bbd2ac16743e316d35b5dc8416e276','[\"*\"]','2025-05-07 16:29:10',NULL,'2025-05-07 16:28:12','2025-05-07 16:29:10'),
(71,'App\\Models\\User',1,'mobile_token','149c9d88134659d660bea062db4ce7eef58d11ff77f45a0c5b63be1b7de38851','[\"*\"]','2025-05-07 16:39:29',NULL,'2025-05-07 16:39:26','2025-05-07 16:39:29'),
(72,'App\\Models\\User',5,'mobile_token','3c5b3d96ee9648e1262749db99fcaa74c5498faafc1fbb97768ce1ba0a04fdf0','[\"*\"]','2025-05-07 21:01:57',NULL,'2025-05-07 21:01:49','2025-05-07 21:01:57'),
(73,'App\\Models\\User',1,'mobile_token','fb0cf277d34094a5c9f3a3fb2cf82b4c7a81acd47de7a15172a3061a9c8f7314','[\"*\"]','2025-05-07 21:04:22',NULL,'2025-05-07 21:03:49','2025-05-07 21:04:22'),
(74,'App\\Models\\User',5,'mobile_token','56826eee62c39976d30962e76429dfa102fe8f29f65d7f51e558135f71bf0529','[\"*\"]',NULL,NULL,'2025-05-07 21:35:50','2025-05-07 21:35:50'),
(75,'App\\Models\\User',1,'mobile_token','fc735dd36ce90f204320e447dfd36479563048d9b5e62f932ca299d79a555d5c','[\"*\"]','2025-05-07 21:38:28',NULL,'2025-05-07 21:36:09','2025-05-07 21:38:28'),
(76,'App\\Models\\User',1,'mobile_token','6d1e80f65465966d0ccb4d6e7eb0eaf52d996ac3b9fcfd1c9960cf700ca90f1a','[\"*\"]','2025-05-07 21:45:41',NULL,'2025-05-07 21:44:27','2025-05-07 21:45:41'),
(77,'App\\Models\\User',1,'mobile_token','7a69775444013a78aa2b4acd43a095342a92efba534500be2e36fa6f4400b535','[\"*\"]','2025-05-07 21:56:28',NULL,'2025-05-07 21:56:26','2025-05-07 21:56:28'),
(78,'App\\Models\\User',1,'mobile_token','362893f3dd13486df5b6d92b99f17d1de51a68aa5792e83f33ab86f807e93a8f','[\"*\"]','2025-05-07 22:03:22',NULL,'2025-05-07 22:02:59','2025-05-07 22:03:22'),
(79,'App\\Models\\User',1,'mobile_token','a97bffae62ce623120086e95f15e4a84620d4edf97ac101c64b09abb6a73a17f','[\"*\"]','2025-05-07 22:22:33',NULL,'2025-05-07 22:22:28','2025-05-07 22:22:33'),
(80,'App\\Models\\User',1,'mobile_token','7ba74d5920b3a57803859d69b3cb940615e2855566129efba950afd8cc39a749','[\"*\"]','2025-05-07 22:24:35',NULL,'2025-05-07 22:24:30','2025-05-07 22:24:35'),
(81,'App\\Models\\User',1,'mobile_token','682a411168c93bcde9a179b0fbddda3ff2abce0b466ced37a551884538e9d1c5','[\"*\"]','2025-05-07 22:26:09',NULL,'2025-05-07 22:26:03','2025-05-07 22:26:09'),
(82,'App\\Models\\User',5,'mobile_token','4cfd378dcda8520ae01fa47c807492001f5efb6866a3d341ebf8ff540add3362','[\"*\"]','2025-05-07 22:27:14',NULL,'2025-05-07 22:27:12','2025-05-07 22:27:14'),
(83,'App\\Models\\User',6,'mobile_token','560be76f2bc47ed173ede61e96742c1ed7d6b9fa5c1d65c9fa23cbc7e74d6ad7','[\"*\"]','2025-05-07 22:31:19',NULL,'2025-05-07 22:29:37','2025-05-07 22:31:19'),
(84,'App\\Models\\User',10,'mobile_token','0f9b5db5b2acff7fb6a0ffac3cf092613db24d92aea23223abe814ac32ca3f34','[\"*\"]','2025-05-07 23:26:38',NULL,'2025-05-07 23:23:29','2025-05-07 23:26:38'),
(85,'App\\Models\\User',10,'mobile_token','0a2943a91c12dec21e5abe27ab7aed6abef1a72d31a4e1e69cef7b11018ca2f3','[\"*\"]','2025-05-08 00:00:22',NULL,'2025-05-08 00:00:17','2025-05-08 00:00:22'),
(86,'App\\Models\\User',10,'mobile_token','b2a8c34f23e5c854cc3c94768e527c791076801963de597c0ec02e282e3d6a70','[\"*\"]','2025-05-08 00:09:02',NULL,'2025-05-08 00:04:31','2025-05-08 00:09:02'),
(87,'App\\Models\\User',10,'mobile_token','a0d525b494e6996833ca824e981bc26bdcb416019fa707105bd34a7c1463c7fb','[\"*\"]','2025-05-08 00:15:47',NULL,'2025-05-08 00:10:09','2025-05-08 00:15:47'),
(88,'App\\Models\\User',10,'mobile_token','866dc16fd3b5461cf00da9ae4f4469ae2ae444b060860db4d7ee64a6bf0e1a39','[\"*\"]','2025-05-08 00:24:01',NULL,'2025-05-08 00:19:05','2025-05-08 00:24:01'),
(89,'App\\Models\\User',10,'mobile_token','2aef8dc344b5806187b6a7962563cc281688f9da29037a1713ba43b085755c4b','[\"*\"]','2025-05-08 00:30:02',NULL,'2025-05-08 00:26:48','2025-05-08 00:30:02'),
(90,'App\\Models\\User',10,'mobile_token','546f7a5b93ff133a6bd5be3fbf8adca5e801de4751296c35bcd72f43e73b2d0d','[\"*\"]','2025-05-08 00:34:46',NULL,'2025-05-08 00:34:38','2025-05-08 00:34:46'),
(91,'App\\Models\\User',10,'mobile_token','7570309dcc404758e341a14d1485009588b55405db1d3c501a8032d3864d31b5','[\"*\"]','2025-05-08 00:53:46',NULL,'2025-05-08 00:53:37','2025-05-08 00:53:46'),
(92,'App\\Models\\User',10,'mobile_token','966c891fdc6acc5d9f744d4c360c0b408e7cbaae8e7a68ef9fb8716c972d46a5','[\"*\"]','2025-05-08 00:58:20',NULL,'2025-05-08 00:58:12','2025-05-08 00:58:20'),
(93,'App\\Models\\User',10,'mobile_token','ccc657646bbc4ab2ee921a266e982a65f251a58fd732c717cbfbe38e67493d17','[\"*\"]','2025-05-08 01:06:18',NULL,'2025-05-08 01:06:11','2025-05-08 01:06:18'),
(94,'App\\Models\\User',10,'mobile_token','2748539dd2077679ae25704ad899325ac883caf0141093af37991d00cb41262c','[\"*\"]',NULL,NULL,'2025-05-08 01:08:35','2025-05-08 01:08:35'),
(95,'App\\Models\\User',10,'mobile_token','f56f1cba017c1d53af5f4d5d8179796a109db9c472d534363755771d8172adeb','[\"*\"]','2025-05-08 01:08:43',NULL,'2025-05-08 01:08:35','2025-05-08 01:08:43'),
(96,'App\\Models\\User',10,'mobile_token','93a1d93379d2ebb69762a152391e7235139723fc38d6a166305157e6b2b0b23f','[\"*\"]','2025-05-08 01:13:14',NULL,'2025-05-08 01:13:06','2025-05-08 01:13:14'),
(97,'App\\Models\\User',10,'mobile_token','b32f30533a7e7aea9989bd13d5960af40abd07f016c46b7caabfde4a6afecd6a','[\"*\"]','2025-05-08 01:16:45',NULL,'2025-05-08 01:16:36','2025-05-08 01:16:45'),
(98,'App\\Models\\User',10,'mobile_token','e7ec270e975fef06e7a0b7d0e4bdf773b48f531b4ea77e7faaa0e9c3b94b3ec2','[\"*\"]','2025-05-08 01:19:28',NULL,'2025-05-08 01:19:04','2025-05-08 01:19:28'),
(99,'App\\Models\\User',11,'mobile_token','6b3e2768138165ae8144f7afc79e7edde0b1407c897f0e239a8fbd95b7456f7b','[\"*\"]','2025-05-08 01:33:46',NULL,'2025-05-08 01:30:50','2025-05-08 01:33:46'),
(100,'App\\Models\\User',10,'mobile_token','103699b001ff93c715458fb7add5e6185ae78bafedce5fcac1469ed4f5edcfe9','[\"*\"]','2025-05-08 10:36:44',NULL,'2025-05-08 10:36:42','2025-05-08 10:36:44'),
(101,'App\\Models\\User',10,'mobile_token','fca7602e7486891a2c0ebdca50c1d95397e85eb753c1258550e833437fb0448c','[\"*\"]','2025-05-08 10:49:25',NULL,'2025-05-08 10:49:19','2025-05-08 10:49:25'),
(102,'App\\Models\\User',10,'mobile_token','406847d2d1e8dd7e5600a9399303cd7265fb5df5b295d3f030913a8854ad80b9','[\"*\"]','2025-05-08 11:05:59',NULL,'2025-05-08 11:05:54','2025-05-08 11:05:59'),
(103,'App\\Models\\User',10,'mobile_token','6ee7a07c2a79b4aa86a54ebf1c10136b4722fa0cd0533c124cea4564fae731a2','[\"*\"]','2025-05-08 11:29:20',NULL,'2025-05-08 11:29:09','2025-05-08 11:29:20'),
(104,'App\\Models\\User',10,'mobile_token','df9c17c2844d9d99ff74973f77ea3768f242f895242c3f2f26b60e04994eca5f','[\"*\"]','2025-05-08 11:36:38',NULL,'2025-05-08 11:36:11','2025-05-08 11:36:38'),
(105,'App\\Models\\User',10,'mobile_token','8aa7ed65d7cb2a242111a439ccd000603e44dc2b760cb6a3cbee8b9384f3cbaa','[\"*\"]','2025-05-08 11:50:44',NULL,'2025-05-08 11:48:37','2025-05-08 11:50:44'),
(106,'App\\Models\\User',10,'mobile_token','59723c354baa1a0dde2cc4b5945348c66d8e1c292423f54becca421680318938','[\"*\"]','2025-05-08 12:33:44',NULL,'2025-05-08 12:33:37','2025-05-08 12:33:44'),
(107,'App\\Models\\User',10,'mobile_token','f4f4df2a29d3ff9cfd2cfa29ea4ed510c87e2f7e7595d62fb955f7736b108902','[\"*\"]','2025-05-08 13:03:23',NULL,'2025-05-08 13:02:39','2025-05-08 13:03:23'),
(108,'App\\Models\\User',10,'mobile_token','9c699fb72989d5dee8742023c3c406442d044164cebe21faece66fad05f4a430','[\"*\"]','2025-05-08 16:24:51',NULL,'2025-05-08 16:23:19','2025-05-08 16:24:51'),
(109,'App\\Models\\User',10,'mobile_token','e91cfe6160aa7c181ebaa7315f8fedd65e6f05bc619e164dd6e788221777f725','[\"*\"]','2025-05-08 16:47:22',NULL,'2025-05-08 16:46:50','2025-05-08 16:47:22'),
(110,'App\\Models\\User',10,'mobile_token','3200d798e84778b666668560f0c471e696625129972f7fa7e8d91287330fbab4','[\"*\"]','2025-05-08 16:53:29',NULL,'2025-05-08 16:52:53','2025-05-08 16:53:29'),
(111,'App\\Models\\User',10,'mobile_token','bc0b533695f3c2c979d7b1718ecca905830163290781370267ba93c7eb98c4b1','[\"*\"]','2025-05-08 16:57:04',NULL,'2025-05-08 16:54:39','2025-05-08 16:57:04'),
(112,'App\\Models\\User',10,'mobile_token','878112b7778499d9dac24770ad58df9c062749885041f59a3dd2dc6e3376cf89','[\"*\"]','2025-05-08 17:01:28',NULL,'2025-05-08 17:01:22','2025-05-08 17:01:28'),
(113,'App\\Models\\User',10,'mobile_token','f42560bc190991854ef807a20c1315d1806d1482769be61b48660bf3f2aa98f9','[\"*\"]','2025-05-08 17:06:08',NULL,'2025-05-08 17:05:56','2025-05-08 17:06:08'),
(114,'App\\Models\\User',10,'mobile_token','3454af2acd3a41febb6e4d67ca2079c66029beeb20aac29bca42e28630ef5804','[\"*\"]','2025-05-08 17:09:15',NULL,'2025-05-08 17:08:43','2025-05-08 17:09:15'),
(115,'App\\Models\\User',10,'mobile_token','4c6bac4e807750af4e39461bae4641c1d14a87337f439029b02c2a6d006a0874','[\"*\"]','2025-05-08 17:15:17',NULL,'2025-05-08 17:14:44','2025-05-08 17:15:17'),
(116,'App\\Models\\User',10,'mobile_token','02b79bb56b0de8a2aa351262245bdcd2bbda95c1a6cd606fa80843ba2e9a5f57','[\"*\"]','2025-05-08 17:22:00',NULL,'2025-05-08 17:21:01','2025-05-08 17:22:00'),
(117,'App\\Models\\User',10,'mobile_token','da85ed833b8137dbbf1776e7b8d7133512579e4bbfb3594082d08716ca866dd8','[\"*\"]','2025-05-08 17:51:45',NULL,'2025-05-08 17:51:40','2025-05-08 17:51:45'),
(118,'App\\Models\\User',10,'mobile_token','e47925bf6a4a71f7154060c68a6763fdcf7b47a93b76726c08b0ff5113fb5705','[\"*\"]','2025-05-08 17:53:48',NULL,'2025-05-08 17:53:44','2025-05-08 17:53:48'),
(119,'App\\Models\\User',10,'mobile_token','76800bb7305b48b019c83ac1c0e525fa1636d7bd12e6ab0514acfb5b1a2a7922','[\"*\"]','2025-05-08 17:54:27',NULL,'2025-05-08 17:54:23','2025-05-08 17:54:27'),
(120,'App\\Models\\User',10,'mobile_token','93ee2924ab07ab310c13db6787df3f66b543ac34fb5164e2abc72fd4116431ef','[\"*\"]','2025-05-08 17:58:21',NULL,'2025-05-08 17:58:16','2025-05-08 17:58:21'),
(121,'App\\Models\\User',10,'mobile_token','a9c47c770cf8acfaf5bbe802cd890d4979980aa47ddfa9586e48d88734be3006','[\"*\"]','2025-05-08 18:34:49',NULL,'2025-05-08 18:34:44','2025-05-08 18:34:49'),
(122,'App\\Models\\User',10,'mobile_token','0b77530ae931c7f858a18523d966e8fc81a7174924825a530ef400fd40d213f8','[\"*\"]','2025-05-08 18:46:26',NULL,'2025-05-08 18:46:17','2025-05-08 18:46:26'),
(123,'App\\Models\\User',10,'mobile_token','7d2efd2527dbc7efcf081e988d19b8d8cda3b8b99c438ad7b14caa2022eef84c','[\"*\"]','2025-05-08 19:07:04',NULL,'2025-05-08 19:03:00','2025-05-08 19:07:04'),
(124,'App\\Models\\User',10,'mobile_token','4b1521739d9c4442be0ece3ec1cb19fa671aeca3e67fab6e32e4d0fbf9abbbc4','[\"*\"]','2025-05-08 19:37:08',NULL,'2025-05-08 19:35:59','2025-05-08 19:37:08'),
(125,'App\\Models\\User',10,'mobile_token','e8aa025606ed5b6c157c409cd4fa1c1392c12a7bd74994a92442553f39fad171','[\"*\"]','2025-05-08 19:58:48',NULL,'2025-05-08 19:58:40','2025-05-08 19:58:48'),
(126,'App\\Models\\User',10,'mobile_token','13178d8e4a148102ccba552e0966c015b353b26e7d8e191f22d21a90594b9ab1','[\"*\"]','2025-05-08 20:00:25',NULL,'2025-05-08 20:00:17','2025-05-08 20:00:25'),
(127,'App\\Models\\User',10,'mobile_token','457815214f576843e62ac720b444f24f1ca48b421cf4ab75e9543d50feb3a0bf','[\"*\"]','2025-05-08 20:06:46',NULL,'2025-05-08 20:06:37','2025-05-08 20:06:46'),
(128,'App\\Models\\User',10,'mobile_token','4ab7d5a7cd6a02824e5d75c7a391dd369a2f3b81a4af4c8e7f3fcf1002cd9d74','[\"*\"]','2025-05-08 20:12:37',NULL,'2025-05-08 20:12:03','2025-05-08 20:12:37'),
(129,'App\\Models\\User',10,'mobile_token','19b7bfba5945307327576bbfb606324322c770646c1dbcda4a986ad83d799271','[\"*\"]','2025-05-08 20:37:12',NULL,'2025-05-08 20:17:26','2025-05-08 20:37:12'),
(130,'App\\Models\\User',10,'mobile_token','110e39446ad7511f0a08c424c49514252065daf521264ccf36b6991a46b40967','[\"*\"]','2025-05-08 21:03:41',NULL,'2025-05-08 20:38:35','2025-05-08 21:03:41'),
(131,'App\\Models\\User',10,'mobile_token','60feb39c579c5e65475bd4fecd56a4552c5e2db26e0a27287e72c50ebe54d9de','[\"*\"]','2025-05-09 04:05:29',NULL,'2025-05-09 04:05:24','2025-05-09 04:05:29'),
(132,'App\\Models\\User',10,'mobile_token','6873a557747921883bdb3c9850d6a1250c1fab6181859159650cbd741670f2ce','[\"*\"]','2025-05-09 04:06:51',NULL,'2025-05-09 04:06:45','2025-05-09 04:06:51'),
(133,'App\\Models\\User',10,'mobile_token','1dabcd31be5ce241f3ba91da35b294873b231a60c15d53e21718e30d76566815','[\"*\"]','2025-05-09 04:14:09',NULL,'2025-05-09 04:14:05','2025-05-09 04:14:09'),
(134,'App\\Models\\User',10,'mobile_token','38e3cefb8ab1af89009aae4e6c83bd6e9b76a61a061bf4119d349ca2c5d6643d','[\"*\"]','2025-05-09 05:20:57',NULL,'2025-05-09 05:20:50','2025-05-09 05:20:57'),
(135,'App\\Models\\User',10,'mobile_token','d8c26cc54425e70e14931474b893ff571940793a884daa031006935f9338876a','[\"*\"]','2025-05-09 05:28:21',NULL,'2025-05-09 05:28:16','2025-05-09 05:28:21'),
(136,'App\\Models\\User',10,'mobile_token','d0e3a09c681dd2eabc35fc6b63f35d16414cf41eb0118336b1e2119bc253cb99','[\"*\"]','2025-05-09 05:57:33',NULL,'2025-05-09 05:56:58','2025-05-09 05:57:33'),
(137,'App\\Models\\User',10,'mobile_token','9a7ce62b6098097282f2cd4ea17c0bb30dbf86345f0b6a7645b055ccff605968','[\"*\"]','2025-05-09 21:10:35',NULL,'2025-05-09 20:58:07','2025-05-09 21:10:35'),
(138,'App\\Models\\User',12,'mobile_token','7f3f24e3b5bf951d2f8d5ba630d3239e531db2b40a4cb43c6185034e1f041129','[\"*\"]','2025-05-11 10:33:58',NULL,'2025-05-11 10:33:52','2025-05-11 10:33:58'),
(139,'App\\Models\\User',12,'mobile_token','c63165ded4fa072f32a164845dffca0f8e29d3ec1cb092c9b2e6b4bfb5ed80f8','[\"*\"]','2025-05-12 09:39:07',NULL,'2025-05-12 09:38:12','2025-05-12 09:39:07'),
(140,'App\\Models\\User',12,'mobile_token','94d4d14c1f55b8c6fdf519eb32dbbd358a0f9832adcd5c6211e6e5ba0e1938b4','[\"*\"]','2025-05-12 09:54:31',NULL,'2025-05-12 09:52:26','2025-05-12 09:54:31'),
(141,'App\\Models\\User',13,'mobile_token','9f1cb781dc71cbd4607a7f0792b68b581d9e71c16b87ddf8c09f87c738275c86','[\"*\"]','2025-05-12 10:29:34',NULL,'2025-05-12 10:27:07','2025-05-12 10:29:34'),
(142,'App\\Models\\User',13,'mobile_token','601345b8d70530dcb22163de749ee9d8c61e2eb5d31ddd75bfdcd97a4e2f269c','[\"*\"]','2025-05-12 11:48:39',NULL,'2025-05-12 11:48:31','2025-05-12 11:48:39'),
(143,'App\\Models\\User',10,'mobile_token','1ecc13cef94ac671250c16aa8a97f16b7545a8a183e20c98916f1d802cfe3b53','[\"*\"]','2025-05-12 11:49:33',NULL,'2025-05-12 11:49:26','2025-05-12 11:49:33'),
(144,'App\\Models\\User',12,'mobile_token','e787bf22a9d5dd6731b94ffd01add266c0cd0bcbfc69d15c236f2478bafb47f9','[\"*\"]','2025-05-12 11:54:05',NULL,'2025-05-12 11:50:46','2025-05-12 11:54:05'),
(145,'App\\Models\\User',14,'mobile_token','81721e881398525e0a1c2ef67e1e702c11db82bbe91fd55fd16216ff416e64ac','[\"*\"]','2025-05-12 12:24:52',NULL,'2025-05-12 12:09:38','2025-05-12 12:24:52'),
(146,'App\\Models\\User',13,'mobile_token','c3a752cb032b9ab1899d18d3dd3bd071b3e12fa25a5230f20e24a213d87f2c26','[\"*\"]','2025-05-12 22:31:17',NULL,'2025-05-12 22:31:10','2025-05-12 22:31:17'),
(147,'App\\Models\\User',13,'mobile_token','02405974702e8dba9a54d647c4f3acb31f53a6712e03b26550e69ef6ce5eb551','[\"*\"]','2025-05-12 22:42:11',NULL,'2025-05-12 22:32:34','2025-05-12 22:42:11'),
(148,'App\\Models\\User',13,'mobile_token','ffef88814ded0456027e30e2553c7793951d2b2c70a55bd11d5dbb89c9a5cfef','[\"*\"]','2025-05-12 22:49:37',NULL,'2025-05-12 22:49:32','2025-05-12 22:49:37'),
(149,'App\\Models\\User',13,'mobile_token','4ce01cd8b7a27ec9d7b17e387aaf52ebb39c3b1c66b37d1e1a65cdfd507d9c3c','[\"*\"]','2025-05-12 23:04:30',NULL,'2025-05-12 23:01:06','2025-05-12 23:04:30'),
(150,'App\\Models\\User',13,'mobile_token','4f52d1e0e06445b9fa95262e3615295be412c8e9e86524d9b1eba8777338bed6','[\"*\"]','2025-05-12 23:11:25',NULL,'2025-05-12 23:09:39','2025-05-12 23:11:25'),
(151,'App\\Models\\User',13,'mobile_token','c1bd38fc7e059a09d6fee1254fb8d33e81b3eb6d21f23aa27c13af59b8104d04','[\"*\"]','2025-05-13 00:06:36',NULL,'2025-05-12 23:34:17','2025-05-13 00:06:36'),
(152,'App\\Models\\User',13,'mobile_token','7f4d5a61ca329ad284e3b839101003012d18e91a645af63785901fa8220ab72b','[\"*\"]','2025-05-13 00:49:36',NULL,'2025-05-13 00:49:30','2025-05-13 00:49:36'),
(153,'App\\Models\\User',13,'mobile_token','3a5407afbfb1e8986dae4b333e2497925480f6179f55c3229530d70f175598f7','[\"*\"]','2025-05-13 01:13:16',NULL,'2025-05-13 01:00:39','2025-05-13 01:13:16'),
(154,'App\\Models\\User',10,'mobile_token','1c3308ec9825228f153c64753dcceb6d96d1045516532253f85b6632a02fe0ec','[\"*\"]','2025-05-13 11:32:22',NULL,'2025-05-13 10:48:56','2025-05-13 11:32:22'),
(155,'App\\Models\\User',13,'mobile_token','34cab716bf9cddcc749d728e76bfc64767b70ddf124211d67e0ee31261740946','[\"*\"]','2025-05-29 09:10:35',NULL,'2025-05-13 11:33:21','2025-05-29 09:10:35'),
(156,'App\\Models\\User',13,'mobile_token','122f86e777dc5f698a7eb355fb29e85144ef38d18661e73071ea0e7eae6903b5','[\"*\"]','2025-05-13 11:47:08',NULL,'2025-05-13 11:47:01','2025-05-13 11:47:08'),
(157,'App\\Models\\User',13,'mobile_token','f9eb58d9025eec4c97aa421cfe5ebe9265b9963c91711dbfb492c123b5523075','[\"*\"]','2025-05-13 11:53:38',NULL,'2025-05-13 11:53:32','2025-05-13 11:53:38'),
(158,'App\\Models\\User',13,'mobile_token','95eacda9e1ecf8395ea28576c648913e16cd8beb5302e33ce6d0ce7dab530391','[\"*\"]','2025-05-13 11:56:37',NULL,'2025-05-13 11:56:32','2025-05-13 11:56:37'),
(159,'App\\Models\\User',13,'mobile_token','051231cf2ad942d46911f0320aa6bc04ac8e941c0024272b288e9ad4688b4b10','[\"*\"]','2025-05-13 11:59:40',NULL,'2025-05-13 11:59:35','2025-05-13 11:59:40'),
(160,'App\\Models\\User',13,'mobile_token','0ec60246d34b6f15db4420fef48d064ea026b55a83d11c4a3c12884d92ab8ae4','[\"*\"]','2025-05-13 12:18:17',NULL,'2025-05-13 12:18:12','2025-05-13 12:18:17'),
(161,'App\\Models\\User',13,'mobile_token','553f6d6917106eb788f3907530a7619c91539f5c37fce3d7e12df06cb5b1b46a','[\"*\"]','2025-05-13 12:33:25',NULL,'2025-05-13 12:33:16','2025-05-13 12:33:25'),
(162,'App\\Models\\User',13,'mobile_token','c7253175e5e7c32fb480528d5251e193031a263bfb40f0cb3d2aac4f23c1d663','[\"*\"]','2025-05-13 21:16:58',NULL,'2025-05-13 21:16:50','2025-05-13 21:16:58'),
(163,'App\\Models\\User',13,'mobile_token','5cbf57a12ecdced343ce18012b0de188074a32af1a20830fd6be0647f7a804bd','[\"*\"]','2025-05-13 21:22:51',NULL,'2025-05-13 21:22:38','2025-05-13 21:22:51'),
(164,'App\\Models\\User',13,'mobile_token','a6712d5e9ae7ddfb8ee0cb3a89472f6f076e58079422e6603d2af6b7e8c5049d','[\"*\"]','2025-05-13 21:29:54',NULL,'2025-05-13 21:29:47','2025-05-13 21:29:54'),
(165,'App\\Models\\User',13,'mobile_token','089bdf5d5b3153a7dd8dc08f2d01feb6d852f1b7719944c5e1c3ef29cd803869','[\"*\"]','2025-05-13 21:46:38',NULL,'2025-05-13 21:46:30','2025-05-13 21:46:38'),
(166,'App\\Models\\User',13,'mobile_token','178557b3398228b14742110acfd99afac5311a20067762d46bd21a84bdabce1f','[\"*\"]','2025-05-13 22:19:06',NULL,'2025-05-13 22:18:57','2025-05-13 22:19:06'),
(167,'App\\Models\\User',13,'mobile_token','24df699215616ee223cfd41ffa6ef3f393a93ae010026453bbc9a2f571daa9f8','[\"*\"]','2025-05-13 22:51:04',NULL,'2025-05-13 22:42:14','2025-05-13 22:51:04'),
(168,'App\\Models\\User',12,'mobile_token','31294efed55be52b5f7deaf7c0f17fe1399d0e6d7252bbca18d27c65848d4f61','[\"*\"]','2025-05-13 22:51:50',NULL,'2025-05-13 22:51:32','2025-05-13 22:51:50'),
(169,'App\\Models\\User',12,'mobile_token','eaf8528070cd947f9e68a1613c7b5138e95f8fbb83fb7f6f5270ca21c28c5549','[\"*\"]','2025-05-13 22:54:42',NULL,'2025-05-13 22:53:42','2025-05-13 22:54:42'),
(170,'App\\Models\\User',12,'mobile_token','b2ade78e869554ce29e398d9a41cacc5a12bcf3db4258ac8794eb32c956e11d1','[\"*\"]','2025-05-13 23:07:28',NULL,'2025-05-13 23:07:11','2025-05-13 23:07:28'),
(171,'App\\Models\\User',12,'mobile_token','c2da5a022cd3b565dc99413de4fb963cb2bca3e6deb38135a2edba048e582c83','[\"*\"]','2025-05-14 09:14:13',NULL,'2025-05-14 09:09:17','2025-05-14 09:14:13'),
(172,'App\\Models\\User',12,'mobile_token','ca20e261e40b20d1d0961a78df7d68eb59db86c4b519b541ccc5fe9ec2645d1f','[\"*\"]','2025-05-14 11:41:55',NULL,'2025-05-14 11:35:54','2025-05-14 11:41:55'),
(173,'App\\Models\\User',12,'mobile_token','e7bb40bd0b306505a6bf71b0a5fc008225b1215ebd0bc16a79fd0170dc74e609','[\"*\"]','2025-05-14 12:25:17',NULL,'2025-05-14 12:25:15','2025-05-14 12:25:17'),
(174,'App\\Models\\User',12,'mobile_token','db86d36322b485f8e7fb59ff6b26ac1edd9fe52d5a784f3882dc148213df0c0b','[\"*\"]','2025-05-14 20:50:43',NULL,'2025-05-14 20:47:12','2025-05-14 20:50:43'),
(175,'App\\Models\\User',12,'mobile_token','68fa50177d1e983c99fd895c87e3c3412c480ee0989fd8a0e8433c33a97f7e2e','[\"*\"]','2025-05-14 21:34:57',NULL,'2025-05-14 21:34:45','2025-05-14 21:34:57'),
(176,'App\\Models\\User',12,'mobile_token','a42f09226d4206ca2b633277e6bbd6125ab8bb1d5f3356178249aa80e924cd9b','[\"*\"]','2025-05-14 22:14:15',NULL,'2025-05-14 22:14:06','2025-05-14 22:14:15'),
(177,'App\\Models\\User',12,'mobile_token','82d3428521fbe4821df2fdd320675d3e2c8e00b1eceea2e8807f046d56a5e2f4','[\"*\"]',NULL,NULL,'2025-05-14 22:29:33','2025-05-14 22:29:33'),
(178,'App\\Models\\User',12,'mobile_token','8a28357932a21f8d8c2e8ad04cd7071c232356be33b2114650d34f7f638f370a','[\"*\"]','2025-05-14 22:32:44',NULL,'2025-05-14 22:32:41','2025-05-14 22:32:44'),
(179,'App\\Models\\User',12,'mobile_token','37d78568ff5608a657fb1930aad939f3dad5e28e0d509ae1f252bf0f15f59778','[\"*\"]','2025-05-14 22:34:15',NULL,'2025-05-14 22:34:14','2025-05-14 22:34:15'),
(180,'App\\Models\\User',12,'mobile_token','4f059e8c327c2dbc02ffc64f5671ead1c444c6f044da2edc363cf8e9cb62ffeb','[\"*\"]','2025-05-14 22:43:43',NULL,'2025-05-14 22:36:27','2025-05-14 22:43:43'),
(181,'App\\Models\\User',12,'mobile_token','5700c4205df356eca7f2d590f015ee4fe430ea5fedc551e830ee0cf6b2c9addc','[\"*\"]','2025-05-14 22:58:17',NULL,'2025-05-14 22:58:07','2025-05-14 22:58:17'),
(182,'App\\Models\\User',12,'mobile_token','dc72756b4e568bd60661ca288c83f74ecab764f45cb6138357e2152828248e7a','[\"*\"]','2025-05-14 23:03:35',NULL,'2025-05-14 23:03:25','2025-05-14 23:03:35'),
(183,'App\\Models\\User',12,'mobile_token','7441fb071eb40aa085fe5af71e61c342e2237036adf8f3218d4835b1299054b2','[\"*\"]','2025-05-14 23:26:04',NULL,'2025-05-14 23:05:00','2025-05-14 23:26:04'),
(184,'App\\Models\\User',12,'mobile_token','315fc907f1165d42234d4bfdd2770a370f1e7e4db28988e070f4211d50621a74','[\"*\"]','2025-05-14 23:27:48',NULL,'2025-05-14 23:27:36','2025-05-14 23:27:48'),
(185,'App\\Models\\User',12,'mobile_token','4c1dba763560fd852615afc613b7f9ade5d31c25791559d9114284a9b29dea57','[\"*\"]','2025-05-14 23:34:42',NULL,'2025-05-14 23:34:36','2025-05-14 23:34:42'),
(186,'App\\Models\\User',12,'mobile_token','2b30a918aeecf6624c19417dd4bcfea53d1da1e645e75717a016128fd50a7707','[\"*\"]','2025-05-15 00:21:31',NULL,'2025-05-15 00:21:24','2025-05-15 00:21:31'),
(187,'App\\Models\\User',12,'mobile_token','5c0c6e66ecaadd21830623804f7a8217a74228411242c25d21eda7bdc35c2152','[\"*\"]','2025-05-15 00:31:12',NULL,'2025-05-15 00:31:04','2025-05-15 00:31:12'),
(188,'App\\Models\\User',12,'mobile_token','3c0100d6a71a3f78a8ac8a98f72b17fcc157ac332ff1cebb75e29a0ae486949d','[\"*\"]','2025-05-15 00:38:19',NULL,'2025-05-15 00:37:37','2025-05-15 00:38:19'),
(189,'App\\Models\\User',12,'mobile_token','fba33003945e253351b3f0fa019708b62adbb6ae01ed5c4afa44fc4b4f5966c1','[\"*\"]',NULL,NULL,'2025-05-15 12:48:15','2025-05-15 12:48:15'),
(190,'App\\Models\\User',12,'mobile_token','65d5c1741864f42e3865e13af00739bfc769a24b6f9242bfc463ea8b2e41f795','[\"*\"]','2025-05-15 12:48:55',NULL,'2025-05-15 12:48:44','2025-05-15 12:48:55'),
(191,'App\\Models\\User',12,'mobile_token','718901c03ab730f043b54efcb02d5ab0b2b2f51d3d2814be14b0a8274ade4fc1','[\"*\"]','2025-05-15 12:50:43',NULL,'2025-05-15 12:50:32','2025-05-15 12:50:43'),
(192,'App\\Models\\User',12,'mobile_token','a4169572df9a3fecc6a598344be44931237393b5c055c800ab0d0f6a39e37392','[\"*\"]','2025-05-15 12:52:30',NULL,'2025-05-15 12:52:18','2025-05-15 12:52:30'),
(193,'App\\Models\\User',12,'mobile_token','b10029f1b451ff227064ca46222774b21ab3eb454b05a9f6416ca41ff67a4f03','[\"*\"]','2025-05-15 13:03:37',NULL,'2025-05-15 12:56:18','2025-05-15 13:03:37'),
(194,'App\\Models\\User',12,'mobile_token','031c7b6aa909315541b26dd13d283927515dabccb8f9ebd2b487cacb362466dc','[\"*\"]','2025-05-15 22:28:41',NULL,'2025-05-15 22:28:30','2025-05-15 22:28:41'),
(195,'App\\Models\\User',12,'mobile_token','e0b1a621179a0942537b9fd0909c0e0758ed245182415a52633792cc8122e8ec','[\"*\"]','2025-05-16 21:51:14',NULL,'2025-05-16 21:51:11','2025-05-16 21:51:14'),
(196,'App\\Models\\User',12,'mobile_token','cc31d59a5cdfd322db9758bbb2ed9104a49ece87fb947a600098157616122725','[\"*\"]','2025-05-16 22:43:23',NULL,'2025-05-16 21:59:43','2025-05-16 22:43:23'),
(197,'App\\Models\\User',12,'mobile_token','6a438ad9da1257bb30fe59877ac1e3af08317dd2c0927cce07db7a0851f86a65','[\"*\"]','2025-05-29 09:49:05',NULL,'2025-05-29 09:48:56','2025-05-29 09:49:05'),
(198,'App\\Models\\User',12,'mobile_token','120aee30714df8c006bda6a8406b7a651a3456260e287b005c2461f716e80553','[\"*\"]','2025-05-29 10:04:20',NULL,'2025-05-29 09:52:31','2025-05-29 10:04:20'),
(199,'App\\Models\\User',12,'mobile_token','37b654518c82007e1c40616b0c4342a3bdb139a937e3abed0adb29c473312862','[\"*\"]','2025-05-29 11:30:12',NULL,'2025-05-29 11:29:51','2025-05-29 11:30:12'),
(200,'App\\Models\\User',12,'mobile_token','a1da0008c1809e60eecf863910d37d534edff15ef5171f1a5c3ce7c50ab07e0e','[\"*\"]','2025-05-29 11:51:57',NULL,'2025-05-29 11:51:40','2025-05-29 11:51:57'),
(201,'App\\Models\\User',12,'mobile_token','5dfa9027c77a84237281637e8ba358f859482a9cc9c04e99e1b02d0b7c922f5d','[\"*\"]','2025-05-29 11:55:30',NULL,'2025-05-29 11:55:03','2025-05-29 11:55:30'),
(202,'App\\Models\\User',12,'mobile_token','53690a25b4a1f33c7a41ea5377883dfa02c3e8818d8960981e4dfecf8a7cd61d','[\"*\"]','2025-05-29 11:59:04',NULL,'2025-05-29 11:58:49','2025-05-29 11:59:04'),
(203,'App\\Models\\User',12,'mobile_token','69e4e7012ce154a9f6de1723ec71497c250830ab55446d8bac8385dd9749a852','[\"*\"]','2025-06-01 16:10:30',NULL,'2025-06-01 16:10:18','2025-06-01 16:10:30'),
(204,'App\\Models\\User',12,'mobile_token','43f985069c4ae07b81ddd3bc5c6b2c4c50cd0edcaa949113f52c02d9b1746eb1','[\"*\"]','2025-06-01 16:33:25',NULL,'2025-06-01 16:33:13','2025-06-01 16:33:25'),
(205,'App\\Models\\User',12,'mobile_token','159ad12114de9032aeb574016fa71e0290df24c390932ae8fa56d9a4d912d869','[\"*\"]','2025-06-20 13:44:18',NULL,'2025-06-20 13:43:52','2025-06-20 13:44:18'),
(206,'App\\Models\\User',12,'mobile_token','78dd2e8853b68cdbfb94ddced4ccb185148ee3909909bf2c505cf394446bf0b2','[\"*\"]','2025-06-20 14:30:21',NULL,'2025-06-20 14:14:58','2025-06-20 14:30:21'),
(207,'App\\Models\\User',12,'mobile_token','8a7c8c802f330b4bf256883de47bc9a0a41aecea27dd6376e1aa8d47571026bd','[\"*\"]','2025-06-20 14:36:31',NULL,'2025-06-20 14:34:49','2025-06-20 14:36:31'),
(208,'App\\Models\\User',12,'mobile_token','651e2a8168be212ad79d39ce3ce213840f682dc3882886ed868db7fe27bfe773','[\"*\"]','2025-06-20 15:30:11',NULL,'2025-06-20 15:23:47','2025-06-20 15:30:11'),
(209,'App\\Models\\User',12,'mobile_token','c31ba76f4a07ac7eb3dee628db6e0cd1d60fade988d1e031f2174282c90e8592','[\"*\"]','2025-06-20 15:42:35',NULL,'2025-06-20 15:42:15','2025-06-20 15:42:35'),
(210,'App\\Models\\User',12,'mobile_token','3fb7b25295788bc45f7052d8510a7de1727789f302991ab382c84fe7b019e545','[\"*\"]','2025-06-20 16:32:02',NULL,'2025-06-20 16:31:45','2025-06-20 16:32:02'),
(211,'App\\Models\\User',12,'mobile_token','20cf31784231ad13487740a936771e4dec6848b9777295c4c4dd7e55b11859ae','[\"*\"]','2025-06-20 16:35:17',NULL,'2025-06-20 16:35:14','2025-06-20 16:35:17'),
(212,'App\\Models\\User',12,'mobile_token','8a14bf522981847bad3aca61ee90189f42df35a3bb8b350d19f784e5f1bc7e65','[\"*\"]','2025-06-20 16:55:21',NULL,'2025-06-20 16:50:18','2025-06-20 16:55:21'),
(213,'App\\Models\\User',12,'mobile_token','74cd50692e1d16ce5356f27eb7e9db5e840e40be5967d1827c432d407cea5125','[\"*\"]','2025-06-21 10:42:31',NULL,'2025-06-21 10:29:09','2025-06-21 10:42:31'),
(214,'App\\Models\\User',12,'mobile_token','b0d0e270811c0cc063fc6469320b98269bd0a22dfe43469eb367de16f998c248','[\"*\"]','2025-06-21 10:52:20',NULL,'2025-06-21 10:51:12','2025-06-21 10:52:20'),
(215,'App\\Models\\User',12,'mobile_token','d73c23752a6b621415e6dd9ecf16091fd80206da44822ee5b985637009383359','[\"*\"]','2025-06-21 12:14:49',NULL,'2025-06-21 10:53:04','2025-06-21 12:14:49'),
(216,'App\\Models\\User',12,'mobile_token','440a931744744b19c992d2651f42a4ef883d97ec39b4af553f74cf0ccb687351','[\"*\"]','2025-06-21 12:17:40',NULL,'2025-06-21 12:17:35','2025-06-21 12:17:40'),
(217,'App\\Models\\User',12,'mobile_token','60fee1ea71c819c747eb2905bebe96909554b6ebc73c39b3803e43050ea0e12f','[\"*\"]','2025-06-21 12:20:33',NULL,'2025-06-21 12:20:19','2025-06-21 12:20:33'),
(218,'App\\Models\\User',12,'mobile_token','a76bfc403f6174731628694c1157fad7668774a23def1b5297eee615dcc1da6e','[\"*\"]','2025-06-21 12:33:17',NULL,'2025-06-21 12:29:31','2025-06-21 12:33:17'),
(219,'App\\Models\\User',12,'mobile_token','fd14d00cd17c318f65c0926d6bb0e3a8089c28e0d8d112b665aaa05180b024a3','[\"*\"]','2025-06-21 19:09:18',NULL,'2025-06-21 18:49:20','2025-06-21 19:09:18'),
(220,'App\\Models\\User',13,'mobile_token','9aad6aa757f70caef54ee07672f051115144478403a512e0f33b2e9f30c4ba00','[\"*\"]','2025-06-21 20:18:19',NULL,'2025-06-21 20:18:15','2025-06-21 20:18:19'),
(221,'App\\Models\\User',12,'mobile_token','614b88a378e5c138cf3fe2d451c67930434c7ec877c4eb82e8f7eeb2356ebf0c','[\"*\"]','2025-06-21 20:38:12',NULL,'2025-06-21 20:37:51','2025-06-21 20:38:12'),
(222,'App\\Models\\User',13,'mobile_token','b12922ef6945dd66a894a4492ae34f4c05b0aebaf723967fd20cf5458e83f501','[\"*\"]','2025-06-21 20:38:59',NULL,'2025-06-21 20:38:53','2025-06-21 20:38:59'),
(223,'App\\Models\\User',13,'mobile_token','180a9a71ab71c62d73814944e57f2144341b5520327099c27334bbf22f4efddb','[\"*\"]','2025-06-21 20:40:11',NULL,'2025-06-21 20:40:05','2025-06-21 20:40:11'),
(224,'App\\Models\\User',12,'mobile_token','33c1f979638ff3302a35b1f5dcc21ce018df3499248a323d6d26ee6279bab459','[\"*\"]','2025-06-21 21:34:53',NULL,'2025-06-21 21:34:38','2025-06-21 21:34:53'),
(225,'App\\Models\\User',13,'mobile_token','5b452f0d7df6d69a69b5da3491af113453ef8304eb7f4002cdba32ae1ee890f3','[\"*\"]','2025-06-21 22:06:31',NULL,'2025-06-21 21:36:35','2025-06-21 22:06:31'),
(226,'App\\Models\\User',12,'mobile_token','26f39a9854d43bb5c00db867289d259e6672ee4edd3656af54f0145ab3b93a3f','[\"*\"]','2025-06-21 22:08:04',NULL,'2025-06-21 22:07:06','2025-06-21 22:08:04'),
(227,'App\\Models\\User',12,'mobile_token','2f7cf87cd0c9b57a68171d23a5d80630554a84394e211ce589ac834a6eacf4a1','[\"*\"]','2025-06-21 22:19:32',NULL,'2025-06-21 22:18:18','2025-06-21 22:19:32'),
(228,'App\\Models\\User',12,'mobile_token','f913a3221f594b71c4bbcdb32cbd300a53a4819d7f2bd04cfabc5f7b85d829bf','[\"*\"]','2025-06-21 22:27:02',NULL,'2025-06-21 22:22:58','2025-06-21 22:27:02'),
(229,'App\\Models\\User',13,'mobile_token','83325d279c7676326638024a6d71070bc86b38b72df976772516c7ce3e32c4c3','[\"*\"]','2025-06-21 22:41:42',NULL,'2025-06-21 22:27:27','2025-06-21 22:41:42'),
(230,'App\\Models\\User',13,'mobile_token','4e3cd8c8f82f8054e638d77c83f67b036112cd993be7d85e3e819e62c20226b9','[\"*\"]','2025-06-21 22:44:08',NULL,'2025-06-21 22:44:02','2025-06-21 22:44:08'),
(231,'App\\Models\\User',13,'mobile_token','65e519b4d64d0ac78c49ce9287d1faec1df65169139ed9e2049017e0ffd3e45f','[\"*\"]','2025-06-21 22:52:35',NULL,'2025-06-21 22:52:32','2025-06-21 22:52:35'),
(232,'App\\Models\\User',13,'mobile_token','19d62896378817886417eeb89e6ffc2bcf1a8565e4cf32fedce09bd013ecbe48','[\"*\"]','2025-06-21 23:14:21',NULL,'2025-06-21 23:06:21','2025-06-21 23:14:21'),
(233,'App\\Models\\User',13,'mobile_token','7ad6dc00f7e9d3be8de53d6ece4e9cb82d8d4a89209bd074d91eb7d05c3410a6','[\"*\"]','2025-06-22 16:06:24',NULL,'2025-06-22 16:05:56','2025-06-22 16:06:24'),
(234,'App\\Models\\User',13,'mobile_token','25911b6a8dfa1f8b3df2fbe72a34b51945561a645bff8748d32ce3efc785dfd3','[\"*\"]','2025-06-22 16:51:32',NULL,'2025-06-22 16:51:25','2025-06-22 16:51:32'),
(235,'App\\Models\\User',13,'mobile_token','54ad4701b075692348cde31d39d1cfd2bb2d5bc4226a4a3f315b57853f2a3241','[\"*\"]','2025-06-22 17:12:30',NULL,'2025-06-22 16:55:41','2025-06-22 17:12:30'),
(236,'App\\Models\\User',13,'mobile_token','f2a9102b43147e4a7441b00e4a44a91aeebce1a362add836caf155618d95ff40','[\"*\"]','2025-06-22 17:13:18',NULL,'2025-06-22 17:13:12','2025-06-22 17:13:18'),
(237,'App\\Models\\User',13,'mobile_token','8e292a735e21e2dbacbbd66833edd6818e1dc582b233b9ff406e5b89b6732d96','[\"*\"]','2025-06-22 17:14:52',NULL,'2025-06-22 17:14:47','2025-06-22 17:14:52'),
(238,'App\\Models\\User',13,'mobile_token','9be877a37588dee03a89444ba27a3a10fae3634107dc4212bd6263695b2dd7b9','[\"*\"]','2025-06-22 17:19:32',NULL,'2025-06-22 17:19:26','2025-06-22 17:19:32'),
(239,'App\\Models\\User',12,'mobile_token','4a68032ee18033c9a9f75d66cf8226d1eddf51ba59f43337938f7883742d1c6e','[\"*\"]','2025-06-22 18:02:14',NULL,'2025-06-22 18:01:33','2025-06-22 18:02:14'),
(240,'App\\Models\\User',13,'mobile_token','c3e37d1436dca6dbc1bc26464ba801af7e11cfe91a3b94e179a028b2de902103','[\"*\"]','2025-06-22 18:46:42',NULL,'2025-06-22 18:03:24','2025-06-22 18:46:42'),
(241,'App\\Models\\User',13,'mobile_token','d9e8944250b4050e3e8332868c65c8b2577bd5a9462fd945f6442259ef52c158','[\"*\"]',NULL,NULL,'2025-06-22 19:54:52','2025-06-22 19:54:52'),
(242,'App\\Models\\User',13,'mobile_token','92c7efe0c69a080d3640b134799fca4035d8a80f30ed5d6e5bcc87b5d155b867','[\"*\"]','2025-06-22 20:17:37',NULL,'2025-06-22 20:13:17','2025-06-22 20:17:37'),
(243,'App\\Models\\User',12,'mobile_token','402ab290248b691988d94a73213fff38fd3192da98df7dcf439a256472a54f71','[\"*\"]','2025-06-22 20:17:56',NULL,'2025-06-22 20:17:53','2025-06-22 20:17:56'),
(244,'App\\Models\\User',12,'mobile_token','3a5ae482b7252a775a5bbc6e71dcb51b781d02bea6c800a205c351544a7ada40','[\"*\"]','2025-06-23 18:57:28',NULL,'2025-06-23 18:57:22','2025-06-23 18:57:28'),
(245,'App\\Models\\User',12,'mobile_token','ca4c4c3253b35cfec6141cac34dbd8902bbb9956f79aa50f73a16cbea1e6aca3','[\"*\"]','2025-06-23 20:28:46',NULL,'2025-06-23 20:22:25','2025-06-23 20:28:46'),
(246,'App\\Models\\User',13,'mobile_token','104c17de437d38eda449d4f0ac7c3e25746fff5cfac91c84f1d5fdead88f22a1','[\"*\"]','2025-06-23 20:32:35',NULL,'2025-06-23 20:29:04','2025-06-23 20:32:35'),
(247,'App\\Models\\User',13,'mobile_token','47b68caf83eaf63f31d7ca3083e64ec7bde8edaf4720d89849a25878c0478074','[\"*\"]','2025-06-23 20:49:53',NULL,'2025-06-23 20:48:55','2025-06-23 20:49:53'),
(248,'App\\Models\\User',13,'mobile_token','9bdb2affe7a621bd417caf670a51f9390ede44e6fa2c5836b2095e5112503518','[\"*\"]','2025-06-23 20:55:07',NULL,'2025-06-23 20:54:39','2025-06-23 20:55:07'),
(249,'App\\Models\\User',13,'mobile_token','7d937df39f87630f74b4fdebfdaf8e3ff3fde29fd8452eaefbcc0c051da968d8','[\"*\"]','2025-06-23 21:03:22',NULL,'2025-06-23 21:00:07','2025-06-23 21:03:22'),
(250,'App\\Models\\User',13,'mobile_token','3ba8cc1e7a1ce34705770611ef8846511031969ca39d935b0c69def59a2985dd','[\"*\"]','2025-06-23 21:19:04',NULL,'2025-06-23 21:06:35','2025-06-23 21:19:04'),
(251,'App\\Models\\User',13,'mobile_token','b4bc59c773af4159061c6b4da1d5ee1c4826da1b6f2495c527b1facf2fedb694','[\"*\"]','2025-06-23 21:28:39',NULL,'2025-06-23 21:24:39','2025-06-23 21:28:39'),
(252,'App\\Models\\User',13,'mobile_token','038d31149831b8ec9d1ae9ae72d8832b8bf37e96b4788e01d3048198f2e66f9b','[\"*\"]','2025-06-23 21:37:21',NULL,'2025-06-23 21:35:47','2025-06-23 21:37:21'),
(253,'App\\Models\\User',13,'mobile_token','e37ddb064098c2b0b4ed88207718f37df976a3f4e39f437024c1a525ec3e993f','[\"*\"]','2025-06-23 21:44:40',NULL,'2025-06-23 21:44:35','2025-06-23 21:44:40'),
(254,'App\\Models\\User',13,'mobile_token','05c43bf310eb531bd60137c492b7e39673d195b6698dd249ddb6c4f049043ee7','[\"*\"]','2025-06-23 21:50:19',NULL,'2025-06-23 21:46:41','2025-06-23 21:50:19'),
(255,'App\\Models\\User',13,'mobile_token','787420e09a82e9792dde8f9a77b699f7b827d123bc4a25ec508cdf780c790b8e','[\"*\"]','2025-06-23 22:45:07',NULL,'2025-06-23 22:23:14','2025-06-23 22:45:07'),
(256,'App\\Models\\User',13,'mobile_token','d86fa0aef068fbd9a486154820ef844e653178db6768841eba44465012c483d1','[\"*\"]','2025-06-23 23:08:44',NULL,'2025-06-23 23:08:13','2025-06-23 23:08:44'),
(257,'App\\Models\\User',13,'mobile_token','37dd18b8bd9d44d9f395caad7b35805547312bb37da15219eb1ab4f17c72a54b','[\"*\"]','2025-06-23 23:10:56',NULL,'2025-06-23 23:10:46','2025-06-23 23:10:56'),
(258,'App\\Models\\User',13,'mobile_token','f3be5d54995e050ebcd1acf0f64d03f97af56b040d4283a99291428fb36ee57d','[\"*\"]','2025-06-23 23:14:06',NULL,'2025-06-23 23:13:50','2025-06-23 23:14:06'),
(259,'App\\Models\\User',13,'mobile_token','4f57a4a62b394838c548a501fa98ba5d5f7ad33dcf92f7015e7880a5af2f8b8f','[\"*\"]','2025-06-23 23:21:03',NULL,'2025-06-23 23:20:53','2025-06-23 23:21:03'),
(260,'App\\Models\\User',13,'mobile_token','3b69926c9b7005ef191f47060297fb06be84f1af6340962f311271637ec3b3de','[\"*\"]','2025-06-23 23:28:25',NULL,'2025-06-23 23:25:33','2025-06-23 23:28:25'),
(261,'App\\Models\\User',12,'mobile_token','88b1d198af6a73ac6d048ad5a5449b55f245f5c4c9d74314564938104b9942b6','[\"*\"]','2025-06-23 23:48:24',NULL,'2025-06-23 23:28:46','2025-06-23 23:48:24'),
(262,'App\\Models\\User',12,'mobile_token','c354ee3b9087a755665f748a03fd0487e05eeef5edcc658e91dcd79fe2b844a1','[\"*\"]','2025-06-23 23:54:36',NULL,'2025-06-23 23:50:47','2025-06-23 23:54:36'),
(263,'App\\Models\\User',12,'mobile_token','33f3823e44b82aa0ce93e5c3ecab10c1d09f530a27d4667f743f06021a1fe064','[\"*\"]','2025-06-23 23:59:09',NULL,'2025-06-23 23:58:30','2025-06-23 23:59:09'),
(264,'App\\Models\\User',12,'mobile_token','7fc1674e65b3eeecd1b615cfa361fcbaba2869d4155a0f7c88d474dc95902fb1','[\"*\"]','2025-06-24 00:10:44',NULL,'2025-06-24 00:10:38','2025-06-24 00:10:44'),
(265,'App\\Models\\User',12,'mobile_token','a2115ae63077eb2c18860a40fdec732df2f95d86f21baf27c65c40351e66b512','[\"*\"]','2025-06-24 00:11:40',NULL,'2025-06-24 00:11:36','2025-06-24 00:11:40'),
(266,'App\\Models\\User',12,'mobile_token','9d689100cf43edca8ac2eea646cce20fbfc10a32e9189cee429bc45676d38a3d','[\"*\"]','2025-06-24 00:19:23',NULL,'2025-06-24 00:19:20','2025-06-24 00:19:23'),
(267,'App\\Models\\User',12,'mobile_token','7059ecb4354fb0b3cb684b1571c64b62019cf0fea2d77d3844d3ef9c36b1c798','[\"*\"]','2025-06-24 00:23:58',NULL,'2025-06-24 00:23:53','2025-06-24 00:23:58'),
(268,'App\\Models\\User',12,'mobile_token','beb9c82a9f1e7e1943f293ea8a1a2d2ce7271c54654f182f223f641fc89c7d90','[\"*\"]','2025-06-24 00:32:09',NULL,'2025-06-24 00:31:53','2025-06-24 00:32:09');
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `posts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `visibility` varchar(255) NOT NULL DEFAULT 'Public',
  `topic_name` varchar(255) DEFAULT NULL,
  `content` text DEFAULT NULL,
  `image_path` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `posts_user_id_foreign` (`user_id`),
  CONSTRAINT `posts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES
(2,10,'Public','post1','my first post','posts/uvKFGhIVQ6CeQsdRDCwAsOn7qayGFNviveXBzk0p.png','2025-05-07 23:26:38','2025-05-07 23:26:38'),
(3,10,'Public','post2','description post 2','posts/PEqikJPAtwKpaJGK4PgrtrMESWCbbjrW8taDOqbv.jpg','2025-05-08 00:15:48','2025-05-08 00:15:48'),
(4,10,'Public','post 3','describ of post 3','posts/4qr7yAO5tw0N9yPhi7XULKY94DpckNxVNLDOdBeV.jpg','2025-05-08 00:19:39','2025-05-08 00:19:39'),
(5,10,'Public','post4','describ post 4','posts/UHyT2aOucLIyoVhYQdb9Y93CKJ5f2L4Pkoln6xJ2.png','2025-05-08 00:21:19','2025-05-08 00:21:19'),
(6,10,'Private','post 5','describ post 5','posts/QTjvB9W9ioEn7mmMjncIeSRNiaJXbL3WDpQyTC51.png','2025-05-08 00:23:18','2025-05-08 00:23:18'),
(7,11,'Public','Post Name','contenu du post','posts/w4LKhBFCplQ8OI5EHixTJ2wTJR4G8qx5xzLdh71q.png','2025-05-08 01:33:46','2025-05-08 01:33:46');
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `services`
--

DROP TABLE IF EXISTS `services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `services` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `service_name` varchar(255) NOT NULL,
  `category` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `duration` varchar(255) DEFAULT NULL,
  `price` decimal(8,2) DEFAULT NULL,
  `start_hour` time DEFAULT NULL,
  `end_hour` time DEFAULT NULL,
  `training_option` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `services_user_id_foreign` (`user_id`),
  CONSTRAINT `services_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services`
--

LOCK TABLES `services` WRITE;
/*!40000 ALTER TABLE `services` DISABLE KEYS */;
INSERT INTO `services` VALUES
(70,13,'Name service','Musculation','description service','2025-06-23 21:17:59','2025-06-23 21:17:59',NULL,NULL,NULL,NULL,NULL,NULL),
(71,13,'service test','Musculation','describ service','2025-06-23 21:25:54','2025-06-23 21:25:54',NULL,NULL,NULL,NULL,NULL,NULL),
(72,13,'test','Fitness','description','2025-06-23 21:36:13','2025-06-23 21:36:13',NULL,NULL,NULL,NULL,NULL,NULL),
(73,13,'Service Test','CrossFit','descrp','2025-06-23 21:47:20','2025-06-23 21:47:20',NULL,NULL,NULL,NULL,NULL,NULL),
(74,13,'Service Name Test','Pilates','description','2025-06-23 22:23:59','2025-06-23 22:23:59',NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `role` enum('sporty','coach') DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `latitude` decimal(10,7) DEFAULT NULL,
  `longitude` decimal(10,7) DEFAULT NULL,
  `workspace_media` varchar(255) DEFAULT NULL,
  `workspace_video` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `profile_picture` varchar(255) DEFAULT NULL,
  `bio` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES
(10,'User Name','user@gmail.com',NULL,'$2y$12$gW4BwF.OCFB6ixpiofQogOX/2dYnzU/4BE0ekPcR20k3l.QyairY2',NULL,'2025-05-07 23:22:32','2025-05-08 17:21:32','coach','Location','Paris',33.5992283,-7.5216280,'workspace_uploads/images/MCSbLOy9qiyWTHPR3GKtiSTSU8oiGvE5CcTus3iC.jpg','workspace_uploads/videos/P9YCnnKWxy6I57IVKf0UyO07AOq7QtzX0HYAPZH3.mov',NULL,'/storage/profile_pictures/giIKChxGmCZYZpf07OnilcjALIaB4WSV8KQyvtP6.jpg','My bio is here'),
(11,'Test','test@gmail.com',NULL,'$2y$12$kIewbkH8yCFliI/nSqPfruOjndukNBgUBk9YJKIzFGRb86c5990ge',NULL,'2025-05-08 01:30:08','2025-05-08 01:32:07','coach','Paris','Erreur lors de la récupération de l’adresse',33.5992254,-7.5216165,'workspace_uploads/images/iTBuzI09lqXFRwxJrEIlkqqcYVPF3iVyWsXk7kS1.png','workspace_uploads/videos/swX7XYdyhXvGiwImsKup0bqXhWliWrWhjgasWvZp.mov',NULL,'profiles/rfmJG0mo8oXHV2fBhDRVSCoGl1QGJCMWGxlLv1Lg.png','My bio'),
(12,'sporty','sporty@gmail.com',NULL,'$2y$12$ki8mph6TpQb.5nQTYsYH5.xP3c7TB7zIgscCnkkUJiJkGjtXCF8oq',NULL,'2025-05-11 10:32:55','2025-05-11 10:33:58','sporty',NULL,'sport',NULL,NULL,NULL,NULL,NULL,'profiles/PKvdbpXKjZTIrt2swB3liGaJ67Sbykt8EbOS6cqb.jpg','im\'a a sporty'),
(13,'coach','coach@gmail.com',NULL,'$2y$12$tbdWSF/EvjuKjsY.o6MS9uM5cMLuhMFX0fBOK5mPYfxdtsMuLlnCS',NULL,'2025-05-12 10:25:59','2025-06-23 22:24:14','coach','Addoha','Erreur lors de la récupération de l’adresse',33.5991933,-7.5216528,'workspace_uploads/images/JiCNxSYnAC56lb4ZTFn4t43qCYZkO874ma0nRj1p.png','workspace_uploads/videos/F3uzCoAkF2kr7qcZawpYGMpG2fFJepxb2iWapuFg.mov',NULL,'profiles/1mVArfluyBmwfHFhJd03awnMlBviD9owjn4OuwFB.jpg','I\'m a coach'),
(14,'test1','test1@gmail.com',NULL,'$2y$12$QUjoSDG.gpTRn5gn0JWKvOVzD/msAuALcsDUd1Fu73MoGCuPm9scK',NULL,'2025-05-12 12:08:50','2025-05-12 12:24:52','coach','location_test','Erreur lors de la récupération de l’adresse',33.5992088,-7.5216908,'workspace_uploads/images/GcC079Exi5gNsqfIj7mSMZJWS2xpfoZHvsVNdc85.png','workspace_uploads/videos/P5cLISlJ3c8ddVA7T5lCsvJS0OnEriBHB3tAqxRZ.mov',NULL,'profiles/nSj4OF1w8jrIeaWJLN7V4Q0ApitCk45TkFnNdXTZ.png','It\'s my first test');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `working_hours`
--

DROP TABLE IF EXISTS `working_hours`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `working_hours` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `service_id` bigint(20) unsigned NOT NULL,
  `start_hour` time DEFAULT NULL,
  `end_hour` time DEFAULT NULL,
  `training_option` enum('Gym','At Home','Any Where','Outside') NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `working_hours_service_id_foreign` (`service_id`),
  CONSTRAINT `working_hours_service_id_foreign` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `working_hours`
--

LOCK TABLES `working_hours` WRITE;
/*!40000 ALTER TABLE `working_hours` DISABLE KEYS */;
INSERT INTO `working_hours` VALUES
(6,70,'13:00:00','17:00:00','At Home','2025-06-23 21:18:25','2025-06-23 21:18:25'),
(7,71,'15:00:00','16:00:00','Outside','2025-06-23 21:26:19','2025-06-23 21:26:19'),
(8,72,'14:00:00','17:00:00','Any Where','2025-06-23 21:36:28','2025-06-23 21:36:28'),
(9,73,'14:00:00','17:00:00','At Home','2025-06-23 21:47:32','2025-06-23 21:47:32'),
(10,74,'14:00:00','15:00:00','At Home','2025-06-23 22:24:33','2025-06-23 22:24:33');
/*!40000 ALTER TABLE `working_hours` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workspace_media`
--

DROP TABLE IF EXISTS `workspace_media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `workspace_media` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `service_id` bigint(20) unsigned NOT NULL,
  `workspace_image` varchar(255) DEFAULT NULL,
  `workspace_video` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `workspace_media_service_id_foreign` (`service_id`),
  CONSTRAINT `workspace_media_service_id_foreign` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workspace_media`
--

LOCK TABLES `workspace_media` WRITE;
/*!40000 ALTER TABLE `workspace_media` DISABLE KEYS */;
INSERT INTO `workspace_media` VALUES
(3,70,'workspace_uploads/images/EfT8oIrVtZ1BT4t3VgwIiLjChehgVs4na6fzBddo.png','workspace_uploads/videos/PoIecMyY3Ni6xHQQ17v6cvnba1bES2V6156Gegfr.mov','2025-06-23 21:18:42','2025-06-23 21:18:42'),
(4,71,'workspace_uploads/images/sCEzFls7zjbaqX9yA6c5I77CDxwlItY8EdAM0KHd.png','workspace_uploads/videos/5Ap1YR2toQOElqBRkeXBlHivyY6iHn7GZSH8V6uD.mov','2025-06-23 21:26:37','2025-06-23 21:26:37'),
(5,72,'workspace_uploads/images/EDeDaaNRWvsVviivQV9IwL2OYiaBTGjavfxPopED.png','workspace_uploads/videos/mOcJFbKUIrZ7a1BjTy15A67aMVwr7cTreITlOXGg.mov','2025-06-23 21:36:52','2025-06-23 21:36:52'),
(6,73,'workspace_uploads/images/aAlfBTRzM5LenN1xs5Z4uCnz0gJlGs73G6LNrT1u.png','workspace_uploads/videos/iLgN9mxUpKl194ikuN0NL58Uw08DrnQGz2XQJhtj.mov','2025-06-23 21:47:49','2025-06-23 21:47:49'),
(7,74,'workspace_uploads/images/wPETKP3Mz7RcM7UkO4op6piHle99vPnKSEwKKzmq.png','workspace_uploads/videos/k6x9TyqDTmWKVsd1vBaRk9M1oaHaK2610MSsCmBa.mov','2025-06-23 22:26:00','2025-06-23 22:26:00');
/*!40000 ALTER TABLE `workspace_media` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2025-06-24  2:36:36
