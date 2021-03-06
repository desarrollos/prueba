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
                                <td>C�digo Subsidio</td>
                                <td>Descripci�n Subsidio</td>
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
                                <td>C�digo Tipo Subsidio</td>
                                <td>C�digo Clase Beneficiario</td>
                                <td>C�digo Grupo Grado Escolaridad</td>
                                <td>Valor Base Subsidio</td>
                            </tr>
                            <tr>
                                <td> <select  id="subtipcodigo_subsidio" name="subtipcodigo_subsidio" onfocus="tabla(flexiTipoSubsidio, 'C�digo Tipo Subsidio', 'subtipcodigo_subsidio' )" onclick="tabla(flexiTipoSubsidio, 'C�digo Tipo Subsidio', 'subtipcodigo_subsidio' )"></select></td>
                                <td> <select  id="clabencodigo_subsidio" name="clabencodigo_subsidio" onfocus="tabla(flexiClaseBeneficiario, 'C�digo Clase Beneficiario', 'clabencodigo_subsidio' )" onclick="tabla(flexiClaseBeneficiario, 'C�digo Clase Beneficiario', 'clabencodigo_subsidio' )"></select></td>
                                <td> <select  id="grugracodigo_subsidio" name="grugracodigo_subsidio" onfocus="tabla(flexiEscGrupoGrado, 'C�digo Grupo Grado Escolaridad', 'grugracodigo_subsidio' )" onclick="tabla(flexiEscGrupoGrado, 'C�digo Grupo Grado Escolaridad', 'grugracodigo_subsidio' )"></select></td>
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

                            <tr>
                                <td>Subsidio</td>
                                <td>Municipio</td>
                                <td>Valor Subsidio Municipio</td>
                                <td>C�digo Tipo de Subsidio</td>
                            </tr>
                            <tr>
                                <td> <select  id="subscodigo_subsidiomunicipio" 
                                              name="subscodigo_subsidiomunicipio" onfocus="tabla(flexiSubsidio, 'C�digo Subsidio', 'subscodigo_subsidiomunicipio' )" onclick="tabla(flexiSubsidio, 'C�digo Subsidio', 'subscodigo_subsidiomunicipio' )"></select></td>
                                <td> <select  id="municipio_subsidiomunicipio_1" name="municipio_subsidiomunicipio_1" onfocus="tabla(flexiMunicipio, 'Municipio', 'municipio_subsidiomunicipio_1' )" onclick="tabla(flexiMunicipio, 'Municipio', 'municipio_subsidiomunicipio_1' )"></select></td>
                                <td> <input type="text" id="submunvalsub_subsidiomunicipio" name="submunvalsub_subsidiomunicipio"/></td>
                                <td> <select  id="subtipcodigo_subsidiomunicipio" name="subtipcodigo_subsidiomunicipio" onfocus="tabla(flexiTipoSubsidio, 'C�digo Tipo de Subsidio', 'subtipcodigo_subsidiomunicipio' )" onclick="tabla(flexiTipoSubsidio, 'C�digo Tipo de Subsidio', 'subtipcodigo_subsidiomunicipio' )"></select></td>
                            </tr>
                            <tr>
                                <td colspan="2">Descripci�n Subsidio Municipio</td>
                                <td colspan="2">Observaciones Subsidio Municipio</td>
                            </tr>
                            <tr>
                                <td colspan="2"> <textarea id="submundescri_subsidiomunicipio" name="submundescri_subsidiomunicipio" cols="50" rows="4"></textarea></td>
                                <td colspan="2"> <textarea id="submunobserv_subsidiomunicipio" name="submunobserv_subsidiomunicipio" cols="50" rows="4"></textarea></td>
                            </tr>

                        </table>
                    </div>
                    <div id="tabs-3">
                        <div class="boton"><input type="submit" value="Mostrar subsidios potenciales registrados" 
                                                  onclick="tabla(flexiSubsidioPotencial, 'Subsidios Potenciales', '' ); return false" /></div>
                        <br />
                        <br />
                        <table>

                            <tr>
                                <td>C�digo �nico Familia</td>
                                <td>Tipo Identificacion Beneficiario Subsidio</td>
                                <td>Identificaci�n Beneficiario Subsidio</td>
                                <td>C�digo Subsidio</td>
                            </tr>
                            <tr>
                                <td> <select  id="codunifami_subsidiopotencial" name="codunifami_subsidiopotencial" 
                                              onfocus="tabla(flexiInscripcion, 'C�digo �nico Familia', 'codunifami_subsidiopotencial' )" 
                                              onclick="tabla(flexiInscripcion, 'C�digo �nico Familia', 'codunifami_subsidiopotencial' )">

                                    </select></td>

                                <td> <select  id="codtipoidentidad_subsidiopotencial" name="codtipoidentidad_subsidiopotencial" onfocus="tabla(flexiTipoIdentificacion, 'Tipo Identificacion Beneficiario Subsidio', 'codtipoidentidad_subsidiopotencial' )" onclick="tabla(flexiTipoIdentificacion, 'Tipo Identificacion Beneficiario Subsidio', 'codtipoidentidad_subsidiopotencial' )"></select></td>
                                <td> <input type="text" id="subpotidenti_subsidiopotencial" name="subpotidenti_subsidiopotencial"/></td>
                                <td> <select  id="subscodigo_subsidiopotencial" name="subscodigo_subsidiopotencial" onfocus="tabla(flexiSubsidio, 'C�digo Subsidio', 'subscodigo_subsidiopotencial' )" onclick="tabla(flexiSubsidio, 'C�digo Subsidio', 'subscodigo_subsidiopotencial' )"></select></td>
                            </tr>
                            <tr>
                                <td>Valor Subsidio Potencial</td>
                                <td>Municipio Segun DANE</td>


                            </tr>
                            <tr>
                                <td> <input type="text" id="subpotvalsub_subsidiopotencial" name="subpotvalsub_subsidiopotencial"/></td>
                                <td> <select  id="municipio_subsidiopotencial_1" name="municipio_subsidiopotencial_1" onfocus="tabla(flexiMunicipio, 'CodigoDeparamento Segun DANE', 'municipio_subsidiopotencial_1' )" onclick="tabla(flexiMunicipio, 'CodigoDeparamento Segun DANE', 'municipio_subsidiopotencial_1' )"></select></td>


                            </tr>
                            <tr>
                                <td>Descripci�n Subsidio Potencial</td> 
                            </tr>
                            <tr>
                                <td colspan="4"> <textarea id="subpotdescri_subsidiopotencial" name="subpotdescri_subsidiopotencial" cols="110" rows="4"></textarea></td>
                            </tr>
                            <tr>
                                <td>Observaciones Subsidio Potencial</td>
                            </tr>
                            <tr>
                                <td colspan="4"> <textarea id="subpotobserv_subsidiopotencial" name="subpotobserv_subsidiopotencial" cols="110" rows="4"></textarea></td>
                            </tr>
                        </table>
                    </div>
                    <div id="tabs-4">
                        <div class="boton"><input type="submit" value="Mostrar subsidios asignados registrados" 
                                                  onclick="tabla(flexiSubsidioAsignado, 'Subsidios Asignados', '' ); return false" /></div>
                        <br />
                        <br />
                        <table>

                            <tr>
                                <td>C�digo �nico Familia</td>
                                <td>Fecha Inicial Vigencia Subsidio</td>
                                <td>Fecha Final Vigencia Subsidio</td>
                                <td>Subsidio</td>
                            </tr>
                            <tr>
                                <td> <select  id="subsidiopotencial_subsidioasignado_1" name="subsidiopotencial_subsidioasignado_1" 
                                              onfocus="tabla(flexiSubsidioPotencial, 'C�digo �nico Familia', 'subsidiopotencial_subsidioasignado_1' )" 
                                              onclick="tabla(flexiSubsidioPotencial, 'C�digo �nico Familia', 'subsidiopotencial_subsidioasignado_1' )"></select></td>
                                
                                
                                <td><input type="text" id="_fecha_subasifecini_subsidioasignado" name="subasifecini_subsidioasignado" value="" maxlength="19" readonly="readonly" /></td>
                                <td><input type="text" id="_fecha_subasifecfin_subsidioasignado" name="subasifecfin_subsidioasignado" value="" maxlength="19" readonly="readonly" /></td>
                                <td> <select  id="subscodigo_subsidioasignado" name="subscodigo_subsidioasignado" onfocus="tabla(flexiSubsidio, 'C�digo �nico Familia', 'subscodigo_subsidioasignado' )" onclick="tabla(flexiSubsidio, 'C�digo �nico Familia', 'subscodigo_subsidioasignado' )"></select></td>
                            </tr>
                            <tr>
                                <td>Valor Pago Subsidio</td>
                                <td>Municipio</td>
                                <td>Banco</td>
                                <td>Cumple Requisito Educaci�n (S/N)</td>
                            </tr>
                            <tr>
                                <td> <input type="text" id="subasivalsub_subsidioasignado" name="subasivalsub_subsidioasignado"/></td>
                                <td> <select  id="municipio_subsidioasignado_1" name="municipio_subsidioasignado_1" 
                                              onfocus="tabla(flexiMunicipio, 'Municipio', 
                                                  'municipio_subsidioasignado_1' )" onclick="tabla(flexiMunicipio, 
                                                  'Municipio', 'municipio_subsidioasignado_1' )"></select></td>
                                
                                <td> <select  id="codbanco_subsidioasignado" name="codbanco_subsidioasignado" onfocus="tabla(flexiBanco, 'Banco', 'codbanco_subsidioasignado' )" onclick="tabla(flexiBanco, 'Banco', 'codbanco_subsidioasignado' )"></select></td>
                                <td><div id="switch_subasireqedu_subsidioasignado"></div> <input type="hidden" id="subasireqedu_subsidioasignado" name="subasireqedu_subsidioasignado"  /></td>
                            </tr>
                            <tr>
                                <td>Cumple Requisito Salud (S/N)</td>
                                <td>Uso Subsidio (S/N)</td>
                                
                                
                            </tr>
                            <tr>
                                <td><div id="switch_subasireqsal_subsidioasignado"></div> <input type="hidden" id="subasireqsal_subsidioasignado" name="subasireqsal_subsidioasignado"  /></td>
                                <td><div id="switch_subasiusosub_subsidioasignado"></div> <input type="hidden" id="subasiusosub_subsidioasignado" name="subasiusosub_subsidioasignado"  /></td>
                                
                                
                            </tr>
                            <tr>
                                <td>Descripci�n Subsidio Asignado</td>
                            </tr>
                            <tr>
                                <td colspan="4"> <textarea id="subasidescri_subsidioasignado" name="subasidescri_subsidioasignado" cols="110" rows="4"></textarea></td>
                            </tr>
                            <tr>
                                <td>Observaciones Subsidio Asignado</td>    
                            </tr>
                            <tr>
                                <td colspan="4"> <textarea id="subasiobserv_subsidioasignado" name="subasiobserv_subsidioasignado" cols="110" rows="4"></textarea></td>
                            </tr>
                            

                        </table>
                    </div>
                </div>
            </form>
            <div class="boton"><input type="submit" id="accion2" value="Registrar" onclick="accionFormulario('Subsidios', 'Registrar', ''); return false" /> <input type="reset" id="resetFormulario2" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" /> <input type="submit" id="actualizar2" value="Actualizar" 
                                                                                                                                                                                                        onclick="accionFormulario('Subsidios', 'Actualizar', ''); return false" class="c2" /> <input type="submit" id="volver_registro2" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>
        </div>

    </body>
