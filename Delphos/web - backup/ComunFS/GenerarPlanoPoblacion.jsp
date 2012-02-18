<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<%@ taglib prefix="jsp2" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head><script type="text/javascript" src="../js/jquery/jquery.js"></script>
<title>:: DELPHOS ::</title>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
        <link rel="stylesheet" type="text/css" media="all" href="../css/delphos.css" />
        <link rel="stylesheet" type="text/css" media="all" href="../js/jsCalendar/skins/aqua/theme.css" title="Aqua" />
        <link href="../images/favicon.ico" rel="Shortcut Icon" type="image/x-icon" />
        <script type="text/javascript" src="../js/treeview/ua.js"></script>
        <script type="text/javascript" src="../js/treeview/ftiens4.js"></script>
        <script type="text/javascript" src="../js/treeview/demoFramelessNodes.js"></script>
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
        <form name="formulario" action="GenerarPlanoPoblacion.jsp" method="post">
        <table border="0" align="center" width="600">
            <tbody>
                <tr>
                    <td colspan="2" align="center" class="titulo1">Inconsistencias / Novedades</td>
                </tr>
                <tr>
                    <td align="left" class="bgDescTablas">Codigo Entidad Salud</td>
                    <td>
                        <select name="codregimen" id="codregimen">
                            <option value="">---------- Seleccione El Regimen ----------</option>
                            <sql:query var="r" sql="SELECT codregimen, descripcion FROM regimen" dataSource="jdbc/delphos" scope="page"/>
                            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                                <option value="${fila.codregimen}">${fila.descripcion}</option>
                            </jsp2:forEach>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">&nbsp;</td>
                </tr>
                <c:choose>
                    <c:when test='${param.hacerSubmit == 1 && msj==""}'>
                <td colspan="2" align="center" class="titulo1">Error al generar el Archivo Plano</td>
                    </c:when>
                    <c:when test='${param.hacerSubmit == 1 && msj!=""}'>
                <td colspan="2" align="center" class="titulo1">${msj}</td>
                    </c:when>
                    <c:otherwise>
                <td colspan="2" align="center" class="titulo1">&nbsp;</td>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
        <center><input type="submit" value="Generar Archivo Plano"></center>
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
</body>
</html>










