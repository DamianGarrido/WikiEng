 /*************************************************************************
 DGARRIDO: Acciones sobre los registros de una grilla
 *************************************************************************/
 
//Ejemplo de bodyGrilla = 'GRID.BODY.P_HG_GR_HOME:ctl_41'
function nuevoTramite(job_type,bodyGrilla) {
	var filas = document.getElementById(bodyGrilla).tBodies[0].rows;
			
	for (var i = 0; i < filas.length-1; i++) {
	filas[i].ondblclick = function(){nuevoTramiteOtroCustomer(job_type, this.childNodes[0].childNodes[0].id, '');};
	}
}