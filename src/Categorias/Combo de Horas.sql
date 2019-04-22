INSERT INTO [ENGAGE_COLUMBIA].[ENGAGE_COLUMBIA].[CAT_DATA]
           ([PKEY]
           ,[PAR_KEY]
           ,[CAT_DATA_CODE]
           ,[CAT_DATA_DESC]
           ,[ATTR1]
           ,[ATTR2]
           ,[ATTR3]
           ,[ATTR4]
           ,[ATTR5]
           ,[ATTR6]
           ,[ATTR7]
           ,[ATTR8]
           ,[ATTR9]
           ,[ATTR10]
           ,[TS_BEGIN]
           ,[TS_END]
           ,[PARENT_CAT_DATA_CODE]
           ,[TS_USER_ID]
           ,[PARENT_CAT_DATA_PKEY]
           ,[CAT_INACTIVE])
 SELECT NEWID(), '0000000022_98', T.CAT_DATA_CODE, T.CAT_DATA_DESC,'','','','','','','','','','', GETDATE(),GETDATE(),'HORA','ADMINISTRADOR','','0'
 FROM  (
 SELECT '0001' AS 'CAT_DATA_CODE','00:00' AS 'CAT_DATA_DESC'
UNION SELECT '0030' AS 'CAT_DATA_CODE','00:30' AS 'CAT_DATA_DESC'
UNION SELECT '0100' AS 'CAT_DATA_CODE','01:00' AS 'CAT_DATA_DESC'
UNION SELECT '0130' AS 'CAT_DATA_CODE','01:30' AS 'CAT_DATA_DESC'
UNION SELECT '0200' AS 'CAT_DATA_CODE','02:00' AS 'CAT_DATA_DESC'
UNION SELECT '0230' AS 'CAT_DATA_CODE','02:30' AS 'CAT_DATA_DESC'
UNION SELECT '0300' AS 'CAT_DATA_CODE','03:00' AS 'CAT_DATA_DESC'
UNION SELECT '0330' AS 'CAT_DATA_CODE','03:30' AS 'CAT_DATA_DESC' 
UNION SELECT '0400' AS 'CAT_DATA_CODE','04:00' AS 'CAT_DATA_DESC' 
UNION SELECT '0430' AS 'CAT_DATA_CODE','04:30' AS 'CAT_DATA_DESC' 
UNION SELECT '0500' AS 'CAT_DATA_CODE','05:00' AS 'CAT_DATA_DESC' 
UNION SELECT '0530' AS 'CAT_DATA_CODE','05:30' AS 'CAT_DATA_DESC' 
UNION SELECT '0600' AS 'CAT_DATA_CODE','06:00' AS 'CAT_DATA_DESC' 
UNION SELECT '0630' AS 'CAT_DATA_CODE','06:30' AS 'CAT_DATA_DESC' 
UNION SELECT '0700' AS 'CAT_DATA_CODE','07:00' AS 'CAT_DATA_DESC' 
UNION SELECT '0730' AS 'CAT_DATA_CODE','07:30' AS 'CAT_DATA_DESC' 
UNION SELECT '0800' AS 'CAT_DATA_CODE','08:00' AS 'CAT_DATA_DESC' 
UNION SELECT '0830' AS 'CAT_DATA_CODE','08:30' AS 'CAT_DATA_DESC' 
UNION SELECT '0900' AS 'CAT_DATA_CODE','09:00' AS 'CAT_DATA_DESC' 
UNION SELECT '0930' AS 'CAT_DATA_CODE','09:30' AS 'CAT_DATA_DESC' 
UNION SELECT '1000' AS 'CAT_DATA_CODE','10:00' AS 'CAT_DATA_DESC' 
UNION SELECT '1030' AS 'CAT_DATA_CODE','10:30' AS 'CAT_DATA_DESC' 
UNION SELECT '1100' AS 'CAT_DATA_CODE','11:00' AS 'CAT_DATA_DESC' 
UNION SELECT '1130' AS 'CAT_DATA_CODE','11:30' AS 'CAT_DATA_DESC' 
UNION SELECT '1200' AS 'CAT_DATA_CODE','12:00' AS 'CAT_DATA_DESC' 
UNION SELECT '1230' AS 'CAT_DATA_CODE','12:30' AS 'CAT_DATA_DESC' 
UNION SELECT '1300' AS 'CAT_DATA_CODE','13:00' AS 'CAT_DATA_DESC' 
UNION SELECT '1330' AS 'CAT_DATA_CODE','13:30' AS 'CAT_DATA_DESC' 
UNION SELECT '1400' AS 'CAT_DATA_CODE','14:00' AS 'CAT_DATA_DESC' 
UNION SELECT '1430' AS 'CAT_DATA_CODE','14:30' AS 'CAT_DATA_DESC' 
UNION SELECT '1500' AS 'CAT_DATA_CODE','15:00' AS 'CAT_DATA_DESC' 
UNION SELECT '1530' AS 'CAT_DATA_CODE','15:30' AS 'CAT_DATA_DESC' 
UNION SELECT '1600' AS 'CAT_DATA_CODE','16:00' AS 'CAT_DATA_DESC' 
UNION SELECT '1630' AS 'CAT_DATA_CODE','16:30' AS 'CAT_DATA_DESC' 
UNION SELECT '1700' AS 'CAT_DATA_CODE','17:00' AS 'CAT_DATA_DESC' 
UNION SELECT '1730' AS 'CAT_DATA_CODE','17:30' AS 'CAT_DATA_DESC' 
UNION SELECT '1800' AS 'CAT_DATA_CODE','18:00' AS 'CAT_DATA_DESC' 
UNION SELECT '1830' AS 'CAT_DATA_CODE','18:30' AS 'CAT_DATA_DESC' 
UNION SELECT '1900' AS 'CAT_DATA_CODE','19:00' AS 'CAT_DATA_DESC' 
UNION SELECT '1930' AS 'CAT_DATA_CODE','19:30' AS 'CAT_DATA_DESC' 
UNION SELECT '2000' AS 'CAT_DATA_CODE','20:00' AS 'CAT_DATA_DESC' 
UNION SELECT '2030' AS 'CAT_DATA_CODE','20:30' AS 'CAT_DATA_DESC' 
UNION SELECT '2100' AS 'CAT_DATA_CODE','21:00' AS 'CAT_DATA_DESC' 
UNION SELECT '2130' AS 'CAT_DATA_CODE','21:30' AS 'CAT_DATA_DESC' 
UNION SELECT '2200' AS 'CAT_DATA_CODE','22:00' AS 'CAT_DATA_DESC' 
UNION SELECT '2230' AS 'CAT_DATA_CODE','22:30' AS 'CAT_DATA_DESC' 
UNION SELECT '2300' AS 'CAT_DATA_CODE','23:00' AS 'CAT_DATA_DESC' 
UNION SELECT '2330' AS 'CAT_DATA_CODE','23:30' AS 'CAT_DATA_DESC' )T

GO


