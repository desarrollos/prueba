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
        <form><input type="hidden" id="respuestaAjax" /></form>
        <input type="hidden" name="servletActivo" id="servletActivo"/>
        <div id="tablaContenedor"></div>
        <form action="" method="post"><input type="hidden" id="combo" /> <input type="hidden" id="nombreFormulario" value="ActividadesNutricionales" /> <input type="hidden" id="servlet" value="ActividadesNutricionales" /></form>
        <div id="dialog" class="c1">
            <div class="encabezado"></div>
            <div class="titulo">Actividades Nutricionales</div> 
            <br />
            <div>
                <form id="ActividadesNutricionales" method="post" accept-charset="utf-8" name="ActividadesNutricionales"><input type="hidden" id="codigo" name="codigo" />
                    <input type="hidden" name="accion" id="accion" value="" />  
                    <div class="boton"><input type="submit" value="Mostrar Actividades Nutricionales " onclick="return tabla(flexiActividadesNutricionales, 'Actividades Nutricionales', '' )" />
                        <input type="submit" id="accion1" value="Registrar" onclick="accionFormulario('ActividadesNutricionales', 'Registrar', ''); return false" />
                        <input type="reset" id="resetFormulario1" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" />
                        <input type="submit" id="actualizar1" value="Actualizar" onclick="accionFormulario('ActividadesNutricionales', 'Actualizar', ''); return false" class="c2" />
                        <input type="submit" id="volver_registro1" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>
                    <table>





                        <tr>
                            <td>Número Registro Nutrición</td>
                            <td>Tipo Identificación Persona</td>
                            <td>Identificación Persona</td>
                        </tr>
                        <tr>
                            <td> <input type="text" id="nutregid_nutricionregistro" name="nutregid_nutricionregistro"/></td>
                            <td> <select  id="codtipoidentidadper_nutricionregistro" name="codtipoidentidadper_nutricionregistro" onfocus="tabla(flexiTipoIdentificacion, 'Tipo Identificación ', 'codtipoidentidadper_nutricionregistro' )" onclick="tabla(flexiTipoIdentificacion, 'Tipo Identificación ', 'codtipoidentidadper_nutricionregistro' )"></select></td>
                            <td> <input type="text" id="nutregideper_nutricionregistro" name="nutregideper_nutricionregistro"/></td>
                        </tr>
                        <tr>
                            <td>Tipo Identificacion Madre</td>
                            <td>Identificación Madre</td>
                            <td>Tipo de actividad</td>
                        </tr>
                        <tr>
                            <td> <select  id="codtipoidentidadma_nutricionregistro" name="codtipoidentidadma_nutricionregistro" onfocus="tabla(flexiTipoIdentificacion, 'Tipo Identificación ', 'codtipoidentidadma_nutricionregistro' )" onclick="tabla(flexiTipoIdentificacion, 'Tipo Identificación ', 'codtipoidentidadma_nutricionregistro' )"></select></td>
                            <td> <input type="text" id="nutregidemad_nutricionregistro" name="nutregidemad_nutricionregistro"/></td>
                            <td> <select  id="codtipoactividad_nutricionregistro" name="codtipoactividad_nutricionregistro" onfocus="tabla(flexiTipoActividad, 'Tipo de actividad', 'codtipoactividad_nutricionregistro' )" onclick="tabla(flexiTipoActividad, 'Tipo de actividad', 'codtipoactividad_nutricionregistro' )"></select></td>
                        </tr>
                        <tr>
                            <td>Fecha Actividad </td>
                            <td>Fecha del Registro</td>
                            <td>Archivo Documento o Certificado</td>
                        </tr>
                        <tr>
                            <td><input type="text" id="_fecha_nutregfecact_nutricionregistro" name="nutregfecact_nutricionregistro" value="" maxlength="19" readonly="readonly" /></td>
                            <td><input type="text" id="_fecha_nutregfecreg_nutricionregistro" name="nutregfecreg_nutricionregistro" value="" maxlength="19" readonly="readonly" /></td>
                            <td><input name="nutregarchiv_nutricionregistro" type="text" id="nutregarchiv_nutricionregistro" size="17" value="" readonly="readonly" onclick="abrirCargaArchivo('nutregarchiv_nutricionregistro')" />   <img src="../images/descargar_1.png" width="30" height="30" onclick="reHref('nutregarchiv_nutricionregistro' )" alt="Descargar" /></td>
                        </tr>
                        <tr>
                            <td>Observaciones Registro Actividad Nutrición</td>
                        </tr>
                        <tr>
                            <td  colspan="3" > <textarea id="nutregobserv_nutricionregistro" name="nutregobserv_nutricionregistro" cols="80" rows="4"></textarea></td>
                        </tr>					 </table>
                    <br />
                    <div class="boton"><input type="submit" id="accion2" value="Registrar" onclick="accionFormulario('ActividadesNutricionales', 'Registrar', ''); return false" />
                        <input type="reset" id="resetFormulario2" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" />
                        <input type="submit" id="actualizar2" value="Actualizar" onclick="accionFormulario('ActividadesNutricionales', 'Actualizar', ''); return false" class="c2" />
                        <input type="submit" id="volver_registro2" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>
                </form>
                <div class="boton"></div>
            </div>
        </div>
        
    </body>
</html>

