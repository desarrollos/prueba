<%--
    Document   : index
    Created on : 26-jun-2010, 14:47:11
    Author     : John J.S
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="Reportes.*" %>
<%@page import="java.io.*"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="net.sf.jasperreports.engine.*"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>

<form action="../Mostrar" method="post">
<input type="hidden" name="sql" value="SELECT * FROM poblacion;" />
<fieldset>
    <legend>Detalle Datos B&aacute;sicos</legend>
    <table>
        <tr>
            <td>N&uacute;mero Documento Afiliado</td><td><input type="checkbox" name="seleccionados[]" value="numeroidentafiliado-java.lang.String-Numero Documento Afiliado" /></td>
        </tr>
        <tr>
            <td>Primer Nombre del Afiliado</td><td><input type="checkbox" name="seleccionados[]" value="primernombre-java.lang.String-Primer Nombre del Afiliado" /></td>
        </tr>
        <tr>
            <td>Segundo Nombre del Afiliado</td><td><input type="checkbox" name="seleccionados[]" value="segundonombre-java.lang.String-Segundo Nombre del Afiliado" /></td>
        </tr>
        <tr>
            <td>Primer Apellido del Afiliado</td><td><input type="checkbox" name="seleccionados[]" value="primerapellido-java.lang.String-Primer Apellido del Afiliado" /></td>
        </tr>
        <tr>
            <td>Segundo Apellido del Afiliado</td><td><input type="checkbox" name="seleccionados[]" value="segundoapellido-java.lang.String-Segundo Apellido del Afiliado" /></td>
        </tr>
        <tr>
            <td>Fecha Nacimiento del Afiliado</td><td><input type="checkbox" name="seleccionados[]" value="fechanacimiento-java.sql.Date-Fecha Nacimiento del Afiliado" /></td>
        </tr>
        <tr>
            <td>C&oacute;digo Deparamento(s) de Nacimiento</td><td><input type="checkbox" name="seleccionados[]" value="coddepartamentonac-java.math.BigDecimal-Codigo Deparamento de Nacimiento" /></td>
        </tr>
        <tr>
            <td>C&oacute;digo Municipio(s) de Nacimiento</td><td><input type="checkbox" name="seleccionados[]" value="codmunicipionac-java.math.BigDecimal-Código Municipio de Nacimiento" /></td>
        </tr>
        <tr>
            <td>C&oacute;digo del Sexo</td><td><input type="checkbox" name="seleccionados[]" value="codsexo-java.lang.String-Codigo del Sexo" /></td>
        </tr>
        <tr>
            <td>C&oacute;digo del estado civil</td><td><input type="checkbox" name="seleccionados[]" value="codestadocivil-java.lang.String-Codigo del estado civil" /></td>
        </tr>

    </table>
</fieldset>

<fieldset>
    <legend>Residencia</legend>
    <table>
        <tr>
            <td>C&oacute;digo Deparamento(s) Residencia</td><td><input type="checkbox" name="seleccionados[]" value="coddepartamentore-java.math.BigDecimal-Codigo Deparamento Residencia" /></td>
        </tr>
        <tr>
            <td>C&oacute;digo Municipio(s) Residencia</td><td><input type="checkbox" name="seleccionados[]" value="codmunicipiore-java.math.BigDecima-Código Municipio Residencia" /></td>
        </tr>
        <tr>
            <td>C&oacute;digo de la zona geografia (U)rbana (R)ural Residencia</td><td><input type="checkbox" name="seleccionados[]" value="codzonageo-java.lang.String-Codigo de la zona geografia (U)rbana (R)ural Residencia" /></td>
        </tr>
        <tr>
            <td>C&oacute;digo Sector Residencia</td><td><input type="checkbox" name="seleccionados[]" value="codsubgrupo-java.math.BigDecimal-Codigo Sector Residencia" /></td>
        </tr>
        <tr>
            <td>C&oacute;digo Barrio Residencia</td><td><input type="checkbox" name="seleccionados[]" value="barriores-java.math.BigDecimal-Codigo Barrio Residencia" /></td>
        </tr>
        <tr>
            <td>C&oacute;digo del sector geografico</td><td><input type="checkbox" name="seleccionados[]" value="codsectorgeografico-java.lang.String-Codigo del sector geografico" /></td>
        </tr>
    </table>
</fieldset>

<fieldset>
    <legend>Estrato</legend>
    <table>
        <tr>
            <td>C&oacute;digo del estrato socioeconomico</td><td><input type="checkbox" name="seleccionados[]" value="codestrato-java.math.BigDecimal-Código del Estrato" /></td>
        </tr>
        <tr>
            <td>C&oacute;digo Nivel Socioeconomico</td><td><input type="checkbox" name="seleccionados[]" value="codnivelclasificacion-java.math.BigDecima-Código Nivel Socioeconomico" /></td>
        </tr>
    </table>
</fieldset>

<fieldset>
    <legend>Grupo Poblaci&oacute;n</legend>
    <table>
        <tr>
            <td>C&oacute;digo del grupo poblacional</td><td><input type="checkbox" name="seleccionados[]" value="codgrupopoblacion-java.math.BigDecimal-Código del grupo poblacional" /></td>
        </tr>
        <tr>
            <td>C&oacute;digo del grupo etnico</td><td><input type="checkbox" name="seleccionados[]" value="codetnia-java.lang.String-Código del grupo etnico" /></td>
        </tr>
        <tr>
            <td>C&oacute;digo del tipo de poblaci&oacute;n</td><td><input type="checkbox" name="seleccionados[]" value="codtipopoblacion-java.lang.String-Código del tipo de poblacion" /></td>
        </tr>
        <tr>
            <td>C&oacute;digo del estado del usuario poblaci&oacute;n</td><td><input type="checkbox" name="seleccionados[]" value="codestadousuapoblac-java.lang.String-Código del estado del usuario poblacion" /></td>
        </tr>
    </table>
</fieldset>

<fieldset>
    <legend>Afiliaci&oacute;n</legend>
    <table>
        <tr>
            <td>C&oacute;digo del regimen</td><td><input type="checkbox" name="seleccionados[]" value="codregimenctoppal-java.lang.String-Codigo del regimen" /></td>
        </tr>
        <tr>
            <td>C&oacute;digo de la E.A.P.B.</td><td><input type="checkbox" name="seleccionados[]" value="codentidadsaludctoppal-java.lang.String-Codigo de la E.A.P.B." /></td>
        </tr>
        <tr>
            <td>C&oacute;digo del contrato</td><td><input type="checkbox" name="seleccionados[]" value="codcontratoppal-java.lang.String-Codigo del contrato" /></td>
        </tr>
        <tr>
            <td>C&oacute;digo del regimen</td><td><input type="checkbox" name="seleccionados[]" value="codregimencto2-java.lang.String-Codigo del regimen" /></td>
        </tr>
        <tr>
            <td>C&oacute;digo de la E.A.P.B.</td><td><input type="checkbox" name="seleccionados[]" value="codentidadsaludcto2-java.lang.String-Codigo de la E.A.P.B." /></td>
        </tr>
        <tr>
            <td>C&oacute;digo del contrato</td><td><input type="checkbox" name="seleccionados[]" value="codcontrato2-java.lang.String-Codigo del contrato" /></td>
        </tr>
        <tr>
            <td>C&oacute;digo del r&eacute;gimen</td><td><input type="checkbox" name="seleccionados[]" value="codregimencto3-java.lang.String-Codigo del regimen" /></td>
        </tr>
        <tr>
            <td>C&oacute;digo de la E.A.P.B.</td><td><input type="checkbox" name="seleccionados[]" value="codentidadsaludcto3-java.lang.String-Codigo de la E.A.P.B." /></td>
        </tr>
        <tr>
            <td>C&oacute;digo del contrato</td><td><input type="checkbox" name="seleccionados[]" value="codcontrato3-java.lang.String-Codigo del contrato" /></td>
        </tr>
        <tr>
            <td>C&oacute;digo Tipo Afiliado</td><td><input type="checkbox" name="seleccionados[]" value="codtipoafiliado-java.lang.String-Código Tipo Afiliado" /></td>
        </tr>
        <tr>
            <td>C&oacute;digo del estado de la afiliaci&oacute;n</td><td><input type="checkbox" name="seleccionados[]" value="codestadoafil-java.lang.String-Codigo del estado de la afiliacion" /></td>
        </tr>
        <tr>
            <td>El afiliado esta carnetizado? (S/N)</td><td><input type="checkbox" name="seleccionados[]" value="afiliadocarnetizado-java.lang.String-El afiliado esta carnetizado? (S/N)" /></td>
        </tr>
        <tr>
            <td>El afiliado esta en BDUA? (S/N)</td><td><input type="checkbox" name="seleccionados[]" value="afiliadoenbdua-java.lang.String-El afiliado esta en BDUA? (S/N)" /></td>
        </tr>
        <tr>
            <td>C&oacute;digo de la modalidad del subsidio</td><td><input type="checkbox" name="seleccionados[]" value="codmodalidadsubsidio-java.lang.String-Codigo de la modalidad del subsidio" /></td>
        </tr>
    </table>
</fieldset>
        <tr>
            <td colspan="2" align="right"><input type="submit" name="Enviar" value="Enviar" /></td>
        </tr>
</form>
    </body>
</html>
