﻿-- ==============================================================
-- PLANTILLA DE SPs PARA LA GENERACION DE ABMS
-- ==============================================================

-- ==============================================================
-- SP DE ALTA
-- ==============================================================
CREATE PROCEDURE [SP_ADD_ELEMENT]
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
FROM TMT
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


-- ==============================================================
-- SP DE MODIFICACION
-- ==============================================================
CREATE PROCEDURE [SP_MOD_ELEMENT]
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
@ID			numeric(9,0),
@CAMPO_1	numeric(9,0),
@CAMPO_2	varchar(100)

--Tomo los datos de la tabla del trámite:
SELECT 
	@CAMPO_1 = CAMPO_1,
	@CAMPO_2 = CAMPO_2
FROM TMT
WHERE PAR_KEY = @P_PKEY_JOB

--Validaciones:
IF @CAMPO_1 = 0 BEGIN
	SET @P_OUT_CODE = '1'
	SET @P_OUT_MSG = '<script> alert("Obligatorio.");</script>'
	RETURN;
END
IF EXISTS(SELECT 1 FROM TABLA_ABM WHERE CAMPO_1 = @CAMPO_1 AND ID != @ID) BEGIN
	SET @P_OUT_CODE = '1'
	SET @P_OUT_MSG = '<script> alert("Ya existe.");</script>'
	RETURN;
END
IF @CAMPO_2 = '' BEGIN
	SET @P_OUT_CODE = '1'
	SET @P_OUT_MSG = '<script> alert("Obligatorio.");</script>'
	RETURN;
END
IF EXISTS(SELECT 1 FROM TABLA_ABM WHERE CAMPO_2 = @CAMPO_2 AND ID != @ID) BEGIN
	SET @P_OUT_CODE = '1'
	SET @P_OUT_MSG = '<script> alert("Ya existe.");</script>'
	RETURN;
END

-- Update de datos
UPDATE TABLA_ABM
SET 
	CAMPO_1 = @CAMPO_1,
	CAMPO_2 = @CAMPO_2 
WHERE ID = @ID

END

-- ==============================================================
-- SP DE BAJA
-- ==============================================================
CREATE PROCEDURE [SP_DEL_ELEMENT]
(
@P_PKEY_JOB VARCHAR(100)
) 

AS BEGIN

DECLARE @ID		NUMERIC(9,0)

--Tomo los datos de la tabla del trámite:
SELECT @ID  = ID
FROM TMT
WHERE PAR_KEY = @P_PKEY_JOB

DELETE FROM TABLA_ABM 
WHERE ID = @ID

END

-- ==============================================================
-- SP QUE LIMPIA CAMPOS DEL ABM
-- ==============================================================
CREATE PROCEDURE [SP_CLR_ABM]
(
@P_PKEY_JOB VARCHAR(100)
) 

AS BEGIN

UPDATE TMT_TG_03
SET ID = 0,
	CAMPO_1 = 0,
	CAMPO_2 = ''
WHERE PAR_KEY = @P_PKEY_JOB

END