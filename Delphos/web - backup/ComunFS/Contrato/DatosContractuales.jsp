<table width="728" border="0" class="tablaContenido">
  <tr>
	<td colspan="6"><div align="center" class="titulo1">Datos Contractuales </div></td>
  </tr>
  <tr>
	<td colspan="6">&nbsp;</td>
  </tr>
  <tr>
    <td width="30">&nbsp;</td>
	<td width="101"><span class="bgDescTablas"><strong>Contratante</strong></span></td>
	<td width="200" class="sinBgDescTablas"><input name="contratante" type="text" id="contratante" value="${contratante}" size="20" maxlength="18" readonly="true"/></td>
	<td width="5">&nbsp;</td>
	<td width="103" class="bgDescTablas"><strong>Codigo </strong></td>
	<td width="192" class="sinBgDescTablas">
	  <input  name="codigo" type="text" id="codigo" value="${codigo}" readonly="readonly"/>                    </td>
  </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="6" class="bgDescTablas"><p align="center"><strong>Descripcion</strong></p>
      <p align="center"><strong>
        <input name="descripcioncontrato" type="text" class="sinBgDescTablas" id="descripcioncontrato" value="${descripcioncontrato}" size="75" maxlength="60" readonly="true" />
      </strong></p></td>
  </tr>
  <tr>
    <td colspan="6" class="bgDescTablas"><p align="center"><strong>Objeto</strong></p>
      <p align="center"><strong>    
        <textarea name="objeto" cols="75" rows="3" class="sinBgDescTablas" id="objeto">${objeto}</textarea>
      </strong></p></td>
  </tr>
  <tr>
    <td class="bgDescTablas">&nbsp;</td>
	<td class="bgDescTablas"><strong>Fecha Inicio</strong></td>
	<td class="sinBgDescTablas"><input name="fechainicio" type="text" id="fechainicio" value="${fechainicio}" size="15" readonly="true" />
      <input name="button" type="button" id="botonFechainicio" value="..." /></td>
	<td>&nbsp;</td>
	<td class="bgDescTablas"><strong>Fecha Fin</strong></td>
	<td class="sinBgDescTablas"><input name="fechafinal" type="text" id="fechafinal" value="${fechafinal}" size="15" readonly="true" />
      <input name="button2" type="button" id="botonFechafinal" value="..." /></td>
  </tr>
  <tr>
	<td height="28" colspan="6" class="bgDescTablas">&nbsp;</td>
  </tr>
  <tr>
    <td class="bgDescTablas">&nbsp;</td>
	<td class="bgDescTablas"><label><strong>Departamento</strong></label></td>
    <td class="bgDescTablas"><label>
      <select name="coddepartamento" id="coddepartamento" onchange="cargarMunicipios();">
        <option value=""></option>
        <sql:query var="r" sql="select coddepartamento, nombre from departamento order by nombre" dataSource="jdbc/delphos" scope="page"/>
        <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
          <c:choose>
            <c:when test='${fila.coddepartamento == coddepartamento}'>
              <option value="${fila.coddepartamento}" selected="selected">${fila.nombre}</option>
            </c:when>
            <c:otherwise>
              <option value="${fila.coddepartamento}">${fila.nombre}</option>
            </c:otherwise>
          </c:choose>
        </jsp2:forEach>
      </select>
    </label></td>
    <td class="bgDescTablas">&nbsp;</td>
    <td class="bgDescTablas"><strong>Municipio</strong></td>
    <td class="bgDescTablas">
	<span id="spanMunicipio">
                    <c:choose>
                        <c:when test="${codmunicipio != null}">
                        <select name="codmunicipio" id="codmunicipio">
                        <option value=""></option>
                        <sql:query var="r" sql="select codmunicipio, nombre from municipio where coddepartamento='${coddepartamento}' order by nombre" dataSource="jdbc/delphos" scope="page"/>
                        <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                        <c:choose>
                            <c:when test='${fila.codmunicipio == codmunicipio}'>
                            <option value="${fila.codmunicipio}" selected="selected">${fila.nombre}</option>
                            </c:when>
                            <c:otherwise>
                            <option value="${fila.codmunicipio}">${fila.nombre}</option>
                            </c:otherwise>
                        </c:choose>
                        </jsp2:forEach>
                        </select>                        
                        </c:when>
                        <c:otherwise>
                        <select disabled>
                            <option value=""></option>
                        </select>
                        </c:otherwise>
                    </c:choose>
                </span></td>
  </tr>
  <tr>
	<td height="27" colspan="6">&nbsp;</td>
  </tr>
  <tr>
    <td class="bgDescTablas">&nbsp;</td>
	<td height="27" class="bgDescTablas"><strong>Valor</strong></td>
	<td colspan="4" class="sinBgDescTablas"><label>
	  <input name="valor" type="text" id="valor" value="${valor}" size="20" maxlength="15" />
	</label>	  <label></label></td>
  </tr>
  <tr>
	<td colspan="6">&nbsp;</td>
  </tr>
  <tr>
    <td class="bgDescTablas">&nbsp;</td>
	<td class="bgDescTablas"><strong>Fecha Legalizacion</strong></td>
	<td class="sinBgDescTablas"><label>
	  <input name="fechalegalizac" type="text" id="fechalegalizac" value="${fechalegalizac}" size="15" readonly="true" />
      <input name="button3" type="button" id="botonFechalegalizac" value="..." />
	</label></td>
	<td>&nbsp;</td>
	<td class="bgDescTablas"><strong>Nro. Radicacion</strong></td>
	<td class="sinBgDescTablas"><label>
	  <input name="nroradicacion" type="text" id="nroradicacion" value="${nroradicacion}" size="20" maxlength="20" />
	</label></td>
  </tr>
  <tr>
	<td colspan="6">&nbsp;</td>
  </tr>
  <tr>
    <td class="bgDescTablas">&nbsp;</td>
	<td class="bgDescTablas"><strong>Norma</strong></td>
	<td class="sinBgDescTablas"><label>
	  <select name="codnorma" id="codnorma" style="width: 150px">
         <option id="codnorma" value=""></option>
                  <sql:query var="r" sql="select codtiponorma, codnorma, fechanorma, referencia from normas"  dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                   <c:choose>
                        <c:when test='${fila.codtiponorma == codtiponorma && fila.codnorma == codnorma && fila.fechanorma == fechanorma}'>
                        <option value="${fila.codtiponorma} ${fila.fechanorma} ${fila.codnorma}" selected="selected">${fila.referencia}</option>
                        </c:when>
                    <c:otherwise>
                        <option value="${fila.codtiponorma} ${fila.fechanorma} ${fila.codnorma}">${fila.referencia}</option>
                    </c:otherwise>
                   </c:choose>
                 </jsp2:forEach>
      </select>
	</label></td>
	<td>&nbsp;</td>
	<td class="bgDescTablas"><strong>Fecha Suscripcion</strong></td>
	<td><span class="sinBgDescTablas">
	  <input name="fechasuscripcion" type="text" id="fechasuscripcion" value="${fechasuscripcion}" size="15" readonly="true" />
      <input name="button322" type="button" id="botonFechasuscripcion" value="..." />
	</span></td>
  </tr>
  <tr>
	<td colspan="6">&nbsp;</td>
  </tr>
  <tr>
    <td class="bgDescTablas">&nbsp;</td>
	<td class="bgDescTablas"><strong>Modalidad Contrato </strong></td>
	<td class="sinBgDescTablas"><label>
	  <select name="codmodalidadcontrato" id="codmodalidadcontrato" style="width: 150px">
           <option id="codmodalidadcontrato" value=""></option>
                  <sql:query var="r" sql="select codmodalidadcontrato, descripcion from modalidadcontrato" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                   <c:choose>
                        <c:when test='${fila.codmodalidadcontrato == codmodalidadcontrato}'>
                        <option value="${fila.codmodalidadcontrato}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                    <c:otherwise>
                        <option value="${fila.codmodalidadcontrato}">${fila.descripcion}</option>
                    </c:otherwise>
                   </c:choose>
                 </jsp2:forEach>
      </select>
	</label></td>
	<td>&nbsp;</td>
	<td class="bgDescTablas"><strong>Nro. Usuarios</strong></td>
	<td class="sinBgDescTablas"><label>
	  <input name="usuarioscontrato" type="text" id="usuarioscontrato" value="${usuarioscontrato}" size="20" maxlength="8" />
	</label></td>
  </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><span class="bgDescTablas"><strong>Codigo Barras</strong></span></td>
    <td><span class="sinBgDescTablas">
      <input name="codigobarras" type="text" id="codigobarras" value="${codigobarras}" size="20" maxlength="70" />
    </span></td>
    <td>&nbsp;</td>
    <td><span class="bgDescTablas"><strong>Archivo</strong></span></td>
    <td><span class="sinBgDescTablas" style="width: 20%">
      <input name="archivo" type="text" id="archivo" size="15"  value="${archivo}" readonly="readonly"/>
      <a href="#" onclick="abrirCargaArchivo();"><img src="../images/Buscar16x16.gif" alt="Cargar Archivo" border="0"/></a>
      <c:if test='${archivo != null}'> <br />
        <a href="../temp/${archivo}" target="_blank">Descargar ${archivo}</a> </c:if>
    </span></td>
  </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="6" class="bgDescTablas"><p align="center"><strong>Forma Pago</strong></p>
    <p align="center"><span class="bgDescTablas">
      <textarea name="formapago" cols="75" rows="3" id="formapago">${formapago}</textarea>
    </span></p></td>
  </tr>
  <tr>
    <td colspan="6"><p align="center" class="bgDescTablas"><strong>Observaciones</strong></p>
      <p align="center" class="bgDescTablas">
        <textarea name="observacion" cols="75" rows="3" id="observacion">${observacion}</textarea>
      </p></td>
  </tr>
</table>
