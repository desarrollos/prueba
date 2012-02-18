<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %><%@ taglib prefix="jsp2" uri="http://java.sun.com/jstl/core_rt" %><%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"  %><%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %><%
    clases.VerificarUsuarioSistema v;
    v = new clases.VerificarUsuarioSistema(request, response);


%>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta name="generator" content="HTML Tidy for Linux (vers 6 November 2007), see www.w3.org" />
        <script type="text/javascript" src="../js/jquery/jquery.js">
        </script>
        <title>:: DELPHOS ::</title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <link rel="stylesheet" type="text/css" media="all" href="../css/delphos.css" /><!--<link rel="stylesheet" type="text/css" media="all" href="../js/jsCalendar/skins/aqua/theme.css" title="Aqua" />-->
        <link href="../images/favicon.ico" rel="Shortcut Icon" type="image/x-icon" />
        <link type="text/css" href="../js/jquery-ui/css/south-street/jquery-ui-1.8.2.custom.css" rel="Stylesheet" />
        <script type="text/javascript" src="../js/jquery-ui/js/jquery-ui-1.8.2.custom.min.js">
        </script>
        <link rel="stylesheet" type="text/css" href="../css/formularios/general.css" />
        <script type="text/javascript" src="../js/formularios/funciones.js">
        </script>
        <script type="text/javascript" src="../js/formularios/Usuarios.js">
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
                <div class="boton"><input type="submit" id="accion1" value="Registrar" onclick="accionFormulario('UsuariosSistema', 'Registrar', ''); return false" /> <input type="reset" id="resetFormulario1" value="Limpiar Formulario" onclick="redireccionar(document.URL);return false;" /> <input type="submit" id="actualizar1" value="Actualizar" onclick="accionFormulario('UsuariosSistema', 'Actualizar', ''); return false" class="c2" /> <input type="submit" id="volver_registro1" value="Volver al formulario de registro" onclick="redireccionar(document.URL);return false" class="c2" /></div>
                <br /><br />
                <div id="tabs">
                    <ul>
                        <li><a href="#tabs-1" id="Usuarios">Usuarios</a></li>
                        <li><a href="#tabs-2" id="Grupos">Grupos</a></li>
                        <li><a href="#tabs-3" id="Paginas">P�ginas</a></li>
                        <li><a href="#tabs-4" id="Perfiles">Perfiles</a></li>
                        <li><a href="#tabs-5" id="Estados">Estados</a></li>
                        <li><a href="#tabs-6" id="Permisos">Permisos</a></li>
                    </ul>
                    <div id="tabs-1"><br />
                        <div class="boton"><input type="submit" value="Mostrar Usuarios Registrados" onclick="return tabla(flexiUsuarios, 'Usuarios Sistema', '' )" /></div>
                        <br />
                        <table>
                            <tr>
                                <td>C�digo Usuario Sistema <span class="obligatorio">(*)</span></td>
                                <td>Usuario Sistema<span class="obligatorio">(*)</span></td>
                                <td>C�digo Alterno Usuario<span class="obligatorio">(*)</span></td>
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
                                <td>Tipo Identificaci�n<span class="obligatorio">(*)</span></td>
                                <td>N�mero Identificaci�n<span class="obligatorio">(*)</span></td>
                                <td>C�digo Grupo Usuario<span class="obligatorio">(*)</span></td>
                                <td>Permitir Multisesion<span class="obligatorio">(*)</span></td>
                                <td>C�digo Estado Usuario<span class="obligatorio">(*)</span></td>
                            </tr>
                            <tr>
                                <td><select name="codtipoidentidad_usuarios" id="codtipoidentidad_usuarios" onfocus="tabla(flexiTipoIdentificacion, 'Tipo Identificaci�n', 'codtipoidentidad_usuarios' )" onclick="tabla(flexiTipoIdentificacion, 'Tipo Identificaci�n', 'codtipoidentidad_usuarios' )"></select></td>
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
                                <td>Contrase�a Usuario<span class="obligatorio">(*)</span></td>
                                <td>Repita Contrase�a Usuario<span class="obligatorio">(*)</span></td>
                                <td>Permitir Cambio Contrase�a<span class="obligatorio">(*)</span></td>
                                <td>Fecha Creaci�n Contrase�a</td>
                                <td>Fecha �ltima Actualizaci�n Contrase�a</td>
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
                                <td>N�mero Dias Caducar Contrase�a<span class="obligatorio">(*)</span></td>
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
                                <td>C�digo Grupo Seguridad<span class="obligatorio">(*)</span></td>
                                <td>C�digo Estado Grupo Segurida<span class="obligatorio">(*)</span></td>
                                <td>Descripci�n Grupo Seguridad<span class="obligatorio">(*)</span></td>
                            </tr>
                            <tr>
                                <td><input name="grusegcodigo_grupos" type="text" id="grusegcodigo_grupos" value="" /></td>
                                <td><select name="esgrsecodigo_grupos" id="esgrsecodigo_grupos" onclick="tabla(flexiEstadosGruposSeguridad, 'C�digo grupo seguridad', 'esgrsecodigo_grupos' )" onfocus="tabla(flexiEstadosGruposSeguridad, 'C�digo grupo seguridad', 'esgrsecodigo_grupos' )"></select></td>
                                <td><textarea name="grusegdescripcion_grupos" id="grusegdescripcion_grupos" cols="80" rows="4"></textarea></td>                            </tr>
                        </table>
                    </div>
                    <div id="tabs-3"><br />
                        <div class="boton"><input type="submit" value="Mostrar P�ginas Registradas" onclick="return tabla(flexiListaOpcion, 'Lista Opci�n', '' )" /></div>
                        <br />
                        <table>
                            <tr>
                                <td>C�digo Opci�n Sistema Informaci�n<span class="obligatorio">(*)</span></td>
                                <td>Nombre Opci�n Interna Programa<span class="obligatorio">(*)</span></td>
                                <td>C�digo Origen Recurso<span class="obligatorio">(*)</span></td>
                                <td>Descripci�n Opci�n Sistema Informaci�n</td>
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
                                <td>C�digo Nivel de Seguridad</td>
                                <td>Descripci�n Nivel Seguridad</td>
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
                                <td>Ocultar Opci�n</td>
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
                                <td>C�digo Estado Usuario</td>
                                <td>Descripci�n</td>
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
                <div class="boton"><input type="submit" id="accion2" value="Registrar" onclick="accionFormulario('UsuariosSistema', 'Registrar', ''); return false" /> <input type="reset" id="resetFormulario2" value="Limpiar Formulario" onclick="redireccionar(document.URL);return false;" /> <input type="submit" id="actualizar2" value="Actualizar" onclick="accionFormulario('UsuariosSistema', 'Actualizar', ''); return false" class="c2" /> <input type="submit" id="volver_registro2" value="Volver al formulario de registro" onclick="redireccionar(document.URL);return false" class="c2" /></div>
            </form>
        </div>
        <div class="c6">
            <table id="Table_01" width="906" class="c5" cellpadding="0" cellspacing="0">
                <tr>
                    <td colspan="3"><img src="../images/cabezote.png" width="906" height="150" alt="" /></td>
                </tr>
                <%-- Datos sesion --%>
                <tr valign="top">
                    <td colspan="3" width="906" height="16" class="c3" align="right"><span class="textoPequeno"><%=request.getSession().getAttribute("nombre")%> <%=request.getSession().getAttribute("apellido")%></span><a href="../logout.jsp"><img src="../images/log_out.png" border="0" alt="Cerrar sesion" width="20" height="20" /></a></td>
                </tr>
                <%-- Datos sesion --%>
                <tr>
                    <td class="c4" width="234" valign="top">
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
        <!-- End ImageReady Slices -->
    </body>
</html>