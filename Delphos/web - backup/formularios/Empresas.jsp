<%@ include file="config.jsp" %>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <jsp:include page="scripts.jsp"> 	
            <jsp:param name="js" value="<%= request.getServletPath() %>" />
        </jsp:include>
    </head>
    <body>
        <div id="ajax" class="c1"></div>
        <input type="hidden" name="servletActivo" id="servletActivo"/>
        <div id="mensaje" class="c1"></div>
        <form><input type="hidden" id="respuestaAjax" /> <!-- Aqui saldra el flexigrid para la tabla --></form>
        <div id="tablaContenedor"></div>
        <input type="hidden" name="postfijo" value="empresa"></input>
        <form><input type="hidden" id="combo" /> <input type="hidden" id="nombreFormulario" value="Empresas" /> <input type="hidden" id="servlet" value="Empresas" /></form>
        <div id="dialog" class="c1">
            <div class="encabezado"></div>
            <div class="titulo">EMPRESAS</div>
            <br />
            <form id="Empresas"><input type="hidden" id="codigo" name="codigo" /> <input type="hidden" name="accion" id="accion" value="" /> 
                <div class="boton">
                    <input type="submit" value="Mostrar Empresas Registradas" onclick="return tabla(flexiEmpresas, 'Empresas', '' )" />
                    <input type="submit" id="accion1" value="Registrar" onclick="accionFormulario('Empresas', 'Registrar', ''); return false" /> <input type="reset" id="resetFormulario1" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" /> <input type="submit" id="actualizar1" value="Actualizar" onclick="accionFormulario('Empresas', 'Actualizar', ''); return false" class="c2" /> <input type="submit" id="volver_registro1" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>
                <br />

                <table>
                    <tr>
                        <td>Tipo Identificaci&oacute;n</td>
                        <td>Identificaci&oacute;n Empresa</td>
                        <td>D&iacute;gito Verificaci&oacute;n</td>
                        <td>Nombre Empresa</td>
                        <td>Sigla</td>

                    </tr>
                    <tr>
                        <td><select name="codtipoidentidad_empresa" id="codtipoidentidad_empresa" onfocus="tabla(flexiTipoIdentificacion, 'Tipo Identificación', 'codtipoidentidad_empresa' )" onclick="tabla(flexiTipoIdentificacion, 'Tipo Identificación', 'codtipoidentidad_empresa' )"></select></td>
                        <td><input name="codempresa_empresa" type="text" id="codempresa_empresa" value="" /></td>
                        <td><input name="digitoverificacion_empresa" type="text" id="digitoverificacion_empresa" value="" /></td>
                        <td><input name="nombre_empresa" type="text" id="nombre_empresa" value="" /></td>
                        <td><input name="sigla_empresa" type="text" id="sigla_empresa" value="" /></td>
                    </tr>
                    <tr>
                        <td>Tel&eacute;fono</td>
                        <td>Fax</td>
                        <td>L&iacute;nea Gratuita</td>
                        <td>Departamento</td>
                        <td>Municipio</td>
                    </tr>
                    <tr>
                        <td><input name="telefono_empresa" type="text" id="telefono_empresa" value="" /></td>
                        <td><input name="fax_empresa" type="text" id="fax_empresa" value="" /></td>
                        <td><input name="lineagratuita_empresa" type="text" id="lineagratuita_empresa" value="" /></td>

                        <td><select name="coddepartamento_empresa" id="coddepartamento_empresa" 
                                    onfocus="tabla(flexiDepartamento, 'Departamento', 'coddepartamento_empresa' )" 
                                    onclick="tabla(flexiDepartamento, 'Departamento', 'coddepartamento_empresa' )"></select></td>


                        <td><select name="codmunicipio_empresa" id="codmunicipio_empresa" 
                                    onfocus="tabla(flexiMunicipio, 'Municipio', 'codmunicipio_empresa' )" 
                                    onclick="tabla(flexiMunicipio, 'Municipio', 'codmunicipio_empresa' )"></select></td>




                    </tr>
                    <tr>
                        <td>C&oacute;digo Sector</td>
                        <td>C&oacute;digo Barrio</td>
                        <td>Direcci&oacute;n</td>
                        <td>Gerente</td>
                        <td>C&oacute;digo Actividad Econ&oacute;mica</td>
                    </tr>
                    <tr>


                        <td><select name="codsubgrupo_empresa" id="codsubgrupo_empresa" 
                                    onfocus="tabla(flexiSubGrupoGeografico, 'Sector', 'codsubgrupo_empresa' )" 
                                    onclick="tabla(flexiSubGrupoGeografico, 'Sector', 'codsubgrupo_empresa' )"></select></td>


                        <td><select name="codbarrio_empresa" id="codbarrio_empresa" 
                                    onfocus="tabla(flexiBarrio, 'Barrio', 'codbarrio_empresa' )" 
                                    onclick="tabla(flexiBarrio, 'Barrio', 'codbarrio_empresa' )"></select></td>


                        <td><input name="direccion_empresa" type="text" id="direccion_empresa" value="" /></td>
                        <td><input name="gerente_empresa" type="text" id="gerente_empresa" value="" /></td>
                        <td><select name="codactividadeconomica_empresa" id="codactividadeconomica_empresa" onfocus="tabla(flexiActividadEconomica, 'Actividad Economica', 'codactividadeconomica_empresa' )" onclick="tabla(flexiActividadEconomica, 'Actividad Economica', 'codactividadeconomica_empresa' )"></select></td>
                    </tr>
                    <tr>
                        <td>
                            Sector Entidad
                        </td>
                        <td>Tipo Aportante</td>
                        <td>Correo Electronico</td>
                        <td>P&aacute;gina Web</td>
                        <td>Tipo Contribuyente DIAN</td>
                    </tr>
                    <tr>
                        <td><select name="codsectorentidad_empresa" id="codsectorentidad_empresa" 
                                    onfocus="tabla(flexiSectorEntidad, 'Sector Entidad', 'codsectorentidad_empresa' )" 
                                    onclick="tabla(flexiSectorEntidad, 'Sector Entidad', 'codsectorentidad_empresa' )"></select></td>

                        <td><select name="codtipoaportante_empresa" id="codtipoaportante_empresa" 
                                    onfocus="tabla(flexiTipoAportante, 'Tipo Aportante', 'codtipoaportante_empresa' )" 
                                    onclick="tabla(flexiTipoAportante, 'Tipo Aportante', 'codtipoaportante_empresa' )"></select></td>

                        <td><input name="email_empresa" type="text" id="email_empresa" value="" /></td>
                        <td><input name="paginaweb_empresa" type="text" id="paginaweb_empresa" value="" /></td>

                        <td><select name="codtipocontribuyente_empresa" id="codtipocontribuyente_empresa" 
                                    onfocus="tabla(flexiTipoContribuyente, 'Tipo Tipo Contribuyente', 'codtipocontribuyente_empresa' )" 
                                    onclick="tabla(flexiTipoContribuyente, 'Tipo Tipo Contribuyente', 'codtipocontribuyente_empresa' )"></select></td>



                    </tr>

                    <tr>
                        <td>C&oacute;digo Tipo Persona</td>
                        <td>Est&aacute; Instalado Sistema</td>
                        <td>C&oacute;digo Dane Empresa</td>
                    </tr>
                    <tr>
                        <td><select name="codclasepersona_empresa" id="codclasepersona_empresa" 
                                    onfocus="tabla(flexiClasePersona, 'Clase Persona', 'codclasepersona_empresa' )" 
                                    onclick="tabla(flexiClasePersona, 'Clase Persona', 'codclasepersona_empresa' )"></select></td>
                        <td>
                            <div id="switch_empresasistema_empresa"></div>
                            <input type="hidden" name="empresasistema_empresa" id="empresasistema_empresa" />
                        </td>
                        <td><input name="empcodigodane_empresa" type="text" id="empcodigodane_empresa" value="" /></td>
                    </tr>

                </table>

                <br />
                <div class="boton"><input type="submit" id="accion2" value="Registrar" onclick="accionFormulario('Empresas', 'Registrar', ''); return false" /> <input type="reset" id="resetFormulario2" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" /> <input type="submit" id="actualizar2" value="Actualizar" onclick="accionFormulario('Empresas', 'Actualizar', ''); return false" class="c2" /> <input type="submit" id="volver_registro2" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>
            </form>
        </div>
       
    </body>
</html>
