<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<%@ taglib prefix="jsp2" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>

<form method="post" id="datosPoblacion" action="SeleccionarColumnas.jsp" target="_blank"  >
    <br /><br /><br /><br /><br />
    <br /><br /><br /><br /><br />
    <table border="0" align="center" width="600">
        <tbody>
            <tr>
                <td>Archivo</td>
                <td><input type="text" name="nombreArchivo2" id="nombreArchivo2" size="35" readonly><a href="#" onclick="abrirCargaArchivo();"><img src="../images/Buscar16x16.gif" alt="Cargar Archivo" border="0"/></a></td>
                <td id="id_nombreArchivo2" class="ui-state-error ui-corner-all" style="padding: 0 .7em;display: block !important; "> </td>
            </tr>
            <tr>
                <td colspan="2"><input type="button" title="lineasMostrar" alt="#nombreArchivo2" id="lineasMostrar" class="lineasMostrar" value="Mostrar algunas lineas del archivo"</td>

            </tr>
            <tr>
                <td>Delimitador</td>
                <td>
                    <table border="0">
                        <tr>
                            <td><label>" ; "<input type="radio" name="delimitador" value=";" checked></label></td>
                            <td>&nbsp;&nbsp;&nbsp;</td>
                            <td><label>" , "<input type="radio" name="delimitador" value=","></label></td>
                            <td>&nbsp;&nbsp;&nbsp;</td>
                            <td><label>" | "<input type="radio" name="delimitador" value="|"></label></td>
                            <td>&nbsp;&nbsp;&nbsp;</td>
                            <td><label>Otro<input type="radio" name="delimitador" value="otro"><input type="text" size="2" id="otroDelimitador" name="otroDelimitador"></label></td>
                            <td id="id_delimitador" class="ui-state-error ui-corner-all" style="padding: 0 .7em;display: block !important; "> </td>
                        </tr>
                    </table>
                </td>
            </tr>

            <!--<tr>
                <td colspan="2" align="center"><input type="submit" value="Cargar Archivo"></td>
            </tr>-->
        </tbody>
    </table>
    <div class="primerasLineas">
        
    </div>

</form>



