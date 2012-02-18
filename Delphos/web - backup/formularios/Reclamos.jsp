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
        <form><input type="hidden" id="combo" /> <input type="hidden" id="nombreFormulario" value="Reclamos" /> <input type="hidden" id="servlet" value="Reclamos" /></form>
        <div id="dialog" class="c1">
            <div class="encabezado"></div>
            <div class="titulo">RECLAMOS</div>
            <br />
            <form id="Reclamos" name="Reclamos">
                <div class="boton"><input type="submit" id="accion1" value="Registrar" onclick="accionFormulario('Reclamos', 'Registrar', ''); return false" /> <input type="reset" id="resetFormulario1" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" /> <input type="submit" id="actualizar1" value="Actualizar" onclick="accionFormulario('Reclamos', 'Actualizar', ''); return false" class="c2" /> <input type="submit" id="volver_registro1" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>
                <br />
                <br />
                <input type="hidden" name="pestana" id="pestana" value="Reuniones" /> <input type="hidden" id="codigo" name="codigo" /> <input type="hidden" name="accion" id="accion" value="" />
                <div id="tabs">
                    <ul>
                        <li><a href="#tabs-1" id="reclamo" name="Registros">Registro</a></li>
                        <li><a href="#tabs-2" id="reclamodocumento" name="Documentos">Documentos</a></li>
                        <li><a href="#tabs-3" id="encuentroactividad" name="Afectados">Afectados</a></li>
                        <li><a href="#tabs-4" id="encuenasistenteexterno" name="Respuestas">Respuestas</a></li>
                    </ul>
                    <div id="tabs-1">
                        <div class="boton"><input type="submit" value="Mostrar Registros Registrados" onclick="tabla(flexiReclamos, 'Reclamos', '' ); return false" /></div>
                        <br />
                        <table>
                            <tr>
                                <td>Código &Uacute;nico Familia</td>
                                <td>Consecutivo Reclamo</td>
                                <td>Tipo de Identificaci&oacute;n Persona Afectada</td>
                                <td>Identificaci&oacute;n Persona Afectada</td>
                                <td>Fecha Reclamo</td>

                            </tr>
                            <tr>
                                <td><select name="codunifami_reclamo" id="codunifami_reclamo" 
                                            onfocus="tabla(flexiInscripcion, 'Código &Uacute;nico Familia', 'codunifami_reclamo' )" 
                                            onclick="tabla(flexiInscripcion, 'Código &Uacute;nico Familia', 'codunifami_reclamo' )"></select></td>

                                <td><input name="reclamconsec_reclamo" type="text" id="reclamconsec_reclamo" value="" /></td>

                                <td><select name="codtipoidentidadper_reclamo" id="codtipoidentidadper_reclamo" 
                                            onfocus="tabla(flexiTipoIdentificacion, 'Tipo Identificacion', 'codtipoidentidadper_reclamo' )" 
                                            onclick="tabla(flexiTipoIdentificacion, 'Tipo Identificacion', 'codtipoidentidadper_reclamo' )"></select></td>

                                <td><input name="reclamidentiper_reclamo" type="text" id="reclamidentiper_reclamo" value="" /></td>
                                
                                <td><input name="reclamfecha_reclamo" type="text" id="_fecha_reclamfecha_reclamo" value="" /></td>
                            </tr>
                            <tr>
                                <td>Municipio</td>
                                <td>Clasificaci&oacute;n Reclamo</td>
                                <td>Cilo Pago Afectado</td>


                            </tr>
                            <tr>
                                <td><select name="municipio_reclamo_1" id="municipio_reclamo_1" 
                                            onfocus="tabla(flexiMunicipio, 'Municipio', 'municipio_reclamo_1' )" 
                                            onclick="tabla(flexiMunicipio, 'Municipio', 'municipio_reclamo_1' )"></select></td>
                                <td><select name="reclamoclasificacion_reclamo_1" id="reclamoclasificacion_reclamo_1" 
                                            onfocus="tabla(flexiClasificacionReclamo, 'Reclamo Clasificacion', 'reclamoclasificacion_reclamo_1' )" 
                                            onclick="tabla(flexiClasificacionReclamo, 'Reclamo Clasificacion', 'reclamoclasificacion_reclamo_1' )"></select></td>
                                <td><input name="reclciclpago_reclamo" type="text" id="reclciclpago_reclamo" value="" /></td>
                            </tr>

                            <tr>
                                <td>Tipo Identificaci&oacute;n Funcionario Recibe Reclamo</td>
                                <td>Identificaci&oacute;n Funcionario Recibe Reclamo</td>
                                <td>Archivo Documento Reclamo</td>
                                <td>Observaciones</td>

                            </tr>
                            <tr>
                                <td><select name="codtipoidentidad_reclamo" id="codtipoidentidad_reclamo" 
                                            onfocus="tabla(flexiTipoIdentificacion, 'Tipo Identificación', 'codtipoidentidad_reclamo' )" 
                                            onclick="tabla(flexiTipoIdentificacion, 'Tipo Identificación', 'codtipoidentidad_reclamo' )"></select></td>

                                <td><input name="numidentfunc_reclamo" type="text" id="numidentfunc_reclamo" value="" /></td>

                                <td><input name="reclarchdocu_reclamo" type="text" id="reclarchdocu_reclamo"
                                           size="17" value="" readonly="readonly" onclick="abrirCargaArchivo('reclarchdocu_reclamo')" /> 
                                    <img src="../images/descargar_1.png" width="30" height="30"  alt="Subir Archivo" onclick="reHref('reclarchdocu_reclamo' )" /></td>

                                <td colspan="2">
                                    <textarea name="reclamobserv_reclamo" id="reclamobserv_reclamo" cols="40" rows="4"></textarea>
                                </td>


                            </tr>
                        </table>
                    </div>
                    <div id="tabs-2">
                        <div class="boton"><input type="submit" value="Mostrar Documentos Registrados" onclick="tabla(flexiReclamoDocumentos, 'Reclamo Documentos', '' ); return false" /></div>
                        <br />
                        <br />
                        <table>
                            <tr>
                                <!--<td>C&oacute;digo &Uacute;nico Familia</td>-->
                                <td>Consecutivo Reclamo</td>
                                <td>C&oacute;digo Tipo Documento Asociado</td>
                                <td>Documento Entregado</td>
                                <td>Archivo Documento Asociado</td>
                            </tr>
                            <tr>
                                <!--                                
                                <td><select name="codunifami_documentos" id="codunifami_documentos" 
                                            onfocus="tabla(flexiInscripcion, 'Código &Uacute;nico Familia', 'codunifami_documentos' )" 
                                            onclick="tabla(flexiInscripcion, 'Código &Uacute;nico Familia', 'codunifami_documentos' )"></select></td>
                                -->

                                <td><select name="reclamconsec_documentos" id="reclamconsec_documentos" 
                                            onfocus="tabla(flexiReclamos, 'Reclamos', 'reclamconsec_documentos' )" 
                                            onclick="tabla(flexiReclamos, 'Reclamos', 'reclamconsec_documentos' )"></select></td>



                                <td><select name="codtipodctoasociado_documentos" id="codtipodctoasociado_documentos" 
                                            onfocus="tabla(flexiTipoDocumentoAsociado, 'Código Tipo Documento Asociado', 'codtipodctoasociado_documentos' )" 
                                            onclick="tabla(flexiTipoDocumentoAsociado, 'Código Tipo Documento Asociado', 'codtipodctoasociado_documentos' )"></select></td>                                

                                <td>
                                    <div id="switch_recdocentrga_documentos"></div>
                                    <input type="hidden" name="recdocentrga_documentos" id="recdocentrga_documentos" />

                                </td>
                                <td><input name="recdocarchiv_documentos" type="text" id="recdocarchiv_documentos" size="17" value="" readonly="readonly"
                                           onclick="abrirCargaArchivo('recdocarchiv_documentos')" />
                                    <img src="../images/descargar_1.png" width="30" height="30" alt="Descargar" onclick="reHref('recdocarchiv_documentos' )" /></td>

                            </tr>

                        </table>
                    </div>
                    <div id="tabs-3">
                        <div class="boton"><input type="submit" value="Mostrar Afectados Registrados" onclick="tabla(flexiReclamoBeneficiario, 'Reclamos Beneficiarios', '' ); return false" /></div>
                        <br />
                        <br />
                        <table>
                            <tr>
                                <!--- <td>C&oacute;digo &Uacute;nico Familia</td>-->
                                <td>Consecutivo Reclamo</td>
                                <!--<td>Tipo Identificaci&oacute;n Afectado</td>-->
                                <td>Identificaci&oacute;n Afectado</td>
                                <td>Observaciones Beneficiario Reclamos</td>
                            </tr>

                            <tr>
                                <!--<td><select name="codunifami_afectados" id="codunifami_afectados" 
                                            onfocus="tabla(flexiInscripcion, 'Código &Uacute;nico Familia', 'codunifami_afectados' )" 
                                            onclick="tabla(flexiInscripcion, 'Código &Uacute;nico Familia', 'codunifami_afectados' )"></select></td>
                                -->
                                <td><select name="reclamconsec_afectados" id="reclamconsec_afectados" 
                                            onfocus="tabla(flexiReclamos, 'Reclamos', 'reclamconsec_afectados' )" 
                                            onclick="tabla(flexiReclamos, 'Reclamos', 'reclamconsec_afectados' )"></select></td>                                


                                <!--<td><select name="codtipoidentidad_afectados" id="codtipoidentidad_afectados" 
                                            onfocus="tabla(flexiTipoIdentificacion, 'Tipo Identificación', 'codtipoidentidad_afectados' )" 
                                            onclick="tabla(flexiTipoIdentificacion, 'Tipo Identificación', 'codtipoidentidad_afectados' )"></select></td>-->
                                           
                                <td><select name="identbenef_afectados" id="identbenef_afectados" 
                                            onfocus="tabla(flexiBeneficiario, 'Beneficiario', 'identbenef_afectados' )" 
                                            onclick="tabla(flexiBeneficiario, 'Beneficiario', 'identbenef_afectados' )"></select></td>


                                <td colspan="1">
                                    <textarea name="recbenobserv_documentos" id="recbenobserv_documentos" cols="30" rows="4"></textarea>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div id="tabs-4">
                        <div class="boton"><input type="submit" value="Mostrar Respuestas Registradas" onclick="tabla(flexiRespuestasReclamo, 'Respuesas Reclamo', '' ); return false" /></div>
                        <br />
                        <br />
                        <table>
                            <tr>
                                <td>C&oacute;digo &Uacute;nico Familia</td>
                                <td>Consecutivo Reclamo</td>
                                <td>Fecha Respuesta Reclamo</td>
                                <td>C&oacute;digo Clasificaci&oacute;n Respuesta</td>
                                <td>Tipo Identificaci&oacute;n Funcionario Respuesta</td>

                            </tr>
                            <tr>
                                <td><select name="codunifami_respuestas" id="codunifami_respuestas" 
                                            onfocus="tabla(flexiInscripcion, 'Código &Uacute;nico Familia', 'codunifami_respuestas' )" 
                                            onclick="tabla(flexiInscripcion, 'Código &Uacute;nico Familia', 'codunifami_respuestas' )"></select></td>

                                <td><input name="reclamconsec_respuestas" type="text" id="reclamconsec_respuestas" value="" /></td>                                
                                <td><input name="resrecfecha_respuestas" type="text" id="_fecha_resrecfecha_respuestas" value="" /></td>                                                                

                                <td><select name="resclacodigo_respuestas" id="resclacodigo_respuestas" 
                                            onfocus="tabla(flexiRespuestaClasificacion, 'Código &Uacute;nico Familia', 'resclacodigo_respuestas' )" 
                                            onclick="tabla(flexiRespuestaClasificacion, 'Código &Uacute;nico Familia', 'resclacodigo_respuestas' )"></select></td>                                

                                <td><select name="codtipoidentidad_respuestas" id="codtipoidentidad_respuestas" 
                                            onfocus="tabla(flexiTipoIdentificacion, 'Tipo Identificación', 'codtipoidentidad_respuestas' )" 
                                            onclick="tabla(flexiTipoIdentificacion, 'Tipo Identificación', 'codtipoidentidad_respuestas' )"></select></td>                                

                            </tr>
                            <tr>
                                <td>Identificaci&oacute;n Funcionario Respuesta</td>

                                <td>C&oacute;digo Tipo Satisfaci&oacute;n</td>
                                <td>Archivo Respuesta Reclamo</td>


                            </tr>
                            <tr>
                                <td><input name="numidentfunc_respuestas" type="text" id="numidentfunc_respuestas" value="" /></td>

                                <td><select name="tipsatcodigo_respuestas" id="tipsatcodigo_respuestas" 
                                            onfocus="tabla(flexiSatifaccionTipo, 'Código Tipo Satisfacci&oacute;n', 'tipsatcodigo_respuestas' )" 
                                            onclick="tabla(flexiSatifaccionTipo, 'Código Tipo Satisfacci&oacute;n', 'tipsatcodigo_respuestas' )"></select></td>                                

                                <td><input name="resrecarcdoc_respuestas" type="text" id="resrecarcdoc_respuestas" size="17" value="" readonly="readonly"
                                           onclick="abrirCargaArchivo('resrecarcdoc_respuestas')" />
                                    <img src="../images/descargar_1.png" width="30" height="30" onclick="reHref('resrecarcdoc_respuestas' )"
                                         alt="Subir Documento" /></td>


                            </tr>

                            <tr>
                                <td>Percepci&oacute;n Usuario Respuesta</td>        

                            </tr>
                            <tr>
                                <td colspan="3"><textarea name="resrecpercep_respuestas" id="resrecpercep_respuestas" cols="80" rows="4"></textarea></td> 

                            </tr>
                            <tr>
                                <td>Observaciones Respuesta Reclamo</td>
                            </tr>
                            <tr>
                                <td colspan="3"><textarea name="resrecobserv_respuestas" id="resrecobserv_respuestas" cols="80" rows="4"></textarea></td> 
                            </tr>

                        </table>
                    </div>
                </div>
            </form>
            <div class="boton"><input type="submit" id="accion2" value="Registrar" onclick="accionFormulario('Reclamos', 'Registrar', ''); return false" /> <input type="reset" id="resetFormulario2" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" /> <input type="submit" id="actualizar2" value="Actualizar" onclick="accionFormulario('Reclamos', 'Actualizar', ''); return false" class="c2" /> <input type="submit" id="volver_registro2" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>
        </div>

    </body>
