<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<%@ taglib prefix="jsp2" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>




<form method="post" action="CargaArchivoRips.jsp" target="_blank" id="ripsForm">
    <sql:query var="r" sql="SELECT codtiporips, descripcion FROM tiporips WHERE upper(obligatorio)='S' AND (codtiporips = 'AF' OR codtiporips = 'US') ORDER BY codtiporips DESC" dataSource="jdbc/delphos" scope="page"/>
    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
        <input type="hidden" id="siguienteRip_${fila.codtiporips}" value="si" />
        <div id="rips_${fila.codtiporips}" style="display:none">
            <table  border="0" align="center" width="670">
                <tr>
                    <td>${fila.descripcion}<input type="hidden" name="tipoRip_${fila.codtiporips}" value="${fila.codtiporips}" id="tipoRip_${fila.codtiporips}"></td>
                </tr>

                <tr>
                    <td><input type="text" value="" size="45" name="archivoRip_${fila.codtiporips}" id="archivoRip_${fila.codtiporips}" readonly><a href="#" onclick="abrirCargaArchivoRips('archivoRip_${fila.codtiporips}');"><img src="../images/Buscar16x16.gif" alt="Cargar Archivo" border="0"/></a></td>
                    <td id="id_archivoRip_${fila.codtiporips}" class="ui-state-error ui-corner-all" style="padding: 0 .7em;display:none; "> </td>
                </tr>
                <tr>
                    <td colspan="2"><input type="button" title="lineasMostrar" class="lineasMostrar"  alt="#archivoRip_${fila.codtiporips}" value="Mostrar algunas lineas del archivo" /></td>

                </tr>
                <tr>
                    <td>
                        <label>" ; "<input type="radio" name="delimitador_${fila.codtiporips}" value=";" checked></label>
                        <label>" , "<input type="radio" name="delimitador_${fila.codtiporips}" value=","></label>
                        <label>" | "<input type="radio" name="delimitador_${fila.codtiporips}" value="|"></label>
                        <label>Otro<input type="radio" name="delimitador_${fila.codtiporips}" value="otro"><input type="text" size="2" name="otroDelimitador_${fila.codtiporips}" id="otroDelimitador_${fila.codtiporips}"></label>
                    </td>
                </tr>

                <c:set var="cantidadRipsObligatorios" value="${contador.count}"/>

            </table>
        </div>
    </jsp2:forEach>
    <!-- Para pruebas se limita la cantidad de rips a mostrar ... -->
    <sql:query var="r" sql="SELECT codtiporips, descripcion FROM tiporips WHERE obligatorio='n' LIMIT 10 OFFSET 2" dataSource="jdbc/delphos" scope="page"/>
    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
        <input type="hidden" id="siguienteRip_${fila.codtiporips}" value="si" />
        <div id="rips_${fila.codtiporips}" style="display:none">
            <table  border="0" align="center" width="670">
                <tr>
                    <td>${fila.descripcion}<input type="hidden" name="tipoRip_${fila.codtiporips}" value="${fila.codtiporips}" id="tipoRip_${fila.codtiporips}"></td>
                </tr>

                <tr>
                    <td><input type="text" value="" size="45" name="archivoRip_${fila.codtiporips}" id="archivoRip_${fila.codtiporips}" readonly><a href="#" onclick="abrirCargaArchivoRips('archivoRip_${fila.codtiporips}');"><img src="../images/Buscar16x16.gif" alt="Cargar Archivo" border="0"/></a></td>
                    <td id="id_archivoRip_${fila.codtiporips}" class="ui-state-error ui-corner-all" style="padding: 0 .7em;display: block !important; "> </td>
                </tr>
                <tr>
                    <td colspan="2"><input type="button" title="lineasMostrar" id="archivoRip_${fila.codtiporips}" class="lineasMostrar" alt="#archivoRip_${fila.codtiporips}" value="Mostrar algunas lineas del archivo" /></td>

                </tr>
                <tr>
                    <td>
                        <label>" ; "<input type="radio" name="delimitador_${fila.codtiporips}" value=";" ></label>
                        <label>" , "<input type="radio" name="delimitador_${fila.codtiporips}" value="," checked></label>
                        <label>" | "<input type="radio" name="delimitador_${fila.codtiporips}" value="|"></label>
                        <label>Otro<input type="radio" name="delimitador_${fila.codtiporips}" value="otro"><input type="text" size="2" name="otroDelimitador_${fila.codtiporips}" id="otroDelimitador_${fila.codtiporips}"></label>
                    </td>
                </tr>

                <c:set var="cantidadRipsObligatorios" value="${contador.count}"/>

            </table>
        </div>

    </jsp2:forEach>
    <div class="primerasLineas">

    </div>

    <!--
<table border="0" align="center" width="670">
<tr>
    <td>Tipo Rip</td>
    <td>
        <select name="tiporips" id="tiporips">
            <option value="">-- Seleccione el tipo de Rip --</option>
    <sql:query var="r" sql="SELECT codtiporips, descripcion FROM tiporips WHERE obligatorio != 'i'" dataSource="jdbc/delphos" scope="page"/>
    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
        <option value="${fila.codtiporips}">${fila.descripcion}</option>
    </jsp2:forEach>
</select>
</td>
<td id="id_tiporips" class="ui-state-error ui-corner-all" style="padding: 0 .7em;display: block !important; "> </td>

</tr>
<tr>
<td>Archivo</td>
<td><input type="text" name="nombreArchivoPrimero" id="nombreArchivoPrimero" size="20" readonly><a href="#" onclick="abrirCargaArchivoRips('nombreArchivoPrimero');"><img src="../images/Buscar16x16.gif" alt="Cargar Archivo" border="0"/></a></td>
<td id="id_nombreArchivoPrimero" class="ui-state-error ui-corner-all" style="padding: 0 .7em;display: block !important; "> </td>
</tr>
<tr>
<td>Delimitador</td>
<td>
<label>" ; "<input type="radio" name="delimitadorRips" value=";" checked></label>
<label>" , "<input type="radio" name="delimitadorRips" value=","></label>
<label>" | "<input type="radio" name="delimitadorRips" value="|"></label>
<label>Otro<input type="radio" name="delimitadorRips" value="otro"><input type="text" size="2" name="otroDelimitadorRips" id="otroDelimitadorRips"></label>
</td>
<td id="id_delimitadorRips" class="ui-state-error ui-corner-all" style="padding: 0 .7em;display: block !important; "> </td>
</tr>
</table>


    -->


    <%---------------------------------------------------------------------------%>

    <input type="hidden" name="tipoRipsX" id="tipoRipsX" value="${param.tipoRips}" />
    <input type="hidden" id="cantidadArchivos" name="cantidadArchivos" value="${cantidadRipsObligatorios}" />
    <input type="hidden" id="contadorArchivos" name="contadorArchivos" value="${cantidadRipsObligatorios}" />


</form>



<script>
    function abrirCargaArchivoRips(campoFormulario)
    {
        var url;
        url = "../common/PopUpCargaArchivo.jsp?";
        url = url + "campo=" + campoFormulario;
        window.open(url,"_blank","width=500,height=190,scrollbars=1,left=350,top=100");
    }
</script>
