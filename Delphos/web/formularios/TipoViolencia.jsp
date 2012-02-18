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
        <form action="" method="post"><input type="hidden" id="combo" /> <input type="hidden" id="nombreFormulario" value="TipoViolencia" /> <input type="hidden" id="servlet" value="TipoViolencia" /></form>
        <div id="dialog" class="c1">
            <div class="encabezado"></div>
            <div class="titulo">Tipo Violencia Intrafamiliar</div> 
            <br />
            <div>
                <form id="TipoViolencia" method="post" accept-charset="utf-8" name="TipoViolencia"><input type="hidden" id="codigo" name="codigo" />
                    <input type="hidden" name="accion" id="accion" value="" />  
                    <div class="boton"><input type="submit" value="Mostrar Tipo Violencia Intrafamiliar " onclick="return tabla(flexiTipoViolencia, 'Tipo Violencia Intrafamiliar', '' )" />
                        <input type="submit" id="accion1" value="Registrar" onclick="accionFormulario('TipoViolencia', 'Registrar', ''); return false" />
                        <input type="reset" id="resetFormulario1" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" />
                        <input type="submit" id="actualizar1" value="Actualizar" onclick="accionFormulario('TipoViolencia', 'Actualizar', ''); return false" class="c2" />
                        <input type="submit" id="volver_registro1" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>
                    <table>
                        <tr>
                            <td>Código Tipo Violencia </td>
                        </tr>
                        <tr>
                            <td> <input type="text" id="tipviocodigo_tipoviolencia" name="tipviocodigo_tipoviolencia"/></td>
                        </tr>
                        <tr>
                            <td>Descripción Tipo Violencia </td>
                        </tr>
                        <tr>
                            <td> <input type="text" id="tipviodescri_tipoviolencia" name="tipviodescri_tipoviolencia"/></td>
                        </tr>
                        <tr>
                            <td>Observaciones Tipo Violencia</td>
                        </tr>
                        <tr>
                            <td <%-- colspan="4" --%>> <textarea id="tipvioobserv_tipoviolencia" name="tipvioobserv_tipoviolencia" cols="50" rows="4"></textarea></td>
                        </tr>					 </table>
                    <br />
                    <div class="boton"><input type="submit" id="accion2" value="Registrar" onclick="accionFormulario('TipoViolencia', 'Registrar', ''); return false" />
                        <input type="reset" id="resetFormulario2" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" />
                        <input type="submit" id="actualizar2" value="Actualizar" onclick="accionFormulario('TipoViolencia', 'Actualizar', ''); return false" class="c2" />
                        <input type="submit" id="volver_registro2" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>
                </form>
                <div class="boton"></div>
            </div>
        </div>
      
    </body>
</html>

