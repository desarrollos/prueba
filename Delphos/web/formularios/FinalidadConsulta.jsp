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
        <form action="" method="post"><input type="hidden" id="combo" /> <input type="hidden" id="nombreFormulario" value="FinalidadConsulta" /> <input type="hidden" id="servlet" value="FinalidadConsulta" /></form>
        <div id="dialog" class="c1">
            <div class="encabezado"></div>
            <div class="titulo">Finalidad Consulta</div> 
            <br />
            <div>
                <form id="FinalidadConsulta" method="post" accept-charset="utf-8" name="FinalidadConsulta"><input type="hidden" id="codigo" name="codigo" />
                    <input type="hidden" name="accion" id="accion" value="" />  
                    <div class="boton"><input type="submit" value="Mostrar Finalidad Consulta " onclick="return tabla(flexiFinalidadConsulta, 'Finalidad Consulta', '' )" />
                        <input type="submit" id="accion1" value="Registrar" onclick="accionFormulario('FinalidadConsulta', 'Registrar', ''); return false" />
                        <input type="reset" id="resetFormulario1" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" />
                        <input type="submit" id="actualizar1" value="Actualizar" onclick="accionFormulario('FinalidadConsulta', 'Actualizar', ''); return false" class="c2" />
                        <input type="submit" id="volver_registro1" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>
                    <table>


                        <tr>
                            <td>C&oacute;digo Finalidad</td>
                        </tr>
                        <tr>
                            <td> <input type="text" id="codfinalidadconsulta_finalidadconsulta" name="codfinalidadconsulta_finalidadconsulta"/></td>
                        </tr>
                        <tr>
                            <td>Descripci&oacute;n C&oacute;digo</td>
                        </tr>
                        <tr>
                            <td> <textarea type="text" id="descripcion_finalidadconsulta" name="descripcion_finalidadconsulta" cols="50" rows="5"></textarea></td>
                        </tr>

                        <tr>
                            <td>Observaciones</td>
                        </tr>
                        <tr>
                            <td> <textarea type="text" id="observacion_finalidadconsulta" name="observacion_finalidadconsulta" cols="50" rows="5"> </textarea></td>
                        </tr>					 </table>
                    <br />
                    <div class="boton"><input type="submit" id="accion2" value="Registrar" onclick="accionFormulario('FinalidadConsulta', 'Registrar', ''); return false" />
                        <input type="reset" id="resetFormulario2" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" />
                        <input type="submit" id="actualizar2" value="Actualizar" onclick="accionFormulario('FinalidadConsulta', 'Actualizar', ''); return false" class="c2" />
                        <input type="submit" id="volver_registro2" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>
                </form>
                <div class="boton"></div>
            </div>
        </div>
   
    </body>
</html>

