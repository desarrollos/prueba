function agregarBeneficiario()
{

    if(datosListos())
    {
        document.getElementById('numeroPeriodosPago').value = parseInt(document.getElementById('numeroPeriodosPago').value) + parseInt(1); 

        document.getElementById('contadorPeriodosPago').value = parseInt(document.getElementById('contadorPeriodosPago').value) + parseInt(1);

        contadorPeriodosPago = parseInt(document.getElementById('contadorPeriodosPago').value);

        tabla = document.createElement('table');
        tabla.width="670";
        tabla.border="0";
        tabla.id="tablaPeriodo"+document.getElementById('contadorPeriodosPago').value;
        tabla.align="center";

        tbody = document.createElement('tbody');

        tr = document.createElement('tr');

        //Columna Tipo Identificacion
        td1 = document.createElement('td');
        input = document.createElement('input');
        input.name = "codtipoidentidad_beneficiario"+contadorPeriodosPago;
        input.id = "codtipoidentidad"+contadorPeriodosPago;
        input.size = "11";
        input.readOnly = true;
        input.type = "hidden";
        input.value = document.getElementById('codtipoidentidad').value;
        td1.appendChild(input);

        td3 = document.createElement('td');
        input = document.createElement('input');
        input.name = "identbenef"+contadorPeriodosPago;
        input.id = "identbenef"+contadorPeriodosPago;
        input.size = "11";
        input.readOnly = true;
        input.value = document.getElementById('identbenef').value;
        td3.appendChild(input);

        td4 = document.createElement('td');
        input = document.createElement('input');
        input.name = "fechanacim"+contadorPeriodosPago;
        input.id = "fechanacim"+contadorPeriodosPago;
        input.size = "11";
        input.readOnly = true;
        input.type = "hidden";
        input.value = document.getElementById('fechanacim').value;
        td4.appendChild(input);


        td5 = document.createElement('td');
        input = document.createElement('input');
        input.name = "codigbenef"+contadorPeriodosPago;
        input.id = "codigbenef"+contadorPeriodosPago;
        input.size = "11";
        input.readOnly = true;
        input.value = document.getElementById('codigbenef').value;
        td5.appendChild(input);

        td6 = document.createElement('td');
        input = document.createElement('input');
        input.name = "tipoparentesco_codtipoparentesco"+contadorPeriodosPago;
        input.id = "tipoparentesco_codtipoparentesco"+contadorPeriodosPago;
        input.size = "11";
        input.readOnly = true;
        input.type = "hidden";
        input.value = document.getElementById('tipoparentesco_codtipoparentesco').value;
        td6.appendChild(input);

        td7 = document.createElement('td');
        input = document.createElement('input');
        input.name = "empresa_codempresa"+contadorPeriodosPago;
        input.id = "empresa_codempresa"+contadorPeriodosPago;
        input.size = "11";
        input.readOnly = true;
        input.type = "hidden";
        input.value = document.getElementById('empresa_codempresa').value;
        td7.appendChild(input);

        td8 = document.createElement('td');
        input = document.createElement('input');
        input.name = "numceresco"+contadorPeriodosPago;
        input.id = "numceresco"+contadorPeriodosPago;
        input.size = "11";
        input.readOnly = true;
        input.type = "hidden";
        input.value = document.getElementById('numceresco').value;
        td8.appendChild(input);

        td9 = document.createElement('td');
        input = document.createElement('input');
        input.name = "entidadsalud_codentidadsalud_beneficiario"+contadorPeriodosPago;
        input.id = "entidadsalud_codentidadsalud_beneficiario"+contadorPeriodosPago;
        input.size = "11";
        input.readOnly = true;
        input.type = "hidden";
        input.value = document.getElementById('entidadsalud_codentidadsalud').value;
        td9.appendChild(input);

        td10 = document.createElement('td');
        input = document.createElement('input');
        input.name = "numcuebanc"+contadorPeriodosPago;
        input.id = "numcuebanc"+contadorPeriodosPago;
        input.size = "11";
        input.readOnly = true;
        input.type = "hidden";
        input.value = document.getElementById('numcuebanc').value;
        td10.appendChild(input);

        td11 = document.createElement('td');
        input = document.createElement('input');
        input.name = "banco_codbanco_beneficiario"+contadorPeriodosPago;
        input.id = "banco_codbanco_beneficiario"+contadorPeriodosPago;
        input.size = "11";
        input.readOnly = true;
        input.type = "hidden";
        input.value = document.getElementById('banco_codbanco').value;
        td11.appendChild(input);

        td12 = document.createElement('td');
        input = document.createElement('input');
        input.name = "vivecontit"+contadorPeriodosPago;
        input.id = "vivecontit"+contadorPeriodosPago;
        input.size = "11";
        input.readOnly = true;
        input.type = "hidden";
        input.value = document.getElementById('vivecontit').value;
        td12.appendChild(input);

        td13 = document.createElement('td');
        input = document.createElement('input');
        input.name = "estadobeneficiario_codiestben"+contadorPeriodosPago;
        input.id = "estadobeneficiario_codiestben"+contadorPeriodosPago;
        input.size = "11";
        input.readOnly = true;
        input.type = "hidden";
        input.value = document.getElementById('estadobeneficiario_codiestben').value;
        td13.appendChild(input);

        td14 = document.createElement('td');
        input = document.createElement('input');
        input.name = "observacion_beneficiario"+contadorPeriodosPago;
        input.id = "observacion_beneficiario"+contadorPeriodosPago;
        input.size = "11";
        input.readOnly = true;
        input.type = "hidden";
        input.value = document.getElementById('observacion').value;
        td14.appendChild(input);




        //Columna Boton Remover
        td15 = document.createElement('td');
        input = document.createElement('input');
        input.type = "button";
        input.name = contadorPeriodosPago;
        input.onclick =  function(){removerPeriodoPago(this);};
        input.value = "Quitar";
        td15.width = 200;
        td15.appendChild(input);

        //-----------------------------------------
        tr.appendChild(td1);
        
        tr.appendChild(td3);
        tr.appendChild(td4);
        tr.appendChild(td5);
        tr.appendChild(td6);
        tr.appendChild(td7);
        tr.appendChild(td8);
        tr.appendChild(td9);
        tr.appendChild(td10);
        tr.appendChild(td11);
        tr.appendChild(td12);
        tr.appendChild(td13);
        tr.appendChild(td14);
        tr.appendChild(td15);

        tabla.appendChild(tbody);
        tbody.appendChild(tr);
        document.getElementById('spanFormularioNegocio').appendChild(tabla);

        document.getElementById('numeroCuotas').value = "";
        document.getElementById('tasaInteres').value = "";
        document.getElementById('fechaInicio').value = "";
    }
    else
    {
        alert('Faltan Datos');
    }
}
//------------------------------------------------------------------------------
function removerPeriodoPago(numeroPeriodo)
{
    document.getElementById('spanFormularioNegocio').removeChild(document.getElementById('tablaPeriodo'+numeroPeriodo.name));
    document.getElementById('numeroPeriodosPago').value = parseInt(document.getElementById('numeroPeriodosPago').value) - parseInt(1); 
}
//------------------------------------------------------------------------------
function datosListos()
{
 /*   if(document.getElementById('numeroCuotas').value == "")
        return false;
    else if(document.getElementById('tasaInteres').value == "")
        return false;
    else if(document.getElementById('valorCuotas').value == "")
        return false;
    else if(document.getElementById('fechaInicio').value == "")
        return false;
    else
        return true;
*/
    return true;

}