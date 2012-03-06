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
        <div id="tablaContenedor"></div>
        <form><input type="hidden" id="combo" /> <input type="hidden" id="nombreFormulario" value="Encuentros o reuniones" /> <input type="hidden" id="servlet" value="EncuentrosOReuniones" /></form>
        <div id="dialog" class="c1">
            <div class="encabezado"></div>
            <div class="titulo">ENCUENTROS O REUNIONES</div>
            <br />
            <form id="EncuentrosOReuniones" name="EncuentrosOReuniones">
                <div class="boton"><input type="submit" id="accion1" value="Registrar" onclick="accionFormulario('EncuentrosOReuniones', 'Registrar', ''); return false" />

                    <input type="reset" id="resetFormulario1" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" />
                    <input type="submit" id="actualizar1" value="Actualizar" onclick="accionFormulario('EncuentrosOReuniones', 'Actualizar', ''); return false" class="c2" />
                    <input type="submit" id="volver_registro1" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>

                <br />
                <br />
                <input type="hidden" name="pestana" id="pestana" value="Reuniones" /> <input type="hidden" id="codigo" name="codigo" /> <input type="hidden" name="accion" id="accion" value="" />
                <div id="tabs">
                    <ul>
                        <li><a href="#tabs-1" id="encuentroreunion" name="encuentroreunion">Reuniones</a></li>
                        <li><a href="#tabs-2" id="asistentesreunion" name="asistentesreunion">Asistencia Reuniones</a></li>
                        <li><a href="#tabs-3" id="encuentroactividad" name="encuentroactividad">Actividades Realizadas</a></li>
                        <li><a href="#tabs-4" id="encuenasistenteexterno" name="encuenasistenteexterno">Asistentes Reuniones</a></li>
                    </ul>
                    <div id="tabs-1">
                        <div class="boton"><input type="submit" value="Mostrar reuniones registradas" onclick="tabla(flexiEncuentroreunion, 'Reuniones', '' ); return false" /></div>
                        <br />
                        <table>

                            <tr>
                                <td>Código Encuentros</td>
                                <td>C&oacute;digo Municipio Encuentro</td>
                                <td>Dirección Encuentro</td>
                                <td>Lugar Referencia Encuentro</td>
                            </tr>
                            <tr>
                                <td> <input type="text" id="encuencodigo_encuentroreunion" name="encuencodigo_encuentroreunion"/></td>
                                <td> <select  id="municipio_encuentroreunion_1" name="municipio_encuentroreunion_1" onfocus="tabla(flexiMunicipio, 'C&oacute;digo Municipio Encuentro', 'municipio_encuentroreunion_1' )" onclick="tabla(flexiMunicipio, 'C&oacute;digo Municipio Encuentro', 'municipio_encuentroreunion_1' )"></select></td>
                                <td> <input type="text" id="encuendirecc_encuentroreunion" name="encuendirecc_encuentroreunion"/></td>
                                <td> <input type="text" id="enculugarefe_encuentroreunion" name="enculugarefe_encuentroreunion"/></td>
                            </tr>
                            <tr>
                                <td>Fecha y Hora  Encuentro</td>
                                <td>Número Participantes Encuentro </td>
                                <td>Código Tipo de Reunión</td>
                                <td>Tipo Identificacion Madre Líder</td>
                            </tr>
                            <tr>
                                <td><input type="text" id="_fechahora_encuenfecha_encuentroreunion" name="encuenfecha_encuentroreunion" value="" maxlength="19" readonly="readonly" /></td>
                                <td> <input type="text" id="encunumepart_encuentroreunion" name="encunumepart_encuentroreunion"/></td>
                                <td> <select  id="coditiporeun_encuentroreunion" name="coditiporeun_encuentroreunion" onfocus="tabla(flexiTipoReunion, 'Código Tipo de Reunión', 'coditiporeun_encuentroreunion' )" onclick="tabla(flexiTipoReunion, 'Código Tipo de Reunión', 'coditiporeun_encuentroreunion' )"></select></td>
                                <td> <select  id="codtipoidentidad_encuentroreunion" name="codtipoidentidad_encuentroreunion" onfocus="tabla(flexiTipoIdentificacion, 'Tipo Identificacion Madre Líder', 'codtipoidentidad_encuentroreunion' )" onclick="tabla(flexiTipoIdentificacion, 'Tipo Identificacion Madre Líder', 'codtipoidentidad_encuentroreunion' )"></select></td>
                            </tr>
                            <tr>
                                <td>Identificación Madre Líder</td>
                                <td>Fecha Hora Informe</td>
                                <td>Tipo Sistema</td>
                                <td>Archivo 1</td>
                            </tr>
                            <tr>
                                <td> <input type="text" id="encidemadlid_encuentroreunion" name="encidemadlid_encuentroreunion"/></td>
                                <td><input type="text" id="_fechahora_encufechinfo_encuentroreunion" name="encufechinfo_encuentroreunion" value="" maxlength="19" readonly="readonly" /></td>
                                <td> <select  id="tisiscodigo_encuentroreunion" name="tisiscodigo_encuentroreunion" onfocus="tabla(flexiTipoSistema, 'Tipo Sistema', 'tisiscodigo_encuentroreunion' )" onclick="tabla(flexiTipoSistema, 'Tipo Sistema', 'tisiscodigo_encuentroreunion' )"></select></td>
                                <td><input name="archivofi_encuentroreunion" type="text" id="archivofi_encuentroreunion" size="17" value="" readonly="readonly" onclick="abrirCargaArchivo('archivofi_encuentroreunion')" />   <img src="../images/descargar_1.png" width="30" height="30" onclick="reHref('archivofi_encuentroreunion' )" alt="Descargar" /></td>
                            </tr>
                            <tr>
                                <td>Archivo 2</td>

                            </tr>
                            <tr>
                                <td><input name="encuarchdocu_encuentroreunion" type="text" id="encuarchdocu_encuentroreunion" size="17" value="" readonly="readonly" onclick="abrirCargaArchivo('encuarchdocu_encuentroreunion')" />   <img src="../images/descargar_1.png" width="30" height="30" onclick="reHref('encuarchdocu_encuentroreunion' )" alt="Descargar" /></td>
                            </tr>

                            <tr>
                                <td>Tema Principal</td>

                            </tr>
                            <tr>
                                <td colspan="4"> <textarea id="encutemaprin_encuentroreunion" name="encutemaprin_encuentroreunion" cols="110" rows="4"></textarea></td>
                            </tr>
                            <tr>
                                <td>Objetivo Reunión</td>
                            </tr>
                            <tr>
                                <td colspan="4"> <textarea id="encuenobjeti_encuentroreunion" name="encuenobjeti_encuentroreunion" cols="110" rows="4"></textarea></td>
                            </tr>

                            <tr>
                                <td>Soluciones Encontradas</td>
                            </tr>
                            <tr>
                                <td colspan="4"> <textarea id="encusoluenco_encuentroreunion" name="encusoluenco_encuentroreunion" cols="110" rows="4"></textarea></td>
                            </tr>
                            <tr>
                                <td>Observaciones </td>
                            </tr>
                            <tr>
                                <td colspan="4"> <textarea id="encuenobserv_encuentroreunion" name="encuenobserv_encuentroreunion" cols="110" rows="4"></textarea></td>
                            </tr>

                        </table>
                    </div>
                    <div id="tabs-2">
                        <div class="boton"><input type="submit" value="Mostrar asistencias registradas" onclick="tabla(flexiAsistencia, 'Asistencia Reuniones', '' ); return false" /></div>
                        <br />
                        <br />
                        <table>

                            <tr>
                                <td>Código Encuentros</td>
                                <td>Tipo Identificaci&oacute;n Asistente</td>
                                <td>Identificación Asistente Reunión</td>
                                <td>Asistente Pertenece Programa (S/N)</td>
                            </tr>
                            <tr>
                                <td> <select  id="encuencodigo_asistentesreunion" name="encuencodigo_asistentesreunion" onfocus="tabla(flexiEncuentroreunion, 'Código Encuentros', 'encuencodigo_asistentesreunion' )" onclick="tabla(flexiEncuentroreunion, 'Código Encuentros', 'encuencodigo_asistentesreunion' )"></select></td>
                                <td> <select  id="codtipoidentidad_asistentesreunion" name="codtipoidentidad_asistentesreunion" onfocus="tabla(flexiTipoIdentificacion, 'Tipo Identificaci&oacute;n Asistente', 'codtipoidentidad_asistentesreunion' )" onclick="tabla(flexiTipoIdentificacion, 'Tipo Identificaci&oacute;n Asistente', 'codtipoidentidad_asistentesreunion' )"></select></td>
                                <td> <input type="text" id="asisteidenti_asistentesreunion" name="asisteidenti_asistentesreunion"/></td>
                                <td><div id="switch_asispertprog_asistentesreunion"></div> <input type="hidden" id="asispertprog_asistentesreunion" name="asispertprog_asistentesreunion"  /></td>
                            </tr>
                            <tr>
                                <td>Código Único Familia Pertenece Asistente</td>
                            </tr>
                            <tr>
                                <td> <select  id="codunifami_asistentesreunion" name="codunifami_asistentesreunion" onfocus="tabla(flexiInscripcion, 'Código Único Familia Pertenece Asistente', 'codunifami_asistentesreunion' )" onclick="tabla(flexiInscripcion, 'Código Único Familia Pertenece Asistente', 'codunifami_asistentesreunion' )"></select></td>
                            </tr>
                        </table>
                    </div>
                    <div id="tabs-3">
                        <div class="boton"><input type="submit" value="Mostrar actividades registradas" onclick="tabla(flexiEncuentroActividad, 'Encuentro Actividades', '' ); return false" /></div>
                        <br />
                        <br />
                        <table>
                            <tr>
                                <td>Código</td>
                                <td>Tipo Actividad</td>
                                <td>Funcionario Tipo Identificaci&oacute;n</td>
                                <td>Funcionario N&uacute;mero Identificaci&oacute;n</td>
                            </tr>
                            <tr>
                                <td><select name="encuencodigo_encuentroactividad" id="encuencodigo_encuentroactividad"
                                            onclick="tabla(flexiEncuentroreunion, 'Reuniones', 'encuencodigo_encuentroactividad' )"></select></td>

                                <td><select name="codtipoactividad_encuentroactividad" id="codtipoactividad_encuentroactividad"
                                            onclick="tabla(flexiTipoActividad, 'Reuniones', 'codtipoactividad_encuentroactividad' )"></select></td>

                                <td><select name="codtipoidentidad_encuentroactividad" id="codtipoidentidad_encuentroactividad"
                                            onclick="tabla(flexiTipoIdentificacion, 'Tipo Identificación', 'codtipoidentidad_encuentroactividad' )"></select></td>

                                <td><input type="text" name="numidentfunc_encuentroactividad" id="numidentfunc_encuentroactividad" /></td>

                            </tr>
                        </table>
                    </div>
                    <div id="tabs-4">
                        <div class="boton"><input type="submit" value="Mostrar asistentes registrados" onclick="tabla(flexiAsistenteExterno, 'Asistente Externo', '' ); return false" /></div>
                        <br />
                        <br />
                        <table>

                            <tr>
                                <td>Código Encuentros o Reuniones</td>
                                <td>Tipo Identificacion Asistente Externo</td>
                                <td>Identificación Asistente Externo</td>
                                <td>Nombres Asistente Externo</td>
                            </tr>
                            <tr>
                                <td> <select  id="encuencodigo_encuenasistenteexterno" name="encuencodigo_encuenasistenteexterno" onfocus="tabla(flexiEncuentroreunion, 'Código Encuentros o Reuniones', 'encuencodigo_encuenasistenteexterno' )" onclick="tabla(flexiEncuentroreunion, 'Código Encuentros o Reuniones', 'encuencodigo_encuenasistenteexterno' )"></select></td>
                                <td> <select  id="codtipoidentidad_encuenasistenteexterno" name="codtipoidentidad_encuenasistenteexterno" onfocus="tabla(flexiTipoIdentificacion, 'Tipo Identificacion Asistente Externo', 'codtipoidentidad_encuenasistenteexterno' )" onclick="tabla(flexiTipoIdentificacion, 'Tipo Identificacion Asistente Externo', 'codtipoidentidad_encuenasistenteexterno' )"></select></td>
                                <td> <input type="text" id="externidenti_encuenasistenteexterno" name="externidenti_encuenasistenteexterno"/></td>
                                <td> <input type="text" id="asiextnombre_encuenasistenteexterno" name="asiextnombre_encuenasistenteexterno"/></td>
                            </tr>
                            <tr>
                                <td>Apellidos Asistente Externo</td>
                                <td>Código Tipo Asistente</td>
                                <td>Observaciones Asistente Externo</td>
                            </tr>
                            <tr>
                                <td> <input type="text" id="asiextapellido_encuenasistenteexterno" name="asiextapellido_encuenasistenteexterno"/></td>
                                <td> <select  id="tipasicodigo_encuenasistenteexterno" name="tipasicodigo_encuenasistenteexterno" onfocus="tabla(flexiTipoAsistente, 'Código Tipo Asistente', 'tipasicodigo_encuenasistenteexterno' )" onclick="tabla(flexiTipoAsistente, 'Código Tipo Asistente', 'tipasicodigo_encuenasistenteexterno' )"></select></td>
                                <td colspan="2"> <textarea id="exterobserv_encuenasistenteexterno" name="exterobserv_encuenasistenteexterno" cols="50" rows="4"></textarea></td>
                            </tr>
                        </table>
                    </div>
                </div>
            </form>
            <div class="boton"><input type="submit" id="accion2" value="Registrar" onclick="accionFormulario('EncuentrosOReuniones', 'Registrar', ''); return false" /> <input type="reset" id="resetFormulario2" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" /> <input type="submit" id="actualizar2" value="Actualizar" 
                                                                                                                                                                                                                                                                                                onclick="accionFormulario('EncuentrosOReuniones', 'Actualizar', ''); return false" class="c2" /> <input type="submit" id="volver_registro2" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>
        </div>
       
    </body>
