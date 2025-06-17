CREATE DATABASE  IF NOT EXISTS `velzon` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `velzon`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: velzon
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

--
-- Temporary view structure for view `getallmetadetails`
--

DROP TABLE IF EXISTS `getallmetadetails`;
/*!50001 DROP VIEW IF EXISTS `getallmetadetails`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `getallmetadetails` AS SELECT 
 1 AS `Id`,
 1 AS `LanguageId`,
 1 AS `PagePath`,
 1 AS `PathData`,
 1 AS `MetaTitle`,
 1 AS `MetaDescription`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `getallmetadetails`
--

/*!50001 DROP VIEW IF EXISTS `getallmetadetails`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`darpan`@`127.0.0.1` SQL SECURITY DEFINER */
/*!50001 VIEW `getallmetadetails` AS select `crm`.`MinisterID` AS `Id`,`crm`.`LanguageId` AS `LanguageId`,'/Index' AS `PagePath`,'' AS `PathData`,`crm`.`MetaTitle` AS `MetaTitle`,`crm`.`MetaDescription` AS `MetaDescription` from `ministermasterdetails` `crm` where ((`crm`.`IsDelete` <> 1) and (`crm`.`IsActive` <> 0)) union select `crm`.`BlogMasterId` AS `id`,`crm`.`LanguageId` AS `languageid`,(case when (`crm`.`TypeId` = 1) then '/Home/BlogDetailsList' when (`crm`.`TypeId` = 2) then '/Home/SchemeDetailsList' when (`crm`.`TypeId` = 3) then '/PressReleases' else '/Index' end) AS `PagePath`,'' AS `PathData`,`crm`.`MetaTitle` AS `metatitle`,`crm`.`MetaDescription` AS `metadescription` from `blogmasterdetails` `crm` where ((`crm`.`IsDelete` <> 1) and (`crm`.`IsActive` <> 0) and ((ifnull(`crm`.`MetaTitle`,'') <> '') or (ifnull(`crm`.`MetaDescription`,'') <> ''))) union select `cmsmd`.`CMSMenuResId` AS `id`,`cmsmd`.`LanguageId` AS `languageid`,(case when (`cmsm`.`ResourceType` = 0) then concat('/Home/',`cmsm`.`MenuURL`) else `cmsm`.`MenuURL` end) AS `PagePath`,'' AS `PathData`,`cmsmd`.`MetaTitle` AS `metatitle`,`cmsmd`.`MetaDescription` AS `metadescription` from (`cmsmenuresourcemaster` `cmsm` join `cmsmenuresourcemasterdetails` `cmsmd` on((`cmsm`.`Id` = `cmsmd`.`CMSMenuResId`))) where ((`cmsm`.`col_menu_type` in (0,1)) and (`cmsm`.`IsActive` <> 0) and (`cmsm`.`IsDelete` <> 1) and ((ifnull(`cmsmd`.`MetaTitle`,'') <> '') or (ifnull(`cmsmd`.`MetaDescription`,'') <> ''))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Dumping events for database 'velzon'
--

--
-- Dumping routines for database 'velzon'
--
/*!50003 DROP FUNCTION IF EXISTS `replace_ci` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` FUNCTION `replace_ci`(str text, needle char(255), str_rep char(255)) RETURNS text CHARSET utf8mb4
    DETERMINISTIC
begin
declare return_str text default '';
declare lower_str text;
declare lower_needle text;
declare tmp_needle text;
declare str_origin_char char(1);
declare str_rep_char char(1);
declare final_str_rep text default '';
declare pos int default 1;
declare old_pos int default 1;
declare needle_pos int default 1;

if needle = '' then
    return str;
end if;

select lower(str) into lower_str;
select lower(needle) into lower_needle;
select locate(lower_needle, lower_str, pos) into pos;
while pos > 0 do
    select substr(str, pos, char_length(needle)) into tmp_needle;
    select '' into final_str_rep;
    select 1 into needle_pos;
    while needle_pos <= char_length(tmp_needle) do
        select substr(tmp_needle, needle_pos, 1) into str_origin_char;
        select substr(str_rep, needle_pos, 1) into str_rep_char;
        select concat(final_str_rep, if(binary str_origin_char = lower(str_origin_char), lower(str_rep_char), if(binary str_origin_char = upper(str_origin_char), upper(str_rep_char), str_rep_char))) into final_str_rep;
        select (needle_pos + 1) into needle_pos;
    end while;
    select concat(return_str, substr(str, old_pos, pos - old_pos), final_str_rep) into return_str;
    select pos + char_length(needle) into pos;
    select pos into old_pos;
    select locate(lower_needle, lower_str, pos) into pos;
end while;
select concat(return_str, substr(str, old_pos, char_length(str))) into return_str;
return return_str;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `xsspayload` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` FUNCTION `xsspayload`(pdesc text) RETURNS text CHARSET utf8mb4
    DETERMINISTIC
begin

	  declare done int default 0;
      declare psubstring text;
      declare updatedstring text;
      declare cur cursor for select `payload` from payload;
      declare continue handler for not found set done = 1;
      
      set updatedstring= (pdesc);
      
      open cur;
      label: loop
      fetch cur into psubstring;
      set updatedstring=(select replace_ci(updatedstring,(psubstring),''));
      if done = 1 then leave label;
      end if;
      end loop;
      close cur;
    
    return updatedstring;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsChangePassword` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsChangePassword`(pid int, puserpassword text, pchangedby text)
begin
	update usersmaster set userpassword = puserpassword, updateby = pchangedby, updatedate = now()
    where usersmaster.id = pid;
    
    select pid as recid;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsCheckForgotPasswordDetails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsCheckForgotPasswordDetails`( pemailid text, pipaddress text )
begin
    declare pislogin tinyint;
	declare pipaddresslog text;
	declare pdatetime datetime;
	declare plogtype text;

	set pislogin = 0 ;
    
    set pdatetime=(select entrydatetime from  `forgotpasswordlogdetails` where emailid = pemailid  order by entrydatetime desc limit 1);
    
    
    
    if(ifnull(pdatetime,'')<>'') then 
		if(date_add(pdatetime, interval 30 minute) < (now())) then	
			set pislogin = 1 ;        
		else    
			set pislogin = 0 ;    
		end if;
	else
		set pislogin = 1 ;     
    end if;
    
	select pislogin as `allowlogin`;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsCheckUserDetails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsCheckUserDetails`( puserid bigint, pipaddress text )
begin

    DECLARE pislogin TINYINT DEFAULT 1;
    DECLARE pipaddresslog TEXT;
    DECLARE pdatetime DATETIME;
    DECLARE plogtype TEXT;
    DECLARE pRoleId INT;
    DECLARE vSuperAdmin INT;
    
    -- Get the SuperAdminRoleId, default to 1 if not found
    SELECT COALESCE(CAST(ParameterValue AS UNSIGNED), 1) INTO vSuperAdmin
    FROM configdetails
    WHERE ParameterName = 'SuperAdminRoleId';

    -- Get RoleId for the user
    SELECT RoleId INTO pRoleId
    FROM usersmaster
    WHERE Id = puserid;

    -- Check if user has any log details
    IF (SELECT COUNT(1) FROM `userlogdetails` WHERE userid = puserid) > 0 THEN
        -- Retrieve the latest entrydatetime, logtype, and ipaddress
        SELECT `entrydatetime`, `logtype`, `ipaddress`
        INTO pdatetime, plogtype, pipaddresslog
        FROM `userlogdetails`
        WHERE userid = puserid
        ORDER BY `id` DESC
        LIMIT 1;

        -- If the log type is 'logout', allow login
        IF plogtype = 'logout' THEN
            SET pislogin = 1;

        -- If user is SuperAdmin (RoleId = 1), allow login
        ELSEIF pRoleId = vSuperAdmin THEN
            SET pislogin = 1;

        -- If log type is 'login', perform IP and time interval checks
        ELSE
            IF (DATE_ADD(pdatetime, INTERVAL 5 MINUTE) < NOW() AND plogtype = 'login' AND pipaddresslog = pipaddress) THEN
                SET pislogin = 1;
            ELSEIF (plogtype = 'login' AND pipaddresslog <> pipaddress) THEN
                SET pislogin = 1;
            ELSE
                SET pislogin = 0;
            END IF;
        END IF;

    ELSE
        -- If no log details found, allow login
        SET pislogin = 1;
    END IF;

    -- Return allowlogin value
    SELECT pislogin AS `allowlogin`;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsCheckUserDetailsByDevice` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsCheckUserDetailsByDevice`(pUserId bigint)
BEGIN
   
	DECLARE pIsLogin TINYINT DEFAULT 1;
    DECLARE pDateTime DATETIME;
    DECLARE pLogType TEXT;
    DECLARE pRoleId INT;
    DECLARE vSuperAdmin INT;
    
    -- Get the SuperAdminRoleId, default to 1 if not found
    SELECT COALESCE(CAST(ParameterValue AS UNSIGNED), 1) INTO vSuperAdmin
    FROM configdetails
    WHERE ParameterName = 'SuperAdminRoleId';
    
    -- Get RoleId for the user
    SELECT RoleId INTO pRoleId
    FROM usersmaster
    WHERE Id = puserid;

    -- Check if the user has any log details
    IF (SELECT COUNT(1) FROM `userlogdetails` WHERE UserId = pUserId) > 0 THEN
        -- Retrieve the latest EntryDatetime and LogType
        SELECT `EntryDatetime`, `LogType`
        INTO pDateTime, pLogType
        FROM `userlogdetails`
        WHERE UserId = pUserId
        ORDER BY `Id` DESC
        LIMIT 1;

        -- If the log type is 'logout', allow login
        IF pLogType = 'logout' THEN
            SET pIsLogin = 1;

		-- If user is SuperAdmin (RoleId = 1), allow login
        ELSEIF pRoleId = vSuperAdmin THEN
            SET pislogin = 1;
            
        -- If the log type is 'login', check time interval
        ELSE
            IF (DATE_ADD(pDateTime, INTERVAL 5 MINUTE) < NOW() AND pLogType = 'login') THEN
                SET pIsLogin = 1;
            ELSEIF pLogType = 'login' THEN
                SET pIsLogin = 0;
            ELSE
                SET pIsLogin = 1;
            END IF;
        END IF;

    ELSE
        -- If no log details found, allow login
        SET pIsLogin = 1;
    END IF;

    -- Return DeviceAllowLogin value
    SELECT pIsLogin AS `DeviceAllowLogin`;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsDeleteVideoMasterUrls` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsDeleteVideoMasterUrls`(
	pVideoMasterId bigint
)
BEGIN
	delete from `videomasterurls` where `VideoMasterId`= pVideoMasterId ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsFrontUserChangePassword` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsFrontUserChangePassword`(pid int, puserpassword text, pchangedby text)
begin
	update frontusermaster set userpassword = puserpassword, updateby = pchangedby, updatedate = now()
    where frontusermaster.id = pid;
    
    select pid as recid;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsFrontUserSessionUpdate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsFrontUserSessionUpdate`(pid int,pSessionVersion text)
begin
	update frontusermaster set SessionVersion = pSessionVersion, updatedate = now()
    where frontusermaster.id = pid;
    
    select pid as recid;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetAllAchievementsImages` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetAllAchievementsImages`(
pblogmasterid bigint
-- planguageid text
)
begin

select * from blogmasterimages where blogmasterid= pblogmasterid ;
-- and languageid=planguageid;
 
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetAllAdminMenuMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetAllAdminMenuMaster`()
begin
	select amm.*,mrem.menuurl,
    (case
        when amm.parentid = 0 then ''
        else (select subamm.name from adminmenumaster as subamm where subamm.id=amm.parentid order by subamm.id limit 1 )
    end) as parentname
    from adminmenumaster as amm 
    left join menuresourcemaster as mrem on amm.menuid = mrem.id and amm.isdelete<>1 and amm.isactive=1
    where amm.isdelete<>1 order by amm.menurank;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetAllAlbumFirstData` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetAllAlbumFirstData`(langid int)
begin
select cmsmd.*,
(select imagepath from gallerymasterimages as bmg where bmg.gallerymasterid=cmsm.id limit 1) as firstimagepath
 from gallerymaster as cmsm 
inner join gallerymasterdetails as cmsmd 
on cmsm.id=cmsmd.gallerymasterid and cmsmd.languageid=ifnull(langid,1)
where cmsm.isdelete<>1 and cmsmd.isdelete<>1 and cmsm.isactive<>0 and cmsmd.isactive<>0 order by albumrank asc ; 
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetAllAlbumImages` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetAllAlbumImages`(in p_id text,planguageid int)
BEGIN
	select yeim.*,gmd.PlaceName from  `gallerymasterimages` AS yeim 
	inner join `gallerymaster` AS yem on yeim.`gallerymasterId` = yem.`Id` 
	inner join `gallerymasterdetails` as gmd on gmd.`GalleryMasterId`=yem.`Id` and gmd.`LanguageId`=ifnull(planguageid,1)
	WHERE
		IFNULL(yem.`IsActive`, 0) = 1
			AND IFNULL(yem.`IsDelete`, 0) = 0
			and yeim.gallerymasterId=p_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetAllBannerMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetAllBannerMaster`(
langid int
)
begin

	select cmsmd.* from bannermaster as cmsm 
	inner join bannermasterdetails as cmsmd 
	on cmsm.id=cmsmd.bannerid and cmsmd.languageid= langid
	where cmsm.isdelete<>1 and cmsmd.isdelete<>1;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetAllBlogMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetAllBlogMaster`(
langid int
)
begin
	select cmsmd.*,btm.blogtypename as typename ,
	(select imagepath from blogmasterimages as bmg where bmg.blogmasterid=cmsm.id limit 1) as firstimagepath
	,date_format(cmsmd.blogdate,'%d-%b-%y') as blogdateconvert
	 from blogmaster as cmsm 
	inner join blogmasterdetails as cmsmd 
    left join blogtypemaster as btm on btm.Id=cmsmd.typeId
	on cmsm.id=cmsmd.blogmasterid and cmsmd.languageid=ifnull(langid,1)
	where cmsm.isdelete<>1 and cmsmd.isdelete<>1 order by createddate desc ;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetAllBlogTypeMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetAllBlogTypeMaster`()
begin
select * from blogtypemaster where IsDelete<>1;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetAllBranchMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetAllBranchMaster`(
LangId int
)
BEGIN
	SELECT CMSMD.* FROM branchmaster as CMSM 
	inner join branchmasterdetails as CMSMD 
	on CMSM.Id=CMSMD.Branchid and CMSMD.LanguageId=IFNULL(LangId,1)
	 where CMSM.IsDelete<>1 and CMSMD.IsDelete<>1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetAllBrandPresenceMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetAllBrandPresenceMaster`(
langid int
)
begin
select cmsmd.* from brandpresencemaster as cmsm 
inner join brandpresencemasterdetails as cmsmd 
on cmsm.id=cmsmd.brandpresenceid and cmsmd.languageid=ifnull(langid,1)
where cmsm.isdelete<>1 and cmsm.isdelete<>1;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetAllCMSMenuMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetAllCMSMenuMaster`()
begin
select amm.*,mrem.resourcetype as pagetype,cmsmd.pagedescription,cmsmd.cmsmenuresid as menuresid,cmsmd.IsFullScreen
    from cmsmenuresourcemaster as amm 
    left join cmsmenuresourcemaster as mrem on amm.id = mrem.id and ifnull(mrem.isdelete,0)<>1 and mrem.isactive=1
inner join cmsmenuresourcemasterdetails as cmsmd 
on mrem.id=cmsmd.cmsmenuresid and cmsmd.languageid=1
    where ifnull(amm.isdelete,0)<>1 order by amm.menurank;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetAllCMSMenuResourceMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetAllCMSMenuResourceMaster`(
langid int
)
begin

select cmsmd.*,cmsm.*,  
  (case
        when cmsm.col_parent_id = 0 then cmsmd.menuname -- then ''
               else (select rm.menuname from cmsmenuresourcemasterdetails as rm 
               where rm.cmsmenuresid =cmsm.col_parent_id and rm.languageid =ifnull(langid,1) 
       group by rm.menuname order by cmsm.id  limit 1 )
    end) as parentname from cmsmenuresourcemaster as cmsm 
inner join cmsmenuresourcemasterdetails as cmsmd 
on cmsm.id=cmsmd.cmsmenuresid and languageid=ifnull(langid,1)
where 
-- cmsm.isactive<>0 and 
cmsm.isdelete<>1  order by  cmsm.menurank ;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetAllCMSMenuResourceMasterRank` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetAllCMSMenuResourceMasterRank`(

)
begin


select * from cmsmenuresourcemaster;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetAllCMSTemplteMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetAllCMSTemplteMaster`(
langid int
)
begin


select cmsmd.*,cmsm.templatetype from cmstempltemaster as cmsm 
inner join cmstempltemasterdetails as cmsmd 
on cmsm.id=cmsmd.templateid and languageid=ifnull(langid,1)
where cmsm.isdelete<>1;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetAllCssMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetAllCssMaster`()
begin
select * from cssmaster where ifnull(isdelete,0)=0;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetAllCssMasterData` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetAllCssMasterData`()
BEGIN
select * from cssmaster where  IsActive=1 and ifnull(IsDelete,0)=0; -- order by Id desc;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetAllDisctrictMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetAllDisctrictMaster`()
begin
select * from districtmaster where ifnull(IsDelete,0) <> 1
order by DistrictName ;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetAllDistrictProductData` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetAllDistrictProductData`(
LangId bigint
)
begin
select * from districtproduct where ifnull(IsDelete,0) <> 1 And LanguageId = LangId;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetAllDistrictProfileData` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetAllDistrictProfileData`(
    IN LangId bigint
)
BEGIN
    SELECT dp.*,dm.DistrictName
    FROM districtprofile dp
    JOIN districtmaster dm ON dp.DistrictId = dm.Id
    WHERE IFNULL(dp.IsDelete, 0) <> 1 
      AND dp.LanguageId = LangId
    ORDER BY dm.DistrictName;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetAllDocumentMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetAllDocumentMaster`(
	planguageid int
)
begin
	select *,file_name as couchfile from document_master 
    where languageid=planguageid and isdelete<>1 order by doc_id desc;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetAllEcitizenMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetAllEcitizenMaster`(
langid int
)
begin

	select cmsmd.*,cmsmt.Name as EcitizenTypeName, bmd.BranchName 
    from ecitizenmaster as cmsm 
	inner join ecitizenmasterdetails as cmsmd on cmsm.Id = cmsmd.EcitizenId
    INNER join ecitizenmastertype as cmsmt on cmsmd.EcitizenTypeId=cmsmt.Id and cmsmt.IsVisible=1
    left join branchmasterdetails as bmd on bmd.Id=cmsmd.BranchId and cmsmd.LanguageId=bmd.LanguageId
	where cmsm.isdelete<>1 and cmsmd.isdelete<>1 and cmsmd.LanguageId=IFNULL(langid,1) order by createddate desc ;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetAllEcitizenMasterType` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetAllEcitizenMasterType`()
BEGIN
	SELECT * FROM ecitizenmastertype where IsVisible<>0;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetAllEventApplications` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetAllEventApplications`()
BEGIN
  SELECT
    ea.*,ea.Id as EventApplicationId,
    fu.FirstName,
    fu.MiddleName,
    fu.LastName,
    fu.email,
    fu.PhoneNo,
    fu.Address,
    fu.state,
    fu.city,
    fu.CreateDate as UserRegisteredDate,
    em.*
    
    
  FROM eventapplications AS ea
  JOIN frontusermaster fu on ea.UserId = fu.Id
  JOIN eventmasterdetails em on ea.EventId  =  em.EventMasterId
  WHERE fu.IsDelete <> 1 and em.IsDelete <> 1
  Order By  ea.AppliedDate DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetAllEventEmailLogs` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetAllEventEmailLogs`()
BEGIN
  SELECT
    el.*,el.EventId as EventMasterId,
    em.Location,em.EventStartDate,em.EventEndDate
  FROM eventemaillogdetails AS el
  join eventmasterdetails as em on em.EventMasterId = el.EventId 
  Order By  el.CreatedDate DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetAllEventImages` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetAllEventImages`(
	pEventMasterId bigint
)
begin

	select * from eventmasterimages where EventMasterId= pEventMasterId;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetAllEventMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetAllEventMaster`(
    pLangId INT
)
BEGIN
    SELECT 
        CMSMD.*,
        (SELECT ImagePath FROM eventmasterimages AS CMSMI WHERE CMSMI.EventMasterId = CMSM.Id LIMIT 1) AS firstimagepath,
        DATE_FORMAT(CMSMD.eventstartdate, '%d-%b-%y') AS blogdateconvert,
        CONCAT(DATE_FORMAT(eventStartDate, '%d/%m/%Y %h:%i %p'), ' - ', DATE_FORMAT(eventEndDate, '%d/%m/%Y %h:%i %p')) AS eventdate,
        TIME_FORMAT(CMSMD.eventstartdate, '%H:%i') AS EventStartTime,  -- Extract EventStartTime (HH:MM)
        TIME_FORMAT(CMSMD.eventenddate, '%H:%i') AS EventEndTime       -- Extract EventEndTime (HH:MM)
    FROM 
        eventmaster AS CMSM
    INNER JOIN 
        eventmasterdetails AS CMSMD 
        ON CMSM.Id = CMSMD.EventMasterId AND CMSMD.LanguageId = IFNULL(pLangId, 1)
    WHERE 
        CMSM.IsDelete <> 1 
        AND CMSMD.IsDelete <> 1 
    ORDER BY 
        CMSMD.CreatedDate DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetAllFrontUserMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetAllFrontUserMaster`()
BEGIN
  SELECT
    UM.*,UM.ApplicantPhoto as ApplicantPhotoPath,
    IFNULL(COUNT(DISTINCT EA.eventid), 0) AS TotalParticipatedEvent,
    (SELECT MAX(LD.EntryDateTime) 
     FROM frontuserlogdetails AS LD
     WHERE LD.UserId = UM.Id AND LD.LogType = 'login') AS LastLoginDate
  FROM frontusermaster AS UM
  left join eventapplications as EA on EA.UserId  = UM.Id
  WHERE UM.IsDelete <> 1
  GROUP BY UM.Id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetAllGalleryImages` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetAllGalleryImages`(
pgallerymasterid bigint
)
begin

   select * from gallerymasterimages where gallerymasterid= pgallerymasterid;
  
 end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetAllGalleryMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetAllGalleryMaster`(langid int)
begin
select cmsmd.*,
(select imagepath from gallerymasterimages as bmg where bmg.gallerymasterid=cmsm.id limit 1) as firstimagepath
 from gallerymaster as cmsm 
inner join gallerymasterdetails as cmsmd 
on cmsm.id=cmsmd.gallerymasterid and cmsmd.languageid=ifnull(langid,1)
where cmsm.isdelete<>1 and cmsmd.isdelete<>1 order by createddate desc ;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetAllGoiLogoMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetAllGoiLogoMaster`(
	planguageid int
)
begin
	select *,imagename as logoimage from goilogomaster 
    where isdelete<>1;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetAllHomePageData` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetAllHomePageData`()
begin
-- 1 banner 
select bannerid,title,description,imagepath from bannermasterdetails where isactive=1 and isdelete=0 ;

-- 2 minister
select ministerid,ministername,ministerdescription,imagepath from ministermasterdetails where isactive=1 and isdelete=0 ;

-- 3 news master
select newsid,newsdesc from newsmasterdetails where newstypeid=1 and isactive=1 and isdelete=0 ;

-- 4 key initiatives
select blogid,blogname,imagepath from blogmasterdetails where isactive=1 and isdelete=0 ;

-- 5 blogs
select blogid,blogname,imagepath from blogmasterdetails where isactive=1 and isdelete=0 ;

-- 6 reports
select blogid,blogname,imagepath from blogmasterdetails where isactive=1 and isdelete=0 ;

-- news 
 
select newsid,newstitle,imagepath,createddate from newsmasterdetails where newstypeid='r' and isactive=1 and isdelete=0;

select newsid,newstitle,imagepath,createddate from newsmasterdetails where newstypeid='n' and isactive=1 and isdelete=0;

select newsid,newstitle,imagepath,createddate from newsmasterdetails where newstypeid='e' and isactive=1 and isdelete=0;

-- goi footer logo
select id,logoname,imagepath,url,imagename from goilogomaster where isactive=1 and isdelete=0 ;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetAllJsMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetAllJsMaster`()
begin
select * from jsmaster where ifnull(isdelete,0)=0;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetAllJsMasterData` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetAllJsMasterData`()
BEGIN
select * from jsmaster where  IsActive=1 and ifnull(IsDelete,0)=0; -- order by Id desc;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetAllLanguage` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetAllLanguage`()
BEGIN
	select id,name,isvisible from cmslanguagemaster where IFNULL(isdelete, 0) <> 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetAllMenuResourceMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetAllMenuResourceMaster`()
begin
	select * from menuresourcemaster as amm  where amm.isdelete<>1;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetAllMenuRightsMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetAllMenuRightsMaster`()
begin
	
select amm.id,amm.menurank,mrem.id as menuresourceid,mrem.menuname as menuresourcename,amm.name,amm.menutype,amm.parentid,(select amms.name from adminmenumaster as amms where amms.id=amm.parentid order by amms.id limit 1) as parentname,mrem.menuurl,mrm.insert,mrm.update,mrm.delete,mrm.view,mrm.lastupdateby 
from menurightsmaster as mrm 
inner join menuresourcemaster as mrem on mrem.id = mrm.menuid and mrem.isdelete<>1 and mrem.isactive=1
inner join adminmenumaster as amm on amm.menuid = mrem.id and amm.isdelete<>1 and amm.isactive=1
order by amm.menurank;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetAllMenuRightsMasterByRoleId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetAllMenuRightsMasterByRoleId`( UserRoleId int)
begin
	SELECT AMM.Id,AMM.MenuRank,MReM.Id as MenuResourceId,MReM.MenuName as MenuResourceName,
	AMM.Name,AMM.MenuType,AMM.MenuIcon,AMM.ParentId ,(select AMMs.name from adminmenumaster as AMMs
	where AMMs.id=AMM.ParentId order by AMMs.id limit 1) as ParentName,Trim(replace(MReM.MenuURL,'	','')) as MenuURL,MRM.Insert,MRM.Update,MRM.Delete,MRM.View,MRM.LastUpdateBy
	FROM menurightsmaster as MRM 
	inner join adminmenumaster as AMM on AMM.Id = MRM.MenuId and AMM.IsDelete<>1 and AMM.IsActive=1
	inner join menuresourcemaster as MReM on MReM.id = AMM.MenuId and MReM.IsDelete<>1 and MReM.IsActive=1 
	where MRM.RoleId=UserRoleId
	order by AMM.MenuRank;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetAllMetaData` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetAllMetaData`(languageid int, searchtext text)
begin
	IF(searchtext != '') then
	select distinct id,
           pagepath,
           pathdata,
           languageid,
           metatitle,
           metadescription from getallmetadetails 
		   where
		   metadescription is not null and   metatitle is not null 
		   and (metatitle like concat('%', searchtext, '%')
		   or metadescription like concat('%', searchtext, '%')); 
	END IF;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetAllMinisterMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetAllMinisterMaster`(
langid int
)
begin
select cmsmd.* from ministermaster as cmsm 
inner join ministermasterdetails as cmsmd 
on cmsm.id=cmsmd.ministerid and cmsmd.languageid=ifnull(langid,1)
where cmsm.isdelete<>1 and cmsm.isdelete<>1;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetAllNewsMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetAllNewsMaster`(
langid int
)
begin

	SELECT CMSMD.*,CMSMT.Name as NewsTypeName
	FROM newsmaster as CMSM 
	inner join newsmasterdetails as CMSMD 
	inner join newsmastertype as CMSMT on CMSMT.Id=CMSMD.NewsTypeId and CMSMT.IsVisible=1
	on CMSM.Id=CMSMD.NewsId and CMSMD.LanguageId=IFNULL(LangId,1)
	where CMSM.IsDelete<>1 and CMSMD.IsDelete<>1
    order by createddate desc;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetAllNewsMasterType` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetAllNewsMasterType`()
begin
	SELECT CMSMT.* FROM newsmastertype as CMSMT where CMSMT.IsVisible<>0;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetAllPanoramaImages` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetAllPanoramaImages`(
langid int
)
begin
	select bmi.*, bmi.Imagepath as firstimagepath from blogmasterimages as bmi
    left join blogmasterdetails as bmd on bmd.blogmasterId = bmi.blogmasterId
    where bmd.typeId = 4 and
    bmd.isactive = true and 
    bmd.isdelete = false and
    bmd.languageid=ifnull(langid,1);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetAllPopupMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetAllPopupMaster`(langid int)
begin
select cmsmd.* from popupmaster as cmsm 
inner join popupmasterdetails as cmsmd 
on cmsm.id=cmsmd.popupid and cmsmd.languageid=ifnull(langid,1)
where cmsm.isdelete<>1 and cmsm.isdelete<>1;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetAllProcessedProductData` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetAllProcessedProductData`(
LangId bigint
)
begin
select * from processedproduct where ifnull(IsDelete,0) <> 1 And LanguageId = LangId;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetAllProcessingUnitAndPortMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetAllProcessingUnitAndPortMaster`(
LangId bigint
)
begin
select * from processingunitandport where ifnull(IsDelete,0) <> 1 And LanguageId = LangId;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetAllProductMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetAllProductMaster`()
begin
select * from productmaster where ifnull(IsDelete,0) <> 1 order by ProductName ASC;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetAllRoleMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetAllRoleMaster`()
begin
	select * from rolemaster where isdelete<>1;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetAllSearchedAdminMenu` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetAllSearchedAdminMenu`(
	IN pRoleId BIGINT,
    IN pSearchText VARCHAR(100)
)
BEGIN
	DECLARE done INT DEFAULT FALSE;
    DECLARE v_menuName VARCHAR(255);
	DECLARE v_menuUrl VARCHAR(255);
	DECLARE v_menuIcon VARCHAR(255);
    
    -- Cursor for menu items with View permission and matching search
    DECLARE cur CURSOR FOR
        SELECT a.Name, res.MenuURL, a.MenuIcon
        FROM adminmenumaster a
        JOIN menurightsmaster r ON r.MenuId = a.Id
        JOIN menuresourcemaster res ON res.Id = a.MenuId
        WHERE r.RoleId = pRoleId
          AND r.View = 1
          AND res.MenuURL IS NOT NULL
          AND res.MenuURL != '#'
          AND res.MenuURL LIKE CONCAT('%', pSearchText, '%');

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    -- Add the Pages heading first    
    SET @strInnerHtml = 
        '<div class="dropdown-header mt-2">
            <h6 class="text-overflow text-muted mb-1 text-uppercase">Pages</h6>
        </div>';

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO v_menuName, v_menuUrl, v_menuIcon;
        IF done THEN
            LEAVE read_loop;
        END IF;

        SET @strInnerHtml = CONCAT(@strInnerHtml,
				'<a href="', v_menuUrl, '" class="dropdown-item notify-item">
			<i class="', IFNULL(v_menuIcon, 'ri-bubble-chart-line'), ' align-middle fs-18 text-muted me-2"></i>
			<span>', v_menuName, '</span>
		</a>');
    END LOOP;

    CLOSE cur;

    SELECT @strInnerHtml AS Search;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetAllServiceRateMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetAllServiceRateMaster`(langid int)
BEGIN

select srmd.* from serviceratemaster as sm
inner join serviceratemasterdetails as srmd
on sm.id = srmd.servicerateid  and srmd.languageid=ifnull(langid,1)
where sm.isdelete<>1 and srmd.isdelete<>1;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetAllStatisticDataMasterType` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetAllStatisticDataMasterType`()
begin
    SELECT * FROM statisticdatamastertype where IsVisible<>0;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetAllStatisticMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetAllStatisticMaster`(
langid int
)
begin

	select cmsmd.*,cmsmt.Name as StatisticTypeName from statisticdatamaster as cmsm 
	inner join statisticdatamasterdetails as cmsmd on cmsm.id=cmsmd.statisticdataid and cmsmd.languageid=ifnull(langid,1)
    inner join statisticdatamastertype as cmsmt on cmsmd.StatisticTypeId=cmsmt.Id and cmsmt.IsVisible=1
	where cmsm.isdelete<>1 and cmsmd.isdelete<>1 order by createddate desc ;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetAllUserByRole` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetAllUserByRole`(
	pRoleId int
)
BEGIN
	
    select * from usersmaster where DeleteDate is null and RoleId = pRoleId;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetAllUserMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetAllUserMaster`()
begin
	select UM.*,(select RM.RoleName from rolemaster as RM where RM.Id=UM.RoleId limit 1) as RoleName,
    (select RA.IsActive from rolemaster as RA where RA.Id=UM.RoleId limit 1) as IsRoleActive
	FROM usersmaster as UM WHERE UM.IsDelete<>1;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetAllUtilityLockedUsers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetAllUtilityLockedUsers`()
BEGIN

	DECLARE vInterval, vSuperAdmin INT;

    -- Fetch Interval and SuperAdmin Role
    SELECT COALESCE(CAST(ParameterValue AS UNSIGNED), 15) INTO vInterval
    FROM configdetails
    WHERE ParameterName = 'IntervalWrongAttemptInMinutes';

    SELECT COALESCE(CAST(ParameterValue AS UNSIGNED), 1) INTO vSuperAdmin
    FROM configdetails
    WHERE ParameterName = 'SuperAdminRoleId';

    -- Main Query
    SELECT * 
	FROM (
		SELECT 
			ROW_NUMBER() OVER (
				PARTITION BY x.UserId 
				ORDER BY 
					CASE 
						WHEN x.isLocked = 1 AND x.updatedBy IS NULL AND x.lastEntry >= NOW() - INTERVAL vInterval MINUTE THEN 1
						WHEN x.isLocked = 1 AND x.updatedBy IS NOT NULL THEN 1
						ELSE 0
					END DESC
			) AS srno,

			x.UserId,
			x.Username,
			x.lastEntry AS LastEntryDatetime,
			x.updatedBy AS UpdateBy,

			CASE
				WHEN x.isLocked = 1 AND x.updatedBy IS NULL AND x.lastEntry >= NOW() - INTERVAL vInterval MINUTE THEN 'Locked by wrong attempts'
				WHEN x.isLocked = 1 AND x.updatedBy IS NOT NULL THEN 'Locked by admin'
				ELSE 'Not Locked'
			END AS LockStatus,

			CASE
				WHEN x.isLocked = 1 AND x.updatedBy IS NULL AND x.lastEntry >= NOW() - INTERVAL vInterval MINUTE THEN 1
				WHEN x.isLocked = 1 AND x.updatedBy IS NOT NULL THEN 1
				ELSE 0
			END AS IsLock

		FROM (
			SELECT 
				uld.UserId,
				um.Username,
				MAX(uld.EntryDatetime) AS lastEntry,
				MAX(uld.UpdateBy) AS updatedBy,
				MAX(uld.IsLock) AS isLocked
			FROM userlogdetails uld
			INNER JOIN usersmaster um ON um.Id = uld.UserId
			WHERE um.IsActive = 1 
			  AND um.IsDelete = 0 
			  AND um.RoleId <> vSuperAdmin
			GROUP BY uld.UserId, um.Username
		) AS x
	) AS final

    -- Select only the latest entry for each UserId
    WHERE srno = 1;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetAllVideoMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetAllVideoMaster`(pLangid int)
BEGIN
    SELECT GMD.*,(SELECT VideoUrl FROM videomasterurls AS GMI WHERE GMI.VideoMasterId=GM.Id LIMIT 1) AS VideoUrl,
    (SELECT ThumbImage FROM videomasterurls AS GMI WHERE GMI.VideoMasterId=GM.Id LIMIT 1) AS ThumbImage,
    (SELECT VideoName FROM videomasterurls AS GMI WHERE GMI.VideoMasterId=GM.Id LIMIT 1) AS VideoName
	FROM videomaster AS GM 
	INNER JOIN videomasterdetails AS GMD 
	ON GM.id=GMD.VideoId AND GMD.LanguageId=ifnull(pLangId,1)
	WHERE GM.IsDelete<>1 AND GMD.IsDelete<>1 ORDER BY GM.CreateDate DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetAllVideoMasterUrls` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetAllVideoMasterUrls`(
	pVideoMasterId bigint
)
BEGIN
	Select Id, VideoMasterId, VideoName, ThumbImage, VideoUrl, uploadedname, uploadedurl, islinkvideo as urllink
	from videomasterurls where VideoMasterId=pVideoMasterId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetConfigdetailsByName` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetConfigdetailsByName`(parameternames text)
begin
 select id,
           parametername,
           parametervalue,
           description from configdetails where parametername=parameternames;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetCssByName` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetCssByName`(In PCssName text)
begin
select * from cssmaster where ifnull(isdelete,0)=0 and Title=PCssName;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetDistrictProfileByDistrict` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetDistrictProfileByDistrict`(
pLangId bigint
)
begin
SELECT 
    p.Id AS Id,
    p.LanguageId AS LanguageId,
    p.DistrictProfileId AS DistrictProfileId,
    d.DistrictName AS DistrictName,
    d.DistrictNameGuj AS DistrictNameGuj,
    p.Population AS Population,
    p.SexRatio AS SexRatio,
    p.LiteracyRate AS LiteracyRate,
    p.DistrictDescription AS DistrictDescription,
    p.FileName As FileName,
    p.FilePath As FilePath
FROM 
    districtprofile p
INNER JOIN 
    districtmaster d ON p.DistrictId = d.Id
WHERE 
    IFNULL(p.IsDelete, 0) <> 1 AND IFNULL(p.IsActive, 0) = 1 
    AND p.LanguageId = pLangId
GROUP BY
    p.DistrictId;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetFeedbackData` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetFeedbackData`(

)
begin


select * from feedbackfromuser order by id desc;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetFeesDocument` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetFeesDocument`(
planguageid int
)
BEGIN
select *,file_name as couchfile from document_master 
    where languageid=1 and Doc_Name= 'feeDocument' and isdelete<>1 order by doc_id desc limit 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetIsLockCount` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetIsLockCount`(pUserName text)
BEGIN

	select count(*) AS IsLockCount
	from userlogdetails as ud
	left join usersmaster as um on ud.UserId = um.Id
	where um.Username = pUserName AND ud.IsLock = 1;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetJsByName` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetJsByName`(In PJsName text)
begin
select * from jsmaster where ifnull(isdelete,0)=0 and Title=PJsName;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetLanguageById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetLanguageById`(
    pid INT
)
BEGIN
    SELECT 
        id,
        name,
        isvisible
    FROM
        cmslanguagemaster
    WHERE
        id = pid; 

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetListLanguage` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetListLanguage`()
begin
select * from cmslanguagemaster where isvisible<>0;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetLoginFrontUsersMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetLoginFrontUsersMaster`(p_userusername text, p_userpassword text)
begin
	select  `id`,
`firstname`,
`middlename`,
`lastname`,
`email`,
`phoneno`,
`isactive`,
`ispasswordreset`,
`applicantphoto` as applicantphotopath,
`designation`,
`SessionVersion`,
`UserPassword`
from frontusermaster  
        where `userpassword` = p_userpassword and `Email`=`p_userusername`
        AND isdelete <> 1;
   
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetLoginUsersMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetLoginUsersMaster`(p_userusername text, p_userpassword text)
begin
	select  `id`,
`roleid`,
`firstname`,
`lastname`,
`email`,
`username` as username,
`phoneno`,
`profilepic`,
`lastlogindate`,
`userpassword`,
`isactive`,
`ispasswordreset`,
(select RA.IsActive from rolemaster as RA where RA.Id=usersmaster.RoleId limit 1) as IsRoleActive
from usersmaster  where  binary `username` = p_userusername  -- Case-sensitive comparison
        AND `userpassword` = p_userpassword 
        AND isdelete <> 1;
    -- from usersmaster where `username` = p_userusername and `userpassword` = p_userpassword and isdelete <>1;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetPageDataFromPageName` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetPageDataFromPageName`( 
 in p_pageid int )
begin

select  replace(r.pagedescription,concat ("{{", trim(templatename),"}}"),t.content) as pagedescription
-- r.pagedescription,concat ("{{", templatename,"}}"),t.content
from cmstempltemasterdetails t 
inner join cmsmenuresourcemasterdetails r on r.templateid=t.templateid
where r.id = p_pageid;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetProcessingUnitAndPortByDistrict` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetProcessingUnitAndPortByDistrict`(
pLangId bigint
)
begin
SELECT 
    p.Id AS Id,
    p.LanguageId AS LanguageId,
    p.ProcessingUnitandPortId AS ProcessingUnitandPortId,
    d.DistrictName AS DistrictName,
    d.DistrictNameGuj AS DistrictNameGuj,
    p.TotalProcessingUnit AS TotalProcessingUnit,
    p.MSME AS MSME,
    p.TotalLargeUnits AS TotalLargeUnits,
    p.TotalPorts AS TotalPorts,
    p.MajorCrops As MajorCrops,
    p.AvailableInfrastructure As AvailableInfrastructure,
    p.LargeUnits As LargeUnits
FROM 
    processingunitandport p
INNER JOIN 
    districtmaster d ON p.DistrictId = d.Id
WHERE 
    IFNULL(p.IsDelete, 0) <> 1  AND IFNULL(p.IsActive, 0) = 1 
    AND p.LanguageId = pLangId
GROUP BY
    p.DistrictId;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetUserIdByUserName` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetUserIdByUserName`(Puserusername text)
BEGIN
	select  `Id`
    FROM usersmaster where `Username` = Puserusername AND IsDelete <>1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsGetWrongAttemptCount` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsGetWrongAttemptCount`(pUserName text, pipAddress text)
BEGIN
	DECLARE vInterval, vSuperAdmin INT;
    -- Variable to store the count of wrong attempts and is lock value
    DECLARE vAttemptsLogin, vIsLocked INT DEFAULT 0; 

	-- Get the interval in minutes for wrong attempt count, default to 15 if not found
    SELECT COALESCE(CAST(ParameterValue AS UNSIGNED), 15) INTO vInterval
    FROM configdetails
    WHERE ParameterName = 'IntervalWrongAttemptInMinutes';
    
    -- Get the SuperAdminRoleId, default to 1 if not found
    SELECT COALESCE(CAST(ParameterValue AS UNSIGNED), 1) INTO vSuperAdmin
    FROM configdetails
    WHERE ParameterName = 'SuperAdminRoleId';

    -- Use the interval in minutes to filter records in the query
    -- Count the number of wrong login attempts within the specified interval
    SELECT 
		CASE 
			WHEN  um.RoleId = vSuperAdmin OR COUNT(ud.UpdateBy) > 0 THEN 0  -- If RoleId = 1, return 0 as AttemptCount
			ELSE COUNT(*)  -- Otherwise, count the records
		END INTO vAttemptsLogin
	FROM userlogdetails AS ud
	LEFT JOIN usersmaster AS um ON ud.UserId = um.Id
	WHERE um.Username = pUserName
	AND (
		(um.RoleId = vSuperAdmin)  -- Bypass IP address check if RoleId = 1
		OR (um.RoleId != vSuperAdmin AND ud.IPAddress = pipAddress)  -- Check IP address if RoleId is not 1
	)
	AND LogType = 'login'
	AND ud.WrongAttempt = 1
	AND ud.EntryDatetime >= NOW() - INTERVAL vInterval MINUTE;

    -- Get the most recent IsLock status
    SELECT ud.IsLock INTO vIsLocked
    FROM userlogdetails AS ud
    LEFT JOIN usersmaster AS um ON ud.UserId = um.Id
    WHERE (um.Username = pUserName AND IsLock = 1 AND ud.UpdateBy IS NOT NULL)
    ORDER BY ud.EntryDatetime DESC
    LIMIT 1;
    
    -- Return both AttemptsLogin and IsLock values
    SELECT vAttemptsLogin AS AttemptsLogin, vIsLocked AS IsLocked;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsInsertAchievementsImages` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsInsertAchievementsImages`(
pblogmasterid bigint,
pimagename text,
pimagepath text
-- planguageid text
)
begin

		insert into blogmasterimages
        (
			blogmasterid,
            imagename,
            imagepath
           -- languageid
		) 
        values
        (
			pblogmasterid,
            pimagename,
            pimagepath
            -- planguageid
		);
        

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsInsertEventEmailLogDetails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsInsertEventEmailLogDetails`(
	pUserId bigint,
	pUserName text,
    pEmail text,
    pEventId bigint,
	pEventName text,
	pIsEmailsent tinyint,
    pAdminId bigint,
    pSentBy text

)
BEGIN
		INSERT INTO `eventemaillogdetails` (
            `UserId`,
            `UserName`,
            `Email`,
            `EventId`,
            `EventName`,
            `IsEmailsent`,
            `AdminId`,
            `SentBy`,
            `CreatedDate`
        ) VALUES (
            pUserId,
            pUserName,
            pEmail,
            pEventId,
            pEventName,
            pIsEmailsent,
            pAdminId,
            pSentBy,
            NOW()
        );
        
        SELECT LAST_INSERT_ID() AS InsertedId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsInsertEventImages` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsInsertEventImages`(
	peventmasterid bigint,
	pimagename text,
	pimagepath text
)
begin

		insert into eventmasterimages
        (
			eventmasterid,
            imagename,
            imagepath
		) 
        values
        (
			peventmasterid,
            pimagename,
            pimagepath
		);
        
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsInsertFeedbackDetails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsInsertFeedbackDetails`(
pfname text,
plname text,
pemail text,
pmobileno text,
pzip text,
psubject text,
pcountry text,
pstate text,
pcity text,
paddress text,
pfeedbackdetails text
)
begin
declare id int;
insert into `feedbackfromuser`
(`fname`,`lname`, `email`, `mobileno`,`zip`,`subject`,`country`,`state`,`city`,`address`, `feedbackdetails`, `createddate`)
values
( pfname,plname,pemail,pmobileno,pzip,psubject,pcountry,pstate,pcity,paddress,pfeedbackdetails, now());

set id=last_insert_id();
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsInsertForgotPasswordLogDetails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsInsertForgotPasswordLogDetails`(
pemailid text,
plogtype text,
pipaddress text,
in pdetails text
)
begin

insert into `forgotpasswordlogdetails`
(
`emailid`,
`logtype`,
`entrydatetime`,
`ipaddress`,
`details`)
values
(
pemailid,
plogtype,
now(),
pipaddress,
pdetails
);

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsInsertFrontUserMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsInsertFrontUserMaster`(
pFirstName text, 
pMiddleName text,
pLastName text, 
pEmail text,
pPhoneNo text,
pUserPassword text,
pIsActive tinyint,
pCreateBy text,
pIsPasswordReset int
)
BEGIN
    INSERT INTO frontusermaster (
    FirstName,
    MiddleName,
    LastName,
    Email,
    PhoneNo,
    UserPassword,
    IsActive,
    CreateBy,
    CreateDate,
    IsPasswordReset
    )
      VALUES (pFirstName, pMiddleName, pLastName,pEmail, pPhoneNo,pUserPassword, 1, pCreateBy, NOW(),pIsPasswordReset);

  SELECT
    LAST_INSERT_ID() AS id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsInsertGalleryImages` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsInsertGalleryImages`(
pgallerymasterid bigint,
pimagename text,
pimagepath text
)
begin

		insert into gallerymasterimages
        (
			gallerymasterid,
            imagename,
            imagepath
		) 
        values
        (
			pgallerymasterid,
            pimagename,
            pimagepath
		);
        

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsInsertLogFrontUserDetails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsInsertLogFrontUserDetails`(
	pUserId bigint,
	pLogType text,
	pIPAddress text,
	in pDetails text

)
BEGIN
		INSERT INTO `frontuserlogdetails` (
            `UserId`,
            `LogType`,
            `EntryDatetime`,
            `IPAddress`,
            `Details`
        ) VALUES (
            pUserId,
            pLogType,
            NOW(),
            pIPAddress,
            pDetails
        );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsInsertLogUserDetails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsInsertLogUserDetails`(
	pUserId bigint,
	pLogType text,
	pIPAddress text,
	in pDetails text,
	pWorngattempt tinyint
)
BEGIN
	DECLARE vInterval, vSuperAdmin INT;
    -- Variable to store the count of wrong attempts and is lock value
    DECLARE vAttemptsLogin, vIsLocked INT DEFAULT 0; 

	-- Get the interval in minutes for wrong attempt count, default to 15 if not found
    SELECT COALESCE(CAST(ParameterValue AS UNSIGNED), 15) INTO vInterval
    FROM configdetails
    WHERE ParameterName = 'IntervalWrongAttemptInMinutes';
    
    -- Get the SuperAdminRoleId, default to 1 if not found
    SELECT COALESCE(CAST(ParameterValue AS UNSIGNED), 1) INTO vSuperAdmin
    FROM configdetails
    WHERE ParameterName = 'SuperAdminRoleId';
    
    -- Use the interval in minutes to filter records in the query
    -- Count the number of wrong login attempts within the specified interval
    SELECT 
		CASE 
			WHEN um.RoleId = vSuperAdmin THEN 0  -- If RoleId = 1, return 0 as AttemptCount
			ELSE COUNT(*)  -- Otherwise, count the records
		END INTO vAttemptsLogin
	FROM userlogdetails AS ud
	LEFT JOIN usersmaster AS um ON ud.UserId = um.Id
	WHERE um.Id = pUserId
	AND (
		(um.RoleId = vSuperAdmin)  -- Bypass IP address check if RoleId = 1
		OR (um.RoleId != vSuperAdmin AND ud.IPAddress = pipAddress)  -- Check IP address if RoleId is not 1
	)
	AND LogType = 'login'
	AND ud.WrongAttempt = 1
	AND ud.EntryDatetime >= NOW() - INTERVAL vInterval MINUTE;

    -- If the count of wrong attempts is equal to 3
    IF vAttemptsLogin = 2 THEN
		INSERT INTO `userlogdetails` (
            `UserId`,
            `LogType`,
            `EntryDatetime`,
            `IPAddress`,
            `Details`,
            `WrongAttempt`,
            `IsLock`
        ) VALUES (
            pUserId,
            pLogType,
            NOW(),
            pIPAddress,
            pDetails,
            pWorngattempt,
            1
        );
    ELSE
        INSERT INTO `userlogdetails` (
            `UserId`,
            `LogType`,
            `EntryDatetime`,
            `IPAddress`,
            `Details`,
            `WrongAttempt`
        ) VALUES (
            pUserId,
            pLogType,
            NOW(),
            pIPAddress,
            pDetails,
            pWorngattempt
        );
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsInsertMenuRightsMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsInsertMenuRightsMaster`(
pRoleId int,
pMenuId int,
pInsert bit,
pUpdate bit,
pDelete bit,
pView bit,
pLastUpdateBy text
)
BEGIN
INSERT INTO `menurightsmaster`
(
`RoleId`,
`MenuId`,
`Insert`,
`Update`,
`Delete`,
`View`,
`LastUpdateBy`
)
VALUES
(
pRoleId,
pMenuId,
pInsert,
pUpdate,
pDelete,
pView,
pLastUpdateBy
);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsInsertOrUpdateAdminMenuMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsInsertOrUpdateAdminMenuMaster`(
	id int,
    menuid int,
    name text,
    menutype int,
    menuicon text,
    parentid int,
    menurank int,
    isactive tinyint,
    changedby text
)
begin
	if(id = 0) then
		insert into adminmenumaster(menuid,name,menutype,menuicon,parentid,menurank,isactive,createby,createdate) values(menuid,name,menutype,menuicon,parentid,menurank,isactive,changedby,now());
        set id=last_insert_id();
	else
		if(menutype != 1) then
			set parentid=0;
		end if;
        update adminmenumaster set menuid=menuid,name=name,menutype=menutype,menuicon=menuicon,parentid=parentid,menurank=menurank,isactive=isactive,updateby=changedby,updatedate=now() where adminmenumaster.id=id;
    end if;
    select id as recid;
    
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsInsertOrUpdateBannerMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsInsertOrUpdateBannerMaster`(
id int,
languageid int,
title text,
purl text,
description text,
imagename text,
imagepath text,
bannerrank int,
isactive tinyint,
username text
)
begin
set title = XSSPAyLoad(title);
set purl = XSSPAyLoad(purl);
set description = XSSPAyLoad(description);
if(id=0) then 

insert into `bannermaster`(`isactive`,`isdelete`,`createdby`,`createddate`)values(isactive,0,username,now());

set id=last_insert_id();

insert into `bannermasterdetails`
(
`bannerid`,`languageid`,`title`,`url`,`description`,`imagename`,`imagepath`,`bannerrank`,`isactive`,`isdelete`,`createdby`,`createddate`)
values
(
id,languageid,title,purl,replace(replace(replace(replace(replace(description,'embed',''),'javascript:alert',''),'alert',''),'prompt',''),'svg',''),imagename,imagepath,bannerrank,isactive,0,username,now());

else 

update `bannermaster` set 
isactive=isactive , 
updatedby=username,
updateddate=now() 
where id=id;

update `bannermasterdetails`
set 
title=title,
url=purl,
description=replace(replace(replace(replace(replace(description,'embed',''),'javascript:alert',''),'alert',''),'prompt',''),'svg',''),
bannerrank=bannerrank,
imagename=(case when ifnull(imagename,'')<>'' then imagename else imagename end),
imagepath=(case when ifnull(imagepath,'')<>'' then imagepath else imagepath end),
isactive=isactive , 
updatedby=username,
updateddate=now()
where bannerid=id and languageid=languageid;

end if;
select id as recid;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsInsertOrUpdateBlogMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsInsertOrUpdateBlogMaster`(
pid bigint,
planguageid int,
pblogname varchar(300),
filename longtext,
filepath text,
pdescription longtext,
pMetaTitle longtext,
pMetaDescription longtext,
pTypeId bigint,
pblogmasterid bigint,
-- blogby varchar(45),
pblogdate datetime,
pisactive tinyint,
plocation text,
pusername text
)
begin
    set pdescription = XSSPAyLoad(pdescription);
    if(pid=0) then 

        -- Insert new blog master record
        insert into `blogmaster`(`isactive`,`isdelete`,`createdby`,`createddate`) 
        values(pisactive,0,pusername,now());

        set pblogmasterid = last_insert_id();

        -- Insert new blog master details record
        insert into `blogmasterdetails`
        (
            `languageid`, `blogname`, `fileupload`, `filepath`, `description`, `blogmasterid`, `blogdate`, 
            `location`, `isactive`, `isdelete`, `createdby`, `createddate`, `MetaTitle`, `MetaDescription`, `TypeId`
        )
        values
        (
            planguageid, pblogname, filename, filepath, pdescription, pblogmasterid, pblogdate, plocation, 
            pisactive, 0, pusername, now(), pMetaTitle, pMetaDescription, pTypeId
        );

        select pblogmasterid;

    else 
        -- Update the blog master record
        update `blogmaster` set 
            isactive = pisactive, 
            updatedby = pusername,
            updateddate = now() 
        where id = pid;

        -- Check if the blogmasterdetails record exists
        if (select count(1) 
            from `blogmasterdetails` 
            where `blogmasterid` = pid and `languageid` = planguageid) > 0 then
        
            -- Update the existing blogmasterdetails record
            update `blogmasterdetails`
            set 
                blogname = pblogname,
                fileupload = (case when ifnull(filename,'') <> '' then filename else fileupload end),
                filepath = (case when ifnull(filepath,'') <> '' then filepath else filepath end),
                description = pdescription,
                blogdate = pblogdate,
                location = plocation,
                isactive = pisactive, 
                updatedby = pusername,
                updateddate = now(),
                MetaTitle = pMetaTitle,
                MetaDescription = pMetaDescription,
                TypeId = pTypeId
            where `blogmasterid` = pid and `languageid` = planguageid;
            
            select pid;

        else 
            -- If the blogmasterdetails record does not exist, insert a new one
            insert into `blogmasterdetails`
            (
                `languageid`, `blogname`, `fileupload`, `filepath`, `description`, `blogmasterid`, `blogdate`, 
                `location`, `isactive`, `isdelete`, `createdby`, `createddate`, `MetaTitle`, `MetaDescription`, `TypeId`
            )
            values
            (
                planguageid, pblogname, filename, filepath, pdescription, pblogmasterid, pblogdate, 
                plocation, pisactive, 0, pusername, now(), pMetaTitle, pMetaDescription, pTypeId
            );

            select pid;

        end if;
    end if;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsInsertOrUpdateBranchMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsInsertOrUpdateBranchMaster`(
pId int,
pLanguageId int ,
pBranchName text,
pIsActive tinyint,
pUsername text
)
BEGIN

if(pId=0) then  
INSERT INTO `branchmaster`(`IsActive`,`IsDelete`,`CreatedBy`,`CreatedDate`)VALUES(pIsActive,0,pUsername,now());

set pId=last_insert_id();

INSERT INTO `branchmasterdetails`
(
`Branchid`,`LanguageId`,`Branchname`,`IsActive`,`IsDelete`,`CreatedBy`,`CreatedDate`)
VALUES
(pId,pLanguageId,pBranchName,pIsActive,0,pUsername,now());
 

else 

update `branchmaster` set 
`IsActive`=pIsActive , 
`UpdatedBy`=pUsername,
`UpdatedDate`=now() 
where `Id`=pId;

if((select count(1) from `branchmasterdetails` where Branchid=pId and LanguageId=pLanguageId )>0) then

update `branchmasterdetails`
set 
`Branchname`=pBranchName,
`IsActive`=pIsActive , 
`UpdatedBy`=pUsername,
`UpdatedDate`=now()

where `Branchid`=pId and `LanguageId`=pLanguageId;

else 

INSERT INTO `branchmasterdetails`
(
`Branchid`,`LanguageId`,`Branchname`,`IsActive`,`IsDelete`,`CreatedBy`,`CreatedDate`)
VALUES
(pId,pLanguageId,pBranchName,pIsActive,0,pUsername,now());

end if;
end if;
select pId as RecId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsInsertOrUpdatebrandpresenceMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsInsertOrUpdatebrandpresenceMaster`(
pid int,
planguageid int,
pbrandpresenceid int,
pbrandpresencename text,
pshortdescription text,
pbrandpresencedescription text,
pimagename text,
pimagepath text,
pisactive tinyint,
pusername text,
pmetatitle text,
pmetadescription text
)
begin
-- set pbrandpresencedescription = XSSPAyLoad(pbrandpresencedescription);
if(pid=0) then 

insert into `brandpresencemaster`(`isactive`,`isdelete`,`createdby`,`createddate`)values(pisactive,0,pusername,now());

set pid=last_insert_id();

insert into `brandpresencemasterdetails`
(
`brandpresenceid`,`languageid`,`brandpresencename`,`shortdescription`,`brandpresencedescription`,`imagename`,`imagepath`,`isactive`,`isdelete`,`createdby`,`createddate`,`metatitle`,`metadescription`)
values
(
pid,planguageid,pbrandpresencename,pshortdescription,pbrandpresencedescription,pimagename,pimagepath,pisactive,0,pusername,now(),pmetatitle,pmetadescription);

else 

update `brandpresencemaster` set 
isactive=pisactive , 
updatedby=pusername,
updateddate=now() 
where id=pid;

if((select count(1) from `brandpresencemasterdetails` where brandpresenceid=pid and languageid=planguageid )>0) then

update `brandpresencemasterdetails` set 
brandpresencename=pbrandpresencename,
shortdescription=pshortdescription,
brandpresencedescription= pbrandpresencedescription,
imagename=(case when ifnull(pimagename,'')<>'' then pimagename else pimagename end),
imagepath=(case when ifnull(pimagepath,'')<>'' then pimagepath else pimagepath end),
isactive=pisactive , 
updatedby=pusername,
updateddate=now(),
metatitle=pmetatitle,
metadescription=pmetadescription
where 
brandpresenceid=pid and languageid=planguageid;

UPDATE `brandpresencemasterdetails` SET `IsActive` = pisactive WHERE `brandpresenceid` = pid;

else 
insert into `brandpresencemasterdetails`
(
`brandpresenceid`,`languageid`,`brandpresencename`,`shortdescription`,`brandpresencedescription`,`imagename`,`imagepath`,`isactive`,`isdelete`,`createdby`,`createddate`,`metatitle`,`metadescription`)
values
(
pid,planguageid,pbrandpresencename,pshortdescription,pbrandpresencedescription,pimagename,pimagepath,pisactive,0,pusername,now(),pmetatitle,pmetadescription);
end if;

end if;

select pid as recid;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsInsertOrUpdateCMSMenuResourceMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsInsertOrUpdateCMSMenuResourceMaster`(
p_id int,planguageid int,pmenuname text,
pmenuurl text,ptooltip text,ppagedescription longtext,
presourcetype int,ptemplateid text,pisactive tinyint,pusername text,pcol_parent_id int,pcol_menu_type varchar(100),menurank int,pmetatitle text,pmetadescription text,pisredirect tinyint,pIsFullScreen tinyint,
pbannerimagepath text,piconimagepath text
)
begin
set pmenuname = XSSPAyLoad(pmenuname);
set pmenuurl = XSSPAyLoad(pmenuurl);
set ptooltip = XSSPAyLoad(ptooltip);
set ppagedescription = XSSPAyLoad(ppagedescription);
set pmetatitle = XSSPAyLoad(pmetatitle);
set pmetadescription = XSSPAyLoad(pmetadescription);
if(p_id=0) then 

insert into `cmsmenuresourcemaster`(
`isactive`,`isdelete`,`createdby`,`createddate`,`menurank`,`menuurl`,`resourcetype`,`templateid`,`col_parent_id`,`col_menu_type`
)values(pisactive,0,pusername,now(),menurank,pmenuurl,presourcetype,ptemplateid,pcol_parent_id,pcol_menu_type);

set p_id=last_insert_id();

insert into `cmsmenuresourcemasterdetails`
(
`cmsmenuresid`,`languageid`,`menuname`,`tooltip`,`pagedescription`,`isactive`,`isdelete`,`createdby`,`createddate`,`metatitle`,`metadescription`,`isredirect`,`IsFullScreen`,`BannerImagePath`,`IconImagePath`)
values
(
p_id,planguageid,pmenuname,ptooltip,ppagedescription,pisactive,0,pusername,now(),pmetatitle,pmetadescription,pisredirect,pIsFullScreen,pbannerimagepath,piconimagepath);

else 
if(pcol_menu_type != 1) then
	set pcol_parent_id=0;
end if;
update `cmsmenuresourcemaster` set isactive=pisactive ,menuurl=pmenuurl,resourcetype=presourcetype,templateid=ptemplateid,col_parent_id=pcol_parent_id,col_menu_type=pcol_menu_type, updatedby=pusername,updateddate=now(),menurank=menurank where id=p_id;

if((select count(1) from `cmsmenuresourcemasterdetails` where cmsmenuresid=p_id and languageid=planguageid )>0) then

update `cmsmenuresourcemasterdetails`
set 
 menuname=pmenuname,tooltip=ptooltip,
 pagedescription=ppagedescription,
isactive=pisactive ,
isredirect=pisredirect,
IsFullScreen=pIsFullScreen,
 updatedby=pusername,
 updateddate=now(),
 metatitle=pmetatitle,
 metadescription=pmetadescription,
 bannerimagepath = pbannerimagepath,
 iconimagepath = piconimagepath
where cmsmenuresid=p_id and languageid=planguageid;

else 
insert into `cmsmenuresourcemasterdetails`
(
`cmsmenuresid`,`languageid`,`menuname`,`tooltip`,`pagedescription`,`isactive`,`isdelete`,`createdby`,`createddate`,`metatitle`,`metadescription`,`isredirect`,`IsFullScreen`,`BannerImagePath`,`IconImagePath`)
values
(
p_id,planguageid,pmenuname,ptooltip,ppagedescription,pisactive,0,pusername,now(),pmetatitle,pmetadescription,pisredirect,pIsFullScreen,pbannerimagepath,piconimagepath);

end if;
end if;

select p_id as recid;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsInsertOrUpdateCMSMenuResourceMasterSwap` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsInsertOrUpdateCMSMenuResourceMasterSwap`(
 id int,
 menurank int,
 username text)
begin
	
        update cmsmenuresourcemaster set
        menurank=menurank,
        updatedby=username,
        updateddate=now()
        where cmsmenuresourcemaster.id=id;
    
    select id as recid;
    
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsInsertOrUpdateCMSTemplteMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsInsertOrUpdateCMSTemplteMaster`(
    pid int,
    planguageid int,
    ptemplatename text,
    pcontent text,
    ptemplatetype int,
    pisactive tinyint,
    pusername text
)
BEGIN
 
    SET pcontent = XSSPAyLoad(pcontent);

    IF(pid = 0) THEN
      
        INSERT INTO `cmstempltemaster`(`templatetype`, `isactive`, `isdelete`, `createdby`, `createddate`)
        VALUES (ptemplatetype, pisactive, 0, pusername, NOW());

        SET pid = LAST_INSERT_ID();

        INSERT INTO `cmstempltemasterdetails`
        (
            `templateid`, `languageid`, `templatename`, `content`, `isactive`, `isdelete`, `createdby`, `createddate`
        )
        VALUES
        (
            pid, planguageid, ptemplatename,
            REPLACE(REPLACE(REPLACE(pcontent, 'javascript:alert', ''), 'alert', ''), 'prompt', ''),
            pisactive, 0, pusername, NOW()
        );

    ELSE
      
        UPDATE `cmstempltemaster`
        SET 
            templatetype = ptemplatetype,
            isactive = pisactive, 
            updatedby = pusername,
            updateddate = NOW() 
        WHERE id = pid;

        IF((SELECT COUNT(1) FROM `cmstempltemasterdetails` WHERE templateid = pid AND languageid = planguageid) > 0) THEN
           
            INSERT INTO `cmstemplatemasterdetailshistory`
            (
                `cmstempdetailid`, `languageid`, `templateid`, `templatename`, `content`, `isdelete`, `isactive`,
                `createdby`, `createddate`, `updatedby`, `updateddate`, `deletedby`, `deleteddate`
            )
            SELECT cmsde.`id`, cmsde.`languageid`, cmsde.`templateid`, cmsde.`templatename`, cmsde.`content`, cmsde.`isdelete`, 
                   cmsde.`isactive`, cmsde.`createdby`, cmsde.`createddate`, cmsde.`updatedby`, cmsde.`updateddate`, 
                   cmsde.`deletedby`, cmsde.`deleteddate`
            FROM `cmstempltemasterdetails` AS cmsde 
            WHERE cmsde.`templateid` = pid AND cmsde.`languageid` = planguageid;

            -- Update cmstempltemasterdetails
            UPDATE `cmstempltemasterdetails`
            SET 
                templatename = ptemplatename,
                content = REPLACE(REPLACE(REPLACE(pcontent, 'javascript:alert', ''), 'alert', ''), 'prompt', ''),
                isactive = pisactive, 
                updatedby = pusername,
                updateddate = NOW()
            WHERE 
                templateid = pid AND languageid = planguageid;

        ELSE
           
            INSERT INTO `cmstempltemasterdetails`
            (
                `templateid`, `languageid`, `templatename`, `content`, `isactive`, `isdelete`, `createdby`, `createddate`
            )
            VALUES
            (
                pid, planguageid, ptemplatename,
                REPLACE(REPLACE(REPLACE(pcontent, 'javascript:alert', ''), 'alert', ''), 'prompt', ''),
                pisactive, 0, pusername, NOW()
            );

        END IF;

    END IF;

    SELECT pid AS recid;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsInsertOrUpdateCssMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsInsertOrUpdateCssMaster`(
id int,title text,cssfile longtext,isactive tinyint,username text
)
begin

if(id = 0) then 

insert into `cssmaster`(`title`,`cssfile`,`isactive`,`isdelete`,`createdby`,`createddate`)values(title,cssfile,isactive,0,username,now());

set id=last_insert_id();

else 

update cssmaster set 
title=title,
cssfile=cssfile,
isactive=isactive , 
updatedby=username,
updateddate=now() 
where cssmaster.id=id;

end if;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsInsertOrUpdateDistrictMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsInsertOrUpdateDistrictMaster`(
pId bigint,
pDistrictName text,
pDistrictNameGuj text,
pLatitude text,
pLongitude text,
pIsActive bool,
pUsername text
 )
begin
Declare RowCount int;

select count(Id) into RowCount from districtmaster where Id = pId;

if RowCount > 0 THEN
UPDATE districtmaster 
        SET 
            DistrictName = pDistrictName,
            DistrictNameGuj = pDistrictNameGuj,
            Latitude = pLatitude,
            Longitude = pLongitude,
            IsActive = pIsActive,
            UpdatedBy = pUsername,  -- Assuming you have a column for who updated the record
            UpdatedAt = NOW()      -- Assuming you have a column for when the record was updated
        WHERE Id = pId;
    ELSE
      -- Insert a new record
        INSERT INTO districtmaster 
        (
            DistrictName, 
            DistrictNameGuj, 
            Latitude, 
            Longitude, 
            IsActive, 
            CreatedBy,       -- Assuming you have a column for who created the record
            CreatedAt      -- Assuming you have a column for when the record was created
        ) 
        VALUES 
        (
            pDistrictName, 
            pDistrictNameGuj, 
            pLatitude, 
            pLongitude, 
            pIsActive, 
            pUsername, 
            NOW()
        );
    END IF;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsInsertOrUpdateDistrictProductData` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsInsertOrUpdateDistrictProductData`(
    IN pId bigint,
    IN pDistrictId bigint,
    IN pProductId bigint,
    IN pDistrictProductId bigint,
    IN pLanguageId bigint,
    IN pProductioninMT text,
    IN pImageName text,
	IN pImagePath text,
    IN pFileName text,
    IN pFilePath text,
    IN pIsActive bool,
    IN pUsername text
)
BEGIN
    DECLARE RowCount INT;
    DECLARE maxDistrictProductId BIGINT;

    -- Check if the record exists based on processingunitandportId and LanguageId
    SELECT COUNT(*) INTO RowCount 
    FROM districtproduct
    WHERE DistrictProductId = pDistrictProductId
      AND LanguageId = pLanguageId;

    IF RowCount > 0 THEN
        -- Update the existing record
        UPDATE districtproduct 
        SET 
            DistrictId = pDistrictId,
            ProductId = pProductId,
            ProductioninMT = pProductioninMT,
            ImageName = pImageName,
            ImagePath = pImagePath,
            FileName = pFileName,
            FilePath = pFilePath,
            IsActive = pIsActive,
            UpdatedBy = pUsername,  
            UpdatedAt = NOW()      
        WHERE DistrictProductId = pDistrictProductId
          AND LanguageId = pLanguageId;
    ELSE
        -- Insert a new record
        -- Find the maximum processingunitandportId for the given language
        SELECT IFNULL(MAX(DistrictProductId), 0) + 1 INTO maxDistrictProductId 
        FROM districtproduct 
        WHERE LanguageId = pLanguageId;
        IF pId > 0 THEN
                INSERT INTO districtproduct
                (
                    DistrictProductId, 
                    LanguageId, 
                    DistrictId, 
                    ProductId, 
                    ProductioninMT, 
                    ImageName, 
                    ImagePath, 
                    FileName, 
                    FilePath, 
                    IsActive,
                    CreatedBy,      
                    CreatedAt,
                    IsDelete
                ) 
                VALUES 
                (
                    pDistrictProductId, 
                    pLanguageId, 
                    pDistrictId, 
                    pProductId, 
                    pProductioninMT, 
                    pImageName, 
                    pImagePath, 
                    pFileName, 
                    pFilePath, 
                    pIsActive, 
                    pUsername, 
                    NOW(),
                    0
                );
            ELSE
             INSERT INTO districtproduct
                (
                    DistrictProductId, 
                    LanguageId, 
                    DistrictId, 
                    ProductId, 
                    ProductioninMT, 
                    ImageName, 
                    ImagePath, 
                    FileName, 
                    FilePath, 
                    IsActive,
                    CreatedBy,      
                    CreatedAt,
                    IsDelete
                ) 
                VALUES 
                (
                    maxDistrictProductId, 
                    pLanguageId, 
                    pDistrictId, 
                    pProductId, 
                    pProductioninMT, 
                    pImageName, 
                    pImagePath, 
                    pFileName, 
                    pFilePath, 
                    pIsActive, 
                    pUsername, 
                    NOW(),
                    0
                );
        END IF;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsInsertOrUpdateDistrictProfileData` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsInsertOrUpdateDistrictProfileData`(
    IN pId bigint,
    IN pDistrictId bigint,
    IN pDistrictProfileId bigint,
    IN pLanguageId bigint,
    IN pPopulation text,
    IN pSexRatio text,
    IN pLiteracyRate text,
    IN pDistrictDescription text,
    IN pFileName text,
    IN pFilePath text,
    IN pIsActive bool,
    IN pUsername text
)
BEGIN
    DECLARE RowCount INT;
    DECLARE maxDistrictProfileId BIGINT;
    set pDistrictDescription = XSSPAyLoad(pDistrictDescription);

    -- Check if the record exists based on processingunitandportId and LanguageId
    SELECT COUNT(*) INTO RowCount 
    FROM districtProfile 
    WHERE DistrictProfileId = pDistrictProfileId
      AND LanguageId = pLanguageId;

    IF RowCount > 0 THEN
        -- Update the existing record
        UPDATE districtProfile 
        SET 
            DistrictId = pDistrictId,
            Population = pPopulation,
            SexRatio = pSexRatio,
            LiteracyRate = pLiteracyRate,
            DistrictDescription = pDistrictDescription,
            FileName = pFileName,
            FilePath = pFilePath,
            IsActive = pIsActive,
            UpdatedBy = pUsername,  
            UpdatedAt = NOW()      
        WHERE DistrictProfileId = pDistrictProfileId
          AND LanguageId = pLanguageId;
    ELSE
        -- Insert a new record
        -- Find the maximum processingunitandportId for the given language
        SELECT IFNULL(MAX(DistrictProfileId), 0) + 1 INTO maxDistrictProfileId 
        FROM districtProfile 
        WHERE LanguageId = pLanguageId;
        IF pId > 0 THEN
            INSERT INTO districtProfile 
            (
                DistrictProfileId, 
                LanguageId, 
                DistrictId, 
                Population, 
                SexRatio, 
                LiteracyRate, 
                DistrictDescription, 
                FileName, 
                FilePath, 
                IsActive,
                CreatedBy,      
                CreatedAt,
                IsDelete
            ) 
            VALUES 
            (
                pDistrictProfileId, 
                pLanguageId, 
                pDistrictId, 
                pPopulation, 
                pSexRatio, 
                pLiteracyRate, 
                pDistrictDescription, 
                pFileName, 
                pFilePath, 
                pIsActive, 
                pUsername, 
                NOW(),
                0
            );
            ELSE
                INSERT INTO districtProfile 
                (
                    DistrictProfileId, 
                    LanguageId, 
                    DistrictId, 
                    Population, 
                    SexRatio, 
                    LiteracyRate, 
                    DistrictDescription, 
                    FileName, 
                    FilePath, 
                    IsActive,
                    CreatedBy,      
                    CreatedAt,
                    IsDelete
                ) 
                VALUES 
                (
                    maxDistrictProfileId,
                    pLanguageId, 
                    pDistrictId, 
                    pPopulation, 
                    pSexRatio, 
                    pLiteracyRate, 
                    pDistrictDescription, 
                    pFileName, 
                    pFilePath, 
                    pIsActive, 
                    pUsername, 
                    NOW(),
                    0
                );
        END IF;

    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsInsertOrUpdateDocumentMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsInsertOrUpdateDocumentMaster`(
	pdoc_id int,	
	pdoc_name text,
    pfile_name text /* = null */ ,
	pdoc_path text /* = null */ , 
    planguageid int,	
	pisactive tinyint,
	pusername text
 )
begin
	if(pdoc_id=0) then	  	
		insert into `document_master`
			(`doc_name`,
            `file_name`,
            `doc_path`,
            `languageid`,
			`isactive`,	
            `isdelete`,
			`createdby`,
			`createddate`)
			values(pdoc_name,pfile_name,pdoc_path,planguageid,pisactive,0,pusername,now());
		set pdoc_id=last_insert_id();
	else
		update `document_master` 
          set doc_name = pdoc_name,
			  file_name= ifnull( pfile_name,file_name),  
              doc_path = ifnull(pdoc_path,doc_path),
              isactive=pisactive,
              updatedby=pusername,
              updateddate=now()            
        where languageid=planguageid and doc_id=pdoc_id;       
	end if;
select pdoc_id as recid;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsInsertOrUpdateEcitizenMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsInsertOrUpdateEcitizenMaster`(
    pId int, 
    pLanguageId int,
    pEcitizenTypeId text, 
    pBranchId int, 
    pDate datetime,
    pNumber text, 
    pSubject text, 
    pImageName text,
    pImagePath text, 
    pIsActive tinyint, 
    Username text
)
BEGIN
    -- Sanitize the subject input
    SET pSubject = XSSPAyLoad(pSubject);

    -- If it's a new entry (pId = 0)
    IF pId = 0 THEN  
        
            -- Insert into ecitizenmaster
            INSERT INTO `ecitizenmaster`(`IsActive`, `IsDelete`, `CreateBy`, `CreateDate`)
            VALUES (pIsActive, 0, Username, NOW());

            -- Get the last inserted ID
            SET pId = LAST_INSERT_ID();

            -- Insert into ecitizenmasterdetails
            INSERT INTO `ecitizenmasterdetails`
            (
                `EcitizenId`, `LanguageId`,
                `EcitizenTypeId`, `BranchId`, `Date`,
                `Number`, `Subject`, `ImageName`,
                `ImagePath`, `IsActive`, `IsDelete`,
                `CreatedBy`, `CreatedDate`
            )
            VALUES
            (
                pId, pLanguageId, 
                pEcitizenTypeId, pBranchId, pDate,
                pNumber, pSubject, pImageName,
                pImagePath, pIsActive, 0,
                Username, NOW()
            );
        
    ELSE 
        
            -- Update the ecitizenmaster record
            UPDATE `ecitizenmaster`
            SET `IsActive` = pIsActive,
                `UpdatedBy` = Username,
                `UpdatedDate` = NOW()
            WHERE `Id` = pId;
            
            -- Update IsActive in both ecitizenmaster and ecitizenmasterdetails
            UPDATE `ecitizenmaster` AS UCMSM
            JOIN `ecitizenmasterdetails` AS UCMSMD ON UCMSM.Id = UCMSMD.EcitizenId 
            SET UCMSM.IsActive = pIsActive,
                UCMSMD.IsActive = pIsActive
            WHERE UCMSM.Id = pId;

            -- If details for this LanguageId already exist, update them
            IF (SELECT COUNT(1) FROM `ecitizenmasterdetails` WHERE EcitizenId = pId AND LanguageId = pLanguageId) > 0 THEN
               
                -- Update the details
                UPDATE `ecitizenmasterdetails`
                SET EcitizenTypeId = pEcitizenTypeId,
                    BranchId = pBranchId,
                    Date = pDate,
                    Number = pNumber,
                    Subject = pSubject,
                    ImageName = (CASE WHEN IFNULL(pImageName, '') <> '' THEN pImageName ELSE ImageName END),
                    ImagePath = (CASE WHEN IFNULL(pImagePath, '') <> '' THEN pImagePath ELSE ImagePath END),
                    IsActive = pIsActive,
                    UpdatedBy = Username,
                    UpdatedDate = NOW()
                WHERE `EcitizenId` = pId
                  AND `LanguageId` = pLanguageId;
            ELSE
                
                    INSERT INTO `ecitizenmasterdetails`
                    (
                        `EcitizenId`, `LanguageId`,
                        `EcitizenTypeId`, `BranchId`, `Date`,
                        `Number`, `Subject`, `ImageName`,
                        `ImagePath`, `IsActive`, `IsDelete`,
                        `CreatedBy`, `CreatedDate`
                    )
                    VALUES
                    (
                        pId, pLanguageId,
                        pEcitizenTypeId, pBranchId, pDate,
                        pNumber, pSubject, pImageName,
                        pImagePath, pIsActive, 0,
                        Username, NOW()
                    );
            END IF;
        
        SELECT pId AS RecId;
    END IF;

    -- Return the result
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsInsertOrUpdateEventApplications` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsInsertOrUpdateEventApplications`(
pEventId bigint, 
pUserId bigint, 
pIsApplied tinyint
)
BEGIN
    INSERT INTO eventapplications (
    EventId,
    UserId,
    IsApplied,
    AppliedDate
    )
      VALUES (pEventId, pUserId, pIsApplied, NOW());
     SELECT LAST_INSERT_ID() AS id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsInsertOrUpdateEventMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsInsertOrUpdateEventMaster`(
pid bigint,
planguageid int,
peventname varchar(300),
pfilename longtext,
pfilepath text,
pdescription longtext,
pMetaTitle longtext,
pMetaDescription longtext,
peventmasterid bigint,
peventstartdate datetime,
peventenddate datetime,
pisactive tinyint,
plocation text,
pusername text
)
begin
set pdescription = XSSPAyLoad(pdescription);
if(pid=0) then 

		insert into `eventmaster`(`isactive`,`isdelete`,`createdby`,`createddate`)values(pisactive,0,pusername,now());

		set peventmasterid=last_insert_id();

		insert into `eventmasterdetails`
		(
		`languageid`,`eventname`,`filename`,`filepath`,`description`,`eventmasterid`,`eventstartdate`,`eventenddate`,`location`,`isactive`,`isdelete`,`createdby`,`createddate`,`MetaTitle`,`MetaDescription`
		)
		values
		(
		planguageid,peventname,pfilename,pfilepath,pdescription,peventmasterid,peventstartdate,peventenddate,plocation,pisactive,0,pusername,now(),pMetaTitle,pMetaDescription
		);
		select peventmasterid;

else 

		update `eventmaster` set 
		isactive=pisactive , 
		updatedby=pusername,
		updateddate=now() 
		where id=pid;
		
		if((select count(1) from `eventmasterdetails` where eventmasterdetails.id = pid and eventmasterdetails.languageid=planguageid )>0) then
		
			update `eventmasterdetails`
			set 
			languageid = planguageid,
			eventname = peventname,
			filename=(case when ifnull(pfilename,'')<>'' then pfilename else pfilename end),
			filepath=(case when ifnull(pfilepath,'')<>'' then pfilepath else pfilepath end),
			description = pdescription,
			eventmasterid = peventmasterid,
			eventstartdate=peventstartdate,
            eventenddate=peventenddate,
			location = plocation,
			isactive=pisactive , 
			updatedby=pusername,
			updateddate=now(),
            MetaTitle=pMetaTitle,
            MetaDescription=pMetaDescription
			where 
			eventmasterdetails.id=pid and languageid=planguageid;
            select peventmasterid;
		else 
		
		insert into `eventmasterdetails`
		(
		`languageid`,`eventname`,`filename`,`filepath`,`description`,`eventmasterid`,`eventstartdate`,`eventenddate`,`location`,`isactive`,`isdelete`,`createdby`,`createddate`,`MetaTitle`,`MetaDescription`
		)
		values
		(
		planguageid,peventname,pfilename,pfilepath,pdescription,peventmasterid,peventstartdate,peventenddate,plocation,pisactive,0,pusername,now(),pMetaTitle,pMetaDescription
		);

select pid ;

end if;
end if;


end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsInsertOrUpdateFrontUserMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsInsertOrUpdateFrontUserMaster`(
pId int, 
pFirstName text, 
pMiddleName text,
pLastName text, 
pEmail text,
pPhoneNo text,
pUserPassword text,
pIsActive tinyint,
pCreateBy text,
pIsPasswordReset int, 
pIsChangeProfile int,
pApplicantPhoto text,
pAddress text)
BEGIN
  IF (pId = 0) THEN
    INSERT INTO frontusermaster (
    FirstName,
    MiddleName,
    LastName,
    Email,
    PhoneNo,
    UserPassword,
    IsActive,
    CreateBy,
    CreateDate,
    IsPasswordReset,
    IsChangeProfile)
      VALUES (pFirstName, pMiddleName, pLastName,pEmail, pPhoneNo,pUserPassword, 1, pCreateBy, NOW(),pIsPasswordReset, pIsChangeProfile);
    SET pId = LAST_INSERT_ID();

  
  ELSE
    UPDATE frontusermaster
    SET 
        FirstName = pFirstName,
        MiddleName = pMiddleName,
        LastName = pLastName,
        Email = pEmail,
        PhoneNo = pPhoneNo,
        UserPassword = pUserPassword,
        IsActive = pIsActive,
        UpdateBy = pCreateBy,
        UpdateDate = NOW(),
        IsPasswordReset = pIsPasswordReset,
        IsChangeProfile = pIsChangeProfile,
        ApplicantPhoto= (case when ifnull(pApplicantPhoto,'')<>'' then pApplicantPhoto else ApplicantPhoto end),
        Address = pAddress
    WHERE Id = pId;
  
  END IF;
  SELECT
    pId AS id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsInsertOrUpdateGalleryMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsInsertOrUpdateGalleryMaster`(
pid bigint,
pgallerymasterid bigint,
planguageid int,
pplacename text,
in pthumbimagename text,
in pthumbimagepath text,
pisvideo tinyint,
pisactive tinyint,
pusername text,
palbumrank int
)
begin
	if(pid = 0) then
    
    insert into `gallerymaster`(`isactive`,`isdelete`,`createdby`,`createddate`)values(pisactive,0,pusername,now());
    set pgallerymasterid=last_insert_id();
    
    insert into `gallerymasterdetails`
		(
		`gallerymasterid`,`languageid`,`placename`,`thumbimagename`,`thumbimagepath`,`isactive`,`createby`,`createdate`,`isvideo`,`albumrank`
		)
		values
		(
		pgallerymasterid,planguageid,pplacename,pthumbimagename,pthumbimagepath,pisactive,pusername,now(),pisvideo,palbumrank
		);
        select pgallerymasterid;
else
    update `gallerymaster` set 
		isactive=pisactive , 
		updatedby=pusername,
		updateddate=now() 
		where id=pid;
        
        if((select count(1) from `gallerymasterdetails` where gallerymasterdetails.id = pid and gallerymasterdetails.languageid=planguageid )>0) then
        
        update `gallerymasterdetails` set
        gallerymasterid=pgallerymasterid,
        languageid=planguageid,
        placename=pplacename,
        thumbimagename=pthumbimagename,
        thumbimagepath=pthumbimagepath,
        isactive=pisactive,
        updateby=pusername,
        updatedate=now(),
        isvideo=pisvideo,
        albumrank = palbumrank
        where 
			gallerymasterdetails.id=pid and languageid=planguageid;
            UPDATE `gallerymasterdetails` SET `albumrank` = palbumrank WHERE `gallerymasterid` = pgallerymasterid;
            select pgallerymasterid;
else
        insert into `gallerymasterdetails`
		(
		`gallerymasterid`,`languageid`,`placename`,`thumbimagename`,`thumbimagepath`,`isactive`,`createby`,`createdate`,`isvideo`,`albumrank`
		)
		values
		(
		pgallerymasterid,planguageid,pplacename,pthumbimagename,pthumbimagepath,pisactive,pusername,now(),pisvideo,palbumrank
		);
       select pid ;
        
    end if;
end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsInsertOrUpdateGoiLogoMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsInsertOrUpdateGoiLogoMaster`(
	pid int,
	planguageid int,
	plogoname text,
	purl text,    
	pimagename text,
	pimagepath text,
	pisactive tinyint,
	pusername text
 )
begin
	if(pid=0) then	  	
		insert into `goilogomaster`
			(`languageid`,
			`logoname`,
			`imagename`,
			`imagepath`,
			`url`,
			`isactive`,	
            `isdelete`,
			`createdby`,
			`createddate`)
			values(planguageid,plogoname,pimagename,pimagepath,purl,pisactive,0,pusername,now());
		set pid=last_insert_id();
	else
		update `goilogomaster` 
          set logoname = plogoname,
              imagename = pimagename,
              imagepath=pimagepath,
              url=purl,
              isactive=pisactive,
              updatedby=pusername,
              updateddate=now()            
        where languageid=planguageid and id=pid;       
	end if;
select pid as recid;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsInsertOrUpdateJsMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsInsertOrUpdateJsMaster`(
id int,title text,jsfile text,isactive tinyint,username text
)
begin

if(id = 0) then 

insert into `jsmaster`(`title`,`jsfile`,`isactive`,`isdelete`,`createdby`,`createddate`)values(title,jsfile,isactive,0,username,now());

set id=last_insert_id();

else 

update jsmaster set 
title=title,
jsfile=jsfile,
isactive=isactive , 
updatedby=username,
updateddate=now() 
where jsmaster.id=id;

end if;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsInsertOrUpdateLanguageMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsInsertOrUpdateLanguageMaster`(
    pid long,
    pname TEXT,
    puserid LONG,
    pisvisible tinyint
)
BEGIN
    IF pid = 0 THEN
	  -- Insert new language record
        INSERT INTO `cmslanguagemaster` (`name`, `isvisible`, `createdby`, `createddate`)
        VALUES ( pname, pisvisible, puserid, NOW());
    ELSE
        -- Update existing language record
        UPDATE `cmslanguagemaster`
        SET `name` = pname,
            `updatedby` = puserid,
            `isvisible` = pisvisible,
            `updateddate` = NOW()
        WHERE `id` = pid;
    END IF;

    SELECT pid AS recid;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsInsertOrUpdateMenuResourceMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsInsertOrUpdateMenuResourceMaster`(id int, menuname text, menuurl text, isactive tinyint, changedby text)
begin
	if(id = 0) then
		insert into menuresourcemaster(menuname,menuurl,isactive,createby,createdate) values(menuname,menuurl,isactive,changedby,now());
        set id=last_insert_id();
	else
        update menuresourcemaster set menuname=menuname,menuurl=menuurl,isactive=isactive,updateby=changedby,updatedate=now() where menuresourcemaster.id=id;
    end if;
    
    select id as recid;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsInsertOrUpdateMinisterMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsInsertOrUpdateMinisterMaster`(
pId int,pLanguageId int ,pMinisterName text,pMinisterDescription text,ImageName text,ImagePath text, pIsActive tinyint,Username text,pMinisterRank int)
BEGIN
set pMinisterDescription = XSSPAyLoad(pMinisterDescription);
if(pId=0) then 
 
INSERT INTO `ministermaster`(`IsActive`,`IsDelete`,`CreatedBy`,`CreatedDate`)VALUES(pIsActive,0,Username,now());

set pId=last_insert_id();

INSERT INTO `ministermasterdetails`
(
`MinisterID`,`LanguageId`,`MinisterName`,`MinisterDescription`,`ImageName`,`ImagePath`,`IsActive`,`IsDelete`,`CreatedBy`,`CreatedDate`,`MinisterRank`)
VALUES
(pId,pLanguageId,pMinisterName,pMinisterDescription,ImageName,ImagePath,pIsActive,0,Username,now(),pMinisterRank);
 

else 

update `ministermaster` set 
`IsActive`=pIsActive , 
`UpdatedBy`=Username,
`UpdatedDate`=now() 
where `Id`=pId;

if((select count(1) from `ministermasterdetails` where MinisterID=pId and LanguageId=pLanguageId )>0) then

INSERT INTO `ministermasterdetailshistory`
(
`MinisterDetailId`,
`LanguageId`,
`MinisterID`,
`MinisterName`,
`MinisterDescription`,
`ImageName`,
`ImagePath`,
`IsActive`,
`IsDelete`,
`CreatedBy`,
`CreatedDate`,
`UpdatedBy`,
`UpdatedDate`,
`DeletedBy`,
`DeletedDate`)
SELECT Mde.`Id`,
    Mde.`LanguageId`,
    Mde.`MinisterID`,
    Mde.`MinisterName`,
    Mde.`MinisterDescription`,
    Mde.`ImageName`,
    Mde.`ImagePath`,
    Mde.`IsActive`,
    Mde.`IsDelete`,
    Mde.`CreatedBy`,
    Mde.`CreatedDate`,
    Mde.`UpdatedBy`,
    Mde.`UpdatedDate`,
    Mde.`DeletedBy`,
    Mde.`DeleteDate`
FROM `ministermasterdetails` as Mde where Mde.`MinisterID`=pId and Mde.`LanguageId`=pLanguageId;

update `ministermasterdetails`
set 
`MinisterName`=pMinisterName,
`MinisterDescription`=pMinisterDescription, 
ImageName=(case when ifnull(ImageName,'')<>'' then ImageName else ImageName end),
ImagePath=(case when ifnull(ImagePath,'')<>'' then ImagePath else ImagePath end),
`IsActive`=pIsActive , 
`UpdatedBy`=Username,
`UpdatedDate`=now(),
`MinisterRank`=pMinisterRank
where `MinisterID`=pId and `LanguageId`=pLanguageId;
UPDATE `ministermasterdetails` SET `IsActive` = pIsActive WHERE `MinisterID` = pId;
UPDATE `ministermasterdetails` SET `MinisterRank` = pMinisterRank WHERE `MinisterID` = pId;
else 

INSERT INTO `ministermasterdetails`
(
`MinisterID`,`LanguageId`,`MinisterName`,`MinisterDescription`,`ImageName`,`ImagePath`,`IsActive`,`IsDelete`,`CreatedBy`,`CreatedDate`,`MinisterRank`)
VALUES
(pId,pLanguageId,pMinisterName,pMinisterDescription,ImageName,ImagePath,pIsActive,0,Username,now(),pMinisterRank);

end if;
end if;
select pId as RecId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsInsertOrUpdateNewsMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsInsertOrUpdateNewsMaster`(
	pId int,
	pLanguageId int,
	pNewsId int,
	pNewsTypeId text,
	pNewsTitle text,
	pImageName text,
	pImagePath text,
	pShortDescription text,
	pNewsDesc text,
	pNewsBy text,
	pLocation text,
	pPublicDate datetime(3),
	pArchiveDate datetime(3),
	pIsActive tinyint,
	pUsername text,
	pIsLink tinyint,
    pMetaTitle text,
    pMetaDescription text
)
BEGIN

	set pNewsDesc = XSSPAyLoad(pNewsDesc);
    
	if(pId=0) then 
	  IF EXISTS (SELECT 1 FROM newsmasterdetails WHERE NewsTitle=pNewsTitle and LanguageId=pLanguageId and PublicDate=pPublicDate) THEN
	  select 'duplicate';
	  else
	  
	INSERT INTO `newsmaster`(`IsActive`,`IsDelete`,`CreateBy`,`CreateDate`)VALUES(pIsActive,0,pUsername,now());

	set pId=last_insert_id();

	INSERT INTO `newsmasterdetails`
	(
	`NewsId`,`LanguageId`,`NewsTypeId`,`NewsTitle`,`ImageName`,`ImagePath`,`ShortDescription`,`NewsDesc`,`NewsBy`,`PublicDate`,`ArchiveDate`,`Location`,`IsActive`,`IsDelete`,`CreatedBy`,`CreatedDate`,`IsLink`,`MetaTitle`,`MetaDescription`)
	VALUES
	(
	pId,pLanguageId,pNewsTypeId,pNewsTitle,pImageName,pImagePath,pShortDescription,pNewsDesc,pNewsBy,pPublicDate,pArchiveDate,pLocation,pIsActive,0,pUsername,now(),pIsLink,pMetaTitle,pMetaDescription);

	select pId as RecId;
	end if;
	else 
	IF EXISTS (SELECT 1 FROM newsmasterdetails WHERE TRIM(NewsTitle)=TRIM(pNewsTitle) and LanguageId=pLanguageId and PublicDate=pPublicDate 
	  and NewsId<>pId and IsActive=1) THEN
	  select 'duplicate';
	  else
			update `newsmaster` set 
			IsActive=pIsActive , 
			UpdatedBy=pUsername,
			UpdatedDate=now() 
			where Id=pId;

	-- update IsActive column in both master and details table
			UPDATE `newsmaster` AS UCMSM JOIN `newsmasterdetails` AS UCMSMD ON UCMSM.Id = UCMSMD.NewsId SET UCMSM.IsActive = pIsActive, UCMSMD.IsActive = pIsActive WHERE UCMSM.Id = pId;

			if((select count(1) from `newsmasterdetails` where NewsId=pId and LanguageId=pLanguageId )>0) then

			update `newsmasterdetails` set 
			NewsTypeId=pNewsTypeId,
			NewsTitle=pNewsTitle,
			ImageName=(case when pIsLink=1 then '' else(case when ifnull(pImageName,'')<>'' then pImageName else ImageName end)end),
			ImagePath=(case when pIsLink=1 then '' else (case when ifnull(pImagePath,'')<>'' then pImagePath else ImagePath end)end),
			ShortDescription=pShortDescription,
			NewsDesc=pNewsDesc,
			NewsBy=pNewsBy,
			PublicDate=pPublicDate,
			ArchiveDate=pArchiveDate,
			Location=pLocation,
			IsActive=pIsActive , 
			UpdatedBy=pUsername,
			UpdatedDate=now(),
			-- IsLink=pIsLink 
            MetaTitle=pMetaTitle,
			MetaDescription=pMetaDescription
			where 
			NewsId=pId and LanguageId=pLanguageId;
			
			-- update islink column in both language
			update `newsmasterdetails` set 		
			IsLink=pIsLink ,
			ImageName=(case when pIsLink=1 then '' else(case when ifnull(pImageName,'')<>'' then pImageName else ImageName end)end),
			ImagePath=(case when pIsLink=1 then '' else (case when ifnull(pImagePath,'')<>'' then pImagePath else ImagePath end)end)
			where 
			NewsId=pId;
			select pId as RecId;
	else 

	INSERT INTO `newsmasterdetails`
	(
		`NewsId`,`LanguageId`,`NewsTypeId`,`NewsTitle`,`ImageName`,`ImagePath`,`ShortDescription`,`NewsDesc`,`NewsBy`,`PublicDate`,`ArchiveDate`,`Location`,`IsActive`,`IsDelete`,`CreatedBy`,`CreatedDate`,`IsLink`,`MetaTitle`,`MetaDescription`)
	 
	VALUES
	(pId,pLanguageId,pNewsTypeId,pNewsTitle,pImageName,pImagePath,pShortDescription,pNewsDesc,pNewsBy,pPublicDate,pArchiveDate,pLocation,pIsActive,0,pUsername,now(),pIsLink,pMetaTitle,pMetaDescription);
	select pId as RecId;
	end if;
	end if;
	select pId as RecId;

	end if;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsInsertOrUpdatePopupMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsInsertOrUpdatePopupMaster`(pid int,planguageid int ,ppopupdescription text, pisactive tinyint,username text)
begin
set ppopupdescription = XSSPAyLoad(ppopupdescription);
if(pid=0) then 
 
insert into `popupmaster`(`isactive`,`isdelete`,`createdby`,`createddate`)values(pisactive,0,username,now());

set pid=last_insert_id();

insert into `popupmasterdetails`
(

`popupid`,`languageid`,`popupdescription`,`isactive`,`isdelete`,`createdby`,`createddate`)
values

(pid,planguageid,replace(replace(replace(replace(replace(ppopupdescription,'embed',''),'javascript:alert',''),'alert',''),'prompt',''),'svg',''),pisactive,0,username,now());
 

else 

update `popupmaster` set 
`isactive`=pisactive , 
`updatedby`=username,
`updateddate`=now() 
where `id`=pid;

update `popupmasterdetails`
set 
 `popupdescription`=replace(replace(replace(replace(replace(ppopupdescription,'embed',''),'javascript:alert',''),'alert',''),'prompt',''),'svg',''), 
`isactive`=pisactive , 
`updatedby`=username,
`updateddate`=now()
where `popupid`=pid and `languageid`=planguageid;

end if;

select pid as recid;


end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsInsertOrUpdateProcessedProductData` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsInsertOrUpdateProcessedProductData`(
    IN pId bigint,
    IN pProcessedProductId bigint,
    IN pProductId bigint,
    IN pLanguageId bigint,
    IN pProcessedProductName text,
    IN pIsActive bool,
    IN pUsername text
)
BEGIN
    DECLARE RowCount INT;
    DECLARE maxProcessedProductId BIGINT;

    -- Check if the record exists based on processingunitandportId and LanguageId
    SELECT COUNT(*) INTO RowCount 
    FROM processedproduct
    WHERE ProcessedProductId = pProcessedProductId
      AND LanguageId = pLanguageId;

    IF RowCount > 0 THEN
        -- Update the existing record
        UPDATE processedproduct 
        SET 
            ProcessedProductId = pProcessedProductId,
            ProcessedProductName = pProcessedProductName,
            ProductId = pProductId,
            IsActive = pIsActive,
            UpdatedBy = pUsername,  
            UpdatedAt = NOW()      
        WHERE ProcessedProductId = pProcessedProductId
          AND LanguageId = pLanguageId;
    ELSE
        -- Insert a new record
        -- Find the maximum processingunitandportId for the given language
        SELECT IFNULL(MAX(ProcessedProductId), 0) + 1 INTO maxProcessedProductId 
        FROM processedproduct 
        WHERE LanguageId = pLanguageId;
        IF pId > 0 THEN 
            INSERT INTO processedproduct
            (
                ProcessedProductId, 
                LanguageId, 
                ProductId, 
                ProcessedProductName, 
                IsActive,
                CreatedBy,      
                CreatedAt,
                IsDelete
            ) 
            VALUES 
            (
                pProcessedProductId, 
                pLanguageId, 
                pProductId, 
                pProcessedProductName, 
                pIsActive, 
                pUsername, 
                NOW(),
                0
            );
            ELSE
             INSERT INTO processedproduct
            (
                ProcessedProductId, 
                LanguageId, 
                ProductId, 
                ProcessedProductName, 
                IsActive,
                CreatedBy,      
                CreatedAt,
                IsDelete
            ) 
            VALUES 
            (
                maxProcessedProductId, 
                pLanguageId, 
                pProductId, 
                pProcessedProductName, 
                pIsActive, 
                pUsername, 
                NOW(),
                0
            );
         END IF;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsInsertOrUpdateProcessesProductData` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsInsertOrUpdateProcessesProductData`(
    IN pId bigint,
    IN pProcessesProductId bigint,
    IN pProductId bigint,
    IN pLanguageId bigint,
    IN pProcessedProductName text,
    IN pIsActive bool,
    IN pUsername text
)
BEGIN
    DECLARE RowCount INT;
    DECLARE maxProcessesProductId BIGINT;

    -- Check if the record exists based on processingunitandportId and LanguageId
    SELECT COUNT(*) INTO RowCount 
    FROM processedproduct
    WHERE ProcessesProductId = pProcessesProductId
      AND LanguageId = pLanguageId;

    IF RowCount > 0 THEN
        -- Update the existing record
        UPDATE processedproduct 
        SET 
            ProcessesProductId = pProcessesProductId,
            ProcessedProductName = pProcessedProductName,
            ProductId = pProductId,
            IsActive = pIsActive,
            UpdatedBy = pUsername,  
            UpdatedAt = NOW()      
        WHERE ProcessesProductId = pProcessesProductId
          AND LanguageId = pLanguageId;
    ELSE
        -- Insert a new record
        -- Find the maximum processingunitandportId for the given language
        SELECT IFNULL(MAX(ProcessesProductId), 0) + 1 INTO maxProcessesProductId 
        FROM processedproduct 
        WHERE LanguageId = pLanguageId;

        INSERT INTO processedproduct
        (
            ProcessesProductId, 
            LanguageId, 
            ProductId, 
            ProcessedProductName, 
            IsActive,
            CreatedBy,      
            CreatedAt,
            IsDelete
        ) 
        VALUES 
        (
            pProcessesProductId, 
            pLanguageId, 
            pProductId, 
            pProcessedProductName, 
            pIsActive, 
            pUsername, 
            NOW(),
            0
        );
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsInsertOrUpdateProcessingUnitAndPortMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsInsertOrUpdateProcessingUnitAndPortMaster`(
    IN pId bigint,
    IN pProcessingUnitandPortId bigint,
    IN pLanguageId bigint,
    IN pDistrictId bigint,
    IN pTotalProcessingUnit text,
    IN pMSME text,
    IN pTotalLargeUnits text,
    IN pTotalPorts text,
    IN pMajorCrops text,
    IN pAvailableInfrastructure text,
    IN pLargeUnits text,
    IN pIsActive bool,
    IN pUsername text
)
BEGIN
    DECLARE RowCount INT;
    DECLARE maxProcessingUnitAndPortId BIGINT;
    set pMajorCrops = XSSPAyLoad(pMajorCrops);
    set pAvailableInfrastructure = XSSPAyLoad(pAvailableInfrastructure);
    set pLargeUnits = XSSPAyLoad(pLargeUnits);
    -- Check if the record exists based on processingunitandportId and LanguageId
    SELECT COUNT(*) INTO RowCount 
    FROM processingunitandport 
    WHERE ProcessingUnitandPortId = pProcessingUnitandPortId
      AND LanguageId = pLanguageId;

    IF RowCount > 0 THEN
        -- Update the existing record
        UPDATE processingunitandport 
        SET 
            DistrictId = pDistrictId,
            TotalProcessingUnit = pTotalProcessingUnit,
            MSME = pMSME,
            TotalLargeUnits = pTotalLargeUnits,
            TotalPorts = pTotalPorts,
            MajorCrops = pMajorCrops,
            AvailableInfrastructure = pAvailableInfrastructure,
            LargeUnits = pLargeUnits,
            IsActive = pIsActive,
            UpdatedBy = pUsername,  
            UpdatedAt = NOW()      
        WHERE ProcessingUnitandPortId = pProcessingUnitandPortId
          AND LanguageId = pLanguageId;
    ELSE
        -- Insert a new record
        -- Find the maximum processingunitandportId for the given language
        SELECT IFNULL(MAX(ProcessingUnitandPortId), 0) + 1 INTO maxProcessingUnitAndPortId 
        FROM processingunitandport 
        WHERE LanguageId = pLanguageId;
        IF pId > 0 THEN

            INSERT INTO processingunitandport 
            (
                ProcessingUnitandPortId, 
                LanguageId, 
                DistrictId, 
                TotalProcessingUnit, 
                MSME, 
                TotalLargeUnits, 
                TotalPorts, 
                MajorCrops, 
                AvailableInfrastructure, 
                LargeUnits, 
                IsActive,
                CreatedBy,      
                CreatedAt,
                IsDelete
            ) 
            VALUES 
            (
                pProcessingUnitandPortId, 
                pLanguageId, 
                pDistrictId, 
                pTotalProcessingUnit, 
                pMSME, 
                pTotalLargeUnits, 
                pTotalPorts, 
                pMajorCrops, 
                pAvailableInfrastructure, 
                pLargeUnits, 
                pIsActive, 
                pUsername, 
                NOW(),
                0
            );

            ELSE
            INSERT INTO processingunitandport 
            (
                ProcessingUnitandPortId, 
                LanguageId, 
                DistrictId, 
                TotalProcessingUnit, 
                MSME, 
                TotalLargeUnits, 
                TotalPorts, 
                MajorCrops, 
                AvailableInfrastructure, 
                LargeUnits, 
                IsActive,
                CreatedBy,      
                CreatedAt,
                IsDelete
            ) 
            VALUES 
            (
                maxProcessingUnitAndPortId, 
                pLanguageId, 
                pDistrictId, 
                pTotalProcessingUnit, 
                pMSME, 
                pTotalLargeUnits, 
                pTotalPorts, 
                pMajorCrops, 
                pAvailableInfrastructure, 
                pLargeUnits, 
                pIsActive, 
                pUsername, 
                NOW(),
                0
            );
        END IF;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsInsertOrUpdateProductMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsInsertOrUpdateProductMaster`(
pId bigint,
pProductName text,
pProductNameGuj text,
pImageName text,
pImagePath text,
pIsActive bool,
pUsername text
 )
begin
Declare RowCount int;

select count(Id) into RowCount from productmaster where Id = pId;

if RowCount > 0 THEN
UPDATE productmaster 
        SET 
            ProductName = pProductName,
            ProductNameGuj = pProductNameGuj,
			ImageName = pImageName,
            ImagePath = pImagePath,
            IsActive = pIsActive,
            UpdatedBy = pUsername,  
            UpdatedAt = NOW()      
        WHERE Id = pId;
    ELSE
      -- Insert a new record
        INSERT INTO productmaster 
        (
            ProductName, 
            ProductNameGuj, 
            ImageName, 
            ImagePath, 
            IsActive, 
            CreatedBy,      
            CreatedAt,
            IsDelete
        ) 
        VALUES 
        (
            pProductName, 
            pProductNameGuj, 
            pImageName, 
            pImagePath, 
            pIsActive, 
            pUsername, 
            NOW(),
            0
        );
    END IF;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsInsertOrUpdateRoleMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsInsertOrUpdateRoleMaster`(id int, rolename text, isactive tinyint, changedby text)
begin
	if(id = 0) then
		insert into rolemaster(rolename,isactive,createby,createdate) values(rolename,isactive,changedby,now());
        set id = last_insert_id();
	else
        update rolemaster set rolename=rolename,isactive=isactive,updateby=changedby,updatedate=now() where rolemaster.id=id;
    end if;
    
    select id as recid;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsInsertOrUpdateServiceRateMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsInsertOrUpdateServiceRateMaster`(
pId int,
pLanguageId int ,
pServiceName text,
pServiceDescription text,
pShortDescription text,
ImageName text,
ImagePath text, 
pIcon text,
pIsActive tinyint,
Username text,
pServiceRank int
)
BEGIN
set pServiceDescription = XSSPAyLoad(pServiceDescription);
if(pId=0) then 
 
INSERT INTO `serviceratemaster`(`IsActive`,`IsDelete`,`CreatedBy`,`CreatedDate`)VALUES(pIsActive,0,Username,now());

set pId=last_insert_id();

INSERT INTO `serviceratemasterdetails`
(
`ServiceRateId`,`LanguageId`,`ServiceName`,`ShortDescription`,`ServiceDescription`,`ImageName`,`ImagePath`,`Icon`,`IsActive`,`IsDelete`,`CreatedBy`,`CreatedDate`,`ServiceRank`)
VALUES
(pId,pLanguageId,pServiceName,pShortDescription,pServiceDescription,ImageName,ImagePath,pIcon,pIsActive,0,Username,now(),pServiceRank);
 
else 

update `serviceratemaster` set 
`IsActive`=pIsActive , 
`UpdatedBy`=Username,
`UpdatedDate`=now() 
where `Id`=pId;

if((select count(1) from `serviceratemasterdetails` where ServiceRateId=pId and LanguageId=pLanguageId )>0) then

update `serviceratemasterdetails`
set 
ServiceName = pServiceName,
ShortDescription = pShortDescription,
ServiceDescription = pServiceDescription, 
ImageName=(case when ifnull(ImageName,'')<>'' then ImageName else ImageName end),
ImagePath=(case when ifnull(ImagePath,'')<>'' then ImagePath else ImagePath end),
Icon = pIcon,
IsActive=pIsActive , 
UpdatedBy=Username,
UpdatedDate=now(),
ServiceRank = pServiceRank

where `ServiceRateId`=pId and `LanguageId`=pLanguageId;
UPDATE `serviceratemasterdetails` SET `IsActive` = pIsActive WHERE `ServiceRateId` = pId;
UPDATE `serviceratemasterdetails` SET `ServiceRank` = pServiceRank WHERE `ServiceRateId` = pId;

else
INSERT INTO `serviceratemasterdetails`
(
`ServiceRateId`,`LanguageId`,`ServiceName`,`ShortDescription`,`ServiceDescription`,`ImageName`,`ImagePath`,`Icon`,`IsActive`,`IsDelete`,`CreatedBy`,`CreatedDate`,`ServiceRank`)
VALUES
(pId,pLanguageId,pServiceName,pShortDescription,pServiceDescription,ImageName,ImagePath,pIcon,pIsActive,0,Username,now(),pServiceRank);

end if;
end if;
select pId as RecId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsInsertOrUpdateStatisticMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsInsertOrUpdateStatisticMaster`(
    pid int,
    pstatisticdataid int,
	planguageid int,
    pstatistictypeId int,
	ptitle text,
	pcount text,
	purl text,    
	pimagename text,
	pimagepath text,
	pisactive tinyint,
	pusername text
)
begin
if(pid=0) then 

insert into `statisticdatamaster`(`isactive`,`isdelete`,`createby`,`createdate`)values(pisactive,0,pusername,now());

set pid=last_insert_id();

insert into `statisticdatamasterdetails`
			(`statisticdataid`,
            `languageid`,
            `statistictypeId`,
           	`title`,
			`count`,
            `url`,
			`imagename`,
			`imagepath`,
			`isactive`,	
            `isdelete`,
			`createdby`,
			`createddate`)
			values(pid,planguageid,pstatistictypeId,ptitle,pcount,purl,pimagename,pimagepath,pisactive,0,pusername,now());

else 

update `statisticdatamaster` set 
isactive=pisactive , 
updatedby=pusername,
updateddate=now() 
where id=pid;

if((select count(1) from `statisticdatamasterdetails` where statisticdataid=pid and languageid=planguageid )>0) then


update `statisticdatamasterdetails` 
          set 
			  statistictypeId = pstatistictypeId,
			  title = ptitle,
              count = pcount,
              url=purl,
              imagename=(case when ifnull(pimagename,'')<>'' then pimagename else pimagename end),
			  imagepath=(case when ifnull(pimagepath,'')<>'' then pimagepath else pimagepath end),
              isactive=pisactive,
              updatedby=pusername,
              updateddate=now()    
where 
statisticdataid=pid and languageid=planguageid;
UPDATE `statisticdatamasterdetails` SET `isactive` = pisactive WHERE `StatisticDataId` = pid;
else 
insert into `statisticdatamasterdetails`
			(`statisticdataid`,
            `languageid`,
            `statistictypeId`,
            `title`,
			`count`,
            `url`,
			`imagename`,
			`imagepath`,
			`isactive`,	
            `isdelete`,
			`createdby`,
			`createddate`)
			values(pid,planguageid,pstatistictypeId,ptitle,pcount,purl,pimagename,pimagepath,pisactive,0,pusername,now());
end if;

end if;

select pid as recid;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsInsertOrUpdateUserMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsInsertOrUpdateUserMaster`(
pId int,
    pRoleId int,
    pFirstName text,
    pLastName text,
    pEmail text,
    pUsername text,
    pPhoneNo text,
    pUserPassword text,
    pIsActive tinyint,
    pChangedBy text
)
BEGIN
	IF(pId = 0) THEN
		INSERT INTO `usersmaster`
        (
            `RoleId`,`FirstName`,
            `LastName`,`Email`,`Username`,
            `PhoneNo`,`UserPassword`,`IsActive`,
            `CreateBy`,`CreateDate`
        )
		VALUES(
            pRoleId,pFirstName,
            pLastName,pEmail,pUsername,
            pPhoneNo,pUserPassword,pIsActive,
            pChangedBy,now()
        );
		SET pId=last_insert_id();
    ELSE
        UPDATE `usersmaster`
        SET 
            `RoleId`=pRoleId,
            `FirstName`=pFirstName,
            `LastName`=pLastName,
            `Email`=pEmail,
            `Username`=pUsername,
            `PhoneNo`=pPhoneNo,
            `UserPassword`=(case when ifnull(pUserPassword,'')<>'' then pUserPassword else `UserPassword` end),
            `IsActive`=pIsActive,
            `UpdateBy`=pChangedBy,
            `UpdateDate`=now()
        WHERE `Id`=pId;
    END IF;
    SELECT pId as RecId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsInsertOrUpdateVideoMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsInsertOrUpdateVideoMaster`(
    pId int,
	pLanguageId int,
	pVideoId int,
	pVideoTitle longtext,
	pIsActive tinyint,
	pUsername text
)
begin
	if(pId=0) then 
		insert into `videomaster`(`IsActive`,`IsDelete`,`createby`,`createdate`)values(pIsActive,0,pUsername,now());

		set pVideoId=last_insert_id();

		insert into `videomasterdetails`(
			`VideoId`,`LanguageId`, `VideoTitle`, `IsActive`, `IsDelete`, `CreatedBy`, `CreatedDate`
		)
		values
		(
			pVideoId,pLanguageId, pVideoTitle, pIsActive, 0, pUsername, now()
		);
        insert into `videomasterdetails`(
			`VideoId`,`LanguageId`, `VideoTitle`, `IsActive`, `IsDelete`, `CreatedBy`, `CreatedDate`
		)
		values
		(
			pVideoId,2, pVideoTitle, pIsActive, 0, pUsername, now()
		);
        select pVideoId;
	else 
		update `videomaster` set 
		`IsActive`=pIsActive , 
		`UpdatedBy`=pUsername,
		`UpdatedDate`=now() 
		where `Id`=pId;



  -- update IsActive column in both master and details table
		UPDATE `videomaster` AS UCMSM JOIN `videomasterdetails` AS UCMSMD ON UCMSM.Id = UCMSMD.VideoId
        SET UCMSM.IsActive = pIsActive, 
        UCMSMD.IsActive = pIsActive,
         UCMSM.IsActive = pIsActive, 
        UCMSM.IsActive = pIsActive
        WHERE UCMSM.Id = pId;
        
        
		if((select count(1) from `videomasterdetails` where `videomasterdetails`.`VideoId`=pId and `videomasterdetails`.`LanguageId`=pLanguageId)>0) then
			update `videomasterdetails` 
			set 
            `VideoId`=pVideoId,
				`VideoTitle` = pVideoTitle,				
				`IsActive`=pIsActive,
				`UpdatedBy`=pUsername,                
				`UpdatedDate`=now()    
			where 
				`videomasterdetails`.`VideoId`=pId and LanguageId=pLanguageId;
			select pId;
		else 
			insert into `videomasterdetails`(
				`VideoId`,`LanguageId`, `VideoTitle`,  `IsActive`, `IsDelete`, `CreatedBy`, `CreatedDate`
			)
			values
			(
				pId,pLanguageId, pVideoTitle, pisactive, 0, pusername, now()
			);
		end if;

	end if;

	select pId as recid;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsInsertVideoMasterUrls` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsInsertVideoMasterUrls`(
	pVideoMasterId bigint,
	pVideoName text,
	pThumbImage text,
    pVideoUrl text,
    pislinkvideo int
)
BEGIN
insert into `videomasterurls`
	(
		VideoMasterId,
		VideoName,
		ThumbImage,
        VideoUrl,
        islinkvideo
	) 
	values
	(
		pVideoMasterId,
		pVideoName,
		pThumbImage,
        pVideoUrl,
        pislinkvideo
	);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsLockUnlockUserUtility` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsLockUnlockUserUtility`(
	pLock int,
    pUserId int,
    pUsername text
)
BEGIN
	DECLARE pid INT;
    DECLARE v_logtype VARCHAR(10);
    DECLARE v_ipaddress TEXT;
    DECLARE v_details TEXT;

    -- If we are unlocking the user
    IF pLock = 0 THEN
        -- unlock user 
		UPDATE userlogdetails
		SET UpdateBy = pUsername,
			UpdateDate = NOW(),
            IsLock = 0
		WHERE UserId = pUserId
		AND IsLock = 1;

        -- Get the latest log entry for the user
        SELECT Id, LogType, IPAddress, Details INTO pid, v_logtype, v_ipaddress, v_details
        FROM userlogdetails
        WHERE UserId = pUserId
        ORDER BY Id DESC
        LIMIT 1;

        -- Update the log entry to mark it as a logout and unlock the user
        -- If the latest log entry's LogType is 'login', update it to 'logout'
        IF v_logtype = 'login' THEN
            INSERT INTO userlogdetails (UserId, LogType, EntryDatetime, IPAddress, Details, IsLock, UpdateBy, UpdateDate)
            VALUES (pUserId, 'logout', NOW(), v_ipaddress, v_details, 0, pUsername, NOW());
		END IF;
    END IF;

    -- If we are locking the user
    IF pLock = 1 THEN
        -- Get the latest log entry for the user
        SELECT Id INTO pid
        FROM userlogdetails
        WHERE UserId = pUserId
        ORDER BY 1 DESC
        LIMIT 1;

        -- Update the log entry to lock the user without updating WrongAttempt
        UPDATE userlogdetails
        SET UpdateBy = pUsername,
			UpdateDate = NOW(),
            IsLock = 1
        WHERE Id = pid;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsPROC_Visitors_Select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsPROC_Visitors_Select`()
BEGIN
    SELECT MAX(updateddate) AS updateddate
    FROM (
        SELECT 
            CASE 
                WHEN COALESCE(CreatedDate, '0000-00-00') > COALESCE(updateddate, '0000-00-00') 
                THEN CreatedDate 
                ELSE updateddate 
            END AS updateddate
        FROM cmsmenuresourcemasterdetails
        UNION ALL
        SELECT 
            CASE 
                WHEN COALESCE(CreatedDate, '0000-00-00') > COALESCE(updateddate, '0000-00-00') 
                THEN CreatedDate 
                ELSE updateddate 
            END AS updateddate
        FROM cmstempltemasterdetails
        UNION ALL
        SELECT 
            CASE 
                WHEN COALESCE(CreatedDate, '0000-00-00') > COALESCE(updateddate, '0000-00-00') 
                THEN CreatedDate 
                ELSE updateddate 
            END AS updateddate
        FROM ministermasterdetails
        UNION ALL
        SELECT 
            CASE 
                WHEN COALESCE(CreatedDate, '0000-00-00') > COALESCE(updateddate, '0000-00-00') 
                THEN CreatedDate 
                ELSE updateddate 
            END AS updateddate
        FROM bannermasterdetails
        UNION ALL
        SELECT 
            CASE 
                WHEN COALESCE(CreatedDate, '0000-00-00') > COALESCE(updateddate, '0000-00-00') 
                THEN CreatedDate 
                ELSE updateddate 
            END AS updateddate
        FROM goilogomaster
        UNION ALL
        SELECT 
            CASE 
                WHEN COALESCE(CreatedDate, '0000-00-00') > COALESCE(updateddate, '0000-00-00') 
                THEN CreatedDate 
                ELSE updateddate 
            END AS updateddate
        FROM popupmasterdetails
        UNION ALL
        SELECT 
            CASE 
                WHEN COALESCE(CreatedDate, '0000-00-00') > COALESCE(updateddate, '0000-00-00') 
                THEN CreatedDate 
                ELSE updateddate 
            END AS updateddate
        FROM blogmasterdetails
		UNION ALL
        SELECT 
            CASE 
                WHEN COALESCE(CreatedDate, '0000-00-00') > COALESCE(updateddate, '0000-00-00') 
                THEN CreatedDate 
                ELSE updateddate 
            END AS updateddate
        FROM branchmasterdetails
        UNION ALL
        SELECT 
            CASE 
                WHEN COALESCE(CreatedDate, '0000-00-00') > COALESCE(updateddate, '0000-00-00') 
                THEN CreatedDate 
                ELSE updateddate 
            END AS updateddate
        FROM document_master
		UNION ALL
        SELECT 
            CASE 
                WHEN COALESCE(CreateDate, '0000-00-00') > COALESCE(updatedate, '0000-00-00') 
                THEN CreateDate 
                ELSE updatedate 
            END AS updateddate
        FROM gallerymasterdetails
        UNION ALL
        SELECT 
            CASE 
                WHEN COALESCE(CreatedDate, '0000-00-00') > COALESCE(updateddate, '0000-00-00') 
                THEN CreatedDate 
                ELSE updateddate 
            END AS updateddate
        FROM statisticdatamasterdetails
        UNION ALL
        SELECT 
            CASE 
                WHEN COALESCE(CreatedDate, '0000-00-00') > COALESCE(updateddate, '0000-00-00') 
                THEN CreatedDate 
                ELSE updateddate 
            END AS updateddate
        FROM ecitizenmasterdetails
        UNION ALL
        SELECT 
            CASE 
                WHEN COALESCE(CreatedDate, '0000-00-00') > COALESCE(updateddate, '0000-00-00') 
                THEN CreatedDate 
                ELSE updateddate 
            END AS updateddate
        FROM bannervideomaster
        UNION ALL
        SELECT 
            CASE 
                WHEN COALESCE(CreatedDate, '0000-00-00') > COALESCE(updateddate, '0000-00-00') 
                THEN CreatedDate 
                ELSE updateddate 
            END AS updateddate
        FROM newsmasterdetails
		UNION ALL
        SELECT 
            CASE 
                WHEN COALESCE(CreatedDate, '0000-00-00') > COALESCE(updateddate, '0000-00-00') 
                THEN CreatedDate 
                ELSE updateddate 
            END AS updateddate
        FROM eventmasterdetails
        
    ) AS combined_updates;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsRemoveAchievementsImages` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsRemoveAchievementsImages`(
pblogmasterid bigint
)
begin

delete from blogmasterimages where blogmasterid= pblogmasterid;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsRemoveAdminMenuMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsRemoveAdminMenuMaster`(id int, changedby text)
begin
	update adminmenumaster set isdelete=1,deleteby=changedby,deletedate=now() where adminmenumaster.id=id;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsRemoveBannerMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsRemoveBannerMaster`(
p_id int,username text )
begin

update bannermaster set isactive=0,isdelete=1 , deletedby=username,deleteddate=now() where id = p_id;

update bannermasterdetails set isactive=0,isdelete=1 , deletedby=username,deleteddate=now() where bannerid = p_id;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsRemoveBlogMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsRemoveBlogMaster`(pid int,pusername text)
begin
update `blogmaster` set isactive=0,isdelete=1 , deletedby=pusername,deleteddate=now() where id=pid;

update `blogmasterdetails` set isactive=0,isdelete=1 , deleteby=pusername,deleteddate=now() where blogmasterdetails.blogmasterid=pid ;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsRemoveBranchMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsRemoveBranchMaster`(pId int, pUsername text)
BEGIN  
   update branchmaster set IsActive=0,IsDelete=1 , DeletedBy=pUsername,DeletedDate=now() where branchmaster.Id=pId;

	update branchmasterdetails set IsActive=0,IsDelete=1 , DeletedBy=pUsername,DeletedDate=now() where branchmasterdetails.Branchid=pId ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsRemoveBrandPresenceMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsRemoveBrandPresenceMaster`(id int,username text)
begin
update brandpresencemaster set isactive=0,isdelete=1 , deletedby=username,deleteddate=now() where brandpresencemaster.id=id;

update brandpresencemasterdetails set isactive=0,isdelete=1 , deletedby=username,deleteddate=now() where brandpresencemasterdetails.brandpresenceid=id ;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsRemoveCMSMenuResourceMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsRemoveCMSMenuResourceMaster`(
pid int,username text
)
begin

update `cmsmenuresourcemaster` set isactive=0,isdelete=1 , deletedby=username,deleteddate=now() where id=pid ;

update `cmsmenuresourcemasterdetails` set isactive=0,isdelete=1 , deletedby=username,deleteddate=now() where cmsmenuresid=pid ;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsRemoveCMSTemplteMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsRemoveCMSTemplteMaster`(
tid int,username text
)
begin

update `cmstempltemaster` set isactive=0,isdelete=1 , deletedby=username,deleteddate=now() where id=tid;

update `cmstempltemasterdetails` set isactive=0,isdelete=1 , deletedby=username,deleteddate=now() where templateid=tid ;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsRemoveCssMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsRemoveCssMaster`(id int, username text)
begin
   update cssmaster set isactive=0,isdelete=1 , deletedby=username,deletedate=now() where cssmaster.id=id;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsRemoveDistrictMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsRemoveDistrictMaster`(
pid bigint,
pusername text
)
begin
update `districtmaster` set IsActive=0,IsDelete=1, DeletedBy=pusername,DeletedAt=now() where id=pid;  
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsRemoveDistrictProductData` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsRemoveDistrictProductData`(
pid bigint,
pusername text
)
begin
update `districtproduct` set IsActive=0,IsDelete=1, DeletedBy=pusername,DeletedAt=now() where DistrictProductId=pid;  
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsRemoveDistrictProfileData` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsRemoveDistrictProfileData`(
pid bigint,
pusername text
)
begin
update `districtprofile` set IsActive=0,IsDelete=1, DeletedBy=pusername,DeletedAt=now() where DistrictProfileId=pid;  
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsRemoveDocumentMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsRemoveDocumentMaster`(
pdoc_id int,
pusername text
)
begin
  update `document_master` 
          set isactive = 0,
			  isdelete=1,              
              deletedby=pusername,
              deleteddate=now()            
        where doc_id=pdoc_id; 
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsRemoveEcitizenMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsRemoveEcitizenMaster`(pid int,pusername text)
begin
update `ecitizenmaster` set isactive=0,isdelete=1 , deletedby=pusername,deleteddate=now() where id=pid;

update `ecitizenmasterdetails` set isactive=0,isdelete=1 , deletedby=pusername,deleteddate=now() where ecitizenid=pid ;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsRemoveEventImages` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsRemoveEventImages`(
peventmasterid bigint
)
begin

	delete from eventmasterimages where eventmasterid= peventmasterid;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsRemoveEventMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsRemoveEventMaster`(pId int,pUsername text)
begin

	update `eventmaster` set IsActive=0,IsDelete=1, DeletedBy=pUsername, DeletedDate=now() where Id=pId;

	update `eventmasterdetails` set IsActive=0,IsDelete=1, DeleteBy=pUsername, DeletedDate=now() where eventmasterdetails.EventMasterId=pId ;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsRemoveGalleryImages` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsRemoveGalleryImages`(
pgallerymasterid bigint
)
begin

delete from gallerymasterimages where gallerymasterid= pgallerymasterid;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsRemoveGalleryMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsRemoveGalleryMaster`(
pid bigint,
pusername text
)
begin
update `gallerymaster` set isactive=0,isdelete=1 , deletedby=pusername,deleteddate=now() where id=pid;

update `gallerymasterdetails` set isactive=0,isdelete=1 , deleteby=pusername,deletedate=now() where gallerymasterdetails.gallerymasterid=pid ;
        
        
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsRemoveGoiLogoMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsRemoveGoiLogoMaster`(
pid int,
pusername text
)
begin
  update `goilogomaster` 
          set isactive = 0,
			  isdelete=1,              
              deletedby=pusername,
              deleteddate=now()            
        where id=pid; 
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsRemoveJsMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsRemoveJsMaster`(id int, username text)
begin
   update jsmaster set isactive=0,isdelete=1 , deletedby=username,deleteddate=now() where jsmaster.id=id;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsRemoveLanguageMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsRemoveLanguageMaster`(pid INT, pUserid INT)
BEGIN
    -- If the language is in use in other tables, don't delete it
    IF EXISTS (
        SELECT 1
        FROM blogmasterdetails
        WHERE LanguageId = pid
        UNION ALL
        SELECT 1
        FROM popupmasterdetails
        WHERE LanguageId = pid
        -- Add more tables as needed
    ) THEN
        select 'Language is still in use in other pages' as strMessage,1 as isError,'error' as type;
    ELSE
        -- If the language is not in use in other tables, mark it as deleted
        UPDATE cmslanguagemaster
        SET isvisible = 0,
            `deletedby` = pUserid,
            isdelete = 1,
            deleteddate = NOW()
        WHERE cmslanguagemaster.id = pid;
        
        select 'Record Removed success' as strMessage,0 as isError,'success' as type;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsRemoveMenuResourceMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsRemoveMenuResourceMaster`(id int, changedby text)
begin
	update menuresourcemaster set isdelete=1,deleteby=changedby,deletedate=now() where menuresourcemaster.id=id;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsRemoveMinisterMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsRemoveMinisterMaster`(
id int,username text
)
begin
update ministermaster set isactive=0,isdelete=1 , deletedby=username,deleteddate=now() where ministermaster.id=id;

update ministermasterdetails set isactive=0,isdelete=1 , deletedby=username,deletedate=now() where ministermasterdetails.ministerid=id ;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsRemoveNewsMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsRemoveNewsMaster`(pid int,pusername text)
begin

	update `newsmaster` set IsActive=0,IsDelete=1 , DeletedBy=pUsername,DeletedDate=now() where Id=pId;

	update `newsmasterdetails` set IsActive=0,IsDelete=1 , DeletedBy=pUsername,DeletedDate=now() where NewsId=pId ;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsRemovePopupMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsRemovePopupMaster`(
id int,username text
)
begin
update popupmaster set isactive=0,isdelete=1 , deletedby=username,deleteddate=now() where popupmaster.id=id;

update popupmasterdetails set isactive=0,isdelete=1 , deletedby=username,deletedate=now() where popupmasterdetails.popupid=id ;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsRemoveProcessedProductData` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsRemoveProcessedProductData`(
pid bigint,
pusername text
)
begin
update `processedproduct` set IsActive=0,IsDelete=1, DeletedBy=pusername,DeletedAt=now() where ProcessedProductId=pid;  
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsRemoveProcessingUnitAndPortMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsRemoveProcessingUnitAndPortMaster`(
pId bigint,
pUsername text
)
begin
update `processingunitandport` set IsActive=0,IsDelete=1, DeletedBy=pUsername,DeletedAt=now() where ProcessingUnitandPortId=pId;  
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsRemoveProductMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsRemoveProductMaster`(
pid bigint,
pusername text
)
begin
update `productmaster` set IsActive=0,IsDelete=1, DeletedBy=pusername,DeletedAt=now() where Id=pid;  
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsRemoveRoleMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsRemoveRoleMaster`(id int, changedby text)
begin
	update rolemaster set isdelete=1,deleteby=changedby,deletedate=now() where rolemaster.id=id;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsRemoveRoleMenuRightsByRoleId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsRemoveRoleMenuRightsByRoleId`(UserRoleId int)
begin

    delete from menurightsmaster where RoleId=UserRoleId and id <> 0;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsRemoveServiceRateMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsRemoveServiceRateMaster`(
id int,username text
)
begin
update serviceratemaster set isactive=0,isdelete=1 , deletedby=username,deleteddate=now() where serviceratemaster.id=id;

update serviceratemasterdetails set isactive=0,isdelete=1 , deletedby=username,deletedate=now() where serviceratemasterdetails.servicerateid=id ;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsRemoveStatisticMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsRemoveStatisticMaster`(pid int,pusername text)
begin
update `statisticdatamaster` set isactive=0,isdelete=1 , deletedby=pusername,deleteddate=now() where id=pid;

update `statisticdatamasterdetails` set isactive=0,isdelete=1 , deletedby=pusername,deleteddate=now() where statisticdataid=pid ;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsRemoveUserMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsRemoveUserMaster`(id int, changedby text)
begin
	update usersmaster set isdelete=1,deleteby=changedby,deletedate=now() where usersmaster.id=id;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsRemoveVideoMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsRemoveVideoMaster`(pId int,pUsername text)
BEGIN
	update `videomaster` set `IsActive`=0,`IsDelete`=1 , `DeletedBy`=pUsername,`DeletedDate`=now() where `Id`=pId ;
    update `videomasterdetails` set `IsActive`=0,`IsDelete`=1 , `DeletedBy`=pUserName,`DeletedDate`=now() where `videomasterdetails`.`VideoId`=pId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmstbl_Menu_SelectAll` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmstbl_Menu_SelectAll`(in p_languageid int)
begin
select	
	 d.id,m.id	
	-- , d.languageid
	, (concat(cast(menuname as nchar(100)), ' <-- ' , ifnull(  (
														select
																cast(menuname as nchar(100))
														from
																cmsmenuresourcemasterdetails
														where
															m.id = m.col_parent_id
														limit 1
													) , ' '))
		) as menuname,d.languageid
from
	cmsmenuresourcemaster as m
	inner join cmsmenuresourcemasterdetails as d
		on d.cmsmenuresid = m.id
where
	d.languageid	= p_languageid
	and col_menu_type in (0, 1)
	and d.isactive = 1;
-- order by
	-- col_menu_level;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsUpdateEmailSentStatus` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsUpdateEmailSentStatus`(
    IN pId BIGINT,
    IN pUserId BIGINT,
    IN pEventId BIGINT,
    IN pIsEmailSent TINYINT
)
BEGIN
   
    UPDATE eventapplications
    SET IsEmailSent = pIsEmailSent
    WHERE UserId = pUserId AND EventId = pEventId and Id = pId;

   select pId as Id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsUpdateEventEmailLogDetails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsUpdateEventEmailLogDetails`(
	pId bigint,
	pIsEmailsent tinyint,
    pAdminId bigint,
    pSentBy text

)
BEGIN
		UPDATE `eventemaillogdetails`
            set 
            IsEmailsent = pIsEmailsent,
            AdminId = pAdminId,
            SentBy = pSentBy,
            CreatedDate = NOW()
            where Id = pId;
      
        SELECT LAST_INSERT_ID() AS Id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsUpdateFrontUserProfile` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsUpdateFrontUserProfile`(
pId int,
pFirstName text, 
pMiddleName text,
pLastName text, 
pEmail text,
pPhoneNo text,
pCreateBy text,
pAddress text,
pApplicantPhoto text,
pInvestorType text,
pIsExistingInvestment text,
pAgroFoodPreferences text,
pKeyInterest text,
pAverageInvestment text,
pInvestmentHorizon text,
pSpecificInformation text,
pAdditionalInformation text,
pDesignation text,
pCompany text,
pPinCode text,
pWebsite text,
pState text,
pCity text
)
BEGIN
    Update frontusermaster 
    set 
        FirstName = pFirstName,
        MiddleName = pMiddleName,
        LastName = pLastName,
        Email = pEmail,
        PhoneNo = pPhoneNo,
        UpdateBy = pCreateBy,
        Address = pAddress,
        ApplicantPhoto = (case when ifnull(pApplicantPhoto,'')<>'' then pApplicantPhoto else ApplicantPhoto end),
        IsChangeProfile = 1,
        UpdateDate = NOW(),
        InvestorType = pInvestorType,
        IsExistingInvestment = pIsExistingInvestment,
        AgroFoodPreferences = pAgroFoodPreferences,
        KeyInterest = pKeyInterest,
        AverageInvestment = pAverageInvestment,
        InvestmentHorizon =  pInvestmentHorizon,
        SpecificInformation = pSpecificInformation,
        AdditionalInformation = pAdditionalInformation,
        Designation = pDesignation,
        Company = pCompany,
        PinCode = pPinCode,
        Website = pWebsite,
        State = pState,
        City = pCity
        
 where frontusermaster.id = pId;
 
  SELECT
    pId AS id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsUpdateProfilePicUserMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsUpdateProfilePicUserMaster`(
	pId int,
    pStrData text,
    pUsername text
)
BEGIN
	IF(pId != 0) THEN
        UPDATE `usersmaster`
        SET 
            `ProfilePic`=pStrData,
            `UpdateBy`=pUsername,
            `UpdateDate`=now()
        WHERE `Id`=pId;
    END IF;
    SELECT pId as RecId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsUpdateStatusAdminMenuMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsUpdateStatusAdminMenuMaster`(
	pId int,
    pIsActive tinyint,
    pUsername text
)
BEGIN
	IF(pId != 0) THEN
        UPDATE `adminmenumaster`
        SET 
            `IsActive`=pIsActive,
            `UpdateBy`=pUsername,
            `UpdateDate`=now()
        WHERE `Id`=pId;
    END IF;
    SELECT pId as RecId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsUpdateStatusBannerMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsUpdateStatusBannerMaster`(
	pId int,
    pIsActive tinyint,
    pUsername text
)
BEGIN
	IF(pId != 0) THEN
        UPDATE bannermaster AS m
        LEFT JOIN bannermasterdetails AS d ON d.BannerId = m.Id
        SET 
            m.IsActive = pIsActive,
            m.UpdatedBy = pUsername,
            m.UpdatedDate = NOW(),
            d.IsActive = pIsActive,
            d.UpdatedBy = pUsername,
            d.UpdatedDate = NOW()
        WHERE m.Id = pId;
    END IF;
    SELECT pId as RecId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsUpdateStatusBranchMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsUpdateStatusBranchMaster`(
	pId int,
    pIsActive tinyint,
    pUsername text
)
BEGIN
	IF(pId != 0) THEN
        UPDATE branchmaster AS m
        LEFT JOIN branchmasterdetails AS d ON d.BranchId = m.Id
        SET 
            m.IsActive = pIsActive,
            m.UpdatedBy = pUsername,
            m.UpdatedDate = NOW(),
            d.IsActive = pIsActive,
            d.UpdatedBy = pUsername,
            d.UpdatedDate = NOW()
        WHERE m.Id = pId;
    END IF;
    SELECT pId as RecId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsUpdateStatusCMSMenuResourceMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsUpdateStatusCMSMenuResourceMaster`(
	pId int,
    pIsActive tinyint,
    pUsername text
)
BEGIN
	IF(pId != 0) THEN
        UPDATE cmsmenuresourcemaster AS m
        LEFT JOIN cmsmenuresourcemasterdetails AS d ON d.CMSMenuResId = m.Id
        SET 
            m.IsActive = pIsActive,
            m.UpdatedBy = pUsername,
            m.UpdatedDate = NOW(),
            d.IsActive = pIsActive,
            d.UpdatedBy = pUsername,
            d.UpdatedDate = NOW()
        WHERE m.Id = pId;
    END IF;
    SELECT pId as RecId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsUpdateStatusCMSTemplteMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsUpdateStatusCMSTemplteMaster`(
	pId int,
    pIsActive tinyint,
    pUsername text
)
BEGIN
	IF(pId != 0) THEN
        UPDATE cmstempltemaster AS m
        LEFT JOIN cmstempltemasterdetails AS d ON d.TemplateId = m.Id
        SET 
            m.IsActive = pIsActive,
            m.UpdatedBy = pUsername,
            m.UpdatedDate = NOW(),
            d.IsActive = pIsActive,
            d.UpdatedBy = pUsername,
            d.UpdatedDate = NOW()
        WHERE m.Id = pId;
    END IF;
    SELECT pId as RecId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsUpdateStatusCssMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsUpdateStatusCssMaster`(
	pId int,
    pIsActive tinyint,
    pUsername text
)
BEGIN
	IF(pId != 0) THEN
        UPDATE `cssmaster`
        SET 
            `IsActive`=pIsActive,
            `UpdatedBy`=pUsername,
            `UpdatedDate`=now()
        WHERE `Id`=pId;
    END IF;
    SELECT pId as RecId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsUpdateStatusDocumentMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsUpdateStatusDocumentMaster`(
	pId int,
    pIsActive tinyint,
    pUsername text
)
BEGIN
	IF(pId != 0) THEN
        UPDATE `document_master`
        SET 
            `IsActive`=pIsActive,
            `UpdatedBy`=pUsername,
            `UpdatedDate`=now()
        WHERE `Doc_Id`=pId;
    END IF;
    SELECT pId as RecId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsUpdateStatusEcitizenMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsUpdateStatusEcitizenMaster`(
	pId int,
    pIsActive tinyint,
    pUsername text
)
BEGIN
	IF(pId != 0) THEN
        UPDATE ecitizenmaster AS m
        LEFT JOIN ecitizenmasterdetails AS d ON d.EcitizenId = m.Id
        SET 
            m.IsActive = pIsActive,
            m.UpdatedBy = pUsername,
            m.UpdatedDate = NOW(),
            d.IsActive = pIsActive,
            d.UpdatedBy = pUsername,
            d.UpdatedDate = NOW()
        WHERE m.Id = pId;
    END IF;
    SELECT pId as RecId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsUpdateStatusGalleryMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsUpdateStatusGalleryMaster`(
	pId int,
    pIsActive tinyint,
    pUsername text
)
BEGIN
	IF(pId != 0) THEN
        UPDATE gallerymaster AS m
        LEFT JOIN gallerymasterdetails AS d ON d.GallerymasterId = m.Id
        SET 
            m.IsActive = pIsActive,
            m.UpdatedBy = pUsername,
            m.UpdatedDate = NOW(),
            d.IsActive = pIsActive,
            d.UpdateBy = pUsername,
            d.UpdateDate = NOW()
        WHERE m.Id = pId;
    END IF;
    SELECT pId as RecId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsUpdateStatusGoiLogoMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsUpdateStatusGoiLogoMaster`(
	pId int,
    pIsActive tinyint,
    pUsername text
)
BEGIN
	IF(pId != 0) THEN
        UPDATE `goilogomaster`
        SET 
            `IsActive`=pIsActive,
            `UpdatedBy`=pUsername,
            `UpdatedDate`=now()
        WHERE `Id`=pId;
    END IF;
    SELECT pId as RecId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsUpdateStatusJsMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsUpdateStatusJsMaster`(
	pId int,
    pIsActive tinyint,
    pUsername text
)
BEGIN
	IF(pId != 0) THEN
        UPDATE `jsmaster`
        SET 
            `IsActive`=pIsActive,
            `UpdatedBy`=pUsername,
            `UpdatedDate`=now()
        WHERE `Id`=pId;
    END IF;
    SELECT pId as RecId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsUpdateStatusMenuResourceMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsUpdateStatusMenuResourceMaster`(
	pId int,
    pIsActive tinyint,
    pUsername text
)
BEGIN
	IF(pId != 0) THEN
        UPDATE `menuresourcemaster`
        SET 
            `IsActive`=pIsActive,
            `UpdateBy`=pUsername,
            `UpdateDate`=now()
        WHERE `Id`=pId;
    END IF;
    SELECT pId as RecId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsUpdateStatusMinisterMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsUpdateStatusMinisterMaster`(
	pId int,
    pIsActive tinyint,
    pUsername text
)
BEGIN
	IF(pId != 0) THEN
        UPDATE ministermaster AS m
        LEFT JOIN ministermasterdetails AS d ON d.MinisterID = m.Id
        SET 
            m.IsActive = pIsActive,
            m.UpdatedBy = pUsername,
            m.UpdatedDate = NOW(),
            d.IsActive = pIsActive,
            d.UpdatedBy = pUsername,
            d.UpdatedDate = NOW()
        WHERE m.Id = pId;
    END IF;
    SELECT pId as RecId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsUpdateStatusNewsMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsUpdateStatusNewsMaster`(
	pId int,
    pIsActive tinyint,
    pUsername text
)
BEGIN
	IF(pId != 0) THEN
        UPDATE newsmaster AS m
        LEFT JOIN newsmasterdetails AS d ON d.NewsId = m.Id
        SET 
            m.IsActive = pIsActive,
            m.UpdatedBy = pUsername,
            m.UpdatedDate = NOW(),
            d.IsActive = pIsActive,
            d.UpdatedBy = pUsername,
            d.UpdatedDate = NOW()
        WHERE m.Id = pId;
    END IF;
    SELECT pId as RecId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsUpdateStatusPopupMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsUpdateStatusPopupMaster`(
	pId int,
    pIsActive tinyint,
    pUsername text
)
BEGIN
	IF(pId != 0) THEN
        UPDATE popupmaster AS m
        LEFT JOIN popupmasterdetails AS d ON d.popupID = m.Id
        SET 
            m.IsActive = pIsActive,
            m.UpdatedBy = pUsername,
            m.UpdatedDate = NOW(),
            d.IsActive = pIsActive,
            d.UpdatedBy = pUsername,
            d.UpdatedDate = NOW()
        WHERE m.Id = pId;
    END IF;
    SELECT pId as RecId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsUpdateStatusProjectMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsUpdateStatusProjectMaster`(
	pId int,
    pIsActive tinyint,
    pUsername text
)
BEGIN
	IF(pId != 0) THEN
        UPDATE projectmaster AS m
        LEFT JOIN projectmasterdetails AS d ON d.ProjectMasterId = m.Id
        SET 
            m.IsActive = pIsActive,
            m.UpdatedBy = pUsername,
            m.UpdatedDate = NOW(),
            d.IsActive = pIsActive,
            d.UpdatedBy = pUsername,
            d.UpdatedDate = NOW()
        WHERE m.Id = pId;
    END IF;
    SELECT pId as RecId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsUpdateStatusRoleMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsUpdateStatusRoleMaster`(
	pId int,
    pIsActive tinyint,
    pUsername text
)
BEGIN
	IF(pId != 0) THEN
        UPDATE `rolemaster`
        SET 
            `IsActive`=pIsActive,
            `UpdateBy`=pUsername,
            `UpdateDate`=now()
        WHERE `Id`=pId;
    END IF;
    SELECT pId as RecId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsUpdateStatusStatisticMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsUpdateStatusStatisticMaster`(
	pId int,
    pIsActive tinyint,
    pUsername text
)
BEGIN
	IF(pId != 0) THEN
        UPDATE statisticdatamaster AS m
        LEFT JOIN statisticdatamasterdetails AS d ON d.StatisticDataId = m.Id
        SET 
            m.IsActive = pIsActive,
            m.UpdatedBy = pUsername,
            m.UpdatedDate = NOW(),
            d.IsActive = pIsActive,
            d.UpdatedBy = pUsername,
            d.UpdatedDate = NOW()
        WHERE m.Id = pId;
    END IF;
    SELECT pId as RecId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsUpdateStatusUserMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsUpdateStatusUserMaster`(
	pId int,
    pIsActive tinyint,
    pUsername text
)
BEGIN
	IF(pId != 0) THEN
        UPDATE `usersmaster`
        SET 
            `IsActive`=pIsActive,
            `UpdateBy`=pUsername,
            `UpdateDate`=now()
        WHERE `Id`=pId;
    END IF;
    SELECT pId as RecId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsUpdateStatusVideoMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsUpdateStatusVideoMaster`(
	pId int,
    pIsActive tinyint,
    pUsername text
)
BEGIN
	IF(pId != 0) THEN
        UPDATE videomaster AS m
        LEFT JOIN videomasterdetails AS d ON d.VideoId = m.Id
        SET 
            m.IsActive = pIsActive,
            m.UpdatedBy = pUsername,
            m.UpdatedDate = NOW(),
            d.IsActive = pIsActive,
            d.UpdatedBy = pUsername,
            d.UpdatedDate = NOW()
        WHERE m.Id = pId;
    END IF;
    SELECT pId as RecId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cmsUpdateUserProfile` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `cmsUpdateUserProfile`(
pId int,
pFirstName text, 
pMiddleName text,
pLastName text, 
pEmail text,
pPhoneNo text,
pCreateBy text,
pAddress text,
pApplicantPhoto text
)
BEGIN
    Update frontusermaster 
    set 
        FirstName = pFirstName,
        MiddleName = pMiddleName,
        LastName = pLastName,
        Email = pEmail,
        PhoneNo = pPhoneNo,
        UpdateBy = pCreateBy,
        Address = pAddress,
        ApplicantPhoto = (case when ifnull(pApplicantPhoto,'')<>'' then pApplicantPhoto else ApplicantPhoto end),
        IsChangeProfile = 1,
        UpdateDate = NOW()
   
 where frontusermaster.id = pId;
 
  SELECT
    pId AS id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `FrontGetAllAlbumvideos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `FrontGetAllAlbumvideos`(in p_id text,planguageid int)
BEGIN
  SELECT 
   yeim.*, yeim.islinkvideo,gmd.VideoTitle
FROM
    videomasterurls AS yeim
        INNER JOIN
    videomaster AS yem ON yeim.VideoMasterId = yem.Id
        INNER JOIN
    videomasterdetails AS gmd ON gmd.VideoId = yem.Id
        AND gmd.LanguageId = IFNULL(planguageid, 1)
        
WHERE
    IFNULL(yem.`IsActive`, 0) = 1
        AND IFNULL(yem.`IsDelete`, 0) = 0
        AND yeim.VideoMasterId = p_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `frontGetAllBannerMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `frontGetAllBannerMaster`(
langid int
)
begin

	select cmsmd.* from bannermaster as cmsm 
	inner join bannermasterdetails as cmsmd 
	on cmsm.id=cmsmd.bannerid and cmsmd.languageid= langid
	where cmsm.isdelete<>1 and cmsmd.isdelete<>1 and cmsmd.isactive=1;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `frontGetAllBranchMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `frontGetAllBranchMaster`(pLangId int)
BEGIN
	SELECT CMSMD.* FROM branchmaster as CMSM 
	inner join branchmasterdetails as CMSMD 
	on CMSM.Id=CMSMD.Branchid and CMSMD.LanguageId=ifnull(pLangId,1)
	where CMSM.IsDelete=0 and CMSMD.IsDelete<>1 and CMSM.IsActive=1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `frontGetAllBrandPresenceMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `frontGetAllBrandPresenceMaster`(langid int)
BEGIN
select cmsmd.* from brandpresencemaster as cmsm
inner join brandpresencemasterdetails as cmsmd on cmsm.id=cmsmd.brandpresenceid and cmsmd.languageid=ifnull(langid,1)
where cmsm.isdelete<>1 and cmsmd.isdelete<>1 and cmsm.isactive<>0 and cmsmd.isactive<>0;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `frontGetAllCMSMenuResourceMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `frontGetAllCMSMenuResourceMaster`(
langid int
)
begin



select row_number() over (order by cmsm.col_parent_id,cmsm.menurank)srno,cmsmd.*,cmsm.*,  
  (case
        when cmsm.col_parent_id = 0 then cmsmd.menuname -- then ''
        else
        (select rm.menuname from cmsmenuresourcemasterdetails as rm where rm.cmsmenuresid =cmsm.col_parent_id 
        and rm.languageid = ifnull(1,1) order by cmsm.id limit 1 )
    end) as parentname,
(case when col_parent_id=0 then (select (count(*) div 2)+1
from cmsmenuresourcemaster where col_parent_id=0) else 0 end)menudiv
    from cmsmenuresourcemaster as cmsm 
inner join cmsmenuresourcemasterdetails as cmsmd 
on cmsm.id=cmsmd.cmsmenuresid and  languageid=ifnull(langid,1)

where 
cmsm.isactive<>0 and 
cmsm.isdelete<>1 ;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `frontGetAllEcitizenMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `frontGetAllEcitizenMaster`(
	pLangId int,
    pType text
)
BEGIN
	SELECT CMSMD.*,Br.Branchname,DATE_FORMAT(Date, '%d/%m/%Y') as EcitizenDateDisplay,DATE_FORMAT(Date, '%M %d, %Y') as IndexFrontDateDisplay,ROW_NUMBER() OVER() AS rownum  
	FROM ecitizenmaster as CMSM 
	inner join ecitizenmasterdetails as CMSMD 
    left join branchmasterdetails as Br on CMSMD.BranchId=Br.BranchId and Br.LanguageId=IFNULL(pLangId,1) on CMSM.Id=CMSMD.EcitizenID and CMSMD.LanguageId=IFNULL(pLangId,1)
    inner join ecitizenmastertype as CMSMT on CMSMD.EcitizenTypeId=CMSMT.Id and CMSMT.IsVisible=1
	where CMSM.IsDelete<>1 and CMSMD.IsDelete<>1  and CMSMD.IsActive<>0
    and (
		pType IS NULL 
        OR pType = '' 
        OR (pType = 'Government Resolution' AND CMSMD.EcitizenTypeId = 1)
        OR (pType = 'Notification' AND CMSMD.EcitizenTypeId = 2)
        OR (pType = 'Circular' AND CMSMD.EcitizenTypeId = 3)
        OR (pType = 'Right to Information' AND CMSMD.EcitizenTypeId = 4)
        OR (pType = 'Downloads' AND CMSMD.EcitizenTypeId = 5)
        OR (pType = 'Tender' AND CMSMD.EcitizenTypeId = 6)
        OR (pType = 'Others' AND CMSMD.EcitizenTypeId = 7)
        OR (pType = 'Act & Rule' AND CMSMD.EcitizenTypeId = 8)
        OR (pType = 'Notification Circular' AND (CMSMD.EcitizenTypeId = 2 OR CMSMD.EcitizenTypeId = 3))
	)
	order by Date desc;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `frontGetAllEventApplications` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `frontGetAllEventApplications`()
BEGIN
  SELECT
    ea.*,
    fu.FirstName,
    fu.MiddleName,
    fu.LastName,
    fu.email,
    fu.PhoneNo,
    fu.Address,
    fu.CreateDate as UserRegisteredDate,
    em.*,
    date_format(em.eventstartdate,'%d-%b-%y') as blogdateconvert, CONCAT(DATE_FORMAT(eventStartDate, '%d/%m/%Y %h:%i %p'), ' - ', DATE_FORMAT(eventEndDate, '%d/%m/%Y %h:%i %p')) AS eventdate,
    DATE_FORMAT(eventStartDate, '%d') as eventStartDate_Date, year(eventStartDate) as eventStartDate_Year, DATE_FORMAT(eventStartDate, '%b') AS eventStartDate_MonthShortName,
    DATE_FORMAT(eventStartDate, '%h:%i %p') AS eventStartDate_Time, DATE_FORMAT(eventEndDate, '%h:%i %p') AS eventEndDate_Time,
    DATE_FORMAT(eventStartDate, '%d %b, %Y') as eventStartDateFormat, DATE_FORMAT(eventEndDate, '%d %b, %Y') as eventEndDateFormat
    
    
  FROM eventapplications AS ea
  JOIN frontusermaster fu on ea.UserId = fu.Id
  JOIN eventmasterdetails em on ea.EventId  =  em.EventMasterId
  WHERE fu.IsDelete <> 1 and em.IsDelete <> 1
  Order By  em.eventstartdate DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `frontGetAllEventMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `frontGetAllEventMaster`(
	pLangId int
)
begin

	select CMSMD.*,(select ImagePath from eventmasterimages as CMSMI where CMSMI.EventMasterId=CMSM.Id limit 1) as firstimagepath,
    date_format(CMSMD.eventstartdate,'%d-%b-%y') as blogdateconvert, CONCAT(DATE_FORMAT(eventStartDate, '%d/%m/%Y %h:%i %p'), ' - ', DATE_FORMAT(eventEndDate, '%d/%m/%Y %h:%i %p')) AS eventdate,
    DATE_FORMAT(eventStartDate, '%d') as eventStartDate_Date, year(eventStartDate) as eventStartDate_Year, DATE_FORMAT(eventStartDate, '%b') AS eventStartDate_MonthShortName,
	DATE_FORMAT(eventStartDate, '%h:%i %p') AS eventStartDate_Time, DATE_FORMAT(eventEndDate, '%h:%i %p') AS eventEndDate_Time,
    DATE_FORMAT(eventStartDate, '%d %b, %Y') as eventStartDateFormat, DATE_FORMAT(eventEndDate, '%d %b, %Y') as eventEndDateFormat
	from eventmaster as CMSM
	inner join eventmasterdetails as CMSMD on CMSM.Id=CMSMD.EventMasterId and CMSMD.LanguageId=ifnull(pLangId,1)
	where CMSM.IsDelete<>1 and CMSMD.IsDelete<>1 and CMSMD.IsActive=1 order by CMSMD.eventstartdate desc;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `frontGetAllMinisterMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `frontGetAllMinisterMaster`(
langid int
)
begin
select cmsmd.*

-- (case when cmsmd.languageid=ifnull(langid,1) then se.sectionnameeng else  se.sectionnameguj end) as sectionname 
from ministermaster as cmsm 
inner join ministermasterdetails as cmsmd on cmsm.id=cmsmd.ministerid and cmsmd.languageid=ifnull(langid,1)
where cmsm.isdelete<>1 and cmsmd.isdelete<>1 and cmsmd.isactive<>0 and cmsm.isactive<>0 order by cmsmd.MinisterRank;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `frontGetAllNewsMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `frontGetAllNewsMaster`(
	pLangId int,
    pType text
)
begin
    
    SELECT CMSMD.*,DATE_FORMAT(CMSMD.PublicDate, '%d/%m/%Y') as DateDisplay,DATE_FORMAT(CMSMD.PublicDate, '%M %d, %Y') as IndexFrontDateDisplay 
	FROM newsmaster as CMSM 
	inner join newsmasterdetails as CMSMD on CMSM.Id=CMSMD.NewsId and CMSMD.LanguageId=IFNULL(pLangId,1)
    inner join newsmastertype as CMSMT on CMSMT.Id=CMSMD.NewsTypeId and CMSMT.IsVisible=1
    where CMSM.IsDelete<>1 and CMSMD.IsDelete<>1 and CMSM.IsActive=1 and CMSMD.IsActive=1
    and (
		pType IS NULL 
        OR pType = '' 
        OR (pType = 'Announcement' AND CMSMD.NewsTypeId = 1)
        OR (pType = 'Latest News' AND CMSMD.NewsTypeId = 2)
	)
	order by createddate desc;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `frontGetAllPopupMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `frontGetAllPopupMaster`(
	LangId int
)
BEGIN
	SELECT CMSMD.* FROM popupmaster as CMSM 
	inner join popupmasterdetails as CMSMD 
	on CMSM.Id=CMSMD.popupID and CMSMD.LanguageId=IFNULL(LangId,1)
	where CMSM.IsDelete<>1 and CMSMD.IsDelete<>1 and CMSM.IsActive=1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `frontGetAllServiceRateMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `frontGetAllServiceRateMaster`(langid int)
BEGIN
select srmd.*
 
from serviceratemaster as sm 
inner join serviceratemasterdetails as srmd on sm.id=srmd.servicerateid and srmd.languageid=ifnull(langid,1)
where sm.isdelete<>1 and srmd.isdelete<>1 and 
sm.isactive<>0 and srmd.isactive<>0 order by srmd.ServiceRank;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `frontGetAllStatesticDataMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `frontGetAllStatesticDataMaster`(
	pLangId int,
	pDomainId int,
    pType text
)
begin
	SELECT CMSMD.*, NULL AS ImagePath
	FROM statesticdatamaster as CMSM 
	inner join statesticdatamasterdetails as CMSMD on CMSM.Id=CMSMD.StatesticDataId and CMSMD.LanguageId=IFNULL(pLangId,1) and DomainId=pDomainId
    inner join statesticdatamastertype as CMSMT on CMSMT.Id=CMSMD.StatesticTypeId and CMSMT.IsVisible=1
	where CMSM.IsDelete<>1 and CMSMD.IsDelete<>1 and CMSM.IsActive=1 and CMSMD.IsActive=1
    and (
		pType IS NULL 
        OR pType = '' 
        OR (pType = 'Education Corner' AND CMSMD.StatesticTypeId = 1)
        OR (pType = 'Online Service' AND CMSMD.StatesticTypeId = 2)
        OR (pType = 'Special Initiative' AND CMSMD.StatesticTypeId = 3)
        OR (pType = 'Achievement' AND CMSMD.StatesticTypeId = 4)
	)
	order by CMSMD.Id asc;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `frontGetAllStatisticMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `frontGetAllStatisticMaster`(
langid int
)
begin


SELECT CMSMD.* 
FROM statisticdatamaster as CMSM 
inner join statisticdatamasterdetails as CMSMD 
on CMSM.Id=CMSMD.StatisticDataId and CMSMD.LanguageId=IFNULL(langid,1)
where CMSM.IsDelete<>1 and CMSMD.IsDelete<>1 
and CMSM.IsActive=1 and CMSMD.IsActive=1
order by createddate desc;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `FrontGetAllVideoFirstData` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `FrontGetAllVideoFirstData`(
    planguageID int
)
BEGIN
	select vmd.VideoTitle,b.VideoName,b.ThumbImage,b.VideoUrl,b.islinkvideo, gm.*
	FROM  videomaster gm
	inner join videomasterdetails vmd on vmd.VideoId=gm.Id
	left join
	(
	   SELECT videomasterurls.VideoMasterId,videomasterurls.VideoName,videomasterurls.ThumbImage,videomasterurls.VideoUrl,videomasterurls.islinkvideo, 
	   ROW_NUMBER() OVER (PARTITION BY videomasterurls.VideoMasterId ORDER BY videomasterurls.Id) rn
	  FROM videomasterurls
	) b ON(gm.id = b.VideoMasterId AND b.rn = 1) where vmd.LanguageId=ifnull(planguageID,1) and gm.IsActive=1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `frontGetAllVideoMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `frontGetAllVideoMaster`(pLangId int)
BEGIN
	select * from videomaster where IsDelete=0 and isactive = 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `frontGetCmsPageBySlug` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `frontGetCmsPageBySlug`(
	pSlug text
)
BEGIN
	SELECT *
    FROM CmsPages
    WHERE Slug = pSlug
      AND IsActive = 1
    LIMIT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getallprojectmasterlanguageid` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `getallprojectmasterlanguageid`(
langid int
)
begin


select pmd.* from projectmaster as pm 

inner join projectmasterdetails as pmd 

on pm.id=pmd.projectmasterid and pmd.languageid= langid
where pm.isdelete<>1 and pmd.isdelete<>1;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetAllStateMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `GetAllStateMaster`()
BEGIN
SELECT SM.StateId,SM.StateName,SM.IsActive,SM.IsDelete 
    FROM statemaster AS SM    
    WHERE SM.IsDelete <> 1 order by statename;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetCouchDBSettings` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `GetCouchDBSettings`()
begin

select 
(select parametervalue from `configdetails` where parametername='couchdburl') as couchdburl
,(select parametervalue from `configdetails` where parametername='couchdbdbname') as couchdbdbname
,(select parametervalue from `configdetails` where parametername='couchdbuser') as couchdbuser
,(select parametervalue from `configdetails` where parametername='allowcouchdbstore') as allowcouchdbstore
;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getdashboardcount` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `getdashboardcount`(pUserId BIGINT)
BEGIN
     DECLARE new_event INT DEFAULT 0;
     DECLARE register_event INT DEFAULT 0;

    SELECT COUNT(*) INTO new_event
    FROM eventmasterdetails where isactive = true and isdelete = false and eventenddate >= NOW();

	SELECT COUNT(DISTINCT EventId) INTO register_event
    FROM eventapplications
    WHERE isapplied = TRUE and UserId =pUserId ;
    
    SELECT new_event AS NewEvents, register_event AS RegisterEvent;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetDistrictByStateId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `GetDistrictByStateId`(IN pStateId INT)
BEGIN
SELECT * FROM district
    WHERE StateId = pStateId and isactive=true and isdelete = false
    ORDER BY DistrictName ASC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetLayoutByPageType` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `GetLayoutByPageType`(IN inputPageType VARCHAR(255))
BEGIN
    SELECT 
        LayoutId, 
        LayoutName, 
        PageTitle, 
        MetaHtml, 
        HeaderHtml, 
        FooterHtml, 
        MainContentHtml, 
        Styles, 
        Scripts, 
        IsActive, 
        CreatedAt, 
        UpdatedAt
    FROM LayoutMaster
    WHERE LayoutName = inputPageType 
    AND IsActive = 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetProductDetails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `GetProductDetails`(
    IN pProductId BIGINT,
    IN pLanguageId BIGINT
)
BEGIN
    DECLARE ProdData TEXT;
    DECLARE distProdData TEXT;
    DECLARE prossProdData TEXT;
    DECLARE ProdFinalData TEXT;

    -- Select Product Data and output as JSON
    SELECT JSON_OBJECT(
        'ProductId', pd.Id,
        'ProductName', CASE WHEN pLanguageId = 1 THEN pd.ProductName ELSE pd.ProductNameGuj END,
        'ProductImage', pd.ImagePath
    ) INTO ProdData
    FROM productmaster AS pd
    WHERE pd.Id = pProductId;
    
    -- Aggregate Processed Product Data into a JSON array
    SELECT JSON_ARRAYAGG(
        JSON_OBJECT(
            'ProcessedProductId', ppd.Id,
            'ProcessedProductName', ppd.ProcessedProductName
        )
    ) INTO prossProdData
    FROM processedproduct AS ppd
    WHERE ppd.ProductId = pProductId
      AND ppd.LanguageId = pLanguageId
      AND ppd.IsActive = 1
      AND IFNULL(ppd.IsDelete, 0) = 0;
        
    -- Aggregate District Product Data into a JSON array
    SELECT JSON_ARRAYAGG(
        JSON_OBJECT(
            'DistrictProductId', dp.Id,
            'DistrictId', dp.DistrictId,
            'DistrictName', dm.DistrictName,
            'ProductionImage', dp.ImagePath,
            'ProductionFile', dp.FilePath,
            'Latitude', dm.Latitude,
            'Longitude', dm.Longitude,
            'ProductioninMT', dp.ProductioninMT
        )
    ) INTO distProdData
    FROM districtproduct AS dp
    INNER JOIN districtmaster AS dm ON dp.DistrictId = dm.Id
    WHERE dp.ProductId = pProductId
      AND dp.IsActive = 1
      AND IFNULL(dp.IsDelete, 0) = 0
      AND dm.IsActive = 1
      AND IFNULL(dm.IsDelete, 0) = 0;
    
    -- Combine all JSON data into a single JSON object
    SELECT JSON_OBJECT(
        'ProductData', JSON_OBJECT(
            'ProductId', JSON_EXTRACT(ProdData, '$.ProductId'),
            'ProductName', JSON_EXTRACT(ProdData, '$.ProductName'),
            'ProductImage', JSON_EXTRACT(ProdData, '$.ProductImage')
        ),
        'ProcessedProductData', IFNULL(prossProdData, JSON_ARRAY()),
        'DistrictProductData', IFNULL(distProdData, JSON_ARRAY())
    ) INTO ProdFinalData;
    
    SELECT ProdFinalData;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetProductDetails2` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `GetProductDetails2`(
    IN pProductId BIGINT,
    IN pLanguageId BIGINT
    )
BEGIN

select pd.Id as ProductId, 
case when (pLanguageId = 1) then pd.ProductName
else pd.ProductNameGuj 
end as ProductName,
pd.ImagePath as ProductImage from productmaster as pd where pd.Id = pProductId  And pd.IsActive = 1 and ifnull(pd.IsDelete,0) = 0;

select ppd.Id as ProcessedProductId, ppd.ProcessedProductName from processedproduct as ppd where ppd.ProductId = pProductId And ppd.LanguageId = pLanguageId AND ppd.IsActive = 1 and ifnull(ppd.IsDelete,0) = 0;

select dp.Id as DistrictProductId, dp.DistrictId as DistrictId, dm.DistrictName as DistrictName,
dp.ImagePath as ProductionImage, dp.FilePath as ProductionFile, dm.Latitude, dm.Longitude, dp.ProductioninMT as ProductioninMT 
from districtproduct as dp inner join districtmaster as dm on dp.DistrictId = dm.Id and dm.IsActive = 1 and ifnull(dm.IsDelete,0) = 0 
where dp.ProductId = pProductId and dp.LanguageId = pLanguageId and dp.IsActive = 1 and ifnull(dp.IsDelete,0) =0;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetSiteSettings` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `GetSiteSettings`()
begin

	select 
	(select parametervalue from `configdetails` where parametername='sitename') as sitename,
	(select parametervalue from `configdetails` where parametername='sitefaviconwhite') as sitefaviconwhite,
	(select parametervalue from `configdetails` where parametername='sitefavicondark') as sitefavicondark,
	(select parametervalue from `configdetails` where parametername='sitelogowhite') as sitelogowhite,
	(select parametervalue from `configdetails` where parametername='sitelogodark') as sitelogodark;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetSMTPSettings` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `GetSMTPSettings`()
begin

select 
(select parametervalue from `configdetails` where parametername='smtpserver') as smtpserver
,(select parametervalue from `configdetails` where parametername='smtpport') as smtpport
,(select parametervalue from `configdetails` where parametername='smtpaccount') as smtpaccount
,(select parametervalue from `configdetails` where parametername='smtppassword') as smtppassword
,(select parametervalue from `configdetails` where parametername='smtpfromemail') as smtpfromemail
,(select if(parametervalue='1', true,if(parametervalue='0', false,ifnull(parametervalue,null))) from`configdetails` where parametername='smtpissecure') as smtpissecure
,(select parametervalue from `configdetails` where parametername='testsmtpserver') as testsmtpserver
,(select parametervalue from `configdetails` where parametername='testsmtpport') as testsmtpport
,(select parametervalue from `configdetails` where parametername='testsmtpaccount') as testsmtpaccount
,(select parametervalue from `configdetails` where parametername='testsmtppassword') as testsmtppassword
,(select parametervalue from `configdetails` where parametername='testsmtpfromemail') as testsmtpfromemail
,(select if(parametervalue='1', true,if(parametervalue='0', false,ifnull(parametervalue,null))) from `configdetails` where parametername='testsmtpissecure') as testsmtpissecure
,(select if(parametervalue='1', true,false) from `configdetails` where parametername='smtpistest') as smtpistest

;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetUserIdByFrontUserName` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `GetUserIdByFrontUserName`(Puserusername text)
BEGIN
	select  `Id`
    FROM frontusermaster where `Email` = Puserusername AND IsDelete <>1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetUserIdByUserName` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `GetUserIdByUserName`(Puserusername text)
BEGIN
	select  `Id`
    FROM usersmaster where `Username` = Puserusername AND IsDelete <>1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertErrorMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `InsertErrorMaster`(
errordetails text,
controllername text,
actionname text,
dborwebsite text,
userdetails text
)
begin

insert into `errormaster`
(`errordetails`, `errordatetime`, `controllername`, `actionname`, `dborwebsite`, `userdetails`)
values
( errordetails, now(), controllername, actionname, dborwebsite, userdetails);

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertOrUpdateCouchDBSetting` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `InsertOrUpdateCouchDBSetting`(
couchdburl text,
couchdbdbname text,
couchdbuser text,
allowcouchdbstore text
)
begin


begin  /* couchdburl */
if((select count(1) from `configdetails` where parametername='couchdburl')>0) then
update `configdetails` set parametervalue=couchdburl where parametername='couchdburl';
else 
insert into `configdetails`
(`parametername`,`parametervalue`,`description`) value 
('couchdburl',couchdburl,'');
end if;
end;

begin  /* couchdbdbname */
if((select count(1) from `configdetails` where parametername='couchdbdbname')>0) then
update `configdetails` set parametervalue=couchdbdbname where parametername='couchdbdbname';
else 
insert into `configdetails`
(`parametername`,`parametervalue`,`description`) value 
('couchdbdbname',couchdbdbname,'');
end if;
end;

begin  /* couchdbuser */
if((select count(1) from `configdetails` where parametername='couchdbuser')>0) then
update `configdetails` set parametervalue=couchdbuser where parametername='couchdbuser';
else 
insert into `configdetails`
(`parametername`,`parametervalue`,`description`) value 
('couchdbuser',couchdbuser,'');
end if;
end;

begin  /* allowcouchdbstore */
if((select count(1) from `configdetails` where parametername='allowcouchdbstore')>0) then
update `configdetails` set parametervalue=allowcouchdbstore where parametername='allowcouchdbstore';
else 
insert into `configdetails`
(`parametername`,`parametervalue`,`description`) value 
('allowcouchdbstore',allowcouchdbstore,'');
end if;
end;


end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertOrUpdateFrontUserMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `InsertOrUpdateFrontUserMaster`(
pId int, 
pFirstName text, 
pMiddleName text,
pLastName text, 
pEmail text,
pPhoneNo text,
pUserPassword text,
pIsActive tinyint,
pCreateBy text,
pIsPasswordReset int, 
pIsChangeProfile int,
pApplicantPhoto text)
BEGIN
  IF (pId = 0) THEN
    INSERT INTO frontusermaster (
    FirstName,
    MiddleName,
    LastName,
    Email,
    PhoneNo,
    UserPassword,
    IsActive,
    CreateBy,
    CreateDate,
    IsPasswordReset,
    IsChangeProfile)
      VALUES (pFirstName, pMiddleName, pLastName,pEmail, pPhoneNo,pUserPassword, pIsActive, pCreateBy, NOW(),pIsPasswordReset, pIsChangeProfile);
    SET pId = LAST_INSERT_ID();

  
  ELSE
    UPDATE usersmaster
    SET 
        FirstName = pFirstName,
        MiddleName = pMiddleName,
        LastName = pLastName,
        Email = pEmail,
        PhoneNo = pPhoneNo,
        UserPassword = pUserPassword,
        IsActive = pIsActive,
        UpdateBy = pCreateBy,
        UpdateDate = NOW(),
        IsPasswordReset = pIsPasswordReset,
        IsChangeProfile = pIsChangeProfile,
        ApplicantPhoto= pApplicantPhoto
    WHERE Id = pId;
  
  END IF;
  SELECT
    pId AS id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertorupdateprojectmaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `insertorupdateprojectmaster`(
    IN pid BIGINT,
    IN planguageid INT,
    IN pprojectname VARCHAR(400),
    IN pdescription LONGTEXT,
    IN pprojectby VARCHAR(100),
    IN pprojectdate DATETIME,
    IN pisactive TINYINT,
    IN pcreatedby VARCHAR(100),
    IN pupdatedby VARCHAR(100),
    IN plocation TEXT,
    IN pmetatitle LONGTEXT,
    IN pmetadescription LONGTEXT,
    IN filename LONGTEXT,
    IN filepath TEXT
)
BEGIN
   
    SET pdescription = XSSPAyLoad(pdescription);

    IF pid = 0 THEN 
        -- Insert new project master
        INSERT INTO `projectmaster`(`isactive`, `isdelete`, `createdby`, `createddate`)
        VALUES (pisactive, 0, pcreatedby, NOW());

        SET pid = LAST_INSERT_ID();

        -- Insert new project details
        INSERT INTO `projectmasterdetails` (
            `projectmasterid`, `languageid`, `projectname`, `description`, `projectby`, `projectdate`, `fileupload`, `filepath`, `isactive`, `isdelete`, `createdby`, `createddate`, `location`, `metatitle`, `metadescription`
        )
        VALUES (
            pid, planguageid, pprojectname, pdescription, pprojectby, pprojectdate, filename, filepath, pisactive, 0, pcreatedby, NOW(), plocation, pmetatitle, pmetadescription
        );

    ELSE 
        
        -- Update existing project master
        UPDATE `projectmaster`
        SET 
            isactive = pisactive, 
            updatedby = pupdatedby,
            updateddate = NOW()
        WHERE id = pid;
        
    if((select count(1) from `projectmasterdetails` where projectmasterid=pid and LanguageId=planguageid )>0) then
            UPDATE `projectmasterdetails`
            SET 
                projectname = pprojectname,
                fileupload = (CASE WHEN IFNULL(filename, '') <> '' THEN filename ELSE fileupload END),
                filepath = (CASE WHEN IFNULL(filepath, '') <> '' THEN filepath ELSE filepath END),
                description = pdescription,
                -- projectby = pprojectby,
                projectdate = pprojectdate,
                location = plocation,
                isactive = pisactive, 
                updatedby = pupdatedby,
                updateddate = NOW(),
                metatitle = pmetatitle,
                metadescription = pmetadescription
            WHERE 
                projectmasterid = pid and languageid=languageid;
	else
	
	INSERT INTO `projectmasterdetails` (
            `projectmasterid`, `languageid`, `projectname`, `description`, `projectby`, `projectdate`, `fileupload`, `filepath`, `isactive`, `isdelete`, `createdby`, `createddate`, `location`, `metatitle`, `metadescription`
        )
        VALUES (
            pid, planguageid, pprojectname, pdescription, pprojectby, pprojectdate, filename, filepath, pisactive, 0, pcreatedby, NOW(), plocation, pmetatitle, pmetadescription
        );
            
           
        END IF;
		END IF;
   select pid as recid;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertOrUpdateSMTPSetting` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `InsertOrUpdateSMTPSetting`(
smtpserver text,
in smtpport text,
smtpaccount text,
smtppassword text,
smtpfromemail text,
in smtpissecure text,
testsmtpserver text,
in testsmtpport text,
testsmtpaccount text,
testsmtppassword text,
testsmtpfromemail text,
in testsmtpissecure text
)
begin

begin  /* smtp live */

begin  /* smtpserver */
if((select count(1) from `configdetails` where parametername='smtpserver')>0) then
update `configdetails` set parametervalue=smtpserver where parametername='smtpserver';
else 
insert into `configdetails`
(`parametername`,`parametervalue`,`description`) value 
('smtpserver',smtpserver,'');
end if;
end;

begin  /* smtpport */
if((select count(1) from `configdetails` where parametername='smtpport')>0) then
update `configdetails` set parametervalue=smtpport where parametername='smtpport';
else 
insert into `configdetails`
(`parametername`,`parametervalue`,`description`) value 
('smtpport',smtpport,'');
end if;
end;

begin  /* smtpaccount */
if((select count(1) from `configdetails` where parametername='smtpaccount')>0) then
update `configdetails` set parametervalue=smtpaccount where parametername='smtpaccount';
else 
insert into `configdetails`
(`parametername`,`parametervalue`,`description`) value 
('smtpaccount',smtpaccount,'');
end if;
end;

begin  /* smtppassword */
if((select count(1) from `configdetails` where parametername='smtppassword')>0) then
update `configdetails` set parametervalue=smtppassword where parametername='smtppassword';
else 
insert into `configdetails`
(`parametername`,`parametervalue`,`description`) value 
('smtppassword',smtppassword,'');
end if;
end;

begin  /* smtpfromemail */
if((select count(1) from `configdetails` where parametername='smtpfromemail')>0) then
update `configdetails` set parametervalue=smtpfromemail where parametername='smtpfromemail';
else 
insert into `configdetails`
(`parametername`,`parametervalue`,`description`) value 
('smtpfromemail',smtpfromemail,'');
end if;
end;

begin  /* smtpissecure */
if((select count(1) from `configdetails` where parametername='smtpissecure')>0) then
update `configdetails` set parametervalue=smtpissecure where parametername='smtpissecure';
else 
insert into `configdetails`
(`parametername`,`parametervalue`,`description`) value 
('smtpissecure',smtpissecure,'');
end if;
end;

end;


begin  /* testsmtp */

begin  /* testsmtpserver */
if((select count(1) from `configdetails` where parametername='testsmtpserver')>0) then
update `configdetails` set parametervalue=testsmtpserver where parametername='testsmtpserver';
else 
insert into `configdetails`
(`parametername`,`parametervalue`,`description`) value 
('testsmtpserver',testsmtpserver,'');
end if;
end;

begin  /* testsmtpport */
if((select count(1) from `configdetails` where parametername='testsmtpport')>0) then
update `configdetails` set parametervalue=testsmtpport where parametername='testsmtpport';
else 
insert into `configdetails`
(`parametername`,`parametervalue`,`description`) value 
('testsmtpport',testsmtpport,'');
end if;
end;

begin  /* testsmtpaccount */
if((select count(1) from `configdetails` where parametername='testsmtpaccount')>0) then
update `configdetails` set parametervalue=testsmtpaccount where parametername='testsmtpaccount';
else 
insert into `configdetails`
(`parametername`,`parametervalue`,`description`) value 
('testsmtpaccount',testsmtpaccount,'');
end if;
end;

begin  /* testsmtppassword */
if((select count(1) from `configdetails` where parametername='testsmtppassword')>0) then
update `configdetails` set parametervalue=testsmtppassword where parametername='testsmtppassword';
else 
insert into `configdetails`
(`parametername`,`parametervalue`,`description`) value 
('testsmtppassword',testsmtppassword,'');
end if;
end;

begin  /* testsmtpfromemail */
if((select count(1) from `configdetails` where parametername='testsmtpfromemail')>0) then
update `configdetails` set parametervalue=testsmtpfromemail where parametername='testsmtpfromemail';
else 
insert into `configdetails`
(`parametername`,`parametervalue`,`description`) value 
('testsmtpfromemail',testsmtpfromemail,'');
end if;
end;

begin  /* testsmtpissecure */
if((select count(1) from `configdetails` where parametername='testsmtpissecure')>0) then
update `configdetails` set parametervalue=testsmtpissecure where parametername='testsmtpissecure';
else 
insert into `configdetails`
(`parametername`,`parametervalue`,`description`) value 
('testsmtpissecure',testsmtpissecure,'');
end if;
end;

end;


end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_visitors_select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `proc_visitors_select`()
BEGIN
    SELECT MAX(updateddate) AS updateddate
    FROM (
        SELECT 
            CASE 
                WHEN COALESCE(CreatedDate, '0000-00-00') > COALESCE(updateddate, '0000-00-00') 
                THEN CreatedDate 
                ELSE updateddate 
            END AS updateddate
        FROM cmsmenuresourcemasterdetails
        UNION ALL
        SELECT 
            CASE 
                WHEN COALESCE(CreatedDate, '0000-00-00') > COALESCE(updateddate, '0000-00-00') 
                THEN CreatedDate 
                ELSE updateddate 
            END AS updateddate
        FROM cmstempltemasterdetails
        UNION ALL
        SELECT 
            CASE 
                WHEN COALESCE(CreatedDate, '0000-00-00') > COALESCE(updateddate, '0000-00-00') 
                THEN CreatedDate 
                ELSE updateddate 
            END AS updateddate
        FROM ministermasterdetails
        UNION ALL
        SELECT 
            CASE 
                WHEN COALESCE(CreatedDate, '0000-00-00') > COALESCE(updateddate, '0000-00-00') 
                THEN CreatedDate 
                ELSE updateddate 
            END AS updateddate
        FROM bannermasterdetails
        UNION ALL
        SELECT 
            CASE 
                WHEN COALESCE(CreatedDate, '0000-00-00') > COALESCE(updateddate, '0000-00-00') 
                THEN CreatedDate 
                ELSE updateddate 
            END AS updateddate
        FROM goilogomaster
        UNION ALL
        SELECT 
            CASE 
                WHEN COALESCE(CreatedDate, '0000-00-00') > COALESCE(updateddate, '0000-00-00') 
                THEN CreatedDate 
                ELSE updateddate 
            END AS updateddate
        FROM popupmasterdetails
        UNION ALL
        SELECT 
            CASE 
                WHEN COALESCE(CreatedDate, '0000-00-00') > COALESCE(updateddate, '0000-00-00') 
                THEN CreatedDate 
                ELSE updateddate 
            END AS updateddate
        FROM blogmasterdetails
		UNION ALL
        SELECT 
            CASE 
                WHEN COALESCE(CreatedDate, '0000-00-00') > COALESCE(updateddate, '0000-00-00') 
                THEN CreatedDate 
                ELSE updateddate 
            END AS updateddate
        FROM branchmasterdetails
        UNION ALL
        SELECT 
            CASE 
                WHEN COALESCE(CreatedDate, '0000-00-00') > COALESCE(updateddate, '0000-00-00') 
                THEN CreatedDate 
                ELSE updateddate 
            END AS updateddate
        FROM document_master
		UNION ALL
        SELECT 
            CASE 
                WHEN COALESCE(CreateDate, '0000-00-00') > COALESCE(updatedate, '0000-00-00') 
                THEN CreateDate 
                ELSE updatedate 
            END AS updateddate
        FROM gallerymasterdetails
        UNION ALL
        SELECT 
            CASE 
                WHEN COALESCE(CreatedDate, '0000-00-00') > COALESCE(updateddate, '0000-00-00') 
                THEN CreatedDate 
                ELSE updateddate 
            END AS updateddate
        FROM statisticdatamasterdetails
        UNION ALL
        SELECT 
            CASE 
                WHEN COALESCE(CreatedDate, '0000-00-00') > COALESCE(updateddate, '0000-00-00') 
                THEN CreatedDate 
                ELSE updateddate 
            END AS updateddate
        FROM ecitizenmasterdetails
        UNION ALL
        SELECT 
            CASE 
                WHEN COALESCE(CreatedDate, '0000-00-00') > COALESCE(updateddate, '0000-00-00') 
                THEN CreatedDate 
                ELSE updateddate 
            END AS updateddate
        FROM bannervideomaster
        UNION ALL
        SELECT 
            CASE 
                WHEN COALESCE(CreatedDate, '0000-00-00') > COALESCE(updateddate, '0000-00-00') 
                THEN CreatedDate 
                ELSE updateddate 
            END AS updateddate
        FROM quotesmasterdetails
        UNION ALL
        SELECT 
            CASE 
                WHEN COALESCE(CreatedDate, '0000-00-00') > COALESCE(updateddate, '0000-00-00') 
                THEN CreatedDate 
                ELSE updateddate 
            END AS updateddate
        FROM newsmasterdetails
        
    ) AS combined_updates;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `removeprojectmaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `removeprojectmaster`(
p_id int,username text )
begin

update projectmaster set isactive=0,isdelete=1 , deletedby=username,deleteddate=now() where id = p_id;

update projectmasterdetails set isactive=0,isdelete=1 , deletedby=username,deleteddate=now() where projectmasterid = p_id;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `test` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `test`()
BEGIN
	select * from districtmaster;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateSMTPEnvironment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `UpdateSMTPEnvironment`(
smtpistest text
)
begin

BEGIN  /* SMTPIsTest */
if((SELECT Count(1) FROM `configdetails` where ParameterName='SMTPIsTest')>0) then
UPDATE `configdetails` set ParameterValue=SMTPIsTest where ParameterName='SMTPIsTest';
else 
Insert into `configdetails`
(`ParameterName`,`ParameterValue`,`Description`) value 
('SMTPIsTest',SMTPIsTest,'');
end if;
END;


end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `WebSiteVisitorsCount` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`darpan`@`127.0.0.1` PROCEDURE `WebSiteVisitorsCount`(
	p_ipaddress varchar(50)
)
begin

    declare v_totalcount bigint; declare v_lastupdate nvarchar(20); 
    
	if not exists (select hitid from hitcounter where ipaddress = p_ipaddress and CreatedDate=now())
	then
		insert into hitcounter (`ipaddress`, `createddate`)
		values (p_ipaddress, now(3));
	end if;
     
	set v_totalcount = (select count(*) from hitcounter);  
	set v_lastupdate = (select  date_format (updateddate, '%d/%m/%y')  from cmsmenuresourcemasterdetails  order by updateddate desc
	limit 1);  
 -- sqlines license for evaluation use only
	select v_totalcount as  totalcount ,v_lastupdate as lastupdate;  
    
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-17 14:44:52
