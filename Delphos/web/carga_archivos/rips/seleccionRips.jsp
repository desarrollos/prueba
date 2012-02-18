<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<%@ taglib prefix="jsp2" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>

<table>
    <sql:query var="r" sql="SELECT codtiporips, descripcion FROM tiporips WHERE upper(obligatorio)='S' AND (codtiporips = 'AF' OR codtiporips = 'US') ORDER BY codtiporips DESC" dataSource="jdbc/delphos" scope="page"/>
    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">

        <tr>
            <td>${fila.descripcion}  </td><td><input type="checkbox" name="ripsSeleccionados[]" alt="${fila.codtiporips}" /></td>
        </tr>
    </jsp2:forEach>


        
      <sql:query var="r" sql="SELECT codtiporips, descripcion FROM tiporips WHERE obligatorio='n' AND (codtiporips != 'CT' AND codtiporips != 'AD' )" dataSource="jdbc/delphos" scope="page"/>
    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
        <tr id="capa_${fila.codtiporips}">
            <td>${fila.descripcion} </td><td><input type="checkbox" name="ripsSeleccionados[]" alt="${fila.codtiporips}" /></td>
        </tr>
    </jsp2:forEach>

</table>