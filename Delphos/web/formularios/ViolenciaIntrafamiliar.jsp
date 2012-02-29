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
        <form action="" method="post"><input type="hidden" id="combo" /> <input type="hidden" id="nombreFormulario" value="ViolenciaIntrafamiliar" /> <input type="hidden" id="servlet" value="ViolenciaIntrafamiliar" /></form>
        <div id="dialog" class="c1">
            <div class="encabezado"></div>
            <div class="titulo">VIOLENCIA INTRAFAMILIAR</div>
            <br />
            <div>
                <form id="ViolenciaIntrafamiliar" method="post" accept-charset="utf-8" name="ViolenciaIntrafamiliar"><input type="hidden" id="codigo" name="codigo" /> 
                    <input type="hidden" name="accion" id="accion" value="" /> 
                    
                    <div class="boton"><input type="submit" value="Mostrar Violencia Intrafamiliar" 
                                              onclick="return tabla(flexiViolenciaIntraFamiliar, 'Violencia Intrafamiliar', '' ); return false" /> 
                        
                        <input type="submit" id="accion1" value="Registrar" onclick="accionFormulario('ViolenciaIntrafamiliar', 'Registrar', ''); return false" /> 
                        <input type="reset" id="resetFormulario1" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" /> 
                        <input type="submit" id="actualizar1" value="Actualizar" onclick="accionFormulario('ViolenciaIntrafamiliar', 'Actualizar', ''); return false" class="c2" />
                        <input type="submit" id="volver_registro1" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>
                    <table>


                        <tr>
                            <td>Número Registro Violencia Intrafamiliar</td>
                            <td>Tipo Identificación Persona Violencia Intrafamiliar</td>
                            <td>Identificación Persona Violencia Intrafamiliar</td>
                            <td>Código Tipo Violencia Intrafamiliar</td>
                        </tr>
                        <tr>
                            <td> <input type="text" id="viointid_violenciaintrafamiliar" name="viointid_violenciaintrafamiliar"/></td>
                            
                            <td> <select  id="codtipoidentidadpe_violenciaintrafamiliar" name="codtipoidentidadpe_violenciaintrafamiliar" 
                                          onfocus="tabla(flexiTipoIdentificacion, '', 'codtipoidentidadpe_violenciaintrafamiliar' )" 
                                          onclick="tabla(flexiTipoIdentificacion, '', 'codtipoidentidadpe_violenciaintrafamiliar' )"></select></td>
                            
                            <td> <input type="text" id="viointidenti_violenciaintrafamiliar" name="viointidenti_violenciaintrafamiliar"/></td>
                            <td> <select  id="tipviocodigo_violenciaintrafamiliar" name="tipviocodigo_violenciaintrafamiliar" onfocus="tabla(flexiTipoViolencia, 'Código Tipo Violencia Intrafamiliar', 'tipviocodigo_violenciaintrafamiliar' )" onclick="tabla(flexiTipoViolencia, 'Código Tipo Violencia Intrafamiliar', 'tipviocodigo_violenciaintrafamiliar' )"></select></td>
                        </tr>
                        <tr>
                            <td>Acción Violencia Intrafamiliar Denunciada (S/N)</td>
                            <td>Tipo Identificacion Persona Presentó Denuncia</td>
                            <td>Identificacion Persona Presentó Denuncia</td>
                            <td>Apellidos Presentó Denuncia</td>
                        </tr>
                        <tr>
                            <td><div id="switch_viointdenunc_violenciaintrafamiliar"></div> <input type="hidden" id="viointdenunc_violenciaintrafamiliar" name="viointdenunc_violenciaintrafamiliar"  /></td>
                            <td> <select  id="codtipoidentidadde_violenciaintrafamiliar" name="codtipoidentidadde_violenciaintrafamiliar" onfocus="tabla(flexiTipoIdentificacion, 'Tipo Identificacion Persona Presentó Denuncia', 'codtipoidentidadde_violenciaintrafamiliar' )" onclick="tabla(flexiTipoIdentificacion, 'Tipo Identificacion Persona Presentó Denuncia', 'codtipoidentidadde_violenciaintrafamiliar' )"></select></td>
                            <td> <input type="text" id="viointideden_violenciaintrafamiliar" name="viointideden_violenciaintrafamiliar"/></td>
                            <td> <input type="text" id="viointapelli_violenciaintrafamiliar" name="viointapelli_violenciaintrafamiliar"/></td>
                        </tr>
                        <tr>
                            <td>Nombres Presentó Denuncia</td>
                            <td>Tipo Identificacion 1 Generó Violencia</td>
                            <td>Identificacion 1 Generó Violencia</td>
                            <td>Apellidos 1 Generó Violencia</td>
                        </tr>
                        <tr>
                            <td> <input type="text" id="viointnombre_violenciaintrafamiliar" name="viointnombre_violenciaintrafamiliar"/></td>
                            <td> <select  id="codtipoidentidadg1_violenciaintrafamiliar" name="codtipoidentidadg1_violenciaintrafamiliar" onfocus="tabla(flexiTipoIdentificacion, 'Tipo Identificacion 1 Generó Violencia', 'codtipoidentidadg1_violenciaintrafamiliar' )" onclick="tabla(flexiTipoIdentificacion, 'Tipo Identificacion 1 Generó Violencia', 'codtipoidentidadg1_violenciaintrafamiliar' )"></select></td>
                            <td> <input type="text" id="violidengen1_violenciaintrafamiliar" name="violidengen1_violenciaintrafamiliar"/></td>
                            <td> <input type="text" id="violapellid1_violenciaintrafamiliar" name="violapellid1_violenciaintrafamiliar"/></td>
                        </tr>
                        <tr>
                            <td>Nombres 1 Generó Violencia</td>
                            <td>Tipo Identificacion 2 Generó Violencia</td>
                            <td>Identificacion 2 Generó Violencia</td>
                            <td>Apellidos 2 Generó Violencia</td>
                        </tr>
                        <tr>
                            <td> <input type="text" id="violnombre1_violenciaintrafamiliar" name="violnombre1_violenciaintrafamiliar"/></td>
                            <td> <select  id="codtipoidentidad_violenciaintrafamiliar" name="codtipoidentidad_violenciaintrafamiliar" onfocus="tabla(flexiTipoIdentificacion, 'Tipo Identificacion 2 Generó Violencia', 'codtipoidentidad_violenciaintrafamiliar' )" onclick="tabla(flexiTipoIdentificacion, 'Tipo Identificacion 2 Generó Violencia', 'codtipoidentidad_violenciaintrafamiliar' )"></select></td>
                            <td> <input type="text" id="violidengen2_violenciaintrafamiliar" name="violidengen2_violenciaintrafamiliar"/></td>
                            <td> <input type="text" id="violapellid2_violenciaintrafamiliar" name="violapellid2_violenciaintrafamiliar"/></td>
                        </tr>
                        <tr>
                            <td>Nombres 2 Generó Violencia</td>
                            <td>Fecha Suceso Violencia IntraFamiliar</td>
                            <td>Archivo Documento Denuncia Queja</td>
                            
                        </tr>
                        <tr>
                            <td> <input type="text" id="violnombre2_violenciaintrafamiliar" name="violnombre2_violenciaintrafamiliar"/></td>
                            <td><input type="text" id="_fecha_viointfecsuc_violenciaintrafamiliar" name="viointfecsuc_violenciaintrafamiliar" value="" maxlength="19" readonly="readonly" /></td>
                            <td><input name="violarchivo_violenciaintrafamiliar" type="text" id="violarchivo_violenciaintrafamiliar" size="17" value="" readonly="readonly" onclick="abrirCargaArchivo('violarchivo_violenciaintrafamiliar')" />   <img src="../images/descargar_1.png" width="30" height="30" onclick="reHref('violarchivo_violenciaintrafamiliar' )" alt="Descargar" /></td>
                            
                        </tr>
                        <tr>
                            <td>Relato Acción de Violencia Intrafamiliar</td>
                        </tr>
                        <tr>
                            <td colspan="4" ><textarea id="violrelato_violenciaintrafamiliar" name="violrelato_violenciaintrafamiliar" cols="110" rows="4"></textarea></td>
                        </tr>
                        <tr>
                            <td>Autoridad Competente donde se Denunció</td>
                        </tr>
                        <tr>
                            <td colspan="4" ><textarea id="viointautori_violenciaintrafamiliar" name="viointautori_violenciaintrafamiliar" cols="110" rows="4"></textarea></td>
                        </tr>
                        
                        <tr>
                            <td>Observaciones Violencia IntraFamiliar</td>
                        </tr>
                        <tr>
                            <td colspan="4"> <textarea id="violobservac_violenciaintrafamiliar" name="violobservac_violenciaintrafamiliar" cols="110" rows="4"></textarea></td>
                        </tr>
                    </table>
                    <br />
                    <!-- Acciones estan 
                                        1 - > registrar
                                        2 -> actualizar -->
                    <div class="boton"><input type="submit" id="accion2" value="Registrar" onclick="accionFormulario('ViolenciaIntrafamiliar', 'Registrar', ''); return false" /> <input type="reset" id="resetFormulario2" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" /> <input type="submit" id="actualizar2" value="Actualizar" onclick="accionFormulario('ViolenciaIntrafamiliar', 'Actualizar', ''); return false" class="c2" />
                        <input type="submit" id="volver_registro2" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>
                </form>
                <div class="boton"></div>
            </div>
        </div>

    </body>
</html>
