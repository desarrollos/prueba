
<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<%@ taglib prefix="jsp2" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%
clases.VerificarUsuarioSistema v;
v = new clases.VerificarUsuarioSistema(request,response);

%>

<c:if test="${param.errorLogin == 1}">
    <script>alert('Su cuenta no tiene permiso para esta accion');</script>
</c:if>

<html>
    <head><script type="text/javascript" src="../js/jquery/jquery.js"></script>
        <title>:: DELPHOS ::</title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <link rel="stylesheet" type="text/css" media="all" href="../css/delphos.css" />
        <link rel="stylesheet" type="text/css" media="all" href="../js/jsCalendar/skins/aqua/theme.css" title="Aqua" />
        <link href="../images/favicon.ico" rel="Shortcut Icon" type="image/x-icon" />

        <script type="text/javascript" src="../js/jsCalendar/calendar.js"></script>
        <script type="text/javascript" src="../js/jsCalendar/lang/calendar-es.js"></script>
        <script type="text/javascript" src="../js/jsCalendar/calendar-setup.js"></script>
        
        
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
                            <img src="../images/bglogin2.jpg" style="width:500px;" />
                            
                            <div id="contenidoAjax"></div>
                        </center>

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