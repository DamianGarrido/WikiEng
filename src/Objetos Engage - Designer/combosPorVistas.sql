-- AGREGAR UN REGISTRO A LA TABLA CAT_TYPE_EXT

EJEMPLOS:

-- COMBO SIMPLE
insert into CAT_TYPE_EXT (PKEY, PAR_KEY, CAT_TYPE_CODE, CAT_ORDER_BY, ORDER_TYPE, TS_BEGIN, TS_END, TS_CREATED_USER_ID, TS_USER_ID)
values ('VW_MOTIVOS_ATENCION', NULL, 'Motivos de Atención', 'CAT_DATA_DESC', 0, GETDATE(), GETDATE(), 'ADMINISTRADOR','ADMINISTRADOR')

VIEW [ENGAGE_COLUMBIA].[VW_MOTIVOS_ATENCION]
AS

SELECT 
	T1.ID_MOTIVO AS 'CAT_DATA_CODE'
	,T1.MOTIVO AS 'CAT_DATA_DESC'
	,'True' AS FLAG
FROM TUR_CAT_MOT_RECURSO T1


-- COMBO QUE DEPENDE DE OTRO COMBO (Se le agrega la PAR_KEY)
insert into CAT_TYPE_EXT (PKEY, PAR_KEY, CAT_TYPE_CODE, CAT_ORDER_BY, ORDER_TYPE, TS_BEGIN, TS_END, TS_CREATED_USER_ID, TS_USER_ID)
values ('VW_SUBMOTIVOS_ATENCION', 'VW_SEGMENTOS', 'Submotivos de Atención', 'CAT_DATA_DESC', 0, GETDATE(), GETDATE(), 'ADMINISTRADOR','ADMINISTRADOR')

VIEW [ENGAGE_COLUMBIA].[VW_SUBMOTIVOS_ATENCION]
AS
SELECT 
	 T1.ID_SUBMOT AS 'CAT_DATA_CODE'
	,T1.SUBMOTIVO AS 'CAT_DATA_DESC'
	,T2.ID_MOTIVO AS 'PARENT_CAT_DATA_CODE'
	,T2.ID_MOTIVO AS 'PARENT_CAT_DATA_PKEY'
	,'True' AS FLAG
FROM TUR_CAT_SUBMOT_RECURSO T1
INNER JOIN TUR_CAT_MOT_RECURSO T2 ON T2.ID_MOTIVO = T1.PAR_KEY