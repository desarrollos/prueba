
<%
            String comunFS = "../ComunFS/";
            String FamiliasEnAccion = "../ComunFS/";
            String TablasBasicas = "../ComunFS/";
            String reportes = "../ComunFS/";
            String formularios = "../formularios/";
%>

<ul id="salud" class="filetree" style="font-size:12px;">
    <li><span class="folder">FAMILIAS EN ACCI&Oacute;N</span>
        <ul>
            <li><span class="folder">Vinculaci&oacute;n</span>
                <ul>
                    <li><span class="folder">Inscripci&oacute;n</span>
                        <ul>
                            <span class="file">     <li>
                                    <a href="<%= FamiliasEnAccion%>Vinculacion1.jsp">Registro</a>
                                </li></span>
                            <span class="file">      <li>
                                    <a href="<%= FamiliasEnAccion%>DocumentosInscripcion.jsp">Documentos</a>
                                </li></span>
                            <span class="file">      <li>
                                    <a href="<%= FamiliasEnAccion%>GrupoTitular.jsp">Grupos Titulares</a>
                                </li></span>
                            <span class="file">      <li>
                                    <a href="<%= FamiliasEnAccion%>TitularFamilia.jsp">Titular Familia</a>
                                </li></span>
                            <span class="file">      <li>
                                    <a href="<%= FamiliasEnAccion%>Beneficiario.jsp">Beneficiarios</a>
                                </li></span>
                        </ul>
                    </li>
                    <li><span class="folder">Novedad</span>
                        <ul>
                            <span class="file">    <li>
                                    <a href="<%= FamiliasEnAccion%>RegistroNovedad.jsp">Registro</a>
                                </li></span>
                            <span class="file">    <li>
                                    <a href="<%= FamiliasEnAccion%>NovedadPorCampo.jsp">Novedad por Campo</a>
                                </li></span>
                            <span class="file">    <li>
                                    <a href="<%= FamiliasEnAccion%>DocumentosNovedad.jsp">Documentos</a>
                                </li></span>
                        </ul>
                    </li>
                    <li><span class="folder">Poblaci&oacute;n</span>
                        <ul>
                            <span class="file"> <li>
                                    <a href="<%= comunFS%>">Poblaci&oacute;n</a>
                                </li></span>
                            <span class="file">  <li>
                                    <a href="<%= comunFS%>">Consultas</a>
                                </li></span>
                        </ul>
                    </li>
                    <li><span class="folder">Configuraci&oacute;n B&aacute;sica</span>
                        <ul>
                            <span class="file">  <li>
                                    <a href="<%= formularios%>TipoPoblacion.jsp">Tipo Poblaci&oacute;n</a>
                                </li></span>
                            <span class="file">  <li>
                                    <a href="<%= formularios%>EstadoFamilia.jsp">Estado Familia</a>
                                </li></span>
                            <span class="file">  <li>
                                    <a href="<%= formularios%>TipoTitular.jsp">Tipo Titular</a>
                                </li></span>
                            <span class="file">  <li>
                                    <a href="<%= formularios%>EstadoTitular.jsp">Estado Titular</a>
                                </li></span>
                            <span class="file">  <li>
                                    <a href="<%= formularios%>ClaseGrupoTitular.jsp">Clase Grupo Titular</a>
                                </li></span>
                            <span class="file">  <li>
                                    <a href="<%= formularios%>NovedadCausal.jsp">Causal Novedad</a>
                                </li></span>
                            <span class="file">  <li>
                                    <a href="<%= formularios%>DocumentoCausal.jsp">Causal Documentos</a>
                                </li></span>
                        </ul>
                    </li>


                </ul>
            </li>
        </ul>
        <ul>
            <li><span class="folder">ATENCI&Oacute;N AL USUARIO</span>
                <ul>
                    <li><span class="folder">Encuentros y Reuniones</span>
                        <ul>
                            <li>
                                <span class="file"> <a href="<%=formularios%>EncuentrosOReuniones.jsp?#tabs-1">Reuniones</a></span>
                            </li>
                            <li>
                                <span class="file"> <a href="<%=formularios%>EncuentrosOReuniones.jsp?#tabs-2">Asistencia</a></span>
                            </li>
                            <li>
                                <span class="file">  <a href="<%=formularios%>EncuentrosOReuniones.jsp?#tabs-3">Actividades</a></span>
                            </li>
                            <li>
                                <span class="file"> <a href="<%=formularios%>EncuentrosOReuniones.jsp?#tabs-4">Asistentes</a></span>
                            </li>
                        </ul>
                    </li>
                    <li><span class="folder">Reclamos</span>
                        <ul>
                            <span class="file"> <li>
                                    <a href="<%=formularios%>Reclamos.jsp?#tabs-1">Registro</a>
                                </li></span>
                            <span class="file">  <li>
                                    <a href="<%=formularios%>Reclamos.jsp?#tabs-2">Documentos</a>
                                </li></span>
                            <span class="file">  <li>
                                    <a href="<%=formularios%>Reclamos.jsp?#tabs-3">Afectados</a>
                                </li></span>
                            <span class="file">  <li>
                                    <a href="<%=formularios%>Reclamos.jsp?#tabs-4">Respuestas</a>
                                </li></span>
                        </ul>
                    </li>
                    <li><span class="folder">Quejas</span>
                        <ul>
                            <span class="file">   <li>
                                    <a href="<%=formularios%>Quejas.jsp?#tabs-1">Registro</a>
                                </li></span>
                            <span class="file"> <li>
                                    <a href="<%=formularios%>Quejas.jsp?#tabs-2">Documentos</a>
                                </li></span>
                            <span class="file">  <li>
                                    <a href="<%=formularios%>Quejas.jsp?#tabs-3">Afectados</a>
                                </li></span>
                            <span class="file"><li>
                                    <a href="<%=formularios%>Quejas.jsp?#tabs-4">Respuestas</a>
                                </li></span>
                        </ul>
                    </li>
                    <li><span class="folder">Configuraci&oacute;n B&aacute;sica</span>
                        <ul>
                            <span class="file">
                                <li>
                                    <a href="<%=formularios%>TipoActividad.jsp">Tipo actividad</a>

                                </li>
                            </span>
                            <span class="file">
                                <li>
                                    <a href="<%=formularios%>ReclamoClasificacion.jsp">Clasificaci&oacute;n Reclamo</a>
                                </li>
                            </span>
                            <span class="file">
                                <li>
                                    <a href="<%=formularios%>TipoReclamo.jsp">Tipo Reclamo</a>
                                </li></span>
                            <span class="file">
                                <li>
                                    <a href="<%=formularios%>RespuestaClasificacion.jsp">Clasifica Respuesta</a>
                                </li>
                            </span>
                            <span class="file">
                                <li>
                                    <a href="<%=formularios%>TipoSatisfaccion.jsp">Tipo Satisfacci&oacute;n</a>
                                </li>
                            </span>

                            <span class="file"> <li>
                                    <a href="<%=formularios%>QuejaClasificacion.jsp">Clasificacion Queja</a>
                                </li></span>
                            <span class="file"> <li>
                                    <a href="<%=formularios%>TipoQueja.jsp">Tipo Queja</a>
                                </li></span>


                        </ul>
                    </li>




                </ul>
            </li>



        </ul>
        <ul>
            <li><span class="folder">Educaci&oacute;n</span>
                <ul>
                    <span class="file">     <li>
                            <a href="<%= FamiliasEnAccion%>Escolaridad.jsp">Escolaridad</a>
                        </li></span>
                    <span class="file">      <li>
                            <a href="<%= FamiliasEnAccion%>NovedadEscolaridad.jsp">Novedad Escolaridad</a>
                        </li></span>
                    <span class="file">     <li>
                            <a href="<%= FamiliasEnAccion%>RegistroPeriodicoEscolaridad.jsp">Registro periodico</a>
                        </li></span>
                    <span class="file">     <li>
                            <a href="<%= FamiliasEnAccion%>CumplimientoEscolaridad.jsp">Cumple Escolaridad</a>
                        </li></span>
                        <li><span class="folder">Configuraci&oacute;n B&aacute;sica</span>
                        <ul>
                            <span class="file"><li>
                                    <a href="<%= TablasBasicas%>EscolaridadEstado.jsp">Estado Escolaridad</a>
                                </li></span>
                            <span class="file"><li>
                                    <a href="<%= TablasBasicas%>FirmasAutorizadas.jsp">Firmas Autorizadas</a>
                                </li></span>
                        </ul>
                    </li>

                </ul>
            </li>
            <li><span class="folder">Salud</span>
                <ul>
                    <span class="file"> <li>
                            <a href="<%= FamiliasEnAccion%>InscripcionIPS.jsp">Inscripci&oacute;n IPS</a>
                        </li></span>
                    <span class="file"> <li>
                            <a href="#">Novedad Entidad Salud</a>
                        </li></span>
                    <span class="file">  <li>
                            <a href="<%= FamiliasEnAccion%>AtencionesEnSalud.jsp">Atenciones en Salud</a>
                        </li></span>
                    <span class="file">  <li>
                            <a href="<%= FamiliasEnAccion%>RegistroControles.jsp">Registro Contoles</a>
                        </li></span>
                    <span class="file"> <li>
                            <a href="<%= FamiliasEnAccion%>SaludCumplimiento.jsp">Cumplimiento Salud</a>
                        </li></span>
                    <li><span class="folder">Configuraci&oacute;n B&aacute;sica</span>
                        <ul>
                            <span class="file">     <li>
                                    <a href="<%= TablasBasicas%>ActividadSalud.jsp">Actividad Salud</a>
                                </li></span>
                            <span class="file">   <li>
                                    <a href="<%= TablasBasicas%>Diagnostico.jsp">Diagn&oacute;sticos</a>
                                </li></span>
                            <span class="file">  <li>
                                    <a href="<%= TablasBasicas%>EstadoIncripIps.jsp">Estado Inscripto IPS</a>
                                </li></span>
                            <span class="file">   <li>
                                    <a href="<%= TablasBasicas%>FinalidadConsulta.jsp">Finalidad Consulta</a>
                                </li></span>
                            <span class="file">  <li>
                                    <a href="<%= TablasBasicas%>FirmasAutorizadas.jsp">Firma Autorizada</a>
                                </li></span>
                            <span class="file">  <li>
                                    <a href="#">RIPS Periodicos</a>
                                </li></span>
                        </ul>
                    </li>

                </ul>
            </li>
            <li><span class="folder">Nutricci&oacute;n</span>
                <ul>
                    <span class="file">  <li>
                            <a href="<%= FamiliasEnAccion%>ValoracionNutricional.jsp">Valoraci&oacute;n Nutricional</a>
                        </li></span>
                    <span class="file">  <li>
                            <a href="<%= FamiliasEnAccion%>ActividadesNutricionales.jsp">Actividad Nutricional</a>
                        </li></span>
                </ul>
            </li>
            <li><span class="folder">Violencia intrafamiliar</span>
                <ul>
                    <span class="file"> <li>
                            <a href="<%= FamiliasEnAccion%>RegistroAccionViolencia.jsp">Registro Violencia</a>
                        </li></span>
                    <li><span class="folder">Configuraci&oacute;n B&aacute;sica</span>
                        <ul>
                            <span class="file">   <li>
                                    <a href="<%= TablasBasicas%>TipoViolencia.jsp">Tipo Violencia</a>
                                </li></span>
                        </ul>
                    </li>


                </ul>
            </li>

            <li><span class="folder">Estimulaci&oacute;n temprana</span>
                <ul>
                    <span class="file"> <li>
                            <a href="<%= FamiliasEnAccion%>RegistroEstimulacionTemprana.jsp">Registro</a>
                        </li></span>
                    <li><span class="folder">Configuraci&oacute;n B&aacute;sica</span>
                        <ul>
                            <span class="file"> <li>
                                    <a href="<%= TablasBasicas%>TipoEstimulacion.jsp">Tipo Estimulaci&oacute;n</a>
                                </li></span>
                        </ul>
                    </li>
                </ul>
            </li>



            <li><span class="folder">Subsidios</span>
                <ul>
                    <span class="file"> <li>
                            <a href="<%= FamiliasEnAccion%>Subsidios.jsp">Subsidios</a>
                        </li></span>
                    <span class="file">   <li>
                            <a href="<%= FamiliasEnAccion%>SubsidiosMunicipio.jsp">Subsidios Municipio</a>
                        </li></span>
                    <span class="file">  <li>
                            <a href="<%= FamiliasEnAccion%>SubsidioPotencial.jsp">Subsidio Potencial</a>
                        </li></span>
                    <span class="file">  <li>
                            <a href="<%= FamiliasEnAccion%>SubsidioAsignado.jsp">Subsidio Asignado</a>
                        </li></span>
                    <li><span class="folder">Configuraci&oacute;n B&aacute;sica</span>
                        <ul>
                            <span class="file">   <li>
                                    <a href="<%= TablasBasicas%>SubsidioCategoria.jsp">Categor&iacute;a Subsidio</a>
                                </li></span>
                            <span class="file">  <li>
                                    <a href="<%= TablasBasicas%>TipoSubsidio.jsp">Tipo Subsidio</a>
                                </li></span>
                            <span class="file">   <li>
                                    <a href="<%= TablasBasicas%>TipoEducacion.jsp">Tipo Educaci&oacute;n</a>
                                </li></span>
                            <span class="file">  <li>
                                    <a href="<%= TablasBasicas%>EscolaridadGrado.jsp">Grado Escolaridad</a>
                                </li></span>
                            <span class="file">  <li>
                                    <a href="<%= TablasBasicas%>EscGrupoGrado.jsp">Grupo Grado Escolar</a>
                                </li></span>
                        </ul>
                    </li>
                </ul>
            </li>



            <li><span class="folder">BI(Gesti&oacute;n Informaci&oacute;n)</span>
                <ul>
                    <span class="file">  <li>
                            <a href="<%= reportes%>reportePoblacion.jsp">Reporte Poblacion</a>
                        </li></span>
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


            <li><span class="folder">Configuraci&oacute;n general</span>
                <ul>
                    <li><span class="folder">Marco General</span>
                        <ul>
                            <span class="file">     <li>
                                    <a href="#">Empresa Sistema</a>
                                </li> </span>
                            <span class="file">      <li>
                                    <a href="#">Cupos Asignados</a>
                                </li> </span>
                            <span class="file">    <li>
                                    <a href="#">Requisitos Familias</a>
                                </li> </span>
                            <span class="file">     <li>
                                    <a href="#">Estrategias</a>
                                </li> </span>
                            <span class="file">   <li>
                                    <a href="#">Plan Acci&oacute;n</a>
                                </li> </span>
                        </ul>
                    </li>
                    <li><span class="folder">Configuraci&oacute;n b&aacute;sica</span>
                        <ul>
                            <span class="file"> <li>
                                    <a href="#">&Aacute;rea Geogr&aacute;fica</a>
                                </li></span>
                            <span class="file">  <li>
                                    <a href="#">B&aacute;sicas</a>
                                </li></span>
                            <span class="file">  <li>
                                    <a href="#">Entidades</a>
                                </li></span>
                            <span class="file"> <li>
                                    <a href="#">Planes</a>
                                </li></span>
                        </ul>
                    </li>

                </ul>
            </li>


        </ul>
    </li>

</ul>


