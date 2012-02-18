function agregarArchivo()
{
    if(datosListos())
    {
        document.getElementById('cantidadArchivos').value = parseInt(document.getElementById('cantidadArchivos').value) + parseInt(1); 

        document.getElementById('contadorArchivos').value = parseInt(document.getElementById('contadorArchivos').value) + parseInt(1); 
        contadorArchivos = parseInt(document.getElementById('contadorArchivos').value);

        tabla = document.createElement('table');
        tabla.width="600";
        tabla.border="0";
        tabla.id="tablaArchivo"+document.getElementById('contadorArchivos').value;
        tabla.align="center";

        tbody = document.createElement('tbody');

        tr = document.createElement('tr');

        //Columna Tipo Rip
        td1 = document.createElement('td');
        input = document.createElement('input');
        input.size = "20";
        input.readOnly = true;
        input.value = document.getElementById('tiporips').options[document.getElementById('tiporips').selectedIndex].text;
        td1.appendChild(input);

        hidden = document.createElement('input');
        hidden.type = 'hidden';
        hidden.name = "tipoRip"+contadorArchivos;
        hidden.id = "tipoRip"+contadorArchivos;
        hidden.value = document.getElementById('tiporips').value;
        td1.appendChild(hidden);

        //Columna Archivo
        td2 = document.createElement('td');
        input = document.createElement('input');
        input.name = "archivoRip"+contadorArchivos;
        input.id = "archivoRip"+contadorArchivos;
        input.size = "45";
        input.readOnly = true;
        input.value = document.getElementById('nombreArchivo').value;
        td2.appendChild(input);

        //Columna Boton Remover
        img = document.createElement('img');
        img.src = "../images/x.gif";
        td3 = document.createElement('td');

        input = document.createElement('button');
        input.name = contadorArchivos;
        input.onclick =  function(){removerPeriodoPago(this);};
        input.type = "button";
        input.value = "Quitar";
        input.appendChild(img);
        td3.appendChild(input);

        //-----------------------------------------
        tr.appendChild(td1);
        tr.appendChild(td2);
        tr.appendChild(td3);

        tabla.appendChild(tbody);
        tbody.appendChild(tr);
        document.getElementById('spanArchivosAgregados').appendChild(tabla);

        document.getElementById('nombreArchivo').value = '';
        document.getElementById('tiporips').selectedIndex = 0;
    }
    else
    {
        alert('Faltan Datos');
    }
}
//------------------------------------------------------------------------------
function removerPeriodoPago(numeroPeriodo)
{
    document.getElementById('spanArchivosAgregados').removeChild(document.getElementById('tablaArchivo'+numeroPeriodo.name));
    document.getElementById('cantidadArchivos').value = parseInt(document.getElementById('cantidadArchivos').value) - parseInt(1); 
}
//------------------------------------------------------------------------------
function datosListos()
{
    if(document.getElementById('tiporips').value == "")
        return false;
    else if(document.getElementById('nombreArchivo').value == "")
        return false;
    else
        return true;
}