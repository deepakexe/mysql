CREATE DATABASE  IF NOT EXISTS `sharkdb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `sharkdb`;
-- MySQL dump 10.13  Distrib 8.0.27, for macos11 (x86_64)
--
-- Host: 3.109.223.158    Database: sharkdb
-- ------------------------------------------------------
-- Server version	8.0.33

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '';

--
-- Table structure for table `ACPolicies`
--

DROP TABLE IF EXISTS `ACPolicies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ACPolicies` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `companyId` int NOT NULL,
  `features` json DEFAULT NULL,
  `appRoleId` int NOT NULL,
  `channels` json DEFAULT NULL,
  `active` tinyint(1) DEFAULT '1',
  `accessType` int NOT NULL,
  `exceptionalFeatures` json DEFAULT NULL,
  `createdBy` varchar(100) DEFAULT NULL,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`,`appRoleId`),
  UNIQUE KEY `acp_name_cid_idx` (`name`,`companyId`),
  KEY `fk_acp_ar_arid_idx` (`appRoleId`),
  KEY `fk_acp_c_cid_idx` (`companyId`),
  CONSTRAINT `fk_acp_ar_arid` FOREIGN KEY (`appRoleId`) REFERENCES `AppRoles` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_acp_c_cid` FOREIGN KEY (`companyId`) REFERENCES `Company` (`CompanyID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ACPolicyTransactions`
--

DROP TABLE IF EXISTS `ACPolicyTransactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ACPolicyTransactions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `policyId` int NOT NULL,
  `userGroupId` int NOT NULL,
  `active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `acpt_pid_acp_id` (`policyId`),
  KEY `acpt_ugid_ugm_id_idx` (`userGroupId`),
  CONSTRAINT `acpt_pid_acp_id` FOREIGN KEY (`policyId`) REFERENCES `ACPolicies` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `acpt_ugid_ugm_id` FOREIGN KEY (`userGroupId`) REFERENCES `UserGroupsMaster` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `App`
--

DROP TABLE IF EXISTS `App`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `App` (
  `AppID` int NOT NULL,
  `TenantID` int NOT NULL,
  `App_Name` varchar(45) DEFAULT NULL,
  `User_Store` varchar(45) DEFAULT NULL,
  `Description` varchar(45) DEFAULT NULL,
  `Role_Claim` varchar(45) DEFAULT NULL,
  `Auth_Type` varchar(45) DEFAULT NULL,
  `Provisioning_Userstore_Domain` varchar(45) DEFAULT NULL,
  `Is_Local_Claim_Dialect` varchar(45) DEFAULT NULL,
  `Is_Send_Local_Subject_ID` varchar(45) DEFAULT NULL,
  `Is_Send_Auth_List_Of_IDPS` varchar(45) DEFAULT NULL,
  `Subject_Claim_URI` varchar(45) DEFAULT NULL,
  `Is_SAAS_App` varchar(45) DEFAULT NULL,
  `UserProfile_UserID` varchar(100) NOT NULL,
  PRIMARY KEY (`AppID`,`TenantID`),
  KEY `fk_App_UserProfile1_idx` (`UserProfile_UserID`),
  CONSTRAINT `fk_App_UserProfile1` FOREIGN KEY (`UserProfile_UserID`) REFERENCES `UserProfile` (`UserID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AppPolicies`
--

DROP TABLE IF EXISTS `AppPolicies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AppPolicies` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(100) NOT NULL,
  `companyID` int NOT NULL,
  `attributes` json DEFAULT NULL,
  `createdDateTime` datetime DEFAULT CURRENT_TIMESTAMP,
  `acceptanceType` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AppRoles`
--

DROP TABLE IF EXISTS `AppRoles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AppRoles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AppUserAccessList`
--

DROP TABLE IF EXISTS `AppUserAccessList`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AppUserAccessList` (
  `AppUserRole_AppUserRoleID` int NOT NULL,
  `RankRole_RoleID` int NOT NULL,
  KEY `fk_AppUserAccessList_AppUserRole1_idx` (`AppUserRole_AppUserRoleID`),
  KEY `fk_AppUserAccessList_RankRole1_idx` (`RankRole_RoleID`),
  CONSTRAINT `fk_AppUserAccessList_AppUserRole1` FOREIGN KEY (`AppUserRole_AppUserRoleID`) REFERENCES `AppUserRole` (`AppUserRoleID`),
  CONSTRAINT `fk_AppUserAccessList_RankRole1` FOREIGN KEY (`RankRole_RoleID`) REFERENCES `RankRole` (`RoleID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AppUserRole`
--

DROP TABLE IF EXISTS `AppUserRole`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AppUserRole` (
  `AppUserRoleID` int NOT NULL,
  `AppUserRoleName` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`AppUserRoleID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AppVersionTransaction`
--

DROP TABLE IF EXISTS `AppVersionTransaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AppVersionTransaction` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `AppType` int NOT NULL,
  `AppVersion` varchar(45) NOT NULL,
  `AppURL` varchar(1000) NOT NULL,
  `Token` varchar(200) DEFAULT NULL,
  `IsMandatory` tinyint DEFAULT '0',
  `CreatedAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `u_avt_at_token` (`AppType`,`Token`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AuditLogs`
--

DROP TABLE IF EXISTS `AuditLogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AuditLogs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `actor` varchar(45) NOT NULL,
  `actorValue` varchar(45) NOT NULL,
  `actorAdditionalAttributes` json DEFAULT NULL,
  `eventType` varchar(45) NOT NULL,
  `eventStatus` varchar(45) NOT NULL,
  `eventAdditionalAttributes` json DEFAULT NULL,
  `dateTime` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11136 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Auth_Step`
--

DROP TABLE IF EXISTS `Auth_Step`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Auth_Step` (
  `ID` int NOT NULL,
  `App_AppID` int NOT NULL,
  `App_TenantID` int NOT NULL,
  `Step_Order` varchar(45) DEFAULT NULL,
  `Is_Subject_Step` varchar(45) DEFAULT NULL,
  `Is_Attribute_Step` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ID`,`App_AppID`,`App_TenantID`),
  KEY `fk_Auth_Step_App1_idx` (`App_AppID`,`App_TenantID`),
  CONSTRAINT `fk_Auth_Step_App1` FOREIGN KEY (`App_AppID`, `App_TenantID`) REFERENCES `App` (`AppID`, `TenantID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `BloodGroup`
--

DROP TABLE IF EXISTS `BloodGroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `BloodGroup` (
  `BloodGroupID` int NOT NULL AUTO_INCREMENT,
  `BloodGroup` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`BloodGroupID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `BroadcastTypes`
--

DROP TABLE IF EXISTS `BroadcastTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `BroadcastTypes` (
  `id` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `info` json DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Channels`
--

DROP TABLE IF EXISTS `Channels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Channels` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `attributes` json DEFAULT NULL,
  `active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Chat`
--

DROP TABLE IF EXISTS `Chat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Chat` (
  `threadID` varchar(200) NOT NULL,
  `ticketNumber` int NOT NULL AUTO_INCREMENT,
  `type` int NOT NULL,
  `userID` varchar(100) NOT NULL,
  `unitID` varchar(100) NOT NULL,
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `status` int DEFAULT '0',
  `hide` int DEFAULT '0',
  `metaData` json DEFAULT NULL,
  `reOpenCount` int DEFAULT '0',
  `botChats` json DEFAULT NULL,
  `category` varchar(200) NOT NULL,
  `issueDescription` varchar(3000) NOT NULL,
  `concerns` varchar(1000) DEFAULT NULL,
  `recommendations` varchar(1000) DEFAULT NULL,
  `chatBotId` int DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `feedback` json DEFAULT NULL,
  PRIMARY KEY (`ticketNumber`),
  UNIQUE KEY `threadID_UNIQUE` (`threadID`),
  KEY `fk_user_profile_userid_idx` (`userID`),
  KEY `fk_c_cbid_cbj_id` (`chatBotId`),
  CONSTRAINT `fk_c_cbid_cbj_id` FOREIGN KEY (`chatBotId`) REFERENCES `ChatBotJson` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_chat_user_profile_userid` FOREIGN KEY (`userID`) REFERENCES `UserProfile` (`UserID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=929 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ChatBotJson`
--

DROP TABLE IF EXISTS `ChatBotJson`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ChatBotJson` (
  `id` int NOT NULL AUTO_INCREMENT,
  `token` varchar(100) NOT NULL,
  `type` varchar(100) NOT NULL,
  `data` json NOT NULL,
  `visibilityType` tinyint(1) DEFAULT NULL,
  `variables` json DEFAULT NULL,
  `behaviouralOutcomeBackend` varchar(45) DEFAULT NULL,
  `behaviouralOutcomeFrontend` varchar(45) DEFAULT NULL,
  `feedback` json DEFAULT NULL,
  `explainer` json DEFAULT NULL,
  `active` int NOT NULL DEFAULT '1',
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=145 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ChatFeedback`
--

DROP TABLE IF EXISTS `ChatFeedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ChatFeedback` (
  `id` int NOT NULL,
  `header` varchar(45) DEFAULT NULL,
  `message` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ChatMessages`
--

DROP TABLE IF EXISTS `ChatMessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ChatMessages` (
  `msgID` bigint NOT NULL AUTO_INCREMENT,
  `threadID` varchar(200) NOT NULL,
  `message` mediumtext,
  `msgFrom` varchar(45) NOT NULL,
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `mediaUrls` varchar(500) DEFAULT NULL,
  `feedback` json DEFAULT NULL,
  `data` mediumtext,
  PRIMARY KEY (`msgID`),
  KEY `fk_chat_messages_user_profile_userid_idx` (`msgFrom`),
  KEY `fk_chat_messages_chat_thread_id` (`threadID`),
  CONSTRAINT `fk_chat_messages_chat_thread_id` FOREIGN KEY (`threadID`) REFERENCES `Chat` (`threadID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_chat_messages_user_profile_userid` FOREIGN KEY (`msgFrom`) REFERENCES `UserProfile` (`UserID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=1341 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ChatRead`
--

DROP TABLE IF EXISTS `ChatRead`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ChatRead` (
  `id` int NOT NULL AUTO_INCREMENT,
  `msgId` bigint NOT NULL,
  `threadId` varchar(200) NOT NULL,
  `userId` varchar(100) NOT NULL,
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `u_chatread_tid_uid` (`threadId`,`userId`),
  KEY `fk_chatread_uid_up_uid` (`userId`),
  CONSTRAINT `fk_chatread_tid_c_tid` FOREIGN KEY (`threadId`) REFERENCES `Chat` (`threadID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_chatread_uid_up_uid` FOREIGN KEY (`userId`) REFERENCES `UserProfile` (`UserID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=245393 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Claim_Mapping`
--

DROP TABLE IF EXISTS `Claim_Mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Claim_Mapping` (
  `ID` int NOT NULL,
  `App_AppID` int NOT NULL,
  `App_TenantID` int NOT NULL,
  `IDP_Claim` varchar(45) DEFAULT NULL,
  `SP_Claim` varchar(45) DEFAULT NULL,
  `IS_Requested` varchar(45) DEFAULT NULL,
  `Default_Value` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_Claim_Mapping_App1_idx` (`App_AppID`,`App_TenantID`),
  CONSTRAINT `fk_Claim_Mapping_App1` FOREIGN KEY (`App_AppID`, `App_TenantID`) REFERENCES `App` (`AppID`, `TenantID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Company`
--

DROP TABLE IF EXISTS `Company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Company` (
  `CompanyID` int NOT NULL AUTO_INCREMENT,
  `CompanyName` varchar(45) DEFAULT NULL,
  `ContactName` varchar(45) DEFAULT NULL,
  `ContactNumber` varchar(45) DEFAULT NULL,
  `Vertical_VerticalID` int NOT NULL,
  `Token` varchar(200) NOT NULL,
  `BaseURL` varchar(100) DEFAULT NULL,
  `MgmtDashboardURL` varchar(100) DEFAULT NULL,
  `ForgotPasswordFlowEnabled` tinyint DEFAULT NULL,
  `ServiceJwtToken` varchar(500) DEFAULT NULL,
  `SSOFlowEnabled` tinyint DEFAULT NULL,
  `SSOConfiguration` json DEFAULT NULL,
  `Data` json DEFAULT NULL,
  PRIMARY KEY (`CompanyID`),
  UNIQUE KEY `Token_UNIQUE` (`Token`),
  KEY `fk_Company_Vertical_idx` (`Vertical_VerticalID`),
  CONSTRAINT `fk_Company_Vertical` FOREIGN KEY (`Vertical_VerticalID`) REFERENCES `Vertical` (`VerticalID`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `DAP_CONTENT_MASTER`
--

DROP TABLE IF EXISTS `DAP_CONTENT_MASTER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DAP_CONTENT_MASTER` (
  `DAP_CONTENT_ID` int NOT NULL AUTO_INCREMENT,
  `TOKEN` varchar(100) NOT NULL,
  `OSH_ID` int NOT NULL,
  `CAPACITY_ID` int NOT NULL,
  `DIMENSION_ID` int NOT NULL,
  `FACTOR_LEVEL_ID` int NOT NULL,
  `FACTOR_ID` int NOT NULL,
  `VARIABLE_ID` int NOT NULL,
  `NORM_ID` int DEFAULT NULL,
  `NORM` varchar(255) DEFAULT NULL,
  `FUNCTION_ID` int DEFAULT NULL,
  `FUNCTION_NAME` varchar(255) DEFAULT NULL,
  `CONTENT_TYPE_ID` int DEFAULT NULL,
  `CONTENT_TYPE` varchar(255) DEFAULT NULL,
  `CONTENT_ID` int DEFAULT NULL,
  `CONTENT_TITLE` varchar(255) DEFAULT NULL,
  `CONTENT_DURATION` varchar(255) DEFAULT NULL,
  `CONTENT_IMAGE_LINK` varchar(255) DEFAULT NULL,
  `CONTENT_POINTS` varchar(255) DEFAULT NULL,
  `CONTENT_INFOPILL_TEXT` varchar(255) DEFAULT NULL,
  `CONTENT_INFOPILL_ICON_LINK` varchar(255) DEFAULT NULL,
  `CONTENT_ORDER` int DEFAULT NULL,
  `BEHAVIOURAL_OUTCOME_ID` int DEFAULT NULL,
  `BEHAVIOURAL_OUTCOME` varchar(255) DEFAULT NULL,
  `CREATED_BY` varchar(255) DEFAULT NULL,
  `CREATED_TIMESTAMP` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `UPDATED_AT` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ACTIVE` tinyint DEFAULT '1',
  PRIMARY KEY (`DAP_CONTENT_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1880 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `DAP_TRANSACTION`
--

DROP TABLE IF EXISTS `DAP_TRANSACTION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DAP_TRANSACTION` (
  `DAP_TRANASACTION_AUTO_GEN_KEY` int NOT NULL AUTO_INCREMENT,
  `USER_ID` varchar(255) NOT NULL,
  `TRANSACTION_ID` int NOT NULL,
  `TRANSACTION_UNIT_ID` int NOT NULL,
  `OSH_QNA_TRANSACTION_ID` int NOT NULL,
  `DAP_CONTENT_ID` int NOT NULL,
  `DAP_CONTENT_CYCLE` int NOT NULL,
  `STATUS` varchar(255) NOT NULL,
  `CREATED_BY` varchar(255) DEFAULT NULL,
  `CREATED_TIMESTAMP` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `UPDATED_BY` varchar(255) DEFAULT NULL,
  `UPDATED_TIMESTAMP` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`DAP_TRANASACTION_AUTO_GEN_KEY`)
) ENGINE=InnoDB AUTO_INCREMENT=5898 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `DAP_TRANSACTION_HISTORY`
--

DROP TABLE IF EXISTS `DAP_TRANSACTION_HISTORY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DAP_TRANSACTION_HISTORY` (
  `TRANSACTION_HISTORY_ID` int NOT NULL AUTO_INCREMENT,
  `TRANSACTION_ID` int NOT NULL,
  `USER_ID` int NOT NULL,
  `DAP_CONTENT_ID` int NOT NULL,
  `HISTORY_KEY` varchar(255) NOT NULL,
  `HISTORY_VALUE` varchar(255) NOT NULL,
  `CREATED_BY` varchar(255) DEFAULT NULL,
  `CREATED_TIMESTAMP` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `UPDATED_BY` varchar(255) DEFAULT NULL,
  `UPDATED_TIMESTAMP` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`TRANSACTION_HISTORY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Department`
--

DROP TABLE IF EXISTS `Department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Department` (
  `DeptId` int NOT NULL AUTO_INCREMENT,
  `DeptName` varchar(50) NOT NULL,
  `Company_CompanyID` int NOT NULL,
  `DeptDescription` varchar(500) NOT NULL,
  PRIMARY KEY (`DeptId`,`Company_CompanyID`),
  UNIQUE KEY `DeptName_CompanyId` (`DeptName`,`Company_CompanyID`),
  KEY `fk_Department_Company1_idx` (`Company_CompanyID`),
  CONSTRAINT `fk_Department_Company1` FOREIGN KEY (`Company_CompanyID`) REFERENCES `Company` (`CompanyID`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Designation`
--

DROP TABLE IF EXISTS `Designation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Designation` (
  `DesignationID` int NOT NULL AUTO_INCREMENT,
  `DesignationName` varchar(45) DEFAULT NULL,
  `VerticalID` varchar(45) DEFAULT NULL,
  `Designationcol` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`DesignationID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Division`
--

DROP TABLE IF EXISTS `Division`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Division` (
  `DivisionID` int NOT NULL AUTO_INCREMENT,
  `Department_DeptId` int NOT NULL,
  `DivisionName` varchar(50) DEFAULT NULL,
  `DivisionDescription` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`DivisionID`,`Department_DeptId`),
  KEY `fk_Division_Department1_idx` (`Department_DeptId`),
  CONSTRAINT `fk_department_deptid` FOREIGN KEY (`Department_DeptId`) REFERENCES `Department` (`DeptId`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `FAQs`
--

DROP TABLE IF EXISTS `FAQs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FAQs` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Token` varchar(200) DEFAULT NULL,
  `Data` json DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `FeatureCategory`
--

DROP TABLE IF EXISTS `FeatureCategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FeatureCategory` (
  `CategoryID` int NOT NULL,
  `CategoryName` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`CategoryID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `FeatureModule`
--

DROP TABLE IF EXISTS `FeatureModule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FeatureModule` (
  `ModuleID` int NOT NULL,
  `ModuleName` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ModuleID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='	';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `FeatureTransactions`
--

DROP TABLE IF EXISTS `FeatureTransactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FeatureTransactions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `companyId` int DEFAULT NULL,
  `featureId` int NOT NULL,
  `active` tinyint DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `fk_ft_company_cid_id_idx` (`companyId`),
  KEY `fk_ft_fm_fid_id_idx` (`featureId`),
  CONSTRAINT `fk_ft_company_cid_id` FOREIGN KEY (`companyId`) REFERENCES `Company` (`CompanyID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_ft_fm_fid_id` FOREIGN KEY (`featureId`) REFERENCES `FeaturesMaster` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Features`
--

DROP TABLE IF EXISTS `Features`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Features` (
  `Channels_ChannelID` int NOT NULL,
  `FeatureID` int NOT NULL,
  `FeatureName` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Channels_ChannelID`,`FeatureID`),
  KEY `fk_Features_Channels1_idx` (`Channels_ChannelID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `FeaturesMaster`
--

DROP TABLE IF EXISTS `FeaturesMaster`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FeaturesMaster` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `shortName` varchar(100) DEFAULT NULL,
  `pId` int DEFAULT NULL,
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `fk_fm_id_pid_idx` (`pId`),
  CONSTRAINT `fk_fm_id_pid` FOREIGN KEY (`pId`) REFERENCES `FeaturesMaster` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Federated_IDP`
--

DROP TABLE IF EXISTS `Federated_IDP`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Federated_IDP` (
  `Auth_Step_ID` int NOT NULL,
  `Auth_Step_App_AppID` int NOT NULL,
  `Auth_Step_App_TenantID` int NOT NULL,
  KEY `fk_Federated_IDP_Auth_Step1_idx` (`Auth_Step_ID`,`Auth_Step_App_AppID`,`Auth_Step_App_TenantID`),
  CONSTRAINT `fk_Federated_IDP_Auth_Step1` FOREIGN KEY (`Auth_Step_ID`, `Auth_Step_App_AppID`, `Auth_Step_App_TenantID`) REFERENCES `Auth_Step` (`ID`, `App_AppID`, `App_TenantID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `GameContentMaster`
--

DROP TABLE IF EXISTS `GameContentMaster`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `GameContentMaster` (
  `id` int NOT NULL AUTO_INCREMENT,
  `token` varchar(45) NOT NULL,
  `name` varchar(50) NOT NULL,
  `data` json DEFAULT NULL,
  `type` tinyint(1) NOT NULL,
  `dimensions` json DEFAULT NULL,
  `factorLevels` json DEFAULT NULL,
  `factors` json DEFAULT NULL,
  `variables` json DEFAULT NULL,
  `function` varchar(45) DEFAULT NULL,
  `behaviouralOutcomeBackend` varchar(45) DEFAULT NULL,
  `behaviouralOutcomeFrontend` varchar(45) DEFAULT NULL,
  `feedback` json DEFAULT NULL,
  `active` tinyint(1) DEFAULT '1',
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=140 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `GameTransactions`
--

DROP TABLE IF EXISTS `GameTransactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `GameTransactions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `gameId` varchar(50) DEFAULT NULL,
  `userId` varchar(255) DEFAULT NULL,
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `GameId_UserId` (`gameId`,`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `GameTransactionsHistory`
--

DROP TABLE IF EXISTS `GameTransactionsHistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `GameTransactionsHistory` (
  `id` int NOT NULL AUTO_INCREMENT,
  `gameId` varchar(50) DEFAULT NULL,
  `userId` varchar(255) DEFAULT NULL,
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Gender`
--

DROP TABLE IF EXISTS `Gender`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Gender` (
  `GenderID` int NOT NULL AUTO_INCREMENT,
  `GenderName` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`GenderID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ImageList`
--

DROP TABLE IF EXISTS `ImageList`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ImageList` (
  `ImageID` int NOT NULL,
  `ImageContent` varchar(10000) DEFAULT NULL,
  `ImageTimestamp` varchar(45) DEFAULT NULL,
  `ImageFormat` varchar(45) DEFAULT NULL,
  `UserProfile_UserID` varchar(100) NOT NULL,
  PRIMARY KEY (`ImageID`),
  KEY `fk_ImageList_UserProfile1_idx` (`UserProfile_UserID`),
  CONSTRAINT `fk_ImageList_UserProfile1` FOREIGN KEY (`UserProfile_UserID`) REFERENCES `UserProfile` (`UserID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Inbound_Auth`
--

DROP TABLE IF EXISTS `Inbound_Auth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Inbound_Auth` (
  `ID` int NOT NULL,
  `App_AppID` int NOT NULL,
  `App_TenantID` int NOT NULL,
  `Inbound_Auth_key` varchar(45) DEFAULT NULL,
  `Inbound_Auth_Type` varchar(45) DEFAULT NULL,
  `Prop_Name` varchar(45) DEFAULT NULL,
  `Prop_VAlue` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_Inbound_Auth_App1_idx` (`App_AppID`,`App_TenantID`),
  CONSTRAINT `fk_Inbound_Auth_App1` FOREIGN KEY (`App_AppID`, `App_TenantID`) REFERENCES `App` (`AppID`, `TenantID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Integrations`
--

DROP TABLE IF EXISTS `Integrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Integrations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `vendorId` varchar(100) NOT NULL,
  `token` varchar(45) NOT NULL DEFAULT 'all',
  `name` varchar(45) NOT NULL,
  `metaData` json DEFAULT NULL,
  `status` int DEFAULT '0',
  `enabled` int NOT NULL DEFAULT '1',
  `successSync` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `MBCategory`
--

DROP TABLE IF EXISTS `MBCategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MBCategory` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `MBCustomisedTemplates`
--

DROP TABLE IF EXISTS `MBCustomisedTemplates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MBCustomisedTemplates` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(50) DEFAULT NULL,
  `title` varchar(500) DEFAULT NULL,
  `data` json DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `CreatedBy` varchar(50) DEFAULT NULL,
  `Category` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `type` (`type`),
  KEY `CreatedBy` (`CreatedBy`),
  CONSTRAINT `MBCustomisedTemplates_ibfk_1` FOREIGN KEY (`type`) REFERENCES `BroadcastTypes` (`id`),
  CONSTRAINT `MBCustomisedTemplates_ibfk_2` FOREIGN KEY (`CreatedBy`) REFERENCES `UserProfile` (`UserID`)
) ENGINE=InnoDB AUTO_INCREMENT=170 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `MBDefaultTemplates`
--

DROP TABLE IF EXISTS `MBDefaultTemplates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MBDefaultTemplates` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(45) NOT NULL,
  `title` varchar(500) NOT NULL,
  `data` json DEFAULT NULL,
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `Category` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_mbdt_t_bt_id` (`type`),
  CONSTRAINT `fk_mbdt_t_bt_id` FOREIGN KEY (`type`) REFERENCES `BroadcastTypes` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `MBSAllTransactions`
--

DROP TABLE IF EXISTS `MBSAllTransactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MBSAllTransactions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `contentId` int NOT NULL,
  `userId` varchar(100) NOT NULL,
  `feedbackResponse` json DEFAULT NULL,
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_mbsacm_uid_up_uid` (`userId`),
  KEY `fk_mbsacm_id_mbscm_id` (`contentId`),
  CONSTRAINT `fk_mbsacm_id_mbscm_id` FOREIGN KEY (`contentId`) REFERENCES `MBSContentMaster` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_mbsacm_uid_up_uid` FOREIGN KEY (`userId`) REFERENCES `UserProfile` (`UserID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=588 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `MBSContentMaster`
--

DROP TABLE IF EXISTS `MBSContentMaster`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MBSContentMaster` (
  `id` int NOT NULL AUTO_INCREMENT,
  `token` varchar(100) DEFAULT NULL,
  `templateId` int NOT NULL,
  `title` varchar(500) NOT NULL,
  `type` tinyint NOT NULL,
  `data` json DEFAULT NULL,
  `dimension` varchar(100) DEFAULT NULL,
  `factor_level` varchar(100) DEFAULT NULL,
  `factor` varchar(100) DEFAULT NULL,
  `variable` json DEFAULT NULL,
  `visibilityType` tinyint(1) DEFAULT NULL,
  `behaviouralOutcomeBackend` varchar(50) DEFAULT NULL,
  `behaviouralOutcomeFrontend` varchar(50) DEFAULT NULL,
  `feedback` json DEFAULT NULL,
  `active` tinyint DEFAULT '1',
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_mbscm_tid_mbst_id` (`templateId`),
  CONSTRAINT `fk_mbscm_tid_mbst_id` FOREIGN KEY (`templateId`) REFERENCES `MBSTemplates` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=154 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `MBSTemplates`
--

DROP TABLE IF EXISTS `MBSTemplates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MBSTemplates` (
  `id` int NOT NULL AUTO_INCREMENT,
  `data` json DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `MBSTransactions`
--

DROP TABLE IF EXISTS `MBSTransactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MBSTransactions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `contentId` int NOT NULL,
  `userId` varchar(100) NOT NULL,
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `u_mbst_cid_uid` (`contentId`,`userId`),
  KEY `fk_mbscm_uid_up_uid` (`userId`),
  CONSTRAINT `fk_mbscm_id_mbst_cid` FOREIGN KEY (`contentId`) REFERENCES `MBSContentMaster` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_mbscm_uid_up_uid` FOREIGN KEY (`userId`) REFERENCES `UserProfile` (`UserID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=646 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `MBUserTransactions`
--

DROP TABLE IF EXISTS `MBUserTransactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MBUserTransactions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `broadcastId` int DEFAULT NULL,
  `userId` varchar(255) DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `broadcastId` (`broadcastId`),
  KEY `userId` (`userId`),
  CONSTRAINT `MBUserTransactions_ibfk_1` FOREIGN KEY (`broadcastId`) REFERENCES `ManagementBroadcasts` (`id`),
  CONSTRAINT `MBUserTransactions_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `UserProfile` (`UserID`)
) ENGINE=InnoDB AUTO_INCREMENT=404 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `MLAllTransactions`
--

DROP TABLE IF EXISTS `MLAllTransactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MLAllTransactions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `moduleId` int NOT NULL,
  `userId` varchar(45) NOT NULL,
  `feedbackResponse` json DEFAULT NULL,
  `quizResponse` json DEFAULT NULL,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=746 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `MLCategories`
--

DROP TABLE IF EXISTS `MLCategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MLCategories` (
  `CategoryID` varchar(100) NOT NULL,
  `CategoryName` varchar(45) NOT NULL,
  `MetaData` json DEFAULT NULL,
  `Active` tinyint DEFAULT '1',
  PRIMARY KEY (`CategoryID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `MLModules`
--

DROP TABLE IF EXISTS `MLModules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MLModules` (
  `ModuleID` int NOT NULL AUTO_INCREMENT,
  `ModuleName` varchar(500) NOT NULL,
  `TopicID` int NOT NULL,
  `Content` json DEFAULT NULL,
  `MetaData` json DEFAULT NULL,
  `ImageData` longtext,
  `MinutesAlloted` int DEFAULT NULL,
  `Feedback` json DEFAULT NULL,
  PRIMARY KEY (`ModuleID`),
  KEY `fk_mltopics_topicid_idx` (`TopicID`),
  CONSTRAINT `fk_mltopics_topicid` FOREIGN KEY (`TopicID`) REFERENCES `MLTopics` (`TopicID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=711 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `MLTopics`
--

DROP TABLE IF EXISTS `MLTopics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MLTopics` (
  `TopicID` int NOT NULL AUTO_INCREMENT,
  `MLCategories_CategoryID` varchar(100) NOT NULL,
  `CreatedBy` varchar(45) DEFAULT NULL,
  `DateOfCreation` datetime DEFAULT NULL,
  `PassPercentage` varchar(45) DEFAULT NULL,
  `TimeAllotted` varchar(45) DEFAULT NULL,
  `DistinctionPercentage` varchar(45) DEFAULT NULL,
  `PublishedOn` datetime DEFAULT NULL,
  `TopicName` varchar(100) DEFAULT NULL,
  `Description` varchar(100) DEFAULT NULL,
  `Status` int DEFAULT NULL,
  `TargetGroup` varchar(45) DEFAULT NULL,
  `Token` varchar(45) NOT NULL,
  `LastEditedOn` datetime DEFAULT NULL,
  `LastPublishedOn` datetime DEFAULT NULL,
  `ArchivedOn` datetime DEFAULT NULL,
  `KnowMoreText` varchar(1000) DEFAULT NULL,
  `Dimension` varchar(100) DEFAULT NULL,
  `Variable` json DEFAULT NULL,
  `BehaviouralOutcome` varchar(100) DEFAULT NULL,
  `Active` tinyint DEFAULT '1',
  `Type` tinyint DEFAULT '1',
  `Feedback` json DEFAULT NULL,
  `TargetUsers` json DEFAULT NULL,
  `PTopicID` int DEFAULT NULL,
  `UnPublishedOn` datetime DEFAULT NULL,
  `Data` json DEFAULT NULL,
  `BehaviouralOutcomeFrontend` varchar(255) DEFAULT NULL,
  `BehaviouralOutcomeBackend` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`TopicID`),
  KEY `MLCategories_CategoryID_idx` (`MLCategories_CategoryID`),
  CONSTRAINT `fk_mlcategories_catid` FOREIGN KEY (`MLCategories_CategoryID`) REFERENCES `MLCategories` (`CategoryID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=769 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `MLTransactions`
--

DROP TABLE IF EXISTS `MLTransactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MLTransactions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `moduleId` int NOT NULL,
  `userId` varchar(100) NOT NULL,
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_mlt_mid_mlm_mid` (`moduleId`),
  KEY `fk_mlt_uid_up_uid` (`userId`),
  CONSTRAINT `fk_mlt_mid_mlm_mid` FOREIGN KEY (`moduleId`) REFERENCES `MLModules` (`ModuleID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_mlt_uid_up_uid` FOREIGN KEY (`userId`) REFERENCES `UserProfile` (`UserID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=460 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `MLViewTransactions`
--

DROP TABLE IF EXISTS `MLViewTransactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MLViewTransactions` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `MLTopicId` int NOT NULL,
  `UserId` varchar(100) NOT NULL,
  `CreatedAt` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `MLTopicID_UserID_Unique_Pair` (`MLTopicId`,`UserId`)
) ENGINE=InnoDB AUTO_INCREMENT=599 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ManagementBroadcasts`
--

DROP TABLE IF EXISTS `ManagementBroadcasts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ManagementBroadcasts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(50) NOT NULL,
  `name` varchar(200) NOT NULL,
  `sender` varchar(100) NOT NULL,
  `publishedOn` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dueDate` datetime DEFAULT NULL,
  `status` tinyint unsigned DEFAULT NULL,
  `data` json DEFAULT NULL,
  `Category` int DEFAULT NULL,
  `active` tinyint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_type` (`type`),
  KEY `fk_userid_idx` (`sender`),
  CONSTRAINT `fk_type` FOREIGN KEY (`type`) REFERENCES `BroadcastTypes` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_userid` FOREIGN KEY (`sender`) REFERENCES `UserProfile` (`UserID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=231 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Menu`
--

DROP TABLE IF EXISTS `Menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Menu` (
  `id` int NOT NULL AUTO_INCREMENT,
  `parentId` int DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `menuId` varchar(45) NOT NULL,
  `featureId` int NOT NULL,
  `channel` int NOT NULL,
  `data` json DEFAULT NULL,
  `order` int NOT NULL,
  `status` tinyint NOT NULL DEFAULT '1',
  `token` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `parentId` (`parentId`),
  KEY `fk_menu_fid_fm_id_idx` (`featureId`),
  KEY `fk_menu_channel_c_id` (`channel`),
  CONSTRAINT `fk_menu_channel_c_id` FOREIGN KEY (`channel`) REFERENCES `Channels` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_menu_fid_fm_id` FOREIGN KEY (`featureId`) REFERENCES `FeaturesMaster` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Menu_ibfk_1` FOREIGN KEY (`parentId`) REFERENCES `Menu` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=125 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `NEPNDetailHistory`
--

DROP TABLE IF EXISTS `NEPNDetailHistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `NEPNDetailHistory` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` varchar(100) NOT NULL,
  `deviceId` varchar(200) NOT NULL,
  `deviceType` tinyint(1) NOT NULL,
  `provider` tinyint(1) NOT NULL,
  `os` varchar(45) NOT NULL,
  `osVersion` varchar(45) NOT NULL,
  `deviceManufacturer` varchar(100) NOT NULL,
  `deviceModel` varchar(100) NOT NULL,
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_nepndh_uid_up_uid` (`userId`),
  CONSTRAINT `fk_nepndh_uid_up_uid` FOREIGN KEY (`userId`) REFERENCES `UserProfile` (`UserID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=5026 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `NEPNDetails`
--

DROP TABLE IF EXISTS `NEPNDetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `NEPNDetails` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` varchar(100) NOT NULL,
  `deviceId` varchar(200) NOT NULL,
  `deviceType` tinyint(1) NOT NULL,
  `provider` tinyint(1) NOT NULL,
  `os` varchar(45) NOT NULL,
  `osVersion` varchar(45) NOT NULL,
  `deviceManufacturer` varchar(100) NOT NULL,
  `deviceModel` varchar(100) NOT NULL,
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `u_nepnd_uid` (`userId`),
  CONSTRAINT `fk_nepnd_uid_up_uid` FOREIGN KEY (`userId`) REFERENCES `UserProfile` (`UserID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=5047 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `NERuleMessageTemplates`
--

DROP TABLE IF EXISTS `NERuleMessageTemplates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `NERuleMessageTemplates` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ruleId` varchar(100) NOT NULL,
  `channel` tinyint NOT NULL,
  `data` json DEFAULT NULL,
  `active` tinyint DEFAULT '1',
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `NERules`
--

DROP TABLE IF EXISTS `NERules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `NERules` (
  `id` varchar(100) NOT NULL,
  `token` varchar(100) NOT NULL,
  `description` varchar(500) NOT NULL,
  `data` json DEFAULT NULL,
  `channels` json DEFAULT NULL,
  `active` tinyint DEFAULT '1',
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Nationality`
--

DROP TABLE IF EXISTS `Nationality`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Nationality` (
  `NationalityID` int NOT NULL,
  `NationalityName` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`NationalityID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Notification`
--

DROP TABLE IF EXISTS `Notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Notification` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Title` varchar(255) NOT NULL,
  `Category` int DEFAULT NULL,
  `Description` varchar(255) NOT NULL,
  `Status` int NOT NULL,
  `UserId` varchar(255) NOT NULL,
  `Data` json DEFAULT NULL,
  `CreatedAt` datetime NOT NULL,
  `UpdatedAt` datetime NOT NULL,
  `SubTitle` varchar(255) DEFAULT NULL,
  `SubCategory` int DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `UserId` (`UserId`),
  KEY `SubCategory` (`SubCategory`),
  KEY `Category` (`Category`),
  CONSTRAINT `Category` FOREIGN KEY (`Category`) REFERENCES `NotificationCategory` (`Id`),
  CONSTRAINT `Notification_ibfk_1` FOREIGN KEY (`UserId`) REFERENCES `UserProfile` (`UserID`),
  CONSTRAINT `SubCategory` FOREIGN KEY (`SubCategory`) REFERENCES `NotificationSubCategory` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `NotificationCategory`
--

DROP TABLE IF EXISTS `NotificationCategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `NotificationCategory` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Title` varchar(255) DEFAULT NULL,
  `Data` json DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `NotificationSubCategory`
--

DROP TABLE IF EXISTS `NotificationSubCategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `NotificationSubCategory` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Title` varchar(255) DEFAULT NULL,
  `Category_Id` int DEFAULT NULL,
  `Data` json DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `Category_Id` (`Category_Id`),
  CONSTRAINT `NotificationSubCategory_ibfk_1` FOREIGN KEY (`Category_Id`) REFERENCES `NotificationCategory` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `OSH_MASTER`
--

DROP TABLE IF EXISTS `OSH_MASTER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `OSH_MASTER` (
  `token` varchar(100) NOT NULL,
  `osh_id` int NOT NULL AUTO_INCREMENT,
  `capacity_id` int NOT NULL,
  `capacity_name` varchar(255) NOT NULL,
  `dimension_id` int NOT NULL,
  `dimension_name` varchar(255) NOT NULL,
  `factor_level_id` int NOT NULL,
  `factor_level_name` varchar(255) NOT NULL,
  `factor_id` int NOT NULL,
  `factor_name` varchar(255) NOT NULL,
  `variable_id` int NOT NULL,
  `variable_name` varchar(255) NOT NULL,
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `active` tinyint DEFAULT '1',
  PRIMARY KEY (`osh_id`),
  KEY `idx_capacity_id` (`capacity_id`),
  KEY `idx_dimension_id` (`dimension_id`),
  KEY `idx_factor_level_id` (`factor_level_id`),
  KEY `idx_factor_id` (`factor_id`),
  KEY `idx_variable_id` (`variable_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1124 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `OSH_NORM_FUNCTION_MASTER`
--

DROP TABLE IF EXISTS `OSH_NORM_FUNCTION_MASTER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `OSH_NORM_FUNCTION_MASTER` (
  `NORM_FUNCTION_ID` int NOT NULL AUTO_INCREMENT,
  `NORM_ID` int NOT NULL,
  `NORM` varchar(255) NOT NULL,
  `FUNCTION_ID` int NOT NULL,
  `FUNCTION_NAME` varchar(255) NOT NULL,
  `SCR_LOWER_LIMIT` decimal(10,2) NOT NULL,
  `SCR_UPPER_LIMIT` decimal(10,2) NOT NULL,
  PRIMARY KEY (`NORM_FUNCTION_ID`),
  KEY `idx_NORM_ID` (`NORM_ID`),
  KEY `idx_FUNCTION_ID` (`FUNCTION_ID`),
  KEY `idx_SCR_LOWER_LIMIT` (`SCR_LOWER_LIMIT`),
  KEY `idx_SCR_UPPER_LIMIT` (`SCR_UPPER_LIMIT`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `OSH_QNA_MASTER`
--

DROP TABLE IF EXISTS `OSH_QNA_MASTER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `OSH_QNA_MASTER` (
  `OSH_QNA_ID` int NOT NULL AUTO_INCREMENT,
  `TOKEN` varchar(100) NOT NULL,
  `OSH_ID` int NOT NULL,
  `CAPACITY_ID` int NOT NULL,
  `DIMENSION_ID` int NOT NULL,
  `FACTOR_LEVEL_ID` int NOT NULL,
  `FACTOR_ID` int NOT NULL,
  `VARIABLE_ID` int NOT NULL,
  `TMPLT_ID` int NOT NULL,
  `TMPLT_NAME` varchar(255) NOT NULL,
  `TMPLT_ORDR` int NOT NULL,
  `QSTN_TYPE` varchar(255) NOT NULL,
  `QSTN_ID` int NOT NULL,
  `QSTN_TEXT` text NOT NULL,
  `QSTN_XPLNR` text,
  `QSTN_PTS` decimal(10,2) NOT NULL,
  `QSTN_ORDR` int NOT NULL,
  `ANSR_ID` int NOT NULL,
  `ANSR_OPTN_VAR` varchar(255) DEFAULT NULL,
  `ANSR_OPT_TEXT` text NOT NULL,
  `ANSR_OPT_ORDR` int NOT NULL,
  `ANSR_OPT_IMG_LINK` varchar(255) DEFAULT NULL,
  `ANSR_SCORE_VAR` varchar(255) DEFAULT NULL,
  `SCALE_SCORE` decimal(10,2) DEFAULT NULL,
  `CLSTR_ID` int NOT NULL,
  `CLSTR_NAME` varchar(255) NOT NULL,
  `CLSTR_ORDR` int NOT NULL,
  `CLSTR_QSTN_ORDR` int NOT NULL,
  `ACTIVE` tinyint(1) NOT NULL,
  `CREATED_AT` datetime DEFAULT CURRENT_TIMESTAMP,
  `UPDATED_AT` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`OSH_QNA_ID`),
  KEY `idx_osh_id` (`OSH_ID`),
  KEY `idx_capacity_id` (`CAPACITY_ID`),
  KEY `idx_dimension_id` (`DIMENSION_ID`),
  KEY `idx_factor_level_id` (`FACTOR_LEVEL_ID`),
  KEY `idx_factor_id` (`FACTOR_ID`),
  KEY `idx_variable_id` (`VARIABLE_ID`),
  KEY `idx_tmplt_id` (`TMPLT_ID`),
  KEY `idx_qstn_id` (`QSTN_ID`),
  KEY `idx_ansr_id` (`ANSR_ID`),
  KEY `idx_clrstr_id` (`CLSTR_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=13662 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `OSH_QNA_TEMPLATE_METADATA`
--

DROP TABLE IF EXISTS `OSH_QNA_TEMPLATE_METADATA`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `OSH_QNA_TEMPLATE_METADATA` (
  `COMPANY_ID` int DEFAULT NULL,
  `TEMPLATE_ID` int NOT NULL,
  `TEMPLATE_METADATA_KEY` varchar(255) NOT NULL,
  `TEMPLATE_METADATA_VALUE` varchar(5000) DEFAULT NULL,
  PRIMARY KEY (`TEMPLATE_ID`,`TEMPLATE_METADATA_KEY`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `OSH_QNA_TRANSACTION`
--

DROP TABLE IF EXISTS `OSH_QNA_TRANSACTION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `OSH_QNA_TRANSACTION` (
  `OSH_TRANSACTION_ID` int NOT NULL AUTO_INCREMENT,
  `OSH_ID` int NOT NULL,
  `CAPACITY_ID` int NOT NULL,
  `DIMENSION_ID` int NOT NULL,
  `FACTOR_LEVEL_ID` int NOT NULL,
  `FACTOR_ID` int NOT NULL,
  `VARIABLE_ID` int NOT NULL,
  `USER_ID` varchar(255) NOT NULL,
  `TRANSACTION_CYCLE` int NOT NULL,
  `INTERACTION_SEQ` int NOT NULL,
  `CLUSTER_ID` int NOT NULL,
  `CLUSTER_CYCLE` int NOT NULL,
  `STATUS` varchar(256) DEFAULT NULL,
  `TEMPLATE_ID` int DEFAULT NULL,
  `QSTN_ID` int DEFAULT NULL,
  `SCALE` int NOT NULL,
  `ANS_ID` int DEFAULT NULL,
  `ANS_OPT` text,
  `SCORE` decimal(10,2) DEFAULT NULL,
  `CREATED_BY` varchar(255) NOT NULL,
  `CREATED_TIMESTAMP` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `UPDATED_BY` varchar(255) NOT NULL,
  `UPDATED_TIMESTAMP` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`OSH_TRANSACTION_ID`),
  KEY `idx_osh_id` (`OSH_ID`),
  KEY `idx_capacity_id` (`CAPACITY_ID`),
  KEY `idx_dimension_id` (`DIMENSION_ID`),
  KEY `idx_factor_level_id` (`FACTOR_LEVEL_ID`),
  KEY `idx_factor_id` (`FACTOR_ID`),
  KEY `idx_variable_id` (`VARIABLE_ID`),
  KEY `idx_user_id` (`USER_ID`),
  KEY `idx_transaction_cycle` (`TRANSACTION_CYCLE`),
  KEY `idx_interaction_seq` (`INTERACTION_SEQ`),
  KEY `idx_cluster_id` (`CLUSTER_ID`),
  KEY `idx_cluster_cycle` (`CLUSTER_CYCLE`),
  KEY `idx_ckn_qna_id` (`QSTN_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1192 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `OSH_QNA_TRANSACTION2`
--

DROP TABLE IF EXISTS `OSH_QNA_TRANSACTION2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `OSH_QNA_TRANSACTION2` (
  `OSH_TRANSACTION_AUTO_GEN_KEY` int NOT NULL AUTO_INCREMENT,
  `OSH_TRANSACTION_ID` int DEFAULT NULL,
  `OSH_TRANSACTION_UNIT_ID` int NOT NULL,
  `USER_ID` varchar(255) DEFAULT NULL,
  `TRANSACTION_CYCLE` int DEFAULT NULL,
  `INTERACTION_SEQ` int DEFAULT NULL,
  `CLUSTER_ID` int DEFAULT NULL,
  `CLUSTER_CYCLE` int DEFAULT NULL,
  `STATUS` varchar(255) DEFAULT NULL,
  `TEMPLATE_ID` int DEFAULT NULL,
  `QSTN_ID` int DEFAULT NULL,
  `SCALE` int DEFAULT NULL,
  `ANS_ID` int DEFAULT NULL,
  `ANS_OPT` varchar(255) DEFAULT NULL,
  `OSH_ID` int DEFAULT NULL,
  `VARIABLE_ID` int DEFAULT NULL,
  `VARIABLE_SCORE` decimal(10,2) DEFAULT NULL,
  `VARIABLE_AVG_SCORE` decimal(10,2) DEFAULT NULL,
  `FACTOR_ID` int DEFAULT NULL,
  `FACTOR_SCORE` decimal(10,2) DEFAULT NULL,
  `FACTOR_AVG_SCORE` decimal(10,2) DEFAULT NULL,
  `FACTOR_LEVEL_ID` int DEFAULT NULL,
  `FACTOR_LEVEL_SCORE` decimal(10,2) DEFAULT NULL,
  `FACTOR_LEVEL_AVG_SCORE` decimal(10,2) DEFAULT NULL,
  `DIMENSION_ID` int DEFAULT NULL,
  `DIMENSION_SCORE` decimal(10,2) DEFAULT NULL,
  `DIMENSION_AVG_SCORE` decimal(10,2) DEFAULT NULL,
  `CAPACITY_ID` int DEFAULT NULL,
  `CAPACITY_SCORE` decimal(10,2) DEFAULT NULL,
  `CAPACITY_AVG_SCORE` decimal(10,2) DEFAULT NULL,
  `ORG_ID` int DEFAULT '0',
  `ORG_SCORE` decimal(10,2) DEFAULT NULL,
  `ORG_AVG_SCORE` decimal(10,2) DEFAULT NULL,
  `CREATED_BY` varchar(255) DEFAULT NULL,
  `CREATED_TIMESTAMP` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `UPDATED_BY` varchar(255) DEFAULT NULL,
  `UPDATED_TIMESTAMP` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`OSH_TRANSACTION_AUTO_GEN_KEY`)
) ENGINE=InnoDB AUTO_INCREMENT=12902 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `OSH_SCL_SCR_MASTER`
--

DROP TABLE IF EXISTS `OSH_SCL_SCR_MASTER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `OSH_SCL_SCR_MASTER` (
  `SCALE` int NOT NULL,
  `ANSR_SCORE_VAR` varchar(255) NOT NULL,
  `SCORE_VALUE` decimal(10,2) NOT NULL,
  KEY `idx_SCALE` (`SCALE`),
  KEY `idx_ANSR_SCORE_VAR` (`ANSR_SCORE_VAR`),
  KEY `idx_SCORE_VALUE` (`SCORE_VALUE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `PasswordLog`
--

DROP TABLE IF EXISTS `PasswordLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PasswordLog` (
  `UM_Salted_UserIdSalt` varchar(500) NOT NULL,
  `PwdHash` varchar(500) DEFAULT NULL,
  `CreateDate` datetime DEFAULT NULL,
  `ExpiryDate` datetime DEFAULT NULL,
  KEY `fk_PasswordLog_UM_Salted1_idx` (`UM_Salted_UserIdSalt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Permission`
--

DROP TABLE IF EXISTS `Permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Permission` (
  `PermissionID` int NOT NULL,
  `AccessType` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`PermissionID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `PointTransactions`
--

DROP TABLE IF EXISTS `PointTransactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PointTransactions` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `UserId` varchar(100) NOT NULL,
  `Type` int NOT NULL,
  `ContentId` varchar(200) NOT NULL,
  `Points` int NOT NULL,
  `UnitId` int NOT NULL,
  `DivisionId` int NOT NULL,
  `CreatedAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `IX_UserId_Type_ContentId_UnitId_DivisionId` (`UserId`,`Type`,`ContentId`,`UnitId`,`DivisionId`)
) ENGINE=InnoDB AUTO_INCREMENT=691 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Policies`
--

DROP TABLE IF EXISTS `Policies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Policies` (
  `PolicyID` int NOT NULL,
  `PolicyName` varchar(45) DEFAULT NULL,
  `AccessType` varchar(45) DEFAULT NULL,
  `AccessScript` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`PolicyID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Provisiioning_Connector`
--

DROP TABLE IF EXISTS `Provisiioning_Connector`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Provisiioning_Connector` (
  `ID` int DEFAULT NULL,
  `App_AppID` int NOT NULL,
  `App_TenantID` int NOT NULL,
  `IDP_Name` varchar(45) DEFAULT NULL,
  `Connector_Name` varchar(45) DEFAULT NULL,
  `Is_JIT_Enabled` varchar(45) DEFAULT NULL,
  `Blocking` varchar(45) DEFAULT NULL,
  KEY `fk_Provisiioning_Connector_App1_idx` (`App_AppID`,`App_TenantID`),
  CONSTRAINT `fk_Provisiioning_Connector_App1` FOREIGN KEY (`App_AppID`, `App_TenantID`) REFERENCES `App` (`AppID`, `TenantID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `RankRole`
--

DROP TABLE IF EXISTS `RankRole`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RankRole` (
  `RoleID` int NOT NULL AUTO_INCREMENT,
  `RoleName` varchar(50) DEFAULT NULL,
  `Rating` varchar(45) DEFAULT NULL,
  `UserDept` varchar(45) DEFAULT NULL,
  `LevelName` varchar(255) DEFAULT NULL,
  `RoleDescription` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`RoleID`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `RedAlertChats`
--

DROP TABLE IF EXISTS `RedAlertChats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RedAlertChats` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `userId` varchar(100) NOT NULL,
  `question TODO` varchar(4000) DEFAULT NULL,
  `answer TODO` varchar(4000) DEFAULT NULL,
  `threadId` varchar(200) NOT NULL,
  `category` varchar(100) DEFAULT NULL,
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `markedBy` varchar(100) DEFAULT NULL,
  `status TODO` tinyint DEFAULT '1',
  `reason` varchar(4000) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `threadId_UNIQUE` (`threadId`),
  KEY `fk_rac_uid_up_uid` (`userId`),
  KEY `fk_rac_mb_up_uid_idx` (`markedBy`),
  CONSTRAINT `fk_rac_tid_c_tid` FOREIGN KEY (`threadId`) REFERENCES `Chat` (`threadID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_rac_uid_up_uid` FOREIGN KEY (`userId`) REFERENCES `UserProfile` (`UserID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Req_Path_Authenticator`
--

DROP TABLE IF EXISTS `Req_Path_Authenticator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Req_Path_Authenticator` (
  `ID` int NOT NULL,
  `App_AppID` int NOT NULL,
  `App_TenantID` int NOT NULL,
  `Authenticator_Name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_Req_Path_Authenticator_App1_idx` (`App_AppID`,`App_TenantID`),
  CONSTRAINT `fk_Req_Path_Authenticator_App1` FOREIGN KEY (`App_AppID`, `App_TenantID`) REFERENCES `App` (`AppID`, `TenantID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Role_Mapping`
--

DROP TABLE IF EXISTS `Role_Mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Role_Mapping` (
  `ID` varchar(45) DEFAULT NULL,
  `App_AppID` int NOT NULL,
  `App_TenantID` int NOT NULL,
  `SP_Role` int DEFAULT NULL,
  `RankRole_RoleID` int NOT NULL,
  KEY `fk_Role_Mapping_App1_idx` (`App_AppID`,`App_TenantID`),
  KEY `fk_Role_Mapping_RankRole1_idx` (`RankRole_RoleID`),
  CONSTRAINT `fk_Role_Mapping_App1` FOREIGN KEY (`App_AppID`, `App_TenantID`) REFERENCES `App` (`AppID`, `TenantID`),
  CONSTRAINT `fk_Role_Mapping_RankRole1` FOREIGN KEY (`RankRole_RoleID`) REFERENCES `RankRole` (`RoleID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Subscription`
--

DROP TABLE IF EXISTS `Subscription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Subscription` (
  `SubscriptionID` int NOT NULL,
  `Company_CompanyID` int NOT NULL,
  `FeatureCategory_CategoryID` int NOT NULL,
  `FeatureModule_ModuleID` int NOT NULL,
  PRIMARY KEY (`SubscriptionID`,`Company_CompanyID`,`FeatureCategory_CategoryID`,`FeatureModule_ModuleID`),
  KEY `fk_Subscription_Company1_idx` (`Company_CompanyID`),
  KEY `fk_Subscription_FeatureCategory1_idx` (`FeatureCategory_CategoryID`),
  KEY `fk_Subscription_FeatureModule1_idx` (`FeatureModule_ModuleID`),
  CONSTRAINT `fk_Subscription_Company1` FOREIGN KEY (`Company_CompanyID`) REFERENCES `Company` (`CompanyID`),
  CONSTRAINT `fk_Subscription_FeatureCategory1` FOREIGN KEY (`FeatureCategory_CategoryID`) REFERENCES `FeatureCategory` (`CategoryID`),
  CONSTRAINT `fk_Subscription_FeatureModule1` FOREIGN KEY (`FeatureModule_ModuleID`) REFERENCES `FeatureModule` (`ModuleID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `UM_Salted`
--

DROP TABLE IF EXISTS `UM_Salted`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UM_Salted` (
  `UserIdSalt` varchar(500) NOT NULL,
  `PwdHash` varchar(500) NOT NULL,
  PRIMARY KEY (`UserIdSalt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Unit`
--

DROP TABLE IF EXISTS `Unit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Unit` (
  `UnitID` int NOT NULL AUTO_INCREMENT,
  `UnitName` varchar(50) DEFAULT NULL,
  `Division_DivisionID` int NOT NULL,
  `UnitDescription` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`UnitID`),
  KEY `fk_division_id_idx` (`Division_DivisionID`),
  CONSTRAINT `fk_division_id` FOREIGN KEY (`Division_DivisionID`) REFERENCES `Division` (`DivisionID`)
) ENGINE=InnoDB AUTO_INCREMENT=114 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `UserGroupTransactions`
--

DROP TABLE IF EXISTS `UserGroupTransactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UserGroupTransactions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` varchar(45) NOT NULL,
  `active` tinyint(1) DEFAULT '1',
  `UserGroupId` int DEFAULT NULL,
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `u_ugt_uid_id` (`id`,`userId`),
  KEY `fk_usergroups_userprofiles_id` (`userId`),
  KEY `fk_usergroups_usergroupsmaster_id_idx` (`id`),
  CONSTRAINT `fk_usergroups_userprofiles_id` FOREIGN KEY (`userId`) REFERENCES `UserProfile` (`UserID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `UserGroupsMaster`
--

DROP TABLE IF EXISTS `UserGroupsMaster`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UserGroupsMaster` (
  `id` int NOT NULL AUTO_INCREMENT,
  `companyId` int NOT NULL,
  `aCPolicyId` int DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `active` tinyint(1) DEFAULT '1',
  `createdBy` varchar(45) DEFAULT NULL,
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `u_ugm_cid_name` (`id`,`companyId`,`aCPolicyId`,`name`,`active`),
  KEY `fk_ugm_cid_c_id_idx` (`companyId`),
  CONSTRAINT `fk_ugm_cid_c_id` FOREIGN KEY (`companyId`) REFERENCES `Company` (`CompanyID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `UserHistory`
--

DROP TABLE IF EXISTS `UserHistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UserHistory` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `UserId` varchar(255) DEFAULT NULL,
  `Data` json DEFAULT NULL,
  `ChangedType` int DEFAULT NULL,
  `CreatedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `UserId` (`UserId`),
  CONSTRAINT `UserId` FOREIGN KEY (`UserId`) REFERENCES `UserProfile` (`UserID`)
) ENGINE=InnoDB AUTO_INCREMENT=282 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `UserPhone`
--

DROP TABLE IF EXISTS `UserPhone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UserPhone` (
  `UserProfile_UserID` varchar(100) NOT NULL,
  `PhoneID` varchar(45) NOT NULL,
  `PhoneType` varchar(45) DEFAULT NULL,
  `ContactName` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`UserProfile_UserID`,`PhoneID`),
  KEY `fk_UserPhone_UserProfile1_idx` (`UserProfile_UserID`),
  CONSTRAINT `fk_UserPhone_UserProfile1` FOREIGN KEY (`UserProfile_UserID`) REFERENCES `UserProfile` (`UserID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `UserPolicies`
--

DROP TABLE IF EXISTS `UserPolicies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UserPolicies` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userID` varchar(100) NOT NULL,
  `applicationPolicyID` int NOT NULL,
  `accepted` tinyint(1) NOT NULL,
  `createdDateTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_application_policies_id_idx` (`applicationPolicyID`),
  KEY `fk_user_profile_userid_idx` (`userID`),
  CONSTRAINT `fk_application_policies_id` FOREIGN KEY (`applicationPolicyID`) REFERENCES `AppPolicies` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_user_profile_userid` FOREIGN KEY (`userID`) REFERENCES `UserProfile` (`UserID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=418 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `UserProfile`
--

DROP TABLE IF EXISTS `UserProfile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UserProfile` (
  `UserID` varchar(100) NOT NULL,
  `EmpID` varchar(100) DEFAULT NULL,
  `FirstName` varchar(45) DEFAULT NULL,
  `LastName` varchar(45) DEFAULT NULL,
  `Age` int DEFAULT NULL,
  `DoB` date DEFAULT NULL,
  `NickName` varchar(45) DEFAULT NULL,
  `ImageID` int DEFAULT NULL,
  `Email` varchar(45) DEFAULT NULL,
  `Address` longtext,
  `UserStatus` tinyint DEFAULT NULL,
  `Nationality_NationalityID` int NOT NULL,
  `Designation_DesignationID` int NOT NULL,
  `UM_Salted_UserIdSalt` varchar(500) NOT NULL,
  `RankRole_RoleID` int NOT NULL,
  `Unit_UnitID` int NOT NULL,
  `BloodGroup_BloodGroupID` int DEFAULT NULL,
  `Gender_GenderID` int NOT NULL,
  `SSO_Enabled` tinyint DEFAULT '0',
  `ResetRequired` tinyint DEFAULT '1',
  `MetaData` json DEFAULT NULL,
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `ActivatedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`UserID`,`Unit_UnitID`,`Gender_GenderID`),
  UNIQUE KEY `Email_UNIQUE` (`Email`),
  KEY `fk_UserProfile_Nationality1_idx` (`Nationality_NationalityID`),
  KEY `fk_UserProfile_Designation1_idx` (`Designation_DesignationID`),
  KEY `fk_UserProfile_UM_Salted1_idx` (`UM_Salted_UserIdSalt`),
  KEY `fk_UserProfile_RankRole1_idx` (`RankRole_RoleID`),
  KEY `fk_UserProfile_BloodGroup1_idx` (`BloodGroup_BloodGroupID`),
  KEY `fk_UserProfile_Gender1_idx` (`Gender_GenderID`),
  KEY `fk_UserProfile_Unit1_idx` (`Unit_UnitID`),
  CONSTRAINT `fk_UserProfile_BloodGroup1` FOREIGN KEY (`BloodGroup_BloodGroupID`) REFERENCES `BloodGroup` (`BloodGroupID`),
  CONSTRAINT `fk_UserProfile_Designation1` FOREIGN KEY (`Designation_DesignationID`) REFERENCES `Designation` (`DesignationID`),
  CONSTRAINT `fk_UserProfile_Gender1` FOREIGN KEY (`Gender_GenderID`) REFERENCES `Gender` (`GenderID`),
  CONSTRAINT `fk_UserProfile_Nationality1` FOREIGN KEY (`Nationality_NationalityID`) REFERENCES `Nationality` (`NationalityID`),
  CONSTRAINT `fk_UserProfile_RankRole1` FOREIGN KEY (`RankRole_RoleID`) REFERENCES `RankRole` (`RoleID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_UserProfile_UM_Salted1` FOREIGN KEY (`UM_Salted_UserIdSalt`) REFERENCES `UM_Salted` (`UserIdSalt`),
  CONSTRAINT `fk_UserProfile_Unit1` FOREIGN KEY (`Unit_UnitID`) REFERENCES `Unit` (`UnitID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Vertical`
--

DROP TABLE IF EXISTS `Vertical`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Vertical` (
  `VerticalID` int NOT NULL AUTO_INCREMENT,
  `VerticalName` varchar(45) DEFAULT NULL,
  `VerticalDesc` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`VerticalID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `company_messages`
--

DROP TABLE IF EXISTS `company_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `company_messages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `company_id` int DEFAULT NULL,
  `message_type` enum('error','success','letstalk','ERROR_MESSAGES') NOT NULL,
  `message_code` varchar(50) NOT NULL,
  `message_text` text NOT NULL,
  `message_description` text NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_cid_code_type` (`company_id`,`message_type`,`message_code`),
  CONSTRAINT `fk_companyid` FOREIGN KEY (`company_id`) REFERENCES `Company` (`CompanyID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `company_preferences`
--

DROP TABLE IF EXISTS `company_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `company_preferences` (
  `id` int NOT NULL AUTO_INCREMENT,
  `company_id` int DEFAULT NULL,
  `preference_key` varchar(255) NOT NULL,
  `preference_value` text NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_preference` (`company_id`,`preference_key`),
  UNIQUE KEY `cid_pkey_unique` (`company_id`,`preference_key`),
  CONSTRAINT `fk_company_id` FOREIGN KEY (`company_id`) REFERENCES `Company` (`CompanyID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_activity_log`
--

DROP TABLE IF EXISTS `user_activity_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_activity_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `activity_type` varchar(50) NOT NULL,
  `activity_description` text,
  `activity_timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_preferences`
--

DROP TABLE IF EXISTS `user_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_preferences` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `preference_key` varchar(255) NOT NULL,
  `preference_value` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_preference` (`user_id`,`preference_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'sharkdb'
--

--
-- Dumping routines for database 'sharkdb'
--
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-20 10:50:46
