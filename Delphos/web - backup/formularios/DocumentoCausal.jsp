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
        <form action="" method="post"><input type="hidden" id="combo" /> <input type="hidden" id="nombreFormulario" value="DocumentoCausal" /> <input type="hidden" id="servlet" value="DocumentoCausal" /></form>
        <div id="dialog" class="c1">
            <div class="encabezado"></div>
            <div class="titulo">Documento Causal</div> 
            <br />
            <div>
                <form id="DocumentoCausal" method="post" accept-charset="utf-8" name="DocumentoCausal"><input type="hidden" id="codigo" name="codigo" />
                    <input type="hidden" name="accion" id="accion" value="" />  
                    <div class="boton"><input type="submit" value="Mostrar Documento Causal " onclick="return tabla(flexiDocumentoCausal, 'Documento Causal', '' )" />
                        <input type="submit" id="accion1" value="Registrar" onclick="accionFormulario('DocumentoCausal', 'Registrar', ''); return false" />
                        <input type="reset" id="resetFormulario1" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" />
                        <input type="submit" id="actualizar1" value="Actualizar" onclick="accionFormulario('DocumentoCausal', 'Actualizar', ''); return false" class="c2" />
                        <input type="submit" id="volver_registro1" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>
                    <table>
                        <tr>
                            <td>Causal Novedad</td>
                        </tr>
                        <tr>
                            <td> <select  id="novedadcausal_documentocausal_1" name="novedadcausal_documentocausal_1" onfocus="tabla(flexiNovedadCausal, 'Causal Novedad', 'novedadcausal_documentocausal_1' )" onclick="tabla(flexiNovedadCausal, 'Causal Novedad', 'novedadcausal_documentocausal_1' )"></select></td>
                        </tr>
                        <tr>
                            <td>Tipo Documento Asociado</td>
                        </tr>
                        <tr>
                            <td> <select  id="codtipodctoasociado_documentocausal" name="codtipodctoasociado_documentocausal" onfocus="tabla(flexiTipoDocumentoAsociado, 'Causal Novedad', 'codtipodctoasociado_documentocausal' )" onclick="tabla(flexiTipoDocumentoAsociado, 'Causal Novedad', 'codtipodctoasociado_documentocausal' )"></select></td>
                        </tr>
                        <tr>
                            <td>Observaciones Causal Documentos</td>
                        </tr>
                        <tr>
                            <td <%-- colspan="4" --%>> <textarea id="doccauobserv_documentocausal" name="doccauobserv_documentocausal" cols="50" rows="4"></textarea></td>
                        </tr>					 </table>
                    <br />
                    <div class="boton"><input type="submit" id="accion2" value="Registrar" onclick="accionFormulario('DocumentoCausal', 'Registrar', ''); return false" />
                        <input type="reset" id="resetFormulario2" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" />
                        <input type="submit" id="actualizar2" value="Actualizar" onclick="accionFormulario('DocumentoCausal', 'Actualizar', ''); return false" class="c2" />
                        <input type="submit" id="volver_registro2" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>
                </form>
                <div class="boton"></div>
            </div>
        </div>
       
    </body>
</html>

