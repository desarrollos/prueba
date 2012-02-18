<%--
    Document   : menu_familias
    Created on : 15/06/2011, 14:16PM
    Author     : Gustavo, Sebastian

    Contiene el menu de familas en accion
--%>
<%
    String comunFS = "../ComunFS/";
    String FamiliasEnAccion = "../ComunFS/";
    String TablasBasicas = "../ComunFS/";
    String SistemaSalud = "../ComunFS/";
    String reportes = "../reportes/";
    String formularios ="../formularios/";
%>
<!--<a href="<%= SistemaSalud%>CargarArchivo.jsp" onclick="traer( 'CargarArchivo.jsp' ); return false">Recepci&oacute;n Archivo</a>-->

<ul id="salud" class="filetree" style="font-size:12px;">
    <li><span class="folder">SISTEMA SALUD</span>
        <ul>
            <li><span class="folder">CONTRATACI&Oacute;N</span>
                <ul>
                    <li><span class="folder">Minutas</span>
                        <ul>
                            <span class="file"><li>
                                    <a href="<%= SistemaSalud%>Contrato.jsp">Contratos</a>
                                </li></span>
                            <span class="file"> <li>
                                    <a href="<%= SistemaSalud%>Actividades.jsp">Actividades</a>
                                </li></span>
                            <span class="file"> <li>
                                    <a href="<%= SistemaSalud%>Modificaciones.jsp">Modificaciones</a>
                                </li></span>
                            <span class="file"> <li>
                                    <a href="<%= SistemaSalud%>Obligaciones.jsp">Obligaciones</a>
                                </li></span>
                            <span class="file"> <li>
                                    <a href="<%= SistemaSalud%>PoblacionContrato.jsp">Poblaci&oacute;n Contrato</a>
                                </li></span>
                            <span class="file">  <li>
                                    <a href="<%= SistemaSalud%>Requisitos.jsp">Requisitos</a>
                                </li></span>
                            <span class="file"> <li>
                                    <a href="<%= SistemaSalud%>RubroPptoContrato.jsp">Rubro Presupuestal</a>
                                </li></span>
                            <span class="file"> <li>
                                    <a href="<%= SistemaSalud%>Funcion.jsp">Funciones</a>
                                </li></span>
                            <span class="file">  <li>
                                    <a href="<%= SistemaSalud%>FuncionTipoPersona.jsp">Funci&oacute; Tipo Persona</a>
                                </li></span>
                            <span class="file">  <li>
                                    <a href="<%= SistemaSalud%>PagoCompartido.jsp">Pago Compartido</a>
                                </li></span>
                        </ul>
                    </li>
                </ul>

            </li>



            <li><span class="folder">Documentos o Soportes</span>
                <ul>
                    <span class="file">    <li>
                            <a href="<%= SistemaSalud%>DocumentoAsociado.jsp">Documento Asociado</a>
                        </li></span>
                    <span class="file">    <li>
                            <a href="<%= SistemaSalud%>CampoIPSEAPB.jsp">Campo ISP-EAPB</a>
                        </li></span>
                    <span class="file">   <li>
                            <a href="<%= SistemaSalud%>FormatoRelacionado.jsp">Formato Relacionado</a>
                        </li></span>
                    <span class="file">   <li>
                            <a href="<%= SistemaSalud%>Polizas.jsp">P&oacute;lizas</a>
                        </li></span>
                    <span class="file">     <li>
                            <a href="<%= SistemaSalud%>SoporteModalidad.jsp">Soporte Modalidad</a>
                        </li></span>
                    <span class="file">  <li>
                            <a href="<%= SistemaSalud%>SoporteContrato.jsp">Soportes Contrato</a>
                        </li></span>
                </ul>

            </li>



            <li><span class="folder">Actas y liquidaciones</span>
                <ul>
                    <span class="file">    <li>
                            <a href="<%= SistemaSalud%>ActasPorContrato.jsp">Actas por Contrato</a>
                        </li></span>
                    <span class="file">   <li>
                            <a href="<%= SistemaSalud%>FuncionariosActas.jsp">Funcionarios Actas</a>
                        </li></span>
                    <span class="file">   <li>
                            <a href="<%= SistemaSalud%>Interventoria.jsp">Interventor&iacute;a</a>
                        </li></span>
                    <span class="file">   <li>
                            <a href="<%= SistemaSalud%>Liquidacion.jsp">Liquidaci&oacute;n</a>
                        </li></span>
                    <span class="file">    <li>
                            <a href="<%= SistemaSalud%>PlanInterventoria.jsp">Plan de Interventor&iacute;a</a>
                        </li></span>
                </ul>

            </li>



            <li><span class="folder">Novedades</span>
                <ul>
                    <span class="file">   <li>
                            <a href="<%= SistemaSalud%>PagosContrato.jsp">Pagos Contrato</a>
                        </li></span>
                    <span class="file">     <li>
                            <a href="<%= SistemaSalud%>TramiteGlosas.jsp">Tr&aacute;mite de Glosas</a>
                        </li></span>
                    <span class="file">     <li>
                            <a href="<%= SistemaSalud%>UsuariosPagados.jsp">Usuarios Pagados</a>
                        </li></span>
                </ul>

            </li>



            <li><span class="folder">Configuracion B&aacute;sica</span>
                <ul>
                    <li><span class="folder">Parametrizaci&oacute;n</span>
                        <ul>
                            <span class="file">   <li>
                                    <a href="<%= TablasBasicas%>TipoContrato.jsp">Tipo de Contrato</a>
                                </li></span>
                            <span class="file">  <li>
                                    <a href="<%= TablasBasicas%>AplicacionContrato.jsp">Aplicaci&oacute;n Contrato</a>
                                </li></span>
                            <span class="file">  <li>
                                    <a href="<%= TablasBasicas%>ClaseContrato.jsp">Clase de Contrato</a>
                                </li></span>
                            <span class="file">  <li>
                                    <a href="<%= TablasBasicas%>ModalidadContrato.jsp">Modalidad Contrato</a>
                                </li></span>
                            <span class="file">  <li>
                                    <a href="<%= TablasBasicas%>EstadoContrato.jsp">Estado Contrato</a>
                                </li></span>
                            <span class="file">  <li>
                                    <a href="<%= TablasBasicas%>TipoFaseContrato.jsp">Fases Contrato</a>
                                </li></span>
                            <span class="file">   <li>
                                    <a href="<%= TablasBasicas%>TipoIntervencContrato.jsp">Tipo Intervenci&oacute;n</a>
                                </li></span>
                            <span class="file">   <li>
                                    <a href="<%= TablasBasicas%>SoporteModalCto.jsp">Soporte Modalidad</a>
                                </li></span>
                            <span class="file">  <li>
                                    <a href="<%= TablasBasicas%>FormatoIpsEapb.jsp">Formatos IPS-EAPB</a>
                                </li></span>
                        </ul>

                    </li>


                    <li><span class="folder">B&aacute;sicas</span>
                        <ul>
                            <span class="file"> <li>
                                    <a href="<%= TablasBasicas%>TipoRequisito.jsp">Tipos Requisitos</a>
                                </li></span>
                            <span class="file">  <li>
                                    <a href="<%= TablasBasicas%>TipoSoporte.jsp">Tipos Soportes</a>
                                </li></span>
                            <span class="file">    <li>
                                    <a href="<%= TablasBasicas%>TipoActaContrato.jsp">Tipos Actas</a>
                                </li></span>
                            <span class="file">  <li>
                                    <a href="<%= TablasBasicas%>TipoPoliza.jsp">Tipos P&oacute;lizas</a>
                                </li></span>
                            <span class="file">   <li>
                                    <a href="<%= TablasBasicas%>TipoObligContrato.jsp">Tipo Obligaci&oacute;n</a>
                                </li></span>
                            <span class="file">   <li>
                                    <a href="<%= TablasBasicas%>ConcepEspecifGlosa.jsp">Espec&iacute;fico Glosas</a>
                                </li></span>
                            <span class="file"> <li>
                                    <a href="<%= TablasBasicas%>ConcepGeneralGlosas.jsp">Generalidad Glosas</a>
                                </li></span>
                            <span class="file">     <li>
                                    <a href="<%= TablasBasicas%>EstadoCumplimiento.jsp">Estado Cumplimiento</a>
                                </li></span>
                            <span class="file">   <li>
                                    <a href="<%= TablasBasicas%>EstadoRegistro.jsp">Estado Registro</a>
                                </li></span>
                            <span class="file">    <li>
                                    <a href="<%= TablasBasicas%>ManualConcGlosa.jsp">Manual Glosas</a>
                                </li></span>
                            <span class="file">    <li>
                                    <a href="<%= TablasBasicas%>RubroPresupuestal.jsp">Rubro Presupuestal</a>
                                </li></span>
                        </ul>

                    </li>
                </ul>

            </li>


            <li><span class="folder">Poblaci&oacute;n Aseguramiento</span>
                <ul>
                    <span class="file"> <li>
                            <a href="<%= SistemaSalud%>Autorizacion.jsp">Autorizaci&oacute;n</a>
                        </li></span>
                    <span class="file">  <li>
                            <a href="<%= SistemaSalud%>Poblacion.jsp">Poblaci&oacute;n</a>
                        </li></span>
                    <span class="file">  <li>
                            <a href="#">Poblaci&oacute;n Peri&oacute;dica</a>
                        </li></span>
                    <span class="file">  <li>
                            <a href="<%= SistemaSalud%>CargarArchivo.jsp?o=t">Recepci&oacute;n Archivo</a>
                        </li></span>
                    <span class="file">  <li>
                            <a href="<%= SistemaSalud%>EntregaBD.jsp">Entrega Bases de Datos</a>
                        </li></span>

                    <li><span class="folder">Detalle Archivo</span>
                        <ul>
                            <span class="file">  <li>
                                    <a href="<%= SistemaSalud%>EstructuraArchivo.jsp">Estructura Archivo</a>
                                </li></span>
                            <span class="file">  <li>
                                    <a href="<%= SistemaSalud%>DetalleIncosistencia.jsp">Detalle Inconsistencia</a>
                                </li></span>
                            <span class="file">   <li>
                                    <a href="<%= SistemaSalud%>NovedadDato.jsp">Novedad Dato</a>
                                </li></span>
                        </ul>

                    </li>


                    <li><span class="folder">Generaci&oacute;n Archivos</span>
                        <ul>
                            <span class="file"><li>
                                    <a href="#">Maestro Poblaci&oacute;n</a>
                                </li></span>
                            <span class="file"> <li>
                                    <a href="#">Novedad Poblaci&oacute;n</a>
                                </li></span>
                            <span class="file">  <li>
                                    <a href="#">Translados</a>
                                </li></span>
                            <span class="file">   <li>
                                    <a href="#">Aportes</a>
                                </li></span>


                        </ul>

                    </li>


                    <li><span class="folder">Glosas Afiliaci&oacute;n</span>
                        <ul>
                            <span class="file"> <li>
                                    <a href="<%= SistemaSalud%>GlosasRecibidas.jsp">Glosas Recibidas</a>
                                </li></span>
                            <span class="file">  <li>
                                    <a href="<%= SistemaSalud%>RespuestaGlosas.jsp">Respuesta Glosas</a>
                                </li></span>

                        </ul>

                    </li>

                    <li><span class="folder">BI - Gesti&oacute;n Informaci&oacute;n</span>
                        <ul>
                            <!-- <span class="file">  <li>
                                  <a href="#">An&aacute;lisis Multiafiliaci&oacute;n </a>
                              </li></span>
                              <span class="file"> <li>
                                  <a href="#">Recursos Afiliaci&oacute;n</a>
                              </li></span>
                             <span class="file">  <li>
                                  <a href="#">Inteligencia Negocios</a>
                              </li></span>-->
                            <span class="file"> <li>
                                    <a href="<%= reportes%>reportePoblacion.jsp">Reporte Poblacion</a>
                                </li></span>

                        </ul>

                    </li>




                    <li><span class="folder">Configuraci&oacute;n B&aacute;sica</span>
                        <ul>

                            <li><span class="folder">Datos B&aacute;sicos</span>
                                <ul>
                                    <span class="file"> <li>
                                            <a href="<%= TablasBasicas%>CriterioTipoIdent.jsp">Criterios Tipo Identificaci&oacute;n</a>
                                        </li></span>
                                    <span class="file">  <li>
                                            <a href="<%= TablasBasicas%>EstadoCivil.jsp">Estado Civil</a>
                                        </li></span>
                                    <span class="file"> <li>
                                            <a href="<%= TablasBasicas%>GrupoPoblacion.jsp">Grupo Poblacional</a>
                                        </li></span>
                                    <span class="file"> <li>
                                            <a href="<%= TablasBasicas%>GrupoEdad.jsp">Grupos de Sexo</a>
                                        </li></span>
                                    <span class="file"> <li>
                                            <a href="<%= TablasBasicas%>NombresXSexo.jsp">Nombres por Sexo</a>
                                        </li></span>
                                    <span class="file"> <li>
                                            <a href="<%= TablasBasicas%>TipoParentesco.jsp">Parentesco</a>
                                        </li></span>
                                    <span class="file">   <li>
                                            <a href="<%= TablasBasicas%>Etnia.jsp">Pertenencia &Eacute;tnica</a>
                                        </li></span>
                                    <span class="file">  <li>
                                            <a href="<%= TablasBasicas%>Sexo.jsp">Sexo</a>
                                        </li></span>
                                    <span class="file">  <li>
                                            <a href="<%= TablasBasicas%>TipoIdentificacion.jsp">Tipo de Identificaci&oacute;n</a>
                                        </li></span>
                                    <span class="file">  <li>
                                            <a href="<%= TablasBasicas%>TipoPoblacion.jsp">Tipo de Poblaci&oacute;n</a>
                                        </li></span>
                                    <span class="file">  <li>
                                            <a href="<%= TablasBasicas%>TipoGrupoEdad.jsp">Tipo Grupo Edad</a>
                                        </li></span>
                                    <span class="file">  <li>
                                            <a href="<%= TablasBasicas%>UnidadMedidaEdad.jsp">Medida Edad</a>
                                        </li></span>



                                </ul>

                            </li>
                            <li><span class="folder">Afiliaci&oacute;n</span>
                                <ul>
                                    <span class="file"> <li>
                                            <a href="<%= TablasBasicas%>EstructNovedades.jsp">Afiliado Estructura C&oacute;digo Novedad</a>
                                        </li></span>
                                    <span class="file">  <li>
                                            <a href="<%= TablasBasicas%>AplicacNovedadRegimen.jsp">Aplica Novedad R&eacute;gimen</a>
                                        </li></span>
                                    <span class="file">  <li>
                                            <a href="<%= TablasBasicas%>CapacidadPagoUsua.jsp">Capacidad de Pago</a>
                                        </li></span>
                                    <span class="file">  <li>
                                            <a href="<%= TablasBasicas%>CausalTraslado.jsp">Causal Traslado</a>
                                        </li></span>
                                    <span class="file">  <li>
                                            <a href="<%= TablasBasicas%>CondicionBeneficiario.jsp">Condici&oacute;n Beneficiario</a>
                                        </li></span>
                                    <span class="file">  <li>
                                            <a href="<%= TablasBasicas%>CondicionUsuario.jsp">Condici&oacute;n Usuario</a>
                                        </li></span>
                                    <span class="file">   <li>
                                            <a href="<%= TablasBasicas%>EstadoUsuaPoblac.jsp">Estado Usuario</a>
                                        </li></span>
                                    <span class="file">   <li>
                                            <a href="<%= TablasBasicas%>EstadoAfiliacion.jsp">Estado Afiliaci&oacute;n</a>
                                        </li></span>
                                    <span class="file">   <li>
                                            <a href="<%= TablasBasicas%>EstratoSocioEconomico.jsp">Estato o Nivel</a>
                                        </li></span>
                                    <span class="file">  <li>
                                            <a href="<%= TablasBasicas%>ModalidadSubsidio.jsp">Modalidad Subsidio</a>
                                        </li></span>
                                    <span class="file">   <li>
                                            <a href="<%= TablasBasicas%>NovedadCampo.jsp">Novedad Dato Afiliaci&oacute;n</a>
                                        </li></span>
                                    <span class="file">  <li>
                                            <a href="<%= formularios%>Regimen.jsp">R&eacute;gimen</a>
                                        </li></span>
                                    <span class="file">   <li>
                                            <a href="<%= TablasBasicas%>TipoAfiliado.jsp">Tipo Afiliado</a>
                                        </li></span>
                                    <span class="file">    <li>
                                            <a href="<%= TablasBasicas%>TipoAportante.jsp">Tipo Aportante</a>
                                        </li></span>
                                    <span class="file">   <li>
                                            <a href="<%= TablasBasicas%>TipoCausaTraslado.jsp">Tipo Causal Traslado</a>
                                        </li></span>
                                    <span class="file">    <li>
                                            <a href="<%= TablasBasicas%>TipoCotizante.jsp">Tipo Cotizante</a>
                                        </li></span>
                                    <span class="file">  <li>
                                            <a href="<%= TablasBasicas%>TipoPoliza.jsp">Tipo P&oacute;liza</a>
                                        </li></span>
                                    <span class="file">   <li>
                                            <a href="<%= TablasBasicas%>TipoNovedad.jsp">Tipo Novedad</a>
                                        </li></span>
                                    <span class="file">   <li>
                                            <a href="<%= formularios%>Empresas.jsp">Empresa</a>
                                        </li></span>                                        
                                    <span class="file">   <li>
                                            <a href="<%= formularios%>EntidadSalud.jsp">Entidad Salud</a>
                                        </li></span>
                                    <span class="file">   <li>
                                            <a href="<%= TablasBasicas%>TipoArchivo.jsp">Tipo archivo</a>
                                        </li></span>
                                </ul>

                            </li>

                            <li><span class="folder">Archivos</span>
                                <ul>
                                    <span class="file"> <li>
                                            <a href="<%= TablasBasicas%>ClaseOperArch.jsp">Clase Operaci&oacute;n</a>
                                        </li></span>
                                    <span class="file"> <li>
                                            <a href="<%= TablasBasicas%>SiglaArchBdua.jsp">Sigla Archivo BDUA</a>
                                        </li></span>
                                    <span class="file"> <li>
                                            <a href="<%= TablasBasicas%>TipoIncArchivo.jsp">Tipo Inconsistencia</a>
                                        </li></span>
                                    <span class="file">  <li>
                                            <a href="<%= TablasBasicas%>TipoArchivo.jsp">Tipo Archivo Afiliaci&oacute;n</a>
                                        </li></span>
                                    <span class="file">  <li>
                                            <a href="<%= TablasBasicas%>TipoEscructArch.jsp">Tipo Estructura</a>
                                        </li></span>
                                </ul>

                            </li>
                            <li><span class="folder">Glosas</span>
                                <ul>
                                    <span class="file">  <li>
                                            <a href="<%= TablasBasicas%>ClaseGlosaAfil.jsp">Clase Glosa</a>
                                        </li></span>
                                    <span class="file">  <li>
                                            <a href="<%= TablasBasicas%>IndiceGlosaArchAfil.jsp">&Iacute;ndice Glosa</a>
                                        </li></span>
                                    <span class="file">  <li>
                                            <a href="<%= TablasBasicas%>TipoGlosaArchAfil.jsp">Tipo Glosa</a>
                                        </li></span>
                                    <span class="file"> <li>
                                            <a href="<%= TablasBasicas%>TipoGlosaTrasl.jsp">Tipo Glosa Translado</a>
                                        </li></span>
                                </ul>

                            </li>
                        </ul>

                    </li>






                </ul>

            </li>

            <li><span class="folder">Comprobador derechos</span>
                <ul>
                    <span class="file"><li>
                            <a href="<%= SistemaSalud%>ComprobarDerechos.jsp">Comprobar Derechos</a>
                        </li></span>
                    <span class="file"> <li>
                            <a href="<%= SistemaSalud%>HistoricoConsultas.jsp">Hist&oacute;rico Consultas</a>
                        </li></span>
                    <span class="file"> <li>
                            <a href="#">Consultas BDUA</a>
                        </li></span>
                    <span class="file"> <li>
                            <a href="#">Consultas SIRI</a>
                        </li></span>
                </ul>

            </li>

            <li><span class="folder">Atenci&oacute;n al usuario</span>
                <ul>
                    <li><span class="folder">Encuentros y Reuniones</span>
                        <ul>
                            <span class="file"> <li>
                                    <a href="<%= comunFS%>EncuentrosOReuniones.jsp">Reuniones</a>
                                </li></span>
                            <span class="file"> <li>
                                    <a href="<%= comunFS%>AsistenciaReuniones.jsp">Asistencia</a>
                                </li></span>
                            <span class="file"> <li>
                                    <a href="<%= comunFS%>ActividadesRealizadas.jsp">Actividades</a>
                                </li></span>
                            <span class="file"><li>
                                    <a href="<%= comunFS%>AsistentesReuniones.jsp">Asistentes Externos</a>
                                </li></span>
                        </ul>

                    </li>
                </ul>
                <ul>
                    <li><span class="folder">Reclamos</span>
                        <ul>
                            <span class="file">  <li>
                                    <a href="<%= SistemaSalud%>SaludReclamo.jsp">Registro Reclamo</a>
                                </li></span>
                            <span class="file"> <li>
                                    <a href="<%= FamiliasEnAccion%>DocumentosReclamos.jsp">Documentos Reclamo</a>
                                </li></span>
                            <span class="file"><li>
                                    <a href="<%= FamiliasEnAccion%>AfectadosReclamo.jsp">Afectados Reclamo</a>
                                </li></span>
                            <span class="file"> <li>
                                    <a href="<%= SistemaSalud%>SaludReclamoRespuesta.jsp">Respuesta Reclamo</a>
                                </li></span>
                        </ul>

                    </li>
                </ul>


                <ul>
                    <li><span class="folder">Quejas</span>
                        <ul>
                            <span class="file">  <li>
                                    <a href="<%= SistemaSalud%>SaludQueja.jsp">Registro de Quejas</a>
                                </li></span>
                            <span class="file">   <li>
                                    <a href="<%= FamiliasEnAccion%>DocumentoQuejas.jsp">Documentos</a>
                                </li></span>
                            <span class="file">   <li>
                                    <a href="<%= FamiliasEnAccion%>AfectadosQuejas.jsp">Afectados por Queja</a>
                                </li></span>
                            <span class="file">   <li>
                                    <a href="<%= SistemaSalud%>SaludQuejaRespuesta.jsp">Respuesta a Quejas</a>
                                </li></span>
                        </ul>

                    </li>
                </ul>
                <ul>
                    <li><span class="folder">Configuraci&oacute;n B&aacute;sica</span>
                        <ul>
                            <span class="file">  <li>
                                    <a href="<%= TablasBasicas%>TipoActividad.jsp">Tipo Actividad</a>
                                </li></span>
                            <span class="file">  <li>
                                    <a href="<%= TablasBasicas%>ReclamoClasificacion.jsp">Clasificaci&oacute;n Reclamo</a>
                                </li></span>
                            <span class="file">  <li>
                                    <a href="<%= TablasBasicas%>ReclamoTipo.jsp">Tipo Reclamo</a>
                                </li></span>
                            <span class="file">   <li>
                                    <a href="<%= TablasBasicas%>RespuestaClasificacion.jsp">Clasifica Respuesta</a>
                                </li></span>
                            <span class="file">  <li>
                                    <a href="<%= TablasBasicas%>SatisfaccionTipo.jsp">Tipo Satisfacci&oacute;n</a>
                                </li></span>
                            <span class="file">   <li>
                                    <a href="<%= TablasBasicas%>QuejaClasificacion.jsp">Clasificaci&oacute;n Queja</a>
                                </li></span>
                            <span class="file">  <li>
                                    <a href="<%= TablasBasicas%>TipoQueja.jsp">Tipo Queja</a>
                                </li></span>
                        </ul>

                    </li>
                </ul>




            </li>
            <li><span class="folder">Prestaci&oacute;n servicios salud</span>
                <ul>
                    <span class="file"><li>
                            <a href="<%= SistemaSalud%>AutorizacionSecretaria.jsp">Autorizaciones Secretaria de <br />&nbsp;&nbsp;&nbsp;&nbsp;Salud</a>
                        </li></span>
                    <span class="file"> <li>
                            <a href="<%= SistemaSalud%>UsuariosAtendidosIPS.jsp">Usuarios Atendidos en IPS</a>
                        </li></span>
                    <span class="file"> <li>
                            <a href="<%= SistemaSalud%>RecepcionArchivoRIPS.jsp">Recepci&oacute;n Archivos RIPS</a>
                        </li></span>
                </ul>
                <ul>
                    <li><span class="folder">RIPS Peri&oacute;dicos</span>
                        <ul>
                            <span class="file"><li>
                                    <a href="<%= SistemaSalud%>AutorizacionSecretaria.jsp">Autorizaciones Secretaria de <br />&nbsp;&nbsp;&nbsp;&nbsp;Salud</a>
                                </li></span>
                            <span class="file"> <li>
                                    <a href="<%= SistemaSalud%>UsuariosAtendidosIPS.jsp">Usuarios Atendidos en IPS</a>
                                </li></span>
                            <span class="file"> <li>
                                    <a href="<%= SistemaSalud%>RecepcionArchivoRIPS.jsp">Recepci&oacute;n Archivos RIPS</a>
                                </li></span>
                            <li><span class="folder">RIPS EAPB</span>
                                <ul>

                                    <span class="file">  <li>
                                            <a href="<%= SistemaSalud%>ArchivoControlEAPB.jsp">Archivo de Control</a>
                                        </li></span>
                                    <span class="file">  <li>
                                            <a href="#">Archivo Descripci&oacute;n</a>
                                        </li></span>
                                    <span class="file"> <li>
                                            <a href="#">Archivo Valores Totales</a>
                                        </li></span>
                                    <span class="file">   <li>
                                            <a href="#">RIPS Peri&oacute;dicos</a>
                                        </li></span>

                                </ul>


                            </li>
                            <li><span class="folder">RIPS IPS</span>
                                <ul>
                                    <span class="file">   <li>
                                            <a href="<%= SistemaSalud%>ArchivoControlIPS.jsp">Archivo de Control</a>
                                        </li></span>
                                    <span class="file">   <li>
                                            <a href="<%= SistemaSalud%>ArchivoDescripcionIPS.jsp">Archivo Descripci&oacute;n</a>
                                        </li></span>
                                    <span class="file">    <li>
                                            <a href="#">RIPS Peri&oacute;dicos</a>
                                        </li></span>

                                </ul>


                            </li>




                        </ul>


                    </li>

                    <li><span class="folder">Detalle Archivo RIPS</span>
                        <ul>
                            <span class="file">   <li>
                                    <a href="<%= SistemaSalud%>">Estructura de Archivos</a>
                                </li></span>
                            <span class="file">  <li>
                                    <a href="<%= SistemaSalud%>DetalleInconsistenciaRIPS.jsp">Detalle Inconsistencia RIPS</a>
                                </li></span>
                            <span class="file">   <li>
                                    <a href="<%= SistemaSalud%>NovedadRIPSDato.jsp">Novedades RIPS por Dato</a>
                                </li></span>
                        </ul>


                    </li>


                    <li><span class="folder">Generaci&oacute;n Archivos</span>
                        <ul>
                            <span class="file">  <li>
                                    <a href="#">RIPS EAPB</a>
                                </li></span>
                            <span class="file">  <li>
                                    <a href="#">RIPS IPS</a>
                                </li></span>


                        </ul>


                    </li>


                    <li><span class="folder">BI - Gesti&oacute;n Informaci&oacute;n</span>
                        <ul>
                            <span class="file"> <li>
                                    <a href="#">Producci&oacute;n</a>
                                </li></span>
                            <span class="file">    <li>
                                    <a href="#">Morbilidad</a>
                                </li></span>
                            <span class="file">   <li>
                                    <a href="#">Facturaci&oacute;n</a>
                                </li></span>
                            <span class="file">  <li>
                                    <a href="#">Inteligencia de Negocios</a>
                                </li></span>


                        </ul>


                    </li>

                </ul>

            </li>

              <li><span class="folder">Seguridad</span>
                <ul>
                    <span class="file"> <li>
                            <a href="<%= formularios%>Usuarios.jsp?#tabs-1">Usuario</a>
                        </li></span>
                    <span class="file">  <li>
                            <a href="<%= formularios%>Usuarios.jsp?#tabs-2">Grupos</a>
                        </li></span>
                    <span class="file">  <li>
                            <a href="<%= formularios%>Usuarios.jsp?#tabs-3">Paginas</a>
                        </li></span>
                    <span class="file"> <li>
                            <a href="<%= formularios%>Usuarios.jsp?#tabs-4">Perfiles</a>
                        </li></span>
                    <span class="file"> <li>
                            <a href="<%= formularios%>Usuarios.jsp?#tabs-5">Estados</a>
                        </li></span>
                    <span class="file"> <li>
                            <a href="<%= formularios%>Usuarios.jsp?#tabs-6">Permisos</a>
                        </li></span>
                    
                    
                    <!--        <span class="file">      <li>
                                      <a href="#">Copias Seguridad</a>
                                  </li></span>
                            <span class="file">      <li>
                                      <a href="#">Restaurar Copia</a>
                                  </li> </span>-->
                </ul>
            </li>

        </ul>

    </li>





</ul>