 <table border="0" align="center" width="600">
                                        <tbody>
                                            <tr>
                                                <td colspan="2" align="center" class="titulo1">Encabezado Archivo</td>
                                            </tr>
                                            <%--<tr>
                                                <td align="left" class="bgDescTablas">Id Encabezado</td>
                                                <td><input type="text" name="idencabezado" size="35" readonly></td>
                                            </tr>--%>
                                            <tr>
                                                <td align="left" class="bgDescTablas">Codigo Regimen</td>
                                                <td>
                                                    <select name="codregimen" id="codregimen">
                                                        <option value="">---------- Seleccione Regimen ----------</option>
                                                        <sql:query var="r" sql="SELECT * FROM regimen" dataSource="jdbc/delphos" scope="page"/>
                                                        <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                                                            <option value="${fila.codregimen}">${fila.descripcion}</option>
                                                        </jsp2:forEach>
                                                    </select>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="left" class="bgDescTablas">Codigo Entidad Salud</td>
                                                <td>
                                                    <select name="codentidadsalud" id="codentidadsalud">
                                                        <option value="">---------- Seleccione Entidad ----------</option>
                                                        <sql:query var="r" sql="SELECT * FROM entidadsalud" dataSource="jdbc/delphos" scope="page"/>
                                                        <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                                                            <option value="${fila.codentidadsalud}">${fila.nombrehabilitacion}</option>
                                                        </jsp2:forEach>
                                                    </select>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="left" class="bgDescTablas">Fecha Inicial</td>
                                                <td><input type="text" name="fechainicial" id="fechainicial" size="35" readonly><input type="button" name="btfechainicial" id="btfechainicial" value="..."></td>
                                            </tr>
                                            <tr>
                                                <td align="left" class="bgDescTablas">Fecha Final</td>
                                                <td><input type="text" name="fechafinal" id="fechafinal" size="35" readonly><input type="button" name="btfechafinal" id="btfechafinal" value="..."></td>
                                            </tr>
                                            <tr>
                                                <td align="left" class="bgDescTablas">Codigo Archivo</td>
                                                <td><input type="text" name="codarchivo" id="codarchivo" value="prueba"></td>
                                            </tr>
                                            <tr>
                                                <td align="left" class="bgDescTablas">Departamento</td>
                                                <td>
                                                    <select name="coddepartamento" id="coddepartamento" onChange="cargarMunicipios();">
                                                        <option value="">---------- Seleccione Departamento  ----------</option>
                                                        <sql:query var="r" sql="SELECT * FROM departamento" dataSource="jdbc/delphos" scope="page"/>
                                                        <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                                                            <option value="${fila.coddepartamento}">${fila.nombre}</option>
                                                        </jsp2:forEach>
                                                    </select>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="left" class="bgDescTablas">Municipio</td>
                                                <td>
                                                    <span id="spanMunicipio">
                                                        <select name="codmunicipio" id="codmunicipio" disabled>
                                                            <option>-- Seleccione el municipio --</option>
                                                        </select>
                                                    </span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="left" class="bgDescTablas">Nombre Archivo</td>
                                                <td><input type="text" name="nombrearchivo" id="nombrearchivo" size="35" value="prueba"></td>
                                            </tr>
                                            <tr>
                                                <td align="left" class="bgDescTablas">Codigo Tipo Archivo</td>
                                                <td>
                                                    <select name="codarchivo" id="codarchivo">
                                                        <option value="">---------- Seleccione Tipo Archivo ----------</option>
                                                        <sql:query var="r" sql="SELECT * FROM tipoarchivo" dataSource="jdbc/delphos" scope="page"/>
                                                        <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                                                            <option value="${fila.codtipoarchivo}">${fila.descripcion}</option>
                                                        </jsp2:forEach>
                                                    </select>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="left" class="bgDescTablas">Nombre Envia</td>
                                                <td><input type="text" name="nombreenvia" id="nombreenvia" size="35" value="prueba"></td>
                                            </tr>
                                            <tr>
                                                <td align="left" class="bgDescTablas">Telefono Envia</td>
                                                <td><input type="text" name="telefonoenvia" id="telefonoenvia" size="35" value="5555"></td>
                                            </tr>
                                            <tr>
                                                <td align="left" class="bgDescTablas">Email Envia</td>
                                                <td><input type="text" name="emailenvia" id="emailenvia" size="35" value="prueba"></td>
                                            </tr>
                                            <tr>
                                                <td align="left" class="bgDescTablas">Fecha Envio</td>
                                                <td><input type="text" name="fechaenvio" id="fechaenvio" size="35" readonly><input type="button" name="btfechaenvio" id="btfechaenvio" value="..."></td>
                                            </tr>
                                            <tr>
                                                <td align="left" class="bgDescTablas">Fecha Recibo</td>
                                                <td><input type="text" name="fecharecibo" id="fecharecibo" size="35" readonly><input type="button" name="btfecharecibo" id="btfecharecibo" value="..."></td>
                                            </tr>
                                            <tr>
                                                <td align="left" class="bgDescTablas">Registros</td>
                                                <td><input type="text" name="registros" id="registros" size="35" value="5"></td>
                                            </tr>
                                            <tr>
                                                <td align="left" class="bgDescTablas">Copia Documento Remisorio</td>
                                                <td><input type="text" name="copiadctoremis" id="copiadctoremis" size="35" value="2332"></td>
                                            </tr>
                                            <tr>
                                                <td align="left" class="bgDescTablas">Proceso</td>
                                                <td>
                                                    <select name="proceso" id="proceso">
                                                        <option value="I">Inserter Registros Primer Vez</option>
                                                        <option value="A">Aactualizar los existentes = Borrar e Insertar</option>
                                                    </select>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" class="bgDescTablas">
                                                    <label>Poblacion <input type="radio" name="tipoCarga" value="CargarPoblacion" onclick="seleccionarTipoRip('')"></label>
                                                    <label>Rips IPS<input type="radio" name="tipoCarga" value="CargarRips" onclick="seleccionarTipoRip('ips')"></label>
                                                    <label>Rips EAP<input type="radio" name="tipoCarga" value="CargarRips" onclick="seleccionarTipoRip('eap')"></label>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>