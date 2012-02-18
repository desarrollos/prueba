<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %><%@ taglib prefix="jsp2" uri="http://java.sun.com/jstl/core_rt" %><%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"  %><%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %><%
    clases.VerificarUsuarioSistema v;
    v = new clases.VerificarUsuarioSistema(request, response);


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta name="generator" content="HTML Tidy for Linux (vers 6 November 2007), see www.w3.org" />
        <script type="text/javascript" src="../js/jquery/jquery.js">
        </script>
        <title>:: DELPHOS ::</title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <link rel="stylesheet" type="text/css" media="all" href="../css/delphos.css" /><!--<link rel="stylesheet" type="text/css" media="all" href="../js/jsCalendar/skins/aqua/theme.css" title="Aqua" />-->
        <link href="../images/favicon.ico" rel="Shortcut Icon" type="image/x-icon" /><!--  <script type="text/javascript" src="../js/jquery/jquery.js"></script>  -->
        <link type="text/css" href="../js/jquery-ui/css/south-street/jquery-ui-1.8.2.custom.css" rel="Stylesheet" />
        <script type="text/javascript" src="../js/jquery-ui/js/jquery-ui-1.8.2.custom.min.js">
        </script>
        <link rel="stylesheet" type="text/css" href="../css/formularios/general.css" />
        <script type="text/javascript" src="../js/formularios/funciones.js">
        </script>
        <script type="text/javascript" src="../js/formularios/Reclamos.js">
        </script>
        <link rel="stylesheet" type="text/css" href="../js/flexigrid/css/flexigrid.css" />
        <script type="text/javascript" src="../js/flexigrid/js/flexigrid.js">
        </script>
        <script type="text/javascript" src="../js/ajax-switch/ajax-switch/jquery.iphone-switch.js">
        </script>
        <style type="text/css">
            /*<![CDATA[*/
            body {
                background-color: #FFFFFF;
            }
            div.c6 {text-align: center}
            table.c5 {height: 780; border: 0px}
            td.c4 {background: url('../images/back.png')}
            td.c3 {background: url('../images/panel_02.gif')}
            input.c2 {display:none}
            div.c1 {display: none}
            /*]]>*/
        </style>

        <style type="text/css">
            /*<![CDATA[*/
            body {
                background-color: #FFFFFF;
            }
            div.c5 {text-align: center}
            table.c4 {height: 780; border: 0px}
            td.c3 {background: url('../images/back.png')}
            td.c2 {background: url('../images/panel_02.gif')}
            div.c1 {display: none}
            /*]]>*/
        </style>
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
                <div class="boton"><input type="submit" id="accion1" value="Registrar" onclick="accionFormulario('Reclamos', 'Registrar', ''); return false" /> <input type="reset" id="resetFormulario1" value="Limpiar Formulario" onclick="redireccionar(document.URL);return false;" /> <input type="submit" id="actualizar1" value="Actualizar" onclick="accionFormulario('Reclamos', 'Actualizar', ''); return false" class="c2" /> <input type="submit" id="volver_registro1" value="Volver al formulario de registro" onclick="redireccionar(document.URL);return false" class="c2" /></div>
                <br />
                <br />
                <input type="hidden" name="pestana" id="pestana" value="Reuniones" /> <input type="hidden" id="codigo" name="codigo" /> <input type="hidden" name="accion" id="accion" value="" />
                <div id="tabs">
                    <ul>
                        <li><a href="#tabs-1" id="Registros" name="Registros">Registro</a></li>
                        <li><a href="#tabs-2" id="Documentos" name="Documentos">Documentos</a></li>
                        <li><a href="#tabs-3" id="Afectados" name="Afectados">Afectados</a></li>
                        <li><a href="#tabs-4" id="Respuestas" name="Respuestas">Respuestas</a></li>
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
                                <td><select name="codunifami_registro" id="codunifami_registro" 
                                            onfocus="tabla(flexiInscripcion, 'Código &Uacute;nico Familia', 'codunifami_registro' )" 
                                            onclick="tabla(flexiInscripcion, 'Código &Uacute;nico Familia', 'codunifami_registro' )"></select></td>

                                <td><input name="reclamconsec_registro" type="text" id="reclamconsec_registro" value="" /></td>

                                <td><select name="codtipoidentidadper_registro" id="codtipoidentidadper_registro" 
                                            onfocus="tabla(flexiTipoIdentificacion, 'Tipo Identificaci', 'codtipoidentidadper_registro' )" 
                                            onclick="tabla(flexiTipoIdentificacion, 'Departamento', 'codtipoidentidadper_registro' )"></select></td>

                                <td><input name="reclamidentiper_registro" type="text" id="reclamidentiper_registro" value="" /></td>
                                <td><input name="reclamfecha_registro" type="text" id="_fecha_reclamfecha_registro" value="" /></td>
                            </tr>
                            <tr>
                                <td>C&oacute;digo Departamento</td>
                                <td>C&oacute;digo Municipio</td>
                                <td>C&oacute;digo Tipo Reclamo</td>
                                <td>C&oacute;digo Clasificaci&oacute;n Reclamo</td>
                                <td>Cilo Pago Afectado</td>


                            </tr>
                            <tr>
                                <td><select name="coddepartamento_registro" id="coddepartamento_registro" 
                                            onfocus="tabla(flexiDepartamento, 'Departamento', 'coddepartamento_registro' )" 
                                            onclick="tabla(flexiDepartamento, 'Departamento', 'coddepartamento_registro' )"></select></td>

                                <td><select name="codmunicipio_registro" id="codmunicipio_registro" 
                                            onfocus="tabla(flexiMunicipio, 'Departamento', 'codmunicipio_registro' )" 
                                            onclick="tabla(flexiMunicipio, 'Departamento', 'codmunicipio_registro' )"></select></td>

                                <td><select name="rectipcodigo_registro" id="rectipcodigo_registro" 
                                            onfocus="tabla(flexiTipoReclamo, 'Codigo Tipo Reclamo', 'rectipcodigo_registro' )" 
                                            onclick="tabla(flexiTipoReclamo, 'Codigo Tipo Reclamo', 'rectipcodigo_registro' )"></select></td>


                                <td><select name="recclacodigo_registro" id="recclacodigo_registro" 
                                            onfocus="tabla(flexiClasificacionReclamo, 'Departamento', 'recclacodigo_registro' )" 
                                            onclick="tabla(flexiClasificacionReclamo, 'Departamento', 'recclacodigo_registro' )"></select></td>

                                <td><input name="reclciclpago_registro" type="text" id="reclciclpago_registro" value="" /></td>



                            </tr>

                            <tr>
                                <td>Tipo Identificaci&oacute;n Funcionario Recibe Reclamo</td>
                                <td>Identificaci&oacute;n Funcionario Recibe Reclamo</td>
                                <td>Archivo Documento Reclamo</td>
                                <td>Observaciones</td>

                            </tr>
                            <tr>
                                <td><select name="codtipoidentidad_registro" id="codtipoidentidad_registro" 
                                            onfocus="tabla(flexiTipoIdentificacion, 'Tipo Identificación', 'codtipoidentidad_registro' )" 
                                            onclick="tabla(flexiTipoIdentificacion, 'Tipo Identificación', 'codtipoidentidad_registro' )"></select></td>

                                <td><input name="numidentfunc_registro" type="text" id="numidentfunc_registro" value="" /></td>

                                <td><input name="reclarchdocu_registro" type="text" id="reclarchdocu_registro"
                                           size="17" value="" readonly="readonly" onclick="abrirCargaArchivo('reclarchdocu_registro')" /> 
                                    <img src="../images/descargar_1.png" width="30" height="30"  alt="Subir Archivo" onclick="reHref('reclarchdocu_registro' )" /></td>

                                <td colspan="2">
                                    <textarea name="reclamobserv_registro" id="reclamobserv_registro" cols="40" rows="4"></textarea>
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
            <div class="boton"><input type="submit" id="accion2" value="Registrar" onclick="accionFormulario('Reclamos', 'Registrar', ''); return false" /> <input type="reset" id="resetFormulario2" value="Limpiar Formulario" onclick="redireccionar(document.URL);return false;" /> <input type="submit" id="actualizar2" value="Actualizar" onclick="accionFormulario('Reclamos', 'Actualizar', ''); return false" class="c2" /> <input type="submit" id="volver_registro2" value="Volver al formulario de registro" onclick="redireccionar(document.URL);return false" class="c2" /></div>
        </div>
        <div class="c5">
            <table id="Table_01" width="906" class="c4" cellpadding="0" cellspacing="0">
                <tr>
                    <td colspan="3"><img src="../images/cabezote.png" width="906" height="150" alt="" /></td>
                </tr>
                <%-- Datos sesion --%>
                <tr valign="top">
                    <td colspan="3" width="906" height="16" class="c2" align="right"><span class="textoPequeno"><%=request.getSession().getAttribute("nombre")%> <%=request.getSession().getAttribute("apellido")%></span><a href="../logout.jsp"><img src="../images/log_out.png" border="0" alt="Cerrar sesion" width="20" height="20" /></a></td>
                </tr>
                <%-- Datos sesion --%>
                <tr>
                    <td class="c3" width="234" valign="top">
                        <table cellpadding="0" cellspacing="0">
                            <tr>
                                <td align="left" valign="top"></td>
                            </tr>
                        </table>
                    </td>
                    <td valign="top"></td>
                </tr>
                <tr>
                    <td></td>
                </tr>
                <tr>
                    <td height="42" colspan="3"><img src="../images/panel_07.gif" width="906" height="23" alt="" /></td>
                </tr>
            </table>
        </div>
    </body>
