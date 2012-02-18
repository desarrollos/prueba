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
        <form><input type="hidden" id="respuestaAjax" /> <!-- Aqui saldra el flexigrid para la tabla --></form>
        <div id="tablaContenedor"></div>
        <form><input type="hidden" id="combo" /> <input type="hidden" id="nombreFormulario" value="Vinculacion" /> <input type="hidden" id="servlet" value="Vinculacion" /></form>
        <div id="dialog" class="c1">
            <div class="encabezado"></div>
            <div class="titulo">Vinculación</div>
            <br />
            <form id="Vinculacion" name="Vinculacion">
                <div class="boton"><input type="submit" id="accion1" value="Registrar" onclick="accionFormulario('Vinculacion', 'Registrar', ''); return false" /> <input type="reset" id="resetFormulario1" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" /> <input type="submit" id="actualizar1" value="Actualizar" onclick="accionFormulario('Vinculacion', 'Actualizar', ''); return false" class="c2" /> <input type="submit" id="volver_registro1" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>
                <br />
                <br />
                <input type="hidden" name="pestana" id="pestana" value="Vinculacion" /> <input type="hidden" id="codigo" name="codigo" /> <input type="hidden" name="accion" id="accion" value="" />
                <div id="tabs">
                    <ul>
                        <li><a href="#tabs-1" id="inscripcion" name="Inscripcion">Inscripci&oacute;n</a></li>
                        <li><a href="#tabs-2" id="documentoinscripcion" name="documentoinscripcion">Documentos</a></li>
                        <li><a href="#tabs-3" id="grupotitular" name="grupotitular">Grupos Titulares</a></li>
                        <li><a href="#tabs-4" id="titularfamilia" name="titularfamilia">Titular Familia</a></li>
                        <li><a href="#tabs-5" id="beneficiario" name="beneficiario">Beneficiarios</a></li>
                    </ul>
                    <div id="tabs-1">
                        <div class="boton">
                            <input type="submit" value="Mostrar Vinculaciones registradas " onclick="return tabla(flexiVinculacion, 'Inscripciones Registradas', '' );return false" />
                        </div>
                        <br />
                        <table>
                            <tr>
                                <td>C&oacute;digo Unico Familia </td>
                                <td>Empresa Aprobadora </td>
                                <td>Tipo Identificaci&oacute;n Jefe Hogar </td>
                                <td>Identificaci&oacute;n Jefe Hogar </td>
                            </tr>
                            <tr>
                                <td> <input type="text" id="codunifami_inscripcion" name="codunifami_inscripcion"/></td>
                                <td> <select name="empresa_inscripcion_1" id="empresa_inscripcion_1" onfocus="tabla(flexiEmpresas, 'Empresas Registradas', 'empresa_inscripcion_1' )" onclick="tabla(flexiEmpresas, 'Empresas Registradas', 'empresa_inscripcion_1' )"></select></td>
                                <td> <select name="tiidenjefhog_inscripcion" id="tiidenjefhog_inscripcion" onfocus="tabla(flexiTipoIdentificacion, 'Tipo Identificación', 'tiidenjefhog_inscripcion' )" onclick="tabla(flexiTipoIdentificacion, 'Tipo Identificación', 'tiidenjefhog_inscripcion' )"></select></td>
                                <td> <input type="text" id="idenjefhog_inscripcion" name="idenjefhog_inscripcion"/></td>
                            </tr>
                            <tr>
                                <td>Numero Declaraci&oacute;n </td>
                                <td>Fecha-Hora Diligenciamiento </td>
                                <td>Fecha-Hora Inscripci&oacute;n </td>
                                <!--<td>Departamento </td>-->
                            </tr>
                            <tr>
                                <td> <input type="text" id="numerdecla_inscripcion" name="numerdecla_inscripcion"/></td>
                                <td><input name="fechadilig_inscripcion" type="text" id="_fechahora_fechadilig_inscripcion" value="" maxlength="19" readonly="readonly" /></td>
                                <td><input name="fechainscr_inscripcion" type="text" id="_fechahora_fechainscr_inscripcion" value="" maxlength="19" readonly="readonly" /></td>
                                <!--<td> <select name="coddepartamento_inscripcion" id="coddepartamento_inscripcion" onfocus="tabla(flexiDepartamento, 'Departamentos', 'coddepartamento_inscripcion' )" onclick="tabla(flexiDepartamento, 'Departamentos', 'coddepartamento_inscripcion' )"></select></td>-->
                            </tr>
                            <tr>
                                <!--<td>Municipio </td>-->
                                <!--<td>Subgrupo Geogr&aacute;fico </td>-->
                                <td>Barrio </td>
                                <td>IPS Asignada </td>
                            </tr>
                            <tr>
                                <!--<td> <select name="codmunicipio_inscripcion" id="codmunicipio_inscripcion" onfocus="tabla(flexiMunicipio, 'Municipios', 'codmunicipio_inscripcion' )" onclick="tabla(flexiMunicipio, 'Municipios', 'codmunicipio_inscripcion' )"></select></td>-->
                                <!--<td> <select name="codsubgrupo_inscripcion" id="codsubgrupo_inscripcion" onfocus="tabla(flexiSubGrupoGeografico, 'Subgrupos Geográficos Registrados', 'codsubgrupo_inscripcion' )" onclick="tabla(flexiSubGrupoGeografico, 'Subgrupos Geográficos Registrados', 'codsubgrupo_inscripcion' )"></select></td>-->
                                <td> <select name="barrio_inscripcion_1" id="barrio_inscripcion_1" onfocus="tabla(flexiBarrio, 'Barrios Registrados', 'barrio_inscripcion_1' )" onclick="tabla(flexiBarrio, 'Barrios Registrados', 'barrio_inscripcion_1' )"></select></td>
                                <td> <select name="entidadsalud_inscripcion_1" id="entidadsalud_inscripcion_1" onfocus="tabla(flexiEntidadSalud, 'IPS Registradas', 'entidadsalud_inscripcion_1' )" onclick="tabla(flexiEntidadSalud, 'IPS Registradas', 'entidadsalud_inscripcion_1' )"></select></td>
                            </tr>
                            <tr>
                                <td>N&uacute;mero Cuenta Bancaria </td>
                                <td>Banco </td>
                                <td>Funcionario Aprueba </td>
                                <td>N&uacute;mero Mesa </td>
                            </tr>
                            <tr>
                                <td><input type="text" id="numcuebanc_inscripcion" name="numcuebanc_inscripcion"/></td>
                                <td> <select name="codbanco_inscripcion" id="codbanco_inscripcion" onfocus="tabla(flexiBanco, 'Bancos Registrados', 'codbanco_inscripcion' )" onclick="tabla(flexiBanco, 'Bancos Registrados', 'codbanco_inscripcion' )"></select></td>
                                <td> <select name="funcionario_inscripcion_1" id="funcionario_inscripcion_1" onfocus="tabla(flexiFuncionario, 'Funcionarios Registrados', 'funcionario_inscripcion_1' )" onclick="tabla(flexiFuncionario, 'Funcionarios Registrados', 'funcionario_inscripcion_1' )"></select></td>
                                <td><input type="text" id="numeromesa_inscripcion" name="numeromesa_inscripcion"/></td>
                            </tr>
                            <tr>
                                <td>Tipo Beneficiario </td>
                                <td>Ni&ntilde;os Menores a 7 A&ntilde;os   </td>
                                <td>Ni&ntilde;os Entre 7 y 18 A&ntilde;os </td>
                                <td>Reside Municipio </td>
                            </tr>
                            <tr>
                                <td> <select name="coditipben_inscripcion" id="coditipben_inscripcion" onfocus="tabla(flexiTipoBeneficiario, 'Tipos de Beneficiarios Registrados', 'coditipben_inscripcion' )" onclick="tabla(flexiTipoBeneficiario, 'Tipos de Beneficiarios Registrados', 'coditipben_inscripcion' )"></select></td>
                                <td><input type="text" id="meno7anyos_inscripcion" name="meno7anyos_inscripcion"/></td>
                                <td><input type="text" id="meno7a18anyos_inscripcion" name="meno7a18anyos_inscripcion"/></td>
                                <td><div id="switch_residmunic_inscripcion"></div> <input type="hidden" name="residmunic_inscripcion" id="residmunic_inscripcion" /></td>
                            </tr>
                            <tr>
                                <td>Se Compromete con Obligaciones </td>
                                <td>Fecha y Hora Aprobaci&oacute;n </td>
                                <td>Empresa Aprobadora </td>
                                <td>Funcionario Diligente </td>
                            </tr>
                            <tr>
                                <td><div id="switch_comproblig_inscripcion"></div> <input type="hidden" name="comproblig_inscripcion" id="comproblig_inscripcion" /></td>
                                <td><input name="fechaaprobac_inscripcion" type="text" id="_fechahora_fechaaprobac_inscripcion" value="" maxlength="19" readonly="readonly" /></td>
                                <td> <select name="empresa_inscripcion_2" id="empresa_inscripcion_2" onfocus="tabla(flexiEmpresas, 'IPS Registradas', 'empresa_inscripcion_2' )" onclick="tabla(flexiEmpresas, 'IPS Registradas', 'empresa_inscripcion_2' )"></select></td>
                                <td> <select name="funcionario_inscripcion_2" id="funcionario_inscripcion_2" onfocus="tabla(flexiFuncionario, 'Funcionarios Registrados', 'funcionario_inscripcion_2' )" onclick="tabla(flexiFuncionario, 'Funcionarios Registrados', 'funcionario_inscripcion_2' )"></select></td>
                            </tr>
                            <tr>
                                <td>Documento Afiliaci&oacute;n</td>
                                <td>N&uacute;mero Afiliaci&oacute;n </td>
                                <td>Estado Familia </td>
                                <td>Comprobante Inscripci&oacute;n </td>
                            </tr>
                            <tr>
                                <td><input name="arcdocapro_inscripcion" type="text" id="arcdocapro_inscripcion" size="17" value="" readonly="readonly" onclick="abrirCargaArchivo('arcdocapro_inscripcion')" />
                                    <img src="../images/descargar_1.png" width="30" height="30" onclick="reHref('arcdocapro_inscripcion' )" alt="Descargar" /></td>
                                <td><input type="text" id="numeraprob_inscripcion" name="numeraprob_inscripcion"/></td>
                                <td> <select name="codiestfam_inscripcion" id="codiestfam_inscripcion" onfocus="tabla(flexiEstadoFamilia, 'Estados de Familia Registrados', 'codiestfam_inscripcion' )" onclick="tabla(flexiEstadoFamilia, 'Estados de Familia Registrados', 'codiestfam_inscripcion' )"></select></td>
                                <td><input name="archcomins_inscripcion" type="text" id="archcomins_inscripcion" size="17" value="" readonly="readonly" onclick="abrirCargaArchivo('archcomins_inscripcion')" />
                                    <img src="../images/descargar_1.png" width="30" height="30" onclick="reHref('archcomins_inscripcion' )" alt="Descargar" /></td>
                            </tr>
                            <tr>
                                <td colspan="4">Observaciones</td>
                            </tr>
                            <tr>
                                <td  colspan="4"><textarea name="observacion_inscripcion" id="observacion_inscripcion" cols="110" rows="4"></textarea></td>
                            </tr>
                        </table>
                    </div>
                    <div id="tabs-2">
                        <div class="boton"><input type="submit" value="Mostrar Documentos Registrados" onclick="tabla(flexiDocumentoInscripcion, 'Mostrar Documentos Registrados', '' ); return false" /></div>
                        <br />
                        <br />
                        <table>


                            <tr>
                                <td>C&oacute;digo &Uacute;nico Familia</td>
                                <td>Codigo Tipo Documento Asociado</td>
                                <td>Tipo Identificación</td>
                                <td>Identificaci&oacute;n Persona Documento</td>
                            </tr>
                            <tr>
                                <td> <select  id="codunifami_documentoinscripcion" name="codunifami_documentoinscripcion" onfocus="tabla(flexiInscripcion, 'C&oacute;digo &Uacute;nico Familia', 'codunifami_documentoinscripcion' )" onclick="tabla(flexiInscripcion, 'C&oacute;digo &Uacute;nico Familia', 'codunifami_documentoinscripcion' )"></select></td>
                                <td> <select  id="codtipodctoasociado_documentoinscripcion" name="codtipodctoasociado_documentoinscripcion" onfocus="tabla(flexiTipoDocumentoAsociado, 'Codigo Tipo Documento Asociado', 'codtipodctoasociado_documentoinscripcion' )" onclick="tabla(flexiTipoDocumentoAsociado, 'Codigo Tipo Documento Asociado', 'codtipodctoasociado_documentoinscripcion' )"></select></td>
                                <td> <select  id="codtipoidentidad_documentoinscripcion" name="codtipoidentidad_documentoinscripcion" onfocus="tabla(flexiTipoIdentificacion, 'Tipo Identificación', 'codtipoidentidad_documentoinscripcion' )" onclick="tabla(flexiTipoIdentificacion, 'Tipo Identificación', 'codtipoidentidad_documentoinscripcion' )"></select></td>
                                <td> <input type="text" id="idenperdoc_documentoinscripcion" name="idenperdoc_documentoinscripcion"/></td>
                            </tr>
                            <tr>
                                <td>Descripci&oacute;n Documento Inscripci&oacute;n</td>
                            </tr>
                            <tr>
                                <td colspan="4"> <textarea id="descripcion_documentoinscripcion" name="descripcion_documentoinscripcion" cols="110" rows="4"></textarea></td>
                            </tr>
                        </table>
                    </div>
                    <div id="tabs-3">
                        <div class="boton"><input type="submit" value="Mostrar Grupo Titulares registradas" onclick="tabla(flexiGrupoTiular, 'Grupos Titiulares', '' ); return false" /></div>
                        <br />
                        <br />
                        <table>

                            <tr>
                                <td>Código Clase Grupo Titular</td>
                                <td>Titular Familia</td>
                            </tr>
                            <tr>
                                <td> <select  id="codclagrutit_grupotitular" name="codclagrutit_grupotitular" onfocus="tabla(flexiClaseGrupoTitular, 'Código Clase Grupo Titular', 'codclagrutit_grupotitular' )" onclick="tabla(flexiClaseGrupoTitular, 'Código Clase Grupo Titular', 'codclagrutit_grupotitular' )"></select></td>
                                <td> <select  id="titularfamilia_grupotitular_1" name="titularfamilia_grupotitular_1" onfocus="tabla(flexiTitularFamilia, 'Titular Familia', 'titularfamilia_grupotitular_1' )" onclick="tabla(flexiTitularFamilia, 'Titular Familia', 'titularfamilia_grupotitular_1' )"></select></td>

                            </tr>
                            <tr>
                                <td>Observaciones</td>
                            </tr>
                            <tr>
                                <td colspan="4"> <textarea id="observacion_grupotitular" name="observacion_grupotitular" cols="50" rows="4"></textarea></td>
                            </tr>

                        </table>
                    </div>
                    <div id="tabs-4">
                        <div class="boton"><input type="submit" value="Mostrar Titulares Familia registrados" onclick="tabla(flexiTitularFamilia, 'Mostrar Titulares Familia registrados', '' ); return false" /></div>
                        <br />
                        <br />
                        <table>


                            <tr>
                                <td>Código &Uacute;nico Familia</td>
                                <td>Tipo Identificaci&oacute;n del Titular</td>
                                <td>Identificación Titular Familia</td>
                                <td>C&oacute;digo Tipo Titular</td>
                            </tr>
                            <tr>
                                <td> <select  id="codunifami_titularfamilia" name="codunifami_titularfamilia" onfocus="tabla(flexiInscripcion, 'Código &Uacute;nico Familia', 'codunifami_titularfamilia' )" onclick="tabla(flexiInscripcion, 'Código &Uacute;nico Familia', 'codunifami_titularfamilia' )"></select></td>
                                <td> <select  id="codtipoidentidad_titularfamilia" name="codtipoidentidad_titularfamilia" onfocus="tabla(flexiTipoIdentificacion, 'Tipo Identificaci&oacute;n del Titular', 'codtipoidentidad_titularfamilia' )" onclick="tabla(flexiTipoIdentificacion, 'Tipo Identificaci&oacute;n del Titular', 'codtipoidentidad_titularfamilia' )"></select></td>
                                <td> <input type="text" id="identitfam_titularfamilia" name="identitfam_titularfamilia"/></td>
                                <td> <select  id="coditiptit_titularfamilia" name="coditiptit_titularfamilia" onfocus="tabla(flexiTipoTitular, 'C&oacute;digo Tipo Titular', 'coditiptit_titularfamilia' )" onclick="tabla(flexiTipoTitular, 'C&oacute;digo Tipo Titular', 'coditiptit_titularfamilia' )"></select></td>
                            </tr>
                            <tr>
                                <td>Fecha Inicial Asignado Titular</td>
                                <td>Vive Hijos o Beneficiarios (S/N)</td>
                                <td>N&uacute;mero Cuenta Bancaria</td>
                                <td>Codigo Banco Cuenta</td>
                            </tr>
                            <tr>
                                <td> <input type="text" id="_fecha_fechinitit_titularfamilia" name="fechinitit_titularfamilia"/></td>
                                <td><div id="switch_vivehijos_titularfamilia"></div> <input type="hidden" id="vivehijos_titularfamilia" name="vivehijos_titularfamilia"  /></td>
                                <td> <input type="text" id="numecueban_titularfamilia" name="numecueban_titularfamilia"/></td>
                                <td> <select  id="codbanco_titularfamilia" name="codbanco_titularfamilia" onfocus="tabla(flexiBanco, 'Tipo Identificaci&oacute;n del Titular', 'codbanco_titularfamilia' )" onclick="tabla(flexiBanco, 'Tipo Identificaci&oacute;n del Titular', 'codbanco_titularfamilia' )"></select></td>
                            </tr>
                            <tr>
                                <td>Código Estado Titular Familia</td>
                                <td>Firma Titular</td>
                                <td>Observaciones Registro Titular</td>
                            </tr>
                            <tr>
                                <td> <select  id="codiesttit_titularfamilia" name="codiesttit_titularfamilia" onfocus="tabla(flexiEstadoTitular, 'C&oacute;digo Estado Titular', 'codiesttit_titularfamilia' )" onclick="tabla(flexiEstadoTitular, 'C&oacute;digo Estado Titular', 'codiesttit_titularfamilia' )"></select></td>
                                <td><input name="firmatitul_titularfamilia" type="text" id="firmatitul_titularfamilia" size="17" value="" readonly="readonly" onclick="abrirCargaArchivo('firmatitul_titularfamilia')" />   <img src="../images/descargar_1.png" width="30" height="30" onclick="reHref('firmatitul_titularfamilia' )" alt="Descargar" /></td>
                                <td colspan="2"> <textarea id="observacion_titularfamilia" name="observacion_titularfamilia" cols="50" rows="4"></textarea></td>
                            </tr>
                        </table>
                    </div>
                    <div id="tabs-5">
                        <div class="boton"><input type="submit" value="Mostrar beneficiarios registrados" onclick="tabla(flexiBeneficiario, 'Beneficiarios', '' ); return false" /></div>
                        <br />
                        <br />
                        <table>

                            <tr>
                                <td>Código Unico Familia</td>
                                <td>Tipo Identificación</td>
                                <td>Numero Identificación</td>
                                <td>Fecha Nacimiento</td>
                            </tr>
                            <tr>
                                <td> <select  id="codunifami_beneficiario" name="codunifami_beneficiario" onfocus="tabla(flexiInscripcion, 'Código Unico Familia', 'codunifami_beneficiario' )" onclick="tabla(flexiInscripcion, 'Código Unico Familia', 'codunifami_beneficiario' )"></select></td>
                                <td> <select  id="codtipoidentidad_beneficiario" name="codtipoidentidad_beneficiario" onfocus="tabla(flexiTipoIdentificacion, 'Tipo Identificación', 'codtipoidentidad_beneficiario' )" onclick="tabla(flexiTipoIdentificacion, 'Tipo Identificación', 'codtipoidentidad_beneficiario' )"></select></td>
                                <td> <input type="text" id="identbenef_beneficiario" name="identbenef_beneficiario"/></td>
                                <td><input type="text" id="_fecha_fechanacim_beneficiario" name="fechanacim_beneficiario" value="" maxlength="19" readonly="readonly" /></td>
                            </tr>
                            <tr>
                                <td>Código Beneficiario</td>
                                <td>Parentesco</td>
                                <td>Empresa</td>
                                <td>Certificado Escolar Inicial</td>
                            </tr>
                            <tr>
                                <td> <input type="text" id="codigbenef_beneficiario" name="codigbenef_beneficiario"/></td>
                                <td> <select  id="codtipoparentesco_beneficiario" name="codtipoparentesco_beneficiario" onfocus="tabla(flexiTipoParentesco, 'Parentesco', 'codtipoparentesco_beneficiario' )" onclick="tabla(flexiTipoParentesco, 'Parentesco', 'codtipoparentesco_beneficiario' )"></select></td>
                                <td> <select  id="empresa_beneficiario_1" name="empresa_beneficiario_1" onfocus="tabla(flexiEmpresas, 'Empresa', 'empresa_beneficiario_1' )" onclick="tabla(flexiEmpresas, 'Empresa', 'empresa_beneficiario_1' )"></select></td>
                                <td> <input type="text" id="numceresco_beneficiario" name="numceresco_beneficiario"/></td>
                            </tr>
                            <tr>
                                <td>Grado Escolaridad Inicial</td>
                                <td>IPS Asignada</td>
                                <td>Numero de Cuenta</td>
                                <td>Banco</td>
                            </tr>
                            <tr>
                                <td> <select  id="escgracodigo_beneficiario" name="escgracodigo_beneficiario" onfocus="tabla(flexiEscolaridadGrado, 'Grado Escolaridad', 'escgracodigo_beneficiario' )" onclick="tabla(flexiEscolaridadGrado, 'Grado Escolaridad', 'escgracodigo_beneficiario' )"></select></td>
                                <td> <select  id="entidadsalud_beneficiario_1" name="entidadsalud_beneficiario_1" onfocus="tabla(flexiEntidadSalud, 'IPS Asignada', 'entidadsalud_beneficiario_1' )" onclick="tabla(flexiEntidadSalud, 'IPS Asignada', 'entidadsalud_beneficiario_1' )"></select></td>
                                <td> <input type="text" id="numcuebanc_beneficiario" name="numcuebanc_beneficiario"/></td>
                                <td> <select  id="codbanco_beneficiario" name="codbanco_beneficiario" onfocus="tabla(flexiBanco, 'Banco', 'codbanco_beneficiario' )" onclick="tabla(flexiBanco, 'Banco', 'codbanco_beneficiario' )"></select></td>
                            </tr>
                            <tr>
                                <td>Estado Beneficiario</td>
                                <td>Vive con el titular</td>

                            </tr>
                            <tr>
                                <td> <select  id="codiestben_beneficiario" name="codiestben_beneficiario" onfocus="tabla(flexiEstadoBeneficiario, 'Estado Beneficiario', 'codiestben_beneficiario' )" onclick="tabla(flexiEstadoBeneficiario, 'Estado Beneficiario', 'codiestben_beneficiario' )"></select></td>
                                <td><div id="switch_vivecontit_beneficiario"></div> <input type="hidden" id="vivecontit_beneficiario" name="vivecontit_beneficiario"  /></td>

                            </tr>
                            <tr>
                                <td>Observaciones</td>
                            </tr>
                            <tr>
                                <td colspan="4"> <textarea id="observacion_beneficiario" name="observacion_beneficiario" cols="110" rows="4"></textarea></td>
                            </tr>
                        </table>
                    </div>
                </div>
            </form>
            <div class="boton"><input type="submit" id="accion2" value="Registrar" onclick="accionFormulario('Vinculacion', 'Registrar', ''); return false" /> <input type="reset" id="resetFormulario2" value="Limpiar Formulario" onclick="redireccionar(urlActual);return false;" /> <input type="submit" id="actualizar2" value="Actualizar" onclick="accionFormulario('Vinculacion', 'Actualizar', ''); return false" class="c2" /> <input type="submit" id="volver_registro2" value="Volver al formulario de registro" onclick="redireccionar(urlActual);return false" class="c2" /></div>
        </div>
        
    </body>
