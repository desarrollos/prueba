<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<%@ taglib prefix="jsp2" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>

<%
clases.VerificarUsuarioSistema v;
v = new clases.VerificarUsuarioSistema(request,response);

%>

<html>
    <head>
        <title>:: DELPHOS ::</title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <link rel="stylesheet" type="text/css" media="all" href="delphos.css"/>
        <link href="images/favicon.ico" rel="Shortcut Icon" type="image/x-icon"/>
        <script type="text/javascript" src="js/jquery/jquery.js"></script>

        <script>
            $(document).ready( function(  ){
                $("#login").focus().select();
                
                $("#password, #login").keypress( function( e ){
                    if( e.keyCode==13 ) {
                        if( $("password").val() != '' &&  $("#login").val() != '' )
                        {
                                submit();
                        }
                    }
                } )
            } );
        </script>
    </head>
    <c:choose>
        <c:when test="${param.errorLogin == 1}">
            <body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  onload="javascript:alert('Inicie sesion con una cuenta valida para ingresar al modulo seleccionado');">
            </c:when>
            <c:otherwise>
            <body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
            </c:otherwise>
        </c:choose>

        <!-- ImageReady Slices (panel.psd) -->
    <center>
        <table id="Table_01" width="906" height="772" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td colspan="3" valign="bottom">
                    <img src="images/panel_01.gif" width="906" height="218" alt="">
                </td>
            </tr>
            <tr>
                <td colspan="3" valign="top">
                    <img src="images/panel_02.gif" width="906" height="16" alt="">
                </td>
            </tr>
            <tr>
                <td>
                    <table width="906" border="0" cellpadding="0" cellspacing="0">
                        <tr height="522" background="images/bglogin.jpg">
                            <td>
                                <form method="post" action="index.jsp" name="formulario">
                                    <table border="0" align="center">
                                        <tr>
                                            <td><span class="titulo2">Usuario</span></td>
                                            <td><input type="text" name="login" id="login" value="root"></td>
                                        </tr>
                                        <tr>                                
                                            <td><span class="titulo2">Contrase&ntilde;a</span></td>
                                            <td><input type="password" name="password" id="password" value="123456"></td>
                                        </tr>                            
                                        <tr> 
                                            <td colspan="6" align="center">&nbsp;</td>
                                        </tr>
                                        <tr> 
                                            <td colspan="6" align="center"><img border="0" src="images/login.png" onmouseover="this.src='images/login2.png'" onmouseout="this.src='images/login.png'" onclick="submit();" /></td>
                                        </tr>
                                    </table>
                                    <input type="hidden" name="hacerSubmit" value="1">
                                </form>
                            </td> 
                        </tr>
                    </table>
                </td> 
            </tr>
            <tr>
                <td colspan="3" valign="top">
                    <table background="images/panel_02.gif"  width="906" height="16" cellpadding="0" cellspacing="0">
                        <tr nowrap="nowrap" >
                            <td align="center"><font face="Verdana, Arial, Helvetica, sans-serif" color="#FFFFFF" size="1+">Copyright © 2009 DELPHOS. Todos los derechos reservados.</font></td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </center>
    <!-- End ImageReady Slices -->
</body>
</html>
<script>
function submit()
{
    document.formulario.submit();
}
</script>

<%if(request.getSession().getAttribute("login") != null)
{
    String errorLogin="";
    if(request.getParameter("errorLogin") != null)
        response.sendRedirect("FamiliasEnAccion/index.jsp?errorLogin="+request.getParameter("errorLogin"));
    else{
        int puerto = request.getServerPort();
        

    //    if(v.aCambiadoClave()){
            response.sendRedirect( (puerto == 8080 ? "ComunFS/index.jsp" : "ComunFS/index.jsp")  );
     //   }else{
       //     response.sendRedirect( "formularios/Usuarios.jsp"  );
       // }


        


    }
%>
<script>window.open("bienvenida.jsp","_blank","toolbar=NO,directories= NO,menubar=NO,status=NO,LOCATION=NO,SCROLLBARS=NO, RESIZABLE=YES");</script>
<script>window.close();</script>
<%}
else
{
    if(request.getAttribute("errorLogin") != null)
    {%>
<center><font face="Arial, Helvetica, sans-serif" color="red" size="4"><%=request.getAttribute("errorLogin")%></font></center>
    <%}
}%>
