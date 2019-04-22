CREATE FUNCTION [ENGAGE_ASOCIART].[Valida_Email]  (@s varchar(100))
RETURNS VARCHAR(100)
AS
BEGIN
--ELIMINAMOS ESPACIOS IDENTIFICABLES COMO ERROR DE TIPEO Y REEMPLAZAMOS EÑES POR ENES
   SELECT @s=LTRIM(RTRIM(@s))
   SELECT @s=REPLACE(@s,',', '.')
   SELECT @s=REPLACE(@s,'@ ', '@')
   SELECT @s=REPLACE(@s,' @',  '@')
   SELECT @s=REPLACE(@s,'. ', '.')
   SELECT @s=REPLACE(@s,' .', '.')
   SELECT @s=REPLACE(@s,'ñ', 'n')
  
--VALIDA ACENTOS, SI ENCUENTRA ACENTO INVALIDA EL EMAIL
   IF CHARINDEX('á',@s,1)>0 or CHARINDEX('é',@s,1)>0 or CHARINDEX('í',@s,1)>0 or CHARINDEX('ó',@s,1)>0 or CHARINDEX('ú',@s,1)>0
		RETURN null
   IF CHARINDEX('à',@s,1)>0 or CHARINDEX('è',@s,1)>0 or CHARINDEX('ì',@s,1)>0 or CHARINDEX('ò',@s,1)>0 or CHARINDEX('ù',@s,1)>0
		RETURN null
  
   IF CHARINDEX('@',@s,1)>0 AND CHARINDEX('.', @s, CHARINDEX( '@', @s))>0 --VALIDA QUE EXISTA ARROBA Y PUNTO DESPUES DEL ARROBA
   BEGIN
      IF charindex('@' , @s, CHARINDEX('@',@s,1)+1)>0
         RETURN NULL --ENCUENTRA 2 ARROBAS Y RETORNA NULO   
      DECLARE @USER AS VARCHAR(60)
      DECLARE @DOM AS VARCHAR(100), @DOM1 AS VARCHAR(100);
      SET @USER=SUBSTRING(@s,1,CHARINDEX( '@',@s)-1)
      SET @DOM=SUBSTRING(@s,CHARINDEX( '@',@s)+1, 100)
      SET @USER=LTRIM(RTRIM(@USER))
      SET @DOM=LTRIM(RTRIM(@DOM))
      
      --VALIDA QUE USER TENGA AL MENOS 4 LETRAS
      IF(LEN(@USER) < 2)
		RETURN NULL;
     
      --VALIDA QUE EL DOMINIO TENGA 2 O TRES CARACTERES
      --IF LEFT(RIGHT(@DOM, 3), 1)='.' OR LEFT(RIGHT(@DOM, 4), 1)='.'
      --VALIDA QUE EL DOMINIO TENGA 3 CARACTERES
      
		 select @DOM1=(select  top 1 * from SPLIT(substring(@DOM,len((select top 1 * from SPLIT(@DOM,'.')))+2,100),'.'))
		 
		 IF(SUBSTRING(@DOM,LEN(@DOM),1)='.')
			RETURN NULL;
		 		 
		 IF(@DOM1<>'com' AND @DOM1<>'net' and LEN(@DOM1)<2)
			RETURN NULL;
         --REEMPLAZA ESPACIOS POR "_" SOLO EN USUARIO, NO EN DOMINIO
         IF CHARINDEX(' ', @USER)>0
         BEGIN
            SET @USER=REPLACE(@USER, ' ', '_')
            RETURN LOWER(@USER +  '@' + @DOM) --RETORNA EMAIL CON ESPACIOS CONVERTIDOS
         END
		 ELSE
            RETURN LOWER(@USER + '@'  + @DOM) --RETORNA EMAIL
      END
/*
RESUMEN VALIDACIONES:
VALIDAR ARROBA
VALIDAR PUNTO DESPUES DEL ARROBA 
VALIDAR EMAILS CON ACENTOS 
VALIDAR EMAILS CON MENOS DE 2 CARACTERES DESPUES DEL PUNTO (DOMINIOS .C)
VALIDAR EMAILS CON MAS DE 3 CARACTERES DESPUES DEL PUNTO (DOMINIOS .COMU)
REEMPLAZAR ESPACIOS POR "_" SOLO EN LO QUE ESTA ANTES DEL ARROBA 
VALIDAR QUE NO EXISTAN DOS ARROBAS
VALIDAR QUE EL @USER TENGA AL MENOS 4 LETRAS
VALIDA QUE EL DOMINIO SEA SOLO .COM O .NET
*/
   RETURN NULL
END