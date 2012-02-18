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
        <form action="" method="post"><input type="hidden" id="combo" /> <input type="hidden" id="nombreFormulario" value="ActividadSalud" /> <input type="hidden" id="servlet" value="ActividadSalud" /></form>
        <div id="dialog" class="c1">
            <div class="encabezado"></div>
            <div class="titulo">ACTIVIDAD SALUD</div> 
            <br />
            <div>
                <form id="ActividadSalud" method="post" accept-charset="utf-8" name="ActividadSalud"><input type="hidden" id="codigo" name="codigo" />
                    <input type="hidden" name="accion" id="accion" value="" />  
                    <div class="boton"><input type="submit" value="Mostrar ActividadSalud " onclick="return tabla(flexiActividadSalud, 'ActividadSalud', '' )" />
                        <input type="submit" id="accion1" value="Registrar" onclick="accionFormulario('ActividadSalud', 'Registrar', ''); return false" />
                        <input type="reset" id="resetFormulario1" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" />
                        <input type="submit" id="actualizar1" value="Actualizar" onclick="accionFormulario('ActividadSalud', 'Actualizar', ''); return false" class="c2" />
                        <input type="submit" id="volver_registro1" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>
                    <table>





                        <tr>
                            <td>C&oacute;digo de la actividad de salud</td>
                            <td>Descripci&oacute;n de la actividad</td>
                        </tr>



                        <tr>
                            <td> <input type="text" id="codactividadsalud_actividadsalud" name="codactividadsalud_actividadsalud"/></td>
                            <td colspan="5" > <textarea id="descripcion_actividadsalud" name="descripcion_actividadsalud" cols="50" rows="4"></textarea></td>

                        </tr>
                        <tr>
                            <td>Grupo Actividad</td>    
                            <td>Sub Grupo Actividad de la actividad</td>
                            <td>C&oacute;digo del ambito de la actividad</td>
                        </tr>                        
                        <tr>
                            <td> <select  id="codgrupoactividad_actividadsalud" name="codgrupoactividad_actividadsalud" onfocus="tabla(FlexiGrupoActividad, 'Grupo Actividad', 'codgrupoactividad_actividadsalud' )" onclick="tabla(FlexiGrupoActividad, 'Grupo Actividad', 'codgrupoactividad_actividadsalud' )"></select></td>
                            <td> <select  id="subgrupoactividad_actividadsalud_1" name="subgrupoactividad_actividadsalud_1" onfocus="tabla(flexiSubGrupoAcitivdad, 'Sub Grupo Actividad', 'subgrupoactividad_actividadsalud_1' )" onclick="tabla(flexiSubGrupoAcitivdad, 'Sub Grupo Actividad', 'subgrupoactividad_actividadsalud_1' )"></select></td>
                            <td> <select  id="codambito_actividadsalud" name="codambito_actividadsalud" onfocus="tabla(flexiAmbitoActividad, 'Ambito Actividad', 'codambito_actividadsalud' )" onclick="tabla(flexiAmbitoActividad, 'Ambito Actividad', 'codambito_actividadsalud' )"></select></td>
                        </tr>
                        <tr>
                            <td>C&oacute;digo de la clase de actividad</td>
                            <td>C&oacute;digo del concepto de servicio</td>
                            <td>C&oacute;digo Tipo Actividad</td>
                            <td>C&oacute;digo Categoria Actividad</td>
                        </tr>
                        <tr>
                            <td> <select  id="codclaseactividad_actividadsalud" name="codclaseactividad_actividadsalud" onfocus="tabla(flexiClaseActividad, 'Ambito Actividad', 'codclaseactividad_actividadsalud' )" onclick="tabla(flexiClaseActividad, 'Ambito Actividad', 'codclaseactividad_actividadsalud' )"></select></td>
                            <td> <select  id="codconceptoservicio_actividadsalud" name="codconceptoservicio_actividadsalud" onfocus="tabla(flexiConceptoServicio, 'Concepto Servicio', 'codconceptoservicio_actividadsalud' )" onclick="tabla(flexiConceptoServicio, 'Concepto Servicio', 'codconceptoservicio_actividadsalud' )"></select></td>
                            <td> <select  id="codtipoactividad_actividadsalud" name="codtipoactividad_actividadsalud" onfocus="tabla(flexiTipoActividad, 'Tipo Actividad', 'codtipoactividad_actividadsalud' )" onclick="tabla(flexiTipoActividad, 'Tipo Actividad', 'codtipoactividad_actividadsalud' )"></select></td>
                            <td> <select  id="codcategactividad_actividadsalud" name="codcategactividad_actividadsalud" onfocus="tabla(flexiCategoriaActividad, 'Categoria Actividad', 'codcategactividad_actividadsalud' )" onclick="tabla(flexiCategoriaActividad, 'Categoria Actividad', 'codcategactividad_actividadsalud' )"></select></td>
                        </tr>
                        <tr>
                            <td>C&oacute;digo Protocolo</td>
                            <td>C&oacute;digo Manual Actividad</td>
                            <td>C&oacute;digo Nivel Complejidad</td>
                            <td>C&oacute;digo Alterno</td>
                        </tr>
                        <tr>
                            <td> <select  id="codprotocolo_actividadsalud" name="codprotocolo_actividadsalud" onfocus="tabla(flexiProtocoloActividad, 'Protocolo Actividad', 'codprotocolo_actividadsalud' )" onclick="tabla(flexiProtocoloActividad, 'Protocolo Actividad', 'codprotocolo_actividadsalud' )"></select></td>
                            <td> <select  id="codmanualactividad_actividadsalud" name="codmanualactividad_actividadsalud" onfocus="tabla(flexiManualActividad, 'Manual Actividad', 'codmanualactividad_actividadsalud' )" onclick="tabla(flexiManualActividad, 'Manual Actividad', 'codmanualactividad_actividadsalud' )"></select></td>
                            <td> <select  id="codnivelcomplejidad_actividadsalud" name="codnivelcomplejidad_actividadsalud" onfocus="tabla(flexiNivelComplejidad, 'Nivel Complejidad', 'codnivelcomplejidad_actividadsalud' )" onclick="tabla(flexiNivelComplejidad, 'Nivel Complejidad', 'codnivelcomplejidad_actividadsalud' )"></select></td>
                            <td> <input type="text" id="codigoalterno_actividadsalud" name="codigoalterno_actividadsalud"/></td>
                        </tr>
                        <tr>
                            <td>Codigo Actividad RIPS</td>
                            <td>Costo Actividad</td>
                            <td>Cantidad Maxima Autorizar</td>
                            <td>C&oacute;digo Barras</td>
                        </tr>
                        <tr>
                            <td> <input type="text" id="codigorips_actividadsalud" name="codigorips_actividadsalud"/></td>
                            <td> <input type="text" id="costo_actividadsalud" name="costo_actividadsalud"/></td>
                            <td> <input type="text" id="cantidadmaxautorizar_actividadsalud" name="cantidadmaxautorizar_actividadsalud"/></td>
                            <td> <input type="text" id="codigobarras_actividadsalud" name="codigobarras_actividadsalud"/></td>
                        </tr>
                        <tr>
                            <td>Resultado Final</td>
                            <td>Permite Hombre</td>
                            <td>Permite Mujer</td>
                            <td>Tiempo Aproximado</td>
                        </tr>
                        <tr>
                            <td> <input type="text" id="resultadofinal_actividadsalud" name="resultadofinal_actividadsalud"/></td>

                            <td><div id="switch_permitehombre_actividadsalud"></div>
                                <input type="hidden" name="permitehombre_actividadsalud" id="permitehombre_actividadsalud" /></td>

                            <td><div id="switch_permitemujer_actividadsalud"></div>
                                <input type="hidden" name="permitemujer_actividadsalud" id="permitemujer_actividadsalud" /></td>

                            <td> <input type="text" id="tiempoaprox_actividadsalud" name="tiempoaprox_actividadsalud"/></td>
                        </tr>
                        <tr>
                            <td>Tarifa Salarios Minimos Legales Vigentes</td>
                            <td>Cantidad UVRs</td>
                            <td>Observaci&oacute;n</td>
                        </tr>
                        <tr>
                            <td> <input type="text" id="tarifasmlv_actividadsalud" name="tarifasmlv_actividadsalud"/></td>
                            <td> <input type="text" id="cantidaduvr_actividadsalud" name="cantidaduvr_actividadsalud"/></td>
                            <td colspan="5" > <textarea id="observacion_actividadsalud" name="observacion_actividadsalud" cols="50" rows="4"></textarea></td>
                        </tr>					 </table>
                    <br />
                    <div class="boton"><input type="submit" id="accion2" value="Registrar" onclick="accionFormulario('ActividadSalud', 'Registrar', ''); return false" />
                        <input type="reset" id="resetFormulario2" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" />
                        <input type="submit" id="actualizar2" value="Actualizar" onclick="accionFormulario('ActividadSalud', 'Actualizar', ''); return false" class="c2" />
                        <input type="submit" id="volver_registro2" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>
                </form>
                <div class="boton"></div>
            </div>
        </div>
        
    </body>
</html>

