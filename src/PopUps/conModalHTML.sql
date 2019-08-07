-- ==============================================================
-- ICONO CON BOTON + POP UP CON TABLA DE UNA UNICA FILA DE VALORES PRE OBTENIDOS
-- ==============================================================

SET @ICONO = '	<div class="w3-container w3-left-align">
							<i onclick="document.getElementById(''id01'').style.display=''block''" name="sel_pad_1" class="fa fa-user" title="Ver Más Datos" style="cursor:pointer;color:#2F5E88;font-size:16px"></i>
							<div id="id01" class="w3-modal">
								<div class="w3-modal-content w3-card-4" style="width:90%;">
									<header class="w3-container w3-teal" style="background:#2F5E88 !important;"> 
										<span onclick="document.getElementById(''id01'').style.display=''none''" class="w3-button w3-display-topright">×</span>
										<h2>TITULO ENCABEZADO</h2>
									</header>
									<div class="w3-container">
										<div class="w3-responsive">
												<p></p>
												<table class="w3-table-all w3-centered">
													<tbody><tr>
														<th>Campo 1</th>
														<th>Campo 2</th>
														<th>Campo 3</th>
														<th>Campo 4</th>       
													</tr>
													<tr>
														<td><div>'+ @CAMPO1 + '</div></td>
														<td><div>' +@CAMPO2 + '</div></td>
														<td><div>' +@CAMPO3 + '</div></td>
														<td><div">'+@CAMPO4 + '</div></td>     
													</tr>
												</tbody></table>
												<p></p>
										</div>                      
									</div>
								</div>
							</div>
					</div>'
							
							
-- ==============================================================
-- ICONO CON BOTON + POP UP CON TABLA A PARTIR DE UN SELECT
-- ==============================================================
SET @ICONO = ' <div class="w3-container w3-left-align">
					<i onclick="document.getElementById(''id02'').style.display=''block''" name="sel_pad_1" class="fa fa-check-circle" title="Ver Períodos" style="cursor:pointer;color:#2F5E88;font-size:16px"></i>
							<div id="id02" class="w3-modal">
								<div class="w3-modal-content w3-card-4" style="width:90%;">
									<header class="w3-container w3-teal" style="background:#2F5E88 !important;"> 
										<span onclick="document.getElementById(''id02'').style.display=''none''" class="w3-button w3-display-topright">×</span>
										<h2>TITULO ENCABEZADO</h2>
									</header>
									<div class="w3-container">
										<div class="w3-responsive">
												<p></p>
												<table class="w3-table-all w3-centered">
													<tbody><tr>
														<th>Campo 1</th>
														<th>Campo 2</th>     
													</tr>'

					-- CARGA UN CURSOR PARA CONCATENAR LOS <TD> y <TR>
					DECLARE @CAMPO1 VARCHAR(100),@CAMPO2 VARCHAR(100)

					DECLARE CUR_POP_UP CURSOR LOCAL FAST_FORWARD FOR
					SELECT 
						CAMPO1,
						CAMPO2
					FROM TABLA T;
							 
					 OPEN CUR_POP_UP;
					 FETCH NEXT FROM CUR_POP_UP INTO @CAMPO1 VARCHAR(100),@CAMPO2 VARCHAR(100)

					 WHILE (@@FETCH_STATUS = 0)
					 BEGIN
							SET @ICONO= @ICONO + '<tr>
									 <td>' +@CAMPO1 + '</td>
									 <td>' +@CAMPO2 + '</td>
									 </tr>'
							FETCH NEXT FROM CUR_POP_UP INTO @CAMPO1 VARCHAR(100),@CAMPO2 VARCHAR(100)
					 END;
					 CLOSE CUR_POP_UP;
					 DEALLOCATE CUR_POP_UP;
					 
					 
					 SET @ICONO= @ICONO  
					 
					 +'</tbody></table>
											<p></p>
									</div>                      
								</div>
							</div>
						</div>
				</div>' 
