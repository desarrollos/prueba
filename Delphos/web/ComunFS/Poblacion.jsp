<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<%@ taglib prefix="jsp2" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<%
clases.VerificarUsuarioSistema v;
v = new clases.VerificarUsuarioSistema(request,response);
%>
<head><script type="text/javascript" src="../js/jquery/jquery.js"></script>
        <title>:: DELPHOS ::</title>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
        <link rel="stylesheet" type="text/css" media="all" href="../css/delphos.css" />
        <link rel="stylesheet" type="text/css" media="all" href="../js/jsCalendar/skins/aqua/theme.css" title="Aqua" />
        <link href="../images/favicon.ico" rel="Shortcut Icon" type="image/x-icon" />

       <link rel="stylesheet" type="text/css" media="all" href="../poblacion/css.css" />
        
       <script type="text/javascript" src="../poblacion/poblacion.js"></script>

        
</head>
<body bgcolor="#FFFFFF">
<center>
<table id="Table_01" width="906" style="height: 780; border: 0px" cellpadding="0" cellspacing="0">
<tr>
    <td colspan="3">
        <jsp:include page="../header.jsp" />
    </td>
</tr>
<tr>
    <td width="234" height="529" valign="top" style="background: url('../images/back.png')">
        <table cellpadding="0" cellspacing="0">
            <tr>
                <td align="left" valign="top">
                    <jsp:include page="../menu.jsp" />
                </td>
            </tr>
        </table>
    </td>
    <td>


        <div id="grupo_1">
	<h3><a href="#">Grupo 1</a></h3>
	<div>
            <p>sdsad</p>
        </div>
        </div><br />

        <div id="grupo_2">
	<h3><a href="#">Grupo 2</a></h3>
	<div>
            <p>sdsad</p>
        </div>
        </div><br />
        
        <div id="grupo_3">
	<h3><a href="#">Grupo 3</a></h3>
	<div>
            <p>sdsad</p>
        </div>
        </div>


    </td>
</tr>
<tr>
    <td>
        <jsp:include page="../footer.jsp" />    </td>
</tr>
</table>
</center>

</body>
</html>