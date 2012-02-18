<%@taglib prefix="c" uri="http://java.sun.com/jstl/core"  %>
<%@page contentType="text/html" pageEncoding="windows-1250"%>
<%@page import="reportesTipos.tiposString" %>
<form action="../Mostrar?tipoReporte=excel" method="post" name="tablasBuscar" target="_blank">
<input type="hidden" name="sql" value="SELECT * FROM ${param.tabla} ${param.where};" />

<%
    int n = 0;
    int tam = 0;
%>
<c:forTokens items="${param.campos}" var="actual" varStatus="posicion" delims=",">
<%
    tam++;
%>
</c:forTokens>


<c:forTokens items="${param.campos}" var="actual" varStatus="posicion" delims=",">
<!-- Tipos para jasperReports -->
<%
    String tabla = request.getParameter("tabla");
    tiposString tipoIns = new tiposString();
    String tipo = tipoIns.tipoCampo( tabla , n, tam);
    pageContext.setAttribute("tipo", tipo);
    n++;
%>

<input type="hidden" name="seleccionados[]" value="${actual}-${tipo}-${actual}" />
</c:forTokens>


</form>


