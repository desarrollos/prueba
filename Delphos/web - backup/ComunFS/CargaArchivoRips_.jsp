<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<%@ taglib prefix="jsp2" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>

<html>
    <head><script type="text/javascript" src="../js/jquery/jquery.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cargar Archivo Rips</title>
        <script type="text/javascript" src="formsAJAX/FormArchivosRips.js"></script>
        <style type="text/css">
        <!--
        .Estilo1 {
                color: #00CC00;
                font-weight: bold;
        }
        -->
        </style>
    </head>
    <body>
        ${msj}
        <form method="post" action="CargaArchivoRips.jsp">
        <table border="1" align="center" width="600">
            <tbody>
                <tr>
                    <td>Tipo Rip</td>
                    <td>
                    <select name="tiporips" id="tiporips">
                        <option value="">-- Seleccione el tipo de Rip --</option>
                        <sql:query var="r" sql="SELECT codtiporips, descripcion FROM tiporips" dataSource="jdbc/delphos" scope="page"/>
                        <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                        <option value="${fila.codtiporips}">${fila.descripcion}</option>
                        </jsp2:forEach>
                    </select>
                    </td>
                    <td>Archivo</td>
                    <td><input type="text" name="nombreArchivo" id="nombreArchivo" size="20" readonly><a href="#" onclick="abrirCargaArchivo('nombreArchivo');"><img src="../images/Buscar16x16.gif" alt="Cargar Archivo" border="0"/></a>&nbsp;&nbsp;&nbsp;<button value="Agregar" type="button" onclick="agregarArchivo();"><img src="../images/send.gif"></button></td>
                </tr>
                <tr>
                    <td colspan="2" align="right">Delimitador Archivos</td>
                    <td colspan="2">
                        <table border="0">
                            <tr>
                                <td><label>" ; "<input type="radio" name="delimitador" value=";"></input></label></td>
                                <td>&nbsp;&nbsp;&nbsp;</td>
                                <td><label>" , "<input type="radio" name="delimitador" value="," checked></label></td>
                                <td>&nbsp;&nbsp;&nbsp;</td>
                                <td><label>" | "<input type="radio" name="delimitador" value="|"></label></td>
                                <td>&nbsp;&nbsp;&nbsp;</td>
                                <td><label>Otro<input type="radio" name="delimitador" value="otro"><input type="text" size="2" name="otroDelimitador"></label></td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </tbody>
        </table>
        <%---------------------------------------------------------------------------%>
        <table align="center" border="1" width="600">
            <sql:query var="r" sql="SELECT codtiporips, descripcion FROM tiporips WHERE upper(obligatorio)='S'" dataSource="jdbc/delphos" scope="page"/>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
            <tr>
                <td><input type="text" value="${fila.descripcion}" size="20" readonly class="Estilo1"><input type="hidden" name="tipoRip${contador.count}"></td>
                <td><input type="text" value="" size="45" name="archivoRip${contador.count}" id="archivoRip${contador.count}" readonly><a href="#" onclick="abrirCargaArchivo('archivoRip${contador.count}');"><img src="../images/Buscar16x16.gif" alt="Cargar Archivo" border="0"/></a></td>
            </tr>
            <c:set var="cantidadRipsObligatorios" value="${contador.count}"/>
            </jsp2:forEach>
        </table>
        <%---------------------------------------------------------------------------%>
        <span id="spanArchivosAgregados">
        </span>
        <%---------------------------------------------------------------------------%>
        <table border="1" align="center" width="600">
            <tbody>
                <tr>
                    <td colspan="4" align="center"><input type="submit" value="Cargar Archivos"></td>
                </tr>
            </tbody>
        </table>
        <input type="hidden" name="hacerSubmit" value="1">
        <input type="hidden" name="codtipoestrucarch" value="${param.codtipoestrucarch}">
        <input type="hidden" name="idencabezado" value="${param.idencabezado}">
        <input type="hidden" name="accion" value="${param.accion}">
        <input type="hidden" name="tipoRips" value="${param.tipoRips}">
        <%------------------------------%>
        <input type="hidden" id="cantidadArchivos" name="cantidadArchivos" value="${cantidadRipsObligatorios}">
        <input type="hidden" id="contadorArchivos" name="contadorArchivos" value="${cantidadRipsObligatorios}">
        </form>
    </body>
</html>
<script>
function abrirCargaArchivo(campoFormulario)
{
    var url;
    url = "../common/PopUpCargaArchivo.jsp?";
    url = url + "campo=" + campoFormulario;
    window.open(url,"_blank","width=500,height=190,scrollbars=1,left=350,top=100");
}
</script>
