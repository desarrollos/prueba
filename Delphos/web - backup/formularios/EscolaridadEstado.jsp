<%@ include file="config.jsp" %>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <jsp:include page="scripts.jsp"> 	
            <jsp:param name="js" value="<%= request.getServletPath() %>" />
        </jsp:include>
    </head>
    <body>
        <table>       
<tr>
 	<td></td>
	<td></td>
 </tr>
<tr>
 	<td> <input type="text" id="escestcodigo_escolaridadestado" name="escestcodigo_escolaridadestado"/></td>
	<td> <input type="text" id="escescdescri_escolaridadestado" name="escescdescri_escolaridadestado"/></td>
 </tr>
 </table>
    </body>
</html>
