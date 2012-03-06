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
        <form action="" method="post"><input type="hidden" id="combo" /> <input type="hidden" id="nombreFormulario" value="RegistroEstimulacionTemprana" /> <input type="hidden" id="servlet" value="RegistroEstimulacionTemprana" /></form>
        <div id="dialog" class="c1">
            <div class="encabezado"></div>
            <div class="titulo">Registro Estimulacion Temprana</div> 
            <br />
            <div>
                <form id="RegistroEstimulacionTemprana" method="post" accept-charset="utf-8" name="RegistroEstimulacionTemprana"><input type="hidden" id="codigo" name="codigo" />
                    <input type="hidden" name="accion" id="accion" value="" />  
                    <div class="boton"><input type="submit" value="Mostrar Registro Estimulacion Temprana " onclick="return tabla(flexiRegistroEstimulacionTemprana, 'Registro Estimulacion Temprana', '' )" />
                        <input type="submit" id="accion1" value="Registrar" onclick="accionFormulario('RegistroEstimulacionTemprana', 'Registrar', ''); return false" />
                        <input type="reset" id="resetFormulario1" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" />
                        <input type="submit" id="actualizar1" value="Actualizar" onclick="accionFormulario('RegistroEstimulacionTemprana', 'Actualizar', ''); return false" class="c2" />
                        <input type="submit" id="volver_registro1" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>
                   <br/>
                    <table>
                        <tr>
                            <td>Id Registro</td>
                            <td>Fecha Actividad</td>
                        </tr>
                        <tr>
                            <td> <input type="text" id="esttemid_estimulaciontemprana" name="esttemid_estimulaciontemprana"/></td>
                            <td><input type="text" id="_fecha_esttemfecact_estimulaciontemprana" name="esttemfecact_estimulaciontemprana" value="" maxlength="19" readonly="readonly" /></td>
                        </tr>
                        <tr>
                            <td>Tipo Identificación Persona</td>
                            <td>Identificación Persona</td>
                        </tr>
                        <tr>
                            <td> <select  id="codtipoidentidad_estimulaciontemprana" name="codtipoidentidad_estimulaciontemprana" onfocus="tabla(flexiTipoIdentificacion, 'Tipo Identificacion', 'codtipoidentidad_estimulaciontemprana' )" onclick="tabla(flexiTipoIdentificacion, 'Tipo Identificacion', 'codtipoidentidad_estimulaciontemprana' )"></select></td>
                            <td> <input type="text" id="esttemidenti_estimulaciontemprana" name="esttemidenti_estimulaciontemprana"/></td>
                        </tr>
                        <tr>
                            <td>Quién Realizó la Actividad</td>
                            <td>CódigoTipo Estimulación</td>
                        </tr>
                        <tr>
                            <td> <input type="text" id="esttemquien_estimulaciontemprana" name="esttemquien_estimulaciontemprana"/></td>
                            <td> <select  id="tipestcodigo_estimulaciontemprana" name="tipestcodigo_estimulaciontemprana" onfocus="tabla(flexiTipoEstimulacion, 'Tipo Estimulacion', 'tipestcodigo_estimulaciontemprana' )" onclick="tabla(flexiTipoEstimulacion, 'Tipo Estimulacion', 'tipestcodigo_estimulaciontemprana' )"></select></td>
                        </tr>
                        <tr>
                            <td>Archivo Documento Actividad</td>
                        </tr>
                        <tr>
                            <td><input name="esttemarchiv_estimulaciontemprana" type="text" id="esttemarchiv_estimulaciontemprana" size="17" value="" readonly="readonly" onclick="abrirCargaArchivo('esttemarchiv_estimulaciontemprana')" />   <img src="../images/descargar_1.png" width="30" height="30" onclick="reHref('esttemarchiv_estimulaciontemprana' )" alt="Descargar" /></td>
                        </tr>
                        <tr>
                           <td>Acciones de Estimulación Temprana</td> 
                        </tr>    
                        <tr>
                            <td  colspan="2" > <textarea id="esttemaccion_estimulaciontemprana" name="esttemaccion_estimulaciontemprana" cols="50" rows="4"></textarea></td>
                        </tr>
                        <tr>
                            <td>Observaciones Estimulación Temprana</td>
                        </tr>
                        <tr>
                            <td  colspan="2" > <textarea id="esttemobserv_estimulaciontemprana" name="esttemobserv_estimulaciontemprana" cols="50" rows="4"></textarea></td>
                        </tr>					 </table>
                    <br />
                    <div class="boton"><input type="submit" id="accion2" value="Registrar" onclick="accionFormulario('RegistroEstimulacionTemprana', 'Registrar', ''); return false" />
                        <input type="reset" id="resetFormulario2" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" />
                        <input type="submit" id="actualizar2" value="Actualizar" onclick="accionFormulario('RegistroEstimulacionTemprana', 'Actualizar', ''); return false" class="c2" />
                        <input type="submit" id="volver_registro2" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>
                </form>
                <div class="boton"></div>
            </div>
        </div>
     
    </body>
</html>

