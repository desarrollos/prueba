<!--
	Familias en accion
-->
<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<%@ taglib prefix="jsp2" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head><script type="text/javascript" src="../js/jquery/jquery.js"></script>
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
        
        <script type="text/javascript" src="../js/pestanas/animatedcollapse.js"></script>
        <script type="text/javascript" src="../js/validaciones/validador.js"></script>
        <script type="text/javascript" src="../js/validaciones/validadorkp.js"></script>
        <script type="text/javascript" src="../js/validaciones/validadorcontrol.js"></script>
        <script type="text/javascript">
           
            //totalidad de elementos en el form
            var cajas = null;
            var combos = null;
			
            var arrayNonulos               	= null;
            var arrayNumerosEnteros        	= null;
            var arrayCombos               	= null;
            var arrayCadenasANCod          	= null;
            var arrayCadenasA              	= null;
            var arrayComentarios           	= null;
            var arrayNumerosDoubles        	= null;
</script>
</head>
<body bgcolor="#FFFFFF" onLoad="borrarMensaje(cajas[0]);">
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
                    <jsp:include page="../menu.jsp" />
                </td>
            </tr>
        </table>
    </td>
    <td valign="top">
         <center>
                <div style="margin-left: -5px; padding-left: 20px; text-align: left; background: url('../images/panel_02.gif'); width: 665">
                    <span class="pestana" onclick="animatedcollapse.show('layerDatosFamilia')">Datos Familia</span>
                    | <span class="pestana" onclick="animatedcollapse.show('layerTitularFamilia')">Titular Familia</span>
                    | <span class="pestana" onclick="animatedcollapse.show('layerBeneficiario')">Beneficiarios</span>
                    |
                </div>

                
                <form name="formulario" method="post" action="Vinculacion.jsp">
                    <div id="layerDatosFamilia"><%@include file="Vinculacion/DatosFamilia.jspf" %></div>
                    <div id="layerTitularFamilia" style="display:none"><%@include file="Vinculacion/Titular.jspf" %></div>
                    <div id="layerBeneficiario" style="display:none"><%@include file="Vinculacion/Beneficiarios.jspf" %></div>
                    <center>
                        <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="1">
                        <input type="submit" value="Registrar" onclick="hacerSubmit.value=1">
                        <input type="submit" value="Editar" onclick="hacerSubmit.value=2">
                        <input type="submit" value="Borrar" onclick="hacerSubmit.value=3">
                    </center>
                </form>
    </td>
</tr>
<tr>
    <td colspan="3">
        <img src="../images/panel_06.gif" width="906" height="1" alt="" />
    </td>
</tr>
<tr>
    <td colspan="3">
        <img src="../images/panel_07.gif" width="906" height="23" alt="" />
    </td>
</tr>
</table>
</center>
<!-- End ImageReady Slices -->
        <script type="text/javascript">
			configurar();
		</script>
</body>
</html>
