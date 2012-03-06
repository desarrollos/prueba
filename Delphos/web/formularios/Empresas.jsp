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
        <div id="mensaje" class="c1"></div><div id="reporte"></div>
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
                        <td>Tipo Identificacion</td>
                        <td>Identificacion Empresa</td>
                        <td>Digito Verificacion Cuando Documento es NIT</td>
                        <td>Nombre de la empresa</td>
                    </tr>
                    <tr>
                        <td> <select  id="codtipoidentidad_empresa" name="codtipoidentidad_empresa" onfocus="tabla(flexiTipoIdentificacion, 'Tipo Identificacion', 'codtipoidentidad_empresa' )" onclick="tabla(flexiTipoIdentificacion, 'Tipo Identificacion', 'codtipoidentidad_empresa' )"></select></td>
                        <td> <input type="text" id="codempresa_empresa" name="codempresa_empresa"/></td>
                        <td> <input type="text" id="digitoverificacion_empresa" name="digitoverificacion_empresa"/></td>
                        <td> <input type="text" id="nombre_empresa" name="nombre_empresa"/></td>
                    </tr>
                    <tr>
                        <td>Sigla Empresa</td>
                        <td>Numero del telefono</td>
                        <td>Numero Fax</td>
                        <td>Linea Telefonica Gratuita</td>
                    </tr>
                    <tr>
                        <td> <input type="text" id="sigla_empresa" name="sigla_empresa"/></td>
                        <td> <input type="text" id="telefono_empresa" name="telefono_empresa"/></td>
                        <td> <input type="text" id="fax_empresa" name="fax_empresa"/></td>
                        <td> <input type="text" id="lineagratuita_empresa" name="lineagratuita_empresa"/></td>
                    </tr>
                    <tr>
                        <td>Barrio</td>
                        <td>Dirección Empresa</td>
                        <td>Nombre Gerente</td>
                        <td>Codigo Actividad Economica</td>
                    </tr>
                    <tr>
                        <td> <select  id="barrio_empresa_1" name="barrio_empresa_1" onfocus="tabla(flexiBarrio, 'Barrio', 'barrio_empresa_1' )" onclick="tabla(flexiBarrio, 'Barrio', 'barrio_empresa_1' )"></select></td>
                        <td> <input type="text" id="direccion_empresa" name="direccion_empresa"/></td>
                        <td> <input type="text" id="gerente_empresa" name="gerente_empresa"/></td>
                        <td> <select  id="codactividadeconomica_empresa" name="codactividadeconomica_empresa" onfocus="tabla(flexiActividadEconomica, 'Codigo Actividad Economica', 'codactividadeconomica_empresa' )" onclick="tabla(flexiActividadEconomica, 'Codigo Actividad Economica', 'codactividadeconomica_empresa' )"></select></td>
                    </tr>
                    <tr>
                        <td>Codigo Sector Entidadades</td>
                        <td>Codigo Tipo Aportante</td>
                        <td>Correo Electronico</td>
                        <td>Nombre Página Web (www.)</td>
                    </tr>
                    <tr>
                        <td> <select  id="codsectorentidad_empresa" name="codsectorentidad_empresa" onfocus="tabla(flexiSectorEntidad, 'Codigo Sector Entidadades', 'codsectorentidad_empresa' )" onclick="tabla(flexiSectorEntidad, 'Codigo Sector Entidadades', 'codsectorentidad_empresa' )"></select></td>
                        <td> <select  id="codtipoaportante_empresa" name="codtipoaportante_empresa" onfocus="tabla(flexiTipoAportante, 'Codigo Tipo Aportante', 'codtipoaportante_empresa' )" onclick="tabla(flexiTipoAportante, 'Codigo Tipo Aportante', 'codtipoaportante_empresa' )"></select></td>
                        <td> <input type="text" id="email_empresa" name="email_empresa"/></td>
                        <td> <input type="text" id="paginaweb_empresa" name="paginaweb_empresa"/></td>
                    </tr>
                    <tr>
                        <td>Codigo Tipo Contribuyente DIAN</td>
                        <td>Codigo Tipo Persona</td>
                        <td>Empresa Instalado Sistema (S/N)</td>
                        <td>Código Dane Empresa</td>
                    </tr>
                    <tr>
                        <td> <select  id="codtipocontribuyente_empresa" name="codtipocontribuyente_empresa" onfocus="tabla(flexiTipoContribuyente, 'Codigo Tipo Contribuyente DIAN', 'codtipocontribuyente_empresa' )" onclick="tabla(flexiTipoContribuyente, 'Codigo Tipo Contribuyente DIAN', 'codtipocontribuyente_empresa' )"></select></td>
                        <td> <select  id="codclasepersona_empresa" name="codclasepersona_empresa" onfocus="tabla(flexiClasePersona, 'Codigo Tipo Persona', 'codclasepersona_empresa' )" onclick="tabla(flexiClasePersona, 'Codigo Tipo Persona', 'codclasepersona_empresa' )"></select></td>
                        <td><div id="switch_empresasistema_empresa"></div> <input type="hidden" id="empresasistema_empresa" name="empresasistema_empresa"  /></td>
                        <td> <input type="text" id="empcodigodane_empresa" name="empcodigodane_empresa"/></td>
                    </tr>

                </table>

                <br />
                <div class="boton"><input type="submit" id="accion2" value="Registrar" onclick="accionFormulario('Empresas', 'Registrar', ''); return false" /> <input type="reset" id="resetFormulario2" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" /> <input type="submit" id="actualizar2" value="Actualizar" onclick="accionFormulario('Empresas', 'Actualizar', ''); return false" class="c2" /> <input type="submit" id="volver_registro2" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>
            </form>
        </div>

    </body>
</html>
