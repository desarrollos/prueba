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
        <form action="" method="post"><input type="hidden" id="combo" /> <input type="hidden" id="nombreFormulario" value="Diagnostico" /> <input type="hidden" id="servlet" value="Diagnostico" /></form>
        <div id="dialog" class="c1">
            <div class="encabezado"></div>
            <div class="titulo">DIAGNOSTICO</div> 
            <br />
            <div>
                <form id="Diagnostico" method="post" accept-charset="utf-8" name="Diagnostico"><input type="hidden" id="codigo" name="codigo" />
                    <input type="hidden" name="accion" id="accion" value="" />  
                    <div class="boton"><input type="submit" value="Mostrar Diagnostico " onclick="return tabla(flexiDiagnostico, 'Diagnostico', '' )" />
                        <input type="submit" id="accion1" value="Registrar" onclick="accionFormulario('Diagnostico', 'Registrar', ''); return false" />
                        <input type="reset" id="resetFormulario1" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" />
                        <input type="submit" id="actualizar1" value="Actualizar" onclick="accionFormulario('Diagnostico', 'Actualizar', ''); return false" class="c2" />
                        <input type="submit" id="volver_registro1" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>
                    <table>





                        <tr>
                            <td>Codigo Diagnostico</td>
                            <td>Descripcion</td>
                            
                        </tr>
                        <tr>
                            <td> <input type="text" id="coddiagnostico_diagnostico" name="coddiagnostico_diagnostico"/></td>
                            <td colspan="4"> <textarea id="descripcion_diagnostico" name="descripcion_diagnostico" cols="90" rows="4"></textarea></td>
                        </tr>
                        <tr>
                            <td>Codigo Diagnostico 298</td>
                            <td>Codigo Diagnostico 3 Caracteres</td>
                        </tr>
                        <tr>
                            
                            <td> <select  id="coddiag298_diagnostico" name="coddiag298_diagnostico" onfocus="tabla(flexiDiagnosticos298, 'Agregar Nuevo Diagnostico 298', 'coddiag298_diagnostico' )" onclick="tabla(flexiDiagnosticos298, 'Agregar Nuevo Diagnostico 298', 'coddiag298_diagnostico' )"></select></td>
                            <td> <select  id="coddiagnostico3char_diagnostico" name="coddiagnostico3char_diagnostico" onfocus="tabla(flexiDiagnostico3char, 'Agregar Nuevo Diagnostico 3 Caracteres', 'coddiagnostico3char_diagnostico' )" onclick="tabla(flexiDiagnostico3char, 'Agregar Nuevo Diagnostico 3 Caracteres', 'coddiagnostico3char_diagnostico' )"></select></td>
                        </tr>
                        <tr>
                            <td>Codigo Nivel Complejidad</td>
                            <td>Codigo Clase Diagnóstico</td>
                            <td>Codigo Ambito Diagnostico</td>
                            <td>Codigo Evento Epidemiologico</td>
                        </tr>
                        <tr>
                            <td> <select  id="codnivelcomplejidad_diagnostico" name="codnivelcomplejidad_diagnostico" onfocus="tabla(flexiNivelComplejidad, 'Agregar Nuevo Nivel Complejidad', 'codnivelcomplejidad_diagnostico' )" onclick="tabla(flexiNivelComplejidad, 'Agregar Nuevo Nivel Complejidad', 'codnivelcomplejidad_diagnostico' )"></select></td>
                            <td> <select  id="codclasediagnostico_diagnostico" name="codclasediagnostico_diagnostico" onfocus="tabla(flexiClaseDiagnostico, 'Agregar Nuevo  Clase Diagnóstico', 'codclasediagnostico_diagnostico' )" onclick="tabla(flexiClaseDiagnostico, 'Agregar Nuevo  Clase Diagnóstico', 'codclasediagnostico_diagnostico' )"></select></td>
                            <td> <select  id="codambitodiagnostico_diagnostico" name="codambitodiagnostico_diagnostico" onfocus="tabla(flexiAmbitoDiagnostico, 'Agregar Nuevo  Ambito Diagnostico', 'codambitodiagnostico_diagnostico' )" onclick="tabla(flexiAmbitoDiagnostico, 'Agregar Nuevo  Ambito Diagnostico', 'codambitodiagnostico_diagnostico' )"></select></td>
                            <td> <select  id="codeventoepidem_diagnostico" name="codeventoepidem_diagnostico" onfocus="tabla(flexiEventoEpidemiologico, 'Agregar Nuevo  Evento Epidemiologico', 'codeventoepidem_diagnostico' )" onclick="tabla(flexiEventoEpidemiologico, 'Agregar Nuevo  Evento Epidemiologico', 'codeventoepidem_diagnostico' )"></select></td>
                        </tr>
                        <tr>
                            <td>Codigo Protocolo Diagnostico</td>
                            <td>Codigo Manual Diagnostico</td>
                            <td>Codigo Sub Grupo Dianostico</td>
                            <td>Codigo Alterno Codigo Diagnostico</td>
                        </tr>
                        <tr>
                            <td> <select  id="codprotocodiagn_diagnostico" name="codprotocodiagn_diagnostico" onfocus="tabla(flexiProtocoloDiagnostico, 'Agregar Nuevo  Protocolo Diagnostico', 'codprotocodiagn_diagnostico' )" onclick="tabla(flexiProtocoloDiagnostico, 'Agregar Nuevo  Protocolo Diagnostico', 'codprotocodiagn_diagnostico' )"></select></td>
                            <td> <select  id="codmanualdiagnostico_diagnostico" name="codmanualdiagnostico_diagnostico" onfocus="tabla(flexiManualDiagnostico, 'Agregar Nuevo  Manual Diagnostico', 'codmanualdiagnostico_diagnostico' )" onclick="tabla(flexiManualDiagnostico, 'Agregar Nuevo  Manual Diagnostico', 'codmanualdiagnostico_diagnostico' )"></select></td>
                            <td> <select  id="subgrupodiagnostico_diagnostico_1" name="subgrupodiagnostico_diagnostico_1" onfocus="tabla(flexiSubgrupoDiagnostico, 'Agregar Nuevo Sub Grupo Dianostico', 'subgrupodiagnostico_diagnostico_1' )" onclick="tabla(flexiSubgrupoDiagnostico, 'Agregar Nuevo Sub Grupo Dianostico', 'subgrupodiagnostico_diagnostico_1' )"></select></td>
                            <td> <input type="text" id="codigoalterno_diagnostico" name="codigoalterno_diagnostico"/></td>
                        </tr>
                        <tr>
                            <td>Codigo Diagnostico RIPS</td>
                            <td>Costo Diagnostico</td>
                            <td>Diagnostico Permitido Sexo Masculino</td>
                            <td>Diagnostico Permitido Sexo Femenino</td>
                        </tr>
                        <tr>
                            <td> <input type="text" id="codigorips_diagnostico" name="codigorips_diagnostico"/></td>
                            <td> <input type="text" id="costo_diagnostico" name="costo_diagnostico"/></td>
                            
                            <td><div id="switch_permitehombre_diagnostico"></div> <input type="hidden" name="permitehombre_diagnostico" id="permitehombre_diagnostico" /></td>
                            
                            <td><div id="switch_permitemujer_diagnostico"></div> <input type="hidden" name="permitemujer_diagnostico" id="permitemujer_diagnostico" /></td>
                        </tr>
                        <tr>
                            <td>Diagnostico Notificacion</td>
                            <td>Diagn&oacute;stico Nutrici&oacute;n</td>
                            <td>Tiempo Tratamiento</td>
                            <td>Tarifa Salarios Minimos Diarios Legales Vigentes</td>
                        </tr>
                        <tr>
                            <td> <input type="text" id="senotifica_diagnostico" name="senotifica_diagnostico"/></td>
                            <td> <input type="text" id="diagnutricion_diagnostico" name="diagnutricion_diagnostico"/></td>
                            <td> <input type="text" id="tiempotratamiento_diagnostico" name="tiempotratamiento_diagnostico"/></td>
                            <td> <input type="text" id="tarifasmdlv_diagnostico" name="tarifasmdlv_diagnostico"/></td>
                        </tr>
                        <tr>
                            <td>Numero UVRs</td>
                            <td>Codigo Barras</td>
                            <td>Fecha Creacion</td>
                            <td>Evento Salud Publ&iacute;ca</td>
                        </tr>
                        <tr>
                            <td> <input type="text" id="numerouvr_diagnostico" name="numerouvr_diagnostico"/></td>
                            <td> <input type="text" id="codigobarras_diagnostico" name="codigobarras_diagnostico"/></td>
                            <td> <input type="text" id="_fecha_fechacreacion_diagnostico" name="fechacreacion_diagnostico"/></td>
                            <td> <input type="text" id="essaludpublica_diagnostico" name="essaludpublica_diagnostico"/></td>
                        </tr>					 </table>
                    <br />
                    <div class="boton"><input type="submit" id="accion2" value="Registrar" onclick="accionFormulario('Diagnostico', 'Registrar', ''); return false" />
                        <input type="reset" id="resetFormulario2" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" />
                        <input type="submit" id="actualizar2" value="Actualizar" onclick="accionFormulario('Diagnostico', 'Actualizar', ''); return false" class="c2" />
                        <input type="submit" id="volver_registro2" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>
                </form>
                <div class="boton"></div>
            </div>
        </div>
        
    </body>
</html>

