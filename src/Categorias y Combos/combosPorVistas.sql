-- ==============================================================
-- COMBO SIMPLE
-- ==============================================================

-- Se agrega un registro en la tabla CAT_TYPE_EXT
INSERT INTO CAT_TYPE_EXT (PKEY, PAR_KEY, CAT_TYPE_CODE, CAT_ORDER_BY, ORDER_TYPE, TS_BEGIN, TS_END, TS_CREATED_USER_ID, TS_USER_ID)
VALUES ('VW_COMBO_SIMPLE', NULL, 'Desc Combo Simple', 'CAT_DATA_DESC', 0, GETDATE(), GETDATE(), 'ADMINISTRADOR','ADMINISTRADOR')

VIEW [VW_COMBO_SIMPLE]
AS

SELECT 
	T.PKEY AS 'CAT_DATA_CODE'
	,T.DESC AS 'CAT_DATA_DESC'
	,'True' AS FLAG
FROM TABLA T

-- ==============================================================
-- COMBO QUE DEPENDE DE OTRO COMBO (Se le agrega la PAR_KEY)
-- ==============================================================

-- Se agrega un registro en la tabla CAT_TYPE_EXT
INSERT INTO CAT_TYPE_EXT (PKEY, PAR_KEY, CAT_TYPE_CODE, CAT_ORDER_BY, ORDER_TYPE, TS_BEGIN, TS_END, TS_CREATED_USER_ID, TS_USER_ID)
VALUES ('VW_COMBO_DEPENDIENTE', 'VW_SEGMENTOS', 'Desc Combo Dependiente', 'CAT_DATA_DESC', 0, GETDATE(), GETDATE(), 'ADMINISTRADOR','ADMINISTRADOR')

VIEW [VW_COMBO_DEPENDIENTE]
AS
SELECT 
	 T1.PKEY AS 'CAT_DATA_CODE'
	,T1.DESC AS 'CAT_DATA_DESC'
	,T2.PKEY AS 'PARENT_CAT_DATA_CODE'
	,T2.PKEY AS 'PARENT_CAT_DATA_PKEY'
	,'True' AS FLAG
FROM TABLA1 T1
INNER JOIN TABLA2 T2 ON T2.PKEY = T1.PAR_KEY