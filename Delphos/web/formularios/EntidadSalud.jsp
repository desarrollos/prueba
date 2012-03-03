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
        <form action="" method="post"><input type="hidden" id="combo" /> <input type="hidden" id="nombreFormulario" value="Entidades de salud" /> <input type="hidden" id="servlet" value="EntidadSalud" /></form>
        <div id="dialog" class="c1">
            <div class="encabezado"></div>
            <div class="titulo">ENTIDADES DE SALUD</div>
            <br />
            <div>
                <form id="EntidadSalud" method="post" accept-charset="utf-8" name="EntidadSalud"><input type="hidden" id="codigo" name="codigo" /> <input type="hidden" id="codregimentabla" name="codregimentabla" /> <input type="hidden" name="accion" id="accion" value="" />
                    <div class="boton"><input type="submit" value="Mostrar Entidades Registradas" onclick="return tabla(flexiEntidadSalud, 'Entidades de Salud', '' )" /> <input type="submit" id="accion1" value="Registrar" onclick="accionFormulario('EntidadSalud', 'Registrar', ''); return false" /> <input type="reset" id="resetFormulario1" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" /> <input type="submit" id="actualizar1" value="Actualizar" onclick="accionFormulario('EntidadSalud', 'Actualizar', ''); return false" class="c2" /> <input type="submit" id="volver_registro1" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>
                    <table>

                        <tr>
                            <td>Codigo Regimen</td>
                            <td>Codigo Entidad Salud</td>
                            <td>Empresa</td>
                            <td>Codigo Tipo Entidad Salud</td>
                        </tr>
                        <tr>
                            <td> <select  id="codregimenes_entidadsalud" name="codregimenes_entidadsalud" onfocus="tabla(flexiRegimen, 'Codigo Regimen', 'codregimenes_entidadsalud' )" onclick="tabla(flexiRegimen, 'Codigo Regimen', 'codregimenes_entidadsalud' )"></select></td>
                            <td> <input type="text" id="codentidadsalud_entidadsalud" name="codentidadsalud_entidadsalud"/></td>
                            <td> <select  id="empresa_entidadsalud_1" name="empresa_entidadsalud_1" onfocus="tabla(flexiEmpresas, 'Empresa', 'empresa_entidadsalud_1' )" onclick="tabla(flexiEmpresas, 'Empresa', 'empresa_entidadsalud_1' )"></select></td>
                            <td> <select  id="codtipoentidadsalud_entidadsalud" name="codtipoentidadsalud_entidadsalud" onfocus="tabla(flexiEntidad, 'Codigo Tipo Entidad Salud', 'codtipoentidadsalud_entidadsalud' )" onclick="tabla(flexiEntidad, 'Codigo Tipo Entidad Salud', 'codtipoentidadsalud_entidadsalud' )"></select></td>
                        </tr>
                        <tr>
                            <td>Codigo Nivel Complejidad</td>
                            <td>Codigo Clasificacion Entidad Salud</td>
                            <td>Nombre del contacto</td>
                            <td>Nombre Cargo Contacto</td>
                        </tr>
                        <tr>
                            <td> <select  id="codnivelcomplejidad_entidadsalud" name="codnivelcomplejidad_entidadsalud" onfocus="tabla(flexiEntidad, 'Codigo Nivel Complejidad', 'codnivelcomplejidad_entidadsalud' )" onclick="tabla(flexiEntidad, 'Codigo Nivel Complejidad', 'codnivelcomplejidad_entidadsalud' )"></select></td>
                            <td> <select  id="codclasifentidad_entidadsalud" name="codclasifentidad_entidadsalud" onfocus="tabla(flexiClasificacionentidad, 'Codigo Clasificacion Entidad Salud', 'codclasifentidad_entidadsalud' )" onclick="tabla(flexiClasificacionentidad, 'Codigo Clasificacion Entidad Salud', 'codclasifentidad_entidadsalud' )"></select></td>
                            <td> <input type="text" id="contacto_entidadsalud" name="contacto_entidadsalud"/></td>
                            <td> <input type="text" id="cargocontacto_entidadsalud" name="cargocontacto_entidadsalud"/></td>
                        </tr>
                        <tr>
                            <td>Numero Telefonico Linea Gratuita</td>
                            <td>Numero Funcionarios</td>
                            <td>Codigo Barras</td>
                            <td>Slogan Empresa</td>
                        </tr>
                        <tr>
                            <td> <input type="text" id="lineagratuita_entidadsalud" name="lineagratuita_entidadsalud"/></td>
                            <td> <input type="text" id="funcionarios_entidadsalud" name="funcionarios_entidadsalud"/></td>
                            <td> <input type="text" id="codigobarras_entidadsalud" name="codigobarras_entidadsalud"/></td>
                            <td> <input type="text" id="slogan_entidadsalud" name="slogan_entidadsalud"/></td>
                        </tr>
                        <tr>
                            <td>Codigo Habilitacion</td>
                            <td>Nombre Habilitacion</td>
                            <td>Codigo Tipo Especializacion Salud</td>
                        </tr>
                        <tr>
                            <td> <input type="text" id="codhabilitacion_entidadsalud" name="codhabilitacion_entidadsalud"/></td>
                            <td> <input type="text" id="nombrehabilitacion_entidadsalud" name="nombrehabilitacion_entidadsalud"/></td>
                            <td> <select  id="codtipoespecializacion_entidadsalud" name="codtipoespecializacion_entidadsalud" onfocus="tabla(flexiTipoespecializacionsalud, 'Codigo Tipo Especializacion Salud', 'codtipoespecializacion_entidadsalud' )" onclick="tabla(flexiTipoespecializacionsalud, 'Codigo Tipo Especializacion Salud', 'codtipoespecializacion_entidadsalud' )"></select></td>
                        </tr>
                        <tr>
                            <td>Codigo Tipo Atencion Salud</td>
                            <td>Codigo Estado Entidad Salud</td>
                            <td>Numero Acto Inscripcion</td>
                            <td>Fecha Acto Administrativo</td>
                        </tr>
                        <tr>
                            <td> <select  id="codtipoatencion_entidadsalud" name="codtipoatencion_entidadsalud" onfocus="tabla(flexiTipoatencion, 'Codigo Tipo Atencion Salud', 'codtipoatencion_entidadsalud' )" onclick="tabla(flexiTipoatencion, 'Codigo Tipo Atencion Salud', 'codtipoatencion_entidadsalud' )"></select></td>
                            <td> <select  id="codestadoentidad_entidadsalud" name="codestadoentidad_entidadsalud" onfocus="tabla(flexiEstadoentidadsalud, 'Codigo Estado Entidad Salud', 'codestadoentidad_entidadsalud' )" onclick="tabla(flexiEstadoentidadsalud, 'Codigo Estado Entidad Salud', 'codestadoentidad_entidadsalud' )"></select></td>
                            <td> <input type="text" id="numactoinscripcion_entidadsalud" name="numactoinscripcion_entidadsalud"/></td>
                            <td><input type="text" id="_fecha_fechaactoadmin_entidadsalud" name="fechaactoadmin_entidadsalud" value="" maxlength="19" readonly="readonly" /></td>
                        </tr>
                        <tr>
                            <td>Archivo Físico</td>
                            <td>Archivo Físico 2</td>
                            <td>Logo</td>
                            <td>Archivo Acto Admin</td>
                        </tr>
                        <tr>
                            <td><input name="archivofi_entidadsalud" type="text" id="archivofi_entidadsalud" size="17" value="" readonly="readonly" onclick="abrirCargaArchivo('archivofi_entidadsalud')" />   <img src="../images/descargar_1.png" width="30" height="30" onclick="reHref('archivofi_entidadsalud' )" alt="Descargar" /></td>
                            <td><input name="archivofi2_entidadsalud" type="text" id="archivofi2_entidadsalud" size="17" value="" readonly="readonly" onclick="abrirCargaArchivo('archivofi2_entidadsalud')" />   <img src="../images/descargar_1.png" width="30" height="30" onclick="reHref('archivofi2_entidadsalud' )" alt="Descargar" /></td>
                            <td><input name="logo_entidadsalud" type="text" id="logo_entidadsalud" size="17" value="" readonly="readonly" onclick="abrirCargaArchivo('logo_entidadsalud')" />   <img src="../images/descargar_1.png" width="30" height="30" onclick="reHref('logo_entidadsalud' )" alt="Descargar" /></td>
                            <td><input name="archivoactoadmin_entidadsalud" type="text" id="archivoactoadmin_entidadsalud" size="17" value="" readonly="readonly" onclick="abrirCargaArchivo('archivoactoadmin_entidadsalud')" />   <img src="../images/descargar_1.png" width="30" height="30" onclick="reHref('archivoactoadmin_entidadsalud' )" alt="Descargar" /></td>
                        </tr>
                    </table>
                    <br />
                    <!-- Acciones estan 
                                        1 - > registrar
                                        2 -> actualizar -->
                    <div class="boton"><input type="submit" id="accion2" value="Registrar" onclick="accionFormulario('EntidadSalud', 'Registrar', ''); return false" /> <input type="reset" id="resetFormulario2" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" /> <input type="submit" id="actualizar2" value="Actualizar" onclick="accionFormulario('EntidadSalud', 'Actualizar', ''); return false" class="c2" /> <!-- <input type="submit" id="eliminar2" value="Eliminar" onclick="accionFormulario('EntidadSalud', 'Eliminar', ''); return false" style="display:none" />-->
                        <input type="submit" id="volver_registro2" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>
                </form>
                <div class="boton"></div>
            </div>
        </div>

    </body>
</html>
