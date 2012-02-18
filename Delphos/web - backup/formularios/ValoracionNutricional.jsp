<%@ include file="config.jsp" %>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <jsp:include page="scripts.jsp"> 	
            <jsp:param name="js" value="<%= request.getServletPath() %>" />
        </jsp:include>
    </head>
    <body>
        <div id="ajax" class="c1"></div>
        <div id="mensaje" class="c1"></div>
        <form><input type="hidden" id="respuestaAjax" /> <!-- Aqui saldra el flexigrid para la tabla --></form>
        <input type="hidden" name="servletActivo" id="servletActivo"/>
        <div id="tablaContenedor"></div>
        <form action="" method="post"><input type="hidden" id="combo" /> <input type="hidden" id="nombreFormulario" value="Valoracion Nutricional" /> <input type="hidden" id="servlet" value="ValoracionNutricional" /></form>
        <div id="dialog" class="c1">
            <div class="encabezado"></div>
            <div class="titulo">VALORACION NUTRICIONAL</div>
            <br />
            <div>
                <form id="ValoracionNutricional" method="post" accept-charset="utf-8" name="ValoracionNutricional"><input type="hidden" id="codigo" name="codigo" />
                    <input type="hidden" name="accion" id="accion" value="" />
                    <div class="boton"><input type="submit" value="Mostrar Valoracion Nutricional " onclick="return tabla(flexiNutricionValoracion, 'Nutricion Valoracion', '' )" />
                        <input type="submit" id="accion1" value="Registrar" onclick="accionFormulario('ValoracionNutricional', 'Registrar', ''); return false" />
                        <input type="reset" id="resetFormulario1" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" />
                        <input type="submit" id="actualizar1" value="Actualizar" onclick="accionFormulario('ValoracionNutricional', 'Actualizar', ''); return false" class="c2" />
                        <input type="submit" id="volver_registro1" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>
                    <table>

                        <tr>
                            <td>Codigo Valoracion</td>
                            <td>Fecha Atencion</td>
                            <td>Tipo Identificacion</td>
                            <td>Numero  Identificacion</td>
                        </tr>
                        <tr>
                            <td> <input type="text" id="nutridregist_nutricionvaloracion" name="nutridregist_nutricionvaloracion"/></td>
                            <td><input type="text" id="_fecha_nutrfechatennutrfechaten_nutricionvaloracion" name="nutrfechatennutrfechaten_nutricionvaloracion" value="" maxlength="19" readonly="readonly" /></td>
                            <td> <select  id="codtipoidentidad_nutricionvaloracion" name="codtipoidentidad_nutricionvaloracion" onfocus="tabla(flexiTipoIdentificacion, 'Tipo Identificacion', 'codtipoidentidad_nutricionvaloracion' )" onclick="tabla(flexiTipoIdentificacion, 'Tipo Identificacion', 'codtipoidentidad_nutricionvaloracion' )"></select></td>
                            <td> <input type="text" id="nutridentifi_nutricionvaloracion" name="nutridentifi_nutricionvaloracion"/></td>
                        </tr>
                        <tr>
                            <td>Cantidad</td>
                            <td>Finalidad Consulta </td>
                            <td>Dx Principal</td>
                            <td>Dx Relacionado 1</td>
                        </tr>
                        <tr>
                            <td> <input type="text" id="nutrcantidad_nutricionvaloracion" name="nutrcantidad_nutricionvaloracion"/></td>
                            <td> <select  id="codfinalidadconsulta_nutricionvaloracion" name="codfinalidadconsulta_nutricionvaloracion" onfocus="tabla(flexiFinalidadConsulta, 'Finalidad Consulta ', 'codfinalidadconsulta_nutricionvaloracion' )" onclick="tabla(flexiFinalidadConsulta, 'Finalidad Consulta ', 'codfinalidadconsulta_nutricionvaloracion' )"></select></td>
                            <td> <select  id="coddiagnosticopr_nutricionvaloracion" name="coddiagnosticopr_nutricionvaloracion" onfocus="tabla(flexiFinalidadConsulta, 'Dx Principal', 'coddiagnosticopr_nutricionvaloracion' )" onclick="tabla(flexiFinalidadConsulta, 'Dx Principal', 'coddiagnosticopr_nutricionvaloracion' )"></select></td>
                            <td> <select  id="coddiagnosticor1_nutricionvaloracion" name="coddiagnosticor1_nutricionvaloracion" onfocus="tabla(flexiFinalidadConsulta, 'Dx Relacionado 1', 'coddiagnosticor1_nutricionvaloracion' )" onclick="tabla(flexiFinalidadConsulta, 'Dx Relacionado 1', 'coddiagnosticor1_nutricionvaloracion' )"></select></td>
                        </tr>
                        <tr>
                            <td>Dx Relacionado 2</td>
                            <td>Dx Relacionado 3</td>
                            <td>Dx Salida</td>
                            <td>Archivo Documento</td>
                        </tr>
                        <tr>
                            <td> <select  id="coddiagnosticor2_nutricionvaloracion" name="coddiagnosticor2_nutricionvaloracion" onfocus="tabla(flexiFinalidadConsulta, 'Dx Relacionado 2', 'coddiagnosticor2_nutricionvaloracion' )" onclick="tabla(flexiFinalidadConsulta, 'Dx Relacionado 2', 'coddiagnosticor2_nutricionvaloracion' )"></select></td>
                            <td> <select  id="coddiagnosticor3_nutricionvaloracion" name="coddiagnosticor3_nutricionvaloracion" onfocus="tabla(flexiFinalidadConsulta, 'Dx Relacionado 3', 'coddiagnosticor3_nutricionvaloracion' )" onclick="tabla(flexiFinalidadConsulta, 'Dx Relacionado 3', 'coddiagnosticor3_nutricionvaloracion' )"></select></td>
                            <td> <select  id="coddiagnosticosa_nutricionvaloracion" name="coddiagnosticosa_nutricionvaloracion" onfocus="tabla(flexiFinalidadConsulta, 'Dx Salida', 'coddiagnosticosa_nutricionvaloracion' )" onclick="tabla(flexiFinalidadConsulta, 'Dx Salida', 'coddiagnosticosa_nutricionvaloracion' )"></select></td>
                            <td><input name="nutrarchivo_nutricionvaloracion" type="text" id="nutrarchivo_nutricionvaloracion" size="17" value="" readonly="readonly" onclick="abrirCargaArchivo('nutrarchivo_nutricionvaloracion')" />   <img src="../images/descargar_1.png" width="30" height="30" onclick="reHref('nutrarchivo_nutricionvaloracion' )" alt="Descargar" /></td>
                        </tr>
                        <tr>
                            <td>Observaciones</td>
                        </tr>
                        <tr>
                            <td  colspan="4" > <textarea id="nutrobservac_nutricionvaloracion" name="nutrobservac_nutricionvaloracion" cols="110" rows="4"></textarea></td>
                        </tr>

                    </table>
                    <br />
                    <!-- Acciones estan
                                        1 - > registrar
                                        2 -> actualizar -->
                    <div class="boton"><input type="submit" id="accion2" value="Registrar" onclick="accionFormulario('ValoracionNutricional', 'Registrar', ''); return false" /> <input type="reset" id="resetFormulario2" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" /> <input type="submit" id="actualizar2" value="Actualizar" onclick="accionFormulario('ValoracionNutricional', 'Actualizar', ''); return false" class="c2" />
                        <input type="submit" id="volver_registro2" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>
                </form>
                <div class="boton"></div>
            </div>
        </div>
       
    </body>
</html>
