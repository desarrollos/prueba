<%@ include file="config.jsp" %>



<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
       <jsp:include page="scripts.jsp"> 	
            <jsp:param name="js" value="<%= request.getServletPath() %>" />
        </jsp:include>
    </head>
    <body>
        <input type="hidden" name="servletActivo" id="servletActivo"/>
        <div id="ajax" class="c1"></div>
        <div id="mensaje" class="c1"></div><div id="reporte"></div>
        <form><input type="hidden" id="respuestaAjax" /> <!-- Aqui saldra el flexigrid para la tabla --></form>
        <div id="tablaContenedor"></div>
        <form><input type="hidden" id="combo" /> <input type="hidden" id="nombreFormulario" value="Esquema seguridad Delphos" /> <input type="hidden" id="servlet" value="Educacion" /></form>
        <div id="dialog" class="c1">
            <div class="encabezado"></div>
            <div class="titulo">ESQUEMA DE EDUCACION DELPHOS</div>
            <br />
            <form id="Educacion"><input type="hidden" id="codigo" name="codigo" /> <input type="hidden" name="accion" id="accion" value="" /> <input type="hidden" name="pestana" id="pestana" value="Educacion" />
                <div class="boton"><input type="submit" id="accion1" value="Registrar" onclick="accionFormulario('Educacion', 'Registrar', ''); return false" /> <input type="reset" id="resetFormulario1" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" /> <input type="submit" id="actualizar1" value="Actualizar" onclick="accionFormulario('Educacion', 'Actualizar', ''); return false" class="c2" /> <input type="submit" id="volver_registro1" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>
                <br /><br />
                <div id="tabs">
                    <ul>
                        <li><a href="#tabs-1" id="escolaridad" >Escolaridad</a></li>
                        <li><a href="#tabs-2" id="escolaridadnovedad">Novedad Escolaridad</a></li>
                        <li><a href="#tabs-3" id="escregperiodico">Registro Periodico</a></li>
                        <li><a href="#tabs-4" id="CumpleEscolaridad">Cumple Escolaridad</a></li>


                    </ul>
                    <div id="tabs-1"><br />
                        <div class="boton"><input type="submit" value="Mostrar Escolaridad" onclick="return tabla(flexiEscolaridad, 'Escolaridad', '' )" /></div>
                        <br />
                        <table>


                            <tr>
                                <td>Institución Educativa</td>
                                <td>Tipo Identificaci&oacute;n Estudiante</td>
                                <td>Identificación Estudiante</td>
                                <td>A&ntilde;o Vigencia Escolaridad</td>
                            </tr>
                            <tr>
                                <td> <select  id="empresa_escolaridad_1" name="empresa_escolaridad_1" onfocus="tabla(flexiEmpresas, 'Tipo Identificacion Institución Educativa', 'empresa_escolaridad_1' )" onclick="tabla(flexiEmpresas, 'Tipo Identificacion Institución Educativa', 'empresa_escolaridad_1' )"></select></td>
                                <td> <select  id="codtipoidentidad_escolaridad" name="codtipoidentidad_escolaridad" onfocus="tabla(flexiTipoIdentificacion, 'Tipo Identificaci&oacute;n Estudiante', 'codtipoidentidad_escolaridad' )" onclick="tabla(flexiTipoIdentificacion, 'Tipo Identificaci&oacute;n Estudiante', 'codtipoidentidad_escolaridad' )"></select></td>
                                <td> <input type="text" id="escidentific_escolaridad" name="escidentific_escolaridad"/></td>
                                <td> <input type="text" id="escvigencia_escolaridad" name="escvigencia_escolaridad"/></td>
                            </tr>
                            <tr>
                                <td>Fecha Registro</td>
                                <td>Fecha Matricula</td>
                                <td>N&uacute;mero de Matricula</td>
                                <td>C&oacute;digo Grado Escolaridad</td>
                            </tr>
                            <tr>
                                <td><input type="text" id="_fecha_escfecharegi_escolaridad" name="escfecharegi_escolaridad" value="" maxlength="19" readonly="readonly" /></td>
                                <td> <input type="text" id="_fecha_escfechamatr_escolaridad" name="escfechamatr_escolaridad"/></td>
                                <td> <input type="text" id="escnumermatr_escolaridad" name="escnumermatr_escolaridad"/></td>
                                <td> <select  id="escgracodigo_escolaridad" name="escgracodigo_escolaridad" onfocus="tabla(flexiEscolaridadGrado, 'C&oacute;digo Grado Escolaridad', 'escgracodigo_escolaridad' )" onclick="tabla(flexiEscolaridadGrado, 'C&oacute;digo Grado Escolaridad', 'escgracodigo_escolaridad' )"></select></td>
                            </tr>
                            <tr>
                                <td>Profesor Coordinador Referente</td>
                                <td>C&oacute;digo Estado Escolaridad</td>
                                <td>Archivo Documento Matricula</td>
                                <td>Archivo Documento Certtificado</td>
                            </tr>
                            <tr>
                                <td> <input type="text" id="escprofesor_escolaridad" name="escprofesor_escolaridad"/></td>
                                <td> <select  id="escestcodigo_escolaridad" name="escestcodigo_escolaridad" onfocus="tabla(flexiEscolaridadEstado, 'C&oacute;digo Estado Escolaridad', 'escestcodigo_escolaridad' )" onclick="tabla(flexiEscolaridadEstado, 'C&oacute;digo Estado Escolaridad', 'escestcodigo_escolaridad' )"></select></td>
                                <td><input name="escarchimatr_escolaridad" type="text" id="escarchimatr_escolaridad" size="17" value="" readonly="readonly" onclick="abrirCargaArchivo('escarchimatr_escolaridad')" />   <img src="../images/descargar_1.png" width="30" height="30" onclick="reHref('escarchimatr_escolaridad' )" alt="Descargar" /></td>
                                <td><input name="escarchicert_escolaridad" type="text" id="escarchicert_escolaridad" size="17" value="" readonly="readonly" onclick="abrirCargaArchivo('escarchicert_escolaridad')" />   <img src="../images/descargar_1.png" width="30" height="30" onclick="reHref('escarchicert_escolaridad' )" alt="Descargar" /></td>
                            </tr>
                            <tr>
                                <td>Observaciones Escolaridad</td>
                            </tr>
                            <tr>
                                <td colspan="4"> <textarea id="escobservaci_escolaridad" name="escobservaci_escolaridad" cols="110" rows="4"></textarea></td>
                            </tr>
                        </table>
                    </div>
                    <div id="tabs-2"><br />
                        <div class="boton"><input type="submit" value="Mostrar Novedada Escolaridad" onclick="return tabla(flexiEscolaridadNovedad, 'Novedada Escolaridad', '' )" /></div>
                        <br />

                        <table>

                            <tr>
                                <td>Institución Educativa Actual</td>
                                <td>Consecutivo Novedad Escolaridad</td>
                                <td>Fecha Novedad Escolaridad</td>
                                <td>Tipo Identificacion Empresa Nueva</td>
                            </tr>
                            <tr>
                                <td> <select  id="escolaridad_escolaridadnovedad_1" name="escolaridad_escolaridadnovedad_1" onfocus="tabla(flexiEscolaridad, 'Institución Educativa Actual', 'escolaridad_escolaridadnovedad_1' )" onclick="tabla(flexiEscolaridad, 'Institución Educativa Actual', 'escolaridad_escolaridadnovedad_1' )"></select></td>
                                <td> <input type="text" id="escnovconsec_escolaridadnovedad" name="escnovconsec_escolaridadnovedad"/></td>
                                <td><input type="text" id="_fecha_escnovfecha_escolaridadnovedad" name="escnovfecha_escolaridadnovedad" value="" maxlength="19" readonly="readonly" /></td>
                                <td> <select  id="empresa_escolaridadnovedad_1" name="empresa_escolaridadnovedad_1" onfocus="tabla(flexiEmpresas, 'Tipo Identificacion Empresa Nueva', 'empresa_escolaridadnovedad_1' )" onclick="tabla(flexiEmpresas, 'Tipo Identificacion Empresa Nueva', 'empresa_escolaridadnovedad_1' )"></select></td>
                            </tr>
                            <tr>
                                <td>Codigo Tipo de Novedad</td>
                                <td>Archivo Documento Novedad Escolaridad</td>
                                <td>Observaciones Tipo de Novedad</td>
                            </tr>
                            <tr>
                                <td> <select  id="codtiponovedad_escolaridadnovedad" name="codtiponovedad_escolaridadnovedad" onfocus="tabla(flexiTipoNovedad, 'Codigo Tipo de Novedad', 'codtiponovedad_escolaridadnovedad' )" onclick="tabla(flexiTipoNovedad, 'Codigo Tipo de Novedad', 'codtiponovedad_escolaridadnovedad' )"></select></td>
                                <td><input name="escnovarchi_escolaridadnovedad" type="text" id="escnovarchi_escolaridadnovedad" size="17" value="" readonly="readonly" onclick="abrirCargaArchivo('escnovarchi_escolaridadnovedad')" />   <img src="../images/descargar_1.png" width="30" height="30" onclick="reHref('escnovarchi_escolaridadnovedad' )" alt="Descargar" /></td>
                                <td colspan="2" > <textarea id="escnovobserv_escolaridadnovedad" name="escnovobserv_escolaridadnovedad" cols="50" rows="4"></textarea></td>
                            </tr>
                        </table>

                    </div>
                    <div id="tabs-3"><br />
                        <div class="boton"><input type="submit" value="Mostrar Registro Periodico" onclick="return tabla(flexiEscolaridadPeriodico, 'Registro Periodico', '' )" /></div>
                        <br />

                        <table>

                            <tr>
                                <td>Escolaridad</td>
                                <td>Fecha Inicial Registro Periódico Escolaridad</td>
                                <td>Fecha Final Registro Periódico Escolaridad</td>
                                <td>Firma Autorizada</td>
                            </tr>
                            <tr>
                                <td> <select  id="escolaridad_escregperiodico_1" name="escolaridad_escregperiodico_1" onfocus="tabla(flexiEscolaridad, 'Escolaridad', 'escolaridad_escregperiodico_1' )" onclick="tabla(flexiEscolaridad, 'Escolaridad', 'escolaridad_escregperiodico_1' )"></select></td>
                                <td><input type="text" id="_fecha_espefechinic_escregperiodico" name="espefechinic_escregperiodico" value="" maxlength="19" readonly="readonly" /></td>
                                <td><input type="text" id="_fecha_espefechfina_escregperiodico" name="espefechfina_escregperiodico" value="" maxlength="19" readonly="readonly" /></td>
                                <td> <select  id="firmasautorizadas_escregperiodico_1" name="firmasautorizadas_escregperiodico_1" onfocus="tabla(flexiFirmasAutorizadas, 'EscolaridadFirma Autorizada', 'firmasautorizadas_escregperiodico_1' )" onclick="tabla(flexiFirmasAutorizadas, 'EscolaridadFirma Autorizada', 'firmasautorizadas_escregperiodico_1' )"></select></td>
                            </tr>
                            <tr>
                                <td>Fecha Registro Escolaridad Periódica</td>
                                <td>N&uacute;mero de Clases Programadas Periódo</td>
                                <td>N&uacute;mero de Fallas Periódo</td>
                                <td>Número de Fallas Justificadas Periódo</td>
                            </tr>
                            <tr>
                                <td><input type="text" id="_fecha_espefechregi_escregperiodico" name="espefechregi_escregperiodico" value="" maxlength="19" readonly="readonly" /></td>
                                <td> <input type="text" id="especlasprog_escregperiodico" name="especlasprog_escregperiodico"/></td>
                                <td> <input type="text" id="espenumefall_escregperiodico" name="espenumefall_escregperiodico"/></td>
                                <td> <input type="text" id="espefalljust_escregperiodico" name="espefalljust_escregperiodico"/></td>
                            </tr>
                            <tr>
                                <td>N&uacute;mero Certificado Escolar Periódo</td>
                                <td>Certificado Recibido (S/N)</td>
                                <td>Cumple Requisitos Subsidio Escolaridad Periódo (S/N)</td>
                                <td>Archivo Documento Certificado de Escolaridad</td>
                            </tr>
                            <tr>
                                <td> <input type="text" id="especertesco_escregperiodico" name="especertesco_escregperiodico"/></td>
                                <td><div id="switch_especertreci_escregperiodico"></div> <input type="hidden" id="especertreci_escregperiodico" name="especertreci_escregperiodico"  /></td>
                                <td><div id="switch_especumprequ_escregperiodico"></div> <input type="hidden" id="especumprequ_escregperiodico" name="especumprequ_escregperiodico"  /></td>
                                <td><input name="espearchivo_escregperiodico" type="text" id="espearchivo_escregperiodico" size="17" value="" readonly="readonly" onclick="abrirCargaArchivo('espearchivo_escregperiodico')" />   <img src="../images/descargar_1.png" width="30" height="30" onclick="reHref('espearchivo_escregperiodico' )" alt="Descargar" /></td>
                            </tr>
                            <tr>
                                <td>Observaciones Registro Peri&oacute;dico Escolaridad</td>
                            </tr>
                            <tr>
                                <td colspan="4"> <textarea id="espeobservac_escregperiodico" name="espeobservac_escregperiodico" cols="100" rows="4"></textarea></td>
                            </tr>
                        </table>

                    </div>
                    <div id="tabs-4"><br />
                        <div class="boton"><input type="submit" value="Mostrar Cumple Escolaridad" onclick="return tabla(flexi, 'Cumple Escolaridad', '' )" /></div>
                        <br />

                        <table>



                            <tr>
                                <td>Escolaridad Periodico</td>
                                <td>C&oacute;digo Requisito</td>
                                <td>Codigo Estado Cumplimiento</td>
                                
                            </tr>
                            <tr>
                                <td> <select  id="escregperiodico_escolaridadcumplimiento_1" name="escregperiodico_escolaridadcumplimiento_1" onfocus="tabla(flexiEscolaridadPeriodico, 'Escolaridad Periodico', 'escregperiodico_escolaridadcumplimiento_1' )" onclick="tabla(flexiEscolaridadPeriodico, 'Escolaridad Periodico', 'escregperiodico_escolaridadcumplimiento_1' )"></select></td>
                                <td> <select  id="requisitos_escolaridadcumplimiento_1" name="requisitos_escolaridadcumplimiento_1" onfocus="tabla(flexiRequisitos, 'C&oacute;digo Requisito', 'requisitos_escolaridadcumplimiento_1' )" onclick="tabla(flexiRequisitos, 'C&oacute;digo Requisito', 'requisitos_escolaridadcumplimiento_1' )"></select></td>
                                <td> <select  id="codestcumplimiento_escolaridadcumplimiento" name="codestcumplimiento_escolaridadcumplimiento" onfocus="tabla(flexiEstadoCumplimactividad, 'Codigo Estado Cumplimiento', 'codestcumplimiento_escolaridadcumplimiento' )" onclick="tabla(flexiEstadoCumplimactividad, 'Codigo Estado Cumplimiento', 'codestcumplimiento_escolaridadcumplimiento' )"></select></td>
                                
                            </tr>
                            <tr>
                                <td>Observaciones Cumplimiento Escolaridad</td>
                            </tr>
                            <tr>
                                <td colspan="4"> <textarea id="esccumobserv_escolaridadcumplimiento" name="esccumobserv_escolaridadcumplimiento" cols="80" rows="4"></textarea></td>
                            </tr>

                        </table>

                    </div>


                    <br />
                    <br />

                    <div class="clearBottom"></div>
                </div>
                <br />
                <div class="boton"><input type="submit" id="accion2" value="Registrar" onclick="accionFormulario('Educacion', 'Registrar', ''); return false" /> <input type="reset" id="resetFormulario2" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" /> <input type="submit" id="actualizar2" value="Actualizar" onclick="accionFormulario('Educacion', 'Actualizar', ''); return false" class="c2" /> <input type="submit" id="volver_registro2" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>
            </form>
        </div>
        
    </body>
</html>
