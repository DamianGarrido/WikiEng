USE [ENGAGENBSF]
GO
/****** Object:  StoredProcedure [ENGAGENBSF].[PA_TR4_REC_CREDITICIA]    Script Date: 01/24/2019 12:12:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [ENGAGENBSF].[PA_TR4_REC_CREDITICIA]
(@P_PKEY_JOB AS VARCHAR(100),
@P_AGENTE AS VARCHAR(30),
@P_OUT_FLUJO AS VARCHAR(50) OUTPUT,
@P_OUT_MSG AS VARCHAR(300) OUTPUT)
AS
BEGIN
	
	DECLARE	@V_CARTERA		VARCHAR(50)
	DECLARE	@V_DISCADOR		VARCHAR(50)
	DECLARE	@V_CONSOLIDADO	VARCHAR(50)
	DECLARE	@V_VENCIDA		VARCHAR(50)
	DECLARE	@V_MORA			VARCHAR(9)
	DECLARE @V_QUERY		VARCHAR(8000)
	DECLARE	@HEADER			VARCHAR(1000)
	DECLARE	@lsTitulo		VARCHAR(300)
	DECLARE	@NOMBRE_ARCHIVO	VARCHAR(50)
	
	SET	@P_OUT_FLUJO	= 'OK'
	SET	@P_OUT_MSG		= ''
	
	SELECT	@V_CARTERA		= ISNULL(NULLIF(CARTERA,''),''),
			@V_CONSOLIDADO	= ISNULL(NULLIF(CAMPO_LIBRE1,''),''),
			@V_VENCIDA		= ISNULL(NULLIF(CAMPO_LIBRE2,''),''),
			@V_MORA			= ISNULL(NULLIF(CONVERT(VARCHAR(9),DIAS),''),''),
			@V_DISCADOR		= ISNULL(NULLIF(FLTR_DISCADOR,''),'NO')
	FROM	TMT_TR4
	WHERE	PAR_KEY = @P_PKEY_JOB	
	
	SET @lsTitulo		= 'Reporte Integrador Recuperación Crediticia (BSC)'
	SET @NOMBRE_ARCHIVO = 'RPT_RECUP_CREDITICIA'+'-'+ CONVERT(VARCHAR,GETDATE(),103)
	
	IF(@V_CARTERA = '' OR @V_CONSOLIDADO = '' OR @V_VENCIDA = '' OR @V_MORA = '') 
	BEGIN
		SET @P_OUT_FLUJO = 'ERROR'
		SET @P_OUT_MSG	 = '<script>alert("Debe completar todos los filtros")</script>'
		RETURN
	END

	IF EXISTS (SELECT 1 FROM PHYSICAL_CALL_TRANSACTIONS WHERE TRANS_CODE = 'PA_TR11_RPT_EXP_ADJ' AND TS_USER_ID = @P_AGENTE AND TS_BEGIN > GETDATE()-1 AND LAST_ACCION = 'EXECUTE')
	BEGIN
		SET @P_OUT_FLUJO = 'ERROR'
		SET @P_OUT_MSG	 = '<script>alert("Ya hay un reporte generándose. Debe esperar a que finalice para generar uno nuevo.")</script>'
		RETURN
	END
	
	SET @V_QUERY =
' C.CUIT_CUIL,
C.NROCLI,
C.NOMBRE1,
C.CARTERA,
C.SUCURSAL,
C.DIAS_ATRASO,
(REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR(35), CONVERT(MONEY, C.MONTO_TOTAL), 1), '','', ''%''), ''.'', '',''), ''%'', ''.'')),
(REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR(35), CONVERT(MONEY, C.MONTO_EXIGIBLE), 1), '','', ''%''), ''.'', '',''), ''%'', ''.'')),
(REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR(35), CONVERT(MONEY, C.MME), 1), '','', ''%''), ''.'', '',''), ''%'', ''.'')),
ISNULL(NULLIF(E.CAT_DATA_DESC,''''),''''),
PREST.DIAATR,
(REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR(35), CONVERT(MONEY, PREST.SDOTOTPEN), 1), '','', ''%''), ''.'', '',''), ''%'', ''.'')),
(REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR(35), CONVERT(MONEY, PREST.MTOTOTMOR), 1), '','', ''%''), ''.'', '',''), ''%'', ''.'')),
(REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR(35), CONVERT(MONEY, PREST.MME), 1), '','', ''%''), ''.'', '',''), ''%'', ''.'')),
TC.DIAATR,
(REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR(35), CONVERT(MONEY, TC.SDOTOTPEN), 1), '','', ''%''), ''.'', '',''), ''%'', ''.'')),
(REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR(35), CONVERT(MONEY, TC.MTOTOTMOR), 1), '','', ''%''), ''.'', '',''), ''%'', ''.'')),
(REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR(35), CONVERT(MONEY, TC.MME), 1), '','', ''%''), ''.'', '',''), ''%'', ''.'')),
GYM.DIAATR,
(REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR(35), CONVERT(MONEY, GYM.SDOTOTPEN), 1), '','', ''%''), ''.'', '',''), ''%'', ''.'')),
(REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR(35), CONVERT(MONEY, GYM.MTOTOTMOR), 1), '','', ''%''), ''.'', '',''), ''%'', ''.'')),
(REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR(35), CONVERT(MONEY, GYM.MME), 1), '','', ''%''), ''.'', '',''), ''%'', ''.'')),
(REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR(35), CONVERT(MONEY, GYM.SDOCAP), 1), '','', ''%''), ''.'', '',''), ''%'', ''.'')),
(REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR(35), CONVERT(MONEY, GYM.SDOCONT), 1), '','', ''%''), ''.'', '',''), ''%'', ''.'')),
CC.DIAATR,
(REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR(35), CONVERT(MONEY, CC.SDOTOTPEN), 1), '','', ''%''), ''.'', '',''), ''%'', ''.'')),
(REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR(35), CONVERT(MONEY, CC.MTOTOTMOR), 1), '','', ''%''), ''.'', '',''), ''%'', ''.'')),
(REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR(35), CONVERT(MONEY, CC.MME), 1), '','', ''%''), ''.'', '',''), ''%'', ''.'')),
CS.DIAATR,
(REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR(35), CONVERT(MONEY, CS.SDOTOTPEN), 1), '','', ''%''), ''.'', '',''), ''%'', ''.'')),
(REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR(35), CONVERT(MONEY, CS.MTOTOTMOR), 1), '','', ''%''), ''.'', '',''), ''%'', ''.'')),
(REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR(35), CONVERT(MONEY, CS.MME), 1), '','', ''%''), ''.'', '',''), ''%'', ''.'')),
C.FALLECIDO,
CASE WHEN C.TIPGESTION = ''LEGALES'' THEN ''SI'' ELSE ''NO'' END,
C.QUIEBRA_CONCU,
ISNULL(AGE.CODIGO,C.AGENCIA),
CD1.CAT_DATA_DESC,
C.COMPORTAMIENTO,
C.ICP,
C.SIT_BCRA,
'' '' + CONVERT(VARCHAR, ISNULL(C.SIT_CAL,1)) + '' - '' + CONVERT(VARCHAR,ISNULL(PROY.SIT_BCRA,1)),
C.EFECTO_ULT,
C.NOMEMP
FROM	CUSTOMER_NBSF C
LEFT JOIN CUSTOMER_PROYECTADO PROY ON (C.PAR_KEY = PROY.PAR_KEY)
LEFT JOIN (SELECT	P2.PAR_KEY, SUM(P2.MME) AS MME, MAX(P2.DIAATR) AS DIAATR, SUM(P2.MTOTOTMOR) AS MTOTOTMOR, SUM(P2.SDOTOTPEN) AS SDOTOTPEN
FROM	CUSTOMER_PRODUCTOS P2
WHERE	P2.TIPPROD = ''4''
AND P2.VIGENTE = ''SI''
AND ISNULL(NULLIF(P2.SEGMENTO_PREST,''''),'''') NOT IN (''18'',''24'')
GROUP	BY P2.PAR_KEY) PREST ON (PREST.PAR_KEY = C.PAR_KEY)
LEFT JOIN (SELECT	P3.PAR_KEY, SUM(P3.MME) AS MME, MAX(P3.DIAATR) AS DIAATR, SUM(P3.MTOTOTMOR) AS MTOTOTMOR, SUM(P3.SDOTOTPEN) AS SDOTOTPEN,
SUM(P3.SDOCAP) AS SDOCAP, SUM(GYM3.SDOCONT) AS SDOCONT
FROM	CUSTOMER_PRODUCTOS P3
INNER JOIN CUSTOMER_GESTIONYMORA GYM3 ON (P3.PKEY = GYM3.PKEY_ACCOUNT)
WHERE	P3.TIPPROD = ''45''
AND P3.VIGENTE = ''SI''
AND ISNULL(NULLIF(P3.SEGMENTO_PREST,''''),'''') NOT IN (''18'',''24'')
GROUP	BY P3.PAR_KEY) GYM ON (GYM.PAR_KEY = C.PAR_KEY)
LEFT JOIN (SELECT	P4.PAR_KEY, SUM(P4.MME) AS MME, MAX(P4.DIAATR) AS DIAATR, SUM(P4.MTOTOTMOR) AS MTOTOTMOR, SUM(P4.SDOTOTPEN) AS SDOTOTPEN
FROM	CUSTOMER_PRODUCTOS P4
WHERE	P4.TIPPROD = ''27''
AND P4.VIGENTE = ''SI''
AND ISNULL(NULLIF(P4.SEGMENTO_PREST,''''),'''') NOT IN (''18'',''24'')
GROUP	BY P4.PAR_KEY) TC ON (TC.PAR_KEY = C.PAR_KEY)
LEFT JOIN (SELECT	P5.PAR_KEY, SUM(P5.MME) AS MME, MAX(P5.DIAATR) AS DIAATR, SUM(P5.MTOTOTMOR) AS MTOTOTMOR, SUM(P5.SDOTOTPEN) AS SDOTOTPEN
FROM	CUSTOMER_PRODUCTOS P5
WHERE	P5.TIPPROD = ''1''
AND P5.VIGENTE = ''SI''
AND ISNULL(NULLIF(P5.SEGMENTO_PREST,''''),'''') NOT IN (''18'',''24'')
GROUP	BY P5.PAR_KEY) CC ON (CC.PAR_KEY = C.PAR_KEY)
LEFT JOIN (SELECT	P6.PAR_KEY, SUM(P6.MME) AS MME, MAX(P6.DIAATR) AS DIAATR, SUM(P6.MTOTOTMOR) AS MTOTOTMOR, SUM(P6.SDOTOTPEN) AS SDOTOTPEN
FROM	CUSTOMER_PRODUCTOS P6
WHERE	P6.TIPPROD = ''55''
AND P6.VIGENTE = ''SI''
AND ISNULL(NULLIF(P6.SEGMENTO_PREST,''''),'''') NOT IN (''18'',''24'')
GROUP	BY P6.PAR_KEY) CS ON (CS.PAR_KEY = C.PAR_KEY)
LEFT JOIN VW_ESTRATEGIAS E ON (C.ESTRATEGIA_CODE = E.CAT_DATA_CODE)
LEFT JOIN CAT_DATA CD1 ON (C.ETAPA = CD1.CAT_DATA_CODE AND CD1.PAR_KEY = (SELECT TOP 1 PKEY FROM CAT_TYPE WHERE CAT_TYPE_CODE = ''ETAPAS''))
LEFT JOIN LOC_AGENCIAS AGE ON (AGE.ID = C.AGENCIA)
WHERE	C.CARTERA = '+@V_CARTERA+' 
AND EXISTS (SELECT TOP 1 1 FROM CUSTOMER_PRODUCTOS P1 WHERE P1.VIGENTE = ''SI'' AND ISNULL(NULLIF(P1.SEGMENTO_PREST,''''),'''') NOT IN (''18'',''24'') AND P1.TIPPROD IN (''4'',''27'',''1'',''45'',''55'') AND P1.PAR_KEY = C.PAR_KEY)
AND C.MONTO_TOTAL >= '''+@V_CONSOLIDADO+'''
AND C.MONTO_EXIGIBLE >= '''+@V_VENCIDA+'''
AND C.DIAS_ATRASO >= '''+@V_MORA+''' '+
CASE	WHEN @V_DISCADOR = 'SI' THEN
' AND NOT EXISTS (SELECT 1 FROM ENGAGENBSF.ENGAGENBSF.CUST_EXCLUIDOS_CAMPANA CEXC   WITH(NOLOCK)    
WHERE CEXC.CAMPANA= ''3799D6CC-8B86-4E1C-AEF2-956480D7ED06'' AND  C.PAR_KEY = CEXC.PAR_KEY)'
		ELSE '' END
+' ORDER BY 1 DESC'
	
	SET @HEADER = 'Numero de CUIT, Numero de Cliente, Apellido y Nombre, Cartera, Sucursal, Mayor Atraso, Deuda Total Consolidada, Deuda Total Vencida, Deuda Total MME, Segmento, Prestamo DDM, Prestamo Deuda Total, Prestamo Deuda Vencida, Prestamo MME, Tarj. Cred. DDM, Tarj. Cred. Deuda Total, Tarj. Cred. Deuda Vencida, Tarj. Cred. MME, GyM DDM, GyM Deuda Total, GyM Deuda Vencida, GyM MME, GyM Capital, GyM Saldo Contable, CC DDM, CC Deuda Total, CC Deuda Vencida, CC MME, CS DDM, CS Deuda Total, CS Deuda Vencida, CS MME, Fallecido [Si - No], Legales [Si - No], Quiebra [Si - No], Agencia Externa, Etapa de Agencia, Comportamiento, Comportamiento ICP, Situacion BCRA, Proyeccion, ultimo Efecto, Dato Empleador'
	
	UPDATE	TMT_TR4 
	SET		QUERY_EXPORTAR		= @V_QUERY
			,titulo				= @lsTitulo
			,subtitulo			= 'Fecha Emision: ' + CONVERT(VARCHAR,GETDATE(),106) + '   ' +SUBSTRING(CONVERT(VARCHAR,GETDATE(),108),1,5)
			,HEADER				= @HEADER							
			,FILE_NAME_ATTACHED	= @NOMBRE_ARCHIVO		
	WHERE	PAR_KEY	= @P_PKEY_JOB
		
END
