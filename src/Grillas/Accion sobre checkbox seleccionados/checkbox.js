
// Array con elementos seleccionados
var Almacena_Checks = new Set();

// Agrega o quita el elementos al array y campo de seleccionados
function addRemoveValue(campo,checkBox,val)
{
	//Actualiza el array
	if (checkBox.checked) Almacena_Checks.add(val);
	else Almacena_Checks.remove(val);
	
	// Actualiza el campo varchar 
	document.getElementsByName(campo).item(0).value=imprimirListado();
}


//Lista en el campo los valores, separados por ; 
function imprimirListado()
{
	var str = ""; 
	var vals = Almacena_Checks.values();
	for(var i = 0; i < vals.length; i++)
	{	
		str += vals[i];
		str += ";"
	}
	return str;
}