
// Doc: https://docs.google.com/document/d/1aRqZVF5_CrR88BnihYlPDQH4YXjboeNIPniQeW-amZ4/edit?usp=sharing


// Chronometer HTML

<div class="crono_wrapper">	<h2 id='crono'>00:00:00</h2></div>

	
// Script para blanquear el localStorage al inicializar el trámite
	
<script>window.localStorage.setItem("tiempoInicio",0);window.localStorage.setItem("tiempoFinal",0);Continuar();</script>


// BTN START/STOP

<input id='btn_empezar' type="button" value="Empezar" onclick="empezarDetener(this);">

	
// BTN RESTART
	
<input id='btn_reiniciar' type="button" value="Reiniciar" onclick="reiniciar(this);">	

	
// IFRAME BTN V1

<input id='btn_siguiente' type="button" value="Siguiente" onclick="window.parent.parent.document.getElementById('btn_empezar').click();">


// IFRAME BTN V2

<input id='btn_siguiente' type="button" value="Siguiente" onclick="window.parent.parent.empezarDetener(window.parent.parent.document.getElementById('btn_empezar'));">


// IFRAME BTN V3 TODO: Para que no haya que usar el botón btn_empezar

	
// JS FUNCTIONS PARAMETER

PS_CRONOMETRO:='<script type="text/javascript">'||
    '
   // var inicio=  (localStorage.getItem("tiempoInicio") == 0) ? new Date().getTime() : localStorage.getItem("tiempoInicio");
    var inicio=0;
    var timeout=0;
	
	function inicializar()
	{
		var actual = (localStorage.getItem("tiempoFinal") == 0) ? new Date().getTime() : localStorage.getItem("tiempoFinal");
		
		inicio=  (localStorage.getItem("tiempoInicio") == 0) ? new Date().getTime() : localStorage.getItem("tiempoInicio");
		
        // Obtenemos la diferencia entre la fecha actual y la de inicio
        var diff=new Date(actual-inicio);
 
        // Formateamos el tiempo a mostrar HH:MM:SS
        var result=LeadingZero(diff.getUTCHours())+":"+LeadingZero(diff.getUTCMinutes())+":"+LeadingZero(diff.getUTCSeconds());
	    
		// Seteamos el tiempo a mostrar
        document.getElementById(''crono'').innerHTML = result;
	}
	
	
    function empezarDetener(elemento)
    {
        if(timeout==0)
        {
            // empezar el cronometro
 
            elemento.value="Detener";
 
            // Obtenemos el valor actual
            inicio=new Date().getTime();
			
			// En caso que la pantalla vaya a refrescarse se guarda el tiempo de inicio del cronómetro
			localStorage.setItem("tiempoInicio", inicio);
			
            // Iniciamos el cronometro
            funcionando();
        }else{
            // Detener el cronometro (En realidad es Pausar)
 
            elemento.value="Empezar";
            clearTimeout(timeout);
            timeout=0;
        }
    }
 

    function reiniciar(elemento)
    {
            // detemer el cronometro
            clearTimeout(timeout);
            timeout=0;
		
	     // Obtenemos el valor actual
            inicio=new Date().getTime();
		
		// En caso que la pantalla vaya a refrescarse se guarda el tiempo de inicio del cronómetro
			localStorage.setItem("tiempoInicio", inicio);
		
	    // Iniciamos el cronometro
            funcionando();
    }

    function funcionando()
    {
        // Obtenemos la fecha actual
        var actual = new Date().getTime();
 
        // Obtenemos la diferencia entre la fecha actual y la de inicio
        var diff=new Date(actual-inicio);
 
        // Formateamos el tiempo a mostrar HH:MM:SS
        var result=LeadingZero(diff.getUTCHours())+":"+LeadingZero(diff.getUTCMinutes())+":"+LeadingZero(diff.getUTCSeconds());
	    
		// Seteamos el tiempo a mostrar
        document.getElementById(''crono'').innerHTML = result;
 		
		// En caso que la pantalla vaya a refrescarse se guarda el tiempo de inicio del cronómetro
			localStorage.setItem("tiempoFinal", actual);
			
        // Indicamos que se ejecute esta función nuevamente dentro de 1 segundo
        timeout=setTimeout("funcionando()",1000);
    }
 
    /* Funcion que pone un 0 delante de un valor si es necesario */
    function LeadingZero(Time) {
        return (Time < 10) ? "0" + Time : + Time;
    }
    </script>
 	
     <style>
    .crono_wrapper {text-align:center;color:azure;font-family:cursive;background:lightskyblue;width:125px;border-radius: 10px;}
	</style>'
