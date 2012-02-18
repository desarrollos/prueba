
<%
// Para que el contenido se ha dinamico, la variable empresa, controlara el contenido que se
// va a mostrar, si empresa = "delphos" , cargaria un contenid por defecto.

// Si queremos agregar contenido de otra empresa, dentro del directorio menu_derecho/
// creamos un .jsp con el nombre de la empresa por ejemplo delphos.jsp y alli incluimos el contenido

// 
String empresa = "Delphos";
pageContext.setAttribute("empresa", empresa);
String mostrar = request.getParameter("mostrar");
// Ruta general a todas las empreas
pageContext.setAttribute("ruta","../menu_derecho/empresas" );
if( empresa.equals("Delphos") ) {
        %>
        <jsp:include page="${ruta}/${empresa}.jsp">
                <jsp:param name="contenido" value="${param.mostrar}" />
            </jsp:include>
        <%
}
/*
if( empresa.equals("otra.empresa.aqui") ) {
    La idea es igual para todas las empresas que se agreguen

}
*/

%>
