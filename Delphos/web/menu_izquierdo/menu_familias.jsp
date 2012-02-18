
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
            <li><span class="folder">Inscripci&oacute;n</span>
                <ul>
                    <li><span class="file"><a href="<%= formularios%>Vinculacion.jsp?#tabs-1">Inscripci&oacute;n</a></span>
                        
                    </li>
                    <li><span class="folder">Novedad</span>
                        <ul>
                            <span class="file">    <li>
                                    <a href="<%= formularios%>Novedad.jsp?#tabs-1">Registro</a>
                                </li></span>
                            <span class="file">    <li>
                                    <a href="<%= formularios%>Novedad.jsp?#tabs-2">Novedad por Campo</a>
                                </li></span>
                            <span class="file">    <li>
                                    <a href="<%= formularios%>Novedad.jsp?#tabs-3">Documentos</a>
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
                            <a href="<%= formularios%>Educacion.jsp?#tabs-1">Escolaridad</a>
                        </li></span>
                    <span class="file">      <li>
                            <a href="<%= formularios%>Educacion.jsp?#tabs-2">Novedad Escolaridad</a>
                        </li></span>
                    <span class="file">     <li>
                            <a href="<%= formularios%>Educacion.jsp?#tabs-3">Registro periodico</a>
                        </li></span>
                    <span class="file">     <li>
                            <a href="<%= formularios%>Educacion.jsp?#tabs-4">Cumple Escolaridad</a>
                        </li></span>
                    <li><span class="folder">Configuraci&oacute;n B&aacute;sica</span>
                        <ul>
                            <span class="file"><li>
                                    <a href="<%= formularios%>EstadoEscolaridad.jsp">Estado Escolaridad</a>
                                </li></span>
                            <span class="file"><li>
                                    <a href="<%= formularios%>FirmasAutorizadas.jsp">Firmas Autorizadas</a>
                                </li></span>
                        </ul>
                    </li>

                </ul>
            </li>
            <li><span class="folder">Salud</span>
                <ul>
                    <span class="file"> <li>
                            <a href="<%= formularios%>Salud.jsp?#tabs-1">Inscripci&oacute;n IPS</a>
                        </li></span>
                    <span class="file">  <li>
                            <a href="<%= formularios%>Salud.jsp?#tabs-3">Atenciones en Salud</a>
                        </li></span>
                    <span class="file">  <li>
                            <a href="<%= formularios%>Salud.jsp?#tabs-4">Registro Controles</a>
                        </li></span>
                    <span class="file">  <li>
                            <a href="#">RIPS Periodicos</a>
                        </li></span>
                    <span class="file"> <li>
                            <a href="<%= formularios%>Salud.jsp?#tabs-5">Cumplimiento Salud</a>
                        </li></span>
                    <li><span class="folder">Configuraci&oacute;n B&aacute;sica</span>
                        <ul>
                            <span class="file">     <li>
                                    <a href="<%= formularios%>ActividadSalud.jsp">Actividad Salud</a>
                                </li></span>
                            <span class="file">   <li>
                                    <a href="<%= formularios%>Diagnostico.jsp">Diagn&oacute;sticos</a>
                                </li></span>
                            <span class="file">  <li>
                                    <a href="<%= formularios%>EstadoIncripIps.jsp">Estado Inscripto IPS</a>
                                </li></span>
                            <span class="file">   <li>
                                    <a href="<%= formularios%>FinalidadConsulta.jsp">Finalidad Consulta</a>
                                </li></span>

                        </ul>
                    </li>

                </ul>
            </li>
            <li><span class="folder">Nutricci&oacute;n</span>
                <ul>
                    <span class="file">  <li>
                            <a href="<%= formularios%>ValoracionNutricional.jsp">Valoraci&oacute;n Nutricional</a>
                        </li></span>
                    <span class="file">  <li>
                            <a href="<%= formularios%>ActividadesNutricionales.jsp">Actividad Nutricional</a>
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
                                    <a href="<%= formularios%>TipoViolencia.jsp">Tipo Violencia</a>
                                </li></span>
                        </ul>
                    </li>


                </ul>
            </li>

            <li><span class="folder">Estimulaci&oacute;n temprana</span>
                <ul>
                    <span class="file"> <li>
                            <a href="<%= formularios%>RegistroEstimulacionTemprana.jsp">Registro</a>
                        </li></span>
                    <li><span class="folder">Configuraci&oacute;n B&aacute;sica</span>
                        <ul>
                            <span class="file"> <li>
                                    <a href="<%= formularios%>TipoEstimulacion.jsp">Tipo Estimulaci&oacute;n</a>
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
                                    <a href="<%= formularios%>SubsidioCategoria.jsp">Categor&iacute;a Subsidio</a>
                                </li></span>
                            <span class="file">  <li>
                                    <a href="<%= formularios%>TipoSubsidio.jsp">Tipo Subsidio</a>
                                </li></span>
                            <span class="file">   <li>
                                    <a href="<%= formularios%>TipoEducacion.jsp">Tipo Educaci&oacute;n</a>
                                </li></span>
                            <span class="file">  <li>
                                    <a href="<%= formularios%>EscolaridadGrado.jsp">Grado Escolaridad</a>
                                </li></span>
                            <span class="file">  <li>
                                    <a href="<%= formularios%>EscGrupoGrado.jsp">Grupo Grado Escolar</a>
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
                            <span class="file">   <li>
                                    <a href="<%= formularios%>Empresas.jsp">Empresa</a>
                                </li></span>
                            <span class="file">   <li>
                                    <a href="<%= formularios%>EntidadSalud.jsp">Entidad Salud</a>
                                </li></span>
                            <span class="file">      <li>
                                    <a href="#">Cupos Asignados</a>
                                </li> </span>
                            <span class="file">    <li>
                                    <a href="<%= formularios%>RequisitosFamilias.jsp">Requisitos Familias</a>
                                </li> </span>
                            <span class="file">     <li>
                                    <a href="<%= formularios%>ImagenCorporativa.jsp">Imagen Corporativa</a>
                                </li> </span>
                        </ul>
                    </li>
                    <li><span class="folder">Configuraci&oacute;n b&aacute;sica</span>
                        <ul>
                            <span class="file"> <li>
                                    <a href="#">&Aacute;rea Geogr&aacute;fica</a>
                                </li></span>
                            <span class="file"> <li>
                                    <a href="<%= formularios%>Regimen.jsp">Reg&iacute;menes</a>
                                </li></span>
                        </ul>
                    </li>

                </ul>
            </li>


        </ul>
    </li>

</ul>


