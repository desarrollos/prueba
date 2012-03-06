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
        <form action="" method="post"><input type="hidden" id="combo" /> <input type="hidden" id="nombreFormulario" value="EscGrupoGrado" /> <input type="hidden" id="servlet" value="EscGrupoGrado" /></form>
        <div id="dialog" class="c1">
            <div class="encabezado"></div>
            <div class="titulo">Grupo Grado Escolaridad</div> 
            <br />
            <div>
                <form id="EscGrupoGrado" method="post" accept-charset="utf-8" name="EscGrupoGrado"><input type="hidden" id="codigo" name="codigo" />
                    <input type="hidden" name="accion" id="accion" value="" />  
                    <div class="boton"><input type="submit" value="Mostrar Grupo Grado Escolaridad " onclick="return tabla(flexiEscGrupoGrado, 'Grupo Grado Escolaridad', '' )" />
                        <input type="submit" id="accion1" value="Registrar" onclick="accionFormulario('EscGrupoGrado', 'Registrar', ''); return false" />
                        <input type="reset" id="resetFormulario1" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" />
                        <input type="submit" id="actualizar1" value="Actualizar" onclick="accionFormulario('EscGrupoGrado', 'Actualizar', ''); return false" class="c2" />
                        <input type="submit" id="volver_registro1" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>
                    <table>

                        <tr>
                            <td>Código Grupo Grado Escolaridad</td>
                            <td>Descripción</td>
                        </tr>
                        <tr>
                            <td> <input type="text" id="grugracodigo_escgrupogrado" name="grugracodigo_escgrupogrado"/></td>
                            <td> <input type="text" id="grugradescri_escgrupogrado" name="grugradescri_escgrupogrado"/></td>
                        </tr>
                        <tr>
                            <td>Grado Escolaridad Inicial</td>
                            <td>Grado Escolaridad Final</td>
                        </tr>
                        <tr>
                            <td> <select  id="escgracodigoin_escgrupogrado" name="escgracodigoin_escgrupogrado" onfocus="tabla(flexiEscolaridadGrado, 'Grado Escolaridad', 'escgracodigoin_escgrupogrado' )" onclick="tabla(flexiEscolaridadGrado, 'Grado Escolaridad', 'escgracodigoin_escgrupogrado' )"></select></td>
                            <td> <select  id="escgracodigofi_escgrupogrado" name="escgracodigofi_escgrupogrado" onfocus="tabla(flexiEscolaridadGrado, 'Grado Escolaridad', 'escgracodigofi_escgrupogrado' )" onclick="tabla(flexiEscolaridadGrado, 'Grado Escolaridad', 'escgracodigofi_escgrupogrado' )"></select></td>
                        </tr>
                        <tr>
                            <td>Observaciones</td>
                        </tr>
                        <tr>
                            <td> <input type="text" id="grugraobserv_escgrupogrado" name="grugraobserv_escgrupogrado"/></td>
                        </tr>					 </table>
                    <br />
                    <div class="boton"><input type="submit" id="accion2" value="Registrar" onclick="accionFormulario('EscGrupoGrado', 'Registrar', ''); return false" />
                        <input type="reset" id="resetFormulario2" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" />
                        <input type="submit" id="actualizar2" value="Actualizar" onclick="accionFormulario('EscGrupoGrado', 'Actualizar', ''); return false" class="c2" />
                        <input type="submit" id="volver_registro2" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>
                </form>
                <div class="boton"></div>
            </div>
        </div>
    
    </body>
</html>

