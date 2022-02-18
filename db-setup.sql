-- phpMyAdmin SQL Dump
-- version 4.6.6deb5ubuntu0.5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Feb 17, 2022 at 03:36 PM
-- Server version: 8.0.27
-- PHP Version: 7.3.33-1+ubuntu18.04.1+deb.sury.org+1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `demoForus`
--
drop database if exists demoForus;
CREATE DATABASE IF NOT EXISTS `demoForus` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `demoForus`;

-- --------------------------------------------------------

--
-- Table structure for table `banks`
--

CREATE TABLE IF NOT EXISTS `banks` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `key` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `oauth_redirect_id` varchar(191) COLLATE utf8_unicode_ci DEFAULT NULL,
  `oauth_redirect_url` varchar(2000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `data` json NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bank_connections`
--

CREATE TABLE IF NOT EXISTS `bank_connections` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `bank_id` int UNSIGNED NOT NULL,
  `organization_id` int UNSIGNED NOT NULL,
  `implementation_id` int UNSIGNED NOT NULL,
  `bank_connection_account_id` bigint UNSIGNED DEFAULT NULL,
  `redirect_token` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `access_token` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `code` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `context` json NOT NULL,
  `session_expire_at` timestamp NULL DEFAULT NULL,
  `state` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bank_connections_bank_id_index` (`bank_id`),
  KEY `bank_connections_organization_id_index` (`organization_id`),
  KEY `bank_connections_implementation_id_index` (`implementation_id`),
  KEY `bank_connections_bank_connection_account_id_foreign` (`bank_connection_account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bank_connection_accounts`
--

CREATE TABLE IF NOT EXISTS `bank_connection_accounts` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `bank_connection_id` int UNSIGNED NOT NULL,
  `monetary_account_id` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `monetary_account_iban` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(200) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'monetary',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bunq_ideal_issuers`
--

CREATE TABLE IF NOT EXISTS `bunq_ideal_issuers` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `bic` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `sandbox` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `business_types`
--

CREATE TABLE IF NOT EXISTS `business_types` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `key` varchar(120) COLLATE utf8_unicode_ci NOT NULL,
  `parent_id` int UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2053 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `business_type_translations`
--

CREATE TABLE IF NOT EXISTS `business_type_translations` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `business_type_id` int UNSIGNED NOT NULL,
  `locale` varchar(3) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(120) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `business_type_translations_business_type_id_locale_unique` (`business_type_id`,`locale`)
) ENGINE=InnoDB AUTO_INCREMENT=4105 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `demo_transactions`
--

CREATE TABLE IF NOT EXISTS `demo_transactions` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `token` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `state` enum('pending','accepted','rejected') COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `digests`
--

CREATE TABLE IF NOT EXISTS `digests` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `digestable_type` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `digestable_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `digests_digestable_type_digestable_id_index` (`digestable_type`,`digestable_id`)
) ENGINE=InnoDB AUTO_INCREMENT=60135 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `digid_sessions`
--

CREATE TABLE IF NOT EXISTS `digid_sessions` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `state` enum('created','pending_authorization','authorized','expired','error') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'created',
  `implementation_id` int UNSIGNED DEFAULT NULL,
  `client_type` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `identity_address` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `meta` json NOT NULL,
  `session_uid` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `session_secret` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `session_final_url` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `session_request` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `digid_rid` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `digid_uid` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `digid_app_url` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `digid_as_url` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `digid_auth_redirect_url` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `digid_error_code` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `digid_error_message` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `digid_request_aselect_server` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `digid_response_aselect_server` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `digid_response_aselect_credentials` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=487 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE IF NOT EXISTS `employees` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `identity_address` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `organization_id` int UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `employees_organization_id_index` (`organization_id`)
) ENGINE=InnoDB AUTO_INCREMENT=425 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `employee_roles`
--

CREATE TABLE IF NOT EXISTS `employee_roles` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `employee_id` int UNSIGNED NOT NULL,
  `role_id` int UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `employee_roles_employee_id_index` (`employee_id`),
  KEY `employee_roles_role_id_index` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1991 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `event_logs`
--

CREATE TABLE IF NOT EXISTS `event_logs` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `loggable_type` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `loggable_id` bigint UNSIGNED NOT NULL,
  `event` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `identity_address` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `original` tinyint(1) NOT NULL DEFAULT '1',
  `data` json NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `event_logs_loggable_type_loggable_id_index` (`loggable_type`,`loggable_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4613 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `connection` text COLLATE utf8_unicode_ci NOT NULL,
  `queue` text COLLATE utf8_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `files`
--

CREATE TABLE IF NOT EXISTS `files` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `original_name` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` varchar(60) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `ext` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `path` varchar(1024) COLLATE utf8_unicode_ci NOT NULL,
  `size` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `identity_address` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `fileable_id` int UNSIGNED DEFAULT NULL,
  `fileable_type` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `funds`
--

CREATE TABLE IF NOT EXISTS `funds` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `organization_id` int UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(15000) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `description_text` text COLLATE utf8_unicode_ci,
  `description_short` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `faq_title` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `request_btn_text` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Aanvragen',
  `external_link_url` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `external_link_text` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `type` enum('budget','subsidies','external') COLLATE utf8_unicode_ci DEFAULT 'budget',
  `state` enum('active','closed','paused','waiting') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'waiting',
  `archived` tinyint(1) NOT NULL DEFAULT '0',
  `public` tinyint(1) NOT NULL DEFAULT '0',
  `criteria_editable_after_start` tinyint(1) NOT NULL DEFAULT '0',
  `notification_amount` decimal(10,2) DEFAULT NULL,
  `notified_at` timestamp NULL DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date NOT NULL DEFAULT '0000-00-00',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `default_validator_employee_id` int UNSIGNED DEFAULT NULL,
  `auto_requests_validation` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `funds_organization_id_foreign` (`organization_id`),
  KEY `funds_default_validator_employee_id_foreign` (`default_validator_employee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fund_backoffice_logs`
--

CREATE TABLE IF NOT EXISTS `fund_backoffice_logs` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `fund_id` int UNSIGNED DEFAULT NULL,
  `identity_address` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `bsn` varchar(191) COLLATE utf8_unicode_ci DEFAULT NULL,
  `voucher_id` int DEFAULT NULL,
  `action` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `state` enum('pending','success','error') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'pending',
  `request_id` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `response_id` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `response_code` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `response_body` json DEFAULT NULL,
  `response_error` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `attempts` int NOT NULL,
  `last_attempt_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fund_backoffice_logs_fund_id_foreign` (`fund_id`),
  KEY `fund_backoffice_logs_identity_address_foreign` (`identity_address`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fund_configs`
--

CREATE TABLE IF NOT EXISTS `fund_configs` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `fund_id` int UNSIGNED NOT NULL,
  `implementation_id` int UNSIGNED DEFAULT NULL,
  `key` varchar(40) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `record_validity_days` mediumint UNSIGNED DEFAULT NULL,
  `hash_bsn` tinyint(1) NOT NULL DEFAULT '0',
  `hash_bsn_salt` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `hash_partner_deny` tinyint(1) NOT NULL DEFAULT '0',
  `bunq_key` varchar(200) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `bunq_allowed_ip` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `bunq_sandbox` tinyint(1) NOT NULL DEFAULT '1',
  `csv_primary_key` varchar(191) COLLATE utf8_unicode_ci DEFAULT NULL,
  `allow_physical_cards` tinyint(1) NOT NULL DEFAULT '0',
  `allow_fund_requests` tinyint(1) NOT NULL DEFAULT '1',
  `allow_prevalidations` tinyint(1) NOT NULL DEFAULT '1',
  `allow_direct_requests` tinyint(1) NOT NULL DEFAULT '1',
  `allow_blocking_vouchers` tinyint(1) NOT NULL DEFAULT '0',
  `employee_can_see_product_vouchers` tinyint(1) NOT NULL DEFAULT '0',
  `is_configured` tinyint(1) NOT NULL DEFAULT '0',
  `limit_generator_amount` tinyint(1) NOT NULL DEFAULT '1',
  `backoffice_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `backoffice_status` tinyint(1) NOT NULL DEFAULT '0',
  `backoffice_url` varchar(191) COLLATE utf8_unicode_ci DEFAULT NULL,
  `backoffice_key` varchar(191) COLLATE utf8_unicode_ci DEFAULT NULL,
  `backoffice_certificate` varchar(8000) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `backoffice_fallback` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fund_configs_fund_id_foreign` (`fund_id`),
  KEY `fund_configs_implementation_id_index` (`implementation_id`),
  KEY `fund_configs_csv_primary_key_foreign` (`csv_primary_key`)
) ENGINE=InnoDB AUTO_INCREMENT=2331 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fund_config_records`
--

CREATE TABLE IF NOT EXISTS `fund_config_records` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `fund_id` int UNSIGNED NOT NULL,
  `record_type` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `record_validity_days` mediumint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `fund_config_records_fund_id_record_type_unique` (`fund_id`,`record_type`),
  KEY `fund_config_records_fund_id_record_type_index` (`fund_id`,`record_type`),
  KEY `fund_config_records_record_type_foreign` (`record_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fund_criteria`
--

CREATE TABLE IF NOT EXISTS `fund_criteria` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `fund_id` int UNSIGNED NOT NULL,
  `record_type_key` varchar(191) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `operator` varchar(5) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `value` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `title` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `show_attachment` tinyint(1) NOT NULL DEFAULT '1',
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fund_criteria_fund_id_foreign` (`fund_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3380 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fund_criterion_validators`
--

CREATE TABLE IF NOT EXISTS `fund_criterion_validators` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `fund_criterion_id` int UNSIGNED NOT NULL,
  `organization_validator_id` int UNSIGNED NOT NULL,
  `accepted` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `fund_criterion_validators_criterion_id_validator_id_unique` (`fund_criterion_id`,`organization_validator_id`),
  KEY `fund_criterion_validators_organization_validator_id_foreign` (`organization_validator_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fund_faq`
--

CREATE TABLE IF NOT EXISTS `fund_faq` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `fund_id` int UNSIGNED NOT NULL,
  `title` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(5000) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fund_faq_fund_id_foreign` (`fund_id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fund_formulas`
--

CREATE TABLE IF NOT EXISTS `fund_formulas` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `fund_id` int UNSIGNED NOT NULL,
  `type` enum('multiply','fixed') COLLATE utf8_unicode_ci NOT NULL,
  `amount` decimal(10,2) UNSIGNED NOT NULL,
  `record_type_key` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fund_formulas_record_type_key_foreign` (`record_type_key`),
  KEY `fund_formulas_fund_id_foreign` (`fund_id`)
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fund_formula_products`
--

CREATE TABLE IF NOT EXISTS `fund_formula_products` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `fund_id` int UNSIGNED NOT NULL,
  `product_id` int UNSIGNED NOT NULL,
  `price` decimal(8,2) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fund_formula_products_fund_id_foreign` (`fund_id`),
  KEY `fund_formula_products_product_id_foreign` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fund_limit_multipliers`
--

CREATE TABLE IF NOT EXISTS `fund_limit_multipliers` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `fund_id` int UNSIGNED NOT NULL,
  `record_type_key` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `multiplier` int UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fund_limit_multipliers_record_type_key_foreign` (`record_type_key`),
  KEY `fund_limit_multipliers_fund_id_foreign` (`fund_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fund_products`
--

CREATE TABLE IF NOT EXISTS `fund_products` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `fund_id` int UNSIGNED NOT NULL,
  `product_id` int UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fund_products_fund_id_foreign` (`fund_id`),
  KEY `fund_products_product_id_foreign` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fund_providers`
--

CREATE TABLE IF NOT EXISTS `fund_providers` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `organization_id` int UNSIGNED NOT NULL,
  `fund_id` int UNSIGNED NOT NULL,
  `allow_budget` tinyint(1) NOT NULL DEFAULT '0',
  `allow_products` tinyint(1) NOT NULL DEFAULT '0',
  `state` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'pending',
  `allow_some_products` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fund_providers_fund_id_foreign` (`fund_id`),
  KEY `fund_providers_organization_id_foreign` (`organization_id`)
) ENGINE=InnoDB AUTO_INCREMENT=318 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fund_provider_chats`
--

CREATE TABLE IF NOT EXISTS `fund_provider_chats` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `product_id` int UNSIGNED DEFAULT NULL,
  `fund_provider_id` int UNSIGNED DEFAULT NULL,
  `identity_address` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fund_provider_chats_product_id_foreign` (`product_id`),
  KEY `fund_provider_chats_fund_provider_id_foreign` (`fund_provider_id`),
  KEY `fund_provider_chats_identity_address_foreign` (`identity_address`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fund_provider_chat_messages`
--

CREATE TABLE IF NOT EXISTS `fund_provider_chat_messages` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `fund_provider_chat_id` bigint UNSIGNED NOT NULL,
  `message` varchar(2000) COLLATE utf8_unicode_ci NOT NULL,
  `identity_address` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `counterpart` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `seen_at` timestamp NULL DEFAULT NULL,
  `provider_seen` tinyint(1) NOT NULL DEFAULT '0',
  `sponsor_seen` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fund_provider_chat_messages_fund_provider_chat_id_foreign` (`fund_provider_chat_id`),
  KEY `fund_provider_chat_messages_identity_address_foreign` (`identity_address`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fund_provider_invitations`
--

CREATE TABLE IF NOT EXISTS `fund_provider_invitations` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `organization_id` int UNSIGNED NOT NULL,
  `from_fund_id` int UNSIGNED NOT NULL,
  `fund_id` int UNSIGNED NOT NULL,
  `allow_budget` tinyint(1) NOT NULL DEFAULT '0',
  `allow_products` tinyint(1) NOT NULL DEFAULT '0',
  `state` enum('pending','accepted','expired') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'pending',
  `token` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `provider_state` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fund_provider_products`
--

CREATE TABLE IF NOT EXISTS `fund_provider_products` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `fund_provider_id` int UNSIGNED NOT NULL,
  `product_id` int UNSIGNED NOT NULL,
  `limit_total` int UNSIGNED DEFAULT NULL,
  `limit_total_unlimited` tinyint(1) NOT NULL DEFAULT '0',
  `limit_per_identity` int UNSIGNED DEFAULT NULL,
  `amount` decimal(8,2) DEFAULT NULL,
  `price` decimal(8,2) DEFAULT NULL,
  `expire_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fund_provider_products_product_id_fund_provider_id_index` (`product_id`,`fund_provider_id`)
) ENGINE=InnoDB AUTO_INCREMENT=210 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fund_provider_product_exclusions`
--

CREATE TABLE IF NOT EXISTS `fund_provider_product_exclusions` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `fund_provider_id` int UNSIGNED NOT NULL,
  `product_id` int UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fund_provider_product_exclusions_fund_provider_id_foreign` (`fund_provider_id`),
  KEY `fund_provider_product_exclusions_product_id_foreign` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fund_requests`
--

CREATE TABLE IF NOT EXISTS `fund_requests` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `fund_id` int UNSIGNED NOT NULL,
  `identity_address` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `note` varchar(2000) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `disregard_note` varchar(2000) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `disregard_notify` tinyint(1) NOT NULL DEFAULT '0',
  `state` enum('pending','approved','declined','approved_partly','disregarded') COLLATE utf8_unicode_ci DEFAULT 'pending',
  `resolved_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=155 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fund_request_clarifications`
--

CREATE TABLE IF NOT EXISTS `fund_request_clarifications` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `fund_request_record_id` int UNSIGNED NOT NULL,
  `question` varchar(2000) COLLATE utf8_unicode_ci NOT NULL,
  `answer` varchar(2000) COLLATE utf8_unicode_ci NOT NULL,
  `state` enum('pending','answered') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'pending',
  `answered_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fund_request_clarifications_fund_request_record_id_foreign` (`fund_request_record_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fund_request_records`
--

CREATE TABLE IF NOT EXISTS `fund_request_records` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `fund_request_id` int UNSIGNED NOT NULL,
  `fund_criterion_id` int UNSIGNED DEFAULT NULL,
  `record_type_key` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `value` varchar(200) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `note` varchar(2000) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `state` enum('pending','approved','declined','disregarded') COLLATE utf8_unicode_ci DEFAULT 'pending',
  `employee_id` int UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fund_request_records_fund_request_id_foreign` (`fund_request_id`)
) ENGINE=InnoDB AUTO_INCREMENT=441 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fund_top_ups`
--

CREATE TABLE IF NOT EXISTS `fund_top_ups` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `fund_id` int UNSIGNED DEFAULT NULL,
  `code` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fund_top_ups_fund_id_foreign` (`fund_id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fund_top_up_transactions`
--

CREATE TABLE IF NOT EXISTS `fund_top_up_transactions` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `fund_top_up_id` int UNSIGNED NOT NULL,
  `amount` double(8,2) UNSIGNED DEFAULT NULL,
  `bunq_transaction_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fund_top_up_transactions_fund_top_up_id_foreign` (`fund_top_up_id`)
) ENGINE=InnoDB AUTO_INCREMENT=283 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `identities`
--

CREATE TABLE IF NOT EXISTS `identities` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `pin_code` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `public_key` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `private_key` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `passphrase` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `identities_address_unique` (`address`)
) ENGINE=InnoDB AUTO_INCREMENT=627 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `identity_emails`
--

CREATE TABLE IF NOT EXISTS `identity_emails` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `email` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `identity_address` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `verified` tinyint(1) NOT NULL DEFAULT '0',
  `primary` tinyint(1) NOT NULL DEFAULT '0',
  `initial` tinyint(1) NOT NULL DEFAULT '0',
  `verification_token` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `identity_emails_identity_address_primary_index` (`identity_address`,`primary`),
  KEY `identity_emails_identity_address_index` (`identity_address`),
  KEY `identity_emails_primary_index` (`primary`),
  KEY `identity_emails_initial_index` (`initial`)
) ENGINE=InnoDB AUTO_INCREMENT=629 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `identity_proxies`
--

CREATE TABLE IF NOT EXISTS `identity_proxies` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `identity_address` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `access_token` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `exchange_token` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `state` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `expires_in` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `identity_proxies_identity_address_foreign` (`identity_address`)
) ENGINE=InnoDB AUTO_INCREMENT=4434 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `implementations`
--

CREATE TABLE IF NOT EXISTS `implementations` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `organization_id` int UNSIGNED DEFAULT NULL,
  `key` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `description_alignment` enum('left','center','right') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'left',
  `overlay_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `overlay_type` varchar(191) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'color',
  `header_text_color` enum('dark','bright','auto') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'auto',
  `overlay_opacity` int NOT NULL DEFAULT '40',
  `url_webshop` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `url_sponsor` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `url_provider` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `url_validator` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `url_app` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `lon` double DEFAULT NULL,
  `lat` double DEFAULT NULL,
  `informal_communication` tinyint(1) NOT NULL DEFAULT '0',
  `email_from_address` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email_from_name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email_color` text COLLATE utf8_unicode_ci,
  `email_signature` text COLLATE utf8_unicode_ci,
  `digid_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `digid_required` tinyint(1) NOT NULL DEFAULT '1',
  `digid_env` enum('sandbox','production') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'sandbox',
  `digid_app_id` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `digid_shared_secret` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `digid_a_select_server` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `digid_forus_api_url` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `implementation_pages`
--

CREATE TABLE IF NOT EXISTS `implementation_pages` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `implementation_id` int UNSIGNED NOT NULL,
  `page_type` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `content` text COLLATE utf8_unicode_ci,
  `content_alignment` enum('left','center','right') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'left',
  `external_url` varchar(300) COLLATE utf8_unicode_ci DEFAULT NULL,
  `external` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE IF NOT EXISTS `jobs` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `queue` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `languages`
--

CREATE TABLE IF NOT EXISTS `languages` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `locale` varchar(3) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `base` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `media`
--

CREATE TABLE IF NOT EXISTS `media` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `original_name` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `ext` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `order` int UNSIGNED NOT NULL DEFAULT '0',
  `dominant_color` varchar(200) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `identity_address` varchar(200) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `mediable_id` int UNSIGNED DEFAULT NULL,
  `mediable_type` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=622 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `media_presets`
--

CREATE TABLE IF NOT EXISTS `media_presets` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `media_id` int UNSIGNED NOT NULL,
  `key` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `path` varchar(1024) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `media_sizes_media_id_foreign` (`media_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1967 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=639 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE IF NOT EXISTS `notifications` (
  `id` char(36) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `notifiable_type` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `notifiable_id` bigint UNSIGNED NOT NULL,
  `data` text COLLATE utf8_unicode_ci NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notification_preferences`
--

CREATE TABLE IF NOT EXISTS `notification_preferences` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `identity_address` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `key` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `type` enum('email','push') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'email',
  `subscribed` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notification_preferences_identity_address_mail_key_index` (`identity_address`,`key`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notification_templates`
--

CREATE TABLE IF NOT EXISTS `notification_templates` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'mail',
  `formal` tinyint(1) NOT NULL DEFAULT '0',
  `system_notification_id` bigint UNSIGNED NOT NULL,
  `implementation_id` int UNSIGNED NOT NULL,
  `title` varchar(400) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `content` varchar(16384) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `notification_templates_fields_unique` (`type`,`formal`,`system_notification_id`,`implementation_id`),
  KEY `notification_templates_system_notification_id_foreign` (`system_notification_id`),
  KEY `notification_templates_implementation_id_foreign` (`implementation_id`)
) ENGINE=InnoDB AUTO_INCREMENT=399 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notification_tokens`
--

CREATE TABLE IF NOT EXISTS `notification_tokens` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `identity_address` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `type` enum('fcm','apn') COLLATE utf8_unicode_ci NOT NULL,
  `token` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notification_tokens_identity_address_foreign` (`identity_address`)
) ENGINE=InnoDB AUTO_INCREMENT=125 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notification_unsubscriptions`
--

CREATE TABLE IF NOT EXISTS `notification_unsubscriptions` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `email` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notification_unsubscription_tokens`
--

CREATE TABLE IF NOT EXISTS `notification_unsubscription_tokens` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `email` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `token` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6636 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `offices`
--

CREATE TABLE IF NOT EXISTS `offices` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `organization_id` int UNSIGNED NOT NULL,
  `address` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `phone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lon` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lat` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `postcode` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `postcode_number` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `postcode_addition` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `parsed` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `offices_organization_id_foreign` (`organization_id`)
) ENGINE=InnoDB AUTO_INCREMENT=149 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `office_schedules`
--

CREATE TABLE IF NOT EXISTS `office_schedules` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `office_id` int UNSIGNED NOT NULL,
  `week_day` int UNSIGNED NOT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `break_start_time` time DEFAULT NULL,
  `break_end_time` time DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `office_schedules_office_id_foreign` (`office_id`)
) ENGINE=InnoDB AUTO_INCREMENT=620 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `organizations`
--

CREATE TABLE IF NOT EXISTS `organizations` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `identity_address` varchar(200) COLLATE utf8_unicode_ci DEFAULT '',
  `name` varchar(200) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `description` varchar(4096) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description_text` text COLLATE utf8_unicode_ci,
  `iban` varchar(200) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `email` varchar(200) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `email_public` tinyint(1) NOT NULL DEFAULT '0',
  `phone` varchar(200) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `phone_public` tinyint(1) NOT NULL DEFAULT '0',
  `kvk` varchar(200) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `btw` varchar(200) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `website` varchar(200) COLLATE utf8_unicode_ci DEFAULT '',
  `website_public` tinyint(1) NOT NULL DEFAULT '0',
  `business_type_id` int UNSIGNED DEFAULT NULL,
  `is_sponsor` tinyint(1) NOT NULL DEFAULT '0',
  `is_provider` tinyint(1) NOT NULL DEFAULT '0',
  `is_validator` tinyint(1) NOT NULL DEFAULT '0',
  `validator_auto_accept_funds` tinyint(1) NOT NULL DEFAULT '0',
  `reservations_budget_enabled` tinyint(1) NOT NULL DEFAULT '1',
  `reservations_subsidy_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `reservations_auto_accept` tinyint(1) NOT NULL DEFAULT '0',
  `manage_provider_products` tinyint(1) NOT NULL DEFAULT '0',
  `backoffice_available` tinyint(1) NOT NULL DEFAULT '0',
  `allow_batch_reservations` tinyint(1) NOT NULL DEFAULT '0',
  `pre_approve_external_funds` tinyint(1) NOT NULL DEFAULT '0',
  `provider_throttling_value` int NOT NULL DEFAULT '100',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `bsn_enabled` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `organizations_identity_address_foreign` (`identity_address`),
  KEY `organizations_business_type_id_foreign` (`business_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=170 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `organization_validators`
--

CREATE TABLE IF NOT EXISTS `organization_validators` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `organization_id` int UNSIGNED NOT NULL,
  `validator_organization_id` int UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `organization_validators_organization_id_validator_id_unique` (`organization_id`,`validator_organization_id`),
  KEY `organization_validators_validator_organization_id_foreign` (`validator_organization_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE IF NOT EXISTS `permissions` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `key` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `permissions_key_index` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `physical_cards`
--

CREATE TABLE IF NOT EXISTS `physical_cards` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `voucher_id` int UNSIGNED NOT NULL,
  `code` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `identity_address` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `physical_cards_code_unique` (`code`),
  KEY `physical_cards_voucher_id_foreign` (`voucher_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `physical_card_requests`
--

CREATE TABLE IF NOT EXISTS `physical_card_requests` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `voucher_id` int UNSIGNED NOT NULL,
  `employee_id` int UNSIGNED DEFAULT NULL,
  `address` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `house` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `house_addition` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `postcode` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `city` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `physical_card_requests_voucher_id_foreign` (`voucher_id`),
  KEY `physical_card_requests_employee_id_foreign` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `prevalidations`
--

CREATE TABLE IF NOT EXISTS `prevalidations` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` varchar(191) COLLATE utf8_unicode_ci DEFAULT NULL,
  `identity_address` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `redeemed_by_address` varchar(191) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fund_id` int UNSIGNED DEFAULT NULL,
  `organization_id` int UNSIGNED DEFAULT NULL,
  `state` varchar(191) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'pending',
  `uid_hash` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `records_hash` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `exported` tinyint(1) NOT NULL DEFAULT '0',
  `validated_at` datetime DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `prevalidations_identity_address_foreign` (`identity_address`),
  KEY `prevalidations_redeemed_by_address_foreign` (`redeemed_by_address`)
) ENGINE=InnoDB AUTO_INCREMENT=946 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `prevalidation_records`
--

CREATE TABLE IF NOT EXISTS `prevalidation_records` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `record_type_id` int UNSIGNED NOT NULL,
  `prevalidation_id` int UNSIGNED NOT NULL,
  `value` varchar(191) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `prevalidation_records_record_type_id_foreign` (`record_type_id`),
  KEY `prevalidation_records_prevalidation_id_foreign` (`prevalidation_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6494 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE IF NOT EXISTS `products` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `organization_id` int UNSIGNED NOT NULL,
  `product_category_id` int UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(2500) COLLATE utf8_unicode_ci NOT NULL,
  `description_text` text COLLATE utf8_unicode_ci,
  `price` decimal(10,2) UNSIGNED NOT NULL,
  `total_amount` int UNSIGNED NOT NULL,
  `unlimited_stock` tinyint(1) NOT NULL DEFAULT '0',
  `price_type` enum('free','regular','discount_percentage','discount_fixed') COLLATE utf8_unicode_ci NOT NULL,
  `price_discount` decimal(8,2) DEFAULT '0.00',
  `show_on_webshop` tinyint(1) NOT NULL DEFAULT '1',
  `reservation_enabled` tinyint(1) NOT NULL DEFAULT '1',
  `reservation_policy` enum('accept','review','global') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'global',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `expire_at` date DEFAULT NULL,
  `sold_out` tinyint(1) NOT NULL DEFAULT '0',
  `sponsor_organization_id` int UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `products_organization_id_foreign` (`organization_id`),
  KEY `products_product_category_id_foreign` (`product_category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=198 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_categories`
--

CREATE TABLE IF NOT EXISTS `product_categories` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `key` varchar(120) COLLATE utf8_unicode_ci NOT NULL,
  `parent_id` int UNSIGNED DEFAULT NULL,
  `root_id` int UNSIGNED DEFAULT NULL,
  `_lft` int UNSIGNED NOT NULL,
  `_rgt` int UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `service` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `product_categories_parent_id_foreign` (`parent_id`),
  KEY `product_categories_root_id_foreign` (`root_id`)
) ENGINE=InnoDB AUTO_INCREMENT=755009 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_category_translations`
--

CREATE TABLE IF NOT EXISTS `product_category_translations` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `product_category_id` int UNSIGNED NOT NULL,
  `locale` varchar(3) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(120) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_category_translations_product_category_id_locale_unique` (`product_category_id`,`locale`)
) ENGINE=InnoDB AUTO_INCREMENT=11123 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_reservations`
--

CREATE TABLE IF NOT EXISTS `product_reservations` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `product_id` int UNSIGNED NOT NULL,
  `voucher_id` int UNSIGNED NOT NULL,
  `employee_id` int UNSIGNED DEFAULT NULL,
  `voucher_transaction_id` int UNSIGNED DEFAULT NULL,
  `fund_provider_product_id` int UNSIGNED DEFAULT NULL,
  `amount` decimal(8,2) NOT NULL,
  `price` decimal(8,2) NOT NULL,
  `price_discount` decimal(8,2) NOT NULL,
  `code` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `price_type` enum('free','regular','discount_percentage','discount_fixed') COLLATE utf8_unicode_ci NOT NULL,
  `state` enum('pending','accepted','rejected','canceled','complete') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'pending',
  `first_name` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_name` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_note` varchar(400) COLLATE utf8_unicode_ci DEFAULT NULL,
  `note` varchar(2000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `accepted_at` timestamp NULL DEFAULT NULL,
  `canceled_at` timestamp NULL DEFAULT NULL,
  `rejected_at` timestamp NULL DEFAULT NULL,
  `expire_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_reservations_employee_id_foreign` (`employee_id`),
  KEY `product_reservations_product_id_foreign` (`product_id`),
  KEY `product_reservations_voucher_id_foreign` (`voucher_id`),
  KEY `product_reservations_voucher_transaction_id_foreign` (`voucher_transaction_id`),
  KEY `product_reservations_fund_provider_product_id_foreign` (`fund_provider_product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `records`
--

CREATE TABLE IF NOT EXISTS `records` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `identity_address` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `record_type_id` int UNSIGNED NOT NULL,
  `record_category_id` int UNSIGNED DEFAULT NULL,
  `prevalidation_id` int UNSIGNED DEFAULT NULL,
  `value` varchar(191) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `order` int UNSIGNED NOT NULL DEFAULT '0',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `records_identity_address_foreign` (`identity_address`),
  KEY `records_record_type_id_foreign` (`record_type_id`),
  KEY `records_record_category_id_foreign` (`record_category_id`),
  KEY `records_prevalidation_id_foreign` (`prevalidation_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1854 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `record_categories`
--

CREATE TABLE IF NOT EXISTS `record_categories` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `identity_address` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `order` int UNSIGNED NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `record_categories_identity_address_foreign` (`identity_address`)
) ENGINE=InnoDB AUTO_INCREMENT=838 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `record_types`
--

CREATE TABLE IF NOT EXISTS `record_types` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `key` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `system` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `record_types_key_unique` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `record_type_translations`
--

CREATE TABLE IF NOT EXISTS `record_type_translations` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `record_type_id` int UNSIGNED NOT NULL,
  `locale` varchar(3) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `record_type_translations_record_type_id_locale_unique` (`record_type_id`,`locale`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `record_validations`
--

CREATE TABLE IF NOT EXISTS `record_validations` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `uuid` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `record_id` int UNSIGNED NOT NULL,
  `identity_address` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `organization_id` int UNSIGNED DEFAULT NULL,
  `prevalidation_id` int UNSIGNED DEFAULT NULL,
  `state` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `record_validations_uuid_unique` (`uuid`),
  KEY `record_validations_record_id_foreign` (`record_id`),
  KEY `record_validations_identity_address_foreign` (`identity_address`),
  KEY `record_validations_prevalidation_id_foreign` (`prevalidation_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1016 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE IF NOT EXISTS `roles` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `key` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `roles_key_index` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `role_permissions`
--

CREATE TABLE IF NOT EXISTS `role_permissions` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `role_id` int UNSIGNED NOT NULL,
  `permission_id` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  KEY `role_permissions_role_id_index` (`role_id`),
  KEY `role_permissions_permission_id_index` (`permission_id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `role_translations`
--

CREATE TABLE IF NOT EXISTS `role_translations` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `role_id` int UNSIGNED NOT NULL,
  `locale` varchar(3) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `role_translations_role_id_locale_unique` (`role_id`,`locale`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE IF NOT EXISTS `sessions` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `identity_address` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `identity_proxy_id` int UNSIGNED DEFAULT NULL,
  `last_activity_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sessions_uid_unique` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=2111 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `session_requests`
--

CREATE TABLE IF NOT EXISTS `session_requests` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `session_id` int UNSIGNED NOT NULL,
  `ip` varchar(46) COLLATE utf8_unicode_ci NOT NULL,
  `client_type` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `client_version` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `endpoint` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `method` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_agent` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `session_requests_session_id_foreign` (`session_id`)
) ENGINE=InnoDB AUTO_INCREMENT=241481 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sources`
--

CREATE TABLE IF NOT EXISTS `sources` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `key` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `url` varchar(191) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `system_notifications`
--

CREATE TABLE IF NOT EXISTS `system_notifications` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `key` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `mail` tinyint(1) NOT NULL DEFAULT '0',
  `push` tinyint(1) NOT NULL DEFAULT '0',
  `database` tinyint(1) NOT NULL DEFAULT '1',
  `optional` tinyint(1) NOT NULL DEFAULT '0',
  `visible` tinyint(1) NOT NULL DEFAULT '0',
  `editable` tinyint(1) NOT NULL DEFAULT '0',
  `order` int UNSIGNED NOT NULL DEFAULT '0',
  `group` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `system_notification_configs`
--

CREATE TABLE IF NOT EXISTS `system_notification_configs` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `system_notification_id` bigint UNSIGNED NOT NULL,
  `implementation_id` int UNSIGNED NOT NULL,
  `enable_all` tinyint(1) NOT NULL DEFAULT '1',
  `enable_mail` tinyint(1) NOT NULL DEFAULT '1',
  `enable_push` tinyint(1) NOT NULL DEFAULT '1',
  `enable_database` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `system_notification_configs_unique_keys` (`implementation_id`,`system_notification_id`),
  KEY `system_notification_configs_index_keys` (`implementation_id`,`system_notification_id`),
  KEY `system_notification_configs_system_notification_id_foreign` (`system_notification_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `taggables`
--

CREATE TABLE IF NOT EXISTS `taggables` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `tag_id` int UNSIGNED NOT NULL,
  `taggable_id` int UNSIGNED NOT NULL,
  `taggable_type` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `taggables_tag_id_foreign` (`tag_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tags`
--

CREATE TABLE IF NOT EXISTS `tags` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `key` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `scope` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `vouchers`
--

CREATE TABLE IF NOT EXISTS `vouchers` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `fund_id` int UNSIGNED NOT NULL,
  `identity_address` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `state` varchar(200) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'active',
  `amount` decimal(10,2) UNSIGNED NOT NULL,
  `limit_multiplier` int UNSIGNED NOT NULL DEFAULT '1',
  `returnable` tinyint(1) NOT NULL DEFAULT '1',
  `product_reservation_id` bigint UNSIGNED DEFAULT NULL,
  `note` varchar(280) COLLATE utf8_unicode_ci DEFAULT NULL,
  `employee_id` int UNSIGNED DEFAULT NULL,
  `activation_code` varchar(191) COLLATE utf8_unicode_ci DEFAULT NULL,
  `activation_code_uid` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fund_backoffice_log_id` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `product_id` int UNSIGNED DEFAULT NULL,
  `parent_id` int UNSIGNED DEFAULT NULL,
  `expire_at` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `vouchers_fund_id_foreign` (`fund_id`),
  KEY `vouchers_product_id_foreign` (`product_id`),
  KEY `vouchers_parent_id_foreign` (`parent_id`),
  KEY `vouchers_employee_id_foreign` (`employee_id`),
  KEY `vouchers_fund_backoffice_log_id_foreign` (`fund_backoffice_log_id`),
  KEY `vouchers_product_reservation_id_foreign` (`product_reservation_id`),
  KEY `vouchers_identity_address_index` (`identity_address`)
) ENGINE=InnoDB AUTO_INCREMENT=876 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `voucher_relations`
--

CREATE TABLE IF NOT EXISTS `voucher_relations` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `voucher_id` int UNSIGNED NOT NULL,
  `bsn` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `voucher_relations_voucher_id_foreign` (`voucher_id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `voucher_tokens`
--

CREATE TABLE IF NOT EXISTS `voucher_tokens` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `voucher_id` int UNSIGNED NOT NULL,
  `address` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `need_confirmation` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `voucher_tokens_voucher_id_foreign` (`voucher_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1741 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `voucher_transactions`
--

CREATE TABLE IF NOT EXISTS `voucher_transactions` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `voucher_id` int UNSIGNED NOT NULL,
  `organization_id` int UNSIGNED NOT NULL,
  `employee_id` int UNSIGNED DEFAULT NULL,
  `product_id` int UNSIGNED DEFAULT NULL,
  `fund_provider_product_id` int UNSIGNED DEFAULT NULL,
  `voucher_transaction_bulk_id` int UNSIGNED DEFAULT NULL,
  `amount` decimal(10,2) UNSIGNED NOT NULL,
  `iban_from` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `iban_to` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `payment_time` timestamp NULL DEFAULT NULL,
  `address` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `transfer_at` timestamp NULL DEFAULT NULL,
  `canceled_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `payment_id` int UNSIGNED DEFAULT NULL,
  `payment_description` varchar(191) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `attempts` int UNSIGNED NOT NULL DEFAULT '0',
  `state` varchar(191) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'pending',
  `last_attempt_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `voucher_transactions_voucher_id_foreign` (`voucher_id`),
  KEY `voucher_transactions_organization_id_foreign` (`organization_id`),
  KEY `voucher_transactions_product_id_foreign` (`product_id`),
  KEY `voucher_transactions_employee_id_foreign` (`employee_id`),
  KEY `voucher_transactions_voucher_transaction_bulk_id_index` (`voucher_transaction_bulk_id`)
) ENGINE=InnoDB AUTO_INCREMENT=387 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `voucher_transaction_bulks`
--

CREATE TABLE IF NOT EXISTS `voucher_transaction_bulks` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `bank_connection_id` int UNSIGNED DEFAULT NULL,
  `payment_id` int UNSIGNED DEFAULT NULL,
  `monetary_account_id` varchar(191) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `monetary_account_iban` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `state` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'draft',
  `accepted_manually` tinyint(1) NOT NULL DEFAULT '0',
  `state_fetched_times` int NOT NULL DEFAULT '0',
  `state_fetched_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `voucher_transaction_bulks_bank_connection_id_foreign` (`bank_connection_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `voucher_transaction_notes`
--

CREATE TABLE IF NOT EXISTS `voucher_transaction_notes` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `voucher_transaction_id` int UNSIGNED NOT NULL,
  `icon` varchar(10) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'quote',
  `message` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `pin_to_top` tinyint(1) NOT NULL DEFAULT '0',
  `group` varchar(10) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `voucher_transaction_notes_voucher_transaction_id_foreign` (`voucher_transaction_id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bank_connections`
--
ALTER TABLE `bank_connections`
  ADD CONSTRAINT `bank_connections_bank_connection_account_id_foreign` FOREIGN KEY (`bank_connection_account_id`) REFERENCES `bank_connection_accounts` (`id`) ON DELETE RESTRICT,
  ADD CONSTRAINT `bank_connections_bank_id_foreign` FOREIGN KEY (`bank_id`) REFERENCES `banks` (`id`) ON DELETE RESTRICT,
  ADD CONSTRAINT `bank_connections_implementation_id_foreign` FOREIGN KEY (`implementation_id`) REFERENCES `implementations` (`id`) ON DELETE RESTRICT,
  ADD CONSTRAINT `bank_connections_organization_id_foreign` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`) ON DELETE RESTRICT;

--
-- Constraints for table `business_type_translations`
--
ALTER TABLE `business_type_translations`
  ADD CONSTRAINT `business_type_translations_business_type_id_foreign` FOREIGN KEY (`business_type_id`) REFERENCES `business_types` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Constraints for table `employees`
--
ALTER TABLE `employees`
  ADD CONSTRAINT `employees_organization_id_foreign` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Constraints for table `employee_roles`
--
ALTER TABLE `employee_roles`
  ADD CONSTRAINT `employee_roles_employee_id_foreign` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  ADD CONSTRAINT `employee_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Constraints for table `funds`
--
/*ALTER TABLE `funds`
  ADD CONSTRAINT `funds_default_validator_employee_id_foreign` FOREIGN KEY (`default_validator_employee_id`) REFERENCES `employees` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  ADD CONSTRAINT `funds_organization_id_foreign` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT;
*/
--
-- Constraints for table `fund_backoffice_logs`
--
ALTER TABLE `fund_backoffice_logs`
  ADD CONSTRAINT `fund_backoffice_logs_fund_id_foreign` FOREIGN KEY (`fund_id`) REFERENCES `funds` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  ADD CONSTRAINT `fund_backoffice_logs_identity_address_foreign` FOREIGN KEY (`identity_address`) REFERENCES `identities` (`address`) ON DELETE SET NULL ON UPDATE RESTRICT;

--
-- Constraints for table `fund_configs`
--
/*ALTER TABLE `fund_configs`
  ADD CONSTRAINT `fund_configs_csv_primary_key_foreign` FOREIGN KEY (`csv_primary_key`) REFERENCES `record_types` (`key`) ON DELETE SET NULL ON UPDATE RESTRICT,
  ADD CONSTRAINT `fund_configs_fund_id_foreign` FOREIGN KEY (`fund_id`) REFERENCES `funds` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  ADD CONSTRAINT `fund_configs_implementation_id_foreign` FOREIGN KEY (`implementation_id`) REFERENCES `implementations` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT;
*/
--
-- Constraints for table `fund_config_records`
--
ALTER TABLE `fund_config_records`
  ADD CONSTRAINT `fund_config_records_fund_id_foreign` FOREIGN KEY (`fund_id`) REFERENCES `funds` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  ADD CONSTRAINT `fund_config_records_record_type_foreign` FOREIGN KEY (`record_type`) REFERENCES `record_types` (`key`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Constraints for table `fund_criteria`
--
/*ALTER TABLE `fund_criteria`
  ADD CONSTRAINT `fund_criteria_fund_id_foreign` FOREIGN KEY (`fund_id`) REFERENCES `funds` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT;
*/
--
-- Constraints for table `fund_criterion_validators`
--
ALTER TABLE `fund_criterion_validators`
  ADD CONSTRAINT `fund_criterion_validators_fund_criterion_id_foreign` FOREIGN KEY (`fund_criterion_id`) REFERENCES `fund_criteria` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  ADD CONSTRAINT `fund_criterion_validators_organization_validator_id_foreign` FOREIGN KEY (`organization_validator_id`) REFERENCES `organization_validators` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Constraints for table `fund_faq`
--
ALTER TABLE `fund_faq`
  ADD CONSTRAINT `fund_faq_fund_id_foreign` FOREIGN KEY (`fund_id`) REFERENCES `funds` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `fund_formulas`
--
ALTER TABLE `fund_formulas`
  ADD CONSTRAINT `fund_formulas_fund_id_foreign` FOREIGN KEY (`fund_id`) REFERENCES `funds` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  ADD CONSTRAINT `fund_formulas_record_type_key_foreign` FOREIGN KEY (`record_type_key`) REFERENCES `record_types` (`key`) ON DELETE SET NULL ON UPDATE RESTRICT;

--
-- Constraints for table `fund_formula_products`
--
ALTER TABLE `fund_formula_products`
  ADD CONSTRAINT `fund_formula_products_fund_id_foreign` FOREIGN KEY (`fund_id`) REFERENCES `funds` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fund_formula_products_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `fund_limit_multipliers`
--
ALTER TABLE `fund_limit_multipliers`
  ADD CONSTRAINT `fund_limit_multipliers_fund_id_foreign` FOREIGN KEY (`fund_id`) REFERENCES `funds` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  ADD CONSTRAINT `fund_limit_multipliers_record_type_key_foreign` FOREIGN KEY (`record_type_key`) REFERENCES `record_types` (`key`) ON DELETE SET NULL ON UPDATE RESTRICT;

--
-- Constraints for table `fund_products`
--
ALTER TABLE `fund_products`
  ADD CONSTRAINT `fund_products_fund_id_foreign` FOREIGN KEY (`fund_id`) REFERENCES `funds` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  ADD CONSTRAINT `fund_products_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Constraints for table `fund_providers`
--
ALTER TABLE `fund_providers`
  ADD CONSTRAINT `fund_providers_fund_id_foreign` FOREIGN KEY (`fund_id`) REFERENCES `funds` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  ADD CONSTRAINT `fund_providers_organization_id_foreign` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Constraints for table `fund_provider_chats`
--
ALTER TABLE `fund_provider_chats`
  ADD CONSTRAINT `fund_provider_chats_fund_provider_id_foreign` FOREIGN KEY (`fund_provider_id`) REFERENCES `fund_providers` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  ADD CONSTRAINT `fund_provider_chats_identity_address_foreign` FOREIGN KEY (`identity_address`) REFERENCES `identities` (`address`) ON DELETE CASCADE ON UPDATE RESTRICT,
  ADD CONSTRAINT `fund_provider_chats_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Constraints for table `fund_provider_chat_messages`
--
ALTER TABLE `fund_provider_chat_messages`
  ADD CONSTRAINT `fund_provider_chat_messages_fund_provider_chat_id_foreign` FOREIGN KEY (`fund_provider_chat_id`) REFERENCES `fund_provider_chats` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  ADD CONSTRAINT `fund_provider_chat_messages_identity_address_foreign` FOREIGN KEY (`identity_address`) REFERENCES `identities` (`address`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Constraints for table `fund_provider_product_exclusions`
--
ALTER TABLE `fund_provider_product_exclusions`
  ADD CONSTRAINT `fund_provider_product_exclusions_fund_provider_id_foreign` FOREIGN KEY (`fund_provider_id`) REFERENCES `fund_providers` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  ADD CONSTRAINT `fund_provider_product_exclusions_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Constraints for table `fund_request_clarifications`
--
ALTER TABLE `fund_request_clarifications`
  ADD CONSTRAINT `fund_request_clarifications_fund_request_record_id_foreign` FOREIGN KEY (`fund_request_record_id`) REFERENCES `fund_request_records` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Constraints for table `fund_request_records`
--
ALTER TABLE `fund_request_records`
  ADD CONSTRAINT `fund_request_records_fund_request_id_foreign` FOREIGN KEY (`fund_request_id`) REFERENCES `fund_requests` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Constraints for table `fund_top_ups`
--
ALTER TABLE `fund_top_ups`
  ADD CONSTRAINT `fund_top_ups_fund_id_foreign` FOREIGN KEY (`fund_id`) REFERENCES `funds` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Constraints for table `fund_top_up_transactions`
--
ALTER TABLE `fund_top_up_transactions`
  ADD CONSTRAINT `fund_top_up_transactions_fund_top_up_id_foreign` FOREIGN KEY (`fund_top_up_id`) REFERENCES `fund_top_ups` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Constraints for table `identity_emails`
--
ALTER TABLE `identity_emails`
  ADD CONSTRAINT `identity_emails_identity_address_foreign` FOREIGN KEY (`identity_address`) REFERENCES `identities` (`address`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Constraints for table `identity_proxies`
--
ALTER TABLE `identity_proxies`
  ADD CONSTRAINT `identity_proxies_identity_address_foreign` FOREIGN KEY (`identity_address`) REFERENCES `identities` (`address`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Constraints for table `media_presets`
--
ALTER TABLE `media_presets`
  ADD CONSTRAINT `media_sizes_media_id_foreign` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Constraints for table `notification_preferences`
--
ALTER TABLE `notification_preferences`
  ADD CONSTRAINT `notification_preferences_identity_address_foreign` FOREIGN KEY (`identity_address`) REFERENCES `identities` (`address`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Constraints for table `notification_templates`
--
ALTER TABLE `notification_templates`
  ADD CONSTRAINT `notification_templates_implementation_id_foreign` FOREIGN KEY (`implementation_id`) REFERENCES `implementations` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `notification_templates_system_notification_id_foreign` FOREIGN KEY (`system_notification_id`) REFERENCES `system_notifications` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `notification_tokens`
--
ALTER TABLE `notification_tokens`
  ADD CONSTRAINT `notification_tokens_identity_address_foreign` FOREIGN KEY (`identity_address`) REFERENCES `identities` (`address`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Constraints for table `offices`
--
ALTER TABLE `offices`
  ADD CONSTRAINT `offices_organization_id_foreign` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Constraints for table `office_schedules`
--
ALTER TABLE `office_schedules`
  ADD CONSTRAINT `office_schedules_office_id_foreign` FOREIGN KEY (`office_id`) REFERENCES `offices` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Constraints for table `organizations`
--
ALTER TABLE `organizations`
  ADD CONSTRAINT `organizations_business_type_id_foreign` FOREIGN KEY (`business_type_id`) REFERENCES `business_types` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  ADD CONSTRAINT `organizations_identity_address_foreign` FOREIGN KEY (`identity_address`) REFERENCES `identities` (`address`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Constraints for table `organization_validators`
--
ALTER TABLE `organization_validators`
  ADD CONSTRAINT `organization_validators_organization_id_foreign` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  ADD CONSTRAINT `organization_validators_validator_organization_id_foreign` FOREIGN KEY (`validator_organization_id`) REFERENCES `organizations` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Constraints for table `physical_cards`
--
ALTER TABLE `physical_cards`
  ADD CONSTRAINT `physical_cards_voucher_id_foreign` FOREIGN KEY (`voucher_id`) REFERENCES `vouchers` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Constraints for table `physical_card_requests`
--
ALTER TABLE `physical_card_requests`
  ADD CONSTRAINT `physical_card_requests_employee_id_foreign` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`) ON DELETE RESTRICT,
  ADD CONSTRAINT `physical_card_requests_voucher_id_foreign` FOREIGN KEY (`voucher_id`) REFERENCES `vouchers` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Constraints for table `prevalidations`
--
ALTER TABLE `prevalidations`
  ADD CONSTRAINT `prevalidations_identity_address_foreign` FOREIGN KEY (`identity_address`) REFERENCES `identities` (`address`) ON DELETE CASCADE ON UPDATE RESTRICT,
  ADD CONSTRAINT `prevalidations_redeemed_by_address_foreign` FOREIGN KEY (`redeemed_by_address`) REFERENCES `identities` (`address`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Constraints for table `prevalidation_records`
--
ALTER TABLE `prevalidation_records`
  ADD CONSTRAINT `prevalidation_records_prevalidation_id_foreign` FOREIGN KEY (`prevalidation_id`) REFERENCES `prevalidations` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  ADD CONSTRAINT `prevalidation_records_record_type_id_foreign` FOREIGN KEY (`record_type_id`) REFERENCES `record_types` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_organization_id_foreign` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  ADD CONSTRAINT `products_product_category_id_foreign` FOREIGN KEY (`product_category_id`) REFERENCES `product_categories` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Constraints for table `product_categories`
--
ALTER TABLE `product_categories`
  ADD CONSTRAINT `product_categories_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `product_categories` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  ADD CONSTRAINT `product_categories_root_id_foreign` FOREIGN KEY (`root_id`) REFERENCES `product_categories` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Constraints for table `product_category_translations`
--
ALTER TABLE `product_category_translations`
  ADD CONSTRAINT `product_category_translations_product_category_id_foreign` FOREIGN KEY (`product_category_id`) REFERENCES `product_categories` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Constraints for table `product_reservations`
--
ALTER TABLE `product_reservations`
  ADD CONSTRAINT `product_reservations_employee_id_foreign` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`) ON UPDATE RESTRICT,
  ADD CONSTRAINT `product_reservations_fund_provider_product_id_foreign` FOREIGN KEY (`fund_provider_product_id`) REFERENCES `fund_provider_products` (`id`) ON UPDATE RESTRICT,
  ADD CONSTRAINT `product_reservations_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON UPDATE RESTRICT,
  ADD CONSTRAINT `product_reservations_voucher_id_foreign` FOREIGN KEY (`voucher_id`) REFERENCES `vouchers` (`id`) ON UPDATE RESTRICT,
  ADD CONSTRAINT `product_reservations_voucher_transaction_id_foreign` FOREIGN KEY (`voucher_transaction_id`) REFERENCES `voucher_transactions` (`id`) ON UPDATE RESTRICT;

--
-- Constraints for table `records`
--
ALTER TABLE `records`
  ADD CONSTRAINT `records_identity_address_foreign` FOREIGN KEY (`identity_address`) REFERENCES `identities` (`address`) ON DELETE CASCADE ON UPDATE RESTRICT,
  ADD CONSTRAINT `records_prevalidation_id_foreign` FOREIGN KEY (`prevalidation_id`) REFERENCES `prevalidations` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  ADD CONSTRAINT `records_record_category_id_foreign` FOREIGN KEY (`record_category_id`) REFERENCES `record_categories` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  ADD CONSTRAINT `records_record_type_id_foreign` FOREIGN KEY (`record_type_id`) REFERENCES `record_types` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Constraints for table `record_categories`
--
ALTER TABLE `record_categories`
  ADD CONSTRAINT `record_categories_identity_address_foreign` FOREIGN KEY (`identity_address`) REFERENCES `identities` (`address`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Constraints for table `record_type_translations`
--
ALTER TABLE `record_type_translations`
  ADD CONSTRAINT `record_type_translations_record_type_id_foreign` FOREIGN KEY (`record_type_id`) REFERENCES `record_types` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Constraints for table `record_validations`
--
ALTER TABLE `record_validations`
  ADD CONSTRAINT `record_validations_identity_address_foreign` FOREIGN KEY (`identity_address`) REFERENCES `identities` (`address`) ON DELETE CASCADE ON UPDATE RESTRICT,
  ADD CONSTRAINT `record_validations_prevalidation_id_foreign` FOREIGN KEY (`prevalidation_id`) REFERENCES `prevalidations` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  ADD CONSTRAINT `record_validations_record_id_foreign` FOREIGN KEY (`record_id`) REFERENCES `records` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Constraints for table `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD CONSTRAINT `role_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  ADD CONSTRAINT `role_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Constraints for table `role_translations`
--
ALTER TABLE `role_translations`
  ADD CONSTRAINT `role_translations_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Constraints for table `session_requests`
--
ALTER TABLE `session_requests`
  ADD CONSTRAINT `session_requests_session_id_foreign` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Constraints for table `system_notification_configs`
--
ALTER TABLE `system_notification_configs`
  ADD CONSTRAINT `system_notification_configs_implementation_id_foreign` FOREIGN KEY (`implementation_id`) REFERENCES `implementations` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `system_notification_configs_system_notification_id_foreign` FOREIGN KEY (`system_notification_id`) REFERENCES `system_notifications` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `taggables`
--
ALTER TABLE `taggables`
  ADD CONSTRAINT `taggables_tag_id_foreign` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Constraints for table `vouchers`
--
ALTER TABLE `vouchers`
  ADD CONSTRAINT `vouchers_employee_id_foreign` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  ADD CONSTRAINT `vouchers_fund_backoffice_log_id_foreign` FOREIGN KEY (`fund_backoffice_log_id`) REFERENCES `fund_backoffice_logs` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  ADD CONSTRAINT `vouchers_fund_id_foreign` FOREIGN KEY (`fund_id`) REFERENCES `funds` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  ADD CONSTRAINT `vouchers_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `vouchers` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  ADD CONSTRAINT `vouchers_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  ADD CONSTRAINT `vouchers_product_reservation_id_foreign` FOREIGN KEY (`product_reservation_id`) REFERENCES `product_reservations` (`id`) ON UPDATE RESTRICT;

--
-- Constraints for table `voucher_relations`
--
ALTER TABLE `voucher_relations`
  ADD CONSTRAINT `voucher_relations_voucher_id_foreign` FOREIGN KEY (`voucher_id`) REFERENCES `vouchers` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Constraints for table `voucher_tokens`
--
ALTER TABLE `voucher_tokens`
  ADD CONSTRAINT `voucher_tokens_voucher_id_foreign` FOREIGN KEY (`voucher_id`) REFERENCES `vouchers` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Constraints for table `voucher_transactions`
--
ALTER TABLE `voucher_transactions`
  ADD CONSTRAINT `voucher_transactions_employee_id_foreign` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  ADD CONSTRAINT `voucher_transactions_organization_id_foreign` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  ADD CONSTRAINT `voucher_transactions_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  ADD CONSTRAINT `voucher_transactions_voucher_id_foreign` FOREIGN KEY (`voucher_id`) REFERENCES `vouchers` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  ADD CONSTRAINT `voucher_transactions_voucher_transaction_bulk_id_foreign` FOREIGN KEY (`voucher_transaction_bulk_id`) REFERENCES `voucher_transaction_bulks` (`id`) ON DELETE RESTRICT;

--
-- Constraints for table `voucher_transaction_bulks`
--
ALTER TABLE `voucher_transaction_bulks`
  ADD CONSTRAINT `voucher_transaction_bulks_bank_connection_id_foreign` FOREIGN KEY (`bank_connection_id`) REFERENCES `bank_connections` (`id`) ON DELETE RESTRICT;

--
-- Constraints for table `voucher_transaction_notes`
--
ALTER TABLE `voucher_transaction_notes`
  ADD CONSTRAINT `voucher_transaction_notes_voucher_transaction_id_foreign` FOREIGN KEY (`voucher_transaction_id`) REFERENCES `voucher_transactions` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
