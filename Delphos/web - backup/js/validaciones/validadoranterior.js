// JavaScript Document
var clase_css_error = "formulario_error";
var clase_css_normal = "formulario_normal";

function validar( cadenas, numeros, fechas, horas, combos )
{
        limpiarColor(cadenas);
        limpiarColor(numeros);
        limpiarColor(fechas);
        limpiarColor(horas);
        limpiarColor(combos);

        if( cadenas != null && !sonValidasCadenas( cadenas ) )
	{
		alert("Datos incompletos. Debe llenar todos los campos.");
		return false;
	}

        if( numeros != null && !sonValidosNumeros( numeros ) )
	{
		alert("Datos erróneos. Debe llenar los campos con números.");
		return false;
	}
        
	if( combos != null && !sonValidosCombos( combos ) )
	{
		alert("Datos erróneos. Debe llenar los campos desplegables.");
		return false;
	}

        if( fechas != null && !sonValidasFechas( fechas ))
	{
		alert("Datos erróneos. Debe llenar los campos con fechas.");
		return false;
	}

        if( horas != null && !sonValidasHoras( horas ) )
	{
		alert("Datos incompletos. Debe llenar los campos con formatos de hora válidos [HH:MM].");
		return false;
	}

        return true;
}

function sonValidasHoras( horas )
{
	for( var i=0; i<horas.length; i++ )
	{
                if( !esHoraValida( horas[i] ) )
                {
                    pintarCampoErroneo( horas[i] );
                    return false;
                }
	}
	
	return true;
}

function esHoraValida(timeStrtotal)
{
    timeStr = obtenerValorElemento(timeStrtotal);

    // Checks if time is in HH:MM:SS AM/PM format.
    // The seconds and AM/PM are optional.

    var timePat = /^(\d{1,2}):(\d{2})(:(\d{2}))?(\s?(AM|am|PM|pm))?$/;

    var matchArray = timeStr.match(timePat);
    
    if (matchArray == null)
    {
        alert("La hora no tiene un formato válido.");
        return false;
    }

    hour = matchArray[1];
    minute = matchArray[2];
    second = matchArray[4];
    ampm = matchArray[6];

    if (second=="") { second = null; obtenerElemento(timeStrtotal).value = timeStr+":00"; }
    if (ampm=="") { ampm = null }

    if (hour < 0  || hour > 23)
    {
        alert("La hora debe estar entre 0 y 23");
        return false;
    }
    
    if  (ampm != null)
    {
        alert("No puede especificar AM o PM. Debe usar el formato [HH:MM:SS]");
        return false;
    }

    if (minute<0 || minute > 59)
    {
        alert ("Los minutos deben estar entre 0 y 59.");
        return false;
    }
    
    if (second != null && (second < 0 || second > 59))
    {
        alert ("Los segundos deben estar 0 y 59.");
        return false;
    }
    
    return true;
}

function limpiarColor( arrayDatos )
{
    if( arrayDatos != null )
        for( var i=0; i<arrayDatos.length; i++  )
        {
            pintarCampo( arrayDatos[i], clase_css_normal );
        }
}

function sonValidosCombos( combos )
{
	for( var i=0; i<combos.length; i++ )
	{
			var elemento = obtenerElemento(combos[i]);
			if( elemento.selectedIndex < 1 )
			{
				pintarCampoErroneo( combos[i] );
				return false;
			}
 	}
	
	return true;
}

function sonValidasFechas( fechas )
{
	for( var i=0; i<fechas.length; i++ )
	{
                if( !esFecha( fechas[i] ) )
                {
                        pintarCampoErroneo( fechas[i] );
						return false;
                }
	}
	
	return true;
}

function esFecha( fecha )
{
	try
	{
		var fechaStr 	= obtenerValorElemento(fecha);

                if (!/^\d{2}\/\d{2}\/\d{4}$/.test(fechaStr))
                    return false;
	}
	catch( exception )
	{
		return false;
	}
	
	return true;
}

function sonValidosNumeros( numeros )
{
	for( var i=0; i<numeros.length; i++ )
	{
                if( !esEntero( numeros[i] ) )
                {
                        pintarCampoErroneo( numeros[i] );
			return false;
                }
	}
	
	return true;
}

function pintarCampoErroneo( nombreCampo )
{
    pintarCampo(nombreCampo, clase_css_error);
    elemento.focus();
}

function pintarCampo( nombreCampo, clase_css )
{
    elemento = obtenerElemento(nombreCampo);

    elemento.className = clase_css;
}

function sonValidasCadenas( cadenas )
{
	for( var i=0; i<cadenas.length; i++ )
	{
                if( esVacio( cadenas[i] ) )
                {
                        pintarCampoErroneo( cadenas[i] );
			return false;
                }
	}
	
	return true;
}

function esEntero( nombreCampo )
{
        var texto = obtenerValorElemento(nombreCampo);

	try
	{
            if( texto == null || texto == "" )
                return false;

            var numero = parseInt(texto);

            if( numero <= -1 )
                return false
	}
	catch( e )
	{
		return false;
	}
	
	return true;
}

function esVacio( nombreCampo )
{
        var texto = obtenerValorElemento(nombreCampo);

        for ( var i = 0; i < texto.length; i++ )
        {  
                if ( texto.charAt(i) != ' ' )
                {  
                        return false;
                }  
        }

        return true;
}

function obtenerValorElemento(itemId)
{
        if( obtenerElemento(itemId) != null )
            return obtenerElemento(itemId).value;

        return null;
}

function obtenerElemento(itemId)
{
	if (document.layers && document.layers[itemId] != null) {
	    objValue = document.layers[itemId];
	}
	else if (document.all) {
	    objValue = document.all[itemId];
	}
	else if (document.getElementById) {
	    objValue = document.getElementById([itemId]);
	}

        if(objValue == null)
            alert("No se ha encontrado el elemento " +itemId);

	return objValue;
}

function Trim( str ) 
{
    var resultStr = "";
    resultStr = TrimLeft(str);
    resultStr = TrimRight(resultStr);
    return resultStr;
}

function TrimLeft( str ) 
{
    var resultStr = "";
    var i = len = 0;
    if (str+"" == "undefined" || str == null)
        return "";
    str += "";

    if (str.length == 0)
        resultStr = "";
    else {
        len = str.length;
        while ((i <= len) && (str.charAt(i) == " "))
            i++;
        resultStr = str.substring(i, len);
    }
    return resultStr;
}

function TrimRight( str ) 
{
    var resultStr = "";
    var i = 0;
    if (str+"" == "undefined" || str == null)
        return "";
    str += "";
    if (str.length == 0)
        resultStr = "";
    else {
        i = str.length - 1;
        while ((i >= 0) && (str.charAt(i) == " "))
            i--;
        resultStr = str.substring(0, i + 1);
    }

    return resultStr;
}