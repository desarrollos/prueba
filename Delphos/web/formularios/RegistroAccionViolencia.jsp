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
        <form><input type="hidden" id="respuestaAjax" /></form>
        <input type="hidden" name="servletActivo" id="servletActivo"/>
        <div id="tablaContenedor"></div>
        <form action="" method="post"><input type="hidden" id="combo" /> <input type="hidden" id="nombreFormulario" value="RegistroAccionViolencia" /> <input type="hidden" id="servlet" value="RegistroAccionViolencia" /></form>
        <div id="dialog" class="c1">
            <div class="encabezado"></div>
            <div class="titulo">Registro Acción Violencia</div> 
            <br />
            <div>
                <form id="RegistroAccionViolencia" method="post" accept-charset="utf-8" name="RegistroAccionViolencia"><input type="hidden" id="codigo" name="codigo" />
                    <input type="hidden" name="accion" id="accion" value="" />  
                    <div class="boton"><input type="submit" value="Mostrar Registro Acción Violencia " onclick="return tabla(flexiViolenciaIntraFamiliar, 'Registro Acción Violencia', '' )" />
                        <input type="submit" id="accion1" value="Registrar" onclick="accionFormulario('RegistroAccionViolencia', 'Registrar', ''); return false" />
                        <input type="reset" id="resetFormulario1" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" />
                        <input type="submit" id="actualizar1" value="Actualizar" onclick="accionFormulario('RegistroAccionViolencia', 'Actualizar', ''); return false" class="c2" />
                        <input type="submit" id="volver_registro1" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>
                        <br/>
                    <table>
                        <tr>
                            <td>Número Registro</td>
                            <td>Fecha Suceso</td>
                            <td>Tipo Identificación</td>
                            <td>Identificación Persona Afectada</td>
                        </tr>
                        <tr>
                            <td> <input type="text" id="viointid_violenciaintrafamiliar" name="viointid_violenciaintrafamiliar"/></td>
                            <td><input type="text" id="_fecha_viointfecsuc_violenciaintrafamiliar" name="viointfecsuc_violenciaintrafamiliar" value="" maxlength="19" readonly="readonly" /></td>
                            <td> <select  id="codtipoidentidadpe_violenciaintrafamiliar" name="codtipoidentidadpe_violenciaintrafamiliar" onfocus="tabla(flexiTipoIdentificacion, 'Tipo Identificación', 'codtipoidentidadpe_violenciaintrafamiliar' )" onclick="tabla(flexiTipoIdentificacion, 'Tipo Identificación', 'codtipoidentidadpe_violenciaintrafamiliar' )"></select></td>
                            <td> <input type="text" id="viointidenti_violenciaintrafamiliar" name="viointidenti_violenciaintrafamiliar"/></td>
                        </tr>
                        <tr>
                            <td>Tipo Violencia</td>
                            <td>Violencia fue Denunciada (S/N)</td>
                            <td>Autoridad donde acudio</td>
                            <td>Tipo Identificacion Presentó Denuncia</td>
                        </tr>
                        <tr>
                            <td> <select  id="tipviocodigo_violenciaintrafamiliar" name="tipviocodigo_violenciaintrafamiliar" onfocus="tabla(flexiTipoViolencia, 'Tipo Violencia Intrafamiliar', 'tipviocodigo_violenciaintrafamiliar' )" onclick="tabla(flexiTipoViolencia, 'Tipo Violencia Intrafamiliar', 'tipviocodigo_violenciaintrafamiliar' )"></select></td>
                            <td><div id="switch_viointdenunc_violenciaintrafamiliar"></div> <input type="hidden" id="viointdenunc_violenciaintrafamiliar" name="viointdenunc_violenciaintrafamiliar"  /></td>
                            <td> <input type="text" id="viointautori_violenciaintrafamiliar" name="viointautori_violenciaintrafamiliar"/></td>
                            <td> <select  id="codtipoidentidadde_violenciaintrafamiliar" name="codtipoidentidadde_violenciaintrafamiliar" onfocus="tabla(flexiTipoIdentificacion, 'Tipo Identificacion Presentó Denuncia', 'codtipoidentidadde_violenciaintrafamiliar' )" onclick="tabla(flexiTipoIdentificacion, 'Tipo Identificacion Presentó Denuncia', 'codtipoidentidadde_violenciaintrafamiliar' )"></select></td>
                        </tr>
                        <tr>
                            <td> Identificacion Denunciante</td>
                            <td>Apellidos Denunciante</td>
                            <td>Nombres Denunciante</td>
                            <td>Tipo Identificacion Denunciado</td>
                        </tr>
                        <tr>
                            <td> <input type="text" id="viointideden_violenciaintrafamiliar" name="viointideden_violenciaintrafamiliar"/></td>
                            <td> <input type="text" id="viointapelli_violenciaintrafamiliar" name="viointapelli_violenciaintrafamiliar"/></td>
                            <td> <input type="text" id="viointnombre_violenciaintrafamiliar" name="viointnombre_violenciaintrafamiliar"/></td>
                            <td> <select  id="codtipoidentidadg1_violenciaintrafamiliar" name="codtipoidentidadg1_violenciaintrafamiliar" onfocus="tabla(flexiTipoIdentificacion, 'Tipo Identificacion Denunciado', 'codtipoidentidadg1_violenciaintrafamiliar' )" onclick="tabla(flexiTipoIdentificacion, 'Tipo Identificacion Denunciado', 'codtipoidentidadg1_violenciaintrafamiliar' )"></select></td>
                        </tr>
                        <tr>
                            <td>Identificacion Denunciado 1</td>
                            <td>Apellidos Denunciado 1</td>
                            <td>Nombres Denunciado 1</td>
                            <td>Tipo Identificacion Denunciado 2</td>
                        </tr>
                        <tr>
                            <td> <input type="text" id="violidengen1_violenciaintrafamiliar" name="violidengen1_violenciaintrafamiliar"/></td>
                            <td> <input type="text" id="violapellid1_violenciaintrafamiliar" name="violapellid1_violenciaintrafamiliar"/></td>
                            <td> <input type="text" id="violnombre1_violenciaintrafamiliar" name="violnombre1_violenciaintrafamiliar"/></td>
                            <td> <select  id="codtipoidentidad_violenciaintrafamiliar" name="codtipoidentidad_violenciaintrafamiliar" onfocus="tabla(flexiTipoIdentificacion, 'Tipo Identificacion Denunciado 2', 'codtipoidentidad_violenciaintrafamiliar' )" onclick="tabla(flexiTipoIdentificacion, 'Tipo Identificacion Denunciado 2', 'codtipoidentidad_violenciaintrafamiliar' )"></select></td>
                        </tr>
                        <tr>
                            <td>Identificacion Denunciado 2</td>
                            <td>Apellidos Denunciado 2</td>
                            <td>Nombres Denunciado 2</td>
                            <td>Documento Denuncia o Queja</td>
                        </tr>
                        <tr>
                            <td> <input type="text" id="violidengen2_violenciaintrafamiliar" name="violidengen2_violenciaintrafamiliar"/></td>
                            <td> <input type="text" id="violapellid2_violenciaintrafamiliar" name="violapellid2_violenciaintrafamiliar"/></td>
                            <td> <input type="text" id="violnombre2_violenciaintrafamiliar" name="violnombre2_violenciaintrafamiliar"/></td>
                            <td><input name="violarchivo_violenciaintrafamiliar" type="text" id="violarchivo_violenciaintrafamiliar" size="17" value="" readonly="readonly" onclick="abrirCargaArchivo('violarchivo_violenciaintrafamiliar')" />   <img src="../images/descargar_1.png" width="30" height="30" onclick="reHref('violarchivo_violenciaintrafamiliar' )" alt="Descargar" /></td>
                        </tr>
                        <tr>
                            <td>Relato Acción de Violencia Intrafamiliar</td>
                            
                        </tr>
                        <tr>
                            <td  colspan="4" > <textarea id="violrelato_violenciaintrafamiliar" name="violrelato_violenciaintrafamiliar" cols="101" rows="4"></textarea></td>
                        </tr>
                        <tr>
                            <td>Observaciones Violencia IntraFamiliar</td>
                        </tr>
                        <tr>
                            <td  colspan="4" > <textarea id="violobservac_violenciaintrafamiliar" name="violobservac_violenciaintrafamiliar" cols="101" rows="4"></textarea></td>
                        </tr>
                    </table>
                    <br />
                    <div class="boton"><input type="submit" id="accion2" value="Registrar" onclick="accionFormulario('RegistroAccionViolencia', 'Registrar', ''); return false" />
                        <input type="reset" id="resetFormulario2" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" />
                        <input type="submit" id="actualizar2" value="Actualizar" onclick="accionFormulario('RegistroAccionViolencia', 'Actualizar', ''); return false" class="c2" />
                        <input type="submit" id="volver_registro2" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>
                </form>
                <div class="boton"></div>
            </div>
        </div>
     
    </body>
</html>

