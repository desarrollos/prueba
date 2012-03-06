<%@ include file="config.jsp" %> 
<html xmlns="http://www.w3.org/1999/xhtml"> 
    <head> 
        <title>:: DELPHOS ::  - Requisitos de Programas o Familias en Acción - </title>
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
        <form action="" method="post"><input type="hidden" id="combo" /> <input type="hidden" id="nombreFormulario" value="RequisitosFamilias" /> <input type="hidden" id="servlet" value="RequisitosFamilias" /></form>
        <div id="dialog" class="c1">
            <div class="encabezado"></div>
            <div class="titulo">Requisitos de Programas o Familias en Acción</div> 
            <br />
            <div>
                <form id="RequisitosFamilias" method="post" accept-charset="utf-8" name="RequisitosFamilias"><input type="hidden" id="codigo" name="codigo" />
                    <input type="hidden" name="accion" id="accion" value="" />  
                    <div class="boton"><input type="submit" value="Mostrar Requisitos de Programas o Familias en Acción " onclick="return tabla(flexiRequisitosFamilias, 'Requisitos de Programas o Familias en Acción', '' )" />
                        <input type="submit" id="accion1" value="Registrar" onclick="accionFormulario('RequisitosFamilias', 'Registrar', ''); return false" />
                        <input type="reset" id="resetFormulario1" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" />
                        <input type="submit" id="actualizar1" value="Actualizar" onclick="accionFormulario('RequisitosFamilias', 'Actualizar', ''); return false" class="c2" />
                        <input type="submit" id="volver_registro1" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>
                    <table>

                        <tr>
                            <td>Codigo Requisito</td>
                        </tr>
                        <tr>
                            <td> <select  id="codtiporequisito_requisitos" name="codtiporequisito_requisitos" onfocus="tabla(flexiTipoRequisito, 'Tipo Requisito', 'codtiporequisito_requisitos' )" onclick="tabla(flexiTipoRequisito, 'Tipo Requisito', 'codtiporequisito_requisitos' )"></select></td>
                        </tr>
                        <tr>
                            <td>Tipo de Beneficiario</td>
                        </tr>
                        <tr>
                            <td> <select  id="coditipben_requisitos" name="coditipben_requisitos" onfocus="tabla(flexiTipoBeneficiario, 'Tipo Beneficiario', 'coditipben_requisitos' )" onclick="tabla(flexiTipoBeneficiario, 'Tipo Beneficiario', 'coditipben_requisitos' )"></select></td>
                        </tr>
                        <tr>
                            <td>Codigo Actividad</td>
                        </tr>
                        <tr>
                            <td> <select  id="codactividadsalud_requisitos" name="codactividadsalud_requisitos" onfocus="tabla(flexiActividadSalud, 'Tipo Actividad Salud', 'codactividadsalud_requisitos' )" onclick="tabla(flexiActividadSalud, 'Tipo Actividad Salud', 'codactividadsalud_requisitos' )"></select></td>
                        </tr>
                        <tr>
                            <td>Descripción del Requisito</td>
                        </tr>
                        <tr>
                            <td <%-- colspan="4" --%>> <textarea id="requisdescri_requisitos" name="requisdescri_requisitos" cols="50" rows="4"></textarea></td>
                        </tr>
                        <tr>
                            <td>Observaciones Requisito</td>
                        </tr>
                        <tr>
                            <td <%-- colspan="4" --%>> <textarea id="requisobserv_requisitos" name="requisobserv_requisitos" cols="50" rows="4"></textarea></td>
                        </tr>					 
                    </table>
                    <br />
                    <div class="boton"><input type="submit" id="accion2" value="Registrar" onclick="accionFormulario('RequisitosFamilias', 'Registrar', ''); return false" />
                        <input type="reset" id="resetFormulario2" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" />
                        <input type="submit" id="actualizar2" value="Actualizar" onclick="accionFormulario('RequisitosFamilias', 'Actualizar', ''); return false" class="c2" />
                        <input type="submit" id="volver_registro2" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>
                </form>
                <div class="boton"></div>
            </div>
        </div>
    </body>
</html>

