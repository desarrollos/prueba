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
        <div id="tablaContenedor"></div>
        <form><input type="hidden" id="combo" /> <input type="hidden" id="nombreFormulario" value="SUBSIDIOS" /> <input type="hidden" id="servlet" value="Subsidios" /></form>
        <div id="dialog" class="c1">
            <div class="encabezado"></div>
            <div class="titulo">SUBSIDIOS</div>
            <br />
            <form id="Subsidios" name="Subsidios">
                <div class="boton"><input type="submit" id="accion1" value="Registrar" onclick="accionFormulario('Subsidios', 'Registrar', ''); return false" />

                    <input type="reset" id="resetFormulario1" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" />
                    <input type="submit" id="actualizar1" value="Actualizar" onclick="accionFormulario('Subsidios', 'Actualizar', ''); return false" class="c2" />
                    <input type="submit" id="volver_registro1" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>

                <br />
                <br />
                <input type="hidden" name="pestana" id="pestana" value="subsidio" /> <input type="hidden" id="codigo" name="codigo" /> <input type="hidden" name="accion" id="accion" value="" />
                <div id="tabs">
                    <ul>
                        <li><a href="#tabs-1" id="subsidio" name="subsidio">Subsidio</a></li>
                        <li><a href="#tabs-2" id="subsidiomunicipio" name="subsidiomunicipio">Subsidio Municipio</a></li>
                        <li><a href="#tabs-3" id="subsidiopotencial" name="subsidiopotencial">Subsidio Potencial</a></li>
                        <li><a href="#tabs-4" id="subsidioasignado" name="subsidioasignado">Subsidio Asignado</a></li>
                    </ul>
                    <div id="tabs-1">
                        <div class="boton"><input type="submit" value="Mostrar subsidios registrados" 
                                                  onclick="tabla(flexiSubsidio, 'Subsidios', '' ); return false" /></div>
                        <br />
                        <table>

                            <tr>
                                <td>Código Subsidio</td>
                                <td>Descripción Subsidio</td>
                                <td>Fecha Inicial Vigencia Subsidio</td>
                                <td>Fecha Final Vigencia Subsidio</td>
                            </tr>
                            <tr>
                                <td> <input type="text" id="subscodigo_subsidio" name="subscodigo_subsidio"/></td>
                                <td> <input type="text" id="subsdescripc_subsidio" name="subsdescripc_subsidio"/></td>
                                <td><input type="text" id="_fecha_subsfechinic_subsidio" name="subsfechinic_subsidio" value="" maxlength="19" readonly="readonly" /></td>
                                <td><input type="text" id="_fecha_subsfechfina_subsidio" name="subsfechfina_subsidio" value="" maxlength="19" readonly="readonly" /></td>
                            </tr>
                            <tr>
                                <td>Código Tipo Subsidio</td>
                                <td>Código Clase Beneficiario</td>
                                <td>Código Grupo Grado Escolaridad</td>
                                <td>Valor Base Subsidio</td>
                            </tr>
                            <tr>
                                <td> <select  id="subtipcodigo_subsidio" name="subtipcodigo_subsidio" onfocus="tabla(flexiTipoSubsidio, 'Código Tipo Subsidio', 'subtipcodigo_subsidio' )" onclick="tabla(flexiTipoSubsidio, 'Código Tipo Subsidio', 'subtipcodigo_subsidio' )"></select></td>
                                <td> <select  id="clabencodigo_subsidio" name="clabencodigo_subsidio" onfocus="tabla(flexiClaseBeneficiario, 'Código Clase Beneficiario', 'clabencodigo_subsidio' )" onclick="tabla(flexiClaseBeneficiario, 'Código Clase Beneficiario', 'clabencodigo_subsidio' )"></select></td>
                                <td> <select  id="grugracodigo_subsidio" name="grugracodigo_subsidio" onfocus="tabla(flexiEscGrupoGrado, 'Código Grupo Grado Escolaridad', 'grugracodigo_subsidio' )" onclick="tabla(flexiEscGrupoGrado, 'Código Grupo Grado Escolaridad', 'grugracodigo_subsidio' )"></select></td>
                                <td> <input type="text" id="subsvalobase_subsidio" name="subsvalobase_subsidio"/></td>
                            </tr>
                            <tr>
                                <td>Codigo Tipo Norma</td>
                                <td>Observaciones Subsidio</td>
                            </tr>
                            <tr>
                                <td> <select  id="normas_subsidio_1" name="normas_subsidio_1" onfocus="tabla(flexiNormas, 
                                    'Codigo Tipo Norma', 'normas_subsidio_1' )" onclick="tabla(flexiNormas, 'Codigo Tipo Norma', 'normas_subsidio_1' )"></select></td>
                                
                                <td colspan="3"> <textarea id="subsobservac_subsidio" name="subsobservac_subsidio" cols="80" rows="4"></textarea></td>
                            </tr>

                        </table>
                    </div>
                    <div id="tabs-2">
                        <div class="boton"><input type="submit" value="Mostrar subsidio municipio registrados" 
                                                  onclick="tabla(flexiSubsidioMunicipio, 'Subsidios Municipio', '' ); return false" /></div>
                        <br />
                        <br />
                        <table>


                        </table>
                    </div>
                    <div id="tabs-3">
                        <div class="boton"><input type="submit" value="Mostrar subsidios potenciales registrados" 
                                                  onclick="tabla(flexiSubsidioPotencial, 'Subsidios Potenciales', '' ); return false" /></div>
                        <br />
                        <br />
                        <table>

                        </table>
                    </div>
                    <div id="tabs-4">
                        <div class="boton"><input type="submit" value="Mostrar subsidios asignados registrados" 
                                                  onclick="tabla(flexiSubsidioAsignado, 'Subsidios Asignados', '' ); return false" /></div>
                        <br />
                        <br />
                        <table>


                        </table>
                    </div>
                </div>
            </form>
            <div class="boton"><input type="submit" id="accion2" value="Registrar" onclick="accionFormulario('Subsidios', 'Registrar', ''); return false" /> <input type="reset" id="resetFormulario2" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" /> <input type="submit" id="actualizar2" value="Actualizar" 
                                                                                                                                                                                                        onclick="accionFormulario('Subsidios', 'Actualizar', ''); return false" class="c2" /> <input type="submit" id="volver_registro2" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>
        </div>

    </body>
