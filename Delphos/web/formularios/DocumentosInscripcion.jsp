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
        <form action="" method="post"><input type="hidden" id="combo" /> <input type="hidden" id="nombreFormulario" value="Estado Titular" /> <input type="hidden" id="servlet" value="DocumentosInscripcion" /></form>
        <div id="dialog" class="c1">
            <div class="encabezado"></div>
            <div class="titulo">DOCUMENTO INCRIPCION</div>
            <br />
            <div>
                <form id="DocumentosInscripcion" method="post" accept-charset="utf-8" name="DocumentosInscripcion"><input type="hidden" id="codigo" name="codigo" />
                    <input type="hidden" name="accion" id="accion" value="" />
                    <div class="boton"><input type="submit" value="Mostrar Documentos de Incripción " onclick="return tabla(flexiDocumentoInscripcion, 'Documento Inscripcion', '' )" />
                        <input type="submit" id="accion1" value="Registrar" onclick="accionFormulario('DocumentosInscripcion', 'Registrar', ''); return false" />
                        <input type="reset" id="resetFormulario1" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" />
                        <input type="submit" id="actualizar1" value="Actualizar" onclick="accionFormulario('DocumentosInscripcion', 'Actualizar', ''); return false" class="c2" />
                        <input type="submit" id="volver_registro1" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>
                    <br />
                    <table>


                        <tr>
                            <td>Código Único Familia</td>
                            <td>Tipo Documento Asociado</td>
                            <td>Tipo Identificacion</td>
                        </tr>
                        <tr>
                            <td> <select  id="codunifami_documentoinscripcion" name="codunifami_documentoinscripcion" onfocus="tabla(flexiVinculacion, 'Incripciones', 'codunifami_documentoinscripcion' )" onclick="tabla(flexiVinculacion, 'Incripciones', 'codunifami_documentoinscripcion' )"></select></td>
                            <td> <select  id="codtipodctoasociado_documentoinscripcion" name="codtipodctoasociado_documentoinscripcion" onfocus="tabla(flexiTipoDocumentoAsociado, 'Tipo Documento Asociado', 'codtipodctoasociado_documentoinscripcion' )" onclick="tabla(flexiTipoDocumentoAsociado, 'Tipo Documento Asociado', 'codtipodctoasociado_documentoinscripcion' )"></select></td>
                            <td> <select  id="codtipoidentidad_documentoinscripcion" name="codtipoidentidad_documentoinscripcion" onfocus="tabla(flexiTipoIdentificacion, 'Tipo Identificacion', 'codtipoidentidad_documentoinscripcion' )" onclick="tabla(flexiTipoIdentificacion, 'Tipo Identificacion', 'codtipoidentidad_documentoinscripcion' )"></select></td>
                        </tr>
                        <tr>
                            <td>Numero Identificacion</td>
                            <td>Archivo Documento</td>
                            <td>Descripción</td>
                        </tr>
                        <tr>
                            <td> <input type="text" id="idenperdoc_documentoinscripcion" name="idenperdoc_documentoinscripcion"/></td>
                            <td><input name="archidocum_documentoinscripcion" type="text" id="archidocum_documentoinscripcion" size="17" value="" readonly="readonly" onclick="abrirCargaArchivo('archidocum_documentoinscripcion')" />   <img src="../images/descargar_1.png" width="30" height="30" onclick="reHref('archidocum_documentoinscripcion' )" alt="Descargar" /></td>
                            <td> <input type="text" id="descripcion_documentoinscripcion" name="descripcion_documentoinscripcion"/></td>
                        </tr>

                    </table>
                    <!-- Acciones estan
                                        1 - > registrar
                                        2 -> actualizar -->
                    <div class="boton"><input type="submit" id="accion2" value="Registrar" onclick="accionFormulario('DocumentosInscripcion', 'Registrar', ''); return false" /> <input type="reset" id="resetFormulario2" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" /> <input type="submit" id="actualizar2" value="Actualizar" onclick="accionFormulario('DocumentosInscripcion', 'Actualizar', ''); return false" class="c2" />
                        <input type="submit" id="volver_registro2" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>
                </form>
                <div class="boton"></div>
            </div>
        </div>
       
    </body>
</html>
