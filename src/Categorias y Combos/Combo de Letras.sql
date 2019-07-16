INSERT INTO [ENGAGE_COLUMBIA].[CAT_DATA]
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
 SELECT NEWID(), '0000000039_98', T.CAT_DATA_CODE, T.CAT_DATA_DESC,'','','','','','','','','','', GETDATE(),GETDATE(),'LETRAS','ADMINISTRADOR','','0'
 FROM  (
		SELECT Char(number+65) AS 'CAT_DATA_CODE',Char(number+65)   AS 'CAT_DATA_DESC'
		  FROM master.dbo.spt_values
		 WHERE name IS NULL AND 
			   number < 26 )T

GO


