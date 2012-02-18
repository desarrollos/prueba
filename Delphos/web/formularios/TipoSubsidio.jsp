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
        <form action="" method="post"><input type="hidden" id="combo" /> <input type="hidden" id="nombreFormulario" value="TipoSubsidio" /> <input type="hidden" id="servlet" value="TipoSubsidio" /></form>
        <div id="dialog" class="c1">
            <div class="encabezado"></div>
            <div class="titulo">Tipo de Subsidio</div> 
            <br />
            <div>
                <form id="TipoSubsidio" method="post" accept-charset="utf-8" name="TipoSubsidio"><input type="hidden" id="codigo" name="codigo" />
                    <input type="hidden" name="accion" id="accion" value="" />  
                    <div class="boton"><input type="submit" value="Mostrar Tipo de Subsidio " onclick="return tabla(flexiTipoSubsidio, 'Tipo de Subsidio', '' )" />
                        <input type="submit" id="accion1" value="Registrar" onclick="accionFormulario('TipoSubsidio', 'Registrar', ''); return false" />
                        <input type="reset" id="resetFormulario1" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" />
                        <input type="submit" id="actualizar1" value="Actualizar" onclick="accionFormulario('TipoSubsidio', 'Actualizar', ''); return false" class="c2" />
                        <input type="submit" id="volver_registro1" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>
                    <table>





                        <tr>
                            <td>Código Tipo Subsidio</td>
                            <td>Categoria Subsidio</td>
                        </tr>
                        <tr>
                            <td> <input type="text" id="subtipcodigo_tiposubsidio" name="subtipcodigo_tiposubsidio"/></td>
                            <td> <select  id="subcatcodigo_tiposubsidio" name="subcatcodigo_tiposubsidio" onfocus="tabla(flexiSubsidioCategoria, 'Categoria Subsidio', 'subcatcodigo_tiposubsidio' )" onclick="tabla(flexiSubsidioCategoria, 'Categoria Subsidio', 'subcatcodigo_tiposubsidio' )"></select></td>
                        </tr>
                        <tr>
                            <td>Edad Inicial</td>
                            <td>Edad Final</td>
                        </tr>
                        <tr>
                            <td> <input type="text" id="subtipedaini_tiposubsidio" name="subtipedaini_tiposubsidio"/></td>
                            <td> <input type="text" id="subtipedafin_tiposubsidio" name="subtipedafin_tiposubsidio"/></td>
                        </tr>
                        <tr>
                            <td>Grado Escolaridad Inicial</td>
                            <td>Grado Escolaridad Final</td>
                        </tr>
                        <tr>
                            <td> <select  id="subtipgraini_tiposubsidio" name="subtipgraini_tiposubsidio" onfocus="tabla(flexiEscolaridadGrado, 'Grados Escolaridad ', 'subtipgraini_tiposubsidio' )" onclick="tabla(flexiEscolaridadGrado, 'Grados Escolaridad ', 'subtipgraini_tiposubsidio' )"></select></td>
                            <td> <select  id="subtipgrafin_tiposubsidio" name="subtipgrafin_tiposubsidio" onfocus="tabla(flexiEscolaridadGrado, 'Grados Escolaridad ', 'subtipgrafin_tiposubsidio' )" onclick="tabla(flexiEscolaridadGrado, 'Grados Escolaridad ', 'subtipgrafin_tiposubsidio' )"></select></td>
                        </tr>
                        <tr>
                            <td>Descripción</td>
                        </tr>
                        <tr>
                            <td  colspan="2" > <textarea id="subtipdescri_tiposubsidio" name="subtipdescri_tiposubsidio" cols="50" rows="4"></textarea></td>
                        </tr>					 </table>
                    <br />
                    <div class="boton"><input type="submit" id="accion2" value="Registrar" onclick="accionFormulario('TipoSubsidio', 'Registrar', ''); return false" />
                        <input type="reset" id="resetFormulario2" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" />
                        <input type="submit" id="actualizar2" value="Actualizar" onclick="accionFormulario('TipoSubsidio', 'Actualizar', ''); return false" class="c2" />
                        <input type="submit" id="volver_registro2" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>
                </form>
                <div class="boton"></div>
            </div>
        </div>
   
    </body>
</html>

