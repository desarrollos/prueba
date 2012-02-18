<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<%@ taglib prefix="jsp2" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
        <title>:: DELPHOS ::</title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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
                //Calendar.setup({inputField : "subsfechinic",ifFormat : "%d/%m/%Y",button : "botonSubsfechinic"});
		//Calendar.setup({inputField : "subsfechfina",ifFormat : "%d/%m/%Y",button : "botonSubsfechfina"});
            }
            
            var arrayCamposTexto        = new Array();
            var arrayCamposNumero       = new Array();
            var arrayCamposFechas       = new Array();
            var arrayCamposHoras        = null;
            var arrayCamposDesplegables = new Array();
	</script>
</head>
<body bgcolor="#FFFFFF">
${msj}
<!-- ImageReady Slices (panel.psd) -->

<center>
<table id="Table_01" width="906" style="height: 780; border: 0px" cellpadding="0" cellspacing="0">
<tr>
    <td colspan="3">
        <img src="../images/cabezote.png" width="906" height="150" alt="" />
    </td>
</tr>
<tr>
                    <td colspan="3" width="906" height="16" style="background: url('../images/panel_02.gif')" align="right">
                        <span class="textoPequeno"><%=request.getSession().getAttribute("nombre")%> <%=request.getSession().getAttribute("apellido")%></span><a href="../logout.jsp"><img src="../images/log_out.png" border="0" alt="Cerrar sesion" width="20" height="20" /></a>
                    </td>
</tr>
<tr>
    <td style="background: url('../images/back.png')" width="234" valign="top">
        <table cellpadding="0" cellspacing="0">
            <tr>
                <jsp:include page="../menu.jsp" />
            </tr>
        </table>
    </td>
    
    <td valign="top">
        
        <div class="contenidoweb">
            <jsp:include page="../menu_derecho/contenido.jsp">
                <jsp:param name="mostrar" value="miempresa" />
            </jsp:include>
        </div>
        
    </td>
    
<jsp:include page="../menu_derecho/menu_contenedor.jsp" />
</tr>
<tr>
    <td colspan="3">
        <img src="../images/panel_06.gif" width="906" height="1" alt="">
    </td>
</tr>
<tr>
    <td colspan="3">
        <img src="../images/panel_07.gif" width="906" height="23" alt="">

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