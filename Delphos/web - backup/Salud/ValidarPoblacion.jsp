<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<%@ taglib prefix="jsp2" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>:: DELPHOS ::</title>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
        <link rel="stylesheet" type="text/css" media="all" href="../css/delphos.css" />
        <link rel="stylesheet" type="text/css" media="all" href="../js/jsCalendar/skins/aqua/theme.css" title="Aqua" />
        <link href="../images/favicon.ico" rel="Shortcut Icon" type="image/x-icon" />
        <script type="text/javascript" src="../js/jsCalendar/calendar.js"></script>
        <script type="text/javascript" src="../js/jsCalendar/lang/calendar-es.js"></script>
        <script type="text/javascript" src="../js/jsCalendar/calendar-setup.js"></script>
        <script type="text/javascript" src="../js/formsAJAX/fomularioAjax.js"></script>
        <script type="text/javascript" src="../js/treeview/ua.js"></script>
        <script type="text/javascript" src="../js/treeview/ftiens4.js"></script>
        <script type="text/javascript" src="../js/treeview/demoFramelessNodes.js"></script>
        <script type="text/javascript" src="../js/pestanas/jquery-1.2.2.pack.js"></script>
        <script type="text/javascript" src="../js/pestanas/animatedcollapse.js"></script>
        <script type="text/javascript" src="../js/validaciones/validador.js"></script>
        <script type="text/javascript">
            function configurar()
            {
            }
            
            /*var arrayCamposTexto        = new Array('codarchivo','nombrearchivo','nombreenvia','telefonoenvia','emailenvia','copiadctoremis');
            var arrayCamposNumero       = new Array('registros');
            var arrayCamposFechas       = new Array('fechainicial','fechafinal','fechaenvio','fecharecibo');
            var arrayCamposHoras        = null;
            var arrayCamposDesplegables = new Array('codregimen','codentidadsalud','coddepartamento','codmunicipio','codarchivo','proceso');*/
	</script>
</head>
<body bgcolor="#FFFFFF">
<!-- ImageReady Slices (panel.psd) -->
${msj}
<center>
<table id="Table_01" width="906" style="height: 780; border: 0px" cellpadding="0" cellspacing="0">
<tr>
    <td colspan="3">
        <img src="../images/cabezote.png" width="906" height="150" alt="" />
    </td>
</tr>
<%-- Datos sesion --%>
<tr valign="top">
    <td colspan="3" width="906" height="16" style="background: url('../images/panel_02.gif')" align="right">
        <span class="textoPequeno"><%=request.getSession().getAttribute("nombre")%> <%=request.getSession().getAttribute("apellido")%></span><a href="../logout.jsp"><img src="../images/log_out.png" border="0" alt="Cerrar sesion" width="20" height="20" /></a>
    </td>
</tr>
<%-- Datos sesion --%>
<tr>
    <td style="background: url('../images/back.png')" width="234" valign="top">
        <table cellpadding="0" cellspacing="0">
            <tr>
                <td align="left" valign="top">
                    <table border="0"><tr><td><font size="-2"><a style="font-size:7pt;text-decoration:none;color:silver" href="http://www.treemenu.net/" target="_blank">Javascript Tree Menu</a></font></td></tr></table>
                     <span class="TreeviewSpanArea">
                         <script type="text/javascript">
				 initializeDocument();
                         </script> 
                     </span>
                </td>
            </tr>
        </table>
    </td>
    <td valign="top">
        <form name="formulario" action="ValidarPoblacion.jsp" method="post">
        <table border="0" align="center" width="600">
            <tbody>
                <tr>
                    <td colspan="2" align="center" class="titulo1">Inconsistencias / Novedades</td>
                </tr>
                <tr>
                    <td align="left" class="bgDescTablas">Codigo Entidad Salud</td>
                    <td>
                        <select name="codentidadsalud" id="codentidadsalud">
                            <option value="">---------- Seleccione Entidad ----------</option>
                            <sql:query var="r" sql="SELECT * FROM entidadsalud" dataSource="jdbc/delphos" scope="page"/>
                            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                                <option value="${fila.codentidadsalud}">${fila.nombrehabilitacion}</option>
                            </jsp2:forEach>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">&nbsp;</td>
                </tr>
            </tbody>
        </table>
        <center><input type="submit" value="Buscar"></center>
        <input type="hidden" name="hacerSubmit" value="1">
        <c:if test="${param.codentidadsalud != null}">
            <hr>
            <table border="0" align="center">
                <tr>
                    <td colspan="2">&nbsp;</td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                    <sql:setDataSource dataSource="jdbc/delphos" scope="page"/>
                    <sql:query var="r">
                        SELECT nombrehabilitacion
                        FROM entidadsalud
                        WHERE codentidadsalud='${param.codentidadsalud}'
                    </sql:query>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                        <span class="titulo1">${fila.nombrehabilitacion}</span>
                    </jsp2:forEach>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">&nbsp;</td>
                </tr>
                <tr>
            <sql:setDataSource dataSource="jdbc/delphos" scope="page"/>
            <sql:query var="r">
                SELECT COUNT(*) AS cantidadNovedades
                FROM novedadcampo n, encabezadoarchivo e
                WHERE  e.idencabezado=n.idencabezado AND e.codentidadsalud='${param.codentidadsalud}' AND n.codestadoregistro='SVAL'
            </sql:query>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                <c:choose>
                    <c:when test="${fila.cantidadNovedades > 0}">
                <td align="center">
                    <span class="titulo1">
                        <a href="NovedadesPoblacion.jsp?codentidadsalud=${param.codentidadsalud}">
                        <img src="../images/Novedad.gif" border="0" /><br />
                        Novedades: ${fila.cantidadNovedades}
                        </a>
                    </span>
                </td>
                    </c:when>
                    <c:otherwise>
                <td align="center">
                    <span class="titulo1">
                        <img src="../images/Novedad.gif" border="0"><br>
                        Novedades: ${fila.cantidadNovedades}
                    </span>
                </td>
                    </c:otherwise>
                </c:choose>
            </jsp2:forEach>
            <sql:setDataSource dataSource="jdbc/delphos" scope="page"/>
            <sql:query var="r">
                SELECT COUNT(*) AS cantidadInconsistencias
                FROM inconarchafil i, encabezadoarchivo e
                WHERE  e.idencabezado=i.idencabezado AND e.codentidadsalud='${param.codentidadsalud}' AND i.estado='SIN VALIDAR'
            </sql:query>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                <c:choose>
                    <c:when test="${fila.cantidadInconsistencias > 0}">
                <td align="center">
                    <span class="titulo1">
                        <a href="InconsistenciasPoblacion.jsp?codentidadsalud=${param.codentidadsalud}">
                            <img src="../images/Inconsistencia.gif" border="0"><br>
                            Inconsistencias: ${fila.cantidadInconsistencias}
                        </a>
                    </span>
                </td>
                    </c:when>
                    <c:otherwise>
                <td align="center">
                    <span class="titulo1">
                        <img src="../images/Inconsistencia.gif" border="0"><br>
                        Inconsistencias: ${fila.cantidadInconsistencias}
                    </span>
                </td>
                    </c:otherwise>
                </c:choose>
            </jsp2:forEach>
                </tr>
            </table>
        </c:if>
        </form>
    </td>
</tr>
<tr>
    <td colspan="3">
        <img src="../images/panel_06.gif" width="906" height="1" alt="">
    </td>
</tr>
<tr>
    <td height="42" colspan="3">
        <img src="../images/panel_07.gif" width="906" height="23" alt="">    </td>
</tr>
</table>
</center>
<!-- End ImageReady Slices -->
<script>
    configurar();
</script>
</body>
</html>










