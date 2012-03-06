<%@ include file="config.jsp" %>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <jsp:include page="scripts.jsp"> 	
            <jsp:param name="js" value="<%= request.getServletPath() %>" />
        </jsp:include>
    </head>
    <body>
        <div id="ajax" class="c1"></div>
        <div id="mensaje" class="c1"></div><div id="reporte"></div>
        <form><input type="hidden" id="respuestaAjax" /> <!-- Aqui saldra el flexigrid para la tabla --></form>
        <input type="hidden" name="servletActivo" id="servletActivo"/>
        <div id="tablaContenedor"></div>
        <form action="" method="post"><input type="hidden" id="combo" /> <input type="hidden" id="nombreFormulario" value="FirmasAutorizadas" /> <input type="hidden" id="servlet" value="FirmasAutorizadas" /></form>
        <div id="dialog" class="c1">
            <div class="encabezado"></div>
            <div class="titulo">FIRMAS AUTORIZADAS</div>
            <br />
            <div>
                <form id="FirmasAutorizadas" method="post" accept-charset="utf-8" name="FirmasAutorizadas"><input type="hidden" id="codigo" name="codigo" /> 
                    <input type="hidden" name="accion" id="accion" value="" /> 
                    <div class="boton"><input type="submit" value="Mostrar Firmas Autorizadas" onclick="return tabla(flexiFirmasAutorizadas, 'Firmas Autorizadas', '' )" /> 
                        <input type="submit" id="accion1" value="Registrar" onclick="accionFormulario('FirmasAutorizadas', 'Registrar', ''); return false" /> 
                        <input type="reset" id="resetFormulario1" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" /> 
                        <input type="submit" id="actualizar1" value="Actualizar" onclick="accionFormulario('FirmasAutorizadas', 'Actualizar', ''); return false" class="c2" />
                        <input type="submit" id="volver_registro1" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>
                    <table>
                        <tr>
                            <td>Tipo de Identificaci&oacute;n</td>
                            <td>Identificaci&oacute;n Firma Autorizada</td>
                            <td>Identificaci&oacute;n Instituci&oacute;n Educativa</td>


                        </tr>
                        <tr>
                            <td><select name="codtipoidentidadfir_firmasautorizadas" id="codtipoidentidadfir_firmasautorizadas" 
                                        onfocus="tabla(flexiTipoIdentificacion, 'Tipo Identificacion',
                                            'codtipoidentidadfir_firmasautorizadas' )" onclick="tabla(flexiTipoIdentificacion, 
                                            'Tipo Identificacion', 'codtipoidentidadfir_firmasautorizadas' )"></select></td>

                            <td><input name="firmidentifi_firmasautorizadas" type="text" id="firmidentifi_firmasautorizadas" value="" /></td>

                            <td><select name="empresa_firmasautorizadas_1" id="empresa_firmasautorizadas_1" 
                                        onfocus="tabla(flexiEmpresas, 'Empresa',
                                            'empresa_firmasautorizadas_1' )" onclick="tabla(flexiEmpresas, 
                                            'Empresa', 'empresa_firmasautorizadas_1' )"></select>
                            </td>
                        </tr>
                        <tr>
                            <td>Nombre1 Firma Autorizada</td>
                            <td>Nombre2 Firma Autorizada</td>
                            <td>Apellido1 Firma Autorizada</td>
                            <td>Apellido2 Firma Autorizada</td>
                        </tr>
                        <tr>

                            <td><input name="firmnombre1_firmasautorizadas" type="text" id="firmnombre1_firmasautorizadas" value="" /></td>
                            <td><input name="firmnombre2_firmasautorizadas" type="text" id="firmnombre2_firmasautorizadas" value="" /></td>
                            <td><input name="firmapellido1_firmasautorizadas" type="text" id="firmapellido1_firmasautorizadas" value="" /></td>
                            <td><input name="firmapellido2_firmasautorizadas" type="text" id="firmapellido2_firmasautorizadas" value="" /></td>

                        </tr>
                        <tr>
                            <td>Fecha Inicial Vigencia Firma Autorizada</td>
                            <td>Fecha Final Vigencia Firma Autorizada</td>
                            <td>Firma Autorizada</td>
                            <td>Archivo Documento Autorizando Firma</td>
                        </tr>
                        <tr>
                            <td><input name="firmfechinic_firmasautorizadas" type="text" id="_fecha_firmfechinic_firmasautorizadas" value="" /></td>
                            <td><input name="firmfechfina_firmasautorizadas" type="text" id="_fecha_firmfechfina_firmasautorizadas" value="" /></td>
                            <td><input name="firmfirma_firmasautorizadas" type="text" id="firmfirma_firmasautorizadas" value="" /></td>
                            <td><input name="firmarchivo_firmasautorizadas" type="text" id="firmarchivo_firmasautorizadas" size="15" value="" readonly="readonly" 
                                       onclick="abrirCargaArchivo('firmarchivo_firmasautorizadas')" /> 
                                <img src="../images/descargar_1.png" width="30" height="30" onclick="reHref('firmarchivo_firmasautorizadas' )" alt="Descargar" /></td>
                        </tr>

                        <tr>
                            <td colspan="2">Observaciones Firma Autorizada</td>
                            <td>Huella Dactilar Asignada</td>
                            <td>Huella Dactilar</td>
                        </tr>
                        <tr>
                            <td colspan="2"><textarea name="firmobservac_firmasautorizadas" id="firmobservac_firmasautorizadas" cols="50" rows="3"> </textarea></td>
                            <td><div id="switch_tienehuella_firmasautorizadas"></div>
                                <input type="hidden" name="tienehuella_firmasautorizadas" id="tienehuella_firmasautorizadas" /></td>
                             <td><input name="huelladactilar_firmasautorizadas" type="text" id="huelladactilar_firmasautorizadas" size="15" value="" readonly="readonly" 
                                       onclick="abrirCargaArchivo('huelladactilar_firmasautorizadas')" /> 
                                <img src="../images/descargar_1.png" width="30" height="30" onclick="reHref('huelladactilar_firmasautorizadas' )" alt="Descargar" /></td>
                        </tr>
                        <tr>
                            <td>Foto</td>
                        </tr>
                        <tr>
                            <td><input name="foto_firmasautorizadas" type="text" id="foto_firmasautorizadas" size="15" value="" readonly="readonly" 
                                       onclick="abrirCargaArchivo('foto_firmasautorizadas')" /> 
                                <img src="../images/descargar_1.png" width="30" height="30" onclick="reHref('foto_firmasautorizadas' )" alt="Descargar" /></td>
                        </tr>
                    </table>
                    <br />
                    <!-- Acciones estan 
                                        1 - > registrar
                                        2 -> actualizar -->
                    <div class="boton"><input type="submit" id="accion2" value="Registrar" onclick="accionFormulario('FirmasAutorizadas', 'Registrar', ''); return false" /> <input type="reset" id="resetFormulario2" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" /> <input type="submit" id="actualizar2" value="Actualizar" onclick="accionFormulario('FirmasAutorizadas', 'Actualizar', ''); return false" class="c2" />
                        <input type="submit" id="volver_registro2" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>
                </form>
                <div class="boton"></div>
            </div>
        </div>
        
    </body>
</html>
