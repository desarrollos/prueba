<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<%@ taglib prefix="jsp2" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>

<html>
<%
clases.VerificarUsuarioSistema v;
v = new clases.VerificarUsuarioSistema(request,response);
%>
<head><script type="text/javascript" src="../js/jquery/jquery.js"></script>
<title>:: DELPHOS ::</title>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
        <link rel="stylesheet" type="text/css" media="all" href="../css/delphos.css" />
        <link rel="stylesheet" type="text/css" media="all" href="../js/jsCalendar/skins/aqua/theme.css" title="Aqua" />
        <link href="../images/favicon.ico" rel="Shortcut Icon" type="image/x-icon" />

        <script type="text/javascript" src="../js/jsCalendar/calendar.js"></script>
        <script type="text/javascript" src="../js/jsCalendar/lang/calendar-es.js"></script>
        <script type="text/javascript" src="../js/jsCalendar/calendar-setup.js"></script>
        <script type="text/javascript" src="../js/treeview/ua.js"></script>
        <script type="text/javascript" src="../js/treeview/ftiens4.js"></script>

        <script type="text/javascript" src="../js/treeview/demoFramelessNodes.js"></script>
        
        <script type="text/javascript" src="../js/pestanas/animatedcollapse.js"></script>
        <script type="text/javascript" src="../js/validaciones/validador.js"></script>
        <script type="text/javascript" src="../js/validaciones/validadorkp.js"></script>
        <script type="text/javascript" src="../js/validaciones/validadorcontrol.js"></script>
        <script type="text/javascript">
            
			//totalidad de elementos en el form
            var cajas = new Array('codalterno','valormedico','valoranestesiologo','valorayudantia','valorperfusion','valormatesucu','valorsala','valoractividad','porcplan','cantmaxima','cantsincopago','edadinicial','edadfinal','observacion');
            var combos = new Array('codcontratos','codtipoplantarifas','codestadoregistro','codtipoperiodo','codunidmededadini','codunidmededadfin');
                      
            //validar
            var arrayNonulos               = null
            var arrayNumerosEnteros        = new Array('cantmaxima','cantsincopago','edadinicial','edadfinal');
            var arrayCombos                = new Array('codcontratos','codtipoplantarifas','codestadoregistro','codtipoperiodo','codunidmededadini','codunidmededadfin');
            var arrayCadenasANCod          = new Array('codalterno');
            var arrayCadenasA              = null;
            var arrayComentarios           = new Array('observacion');
            var arrayNumerosDoubles        = new Array('valormedico','valoranestesiologo','valorayudantia','valorperfusion','valormatesucu','valorsala','valoractividad');
			
			var arrayPorcentajes            = new Array('porcplan');
            var arrayDirecciones            = null;
            var arrayCorreos                = null;
            
	</script>
</head>
<body bgcolor="#FFFFFF" onLoad="borrarMensaje(combos[0]);">
<center>
<table id="Table_01" width="906" style="height: 780; border: 0px" cellpadding="0" cellspacing="0">
<tr>
    <td colspan="3">
        <jsp:include page="../header.jsp" />
    </td>
</tr>
<tr>
    <td width="234" height="529" valign="top" style="background: url('../images/back.png')">
        <table cellpadding="0" cellspacing="0">
            <tr>
                <td align="left" valign="top">
                    <jsp:include page="../menu.jsp" />
                </td>
            </tr>
        </table>
    </td>
    <td valign="top">
        
        <center>
            <c:if test='${param.codregimenes != null && param.codentidadsalud != null && param.codcontrato != null && param.codtipometodologia != null && param.codtipometodologia != "" && param.codactividadsalud != null && param.codactividadsalud != "" && param.anyo != null && param.anyo != "" && param.mesinicial != null && param.mesinicial != "" && param.codtipoplantarifa != null}'>
            <sql:query var="r" sql="SELECT * FROM actividadcontrato WHERE codregimenes='${param.codregimenes}' AND codentidadsalud='${param.codentidadsalud}' AND codcontrato='${param.codcontrato}' AND codtipometodologia=${param.codtipometodologia} AND codactividadsalud=${param.codactividadsalud} AND anyo=${param.anyo} AND mesinicial=${param.mesinicial} AND codtipoplantarifa='${param.codtipoplantarifa}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codregimenesf" value="${fila.codregimenes}"/>
              <c:set var="codentidadsaludf" value="${fila.codentidadsalud}"/>
              <c:set var="codcontratof" value="${fila.codcontrato}"/>
              <c:set var="codtipometodologiaf" value="${fila.codtipometodologia}"/>
              <c:set var="codactividadsaludf" value="${fila.codactividadsalud}"/>
              <c:set var="anyof" value="${fila.anyo}"/>
              <c:set var="mesinicialf" value="${fila.mesinicial}"/>
              <c:set var="codtipoplantarifaf" value="${fila.codtipoplantarifa}"/>
              <c:set var="codestadoregistro" value="${fila.codestadoregistro}"/>
              <c:set var="porcplan" value="${fila.porcplan}"/>
              <c:set var="valoractividad" value="${fila.valoractividad}"/>
              <c:set var="valormedico" value="${fila.valormedico}"/>
              <c:set var="valoranestesiologo" value="${fila.valoranestesiologo}"/>
              <c:set var="valorayudantia" value="${fila.valorayudantia}"/>
              <c:set var="valorsala" value="${fila.valorsala}"/>
              <c:set var="valormatesucu" value="${fila.valormatesucu}"/> 
              <c:set var="valorperfusion" value="${fila.valorperfusion}"/>
              <c:set var="aplicahombre" value="${fila.aplicahombre}"/>
              <c:set var="aplicamujer" value="${fila.aplicamujer}"/>
              <c:set var="cantmaxima" value="${fila.cantmaxima}"/>
              <c:set var="codtipoperiodo" value="${fila.codtipoperiodo}"/>
              <c:set var="incluyetodoact" value="${fila.incluyetodoact}"/>
              <c:set var="cantsincopago" value="${fila.cantsincopago}"/> 
              <c:set var="codalterno" value="${fila.codalterno}"/>
              <c:set var="codunidmededadini" value="${fila.codunidmededadini}"/>
              <c:set var="edadinicial" value="${fila.edadinicial}"/>
              <c:set var="codunidmededadfin" value="${fila.codunidmededadfin}"/>
              <c:set var="edadfinal" value="${fila.edadfinal}"/>
              <c:set var="observacion" value="${fila.observacion}"/>
            </jsp2:forEach>
                
                <table width="740" border="0" class="tablaContenido">
                <span id="mensajeControlador">${msj}</span>
				<form action="Actividades.jsp" method="post" name="formulario">
                  <tr>
                    <td colspan="6"><div align="center" class="titulo1">Actividades</div></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="30" class="bgDescTablas">&nbsp;</td>
                    <td width="139" class="bgDescTablas"><strong>Contrato</strong></td>
                    <td width="150" class="sinBgDescTablas">
		  <select name="codcontratos" id="codcontratos" style="width: 150px">
               <option id="codcontratos" value=""></option>
                  <sql:query var="r" sql="select codcontrato, codregimenes, codentidadsalud from contrato" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                   <c:choose>
                        <c:when test='${fila.codregimenes == codregimenesf && fila.codentidadsalud == codentidadsaludf && fila.codcontrato == codcontratof}'>
                        <option value="${fila.codregimenes} ${fila.codentidadsalud} ${fila.codcontrato}" selected="selected">${fila.codcontrato}</option>
                        </c:when>
                    <c:otherwise>
                        <option value="${fila.codregimenes} ${fila.codentidadsalud} ${fila.codcontrato}">${fila.codcontrato}</option>
                    </c:otherwise>
                   </c:choose>
                 </jsp2:forEach>
                    </select></td>
                    <td width="20">&nbsp;</td>
                    <td width="119" class="bgDescTablas"><strong>Plan Tarifa </strong></td>
                    <td width="184" class="sinBgDescTablas"><select name="codtipoplantarifas" id="codtipoplantarifas" style="width: 150px">
                      <option id="codtipoplantarifas" value=""></option>
                      <sql:query var="r" sql="select a.codtipometodologia, a.codactividadsalud, a.anyo, a.mesinicial, a.codtipoplantarifa, b.descripcion from plantarifa a, tipoplantarifa b where a.codtipoplantarifa = b.codtipoplantarifa" dataSource="jdbc/delphos" scope="page"/>
                      <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                        <c:choose>
                          <c:when test='${fila.codtipometodologia == codtipometodologiaf && fila.codactividadsalud == codactividadsaludf && fila.anyo == anyof && fila.mesinicial == mesinicialf && fila.codtipoplantarifa == codtipoplantarifaf}'>
                            <option value="${fila.codtipometodologia} ${fila.codactividadsalud} ${fila.anyo} ${fila.mesinicial} ${fila.codtipoplantarifa}" selected="selected">${fila.descripcion}</option>
                          </c:when>
                          <c:otherwise>
                            <option value="${fila.codtipometodologia} ${fila.codactividadsalud} ${fila.anyo} ${fila.mesinicial} ${fila.codtipoplantarifa}">${fila.descripcion}</option>
                          </c:otherwise>
                        </c:choose>
                      </jsp2:forEach>
                    </select></td>
                  </tr>
                  <tr>
                    <td height="27" colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td height="27" class="bgDescTablas"><strong>C&oacute;digo Alterno</strong></td>
                    <td colspan="4" class="sinBgDescTablas"><label>
                      <input name="codalterno" type="text" id="codalterno" value="${codalterno}" size="20" maxlength="6">
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="6"><div align="center" class="titulo1">Valores</div></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="6"><table width="617" border="0" align="center">
                      <tr class="bgDescTablas">
                        <td><div align="center"><strong>Honorarios</strong></div></td>
                        <td><div align="center"><strong>Anestesi&oacute;logo</strong></div></td>
                        <td><div align="center"><strong>Ayudant&iacute;a</strong></div></td>
                        <td><div align="center"><strong>Perfusi&oacute;n</strong></div></td>
                      </tr>
                      <tr class="sinBgDescTablas">
                        <td><div align="center">
                          <input name="valormedico" type="text" id="valormedico" value="${valormedico}" size="20" maxlength="15" />
                        </div></td>
                        <td><div align="center">
                          <input name="valoranestesiologo" type="text" id="valoranestesiologo" value="${valoranestesiologo}" size="20" maxlength="15" />
                        </div></td>
                        <td><div align="center">
                          <input name="valorayudantia" type="text" id="valorayudantia" value="${valorayudantia}" size="20" maxlength="15" />
                        </div></td>
                        <td><div align="center">
                          <input name="valorperfusion" type="text" id="valorperfusion" value="${valorperfusion}" size="20" maxlength="15" />
                        </div></td>
                      </tr>
                    </table></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="6"><center><table width="514" border="0">
                      <tr class="bgDescTablas">
                        <td width="165"><div align="center"><strong>Materiales</strong></div></td>
                        <td width="165"><div align="center"><strong>Sala</strong></div></td>
                        <td width="170"><div align="center"><strong>Actividad</strong></div></td>
                      </tr>
                      <tr class="sinBgDescTablas">
                        <td><div align="center">
                          <input name="valormatesucu" type="text" id="valormatesucu" value="${valormatesucu}" size="20" maxlength="15"/>
                        </div></td>
                        <td><div align="center"><span class="sinBgDescTablas">
                          <input name="valorsala" type="text" id="valorsala" value="${valorsala}" size="20" maxlength="15"/>
                        </span></div></td>
                        <td><div align="center">
                          <input name="valoractividad" type="text" id="valoractividad" value="${valoractividad}" size="20" maxlength="15" />
                        </div></td>
                      </tr>
                    </table></center></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Aplica Hombre</strong></td>
                    <td class="bgDescTablas"><c:choose>
                <c:when test = '${aplicahombre == "S"}'>
                  <label><span class="descCampoForm">Si
                    <input type="radio" name="aplicahombre" value="S" id="aplicahombre_0" checked="true"/>
                  </span> </label>
                  <label> <span class="descCampoForm">No
                    <input type="radio" name="aplicahombre" value="N" id="aplicahombre_1" />
                  </span> </label>
                </c:when>
                  <c:otherwise>
                    <label> <span class="descCampoForm">Si
                      <input type="radio" name="aplicahombre" value="S" id="aplicahombre_0"/>
                    </span> </label>
                    <label> <span class="descCampoForm">No
                      <input type="radio" name="aplicahombre" value="N" id="aplicahombre_1" checked="true"/>
                    </span> </label>
                  </c:otherwise>
                  </c:choose></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas"><strong>Aplica Mujer</strong></td>
                    <td class="bgDescTablas"><c:choose>
                <c:when test = '${aplicamujer == "S"}'>
                  <label><span class="descCampoForm">Si
                    <input type="radio" name="aplicamujer" value="S" id="aplicamujer_0" checked="true"/>
                  </span> </label>
                  <label> <span class="descCampoForm">No
                    <input type="radio" name="aplicamujer" value="N" id="aplicamujer_1" />
                  </span> </label>
                </c:when>
                  <c:otherwise>
                    <label> <span class="descCampoForm">Si
                      <input type="radio" name="aplicamujer" value="S" id="aplicamujer_0"/>
                    </span> </label>
                    <label> <span class="descCampoForm">No
                      <input type="radio" name="aplicamujer" value="N" id="aplicamujer_1" checked="true"/>
                    </span> </label>
                  </c:otherwise>
                  </c:choose></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Porcentaje Plan </strong></td>
                    <td class="sinBgDescTablas"><label>
                      <input name="porcplan" type="text" id="porcplan" value="${porcplan}" size="20" maxlength="8" />
                    </label></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas"><strong>Estado Registro </strong></td>
                    <td class="sinBgDescTablas"><label>
                      <select name="codestadoregistro" id="codestadoregistro" style="width: 150px">
                       <option id="codestadoregistro" value=""></option>
                              <sql:query var="r" sql="select codestadoregistro, descripcion from estadoregistro" dataSource="jdbc/delphos" scope="page"/>
                        <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                               <c:choose>
                                    <c:when test='${fila.codestadoregistro == codestadoregistro}'>
                                    <option value="${fila.codestadoregistro}" selected="selected">${fila.descripcion}</option>
                                    </c:when>
                                <c:otherwise>
                                    <option value="${fila.codestadoregistro}">${fila.descripcion}</option>
                                </c:otherwise>
                               </c:choose>
                        </jsp2:forEach>
                    </select>
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Cantidad Max.</strong></td>
                    <td class="sinBgDescTablas"><label>
                      <input name="cantmaxima" type="text" id="cantmaxima" value="${cantmaxima}" size="20" maxlength="9" />
                    </label></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas"><strong>Tipo Periodo</strong></td>
                    <td class="sinBgDescTablas"><label>
                      <select name="codtipoperiodo" id="codtipoperiodo" style="width: 150px">
                        <option id="codtipoperiodo" value=""></option>
                          <sql:query var="r" sql="select codtipoperiodo, descripcion from tipoperiodo" dataSource="jdbc/delphos" scope="page"/>
                        <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                           <c:choose>
                                <c:when test='${fila.codtipoperiodo == codtipoperiodo}'>
                                <option value="${fila.codtipoperiodo}" selected="selected">${fila.descripcion}</option>
                                </c:when>
                            <c:otherwise>
                                <option value="${fila.codtipoperiodo}">${fila.descripcion}</option>
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
                    <td>&nbsp;</td>
                    <td><strong class="bgDescTablas"> Incluye Todas Actividades Periodo</strong></td>
                    <td class="bgDescTablas"><c:choose>
                <c:when test = '${incluyetodoact == "S"}'>
                  <label><span class="descCampoForm">Si
                    <input type="radio" name="incluyetodoact" value="S" id="incluyetodoact_0" checked="true"/>
                  </span> </label>
                  <label> <span class="descCampoForm">No
                    <input type="radio" name="incluyetodoact" value="N" id="incluyetodoact_1" />
                  </span> </label>
                </c:when>
                  <c:otherwise>
                    <label> <span class="descCampoForm">Si
                      <input type="radio" name="incluyetodoact" value="S" id="incluyetodoact_0"/>
                    </span> </label>
                    <label> <span class="descCampoForm">No
                      <input type="radio" name="incluyetodoact" value="N" id="incluyetodoact_1" checked="true"/>
                    </span> </label>
                  </c:otherwise>
                  </c:choose></td>
                    <td>&nbsp;</td>
                    <td><strong class="bgDescTablas">Cantidad sin Copago</strong></td>
                    <td class="sinBgDescTablas"><input name="cantsincopago" type="text" id="cantsincopago" value="${cantsincopago}" size="20" maxlength="9" /></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Edad Inicial</strong></td>
                    <td class="sinBgDescTablas"><input name="edadinicial" type="text" id="edadinicial" value="${edadinicial}" size="20" maxlength="4" /></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas"><strong>Medida</strong></td>
                    <td class="sinBgDescTablas">
					<select name="codunidmededadini" id="codunidmededadini" style="width: 150px">
                      <option id="codunidmededadini" value=""></option>
                          <sql:query var="r" sql="select codunidmedidaedad, descripcion from unidadmedidaedad" dataSource="jdbc/delphos" scope="page"/>
                          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                           <c:choose>
                                <c:when test='${fila.codunidmedidaedad == codunidmededadini}'>
                                <option value="${fila.codunidmedidaedad}" selected="selected">${fila.descripcion}</option>
                                </c:when>
                            <c:otherwise>
                                <option value="${fila.codunidmedidaedad}">${fila.descripcion}</option>
                            </c:otherwise>
                           </c:choose>
                         </jsp2:forEach>
                     </select></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Edad Final</strong></td>
                    <td class="sinBgDescTablas"><input name="edadfinal" type="text" id="edadfinal" value="${edadfinal}" size="20" maxlength="4" /></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas"><strong>Medida </strong></td>
                    <td class="sinBgDescTablas">
					<select name="codunidmededadfin" id="codunidmededadfin" style="width: 150px">
                      <option id="codunidmededadfin" value=""></option>
                          <sql:query var="r" sql="select codunidmedidaedad, descripcion from unidadmedidaedad" dataSource="jdbc/delphos" scope="page"/>
                          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                           <c:choose>
                                <c:when test='${fila.codunidmedidaedad == codunidmededadfin}'>
                                <option value="${fila.codunidmedidaedad}" selected="selected">${fila.descripcion}</option>
                                </c:when>
                            <c:otherwise>
                                <option value="${fila.codunidmedidaedad}">${fila.descripcion}</option>
                            </c:otherwise>
                           </c:choose>
                         </jsp2:forEach>
                     </select></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="6"><p align="center" class="bgDescTablas"><strong>Observaciones</strong></p>
                    <p align="center" class="bgDescTablas">
                      <textarea name="observacion" cols="75" rows="3" id="observacion">${observacion}</textarea>
                    </p></td>
                  </tr>
                  <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="codregimenes" id="codregimenes" value="" >
                  <input type="hidden" name="codentidadsalud" id="codentidadsalud" value="" >
                  <input type="hidden" name="codcontrato" id="codcontrato" value="" >
                  <input type="hidden" name="codtipometodologia" id="codtipometodologia" value="" >
                  <input type="hidden" name="codactividadsalud" id="codactividadsalud" value="" >
                  <input type="hidden" name="anyo" id="anyo" value="" >
                  <input type="hidden" name="mesinicial" id="mesinicial" value="" >
                  <input type="hidden" name="codtipoplantarifa" id="codtipoplantarifa" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="6"> -->
		  <label>&nbsp;</label>
                  <!--<input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="3" />
                  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="4"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="5"/> -->
                  <jsp:include page="../BarraNavegacion.jsp?tabBuscar=17&tabGuardar=14&tabEditar=15&tabEliminar=16" />
               </div>            </td>
           </tr>
	</form>
       </table>
     </center>
        
    </td>
</tr>
<tr>
    <td>
        <jsp:include page="../footer.jsp" />   </td>
</tr>
</table>
</center>
<!-- End ImageReady Slices -->
<script>    
    //funciones control
    function accion(x)
    {        
        if(validar2(arrayNonulos, arrayNumerosEnteros, arrayCombos, arrayCadenasANCod, arrayCadenasA, arrayComentarios, arrayNumerosDoubles, arrayPorcentajes, arrayDirecciones, arrayCorreos))
        {
            if(x == 1)
            {
                document.getElementById('valpk').value = 1;
            }
            else if(x == 2)
            {
                document.getElementById('valpk').value = 2;
            }
            else if(x == 3)
            {
                document.getElementById('valpk').value = 3;
            }
            validarPK();            
        }
    } 
    
    //-------VALIDACION PK
    function validarPK()
    {
        var cad = document.getElementById('codcontratos').value;
        var cad2 = cad.split(" ");
		
        llaves = 'codregimenes='+cad2[0]+',';
		llaves+= 'codentidadsalud='+cad2[1]+',';
		llaves+= 'codcontrato='+cad2[2]+',';	
		
		var cad = document.getElementById('codtipoplantarifas').value;
        var cad2 = cad.split(" ");
		
        llaves+= 'codtipometodologia='+cad2[0]+',';
		llaves+= 'codactividadsalud='+cad2[1]+',';
		llaves+= 'anyo='+cad2[2]+',';
		llaves+= 'mesinicial='+cad2[3]+',';
		llaves+= 'codtipoplantarifa='+cad2[4];
		
        validarLlave('actividadcontrato',llaves);
    } 
    
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=actividadcontrato&";
        url = url + "campos=codregimenes,codentidadsalud,codcontrato,codtipometodologia,codactividadsalud,anyo,mesinicial,codtipoplantarifa&";
        url = url + "campoLlave=codregimenes,codentidadsalud,codcontrato,codtipometodologia,codactividadsalud,anyo,mesinicial,codtipoplantarifa";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>