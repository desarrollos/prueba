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
        <form><input type="hidden" id="respuestaAjax" /></form>
        <div id="tablaContenedor"></div> 
        <form><input type="hidden" id="combo" /> <input type="hidden" id="nombreFormulario" value="Novedad" /> <input type="hidden" id="servlet" value="Novedad" /></form>  
        <div id="dialog" class="c1">  
            <div class="encabezado"></div>  
            <div class="titulo">NOVEDAD</div>  
            <br />  
            <form id="Novedad" name="Novedad">  
                <div class="boton"><input type="submit" id="accion1" value="Registrar" onclick="accionFormulario('Novedad', 'Registrar', ''); return false" />  
                    <input type="reset" id="resetFormulario1" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" />  
                    <input type="submit" id="actualizar1" value="Actualizar" onclick="accionFormulario('Novedad', 'Actualizar', ''); return false" class="c2" />  
                    <input type="submit" id="volver_registro1" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>  
                <br />  
                <br />  
                <input type="hidden" name="pestana" id="pestana" value="tabs_1" /> <input type="hidden" id="codigo" name="codigo" /> <input type="hidden" name="accion" id="accion" value="" />  
                <div id="tabs">  
                    <ul> 
                        <li><a href="#tabs-1" id="novedad" name="tabs1">Novedad</a></li>  
                        <li><a href="#tabs-2" id="novedadcampo" name="tabs2">Novedad Campo</a></li>  
                        <li><a href="#tabs-3" id="novedaddocumento" name="tabs3">Novedad Documento</a></li>  
                    </ul> 
                    <div id="tabs-1">
                        <div class="boton"><input type="submit" value="Mostrar Novedades Registradas" onclick="tabla(flexiNovedad, 'Novedades Registradas', '' ); return false" /></div> 
                        <br /> 
                        <table> 


                            <tr>
                                <td>Consecutivo Novedad</td>
                                <td>Código Único Familia</td>
                                <td>Tipo Identificacion Persona Presenta Novedad</td>
                                <td>Identificación Persona que Presenta la Novedad</td>
                            </tr>
                            <tr>
                                <td> <input type="text" id="noveconsecut_novedad" name="noveconsecut_novedad"/></td>
                                <td> <select  id="codunifami_novedad" name="codunifami_novedad" onfocus="tabla(flexiInscripcion, 'Consecutivo Novedad', 'codunifami_novedad' )" onclick="tabla(flexiInscripcion, 'Consecutivo Novedad', 'codunifami_novedad' )"></select></td>
                                <td> <select  id="codtipoidentidad_novedad" name="codtipoidentidad_novedad" onfocus="tabla(flexiTipoIdentificacion, 'Tipo Identificacion Persona Presenta Novedad', 'codtipoidentidad_novedad' )" onclick="tabla(flexiTipoIdentificacion, 'Tipo Identificacion Persona Presenta Novedad', 'codtipoidentidad_novedad' )"></select></td>
                                <td> <input type="text" id="noveidentifi_novedad" name="noveidentifi_novedad"/></td>
                            </tr>
                            <tr>
                                <td>Codigo Tipo Novedad</td>
                                <td>Fecha Solicitud Novedad</td>
                                <td>Fecha Novedad</td>
                                <td>Código Tipo de Persona</td>
                            </tr>
                            <tr>
                                <td> <select  id="novedadcausal_novedad_1" name="novedadcausal_novedad_1" onfocus="tabla(flexiNovedadCausal, 'Codigo Tipo Novedad', 'novedadcausal_novedad_1' )" onclick="tabla(flexiNovedadCausal, 'Codigo Tipo Novedad', 'novedadcausal_novedad_1' )"></select></td>
                                <td><input type="text" id="_fecha_novefechsoli_novedad" name="novefechsoli_novedad" value="" maxlength="19" readonly="readonly" /></td>
                                <td> <input type="text" id="_fecha_novefechnove_novedad" name="novefechnove_novedad"/></td>
                                <td> <select  id="tippercodigo_novedad" name="tippercodigo_novedad" onfocus="tabla(flexiTipoPersona, 'Codigo Tipo Novedad', 'tippercodigo_novedad' )" onclick="tabla(flexiTipoPersona, 'Codigo Tipo Novedad', 'tippercodigo_novedad' )"></select></td>
                            </tr>
                            <tr>
                                <td>Archivo Documento Novedad</td>
                                <td>Observaciones Novedad</td>
                            </tr>
                            <tr>
                                <td><input name="novearchivo_novedad" type="text" id="novearchivo_novedad" size="17" value="" readonly="readonly" onclick="abrirCargaArchivo('novearchivo_novedad')" />   <img src="../images/descargar_1.png" width="30" height="30" onclick="reHref('novearchivo_novedad' )" alt="Descargar" /></td>
                                <td colspan="4"> <textarea id="noveobservac_novedad" name="noveobservac_novedad" cols="90" rows="4"></textarea></td>
                            </tr>

                        </table> 
                    </div> 
                    <div id="tabs-2">
                        <div class="boton"><input type="submit" value="Mostrar Novedades Campos Registradas" onclick="tabla(flexiNovedadCampo, 'Novedades Campos Registradas', '' ); return false" /></div> 
                        <br /> 
                        <table> 


                            <tr>
                                <td>Id Usuario (cupo)</td>
                                <td>Codigo Tipo Novedad</td>
                                <td>Codigo Campo en el archivo o Tabla</td>
                                <td>Fecha Novedad</td>
                            </tr>
                            <tr>
                                <td> <input type="text" id="idusuario_novedadcampo" name="idusuario_novedadcampo"/></td>
                                <td> <select  id="codtiponovedad_novedadcampo" name="codtiponovedad_novedadcampo" onfocus="tabla(flexiTipoNovedad, 'C&oacute;digo Tipo Novedad', 'codtiponovedad_novedadcampo' )" onclick="tabla(flexiTipoNovedad, 'C&oacute;digo Tipo Novedad', 'codtiponovedad_novedadcampo' )"></select></td>
                                <td> <select  id="codcampoarchivo_novedadcampo" name="codcampoarchivo_novedadcampo" onfocus="tabla(flexiListaCamposArchivo, 'Codigo Campo en el archivo o Tabla', 'codcampoarchivo_novedadcampo' )" onclick="tabla(flexiListaCamposArchivo, 'Codigo Campo en el archivo o Tabla', 'codcampoarchivo_novedadcampo' )"></select></td>
                                <td><input type="text" id="_fecha_fecha_novedadcampo" name="fecha_novedadcampo" value="" maxlength="19" readonly="readonly" /></td>
                            </tr>
                            <tr>
                                <td>Dato anterior</td>
                                <td>Dato actualizado</td>
                                <td>Encabezado Archivo</td>
                                <td>C&oacute;digo Estado Registro</td>

                            </tr>
                            <tr>
                                <td> <input type="text" id="datoanterior_novedadcampo" name="datoanterior_novedadcampo"/></td>
                                <td> <input type="text" id="datoactualizado_novedadcampo" name="datoactualizado_novedadcampo"/></td>
                                <td> <select  id="idencabezado_novedadcampo" name="idencabezado_novedadcampo" onfocus="tabla(flexiEncabezadoArchivo, 'Encabezado Archivo', 'idencabezado_novedadcampo' )" onclick="tabla(flexiEncabezadoArchivo, 'Encabezado Archivo', 'idencabezado_novedadcampo' )"></select></td>
                                <td> <select  id="codestadoregistro_novedadcampo" name="codestadoregistro_novedadcampo" onfocus="tabla(flexiEstadoRegistro, 'C&oacute;digo Estado Registro', 'codestadoregistro_novedadcampo' )" onclick="tabla(flexiEstadoRegistro, 'C&oacute;digo Estado Registro', 'codestadoregistro_novedadcampo' )"></select></td>

                            </tr>

                            <tr>
                                <td>Observaciones</td>
                            </tr>
                            <tr>
                                <td colspan="4"> <textarea id="observacion_novedadcampo" name="observacion_novedadcampo" cols="110" rows="4"></textarea></td>
                            </tr>


                        </table> 
                    </div> 
                    <div id="tabs-3">
                        <div class="boton"><input type="submit" value="Mostrar Novedades Documentos" onclick="tabla(flexiNovedadDocumento, 'Novedades Documento Registradas', '' ); return false" /></div> 
                        <br /> 
                        <table> 


                            <tr>
                                <td>Consecutivo Novedad</td>
                                <td>Codigo Tipo Documento Asociado</td>
                                <td>Tipo Identificacion Persona Documento</td>
                                <td>Identificación Persona Documento</td>
                            </tr>
                            <tr>
                                <td> <select  id="noveconsecut_novedaddocumento" name="noveconsecut_novedaddocumento" onfocus="tabla(flexiNovedad, 'Consecutivo Novedad', 'noveconsecut_novedaddocumento' )" onclick="tabla(flexiNovedad, 'Consecutivo Novedad', 'noveconsecut_novedaddocumento' )"></select></td>
                                <td> <select  id="documentocausal_novedaddocumento_1" name="documentocausal_novedaddocumento_1" onfocus="tabla(flexiDocumentoCausal, 'Codigo Tipo Documento Asociado', 'documentocausal_novedaddocumento_1' )" onclick="tabla(flexiDocumentoCausal, 'Codigo Tipo Documento Asociado', 'documentocausal_novedaddocumento_1' )"></select></td>
                                <td> <select  id="codtipoidentidad_novedaddocumento" name="codtipoidentidad_novedaddocumento" onfocus="tabla(flexiTipoIdentificacion, 'Codigo Tipo Documento Asociado', 'codtipoidentidad_novedaddocumento' )" onclick="tabla(flexiTipoIdentificacion, 'Codigo Tipo Documento Asociado', 'codtipoidentidad_novedaddocumento' )"></select></td>
                                <td> <input type="text" id="novdocidenti_novedaddocumento" name="novdocidenti_novedaddocumento"/></td>
                            </tr>
                            <tr>
                                <td>Novedad Documento</td>
                                <td>Descripción Documento Novedad</td>
                            </tr>
                            <tr>
                                <td><input name="novdocarchiv_novedaddocumento" type="text" id="novdocarchiv_novedaddocumento" size="17" value="" readonly="readonly" onclick="abrirCargaArchivo('novdocarchiv_novedaddocumento')" />   <img src="../images/descargar_1.png" width="30" height="30" onclick="reHref('novdocarchiv_novedaddocumento' )" alt="Descargar" /></td>
                                <td colspan="4"> <textarea id="novdocdescri_novedaddocumento" name="novdocdescri_novedaddocumento" cols="80" rows="4"></textarea></td>
                            </tr>
                        </table> 
                    </div> 
                </div>  
            </form>  
            <div class="boton"><input type="submit" id="accion2" value="Registrar" onclick="accionFormulario('Novedad', 'Registrar', ''); return false" /> <input type="reset" id="resetFormulario2" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" /> <input type="submit" id="actualizar2" value="Actualizar" onclick="accionFormulario('Novedad', 'Actualizar', ''); return false" class="c2" /> <input type="submit" id="volver_registro2" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>  
        </div>  
        
    </body> 
</html>

