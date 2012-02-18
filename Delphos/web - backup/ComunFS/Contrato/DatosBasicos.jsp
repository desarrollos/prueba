<table width="767" border="0" class="tablaContenido">
  <tr>
	<td colspan="6" class="titulo1"><div align="center">Datos Basicos </div></td>
  </tr>
  <tr>
	<td colspan="6">&nbsp;</td>
  </tr>
  <tr>
    <td class="bgDescTablas">&nbsp;</td>
    <td class="bgDescTablas"><strong>Contratista</strong></td>
    <td class="sinBgDescTablas">
    <select name="codemprcontratista" id="codemprcontratista" style="width: 150px">
               <option id="codemprcontratista" value=""></option>
                  <sql:query var="r" sql="select codtipoidentidad, codempresa, nombre from empresa" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                   <c:choose>
                        <c:when test='${fila.codtipoidentidad == codtipoidentidad && fila.codempresa == codemprcontratista}'>
                        <option value="${fila.codtipoidentidad} ${fila.codempresa}" selected="selected">${fila.nombre}</option>
                        </c:when>
                    <c:otherwise>
                        <option value="${fila.codtipoidentidad} ${fila.codempresa}">${fila.nombre}</option>
                    </c:otherwise>
                   </c:choose>
                 </jsp2:forEach>
    </select></td>
    <td>&nbsp;</td>
    <td class="bgDescTablas"><strong>Contratante</strong></td>
    <td class="sinBgDescTablas">
    <select name="codemprcontratante" id="codemprcontratante" style="width: 150px">
               <option id="codemprcontratante" value=""></option>
                  <sql:query var="r" sql="select codtipoidentidad, codempresa, nombre from empresa" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                   <c:choose>
                        <c:when test='${fila.codtipoidentidad == codtipoidentidad && fila.codempresa == codempresa}'>
                        <option value="${fila.codtipoidentidad} ${fila.codempresa}" selected="selected">${fila.nombre}</option>
                        </c:when>
                    <c:otherwise>
                        <option value="${fila.codtipoidentidad} ${fila.codempresa}">${fila.nombre}</option>
                    </c:otherwise>
                   </c:choose>
                 </jsp2:forEach>
    </select></td>
  </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
  </tr>
  <tr>
    <td width="30">&nbsp;</td>
	<td width="142"><span class="bgDescTablas"><strong>Codigo</strong></span></td>
	<td width="183" class="sinBgDescTablas"><input name="codcontrato" type="text" id="codcontrato" value="${codcontrato}" size="20" maxlength="18" /></td>
	<td width="19">&nbsp;</td>
	<td width="130" class="bgDescTablas"><strong>Numero</strong></td>
	<td width="237" class="sinBgDescTablas">
	  <input  name="numero" type="text" id="numero" value="${numero}" size="20" maxlength="20" />	</td>
  </tr>
  <tr>
	<td colspan="6">&nbsp;</td>
  </tr>
  <tr>
    <td class="bgDescTablas">&nbsp;</td>
	<td class="bgDescTablas"><strong>Tipo</strong></td>
	<td class="sinBgDescTablas">
    <select name="codtipocontrato" id="codtipocontrato" style="width: 150px">
             <option id="codtipocontrato" value=""></option>
                  <sql:query var="r" sql="select codtipocontrato, descripcion from tipocontrato" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                   <c:choose>
                        <c:when test='${fila.codtipocontrato == codtipocontrato}'>
                        <option value="${fila.codtipocontrato}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                    <c:otherwise>
                        <option value="${fila.codtipocontrato}">${fila.descripcion}</option>
                    </c:otherwise>
                   </c:choose>
                 </jsp2:forEach>
    </select></td>
	<td>&nbsp;</td>
	<td class="bgDescTablas"><strong>Clase</strong></td>
	<td class="sinBgDescTablas">
    <select name="codclasecontrato" id="codclasecontrato" style="width: 150px">
              <option id="codclasecontrato" value=""></option>
                  <sql:query var="r" sql="select codclasecontrato, descripcion from clasecontrato" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                   <c:choose>
                        <c:when test='${fila.codclasecontrato == codclasecontrato}'>
                        <option value="${fila.codclasecontrato}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                    <c:otherwise>
                        <option value="${fila.codclasecontrato}">${fila.descripcion}</option>
                    </c:otherwise>
                   </c:choose>
                 </jsp2:forEach>
    </select></td>
  </tr>
  <tr>
    <td colspan="6" class="bgDescTablas">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="6" class="bgDescTablas"><p align="center"><strong>Descripcion</strong></p>
      <p align="center"><strong>    
        <input name="descripcion" type="text" id="descripcion" value="${descripcion}" size="75" maxlength="60" />
      </strong></p></td>
  </tr>
  <tr>
    <td colspan="6" class="bgDescTablas">&nbsp;</td>
  </tr>
  <tr>
    <td class="bgDescTablas">&nbsp;</td>
	<td class="bgDescTablas"><strong>Entidad Salud</strong></td>
	<td class="sinBgDescTablas"><label>
	  <select name="codentidadsalud" id="codentidadsalud" style="width: 150px">
               <option id="codentidadsalud" value=""></option>
                  <sql:query var="r" sql="select codregimenes, codentidadsalud, nombre from entidadsalud a join empresa b on a.codempresa = b.codempresa" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                   <c:choose>
                        <c:when test='${fila.codentidadsalud == codentidadsalud && codregimenes == codregimenes}'>
                        <option value="${fila.codregimenes} ${fila.codentidadsalud}" selected="selected">${fila.nombre}</option>
                        </c:when>
                    <c:otherwise>
                        <option value="${fila.codregimenes} ${fila.codentidadsalud}">${fila.nombre}</option>
                    </c:otherwise>
                   </c:choose>
                 </jsp2:forEach>
      </select>
	</label></td>
	<td>&nbsp;</td>
	<td class="bgDescTablas"><strong>Modalidad</strong></td>
	<td class="sinBgDescTablas">
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
      </select></td>
  </tr>
  <tr>
	<td height="21" colspan="6">&nbsp;</td>
  </tr>
  <tr>
    <td class="bgDescTablas">&nbsp;</td>
	<td height="27" class="bgDescTablas"><strong>Cubrimiento UPC</strong></td>
	<td class="sinBgDescTablas"><label>
	  <select name="codtipocubrimupc" id="codtipocubrimupc" style="width: 150px">
              <option id="codtipocubrimupc" value=""></option>
                  <sql:query var="r" sql="select codregimen, codtipocubrimupc, anyoinicial, mesinicial from upcs" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                   <c:choose>
                        <c:when test='${fila.codregimen == codregimen && fila.codtipocubrimupc == codtipocubrimupc && fila.anyoinicial == anyoinicial} && ${fila.mesinicial == mesinicial}'>
                        <option value="${fila.codregimen} ${fila.codtipocubrimupc} ${fila.anyoinicial} ${fila.mesinicial}" selected="selected">${fila.codtipocubrimupc}</option>
                        </c:when>
                    <c:otherwise>
                        <option value="${fila.codregimen} ${fila.codtipocubrimupc} ${fila.anyoinicial} ${fila.mesinicial}">${fila.codtipocubrimupc}</option>
                    </c:otherwise>
                   </c:choose>
                 </jsp2:forEach>
      </select>
	</label></td>
	<td>&nbsp;</td>
	<td class="bgDescTablas"><strong>Grupo Poblacional</strong></td>
	<td class="sinBgDescTablas"><label>
	  <select name="codgrupopoblacion" id="codgrupopoblacion" style="width: 150px">
           <option id="codgrupopoblacion" value=""></option>
                  <sql:query var="r" sql="select codgrupopoblacion, descripcion from grupopoblacion" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                   <c:choose>
                        <c:when test='${fila.codgrupopoblacion == codgrupopoblacion}'>
                        <option value="${fila.codgrupopoblacion}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                    <c:otherwise>
                        <option value="${fila.codgrupopoblacion}">${fila.descripcion}</option>
                    </c:otherwise>
                   </c:choose>
                 </jsp2:forEach>
	  </select>
	</label></td>
  </tr>
  <tr>
	<td colspan="6">&nbsp;</td>
  </tr>
  <tr>
    <td class="bgDescTablas">&nbsp;</td>
	<td class="bgDescTablas"><strong>Aplicacion Contrato</strong></td>
	<td class="sinBgDescTablas"><label></label>
	  <select name="codaplicacioncontrato" id="codaplicacioncontrato" style="width: 150px">
            <option id="codaplicacioncontrato" value=""></option>
                  <sql:query var="r" sql="select codaplicacioncontrato, descripcion from aplicacioncontrato" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                   <c:choose>
                        <c:when test='${fila.codaplicacioncontrato == codaplicacioncontrato}'>
                        <option value="${fila.codaplicacioncontrato}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                    <c:otherwise>
                        <option value="${fila.codaplicacioncontrato}">${fila.descripcion}</option>
                    </c:otherwise>
                   </c:choose>
                 </jsp2:forEach>
      </select></td>
	<td>&nbsp;</td>
	<td class="bgDescTablas"><strong>Estado</strong></td>
	<td class="sinBgDescTablas"><label>
	  <input name="estadocto" type="text" id="estadocto" size="20" readonly="true" />
	</label></td>
  </tr>
  <tr>
	<td colspan="6">&nbsp;</td>
  </tr>
</table>
