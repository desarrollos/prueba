<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<%@ taglib prefix="jsp2" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>

<table
    <tr>
        <td>
            Tipo de carga
        </td>
        <td>
            <label><input type="radio" name="tipoCarga" id="poblacion" value="CargarPoblacion" onclick="seleccionarTipoRip('', '')">Poblacion </label>
            &nbsp;&nbsp;&nbsp;
            <label><input type="radio" name="tipoCarga" id="ips" value="CargarRips" onclick="seleccionarTipoRip('ips', '')">Rips IPS</label>
            &nbsp;&nbsp;&nbsp;
            <label><input type="radio" name="tipoCarga" id="eap" value="CargarRips" onclick="seleccionarTipoRip('eap', '')">Rips EAPB</label>
            &nbsp;&nbsp;&nbsp;
        </td>

    </tr>
    <tr>
        <td></td>
        <td id="id_tipoArchivo"  style="padding: 0 .7em;display: none;color:#fe0000; ">Seleccione el tipo de archivo</td>
    </tr>
    <tr>
        <td>
            Regimen
        </td>
        <td>
            <select name="codregimen" id="codregimen" onchange="entidadSaludDeAcuerdoAregimen('')">
                <option value="">---------- Seleccione Regimen ----------</option>
                <sql:query var="r" sql="SELECT * FROM regimen ORDER BY(descripcion) ASC" dataSource="jdbc/delphos" scope="page"/>
                <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                    <option value="${fila.codregimen}">${fila.descripcion}</option>
                </jsp2:forEach>
            </select>
        </td>

    </tr>
    <tr >
        <td></td>
        <td id="id_regimen" style="padding: 0 .7em;display: none;color:#fe0000 !important; " colspan="2">
            Selecciona un regimen
        </td>

    </tr>
    <tr>
        <td>Entidad Salud</td>
        <td>
            <select name="codentidadsalud" id="codentidadsalud" onclick="antesDebeSeleccionarUnRegimen()"   >

            </select>
        </td>

    </tr>


    <tr>
        <td>
            Grupo poblaci&oacute;n
        </td>
        <td>
            <select name="grupopoblacion" id="grupopoblacion">
                <option value="">---------- Seleccione un grupo poblaci&oacute;n ----------</option>
                <sql:query var="r" sql="SELECT * FROM grupopoblacion ORDER BY(descripcion) ASC" dataSource="jdbc/delphos" scope="page"/>
                <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                    <option value="${fila.codgrupopoblacion}">${fila.descripcion}</option>
                </jsp2:forEach>
            </select>
        </td>

    </tr>
    <tr >
        <td></td>
        <td id="id_grupopoblacion" style="padding: 0 .7em;display: none;color:#fe0000 !important; " colspan="2">

        </td>

    </tr>

    <tr>
        <td></td>
        <td id="id_entidadSalud"  style="padding: 0 .7em;display:none;color:#fe0000; ">
            Indique una entidad de salud
        </td>
    </tr>

    <tr>
        <td>Fecha Inicial</td>
        <td><input type="text" name="fechainicial" id="fechainicial" size="35" value="" readonly></td>

    </tr>
    <tr>
        <td></td>
        <td id="id_fechaInicial" style="padding: 0 .7em;display: none;color:#fe0000; ">Seleccione una fecha Inicial</td>
    </tr>

    <tr>
        <td>Fecha Final</td>
        <td><input type="text" name="fechafinal" id="fechafinal" size="35" value="" readonly></td>

    </tr>
    <tr>
        <td></td>
        <td id="id_fechaFinal"  style="padding: 0 .7em;display: none;color:#fe0000; ">Seleccione una fecha final</td>
    </tr>
    <tr>
        <td>Codigo Tipo Archivo</td>
        <td>
            <select name="codigoTipoArchivo" id="codigoTipoArchivo">
                <option value="">---------- Seleccione Tipo Archivo ----------</option>
                <sql:query var="r" sql="SELECT * FROM tipoarchivo ORDER BY(descripcion) ASC" dataSource="jdbc/delphos" scope="page"/>
                <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                    <option value="${fila.codtipoarchivo}">${fila.descripcion}</option>
                </jsp2:forEach>
            </select>
        </td>

    </tr>
    <tr>
        <td></td>
        <td id="id_codigoTipoArchivo"  style="padding: 0 .7em;display: none;color:#fe0000; ">
            Codigo del archivo
        </td>
    </tr>
    <tr>
        <td>Codigo Archivo</td>
        <td><input type="text" name="codarchivo" id="codarchivo" value="" /></td>

    </tr>
    <tr>
        <td></td>
        <td id="id_codigoArchivo"  style="padding: 0 .7em;display: none;color:#fe0000; ">Digite el codigo del archivo</td>
    </tr>

    <tr>
        <td>Departamento</td>
        <td>
            <select name="coddepartamento" id="coddepartamento" onChange="llenarComboMunicipios('');">
                <option value="">---------- Seleccione Departamento  ----------</option>
                <sql:query var="r" sql="SELECT * FROM departamento ORDER BY(nombre) ASC" dataSource="jdbc/delphos" scope="page"/>
                <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                    <option value="${fila.coddepartamento}">${fila.nombre}</option>
                </jsp2:forEach>
            </select>
        </td>

    </tr>
    <tr>
        <td></td>
        <td id="id_departamento"  style="padding: 0 .7em;display: none;color:#fe0000; ">
            Seleccione un departamento
        </td>
    </tr>

    <tr>
        <td>Municipio</td>
        <td>
            <span id="spanMunicipio">
                <select name="codmunicipio" id="codmunicipio">
                    <option>-- Seleccione el municipio --</option>
                </select>
            </span>
        </td>

    </tr>
    <tr>
        <td></td>
        <td id="id_municipio"  style="padding: 0 .7em;display: none;color:#fe0000; ">Seleccione un municipio</td>
    </tr>


    <tr>
        <td>Nombre Envia</td>
        <td><input type="text" name="nombreenvia" id="nombreenvia" size="35" value=""></td>

    </tr>
    <tr>
        <td></td>
        <td id="id_nombreEnvia"  style="padding: 0 .7em;display: none;color:#fe0000; "></td>
    </tr>
    <tr>
        <td>Telefono Envia</td>
        <td><input type="text" name="telefonoenvia" id="telefonoenvia" size="35" value=""></td>

    </tr>
    <tr>
        <td></td>
        <td id="id_telefono"  style="padding: 0 .7em;display: none;color:#fe0000; ">Telefono envia</td>
    </tr>
    <tr>
        <td>Email Envia</td>
        <td><input type="text" name="emailenvia" id="emailenvia" size="35" value=""></td>

    </tr>
    <tr>
        <td></td>
        <td id="id_email"  style="padding: 0 .7em;display: none;color:#fe0000; ">Email envia</td>
    </tr>
    <tr>
        <td>Fecha Envio</td>
        <td><input type="text" name="fechaenvio" id="fechaenvio" size="35" value="" readonly></td>

    </tr>
    <tr>
        <td></td>
        <td id="id_fehaEnvio"  style="padding: 0 .7em;display: none;color:#fe0000; ">Fecha de envio</td>
    </tr>
    <tr>
        <td>Fecha Recibo</td>
        <td><input type="text" name="fecharecibo" id="fecharecibo" size="35" value="" readonly></td>

    </tr>
    <tr>
        <td></td>
        <td id="id_fechaRecibo"  style="padding: 0 .7em;display: none;color:#fe0000; ">Fecha de recibido</td>
    </tr>

    <tr>
        <td>Cantidad Registros</td>
        <td><input type="text" name="registros" id="registros" size="35" value=""></td>

    </tr>
    <tr>
        <td></td>
        <td id="id_cantRegistros"  style="padding: 0 .7em;display: none;color:#fe0000; "></td>
    </tr>
    <tr>
        <td>Copia Documento Remisorio</td>
        <td>
            <span id="subirDocumento">
                <input type="text" name="nombreArchivo" id="nombreArchivo" size="35" value=""/>
            <a href="#" onclick="abrirCargaArchivo();"><img src="../images/Buscar16x16.gif" alt="Cargar Archivo" border="0"/></a>
            </span>
            <span id="descargarDocumento">
            <a href="../descargarArchivo?bajar=entra">Descargar</a>    
                
            </span>
            
            
            
        </td>


    </tr>
    <tr>
        <td></td>
        <td id="id_documentAdjunto"  style="padding: 0 .7em;display: none;color:#fe0000; ">Resolucion documento abjunto</td>
    </tr>
    



</table>

<script>
    

    function seleccionarTipoRip(tipoRip, entidadSalud)
    {
        
        document.getElementById('tipoRip').value = tipoRip;
        document.getElementById('tipoRipsX').value = tipoRip;
        
        
        
        //ripsOpoblacion = $("input[@name='tipoCarga']:checked").val();
        $("#grupopoblacion").prop('disabled', ( tipoRip != '' ? true : ( $("#codregimen").val == 'otr' || $("#codregimen").val() == 'par'  ) ? false : true ) )   ;
        $("#codigoTipoArchivo").prop('disabled', ( tipoRip != '' ? true : false ) )   ;
        
        if( tipoRip == 'ips' ){
            
            $("#codregimen").find( "option[value='otr']" ).prop("selected","selected");
            $("#codregimen").prop("disabled", true);
            $("input[name*='tipoCarga']").find('CargarRips').prop("checked", true);
            
            if($("#codregimen").val() == 'otr' && entidadSalud == '' ){
                entidadSaludDeAcuerdoAregimen('');
            }
        } else {
            
            $("#codregimen").find( "option[value='']" ).prop("selected","selected");
            $("#codregimen").prop("disabled", false);
            $("#codentidadsalud").html('');
        }
        
        if( tipoRip != '' ) {
            $("#codigoTipoArchivo").find( "option[value='rips']" ).prop("selected","selected");
        } else {
            $("#codigoTipoArchivo").find( "option[value='']" ).prop("selected","selected");
        }
        
    }

    function abrirCargaArchivo()
    {
        var url;
        url = "../common/PopUpCargaArchivo.jsp?";
        url = url + "campo=nombreArchivo";
        window.open(url,"_blank","width=500,height=190,scrollbars=1,left=350,top=100");
    }

    var req;

    function cargarMunicipios()
    {
        var departamento = document.getElementById("coddepartamento");
        var url = "../ServletSeleccionarMunicipios?codDepartamento=" + encodeURIComponent(departamento.value);
        if (typeof XMLHttpRequest != "undefined")
            req = new XMLHttpRequest();
        else if (window.ActiveXObject)
            req = new ActiveXObject("Microsoft.XMLHTTP");
        req.open("GET", url, true);
        req.onreadystatechange = callbackSeleccionarMunicipios;
        req.send(null);
    }

    function callbackSeleccionarMunicipios()
    {
        if (req.readyState == 4)
            if (req.status == 200)
                obtenerListadoMunicipios();
    }

    function obtenerListadoMunicipios()
    {
        var mdiv = document.getElementById("spanMunicipio");
        var select, xmlMunicipios, i, cantMunicipios, municipio, codMunicipio;

        xmlMunicipios = req.responseXML.getElementsByTagName("municipios")[0];
        cantMunicipios = xmlMunicipios.getElementsByTagName("municipio").length;

        select = "<select name=\"codmunicipio\" id=\"codmunicipio\" style=\"width:150px\">";
        select = select + "<option value=\"\">Seleccione el Municipio</option>";
        for(i=0; i<cantMunicipios; i++ )
        {
            codMunicipio = xmlMunicipios.getElementsByTagName("codMunicipio")[i];
            nombre = xmlMunicipios.getElementsByTagName("nombre")[i];

            select = select+"<option value=\""+codMunicipio.childNodes[0].nodeValue+"\">"+nombre.childNodes[0].nodeValue+"</option>";
        }
        select = select+"</select>";
        mdiv.innerHTML = select;
    }

</script>