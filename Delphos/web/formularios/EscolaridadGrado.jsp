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
        <form><input type="hidden" id="respuestaAjax" /> <!-- Aqui saldra el flexigrid para la tabla --></form>
        <input type="hidden" name="servletActivo" id="servletActivo"/>
        <div id="tablaContenedor"></div>
        <form action="" method="post"><input type="hidden" id="combo" /> <input type="hidden" id="nombreFormulario" value="Tipo Subsidio" /> <input type="hidden" id="servlet" value="EscolaridadGrado" /></form>
        <div id="dialog" class="c1">
            <div class="encabezado"></div>
            <div class="titulo">Grado Escolaridad</div>
            <br />
            <div>
                <form id="EscolaridadGrado" method="post" accept-charset="utf-8" name="EscolaridadGrado"><input type="hidden" id="codigo" name="codigo" />
                    <input type="hidden" name="accion" id="accion" value="" />
                    <div class="boton"><input type="submit" value="Mostrar Grados de Escolaridad " onclick="return tabla(flexiGradoEscolaridad, 'Grados Escolaridad', '' )" />
                        <input type="submit" id="accion1" value="Registrar" onclick="accionFormulario('EscolaridadGrado', 'Registrar', ''); return false" />
                        <input type="reset" id="resetFormulario1" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" />
                        <input type="submit" id="actualizar1" value="Actualizar" onclick="accionFormulario('EscolaridadGrado', 'Actualizar', ''); return false" class="c2" />
                        <input type="submit" id="volver_registro1" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>
                    <br />
                    <table>


                        <tr>
                            <td>Codigo Escolaridad</td>
                            <td>Tipo Educacion</td>
                        </tr>
                        <tr>
                            <td> <input type="text" id="escgracodigo_escolaridadgrado" name="escgracodigo_escolaridadgrado"/></td>
                            <td> <select  id="tipeducodigo_escolaridadgrado" name="tipeducodigo_escolaridadgrado" onfocus="tabla(flexiTipoEducacion, 'Tipo Educacion', 'tipeducodigo_escolaridadgrado' )" onclick="tabla(flexiTipoEducacion, 'Tipo Educacion', 'tipeducodigo_escolaridadgrado' )"></select></td>
                        </tr>
                        <tr>
                            <td>Descripción</td>
                        </tr>
                        <tr>
                            <td  colspan="2"  > <textarea id="escgradescri_escolaridadgrado" name="escgradescri_escolaridadgrado" cols="50" rows="4" > </textarea></td>
                        </tr>

                    </table>
                    <!-- Acciones estan
                                        1 - > registrar
                                        2 -> actualizar -->
                    <div class="boton"><input type="submit" id="accion2" value="Registrar" onclick="accionFormulario('EscolaridadGrado', 'Registrar', ''); return false" /> <input type="reset" id="resetFormulario2" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" /> <input type="submit" id="actualizar2" value="Actualizar" onclick="accionFormulario('EscolaridadGrado', 'Actualizar', ''); return false" class="c2" />
                        <input type="submit" id="volver_registro2" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>
                </form>
                <div class="boton"></div>
            </div>
        </div>
      
    </body>
