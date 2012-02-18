<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<%@ taglib prefix="jsp2" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%
            String incluir = "";
            pageContext.setAttribute("incluir", incluir);

            String filtrar = "";
            pageContext.setAttribute("filtrar", filtrar);
%>



<form action="../Mostrar" method="post" target="_blank" id="formulario">
    <div id="prueba"></div>
    <div id="drawer">
        <p>
            Salida
            <select name="tipoReporte">
                <option value="pdf">Pdf</option>
                <option value="excel" selected>Excel</option>
                <option value="plano">Archivo Plano</option>
            </select>
            <input type="submit" name="generar" value="Generar reporte" id="generar-reporte" />
            <input type="submit" name="borrar" value="Limpiar" onclick="reset(); return false" />
            <input type="submit" name="volver" value="Men&uacute; principal" onclick="javascript:history.go(-1); return false"/>

        </p>
    </div>
    <div id="mensajes-usuario" title="Delphos"></div>
    <div id="ajax-cargando" title="Cargando informaci&oacute;n">
        <img src="../images/ajax-loader.gif" alt="Cargando..."/><br />
        El servidor se encuentra ocupado <br /> espere un momento porfavor.
    </div>



    <div id="departamentos-municipios" title="Seleccion personalizada de municipios">

        <div id="barrios">
            
        </div>


    </div>
    <input type="hidden" name="sql" value="SELECT * FROM poblacion;" />
    <div id="accordion">
        <h3>
            <a href="#" class="titulo_prin">REPORTE DIN&Aacute;MICO POBLACIONAL</a>
        </h3>
        <div></div>

        <h3><a href="#" class="titulo_secun">Configuraci&oacute;n de variables para el reporte</a></h3>
        <div>

            <div id="accordion_variables">
                <h3><a href="#">Detalle Datos B&aacute;sicos</a></h3>
                <div>
                    <fieldset>
                        <legend></legend>
                        <div class="dato">
                            <strong> N&uacute;mero Documento</strong> <c:out value="${filtrar}" /> <input type="text" name="numeroidentafiliado" />
                        </div>
                        <div class="check">
                            <c:out value="${incluir}" /><input type="checkbox" name="seleccionados[]" value="numeroidentafiliado-java.lang.String-Identificacion" checked="checked" id="numeroidentafiliado"/>
                        </div>
                    </fieldset>
                    <br />
                    <fieldset>
                        <legend> <strong> Tipo identificaci&oacute;n</strong></legend>
                        <div class="dato">

                        </div>

                        <div class="check">
                            <c:out value="${incluir}" /><input type="checkbox" name="seleccionados[]" value="codtipoidentafiliado-java.lang.String-Tipo documento afiliado" checked="checked" id="codtipoidentafiliado" />
                        </div>

                        <table>

                            <tr>

                                <td colspan="2">
                                    <c:out value="${filtrar}" />
                                    <input type="checkbox" id="seleccionarElementos_tipoDocumento" title="tipodocumentoafiliado[]" /><strong>Seleccionar todos</strong>
                                </td>

                            </tr>
                            <sql:query var="r" sql="SELECT codtipoidentidad FROM tipoidentificacion" dataSource="jdbc/delphos" scope="page"/>
                            <tr>
                                <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">

                                    <td>
                                        <input type="checkbox" name="tipodocumentoafiliado[]" value="${fila.codtipoidentidad}" />${fila.codtipoidentidad}
                                    </td>

                                </jsp2:forEach>
                            </tr>
                        </table>

                    </fieldset>
                    <br />
                    <fieldset>
                        <legend></legend>
                        <div class="dato">
                            <strong> Primer Nombre</strong><c:out value="${filtrar}" /> <input type="text" name="primernombre" />
                        </div>
                        <div class="check">
                            <c:out value="${incluir}" /><input type="checkbox" name="seleccionados[]" value="primernombre-java.lang.String-Primer Nombre" />
                        </div>

                    </fieldset>
                    <br />
                    <fieldset>
                        <legend></legend>

                        <div class="dato">
                            <strong>Segundo Nombre</strong> <c:out value="${filtrar}" /> <input type="text" name="segundonombre" />
                        </div>
                        <div class="check">
                            <c:out value="${incluir}" /><input type="checkbox" name="seleccionados[]" value="segundonombre-java.lang.String-Segundo Nombre" />
                        </div>

                    </fieldset>
                    <br />
                    <fieldset>
                        <legend></legend>
                        <div class="dato">
                            <strong> Primer Apellido</strong> <c:out value="${filtrar}" /> <input type="text" name="primerapellido" />
                        </div>

                        <div class="check">
                            <c:out value="${incluir}" /><input type="checkbox" name="seleccionados[]" value="primerapellido-java.lang.String-Primer Apellido" />
                        </div>

                    </fieldset>
                    <br />
                    <fieldset>
                        <legend></legend>
                        <div class="dato">
                            <strong> Segundo Apellido</strong><c:out value="${filtrar}" /> <input type="text" name="segundoapellido" />
                        </div>
                        <div class="check">
                            <c:out value="${incluir}" /><input type="checkbox" name="seleccionados[]" value="segundoapellido-java.lang.String-Segundo Apellido" />
                        </div>

                    </fieldset>
                    <br />
                    <fieldset>
                        <legend> </legend>
                        <div class="dato">
                            <strong>Fecha Nacimiento</strong>
                            <c:out value="${filtrar}" /> <strong> Entre </strong><input type="text" name="fechanacimiento[]" class="fecha" size="10" />
                            <strong> y </strong>
                            <input type="text" name="fechanacimiento[]" class="fecha" size="10" />
                        </div>
                        <div class="check">
                            <c:out value="${incluir}" /><input type="checkbox" name="seleccionados[]" value="fechanacimiento-java.sql.Timestamp-Fecha Nacimiento" />
                        </div>

                    </fieldset>
                    <br/>
                    <fieldset>

                        <!-- Conserva el id de los municipios que se estan mostrando ...-->
                        <input type="hidden" name="departamandosmMostrados" id="departamandosmMostrados" />
                        <input type="hidden" name="pruebas" id="pruebas" />
                        
                        
                        <legend> <strong>C&oacute;digo Deparamento(s) y municipio(s) de Nacimiento</strong></legend>
                        <table>

                            <tr>
                                <td>
                                    <c:out value="${filtrar}" />
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <strong>Departamentos</strong> &nbsp;&nbsp;<c:out value="${incluir}" /><input type="checkbox" name="seleccionados[]" value="coddepartamentonac-java.math.BigDecimal-Depto Nacimiento" />
                                    <strong>Municipios</strong> &nbsp;&nbsp;<c:out value="${incluir}" /><input type="checkbox" name="seleccionados[]" value="codmunicipionac-java.math.BigDecimal-Municipio Nacimiento" /><br /><br />
                                    <sql:query var="r" sql="select coddepartamento, nombre from departamento order by nombre LIMIT 17 OFFSET 0" dataSource="jdbc/delphos" scope="page"/>
                                    <sql:query var="r2" sql="select coddepartamento, nombre from departamento order by nombre LIMIT  37 OFFSET 17" dataSource="jdbc/delphos" scope="page"/>
                                    <input type="hidden" id="municipiosNacimiento_barrios" alt="no" />
                                    <div class="tablas">
                                        <table>
                                            <tr>

                                                <td colspan="2"><input type="checkbox" class="seleccionarDepartamentos" title="departamentoNacimiento[]" alt="municipiosNacimiento[]" /><strong>Seleccionar Todos</strong></td>
                                            </tr>
                                            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                                                <tr><td></td>

                                                    <!-- El departamento -->
                                                    <td>
                                                        <input type="checkbox" name="departamentoNacimiento[]" id="${fila.coddepartamento}_municipiosNacimiento_chekear" alt="municipiosNacimiento[]" value="${fila.coddepartamento}" title="(${fila.coddepartamento}) ${fila.nombre}"/><strong>(${fila.coddepartamento})</strong> ${fila.nombre}
                                                    </td>
                                                </tr>

                                            </jsp2:forEach>


                                        </table>
                                    </div>
                                    <div class="tablas">
                                        <table>
                                            <jsp2:forEach items="${r2.rows}" var="fila2" varStatus="contador2">
                                                <tr><td></td>

                                                    <!-- El departamento -->
                                                    <td>
                                                        <input type="checkbox" name="coddepartamentonac[]" id="${fila2.coddepartamento}_municipiosNacimiento_chekear" alt="municipiosNacimiento[]" value="${fila2.coddepartamento}" title="(${fila2.coddepartamento}) ${fila2.nombre}"/><strong>(${fila2.coddepartamento})</strong> ${fila2.nombre}
                                                    </td>
                                                </tr>

                                            </jsp2:forEach>
                                        </table>
                                    </div>

                                </td>
                            </tr>

                        </table>
                    </fieldset>


                    <fieldset>
                        <legend><strong> Sexo</strong></legend>
                        <div class="dato">

                        </div>
                        <div class="check">
                            <input type="checkbox" name="seleccionados[]" value="codsexo-java.lang.String-Sexo" />
                        </div>

                        <table>

                            <tr>

                                <td colspan="2">
                                    <c:out value="${filtrar}" />
                                    <input type="checkbox" id="seleccionarElementos_Sexos" title="codsexo[]" /><strong>Seleccionar todos</strong>
                                </td>

                            </tr>
                            <sql:query var="r" sql="select codsexo, descripcion from sexo" dataSource="jdbc/delphos" scope="page"/>
                            <tr>
                                <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                                    <td>
                                        <input type="checkbox" name="codsexo[]" value="${fila.codsexo}" />${fila.descripcion}
                                    </td>

                                </jsp2:forEach>
                            </tr>
                        </table>
                    </fieldset>

                    <fieldset>
                        <legend><strong> Estado Civil</strong></legend>
                        <div class="dato">
                        </div>
                        <div class="check">
                            <input type="checkbox" name="seleccionados[]" value="codestadocivil-java.lang.String-Estado Civil" /><br /><br />
                        </div>

                        <table>

                            <tr>

                                <td colspan="2">
                                    <c:out value="${filtrar}" />
                                    <input type="checkbox" id="seleccionarElementos_EstadoCivil" title="codestadocivil[]" /><strong>Seleccionar todos</strong>
                                </td>

                            </tr>
                            <sql:query var="r" sql="select codestadocivil, descripcion from estadocivil" dataSource="jdbc/delphos" scope="page"/>
                            <tr>
                                <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">

                                    <td>
                                        <input type="checkbox" name="codestadocivil[]" value="${fila.codestadocivil}" />${fila.descripcion}
                                    </td>

                                </jsp2:forEach>
                            </tr>
                        </table>
                    </fieldset>
                </div>
                <h3><a href="#">Residencia</a></h3>
                <div>
                    <fieldset>
                        <legend> <strong>C&oacute;digo Deparamento(s) y municipio(s) de Residencia</strong></legend>
                        <table>

                            <tr>
                                <td>
                                    <c:out value="${filtrar}" />
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <strong>Departamentos</strong> &nbsp;&nbsp;<c:out value="${incluir}" /><input type="checkbox" name="seleccionados[]" value="coddepartamentore-java.math.BigDecimal-Depto Residencia" />
                                    <strong>Municipios</strong> &nbsp;&nbsp;<c:out value="${incluir}" /><input type="checkbox" name="seleccionados[]" value="codmunicipiore-java.math.BigDecimal-Muni Residencia" /><br /><br />
                                    <sql:query var="r" sql="select coddepartamento, nombre from departamento order by nombre LIMIT 17 OFFSET 0" dataSource="jdbc/delphos" scope="page"/>
                                    <sql:query var="r2" sql="select coddepartamento, nombre from departamento order by nombre LIMIT  37 OFFSET 17" dataSource="jdbc/delphos" scope="page"/>
                                    <input type="hidden" id="municipiosResidencia_barrios" alt="si" />
                                    <div class="tablas">
                                        <table>
                                            <tr>

                                                <td colspan="2"><input type="checkbox" class="seleccionarDepartamentos" title="departamentoResidencia[]" alt="municipiosResidencia[]" /><strong>Seleccionar Todos</strong></td>
                                            </tr>
                                            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                                                <tr><td></td>

                                                    <!-- El departamento -->
                                                    <td>
                                                        <input type="checkbox"   name="departamentoResidencia[]" id="${fila.coddepartamento}_municipiosResidencia_chekear" alt="municipiosResidencia[]" value="${fila.coddepartamento}" title="(${fila.coddepartamento}) ${fila.nombre}"/><strong>(${fila.coddepartamento})</strong> ${fila.nombre}
                                                    </td>
                                                </tr>

                                            </jsp2:forEach>


                                        </table>
                                    </div>
                                    <div class="tablas">
                                        <table>
                                            <jsp2:forEach items="${r2.rows}" var="fila2" varStatus="contador2">
                                                <tr><td></td>

                                                    <!-- El departamento -->
                                                    <td>
                                                        <input type="checkbox" name="departamentoResidencia[]" id="${fila2.coddepartamento}_municipiosResidencia_chekear" alt="municipiosResidencia[]" value="${fila2.coddepartamento}" title="(${fila2.coddepartamento}) ${fila2.nombre}"/><strong>(${fila2.coddepartamento})</strong> ${fila2.nombre}
                                                    </td>
                                                </tr>

                                            </jsp2:forEach>
                                        </table>
                                    </div>

                                </td>
                            </tr>

                        </table>
                    </fieldset>


                    <fieldset>
                        <legend><strong> Zona geogr&aacute;fica</strong></legend>
                        <div class="dato">

                        </div>
                        <div class="check">
                            <input type="checkbox" name="seleccionados[]" value="codzonageo-java.lang.String-Zona geográfica" />
                        </div>

                        <table>

                            <tr>

                                <td colspan="2">
                                    <c:out value="${filtrar}" />
                                    <input type="checkbox" id="seleccionarElementos_Zonas" title="codzonageo[]" /><strong>Seleccionar todos</strong>
                                </td>

                            </tr>
                            <sql:query var="r" sql="select codzonageo, descripcion from zonageografica" dataSource="jdbc/delphos" scope="page"/>
                            <tr>
                                <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                                    <td>
                                        <input type="checkbox" name="codzonageo[]" value="${fila.codzonageo}" />${fila.descripcion}
                                    </td>

                                </jsp2:forEach>
                            </tr>
                        </table>
                    </fieldset>
                </div>

            </div>


        </div>

    </div>
</form>
