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
        <form name="formulario" action="DetalleInconsistenciasEncabezado.jsp" method="post" onsubmit="validarSubmit();">
        <table border="0" align="center" width="600">
            <tbody>
                <tr>
                    <td colspan="4" align="center" class="titulo1">Inconsistencias Encabezado Archivo</td>
                </tr>
                <tr>
                    <td align="center" class="bgDescTablas">Id. Registro</td>
                    <td align="center" class="bgDescTablas">Campo</td>
                    <td align="center" class="bgDescTablas">Descripci&oacute;n</td>
                    <td align="center" class="bgDescTablas">C&oacute;digo Inconsistencia</td>
                </tr>
                <c:set var="sql">
                    SELECT i.idregistro, l.descripcion AS campoInconsistencia, t.descripcion AS descripcionInconsistencia,i.descripcion
                    FROM inconarchafil i, encabezadoarchivo e, listacamposarchivo l, tipoincarchivo t
                    WHERE e.idencabezado=i.idencabezado AND e.idencabezado=${param.idencabezado} AND i.estado='SIN VALIDAR' AND i.codcampoarchivo=l.codcampoarchivo AND t.codtipoincarch=i.codtipoincarch
                </c:set>
                <sql:setDataSource dataSource="jdbc/delphos" scope="page"/>
                <sql:query var="r">
                    ${sql}
                </sql:query>
                <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                <c:choose>
                    <c:when test='${contador.count % 2 == 0}'>
                        <c:set var="bgColor" value="#DDECFE"/>
                    </c:when>
                    <c:otherwise>
                        <c:set var="bgColor" value="#FFFFFF"/>
                    </c:otherwise>
                </c:choose>
                <tr>
                    <td bgcolor="${bgColor}" align="center" class="textoPequeno">${fila.idregistro}</td>
                    <td bgcolor="${bgColor}" class="textoPequeno">${fila.campoInconsistencia}</td>
                    <td bgcolor="${bgColor}" class="textoPequeno">${fila.descripcionInconsistencia}</td>
                    <td bgcolor="${bgColor}" class="textoPequeno">${fila.descripcion}</td>
                </jsp2:forEach>
                <tr>
                    <td colspan="4" align="center">&nbsp;</td>
                </tr>
                <%--<tr>
                    <td colspan="4" align="center" class="titulo1">${msj}</td>
                </tr>--%>
                <tr>
            <c:choose>
                <c:when test='${param.hacerSubmit == 1 && msj==""}'>
                    <td colspan="4" align="center" class="titulo1">Error al generar el Archivo Plano</td>
                </c:when>
                <c:when test='${param.hacerSubmit == 1 && msj!=""}'>
                    <td colspan="4" align="center" class="titulo1">${msj}</td>
                </c:when>
                <c:otherwise>
                    <td colspan="4" align="center" class="titulo1">&nbsp;</td>
                </c:otherwise>
            </c:choose>
                </tr>
                <tr>
                    <td colspan="4" align="center"><input type="submit" value="Generar Archivo Plano"></td>
                </tr>
            </tbody>
        </table>
        <input type="hidden" name="sql" value="${sql}">
        <input type="hidden" name="idencabezado" value="${param.idencabezado}">
        <input type="hidden" name="hacerSubmit" value="1">
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
    function validarSubmit()
    {
        if(confirm('Este proceso puede tardar varios minutos dependiendo de la cantidad de registros.\nDesea continuar?'))
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    
    configurar();
</script>
</body>
</html>