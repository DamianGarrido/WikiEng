-- ==============================================================
-- GRILLA CON ICONOS PARA CAMBIAR EL ORDEN DE LAS FILAS 
-- ==============================================================
CREATE PROCEDURE P_GRILLA
	@P_PKEY_JOB VARCHAR(100)
AS BEGIN

DECLARE  @ID_FILA AS NUMERIC

SELECT	
	 '<i onclick="almacenarSeleccion(''ID_FILA'',''' + CONVERT(VARCHAR,T.ID_FILA) + ''');almacenarSeleccion(''FLAG_ORDEN'',''UP'');SaltoaEstructura(''CAMBIAR_ORDEN'');" 
		class="fa fa-arrow-circle-up" title="Subir" style="cursor:pointer;color:dark-grey;font-size:18px"></i>'
	+
	'<i onclick="almacenarSeleccion(''ID_FILA'',''' + CONVERT(VARCHAR,T.ID_FILA) + ''');almacenarSeleccion(''FLAG_ORDEN'',''DOWN'');SaltoaEstructura(''CAMBIAR_ORDEN'');" 
		class="fa fa-arrow-circle-down" title="Bajar" style="cursor:pointer;color:dark-grey;font-size:18px"></i>'
	AS '<b><font color=#283484>Orden</font></b>',
	 T.CAMPO   AS '<b><font color=#283484>Campo</font></b>'
FROM TABLA T
ORDER BY T.ORDEN

-- ==============================================================
-- CAMBIA EL ORDEN DE LA FILA ELEGIDA y DE LA SIGUIENTE/ANTERIOR
-- ==============================================================

CREATE PROCEDURE P_CAMBIA_ORDEN
	@P_PKEY_JOB			VARCHAR(100)
AS BEGIN

DECLARE  @ID_FILA 	 AS NUMERIC
		,@ORDEN_FILA AS NUMERIC
		,@FLAG_ORDEN AS VARCHAR(20)

SELECT   @ID_FILA = ID_FILA 
		,@FLAG_ORDEN = FLAG_ORDEN
FROM TMT T
WHERE PAR_KEY = @P_PKEY_JOB

-- Obtengo orden de la fila seleccionada
SELECT @ORDEN_FILA = ORDEN_FILA FROM TABLA WHERE ID_FILA = @ID_FILA

-- Cambio los ordenes según corresponda
IF @FLAG_ORDEN = 'DOWN' AND EXISTS(SELECT 1 FROM TABLA T WHERE T.ORDEN_FILA = @ORDEN_FILA - 1)
	BEGIN
		UPDATE TABLA	SET ORDEN_FILA = ORDEN_FILA + 1 WHERE ORDEN_FILA = @ORDEN_FILA - 1
		UPDATE TABLA	SET ORDEN_FILA = ORDEN_FILA - 1 WHERE ID_FILA = @ID_FILA
	END
ELSE IF @FLAG_ORDEN = 'DOWN' AND EXISTS(SELECT 1 FROM TABLA T WHERE T.ORDEN_FILA = @ORDEN_FILA + 1)
	BEGIN
		UPDATE TABLA	SET ORDEN_FILA = ORDEN_FILA - 1 WHERE ORDEN_FILA = @ORDEN_FILA + 1 
		UPDATE TABLA	SET ORDEN_FILA = ORDEN_FILA + 1 WHERE ID_FILA = @ID_FILA
	END
END

-- ==============================================================
-- BAJA EL ORDEN DE LA FILA ELEGIDA
-- ==============================================================

CREATE PROCEDURE P_DOWN
	@P_PKEY_JOB			VARCHAR(100)
AS BEGIN

DECLARE  @ID_FILA 	 AS NUMERIC
		,@ORDEN_FILA AS NUMERIC

SELECT   @ID_FILA = ID_FILA 
		,@ORDEN_FILA = ORDEN_FILA
FROM TMT T
WHERE PAR_KEY = @P_PKEY_JOB

IF EXISTS(SELECT 1 FROM TABLA T WHERE T.ORDEN_FILA = @ORDEN_FILA - 1)
	BEGIN
		UPDATE TABLA	SET ORDEN_FILA = ORDEN_FILA + 1 WHERE ORDEN_FILA = @ORDEN_FILA - 1
		UPDATE TABLA	SET ORDEN_FILA = ORDEN_FILA - 1 WHERE ID_FILA = @ID_FILA
	END
END

-- ==============================================================
-- SUBE EL ORDEN DE LA FILA ELEGIDA
-- ==============================================================
CREATE PROCEDURE  P_UP
	@P_PKEY_JOB			VARCHAR(100)
AS BEGIN

DECLARE  @ID_FILA 	 AS NUMERIC
		,@ORDEN_FILA AS NUMERIC

SELECT   @ID_FILA	 = ID_FILA 
		,@ORDEN_FILA = ORDEN_FILA
FROM TMT T
WHERE PAR_KEY = @P_PKEY_JOB

IF EXISTS(SELECT 1 FROM TABLA T WHERE T.ORDEN_FILA = @ORDEN_FILA + 1)
	BEGIN
		UPDATE TABLA	SET ORDEN_FILA = ORDEN_FILA - 1 WHERE ORDEN_FILA = @ORDEN_FILA + 1 
		UPDATE TABLA	SET ORDEN_FILA = ORDEN_FILA + 1 WHERE ID_FILA = @ID_FILA
	END
END

-- ==============================================================
-- ACTUALIZA LOS ORDENES EN CASO DE BAJA A UNA DE LAS FILAS
-- ==============================================================
UPDATE TABLA
SET ORDEN_FILA = ORDEN_FILA -1 
WHERE ORDEN_FILA > (SELECT ORDEN_FILA FROM TABLA WHERE ID_FILA = @ID_FILA_A_BORRAR)