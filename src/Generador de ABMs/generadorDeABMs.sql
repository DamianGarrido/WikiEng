-- ==============================================================
-- PLANTILLA PARA LA GENERACION DE ABMS
-- VERSION 0 - NO TIENE FUNCIONALIDAD
-- ==============================================================

-- ==============================================================
-- SP DE ALTA
-- ==============================================================
ALTER PROCEDURE [SP_ADD_ELEMENT]
(
@P_PKEY_JOB VARCHAR(100),
@P_AGENTE   VARCHAR(30),
@P_OUT_CODE VARCHAR(30)	  OUTPUT,
@P_OUT_MSG	VARCHAR(2000) OUTPUT
) 

AS BEGIN

SET @P_OUT_CODE = '0'
SET @P_OUT_MSG = ''

--Declaración de Variables
DECLARE
@CAMPO_1	numeric(9,0),
@CAMPO_2	varchar(100)

--Tomo los datos de la tabla del trámite:
SELECT 
	@CAMPO_1 = CAMPO_1,
	@CAMPO_2 = CAMPO_2
FROM TMT_TG_03
WHERE PAR_KEY = @P_PKEY_JOB

--Validaciones:
IF @CAMPO_1 = 0 BEGIN
	SET @P_OUT_CODE = '1'
	SET @P_OUT_MSG = '<script> alert("Obligatorio.");</script>'
	RETURN;
END
IF EXISTS(SELECT 1 FROM TABLA_ABM WHERE CAMPO_1 = @CAMPO_1) BEGIN
	SET @P_OUT_CODE = '1'
	SET @P_OUT_MSG = '<script> alert("Ya existe.");</script>'
	RETURN;
END
IF @CAMPO_2 = '' BEGIN
	SET @P_OUT_CODE = '1'
	SET @P_OUT_MSG = '<script> alert("Obligatorio.");</script>'
	RETURN;
END
IF EXISTS(SELECT 1 FROM TABLA_ABM WHERE CAMPO_2 = @CAMPO_2) BEGIN
	SET @P_OUT_CODE = '1'
	SET @P_OUT_MSG = '<script> alert("Ya existe.");</script>'
	RETURN;
END

--Insert de datos
INSERT INTO [ENGAGESOL].TABLA_ABM
           (
			PKEY,
			CAMPO_1,
			CAMPO_2
			)
     VALUES
           (
		    NEWID(),
		    @CAMPO_1,
			@CAMPO_2
			)

END