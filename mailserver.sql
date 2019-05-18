-- phpMyAdmin SQL Dump
-- version 3.4.11.1deb2+deb7u6
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Nov 08, 2016 at 06:54 PM
-- Server version: 5.6.29
-- PHP Version: 5.6.27-1~dotdeb+7.1

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `mailserver`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE IF NOT EXISTS `admin` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `super` tinyint(1) NOT NULL DEFAULT '0',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `created` datetime NOT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `IX_Username_1` (`username`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `username`, `password`, `super`, `active`, `created`, `modified`) VALUES
(1, 'dps.lwk@gmail.com', '$2a$09$Jqk4ytnMgxmbQSgGscWRHOD.XVG1n87Bn9u6CRihTWvPErUKL.iiO', 1, 1, '2014-05-10 19:10:29', '2014-05-10 19:10:29'),
(2, 'daniel@dswann.co.uk', '$2a$09$UY90EBWP3QeXShD3EaX28un7liBZMHApJ2gKDMsAMOxEiPETwyeZG', 1, 1, '2014-05-10 19:21:45', NULL),
(3, 'jhayward1980@gmail.com', '$2a$09$rj46RKU7MkWzB8Y9rdl1OukGGWIiwXutifEJyIxDkV7JigMSV9Rny', 1, 1, '2014-05-14 19:41:45', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `admin_pref`
--

CREATE TABLE IF NOT EXISTS `admin_pref` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `attribute` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `ix` int(11) NOT NULL DEFAULT '0',
  `op` varchar(2) COLLATE utf8_unicode_ci NOT NULL DEFAULT ':=',
  `value` longtext COLLATE utf8_unicode_ci NOT NULL,
  `expire` bigint(20) NOT NULL DEFAULT '0',
  `Admin_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `IX_AdminPreference_1` (`Admin_id`,`attribute`,`ix`),
  KEY `IDX_814C1AD19D5DE046` (`Admin_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=10 ;

--
-- Dumping data for table `admin_pref`
--

INSERT INTO `admin_pref` (`id`, `attribute`, `ix`, `op`, `value`, `expire`, `Admin_id`) VALUES
(1, 'auth.last_login_from', 0, '=', '82.23.146.216', 0, 1),
(2, 'auth.last_login_at', 0, '=', '1478624067', 0, 1),
(3, 'version_last_check_at', 0, '=', '1478574143', 0, 1),
(4, 'auth.last_login_from', 0, '=', '2.127.33.218', 0, 2),
(5, 'auth.last_login_at', 0, '=', '1469724766', 0, 2),
(6, 'version_last_check_at', 0, '=', '1469724767', 0, 2),
(7, 'auth.last_login_from', 0, '=', '217.33.116.188', 0, 3),
(8, 'auth.last_login_at', 0, '=', '1471364810', 0, 3),
(9, 'version_last_check_at', 0, '=', '1471461402', 0, 3);

-- --------------------------------------------------------

--
-- Table structure for table `alias`
--

CREATE TABLE IF NOT EXISTS `alias` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `address` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `goto` longtext COLLATE utf8_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `created` datetime NOT NULL,
  `modified` datetime DEFAULT NULL,
  `Domain_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_E16C6B94D4E6F81` (`address`),
  KEY `IDX_E16C6B9493AE8C46` (`Domain_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=82 ;

--
-- Dumping data for table `alias`
--

INSERT INTO `alias` (`id`, `address`, `goto`, `active`, `created`, `modified`, `Domain_id`) VALUES
(6, 'dpslwk@andromeda.lwk.me', 'lwk@lwk.me', 1, '2014-05-10 19:48:45', '2014-05-30 09:53:23', 1),
(7, 'root@andromeda.lwk.me', 'lwk@lwk.me', 1, '2014-05-10 19:48:56', '2014-05-30 09:56:28', 1),
(8, 'lwk@lwk.me', 'lwk@lwk.me', 1, '2014-05-30 09:46:52', NULL, 2),
(9, 'dps.lwk@lwk.me', 'lwk@lwk.me', 1, '2014-05-30 09:56:58', NULL, 2),
(11, 'matt.lloyd@nottinghack.org.uk', 'matt.lloyd@nottinghack.org.uk', 1, '2014-06-19 08:41:09', NULL, 4),
(16, 'network@nottinghack.org.uk', 'network@nottinghack.org.uk,matt.lloyd@nottinghack.org.uk,daniel@dswann.co.uk', 1, '2014-06-19 09:00:04', '2014-06-19 09:01:09', 4),
(17, 'realm-admin@nottinghack.org.uk', 'network@nottinghack.org.uk', 1, '2014-06-19 09:16:13', NULL, 4),
(18, 'hostmaster@nottinghack.org.uk', 'network@nottinghack.org.uk', 1, '2014-06-19 09:19:33', NULL, 4),
(19, 'postmaster@nottinghack.org.uk', 'postmaster@nottinghack.org.uk', 1, '2014-06-19 11:02:48', NULL, 4),
(20, 'hostmaster@lwk.me', 'lwk@lwk.me', 1, '2014-06-19 11:17:13', NULL, 2),
(21, 'postmaster@lwk.me', 'postmaster@lwk.me', 1, '2014-06-19 11:22:27', NULL, 2),
(22, 'webmaster@nottinghack.org.uk', 'network@nottinghack.org.uk', 1, '2014-06-19 11:31:25', NULL, 4),
(23, 'info@nottinghack.org.uk', 'info@nottinghack.org.uk', 1, '2014-06-19 11:51:31', NULL, 4),
(24, 'paypal@nottinghack.org.uk', 'paypal@nottinghack.org.uk', 1, '2014-06-19 11:56:09', NULL, 4),
(25, 'donations@nottinghack.org.uk', 'donations@nottinghack.org.uk', 1, '2014-06-19 11:57:26', NULL, 4),
(26, 'bookings@nottinghack.org.uk', 'bookings@nottinghack.org.uk', 1, '2014-06-19 20:02:12', NULL, 4),
(27, 'comms@nottinghack.org.uk', 'comms@nottinghack.org.uk,jhayward1980@gmail.com,katebolin@gmail.com,sid351@gmail.com,leahhallissey@gmail.com,qpigeon@gmail.com,froggatt.a@gmail.com,sophie.r.wilkinson@gmail.com', 1, '2014-06-19 20:05:43', '2016-06-09 12:02:18', 4),
(28, 'ein@nottinghack.org.uk', 'ein@nottinghack.org.uk', 1, '2014-06-19 20:08:50', NULL, 4),
(29, 'github@nottinghack.org.uk', 'network@nottinghack.org.uk', 1, '2014-06-19 20:10:27', NULL, 4),
(30, 'group@nottinghack.org.uk', 'group@nottinghack.org.uk', 1, '2014-06-19 20:12:01', NULL, 4),
(31, 'holly@nottinghack.org.uk', 'holly@nottinghack.org.uk', 1, '2014-06-19 20:12:44', NULL, 4),
(32, 'laser@nottinghack.org.uk', 'laser@nottinghack.org.uk,jhayward1980@gmail.com,chickengrylls@gmail.com,howe@dr.com,andrew@aarmstrong.org,missmichellestrickland@gmail.com,jamesfowkes@gmail.com,matt@re-innovation.co.uk,adam.j.cooper@gmail.com,froggatt.a@gmail.com,ian@d1ckinson.com', 1, '2014-06-19 20:21:04', '2016-09-25 18:09:50', 4),
(33, 'membership@nottinghack.org.uk', 'membership@nottinghack.org.uk,katebolin@gmail.com,sophie.r.wilkinson@gmail.com,roberthunt87@gmail.com,matingslinkys@googlemail.com,froggatt.a@gmail.com,matthewg42@gmail.com,ian@d1ckinson.com,alexander.g.wells@gmail.com', 1, '2014-06-19 20:21:38', '2015-12-29 16:53:59', 4),
(34, 'newsletter@nottinghack.org.uk', 'newsletter@nottinghack.org.uk,katebolin@gmail.com,jhayward1980@gmail.com', 1, '2014-06-19 20:23:30', '2016-04-03 20:57:40', 4),
(35, 'resources@nottinghack.org.uk', 'drumdex@gmail.com,resources@nottinghack.org.uk,andrew@aarmstrong.org,russellh@russellh.net,martin.farraway@gmail.com,nick.baumer@gmail.com', 1, '2014-06-19 20:31:54', '2016-06-23 10:20:47', 4),
(36, 'safety@nottinghack.org.uk', 'safety@nottinghack.org.uk,jamesfowkes@gmail.com,msemtd@googlemail.com,andy@randomorbit.co.uk,sophie.r.wilkinson@gmail.com', 1, '2014-06-19 20:35:54', '2015-09-03 21:27:22', 4),
(37, 'software@nottinghack.org.uk', 'alexander.g.wells@gmail.com,software@nottinghack.org.uk,jhayward1980@gmail.com,roberthunt87@gmail.com,Daniel@dswann.co.uk,adam.j.cooper@gmail.com,jamesfowkes@gmail.com,jodi@jodiwarren.com,matt.lloyd@nottinghack.org.uk', 1, '2014-06-19 20:36:13', '2015-11-03 17:00:19', 4),
(38, 'tools@nottinghack.org.uk', 'trumpettom001@hotmail.com,tools@nottinghack.org.uk,congojoe@gmail.com,dclarke@cix.co.uk,hackspace@russellh.net,matt.lloyd@nottinghack.org.uk', 1, '2014-06-19 20:37:06', '2016-06-06 12:45:53', 4),
(39, 'trustees@nottinghack.org.uk', 'trustees@nottinghack.org.uk,matt.lloyd@nottinghack.org.uk,rob.hunt@nottinghack.org.uk,adam.froggatt@nottinghack.org.uk,kate.bolin@nottinghack.org.uk,russell.houghton@nottinghack.org.uk,james.hayward@nottinghack.org.uk,r0a8s9x0c5o4y4m9@nottinghamhackspace.slack.com,ian.dickinson@nottinghack.org.uk', 1, '2014-06-19 20:37:52', '2016-11-03 20:20:15', 4),
(40, 'david.clarke@nottinghack.org.uk', 'dclarke@cix.co.uk', 1, '2014-06-19 20:40:01', NULL, 4),
(41, 'david.hayward@nottinghack.org.uk', 'nachimir@gmail.com', 1, '2014-06-19 20:40:24', NULL, 4),
(42, 'dominic.morrow@nottinghack.org.uk', 'chickengrylls@gmail.com', 1, '2014-06-19 20:44:00', '2015-03-19 18:54:11', 4),
(43, 'gareth.howell@nottinghack.org.uk', 'garethdoodles@googlemail.com', 1, '2014-06-19 21:08:18', NULL, 4),
(44, 'jake.howe@nottinghack.org.uk', 'howe@dr.com', 1, '2014-06-19 21:08:37', NULL, 4),
(45, 'james.fowkes@nottinghack.org.uk', 'jamesfowkes@gmail.com', 1, '2014-06-19 21:08:58', NULL, 4),
(46, 'james.hayward@nottinghack.org.uk', 'jhayward1980@gmail.com', 1, '2014-06-19 21:09:20', NULL, 4),
(47, 'kate.bolin@nottinghack.org.uk', 'katebolin@gmail.com', 1, '2014-06-19 21:09:35', NULL, 4),
(48, 'daniel@nottinghack.org.uk', 'daniel@nottinghack.org.uk', 1, '2014-06-19 21:27:48', NULL, 4),
(49, 'realm-admin@lwk.me', 'lwk@lwk.me', 1, '2014-06-19 21:38:17', NULL, 2),
(50, 'hostmaster@andromeda.lwk.me', 'hostmaster@lwk.me', 1, '2014-06-19 21:38:41', NULL, 1),
(51, 'realm-admin@andromeda.lwk.me', 'realm-admin@lwk.me', 1, '2014-06-19 21:38:48', NULL, 1),
(52, 'postmater@andromeda.lwk.me', 'postmaster@lwk.me', 1, '2014-06-19 21:38:59', NULL, 1),
(53, 'matt@mjhosting.co.uk', 'lwk@lwk.me', 1, '2014-06-22 13:05:24', NULL, 5),
(54, 'snackspace@nottinghack.org.uk', 'snackspace@nottinghack.org.uk,sophie.r.wilkinson@gmail.com,daniel@dswann.co.uk,roberthunt87@gmail.com,froggatt.a@gmail.com,alexander.g.wells@gmail.com', 1, '2014-08-20 20:12:21', '2015-10-05 08:55:59', 4),
(55, 'talk@nottinghack.org.uk', 'talk@nottinghack.org.uk', 1, '2014-10-22 21:21:52', NULL, 4),
(56, 'maintainers@nottinghack.org.uk', 'maintainers@nottinghack.org.uk,chickengrylls@gmail.com,jhayward1980@gmail.com,jamesfowkes@gmail.com,adam.j.cooper@gmail.com,froggatt.a@gmail.com,ian@d1ckinson.com,martin.farraway@gmail.com,matt@re-innovation.co.uk', 1, '2015-04-20 12:19:03', '2016-10-17 21:15:41', 4),
(57, 'rob.hunt@nottinghack.org.uk', 'roberthunt87@gmail.com', 1, '2015-06-04 22:03:02', NULL, 4),
(58, 'sophie.wilkinson@nottinghack.org.uk', 'sophie.r.wilkinson@gmail.com', 1, '2015-06-04 22:04:17', NULL, 4),
(59, 'craft@nottinghack.org.uk', 'craft@nottinghack.org.uk,katebolin@gmail.com,sophie.r.wilkinson@gmail.com,garethdoodles@googlemail.com,kirkichi@gmail.com,vickiwinter@tiscali.co.uk,froggatt.a@gmail.com', 1, '2015-07-01 19:17:15', '2015-07-01 19:41:06', 4),
(60, 'opensource@nottinghack.org.uk', 'opensource@nottinghack.org.uk', 1, '2015-07-25 12:53:47', NULL, 4),
(61, 'adam.froggatt@nottinghack.org.uk', 'froggatt.a@gmail.com', 1, '2015-08-05 18:27:05', NULL, 4),
(62, 'events@nottinghack.org.uk', 'events@nottinghack.org.uk,trustees@nottinghack.org.uk', 1, '2015-09-03 21:10:33', '2016-06-09 12:01:43', 4),
(63, '3dprinting@nottinghack.org.uk', '3dprinting@nottinghack.org.uk,roberthunt87@gmail.com,martin.farraway@gmail.com', 1, '2015-09-03 21:10:56', '2016-05-22 14:41:21', 4),
(64, 'electronics@nottinghack.org.uk', 'electronics@nottinghack.org.uk,dclarke@cix.co.uk,matt@re-innovation.co.uk,jamesfowkes@gmail.com', 1, '2015-09-03 21:11:24', '2015-09-03 21:20:35', 4),
(65, 'infrastructure@nottinghack.org.uk', 'infrastructure@nottinghack.org.uk,dclarke@cix.co.uk,matt.lloyd@nottinghack.org.uk', 1, '2015-09-03 21:12:27', '2015-11-03 16:59:46', 4),
(66, 'metalworking@nottinghack.org.uk', 'metalworking@nottinghack.org.uk,hackspace@russellh.net,trumpettom001@hotmail.com,matt.lloyd@nottinghack.org.uk,paul.leivers@ntlworld.com,joshuaanthonykelly@gmail.com', 1, '2015-09-03 21:12:49', '2016-10-06 17:57:32', 4),
(67, 'woodworking@nottinghack.org.uk', 'woodworking@nottinghack.org.uk,dclarke@cix.co.uk', 1, '2015-09-03 21:13:17', '2015-09-03 21:22:51', 4),
(68, 'teams@nottinghack.org.uk', 'events@nottinghack.org.uk,3dprinting@nottinghack.org.uk,electronics@nottinghack.org.uk,infrastructure@nottinghack.org.uk,metalworking@nottinghack.org.uk,woodworking@nottinghack.org.uk,comms@nottinghack.org.uk,craft@nottinghack.org.uk,laser@nottinghack.org.uk,maintainers@nottinghack.org.uk,membership@nottinghack.org.uk,network@nottinghack.org.uk,newsletter@nottinghack.org.uk,resources@nottinghack.org.uk,safety@nottinghack.org.uk,snackspace@nottinghack.org.uk,software@nottinghack.org.uk,tools@nottinghack.org.uk', 1, '2015-09-03 21:32:53', NULL, 4),
(69, 'daniel.swann@nottinghack.org.uk', 'hs@dswann.co.uk', 1, '2015-09-14 18:33:49', NULL, 4),
(71, 'leah.hallissey@nottinghack.org.uk', 'leahhallissey@gmail.com', 1, '2015-12-13 16:07:25', NULL, 4),
(72, 'owen.ballentine@nottinghack.org.uk', 'sid351@gmail.com', 1, '2015-12-13 16:10:06', NULL, 4),
(74, 'fundraising@nottinghack.org.uk', 'fundraising@nottinghack.org.uk,froggatt.a@gmail.com', 1, '2016-02-07 19:51:12', '2016-02-28 20:32:02', 4),
(75, 'accounts@nottinghack.org.uk', 'accounts@nottinghack.org.uk,matt.lloyd@nottinghack.org.uk', 1, '2016-02-07 20:20:04', NULL, 4),
(76, 'sales@nottinghack.org.uk', 'trustees@nottinghack.org.uk', 1, '2016-03-10 22:41:11', NULL, 4),
(77, 'michael.erskine@nottinghack.org.uk', 'msemtd@googlemail.com', 1, '2016-05-24 17:39:00', NULL, 4),
(78, 'delivertogroup@nottinghack.org.uk', 'gardencity-uk@googlegroups.com', 1, '2016-06-18 13:33:09', NULL, 4),
(79, 'russell.houghton@nottinghack.org.uk', 'hackspace.russellh@gmail.com', 1, '2016-07-28 23:04:47', '2016-07-30 19:05:24', 4),
(80, 'wirelessthings@lwk.me', 'wirelessthings@lwk.me', 1, '2016-09-05 18:00:57', NULL, 2),
(81, 'ian.dickinson@nottinghack.org.uk', 'ian@d1ckinson.com', 1, '2016-11-03 20:19:59', NULL, 4);

-- --------------------------------------------------------

--
-- Table structure for table `alias_pref`
--

CREATE TABLE IF NOT EXISTS `alias_pref` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `attribute` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `ix` int(11) NOT NULL DEFAULT '0',
  `op` varchar(2) COLLATE utf8_unicode_ci NOT NULL DEFAULT ':=',
  `value` longtext COLLATE utf8_unicode_ci NOT NULL,
  `expire` bigint(20) NOT NULL DEFAULT '0',
  `Alias_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_3279E911A72028B4` (`Alias_id`),
  KEY `IX_AliasPreference_1` (`Alias_id`,`attribute`,`ix`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `archive`
--

CREATE TABLE IF NOT EXISTS `archive` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `status` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `archived_at` datetime NOT NULL,
  `status_changed_at` datetime NOT NULL,
  `homedir_server` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `homedir_file` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `homedir_orig_size` bigint(20) DEFAULT NULL,
  `homedir_size` bigint(20) DEFAULT NULL,
  `maildir_server` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `maildir_file` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `maildir_orig_size` bigint(20) DEFAULT NULL,
  `maildir_size` bigint(20) DEFAULT NULL,
  `data` longtext COLLATE utf8_unicode_ci NOT NULL,
  `Domain_id` bigint(20) DEFAULT NULL,
  `Admin_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_D5FC5D9CF85E0677` (`username`),
  KEY `IDX_D5FC5D9C93AE8C46` (`Domain_id`),
  KEY `IDX_D5FC5D9C9D5DE046` (`Admin_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `dbversion`
--

CREATE TABLE IF NOT EXISTS `dbversion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `applied_on` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Dumping data for table `dbversion`
--

INSERT INTO `dbversion` (`id`, `version`, `name`, `applied_on`) VALUES
(1, 1, 'Venus', '2014-05-10 19:10:29');

-- --------------------------------------------------------

--
-- Table structure for table `directory_entry`
--

CREATE TABLE IF NOT EXISTS `directory_entry` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mailbox_id` bigint(20) NOT NULL,
  `businessCategory` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `carLicense` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `departmentNumber` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `displayName` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `employeeNumber` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `employeeType` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `homePhone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `homePostalAddress` longtext COLLATE utf8_unicode_ci,
  `initials` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `jpegPhoto` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:object)',
  `labeledURI` longtext COLLATE utf8_unicode_ci,
  `mail` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `manager` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mobile` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `o` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pager` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `preferredLanguage` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `roomNumber` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `secretary` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `personalTitle` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sn` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ou` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `facsimileTelephoneNumber` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `givenName` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `telephoneNumber` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `vimb_created` datetime NOT NULL,
  `vimb_update` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_6553C92D66EC35CC` (`mailbox_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `domain`
--

CREATE TABLE IF NOT EXISTS `domain` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `domain` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `max_aliases` int(11) NOT NULL DEFAULT '0',
  `alias_count` bigint(20) NOT NULL DEFAULT '0',
  `max_mailboxes` int(11) NOT NULL DEFAULT '0',
  `mailbox_count` bigint(20) NOT NULL DEFAULT '0',
  `max_quota` bigint(20) NOT NULL DEFAULT '0',
  `quota` bigint(20) NOT NULL DEFAULT '0',
  `transport` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'virtual',
  `backupmx` tinyint(1) NOT NULL DEFAULT '0',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `homedir` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `maildir` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uid` int(11) DEFAULT NULL,
  `gid` int(11) DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `IX_Domain_1` (`domain`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=6 ;

--
-- Dumping data for table `domain`
--

INSERT INTO `domain` (`id`, `domain`, `description`, `max_aliases`, `alias_count`, `max_mailboxes`, `mailbox_count`, `max_quota`, `quota`, `transport`, `backupmx`, `active`, `homedir`, `maildir`, `uid`, `gid`, `created`, `modified`) VALUES
(1, 'andromeda.lwk.me', '', 0, 5, 0, 0, 0, 0, 'virtual', 0, 1, NULL, NULL, NULL, NULL, '2014-05-10 19:18:28', '2014-05-10 19:26:35'),
(2, 'lwk.me', '', 0, 3, 0, 3, 0, 0, 'virtual', 0, 1, NULL, NULL, NULL, NULL, '2014-05-10 19:18:35', NULL),
(4, 'nottinghack.org.uk', '', 0, 24, 0, 33, 0, 0, 'virtual', 0, 1, NULL, NULL, NULL, NULL, '2014-05-14 19:43:48', NULL),
(5, 'mjhosting.co.uk', '', 0, 1, 0, 0, 0, 0, 'virtual', 0, 1, NULL, NULL, NULL, NULL, '2014-06-22 13:05:12', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `domain_admins`
--

CREATE TABLE IF NOT EXISTS `domain_admins` (
  `Admin_id` bigint(20) NOT NULL,
  `Domain_id` bigint(20) NOT NULL,
  PRIMARY KEY (`Admin_id`,`Domain_id`),
  KEY `IDX_CD8319C69D5DE046` (`Admin_id`),
  KEY `IDX_CD8319C693AE8C46` (`Domain_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `domain_pref`
--

CREATE TABLE IF NOT EXISTS `domain_pref` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `attribute` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `ix` int(11) NOT NULL DEFAULT '0',
  `op` varchar(2) COLLATE utf8_unicode_ci NOT NULL DEFAULT ':=',
  `value` longtext COLLATE utf8_unicode_ci NOT NULL,
  `expire` bigint(20) NOT NULL DEFAULT '0',
  `Domain_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_C89B55693AE8C46` (`Domain_id`),
  KEY `IX_DomainPreference_1` (`Domain_id`,`attribute`,`ix`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `log`
--

CREATE TABLE IF NOT EXISTS `log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `action` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `data` longtext COLLATE utf8_unicode_ci,
  `timestamp` datetime NOT NULL,
  `Admin_id` bigint(20) DEFAULT NULL,
  `Domain_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_8F3F68C59D5DE046` (`Admin_id`),
  KEY `IDX_8F3F68C593AE8C46` (`Domain_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=216 ;

--
-- Dumping data for table `log`
--

INSERT INTO `log` (`id`, `action`, `data`, `timestamp`, `Admin_id`, `Domain_id`) VALUES
(1, 'DOMAIN_ADD', 'dps.lwk@gmail.com  added domain andromeda.lwk.me', '2014-05-10 19:18:28', 1, 1),
(2, 'DOMAIN_ADD', 'dps.lwk@gmail.com  added domain lwk.me', '2014-05-10 19:18:35', 1, 2),
(4, 'MAILBOX_ADD', 'dps.lwk@gmail.com  added mailbox dpslwk@andromeda.lwk.me', '2014-05-10 19:19:04', 1, 1),
(5, 'ALIAS_ADD', 'dps.lwk@gmail.com  added alias root@andromeda.lwk.me', '2014-05-10 19:19:24', 1, 1),
(6, 'ADMIN_ADD', 'dps.lwk@gmail.com added admin daniel@dswann.co.uk', '2014-05-10 19:21:45', 1, NULL),
(7, 'DOMAIN_DEACTIVATE', 'daniel@dswann.co.uk deactivated domain andromeda.lwk.me', '2014-05-10 19:26:33', 2, 1),
(8, 'DOMAIN_ACTIVATE', 'daniel@dswann.co.uk activated domain andromeda.lwk.me', '2014-05-10 19:26:34', 2, 1),
(9, 'DOMAIN_DEACTIVATE', 'daniel@dswann.co.uk deactivated domain andromeda.lwk.me', '2014-05-10 19:26:35', 2, 1),
(10, 'DOMAIN_ACTIVATE', 'daniel@dswann.co.uk activated domain andromeda.lwk.me', '2014-05-10 19:26:35', 2, 1),
(11, 'MAILBOX_ADD', 'dps.lwk@gmail.com  added mailbox dpslwk@lwk.me', '2014-05-10 19:38:42', 1, 2),
(12, 'ALIAS_EDIT', 'dps.lwk@gmail.com  edited alias root@andromeda.lwk.me', '2014-05-10 19:39:04', 1, 1),
(13, 'MAILBOX_PURGE', 'dps.lwk@gmail.com purged mailbox dpslwk@andromeda.lwk.me', '2014-05-10 19:39:28', 1, 1),
(14, 'ALIAS_ADD', 'dps.lwk@gmail.com  added alias dpslwk@andromeda.lwk.me', '2014-05-10 19:39:37', 1, 1),
(15, 'MAILBOX_ADD', 'dps.lwk@gmail.com  added mailbox dps.lwk@lwk.me', '2014-05-10 19:48:25', 1, 2),
(16, 'MAILBOX_PURGE', 'dps.lwk@gmail.com purged mailbox dpslwk@lwk.me', '2014-05-10 19:48:34', 1, 2),
(17, 'ALIAS_ADD', 'dps.lwk@gmail.com  added alias dpslwk@andromeda.lwk.me', '2014-05-10 19:48:45', 1, 1),
(18, 'ALIAS_ADD', 'dps.lwk@gmail.com  added alias root@andromeda.lwk.me', '2014-05-10 19:48:56', 1, 1),
(19, 'ADMIN_ADD', 'dps.lwk@gmail.com added admin jhayward1980@gmail.com', '2014-05-14 19:41:45', 1, NULL),
(20, 'DOMAIN_ADD', 'dps.lwk@gmail.com  added domain nottinghack.org.uk', '2014-05-14 19:43:48', 1, 4),
(21, 'ALIAS_EDIT', 'dps.lwk@gmail.com  edited alias root@andromeda.lwk.me', '2014-05-14 19:46:25', 1, 1),
(22, 'ALIAS_EDIT', 'jhayward1980@gmail.com  edited alias root@andromeda.lwk.me', '2014-05-14 20:31:14', 3, 1),
(23, 'MAILBOX_PW_CHANGE', 'dps.lwk@gmail.com changed password for mailbox dps.lwk@lwk.me', '2014-05-28 08:03:30', 1, 2),
(24, 'MAILBOX_PW_CHANGE', 'dps.lwk@gmail.com changed password for mailbox dps.lwk@lwk.me', '2014-05-28 10:18:46', 1, 2),
(25, 'MAILBOX_PW_CHANGE', 'dps.lwk@gmail.com changed password for mailbox dps.lwk@lwk.me', '2014-05-28 10:21:38', 1, 2),
(26, 'MAILBOX_EDIT', 'dps.lwk@gmail.com  edited mailbox dps.lwk@lwk.me', '2014-05-30 09:45:17', 1, 2),
(27, 'MAILBOX_EDIT', 'dps.lwk@gmail.com  edited mailbox dps.lwk@lwk.me', '2014-05-30 09:45:39', 1, 2),
(28, 'MAILBOX_ADD', 'dps.lwk@gmail.com  added mailbox lwk@lwk.me', '2014-05-30 09:46:52', 1, 2),
(29, 'ALIAS_EDIT', 'dps.lwk@gmail.com  edited alias dpslwk@andromeda.lwk.me', '2014-05-30 09:53:23', 1, 1),
(30, 'ALIAS_EDIT', 'dps.lwk@gmail.com  edited alias root@andromeda.lwk.me', '2014-05-30 09:56:24', 1, 1),
(31, 'ALIAS_EDIT', 'dps.lwk@gmail.com  edited alias root@andromeda.lwk.me', '2014-05-30 09:56:28', 1, 1),
(32, 'MAILBOX_PURGE', 'dps.lwk@gmail.com purged mailbox dps.lwk@lwk.me', '2014-05-30 09:56:43', 1, 2),
(33, 'ALIAS_ADD', 'dps.lwk@gmail.com  added alias dps.lwk@lwk.me', '2014-05-30 09:56:58', 1, 2),
(34, 'MAILBOX_ADD', 'dps.lwk@gmail.com  added mailbox network@nottinghack.org.uk', '2014-06-19 08:38:19', 1, 4),
(35, 'MAILBOX_ADD', 'dps.lwk@gmail.com  added mailbox matt.lloyd@nottinghack.org.uk', '2014-06-19 08:41:09', 1, 4),
(36, 'ALIAS_ADD', 'dps.lwk@gmail.com  added alias realm-admin.nottinghack@nottinghack.org.uk', '2014-06-19 08:47:56', 1, 4),
(37, 'ALIAS_DELETE', 'dps.lwk@gmail.com removed alias realm-admin.nottinghack@nottinghack.org.uk', '2014-06-19 08:48:07', 1, 4),
(38, 'ALIAS_ADD', 'dps.lwk@gmail.com  added alias realm-admin@nottinghack.org.uk', '2014-06-19 08:48:17', 1, 4),
(39, 'MAILBOX_PURGE', 'dps.lwk@gmail.com purged mailbox network@nottinghack.org.uk', '2014-06-19 08:57:02', 1, 4),
(40, 'ALIAS_ADD', 'dps.lwk@gmail.com  added alias network@nottinghack.org.uk', '2014-06-19 08:57:58', 1, 4),
(42, 'ALIAS_DELETE', 'dps.lwk@gmail.com removed alias network@nottinghack.org.uk', '2014-06-19 08:59:02', 1, 4),
(43, 'MAILBOX_ADD', 'dps.lwk@gmail.com  added mailbox network@nottinghack.org.uk', '2014-06-19 09:00:04', 1, 4),
(44, 'ALIAS_EDIT', 'dps.lwk@gmail.com  edited alias network@nottinghack.org.uk', '2014-06-19 09:01:05', 1, 4),
(45, 'ALIAS_EDIT', 'dps.lwk@gmail.com  edited alias network@nottinghack.org.uk', '2014-06-19 09:01:09', 1, 4),
(46, 'ALIAS_ADD', 'dps.lwk@gmail.com  added alias realm-admin@nottinghack.org.uk', '2014-06-19 09:16:13', 1, 4),
(47, 'ALIAS_ADD', 'dps.lwk@gmail.com  added alias hostmaster@nottinghack.org.uk', '2014-06-19 09:19:33', 1, 4),
(48, 'MAILBOX_ADD', 'dps.lwk@gmail.com  added mailbox postmaster@nottinghack.org.uk', '2014-06-19 11:02:48', 1, 4),
(49, 'ALIAS_ADD', 'dps.lwk@gmail.com  added alias hostmaster@lwk.me', '2014-06-19 11:17:13', 1, 2),
(50, 'MAILBOX_ADD', 'dps.lwk@gmail.com  added mailbox postmaster@lwk.me', '2014-06-19 11:22:27', 1, 2),
(51, 'ALIAS_ADD', 'dps.lwk@gmail.com  added alias webmaster@nottinghack.org.uk', '2014-06-19 11:31:25', 1, 4),
(52, 'MAILBOX_ADD', 'dps.lwk@gmail.com  added mailbox info@nottinghack.org.uk', '2014-06-19 11:51:31', 1, 4),
(53, 'MAILBOX_ADD', 'dps.lwk@gmail.com  added mailbox paypal@nottinghack.org.uk', '2014-06-19 11:56:09', 1, 4),
(54, 'MAILBOX_ADD', 'dps.lwk@gmail.com  added mailbox donations@nottinghack.org.uk', '2014-06-19 11:57:26', 1, 4),
(55, 'MAILBOX_ADD', 'dps.lwk@gmail.com  added mailbox bookings@nottinghack.org.uk', '2014-06-19 20:02:12', 1, 4),
(56, 'MAILBOX_ADD', 'dps.lwk@gmail.com  added mailbox comms@nottinghack.org.uk', '2014-06-19 20:05:43', 1, 4),
(57, 'MAILBOX_ADD', 'dps.lwk@gmail.com  added mailbox ein@nottinghack.org.uk', '2014-06-19 20:08:50', 1, 4),
(58, 'ALIAS_ADD', 'dps.lwk@gmail.com  added alias github@nottinghack.org.uk', '2014-06-19 20:10:27', 1, 4),
(59, 'MAILBOX_ADD', 'dps.lwk@gmail.com  added mailbox group@nottinghack.org.uk', '2014-06-19 20:12:01', 1, 4),
(60, 'MAILBOX_ADD', 'dps.lwk@gmail.com  added mailbox holly@nottinghack.org.uk', '2014-06-19 20:12:44', 1, 4),
(61, 'MAILBOX_EDIT', 'dps.lwk@gmail.com  edited mailbox holly@nottinghack.org.uk', '2014-06-19 20:14:12', 1, 4),
(62, 'MAILBOX_EDIT', 'dps.lwk@gmail.com  edited mailbox holly@nottinghack.org.uk', '2014-06-19 20:14:19', 1, 4),
(63, 'MAILBOX_ADD', 'dps.lwk@gmail.com  added mailbox laser@nottinghack.org.uk', '2014-06-19 20:21:04', 1, 4),
(64, 'MAILBOX_ADD', 'dps.lwk@gmail.com  added mailbox membership@nottinghack.org.uk', '2014-06-19 20:21:38', 1, 4),
(65, 'MAILBOX_ADD', 'dps.lwk@gmail.com  added mailbox newsletter@nottinghack.org.uk', '2014-06-19 20:23:30', 1, 4),
(66, 'MAILBOX_ADD', 'dps.lwk@gmail.com  added mailbox resources@nottinghack.org.uk', '2014-06-19 20:31:54', 1, 4),
(67, 'MAILBOX_ADD', 'dps.lwk@gmail.com  added mailbox safety@nottinghack.org.uk', '2014-06-19 20:35:54', 1, 4),
(68, 'MAILBOX_ADD', 'dps.lwk@gmail.com  added mailbox software@nottinghack.org.uk', '2014-06-19 20:36:13', 1, 4),
(69, 'MAILBOX_ADD', 'dps.lwk@gmail.com  added mailbox tools@nottinghack.org.uk', '2014-06-19 20:37:06', 1, 4),
(70, 'MAILBOX_ADD', 'dps.lwk@gmail.com  added mailbox trustees@nottinghack.org.uk', '2014-06-19 20:37:52', 1, 4),
(71, 'ALIAS_ADD', 'dps.lwk@gmail.com  added alias david.clarke@nottinghack.org.uk', '2014-06-19 20:40:01', 1, 4),
(72, 'ALIAS_ADD', 'dps.lwk@gmail.com  added alias david.hayward@nottinghack.org.uk', '2014-06-19 20:40:24', 1, 4),
(73, 'ALIAS_ADD', 'dps.lwk@gmail.com  added alias dominic.morrow@nottinghack.org.uk', '2014-06-19 20:44:00', 1, 4),
(74, 'ALIAS_ADD', 'dps.lwk@gmail.com  added alias gareth.howell@nottinghack.org.uk', '2014-06-19 21:08:18', 1, 4),
(75, 'ALIAS_ADD', 'dps.lwk@gmail.com  added alias jake.howe@nottinghack.org.uk', '2014-06-19 21:08:37', 1, 4),
(76, 'ALIAS_ADD', 'dps.lwk@gmail.com  added alias james.fowkes@nottinghack.org.uk', '2014-06-19 21:08:59', 1, 4),
(77, 'ALIAS_ADD', 'dps.lwk@gmail.com  added alias james.hayward@nottinghack.org.uk', '2014-06-19 21:09:20', 1, 4),
(78, 'ALIAS_ADD', 'dps.lwk@gmail.com  added alias kate.bolin@nottinghack.org.uk', '2014-06-19 21:09:35', 1, 4),
(79, 'MAILBOX_ADD', 'dps.lwk@gmail.com  added mailbox daniel@nottinghack.org.uk', '2014-06-19 21:27:48', 1, 4),
(80, 'MAILBOX_EDIT', 'dps.lwk@gmail.com  edited mailbox bookings@nottinghack.org.uk', '2014-06-19 21:35:47', 1, 4),
(81, 'MAILBOX_EDIT', 'dps.lwk@gmail.com  edited mailbox group@nottinghack.org.uk', '2014-06-19 21:36:28', 1, 4),
(82, 'ALIAS_ADD', 'dps.lwk@gmail.com  added alias realm-admin@lwk.me', '2014-06-19 21:38:17', 1, 2),
(83, 'ALIAS_ADD', 'dps.lwk@gmail.com  added alias hostmaster@andromeda.lwk.me', '2014-06-19 21:38:41', 1, 1),
(84, 'ALIAS_ADD', 'dps.lwk@gmail.com  added alias realm-admin@andromeda.lwk.me', '2014-06-19 21:38:48', 1, 1),
(85, 'ALIAS_ADD', 'dps.lwk@gmail.com  added alias postmater@andromeda.lwk.me', '2014-06-19 21:38:59', 1, 1),
(86, 'DOMAIN_ADD', 'dps.lwk@gmail.com  added domain mjhosting.co.uk', '2014-06-22 13:05:12', 1, 5),
(87, 'ALIAS_ADD', 'dps.lwk@gmail.com  added alias matt@mjhosting.co.uk', '2014-06-22 13:05:24', 1, 5),
(88, 'MAILBOX_PW_CHANGE', 'daniel@dswann.co.uk changed password for mailbox daniel@nottinghack.org.uk', '2014-06-22 15:05:01', 2, 4),
(89, 'ALIAS_EDIT', 'dps.lwk@gmail.com  edited alias membership@nottinghack.org.uk', '2014-08-18 15:11:22', 1, 4),
(90, 'MAILBOX_ADD', 'dps.lwk@gmail.com  added mailbox snackspace@nottinghack.org.uk', '2014-08-20 20:12:21', 1, 4),
(91, 'ALIAS_EDIT', 'dps.lwk@gmail.com  edited alias snackspace@nottinghack.org.uk', '2014-08-20 20:17:28', 1, 4),
(92, 'ALIAS_EDIT', 'jhayward1980@gmail.com  edited alias tools@nottinghack.org.uk', '2014-10-04 12:02:33', 3, 4),
(93, 'ALIAS_EDIT', 'jhayward1980@gmail.com  edited alias resources@nottinghack.org.uk', '2014-10-04 12:02:46', 3, 4),
(94, 'ALIAS_EDIT', 'jhayward1980@gmail.com  edited alias membership@nottinghack.org.uk', '2014-10-04 12:03:31', 3, 4),
(95, 'ALIAS_EDIT', 'jhayward1980@gmail.com  edited alias membership@nottinghack.org.uk', '2014-10-04 12:03:33', 3, 4),
(96, 'ALIAS_EDIT', 'jhayward1980@gmail.com  edited alias safety@nottinghack.org.uk', '2014-10-04 12:04:00', 3, 4),
(97, 'ALIAS_EDIT', 'dps.lwk@gmail.com  edited alias resources@nottinghack.org.uk', '2014-10-08 09:51:05', 1, 4),
(98, 'ALIAS_EDIT', 'jhayward1980@gmail.com  edited alias membership@nottinghack.org.uk', '2014-10-16 20:09:51', 3, 4),
(99, 'ALIAS_EDIT', 'jhayward1980@gmail.com  edited alias software@nottinghack.org.uk', '2014-10-16 20:10:53', 3, 4),
(100, 'MAILBOX_ADD', 'jhayward1980@gmail.com  added mailbox talk@nottinghack.org.uk', '2014-10-22 21:21:52', 3, 4),
(101, 'MAILBOX_PW_CHANGE', 'jhayward1980@gmail.com changed password for mailbox talk@nottinghack.org.uk', '2014-10-22 21:53:51', 3, 4),
(102, 'MAILBOX_PW_CHANGE', 'jhayward1980@gmail.com changed password for mailbox talk@nottinghack.org.uk', '2014-10-22 22:09:00', 3, 4),
(103, 'ALIAS_EDIT', 'daniel@dswann.co.uk  edited alias snackspace@nottinghack.org.uk', '2015-01-08 18:15:50', 2, 4),
(104, 'ALIAS_EDIT', 'jhayward1980@gmail.com  edited alias laser@nottinghack.org.uk', '2015-03-12 17:07:04', 3, 4),
(105, 'ALIAS_EDIT', 'dps.lwk@gmail.com  edited alias dominic.morrow@nottinghack.org.uk', '2015-03-19 18:54:11', 1, 4),
(106, 'ALIAS_EDIT', 'dps.lwk@gmail.com  edited alias snackspace@nottinghack.org.uk', '2015-03-19 18:55:32', 1, 4),
(107, 'MAILBOX_ADD', 'dps.lwk@gmail.com  added mailbox maintainers@nottinghack.org.uk', '2015-04-20 12:19:03', 1, 4),
(108, 'ALIAS_EDIT', 'dps.lwk@gmail.com  edited alias maintainers@nottinghack.org.uk', '2015-04-20 12:22:31', 1, 4),
(109, 'ALIAS_ADD', 'dps.lwk@gmail.com  added alias rob.hunt@nottinghack.org.uk', '2015-06-04 22:03:02', 1, 4),
(110, 'ALIAS_ADD', 'dps.lwk@gmail.com  added alias sophie.wilkinson@nottinghack.org.uk', '2015-06-04 22:04:17', 1, 4),
(111, 'ALIAS_EDIT', 'dps.lwk@gmail.com  edited alias trustees@nottinghack.org.uk', '2015-06-04 22:05:30', 1, 4),
(112, 'ALIAS_EDIT', 'dps.lwk@gmail.com  edited alias trustees@nottinghack.org.uk', '2015-06-24 15:02:47', 1, 4),
(113, 'ALIAS_EDIT', 'dps.lwk@gmail.com  edited alias membership@nottinghack.org.uk', '2015-06-24 15:03:36', 1, 4),
(114, 'ALIAS_EDIT', 'dps.lwk@gmail.com  edited alias membership@nottinghack.org.uk', '2015-07-01 17:56:39', 1, 4),
(115, 'MAILBOX_ADD', 'dps.lwk@gmail.com  added mailbox craft@nottinghack.org.uk', '2015-07-01 19:17:15', 1, 4),
(116, 'ALIAS_EDIT', 'dps.lwk@gmail.com  edited alias craft@nottinghack.org.uk', '2015-07-01 19:41:06', 1, 4),
(117, 'MAILBOX_ADD', 'dps.lwk@gmail.com  added mailbox opensource@nottinghack.org.uk', '2015-07-25 12:53:47', 1, 4),
(118, 'ALIAS_ADD', 'jhayward1980@gmail.com  added alias adam.froggatt@nottinghack.org.uk', '2015-08-05 18:27:05', 3, 4),
(119, 'ALIAS_EDIT', 'jhayward1980@gmail.com  edited alias trustees@nottinghack.org.uk', '2015-08-05 18:27:34', 3, 4),
(120, 'ALIAS_EDIT', 'jhayward1980@gmail.com  edited alias laser@nottinghack.org.uk', '2015-08-07 10:08:51', 3, 4),
(121, 'ALIAS_EDIT', 'dps.lwk@gmail.com  edited alias resources@nottinghack.org.uk', '2015-08-18 20:23:52', 1, 4),
(122, 'ALIAS_EDIT', 'dps.lwk@gmail.com  edited alias tools@nottinghack.org.uk', '2015-08-18 20:25:10', 1, 4),
(123, 'ALIAS_EDIT', 'dps.lwk@gmail.com  edited alias membership@nottinghack.org.uk', '2015-08-26 17:46:06', 1, 4),
(124, 'MAILBOX_ADD', 'jhayward1980@gmail.com  added mailbox events@nottinghack.org.uk', '2015-09-03 21:10:33', 3, 4),
(125, 'MAILBOX_ADD', 'jhayward1980@gmail.com  added mailbox 3dprinting@nottinghack.org.uk', '2015-09-03 21:10:56', 3, 4),
(126, 'MAILBOX_ADD', 'jhayward1980@gmail.com  added mailbox electronics@nottinghack.org.uk', '2015-09-03 21:11:24', 3, 4),
(127, 'MAILBOX_ADD', 'jhayward1980@gmail.com  added mailbox infrastructure@nottinghack.org.uk', '2015-09-03 21:12:27', 3, 4),
(128, 'MAILBOX_ADD', 'jhayward1980@gmail.com  added mailbox metalworking@nottinghack.org.uk', '2015-09-03 21:12:49', 3, 4),
(129, 'MAILBOX_ADD', 'jhayward1980@gmail.com  added mailbox woodworking@nottinghack.org.uk', '2015-09-03 21:13:17', 3, 4),
(130, 'ALIAS_EDIT', 'jhayward1980@gmail.com  edited alias events@nottinghack.org.uk', '2015-09-03 21:16:39', 3, 4),
(131, 'MAILBOX_EDIT', 'jhayward1980@gmail.com  edited mailbox events@nottinghack.org.uk', '2015-09-03 21:17:00', 3, 4),
(132, 'ALIAS_EDIT', 'jhayward1980@gmail.com  edited alias 3dprinting@nottinghack.org.uk', '2015-09-03 21:19:55', 3, 4),
(133, 'ALIAS_EDIT', 'jhayward1980@gmail.com  edited alias electronics@nottinghack.org.uk', '2015-09-03 21:20:35', 3, 4),
(134, 'ALIAS_EDIT', 'jhayward1980@gmail.com  edited alias infrastructure@nottinghack.org.uk', '2015-09-03 21:21:50', 3, 4),
(135, 'ALIAS_EDIT', 'jhayward1980@gmail.com  edited alias metalworking@nottinghack.org.uk', '2015-09-03 21:22:35', 3, 4),
(136, 'ALIAS_EDIT', 'jhayward1980@gmail.com  edited alias woodworking@nottinghack.org.uk', '2015-09-03 21:22:51', 3, 4),
(137, 'ALIAS_EDIT', 'jhayward1980@gmail.com  edited alias laser@nottinghack.org.uk', '2015-09-03 21:25:57', 3, 4),
(138, 'ALIAS_EDIT', 'jhayward1980@gmail.com  edited alias maintainers@nottinghack.org.uk', '2015-09-03 21:26:34', 3, 4),
(139, 'ALIAS_EDIT', 'jhayward1980@gmail.com  edited alias resources@nottinghack.org.uk', '2015-09-03 21:27:10', 3, 4),
(140, 'ALIAS_EDIT', 'jhayward1980@gmail.com  edited alias safety@nottinghack.org.uk', '2015-09-03 21:27:22', 3, 4),
(141, 'ALIAS_EDIT', 'jhayward1980@gmail.com  edited alias software@nottinghack.org.uk', '2015-09-03 21:27:40', 3, 4),
(142, 'ALIAS_EDIT', 'jhayward1980@gmail.com  edited alias tools@nottinghack.org.uk', '2015-09-03 21:27:58', 3, 4),
(143, 'ALIAS_ADD', 'jhayward1980@gmail.com  added alias teams@nottinghack.org.uk', '2015-09-03 21:32:53', 3, 4),
(144, 'ALIAS_EDIT', 'daniel@dswann.co.uk  edited alias software@nottinghack.org.uk', '2015-09-07 20:31:04', 2, 4),
(145, 'ALIAS_EDIT', 'jhayward1980@gmail.com  edited alias software@nottinghack.org.uk', '2015-09-07 20:42:05', 3, 4),
(146, 'ALIAS_EDIT', 'jhayward1980@gmail.com  edited alias maintainers@nottinghack.org.uk', '2015-09-08 08:35:56', 3, 4),
(147, 'ALIAS_ADD', 'dps.lwk@gmail.com  added alias daniel.swann@nottinghack.org.uk', '2015-09-14 18:33:50', 1, 4),
(148, 'ALIAS_EDIT', 'dps.lwk@gmail.com  edited alias trustees@nottinghack.org.uk', '2015-09-15 20:20:51', 1, 4),
(149, 'ALIAS_EDIT', 'dps.lwk@gmail.com  edited alias trustees@nottinghack.org.uk', '2015-09-15 20:20:55', 1, 4),
(150, 'MAILBOX_PW_CHANGE', 'dps.lwk@gmail.com changed password for mailbox events@nottinghack.org.uk', '2015-10-04 16:45:39', 1, 4),
(151, 'ALIAS_EDIT', 'jhayward1980@gmail.com  edited alias snackspace@nottinghack.org.uk', '2015-10-05 08:55:59', 3, 4),
(152, 'ALIAS_EDIT', 'daniel@dswann.co.uk  edited alias membership@nottinghack.org.uk', '2015-10-14 17:37:57', 2, 4),
(153, 'ALIAS_EDIT', 'jhayward1980@gmail.com  edited alias software@nottinghack.org.uk', '2015-10-31 11:18:31', 3, 4),
(154, 'ALIAS_EDIT', 'dps.lwk@gmail.com  edited alias infrastructure@nottinghack.org.uk', '2015-11-03 16:59:46', 1, 4),
(155, 'ALIAS_EDIT', 'dps.lwk@gmail.com  edited alias metalworking@nottinghack.org.uk', '2015-11-03 17:00:01', 1, 4),
(156, 'ALIAS_EDIT', 'dps.lwk@gmail.com  edited alias software@nottinghack.org.uk', '2015-11-03 17:00:19', 1, 4),
(157, 'MAILBOX_EDIT', 'dps.lwk@gmail.com  edited mailbox electronics@nottinghack.org.uk', '2015-12-04 08:37:24', 1, 4),
(158, 'MAILBOX_EDIT', 'dps.lwk@gmail.com  edited mailbox 3dprinting@nottinghack.org.uk', '2015-12-04 08:37:35', 1, 4),
(159, 'MAILBOX_EDIT', 'dps.lwk@gmail.com  edited mailbox infrastructure@nottinghack.org.uk', '2015-12-04 08:38:51', 1, 4),
(160, 'MAILBOX_EDIT', 'dps.lwk@gmail.com  edited mailbox metalworking@nottinghack.org.uk', '2015-12-04 08:40:33', 1, 4),
(161, 'MAILBOX_EDIT', 'dps.lwk@gmail.com  edited mailbox woodworking@nottinghack.org.uk', '2015-12-04 08:40:40', 1, 4),
(162, 'ALIAS_EDIT', 'dps.lwk@gmail.com  edited alias events@nottinghack.org.uk', '2015-12-04 08:41:35', 1, 4),
(163, 'ALIAS_ADD', 'daniel@dswann.co.uk  added alias fundraising@nottinghack.org.uk', '2015-12-04 17:26:06', 2, 4),
(164, 'ALIAS_ADD', 'jhayward1980@gmail.com  added alias leah.hallissey@nottinghack.org.uk', '2015-12-13 16:07:25', 3, 4),
(165, 'ALIAS_ADD', 'jhayward1980@gmail.com  added alias owen.ballentine@nottinghack.org.uk', '2015-12-13 16:10:06', 3, 4),
(166, 'ALIAS_EDIT', 'daniel@dswann.co.uk  edited alias comms@nottinghack.org.uk', '2015-12-15 22:10:41', 2, 4),
(167, 'ALIAS_EDIT', 'daniel@dswann.co.uk  edited alias comms@nottinghack.org.uk', '2015-12-15 22:11:38', 2, 4),
(168, 'ALIAS_EDIT', 'daniel@dswann.co.uk  edited alias events@nottinghack.org.uk', '2015-12-29 13:08:52', 2, 4),
(169, 'ALIAS_EDIT', 'daniel@dswann.co.uk  edited alias events@nottinghack.org.uk', '2015-12-29 13:14:15', 2, 4),
(170, 'ALIAS_EDIT', 'daniel@dswann.co.uk  edited alias membership@nottinghack.org.uk', '2015-12-29 16:53:59', 2, 4),
(171, 'ALIAS_EDIT', 'daniel@dswann.co.uk  edited alias resources@nottinghack.org.uk', '2016-01-28 18:03:27', 2, 4),
(172, 'ALIAS_EDIT', 'jhayward1980@gmail.com  edited alias events@nottinghack.org.uk', '2016-01-30 10:31:44', 3, 4),
(174, 'ALIAS_DELETE', 'dps.lwk@gmail.com removed alias fundraising@nottinghack.org.uk', '2016-02-07 19:50:49', 1, 4),
(175, 'MAILBOX_ADD', 'dps.lwk@gmail.com  added mailbox fundraising@nottinghack.org.uk', '2016-02-07 19:51:12', 1, 4),
(176, 'MAILBOX_PW_CHANGE', 'dps.lwk@gmail.com changed password for mailbox 3dprinting@nottinghack.org.uk', '2016-02-07 19:55:51', 1, 4),
(177, 'MAILBOX_PW_CHANGE', 'dps.lwk@gmail.com changed password for mailbox electronics@nottinghack.org.uk', '2016-02-07 19:57:38', 1, 4),
(178, 'MAILBOX_PW_CHANGE', 'dps.lwk@gmail.com changed password for mailbox infrastructure@nottinghack.org.uk', '2016-02-07 19:58:52', 1, 4),
(179, 'MAILBOX_PW_CHANGE', 'dps.lwk@gmail.com changed password for mailbox metalworking@nottinghack.org.uk', '2016-02-07 19:59:51', 1, 4),
(180, 'MAILBOX_PW_CHANGE', 'dps.lwk@gmail.com changed password for mailbox opensource@nottinghack.org.uk', '2016-02-07 20:01:44', 1, 4),
(181, 'MAILBOX_PW_CHANGE', 'dps.lwk@gmail.com changed password for mailbox woodworking@nottinghack.org.uk', '2016-02-07 20:02:10', 1, 4),
(182, 'MAILBOX_ADD', 'dps.lwk@gmail.com  added mailbox accounts@nottinghack.org.uk', '2016-02-07 20:20:04', 1, 4),
(183, 'MAILBOX_PW_CHANGE', 'dps.lwk@gmail.com changed password for mailbox bookings@nottinghack.org.uk', '2016-02-07 20:47:18', 1, 4),
(184, 'MAILBOX_PW_CHANGE', 'dps.lwk@gmail.com changed password for mailbox bookings@nottinghack.org.uk', '2016-02-07 20:48:00', 1, 4),
(185, 'ALIAS_EDIT', 'jhayward1980@gmail.com  edited alias events@nottinghack.org.uk', '2016-02-08 20:15:26', 3, 4),
(186, 'ALIAS_EDIT', 'dps.lwk@gmail.com  edited alias events@nottinghack.org.uk', '2016-02-16 11:45:39', 1, 4),
(187, 'ALIAS_EDIT', 'dps.lwk@gmail.com  edited alias comms@nottinghack.org.uk', '2016-02-16 11:45:46', 1, 4),
(188, 'ALIAS_EDIT', 'jhayward1980@gmail.com  edited alias trustees@nottinghack.org.uk', '2016-02-28 19:26:51', 3, 4),
(189, 'ALIAS_EDIT', 'daniel@dswann.co.uk  edited alias fundraising@nottinghack.org.uk', '2016-02-28 20:30:55', 2, 4),
(190, 'ALIAS_EDIT', 'daniel@dswann.co.uk  edited alias fundraising@nottinghack.org.uk', '2016-02-28 20:32:02', 2, 4),
(191, 'ALIAS_ADD', 'daniel@dswann.co.uk  added alias sales@nottinghack.org.uk', '2016-03-10 22:41:11', 2, 4),
(192, 'ALIAS_EDIT', 'jhayward1980@gmail.com  edited alias trustees@nottinghack.org.uk', '2016-03-16 09:28:08', 3, 4),
(193, 'ALIAS_EDIT', 'daniel@dswann.co.uk  edited alias newsletter@nottinghack.org.uk', '2016-04-03 20:57:40', 2, 4),
(194, 'ALIAS_EDIT', 'dps.lwk@gmail.com  edited alias 3dprinting@nottinghack.org.uk', '2016-05-22 14:41:21', 1, 4),
(195, 'ALIAS_ADD', 'dps.lwk@gmail.com  added alias michael.erskine@nottinghack.org.uk', '2016-05-24 17:39:00', 1, 4),
(196, 'ALIAS_EDIT', 'dps.lwk@gmail.com  edited alias trustees@nottinghack.org.uk', '2016-05-24 17:41:28', 1, 4),
(197, 'ALIAS_EDIT', 'dps.lwk@gmail.com  edited alias tools@nottinghack.org.uk', '2016-06-06 12:45:53', 1, 4),
(198, 'ALIAS_EDIT', 'dps.lwk@gmail.com  edited alias events@nottinghack.org.uk', '2016-06-09 12:01:43', 1, 4),
(199, 'ALIAS_EDIT', 'dps.lwk@gmail.com  edited alias comms@nottinghack.org.uk', '2016-06-09 12:02:18', 1, 4),
(200, 'ALIAS_ADD', 'jhayward1980@gmail.com  added alias delivertogroup@nottinghack.org.uk', '2016-06-18 13:33:09', 3, 4),
(201, 'ALIAS_EDIT', 'dps.lwk@gmail.com  edited alias resources@nottinghack.org.uk', '2016-06-23 10:20:47', 1, 4),
(202, 'ALIAS_ADD', 'dps.lwk@gmail.com  added alias russell.houghton@nottinghack.org.uk', '2016-07-28 23:04:47', 1, 4),
(203, 'ALIAS_EDIT', 'dps.lwk@gmail.com  edited alias trustees@nottinghack.org.uk', '2016-07-28 23:04:59', 1, 4),
(204, 'ALIAS_EDIT', 'dps.lwk@gmail.com  edited alias russell.houghton@nottinghack.org.uk', '2016-07-30 19:05:24', 1, 4),
(205, 'ALIAS_EDIT', 'jhayward1980@gmail.com  edited alias trustees@nottinghack.org.uk', '2016-08-17 19:19:10', 3, 4),
(206, 'ALIAS_EDIT', 'dps.lwk@gmail.com  edited alias trustees@nottinghack.org.uk', '2016-09-04 16:43:54', 1, 4),
(207, 'MAILBOX_ADD', 'dps.lwk@gmail.com  added mailbox wirelessthings@lwk.me', '2016-09-05 18:00:57', 1, 2),
(208, 'ALIAS_EDIT', 'dps.lwk@gmail.com  edited alias metalworking@nottinghack.org.uk', '2016-09-07 20:14:14', 1, 4),
(209, 'ALIAS_EDIT', 'dps.lwk@gmail.com  edited alias laser@nottinghack.org.uk', '2016-09-25 18:09:50', 1, 4),
(210, 'ALIAS_EDIT', 'dps.lwk@gmail.com  edited alias maintainers@nottinghack.org.uk', '2016-09-25 18:10:01', 1, 4),
(211, 'ALIAS_EDIT', 'dps.lwk@gmail.com  edited alias trustees@nottinghack.org.uk', '2016-10-05 10:21:34', 1, 4),
(212, 'ALIAS_EDIT', 'dps.lwk@gmail.com  edited alias metalworking@nottinghack.org.uk', '2016-10-06 17:57:32', 1, 4),
(213, 'ALIAS_EDIT', 'dps.lwk@gmail.com  edited alias maintainers@nottinghack.org.uk', '2016-10-17 21:15:41', 1, 4),
(214, 'ALIAS_ADD', 'dps.lwk@gmail.com  added alias ian.dickinson@nottinghack.org.uk', '2016-11-03 20:19:59', 1, 4),
(215, 'ALIAS_EDIT', 'dps.lwk@gmail.com  edited alias trustees@nottinghack.org.uk', '2016-11-03 20:20:15', 1, 4);

-- --------------------------------------------------------

--
-- Table structure for table `mailbox`
--

CREATE TABLE IF NOT EXISTS `mailbox` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `alt_email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `quota` bigint(20) NOT NULL DEFAULT '0',
  `local_part` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `access_restriction` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'ALL',
  `homedir` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `maildir` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uid` bigint(20) DEFAULT NULL,
  `gid` bigint(20) DEFAULT NULL,
  `homedir_size` bigint(20) DEFAULT NULL,
  `maildir_size` bigint(20) DEFAULT NULL,
  `size_at` datetime DEFAULT NULL,
  `delete_pending` tinyint(1) DEFAULT '0',
  `created` datetime NOT NULL,
  `modified` datetime DEFAULT NULL,
  `Domain_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_A69FE20B93AE8C46` (`Domain_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=41 ;

--
-- Dumping data for table `mailbox`
--

INSERT INTO `mailbox` (`id`, `username`, `password`, `name`, `alt_email`, `quota`, `local_part`, `active`, `access_restriction`, `homedir`, `maildir`, `uid`, `gid`, `homedir_size`, `maildir_size`, `size_at`, `delete_pending`, `created`, `modified`, `Domain_id`) VALUES
(4, 'lwk@lwk.me', '//Tc6grziwRyEFXk8KqDts3wU14iMoP7Be800NztnqMhc5lS2G/442VAuz2RT+xhGncCqh+e5oxvcilSqKD9XWryqD4=', 'Matt Lloyd', '', 0, 'lwk', 1, 'ALL', '/var/vmail/lwk.me/lwk', 'maildir:/var/vmail/lwk.me/lwk/mail:LAYOUT=fs', 5000, 5000, NULL, NULL, NULL, 0, '2014-05-30 09:46:52', NULL, 2),
(6, 'matt.lloyd@nottinghack.org.uk', '9m2iAqYVy5XzluIemDE6bI8nwWfJTZ8PC0iz2tG+hDpSOx3E3xfNKBkgTnJcuwTdW/uuU3bTm2YaFakL6GG0ukfqpJY=', 'Matt Lloyd', '', 0, 'matt.lloyd', 1, 'ALL', '/var/vmail/nottinghack.org.uk/matt.lloyd', 'maildir:/var/vmail/nottinghack.org.uk/matt.lloyd/mail:LAYOUT=fs', 5000, 5000, NULL, NULL, NULL, 0, '2014-06-19 08:41:09', NULL, 4),
(7, 'network@nottinghack.org.uk', 'X/cp9ho1W4SuQq0hlPO6NqQT+2Mei9xlojYSdKcDJJPxAGq9HsCy653pJ0Ohu2UBdX7OrgwM82n+avK+787YGB2t00I=', 'Network Team', '', 0, 'network', 1, 'ALL', '/var/vmail/nottinghack.org.uk/network', 'maildir:/var/vmail/nottinghack.org.uk/network/mail:LAYOUT=fs', 5000, 5000, NULL, NULL, NULL, 0, '2014-06-19 09:00:04', NULL, 4),
(8, 'postmaster@nottinghack.org.uk', 'lz5GoTHwTNOZZcKlWLCoqNMV1+QnFceMAqfcm5q9wXx2GY/6F7aglai4ocFzGJNXDey6AfYJJXVp9xApIGgS28jGlNk=', 'Postmaster', '', 0, 'postmaster', 1, 'ALL', '/var/vmail/nottinghack.org.uk/postmaster', 'maildir:/var/vmail/nottinghack.org.uk/postmaster/mail:LAYOUT=fs', 5000, 5000, NULL, NULL, NULL, 0, '2014-06-19 11:02:48', NULL, 4),
(9, 'postmaster@lwk.me', 'NhLqJSBFAJxq48zLpDXq18p6jv7gqxFmsGjXTaTJwW7JSCw1HgO3eWyi1sJkSXFxi4kiBRPBkWpCaqodgznhwKzBc+E=', 'Postmaster', '', 0, 'postmaster', 1, 'ALL', '/var/vmail/lwk.me/postmaster', 'maildir:/var/vmail/lwk.me/postmaster/mail:LAYOUT=fs', 5000, 5000, NULL, NULL, NULL, 0, '2014-06-19 11:22:27', NULL, 2),
(10, 'info@nottinghack.org.uk', 'TnxXTFDvQIXfTQIn114kkae6AuCu0vIkD0U+Dvi0RlMGxZ+oSqT6STebiCvtb4rbjPMZk90Vjrc0NB2KC697N/THoKE=', 'Info Team', '', 0, 'info', 1, 'ALL', '/var/vmail/nottinghack.org.uk/info', 'maildir:/var/vmail/nottinghack.org.uk/info/mail:LAYOUT=fs', 5000, 5000, NULL, NULL, NULL, 0, '2014-06-19 11:51:31', NULL, 4),
(11, 'paypal@nottinghack.org.uk', 'DwiJOccTipjPbPgfasHBUDQ3uIJMVAE2Gc897O4VBMS1qXo/mviLnQ63hMKvEDS/Y/JIr/FnYE1LRMHt4PgsM7ufVGc=', 'Paypal Nottinghack', '', 0, 'paypal', 1, 'ALL', '/var/vmail/nottinghack.org.uk/paypal', 'maildir:/var/vmail/nottinghack.org.uk/paypal/mail:LAYOUT=fs', 5000, 5000, NULL, NULL, NULL, 0, '2014-06-19 11:56:09', NULL, 4),
(12, 'donations@nottinghack.org.uk', 'gbO4o+2CBuLVaOjBvvOHUwdEO29wP0qJMxMPV2vcb0vDhwA86ir11WVZYfJkBnzYjO9tRfs6hYrLQcdBkJJMinpGX4E=', 'Donations Nottinghack', '', 0, 'donations', 1, 'ALL', '/var/vmail/nottinghack.org.uk/donations', 'maildir:/var/vmail/nottinghack.org.uk/donations/mail:LAYOUT=fs', 5000, 5000, NULL, NULL, NULL, 0, '2014-06-19 11:57:26', NULL, 4),
(13, 'bookings@nottinghack.org.uk', 'CObF93p373AC7gwLCRHrTXTNBPMFTMtg4nY/fkZbyXrskITilcRRKo5VqAf7sRUOXqf6F/cFKnt7WGdA5O83gXHG4qw=', 'Tool Bookings', '', 0, 'bookings', 1, 'ALL', '/var/vmail/nottinghack.org.uk/bookings', 'maildir:/var/vmail/nottinghack.org.uk/bookings/mail:LAYOUT=fs', 5000, 5000, NULL, NULL, NULL, 0, '2014-06-19 20:02:12', '2014-06-19 21:35:47', 4),
(14, 'comms@nottinghack.org.uk', 'O4vMYN44MrcEBynyKybEq7x87YiRsNJdtao8RpG00ZmWC7n12y8nDWFnhFC7+IygZG969KUfM1qwlYhBbMcRgZeeZ1k=', 'Communications Team', '', 0, 'comms', 1, 'ALL', '/var/vmail/nottinghack.org.uk/comms', 'maildir:/var/vmail/nottinghack.org.uk/comms/mail:LAYOUT=fs', 5000, 5000, NULL, NULL, NULL, 0, '2014-06-19 20:05:43', NULL, 4),
(15, 'ein@nottinghack.org.uk', 'ggBhcb1FBNjqHhI2gAu9SxsPAMecdHQHj020ZTDZ0cXX1DeCGiMVd3HRJuU2amOWtD/UxhLX5/5vaCyfntj32D7VqYs=', 'Ein the Duck', '', 0, 'ein', 1, 'ALL', '/var/vmail/nottinghack.org.uk/ein', 'maildir:/var/vmail/nottinghack.org.uk/ein/mail:LAYOUT=fs', 5000, 5000, NULL, NULL, NULL, 0, '2014-06-19 20:08:50', NULL, 4),
(16, 'group@nottinghack.org.uk', 'Zpbary4sBmtPGitOyGJGHKAdawWAMflfKqClD6T3MWc1nLY2d9SXheDte+2R735b+8s2eKbdQc7tuwBo8PFeTy3kp40=', 'Nottinghack Discussions', '', 0, 'group', 1, 'ALL', '/var/vmail/nottinghack.org.uk/group', 'maildir:/var/vmail/nottinghack.org.uk/group/mail:LAYOUT=fs', 5000, 5000, NULL, NULL, NULL, 0, '2014-06-19 20:12:01', '2014-06-19 21:36:28', 4),
(17, 'holly@nottinghack.org.uk', 'jrDX31XLkkfRZW/gwoEC93GP4NhH9Lje4tnbIk3A7dAqHa159AX6yf+DyQ67hVC7GzTU+Dy5zy401Y7fu9mP+bOwKgc=', 'Holly533MHz', '', 0, 'holly', 1, 'ALL', '/var/vmail/nottinghack.org.uk/holly', 'maildir:/var/vmail/nottinghack.org.uk/holly/mail:LAYOUT=fs', 5000, 5000, NULL, NULL, NULL, 0, '2014-06-19 20:12:44', '2014-06-19 20:14:19', 4),
(18, 'laser@nottinghack.org.uk', '7aO/JjdXyos8K66SDGBF2RX2cBky8NGxdG3SlGFECdhpnVkPKacCC0xuHxz+MfTLiZGOOIYtUtlhPb5tCIqupzl557Q=', 'Laser', '', 0, 'laser', 1, 'ALL', '/var/vmail/nottinghack.org.uk/laser', 'maildir:/var/vmail/nottinghack.org.uk/laser/mail:LAYOUT=fs', 5000, 5000, NULL, NULL, NULL, 0, '2014-06-19 20:21:04', NULL, 4),
(19, 'membership@nottinghack.org.uk', 'npvaTEtLCIWSrIK06Dt3uvidluekXeLxtKB5Jcmo5UiV+7Yz3ZktqaFsfi80yebcqpGwbZudfJ9Bl1gvvXLiMs8rlBQ=', 'Membership Team', '', 0, 'membership', 1, 'ALL', '/var/vmail/nottinghack.org.uk/membership', 'maildir:/var/vmail/nottinghack.org.uk/membership/mail:LAYOUT=fs', 5000, 5000, NULL, NULL, NULL, 0, '2014-06-19 20:21:38', NULL, 4),
(20, 'newsletter@nottinghack.org.uk', '2U18e7rnB8uALW/HujrF6Ydr3k7fOrtnjAoUvgnI4WTxa+iiNoeJvgB8oCAiw18z1IIgl5m8paVePojV2RxmoEjNGIE=', 'Nottinghack Newsletter', '', 0, 'newsletter', 1, 'ALL', '/var/vmail/nottinghack.org.uk/newsletter', 'maildir:/var/vmail/nottinghack.org.uk/newsletter/mail:LAYOUT=fs', 5000, 5000, NULL, NULL, NULL, 0, '2014-06-19 20:23:30', NULL, 4),
(21, 'resources@nottinghack.org.uk', 'ew9N6Yxrs+ektIdjgOqGTf4r2WOjJzo/I9xPE45/t0cTybu4DnisXsSVTbKWu3p8k8iiY6ozYDk8dduSiaX4QBBjdbA=', 'Resource Team', '', 0, 'resources', 1, 'ALL', '/var/vmail/nottinghack.org.uk/resources', 'maildir:/var/vmail/nottinghack.org.uk/resources/mail:LAYOUT=fs', 5000, 5000, NULL, NULL, NULL, 0, '2014-06-19 20:31:54', NULL, 4),
(22, 'safety@nottinghack.org.uk', 'agJtFTd3VVhObUE1OWrs1iVXuz+iXBaDFxAIrWwWb4D6C6dsRc39UNXUi8EiNJAVcimhslvxjkH3pK6pxk5cXWuUHjY=', 'Safety Team', '', 0, 'safety', 1, 'ALL', '/var/vmail/nottinghack.org.uk/safety', 'maildir:/var/vmail/nottinghack.org.uk/safety/mail:LAYOUT=fs', 5000, 5000, NULL, NULL, NULL, 0, '2014-06-19 20:35:54', NULL, 4),
(23, 'software@nottinghack.org.uk', 'fgYJ8rHsO4Y3JNA4zxDupSOqvq++Y0tYiV7qINXwCd42s1xiEE+ylUs9PkI37lvXywfDa1exfNk7MBQHArt7jS9+K9s=', 'Software Team', '', 0, 'software', 1, 'ALL', '/var/vmail/nottinghack.org.uk/software', 'maildir:/var/vmail/nottinghack.org.uk/software/mail:LAYOUT=fs', 5000, 5000, NULL, NULL, NULL, 0, '2014-06-19 20:36:13', NULL, 4),
(24, 'tools@nottinghack.org.uk', '408vwjQPdd/c3+4pQqG0trmPgPlEqeIF4gqwxDRMj3rb3C2XKpAQhAFw/fd8WzSOPgHPvDUESmFc9Pyh4IfaZFZWgtc=', 'Tools Team', '', 0, 'tools', 1, 'ALL', '/var/vmail/nottinghack.org.uk/tools', 'maildir:/var/vmail/nottinghack.org.uk/tools/mail:LAYOUT=fs', 5000, 5000, NULL, NULL, NULL, 0, '2014-06-19 20:37:06', NULL, 4),
(25, 'trustees@nottinghack.org.uk', 'V3Y7hOA5/DuZV63AIt20Nbx4aP4/6g9p+dPvtjluckohvsx5gwQ36es3p/4D6+CvsZyzyH24cEiRXH/rZb1bCgrAz/M=', 'Nottinghack Trustees', '', 0, 'trustees', 1, 'ALL', '/var/vmail/nottinghack.org.uk/trustees', 'maildir:/var/vmail/nottinghack.org.uk/trustees/mail:LAYOUT=fs', 5000, 5000, NULL, NULL, NULL, 0, '2014-06-19 20:37:52', NULL, 4),
(26, 'daniel@nottinghack.org.uk', 'Cq0vGNPZUmTEVTA8oZGqS0IZR0+beDfDq+rauRZjEFpqa+EmY3YcJyKlhMJzDjYvtkdM96UavPRAJtCfGrOet7acRHw=', 'Daniel Swann', '', 0, 'daniel', 1, 'ALL', '/var/vmail/nottinghack.org.uk/daniel', 'maildir:/var/vmail/nottinghack.org.uk/daniel/mail:LAYOUT=fs', 5000, 5000, NULL, NULL, NULL, 0, '2014-06-19 21:27:48', NULL, 4),
(27, 'snackspace@nottinghack.org.uk', 'IgoloZ7xU3zfEdeE3P9J5AMjJk+9CBDQsx1k2XfA3/mXJusU87wB5nh+ckZJT88kn8ZE5CsbJyVhZBfJsSlVMkpbZVk=', 'Snackspace', '', 0, 'snackspace', 1, 'ALL', '/var/vmail/nottinghack.org.uk/snackspace', 'maildir:/var/vmail/nottinghack.org.uk/snackspace/mail:LAYOUT=fs', 5000, 5000, NULL, NULL, NULL, 0, '2014-08-20 20:12:21', NULL, 4),
(28, 'talk@nottinghack.org.uk', 'b/QGXZn88KwaNXMPLCjuRS/jNd6pPzEBy7lBYA/45Cw0qx5yDkxkwp5vKoqzmUZyIiKR0dUCGha0kzTmQsEUSW05Vk4=', 'Nottinghack Talk', '', 0, 'talk', 1, 'ALL', '/var/vmail/nottinghack.org.uk/talk', 'maildir:/var/vmail/nottinghack.org.uk/talk/mail:LAYOUT=fs', 5000, 5000, NULL, NULL, NULL, 0, '2014-10-22 21:21:52', NULL, 4),
(29, 'maintainers@nottinghack.org.uk', 'hEIEcps1gzCP8zKgAw2MaJ1AQHqvyW7QNpGHR6bMtu5rmaIl+DC+5639UEbbgMyZtFaBiQO+TKsIa6SllvvSiWevo3c=', 'Maintainers', '', 0, 'maintainers', 1, 'ALL', '/var/vmail/nottinghack.org.uk/maintainers', 'maildir:/var/vmail/nottinghack.org.uk/maintainers/mail:LAYOUT=fs', 5000, 5000, NULL, NULL, NULL, 0, '2015-04-20 12:19:03', NULL, 4),
(30, 'craft@nottinghack.org.uk', 'KGaDHQtsxwHJ1KMUFsHntPQ/WbcfqFCcIWU6GwwLtpNh1TI/kh83g8wZaYDJFJJro28RsC9P5cqS51XriNaTzQR3iA4=', 'Craft Team', '', 0, 'craft', 1, 'ALL', '/var/vmail/nottinghack.org.uk/craft', 'maildir:/var/vmail/nottinghack.org.uk/craft/mail:LAYOUT=fs', 5000, 5000, NULL, NULL, NULL, 0, '2015-07-01 19:17:15', NULL, 4),
(31, 'opensource@nottinghack.org.uk', 'CTbQ2mkSzLwDosqAfa5eIKYfv3yQ/fFwwPDbwVYCTeK4aJgwUUqfRXQE2Dad4RxcchqxyRYJG/D0Aj/uJHZDebUlfT0=', 'Open Source', '', 0, 'opensource', 1, 'ALL', '/var/vmail/nottinghack.org.uk/opensource', 'maildir:/var/vmail/nottinghack.org.uk/opensource/mail:LAYOUT=fs', 5000, 5000, NULL, NULL, NULL, 0, '2015-07-25 12:53:47', NULL, 4),
(32, 'events@nottinghack.org.uk', 'ggohfhPxCktN6WGBLjlh4HANyhUnuEx/sZuvR1/5qZzIg13I6GiviBS3eEaYNSzAMT8wObL7X4C2VjqP0zAg4Rbg0u4=', 'Events Team', '', 0, 'events', 1, 'ALL', '/var/vmail/nottinghack.org.uk/events', 'maildir:/var/vmail/nottinghack.org.uk/events/mail:LAYOUT=fs', 5000, 5000, NULL, NULL, NULL, 0, '2015-09-03 21:10:33', '2015-09-03 21:17:00', 4),
(33, '3dprinting@nottinghack.org.uk', 'c5kGOXKWU1jJA41RV5ptku7rSOw9nWki/zGTZOZwgdWz0RvwPlgDhZoRPAkvkjd/ymp9XpUUvVOouedtPGiwgntTtWw=', '3D Printing Team', '', 0, '3dprinting', 1, 'ALL', '/var/vmail/nottinghack.org.uk/3dprinting', 'maildir:/var/vmail/nottinghack.org.uk/3dprinting/mail:LAYOUT=fs', 5000, 5000, NULL, NULL, NULL, 0, '2015-09-03 21:10:56', '2015-12-04 08:37:35', 4),
(34, 'electronics@nottinghack.org.uk', 'BVz9pEGCbIh+IXABkVe8rFvhB/AkhlWtYMaOGA0Tmz+Pp1NkS7LEg7XLDkyyXcaRFmfBXXz3mzE7i441Fb3wuI7sCeg=', 'Electronics Team', '', 0, 'electronics', 1, 'ALL', '/var/vmail/nottinghack.org.uk/electronics', 'maildir:/var/vmail/nottinghack.org.uk/electronics/mail:LAYOUT=fs', 5000, 5000, NULL, NULL, NULL, 0, '2015-09-03 21:11:24', '2015-12-04 08:37:24', 4),
(35, 'infrastructure@nottinghack.org.uk', 'QiWSv8NUjyXV0hFp5vyNMMgD0MA/yP35INchzxN0EsD4+ka3YJVTcF1Rb8D9urrOp/ombCFFX+PMa8KM7vDkhqhY6zE=', 'Infrastructure Team', '', 0, 'infrastructure', 1, 'ALL', '/var/vmail/nottinghack.org.uk/infrastructure', 'maildir:/var/vmail/nottinghack.org.uk/infrastructure/mail:LAYOUT=fs', 5000, 5000, NULL, NULL, NULL, 0, '2015-09-03 21:12:27', '2015-12-04 08:38:51', 4),
(36, 'metalworking@nottinghack.org.uk', 'uYpdQdtOrlbNdYtKm6zD8nY/Jp1j+RTdFpr3uekQlxHcJg7mFbp7i9R5LK4jRw3kH6wRCw486tljI3amLAhN+1TAHGQ=', 'Metal Working Team', '', 0, 'metalworking', 1, 'ALL', '/var/vmail/nottinghack.org.uk/metalworking', 'maildir:/var/vmail/nottinghack.org.uk/metalworking/mail:LAYOUT=fs', 5000, 5000, NULL, NULL, NULL, 0, '2015-09-03 21:12:49', '2015-12-04 08:40:33', 4),
(37, 'woodworking@nottinghack.org.uk', '1gCkPgZecUaeuMcvQst/jKIdkVUGu/I4ofH42IRZ5rO6R6aBnwXBULeICxh9jgNaB7/yyFcT8eS/3aUp+CLTjsnxy1A=', 'Wood Working Team', '', 0, 'woodworking', 1, 'ALL', '/var/vmail/nottinghack.org.uk/woodworking', 'maildir:/var/vmail/nottinghack.org.uk/woodworking/mail:LAYOUT=fs', 5000, 5000, NULL, NULL, NULL, 0, '2015-09-03 21:13:17', '2015-12-04 08:40:40', 4),
(38, 'fundraising@nottinghack.org.uk', '4D3or6s2nCTPicfI17YOtu1jsNec1JWclL77Y0e+kdFwu4mRW1doqqxDJLmMYfS/XZ1twaQqo25keH/gBemV8YFKgYw=', 'Fundraising Team', '', 0, 'fundraising', 1, 'ALL', '/var/vmail/nottinghack.org.uk/fundraising', 'maildir:/var/vmail/nottinghack.org.uk/fundraising/mail:LAYOUT=fs', 5000, 5000, NULL, NULL, NULL, 0, '2016-02-07 19:51:12', NULL, 4),
(39, 'accounts@nottinghack.org.uk', 'rrI7dmNysWxLFTnnjMjeuAHiWG112Pu8MHijNhRP2S96w979uoFMOAzZ09lBOZt6rwcHVjdr/nPXj51xI1ErcfcHM70=', 'Finance Team', '', 0, 'accounts', 1, 'ALL', '/var/vmail/nottinghack.org.uk/accounts', 'maildir:/var/vmail/nottinghack.org.uk/accounts/mail:LAYOUT=fs', 5000, 5000, NULL, NULL, NULL, 0, '2016-02-07 20:20:04', NULL, 4),
(40, 'wirelessthings@lwk.me', 'sdGA5FTHrGRzmi9hr4Q9XX5xzQrXs+GwcROcRfbfHIoQfIBZAl1qStg/uWzskBleD2ZynYyAx1zDbAg3NEbmRR7er8k=', 'Matt Lloyd', '', 0, 'wirelessthings', 1, 'ALL', '/var/vmail/lwk.me/wirelessthings', 'maildir:/var/vmail/lwk.me/wirelessthings/mail:LAYOUT=fs', 5000, 5000, NULL, NULL, NULL, 0, '2016-09-05 18:00:57', NULL, 2);

-- --------------------------------------------------------

--
-- Table structure for table `mailbox_pref`
--

CREATE TABLE IF NOT EXISTS `mailbox_pref` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `attribute` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `ix` int(11) NOT NULL DEFAULT '0',
  `op` varchar(2) COLLATE utf8_unicode_ci NOT NULL DEFAULT ':=',
  `value` longtext COLLATE utf8_unicode_ci NOT NULL,
  `expire` bigint(20) NOT NULL DEFAULT '0',
  `Mailbox_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_F9C4B42A29B1361C` (`Mailbox_id`),
  KEY `IX_MailboxPreference_1` (`Mailbox_id`,`attribute`,`ix`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `remember_me`
--

CREATE TABLE IF NOT EXISTS `remember_me` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `userhash` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `ckey` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `original_ip` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `expires` datetime NOT NULL,
  `last_used` datetime NOT NULL,
  `created` datetime NOT NULL,
  `Admin_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_7AF2A7289D5DE046` (`Admin_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `admin_pref`
--
ALTER TABLE `admin_pref`
  ADD CONSTRAINT `FK_814C1AD19D5DE046` FOREIGN KEY (`Admin_id`) REFERENCES `admin` (`id`);

--
-- Constraints for table `alias`
--
ALTER TABLE `alias`
  ADD CONSTRAINT `FK_E16C6B9493AE8C46` FOREIGN KEY (`Domain_id`) REFERENCES `domain` (`id`);

--
-- Constraints for table `alias_pref`
--
ALTER TABLE `alias_pref`
  ADD CONSTRAINT `FK_3279E911A72028B4` FOREIGN KEY (`Alias_id`) REFERENCES `alias` (`id`);

--
-- Constraints for table `archive`
--
ALTER TABLE `archive`
  ADD CONSTRAINT `FK_D5FC5D9C93AE8C46` FOREIGN KEY (`Domain_id`) REFERENCES `domain` (`id`),
  ADD CONSTRAINT `FK_D5FC5D9C9D5DE046` FOREIGN KEY (`Admin_id`) REFERENCES `admin` (`id`);

--
-- Constraints for table `directory_entry`
--
ALTER TABLE `directory_entry`
  ADD CONSTRAINT `FK_6553C92D66EC35CC` FOREIGN KEY (`mailbox_id`) REFERENCES `mailbox` (`id`);

--
-- Constraints for table `domain_admins`
--
ALTER TABLE `domain_admins`
  ADD CONSTRAINT `FK_CD8319C693AE8C46` FOREIGN KEY (`Domain_id`) REFERENCES `domain` (`id`),
  ADD CONSTRAINT `FK_CD8319C69D5DE046` FOREIGN KEY (`Admin_id`) REFERENCES `admin` (`id`);

--
-- Constraints for table `domain_pref`
--
ALTER TABLE `domain_pref`
  ADD CONSTRAINT `FK_C89B55693AE8C46` FOREIGN KEY (`Domain_id`) REFERENCES `domain` (`id`);

--
-- Constraints for table `log`
--
ALTER TABLE `log`
  ADD CONSTRAINT `FK_8F3F68C593AE8C46` FOREIGN KEY (`Domain_id`) REFERENCES `domain` (`id`),
  ADD CONSTRAINT `FK_8F3F68C59D5DE046` FOREIGN KEY (`Admin_id`) REFERENCES `admin` (`id`);

--
-- Constraints for table `mailbox`
--
ALTER TABLE `mailbox`
  ADD CONSTRAINT `FK_A69FE20B93AE8C46` FOREIGN KEY (`Domain_id`) REFERENCES `domain` (`id`);

--
-- Constraints for table `mailbox_pref`
--
ALTER TABLE `mailbox_pref`
  ADD CONSTRAINT `FK_F9C4B42A29B1361C` FOREIGN KEY (`Mailbox_id`) REFERENCES `mailbox` (`id`);

--
-- Constraints for table `remember_me`
--
ALTER TABLE `remember_me`
  ADD CONSTRAINT `FK_7AF2A7289D5DE046` FOREIGN KEY (`Admin_id`) REFERENCES `admin` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
