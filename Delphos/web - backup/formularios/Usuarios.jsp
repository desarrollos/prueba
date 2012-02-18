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
        <div id="mensaje" class="c1"></div>
        <form><input type="hidden" id="respuestaAjax" /> <!-- Aqui saldra el flexigrid para la tabla --></form>
        <div id="tablaContenedor"></div>
        <form><input type="hidden" id="combo" /> <input type="hidden" id="nombreFormulario" value="Esquema seguridad Delphos" /> <input type="hidden" id="servlet" value="UsuariosSistema" /></form>
        <div id="dialog" class="c1">
            <div class="encabezado"></div>
            <div class="titulo">ESQUEMA DE SEGURIDAD DELPHOS</div>
            <br />
            <form id="UsuariosSistema"><input type="hidden" id="codigo" name="codigo" /> <input type="hidden" name="accion" id="accion" value="" /> <input type="hidden" name="pestana" id="pestana" value="Usuarios" />
                <div class="boton"><input type="submit" id="accion1" value="Registrar" onclick="accionFormulario('UsuariosSistema', 'Registrar', ''); return false" /> <input type="reset" id="resetFormulario1" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" /> <input type="submit" id="actualizar1" value="Actualizar" onclick="accionFormulario('UsuariosSistema', 'Actualizar', ''); return false" class="c2" /> <input type="submit" id="volver_registro1" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>
                <br /><br />
                <div id="tabs">
                    <ul>
                        <li><a href="#tabs-1" id="Usuarios">Usuarios</a></li>
                        <li><a href="#tabs-2" id="Grupos">Grupos</a></li>
                        <li><a href="#tabs-3" id="Paginas">Páginas</a></li>
                        <li><a href="#tabs-4" id="Perfiles">Perfiles</a></li>
                        <li><a href="#tabs-5" id="Estados">Estados</a></li>
                        <li><a href="#tabs-6" id="Permisos">Permisos</a></li>
                    </ul>
                    <div id="tabs-1"><br />
                        <div class="boton"><input type="submit" value="Mostrar Usuarios Registrados" onclick="return tabla(flexiUsuarios, 'Usuarios Sistema', '' )" /></div>
                        <br />
                        <table>
                            <tr>
                                <td>Código Usuario Sistema <span class="obligatorio">(*)</span></td>
                                <td>Usuario Sistema<span class="obligatorio">(*)</span></td>
                                <td>Código Alterno Usuario<span class="obligatorio">(*)</span></td>
                                <td>Nombres Usuario<span class="obligatorio">(*)</span></td>
                                <td>Apellidos Usuario<span class="obligatorio">(*)</span></td>
                            </tr>
                            <tr>
                                <td><input name="ususiscodigo_usuarios" type="text" id="ususiscodigo_usuarios" value="" /></td>
                                <td><input name="ususisusuario_usuarios" type="text" id="ususisusuario_usuarios" value="" /></td>
                                <td><input name="ususiscodigoalt_usuarios" type="text" id="ususiscodigoalt_usuarios" value="" /></td>
                                <td><input name="ususisnombre_usuarios" type="text" id="ususisnombre_usuarios" value="" /></td>
                                <td><input name="ususisapellido_usuarios" type="text" id="ususisapellido_usuarios" value="" /></td>
                            </tr>
                            <tr>
                                <td>Tipo Identificación<span class="obligatorio">(*)</span></td>
                                <td>Número Identificación<span class="obligatorio">(*)</span></td>
                                <td>Código Grupo Usuario<span class="obligatorio">(*)</span></td>
                                <td>Permitir Multisesion<span class="obligatorio">(*)</span></td>
                                <td>Código Estado Usuario<span class="obligatorio">(*)</span></td>
                            </tr>
                            <tr>
                                <td><select name="codtipoidentidad_usuarios" id="codtipoidentidad_usuarios" onfocus="tabla(flexiTipoIdentificacion, 'Tipo Identificación', 'codtipoidentidad_usuarios' )" onclick="tabla(flexiTipoIdentificacion, 'Tipo Identificación', 'codtipoidentidad_usuarios' )"></select></td>
                                <td><input name="ususisindenfica_usuarios" type="text" id="ususisindenfica_usuarios" value="" /></td>
                                <td><select name="grusegcodigo_usuarios" id="grusegcodigo_usuarios" onfocus="tabla(flexiGruposSeguridad, 'Grupos Seguridad', 'grusegcodigo_usuarios' )" onclick="tabla(flexiGruposSeguridad, 'Grupos Seguridad', 'grusegcodigo_usuarios' )"></select></td>
                                <td>
                                    <!--Si <input type="radio" name="ususismultisesion_usuarios" id="ususismultisesion_s_usuarios" value="s" checked="checked" /> No <input type="radio" name="ususismultisesion_usuarios" id="ususismultisesion_n_usuarios" value="n" />-->

                                    <div id="switch_ususismultisesion_usuarios"></div>
                                    <input type="hidden" name="ususismultisesion_usuarios" id="ususismultisesion_usuarios" /></td>

                                </td>
                                <td><select name="codestusuasistema_usuarios" id="codestusuasistema_usuarios" onfocus="tabla(flexiEstadoUsuario, 'Estado Usuario Sistema', 'codestusuasistema_usuarios' )" onclick="tabla(flexiEstadoUsuario, 'Estado Usuario Sistema', 'codestusuasistema_usuarios' )"></select></td>
                            </tr>
                            <tr>
                                <td>Pertene Entidad Sistema<span class="obligatorio">(*)</span></td>
                                <td>Tiene Huella Digital</td>
                                <td>Huella dactilar</td>
                                <td>Foto</td>
                            </tr>
                            <tr>
                                <td>
                                    <!--Si <input type="radio" name="ususisinterno_usuarios" id="ususisinterno_s_usuarios" value="s" checked="checked" /> No <input type="radio" name="ususisinterno_usuarios" id="ususisinterno_n_usuarios" value="n" />-->

                                    <div id="switch_ususisinterno_usuarios"></div>
                                    <input type="hidden" name="ususisinterno_usuarios" id="ususisinterno_usuarios" /></td>

                                </td>
                                <td>
                                    <!--Si <input type="radio" name="tienehuella_usuarios" id="tienehuella_s_usuarios" value="s" checked="checked" /> No <input type="radio" name="tienehuella_usuarios" id="tienehuella_n_usuarios" value="n" />-->

                                    <div id="switch_tienehuella_usuarios"></div>
                                    <input type="hidden" name="tienehuella_usuarios" id="tienehuella_usuarios" /></td>

                                </td>
                                <td><input name="huelladactilar_usuarios" type="text" id="huelladactilar_usuarios" size="17" value="" readonly="readonly" onclick="abrirCargaArchivo('huelladactilar_usuarios')" />
                                        <img src="../images/descargar_1.png" width="30" height="30" onclick="reHref('huelladactilar_usuarios' )" alt="Descargar" /></a></td>
                                
                                
                                <td><input name="foto_usuarios" type="text" id="foto_usuarios" size="15" value="" readonly="readonly" 
                                           onclick="abrirCargaArchivo('foto_usuarios')" /> 
                                        <img src="../images/descargar_1.png" width="30" height="30" onclick="reHref('foto_usuarios' )" alt="Descargar" /></a></td>
                            </tr>
                            <tr>
                                <td>Contraseña Usuario<span class="obligatorio">(*)</span></td>
                                <td>Repita Contraseña Usuario<span class="obligatorio">(*)</span></td>
                                <td>Permitir Cambio Contraseña<span class="obligatorio">(*)</span></td>
                                <td>Fecha Creación Contraseña</td>
                                <td>Fecha Última Actualización Contraseña</td>
                            </tr>
                            <tr>
                                <td><input name="ususiscontrasena_usuarios" type="password" id="ususiscontrasena_usuarios" value="" /></td>
                                <td><input name="ususiscontrasena_repetir_usuarios" type="password" id="ususiscontrasena_repetir_usuarios" value="" /></td>
                                <td>
                                    <!-- Si <input type="radio" name="ususiscambio_usuarios" id="ususiscambio_s_usuarios" value="s" checked="checked" /> No <input type="radio" name="ususiscambio_usuarios" id="ususiscambio_n_usuarios" value="n" />-->

                                    <div id="switch_ususiscambio_usuarios"></div>
                                    <input type="hidden" name="ususiscambio_usuarios" id="ususiscambio_usuarios" /></td>
                                </td>
                                <td><input name="ususisfechacrea_usuarios" type="text" id="ususisfechacrea_usuarios" value="" readonly="readonly" /></td>
                                <td><input name="ususisfechamodi_usuarios" type="text" id="ususisfechamodi_usuarios" value="" readonly="readonly" /></td>
                            </tr>
                            <tr>
                                <td>Número Dias Caducar Contraseña<span class="obligatorio">(*)</span></td>
                            </tr>
                            <tr>
                                <td><input name="ususisdias_usuarios" type="text" id="ususisdias_usuarios" value="90" /></td>
                            </tr>
                        </table>
                    </div>
                    <div id="tabs-2"><br />
                        <div class="boton"><input type="submit" value="Mostrar Grupos Seguridad Registrados" onclick="return tabla(flexiGruposSeguridad, 'Grupos Seguridad', '' )" /></div>
                        <br />
                        <table>
                            <tr>
                                <td>Código Grupo Seguridad<span class="obligatorio">(*)</span></td>
                                <td>Código Estado Grupo Segurida<span class="obligatorio">(*)</span></td>
                                <td>Descripción Grupo Seguridad<span class="obligatorio">(*)</span></td>
                            </tr>
                            <tr>
                                <td><input name="grusegcodigo_grupos" type="text" id="grusegcodigo_grupos" value="" /></td>
                                <td><select name="esgrsecodigo_grupos" id="esgrsecodigo_grupos" onclick="tabla(flexiEstadosGruposSeguridad, 'Código grupo seguridad', 'esgrsecodigo_grupos' )" onfocus="tabla(flexiEstadosGruposSeguridad, 'Código grupo seguridad', 'esgrsecodigo_grupos' )"></select></td>
                                <td><textarea name="grusegdescripcion_grupos" id="grusegdescripcion_grupos" cols="80" rows="4"></textarea></td>                            </tr>
                        </table>
                    </div>
                    <div id="tabs-3"><br />
                        <div class="boton"><input type="submit" value="Mostrar Páginas Registradas" onclick="return tabla(flexiListaOpcion, 'Lista Opción', '' )" /></div>
                        <br />
                        <table>
                            <tr>
                                <td>Código Opción Sistema Información<span class="obligatorio">(*)</span></td>
                                <td>Nombre Opción Interna Programa<span class="obligatorio">(*)</span></td>
                                <td>Código Origen Recurso<span class="obligatorio">(*)</span></td>
                                <td>Descripción Opción Sistema Información</td>
                            </tr>
                            <tr>
                                <td><input name="lisopccodigo_paginas" type="text" id="lisopccodigo_paginas" value="" /></td>
                                <td><input name="lisopcprograma_paginas" type="text" id="lisopcprograma_paginas" value="" /></td>
                                <!--<td><select name="lisopcprograma_paginas" id="lisopcprograma_paginas" onfocus="tabla(flexiListaOpcion, 'Lista Paginas', 'lisopcprograma_paginas' )" onclick="tabla(flexiListaOpcion, 'Lista Paginas', 'lisopcprograma_paginas' )"></select>  </td>-->
                                <td><select name="orcodigo_paginas" id="orcodigo_paginas" onfocus="tabla(flexiOrigenRecurso, 'Origen Recurso', 'orcodigo_paginas' )" onclick="tabla(flexiOrigenRecurso, 'Origen Recurso', 'orcodigo_paginas' )"></select></td>
                                <td>
                                    <textarea name="lisopcdescripcion_paginas" id="lisopcdescripcion_paginas" cols="50" rows="4">
                                    </textarea></td>
                            </tr>
                        </table>
                    </div>
                    <div id="tabs-4"><br />
                        <div class="boton"><input type="submit" value="Mostrar Perfiles Registrados" onclick="return tabla(flexiNivelsegopcion, 'Lista Perfiles', '' )" /></div>
                        <br />
                        <table>
                            <tr>
                                <td>Código Nivel de Seguridad</td>
                                <td>Descripción Nivel Seguridad</td>
                            </tr>
                            <tr>
                                <td><input name="niseopcodigo_perfiles" type="text" id="niseopcodigo_perfiles" value="" /></td>
                                <td colspan="2">
                                    <textarea name="niseopdescripcion_perfiles" id="niseopdescripcion_perfiles" cols="50" rows="4">
                                    </textarea></td>
                            </tr>
                            <tr>
                                <td>Permite Ejecutar</td>
                                <td>Permite Adicionar</td>
                                <td>Permite Modificar</td>
                            </tr>
                            <tr>
                                <td>
                                    <div id="switch_niseopejecuta_perfiles"></div>
                                    <input type="hidden" name="niseopejecuta_perfiles" id="niseopejecuta_perfiles" /></td>
                                <td>
                                    <div id="switch_niseopadiciona_perfiles"></div>
                                    <input type="hidden" name="niseopadiciona_perfiles" id="niseopadiciona_perfiles" /></td>
                                <td>
                                    <div id="switch_niseopmodifica_perfiles"></div>
                                    <input type="hidden" name="niseopmodifica_perfiles" id="niseopmodifica_perfiles" /></td>
                            </tr>
                            <tr>
                                <td>Permite Eliminar</td>
                                <td>Permite Consultar</td>
                                <td>Permite Buscar</td>
                            </tr>
                            <tr>
                                <td>
                                    <div id="switch_niseopelimina_perfiles"></div>
                                    <input type="hidden" name="niseopelimina_perfiles" id="niseopelimina_perfiles" /></td>
                                <td>
                                    <div id="switch_niseopconsulta_perfiles"></div>
                                    <input type="hidden" name="niseopconsulta_perfiles" id="niseopconsulta_perfiles" /></td>
                                <td>
                                    <div id="switch_niseopbuscar_perfiles"></div>
                                    <input type="hidden" name="niseopbuscar_perfiles" id="niseopbuscar_perfiles" /></td>
                            </tr>
                            <tr>
                                <td>Permite Imprimir</td>
                                <td>Ocultar Opción</td>
                            </tr>
                            <tr>
                                <td>
                                    <div id="switch_niseopimprime_perfiles"></div>
                                    <input type="hidden" name="niseopimprime_perfiles" id="niseopimprime_perfiles" /></td>
                                <td>
                                    <div id="switch_niseopocultar_perfiles"></div>
                                    <input type="hidden" name="niseopocultar_perfiles" id="niseopocultar_perfiles" /></td>
                            </tr>
                        </table>
                    </div>
                    <div id="tabs-5"><br />
                        <div class="boton"><input type="submit" value="Mostrar Estados Registrados" onclick="return tabla(flexiEstadosUsuarios, 'Lista Perfiles', '' )" /></div>
                        <br />
                        <table>
                            <tr>
                                <td>Código Estado Usuario</td>
                                <td>Descripción</td>
                            </tr>
                            <tr>
                                <td><input name="codestusuasistema_estados" type="text" id="codestusuasistema_estados" value="" /></td>
                                <td colspan="2">
                                    <textarea name="descripcion_estados" id="descripcion_estados" cols="50" rows="4">
                                    </textarea></td>
                            </tr>
                        </table>
                    </div>
                    <div id="tabs-6"><br />
                        <br />
                        <div id="usuarios_permisos" ></div>
                        <div id="paginas_permisos"></div>
                        <div id="perfiles_permisos"></div>

                    </div>
                    <br />
                    <br />

                    <div class="clearBottom"></div>
                </div>
                <br />
                <div class="boton"><input type="submit" id="accion2" value="Registrar" onclick="accionFormulario('UsuariosSistema', 'Registrar', ''); return false" /> <input type="reset" id="resetFormulario2" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" /> <input type="submit" id="actualizar2" value="Actualizar" onclick="accionFormulario('UsuariosSistema', 'Actualizar', ''); return false" class="c2" /> <input type="submit" id="volver_registro2" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>
            </form>
        </div>
     
    </body>
</html>
