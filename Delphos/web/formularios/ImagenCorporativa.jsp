<%@ include file="config.jsp" %> 
<html xmlns="http://www.w3.org/1999/xhtml"> 
    <head> 
        <title>:: DELPHOS ::  - Imagen Corporativa - </title>
        <jsp:include page="scripts.jsp">  
            <jsp:param name="js" value="<%= request.getServletPath()%>" />
        </jsp:include> 
    </head>
    <body> 
        <div id="ajax" class="c1"></div>
        <div id="mensaje" class="c1"></div><div id="reporte"></div>
        <form><input type="hidden" id="respuestaAjax" /></form>
        <input type="hidden" name="servletActivo" id="servletActivo"/>
        <div id="tablaContenedor"></div>
        <form action="" method="post"><input type="hidden" id="combo" /> <input type="hidden" id="nombreFormulario" value="ImagenCorporativa" /> <input type="hidden" id="servlet" value="ImagenCorporativa" /></form>
        <div id="dialog" class="c1">
            <div class="encabezado"></div>
            <div class="titulo">Imagen Corporativa</div> 
            <br />
            <div>
                <form id="ImagenCorporativa" method="post" accept-charset="utf-8" name="ImagenCorporativa"><input type="hidden" id="codigo" name="codigo" />
                    <input type="hidden" name="accion" id="accion" value="" />  
                    <div class="boton"><input type="submit" value="Mostrar Imagen Corporativa " onclick="return tabla(flexiImagenCorporativa, 'Imagen Corporativa', '' )" />
                        <input type="submit" id="accion1" value="Registrar" onclick="accionFormulario('ImagenCorporativa', 'Registrar', ''); return false" />
                        <input type="reset" id="resetFormulario1" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" />
                        <input type="submit" id="actualizar1" value="Actualizar" onclick="accionFormulario('ImagenCorporativa', 'Actualizar', ''); return false" class="c2" />
                        <input type="submit" id="volver_registro1" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>
                    <table>
                        <tr>
                            <td>Codigo Imagen Corporativa</td>
                        </tr>
                        <tr>
                            <td> <input type="text" id="imacorid_imagencorporativa" name="imacorid_imagencorporativa"/></td>
                        </tr>
                        <tr>
                            <td> Tipo Sistemas</td>
                        </tr>
                        <tr>
                            <td> <select  id="tisiscodigo_imagencorporativa" name="tisiscodigo_imagencorporativa" onfocus="tabla(flexiTipoSistema, 'Tipo Sistema', 'tisiscodigo_imagencorporativa' )" onclick="tabla(flexiTipoSistema, 'Tipo Sistema', 'tisiscodigo_imagencorporativa' )"></select></td>
                        </tr>
                        <tr>
                            <td>Tipo Imagen Corporativa</td>
                        </tr>
                        <tr>
                            <td> <select  id="tipcorcodigo_imagencorporativa" name="tipcorcodigo_imagencorporativa" onfocus="tabla(flexiTipoCorporativa, 'Tipo Corporativa', 'tipcorcodigo_imagencorporativa' )" onclick="tabla(flexiTipoCorporativa, 'Tipo Corporativa', 'tipcorcodigo_imagencorporativa' )"></select></td>
                        </tr>
                        <tr>
                            <td>Mostrar Imagen Corporativa</td>
                        </tr>
                        <tr>
                            <td><div id="switch_imacormostrar_imagencorporativa"></div> <input type="hidden" id="imacormostrar_imagencorporativa" name="imacormostrar_imagencorporativa"  /></td>
                        </tr>
                        <tr>
                            <td>Estado Imagen Corporativa</td>
                        </tr>
                        <tr>
                            <td> <select  id="estcorcodigo_imagencorporativa" name="estcorcodigo_imagencorporativa" onfocus="tabla(flexiEstadoCorporativa, 'Estado Corporativa', 'estcorcodigo_imagencorporativa' )" onclick="tabla(flexiEstadoCorporativa, 'Estado Corporativa', 'estcorcodigo_imagencorporativa' )"></select></td>
                        </tr>
                        <tr>
                            <td>Descripción Imagen Corporativa</td>
                        </tr>
                        <tr>
                            <td <%-- colspan="4" --%>> <textarea id="imacordescripc_imagencorporativa" name="imacordescripc_imagencorporativa" cols="50" rows="4"></textarea></td>
                        </tr>					 
                    </table>
                    <br />
                    <div class="boton"><input type="submit" id="accion2" value="Registrar" onclick="accionFormulario('ImagenCorporativa', 'Registrar', ''); return false" />
                        <input type="reset" id="resetFormulario2" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" />
                        <input type="submit" id="actualizar2" value="Actualizar" onclick="accionFormulario('ImagenCorporativa', 'Actualizar', ''); return false" class="c2" />
                        <input type="submit" id="volver_registro2" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>
                </form>
                <div class="boton"></div>
            </div>
        </div>
    </body>
</html>

