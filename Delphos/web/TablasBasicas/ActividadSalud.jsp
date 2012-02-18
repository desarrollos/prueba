<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<%@ taglib prefix="jsp2" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>

<html>
<%
clases.VerificarUsuarioSistema v;
v = new clases.VerificarUsuarioSistema(request,response);
%>
<head>
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
        <script type="text/javascript" src="../js/pestanas/jquery-1.2.2.pack.js"></script>
        <script type="text/javascript" src="../js/pestanas/animatedcollapse.js"></script>
        <script type="text/javascript" src="../js/validaciones/validador.js"></script>
        <script type="text/javascript" src="../js/validaciones/validadorkp.js"></script>
        <script type="text/javascript" src="../js/validaciones/validadorcontrol.js"></script>
        <script type="text/javascript">
            
            //totalidad de elementos en el form
            var cajas = new Array('codactividadsalud','cantidadmaxautorizar','tiempoaprox','cantidaduvr','codigoalterno','codigorips','codigobarras','descripcion','observacion','costo','tarifasmlv');
            var combos = new Array('codgrupoactividads','codambito','codclaseactividad','codconceptoservicio','codtipoactividad','codcategactividad','codprotocolo','codmanualactividad','codnivelcomplejidad');
                       
            //validar
            var arrayNonulos               	= new Array('codactividadsalud');
            var arrayNumerosEnteros        	= new Array('codactividadsalud','cantidadmaxautorizar','tiempoaprox','cantidaduvr');
            var arrayCombos               	= new Array('codgrupoactividads','codambito','codclaseactividad','codconceptoservicio','codtipoactividad','codcategactividad','codprotocolo','codmanualactividad','codnivelcomplejidad');
            var arrayCadenasANCod          	= new Array('codigoalterno','codigorips','codigobarras');
            var arrayCadenasA              	= null;
            var arrayComentarios           	= new Array('descripcion','observacion');
            var arrayNumerosDoubles             = new Array('costo','tarifasmlv');
			
	</script>
</head>
<body bgcolor="#FFFFFF" onLoad="borrarMensaje(cajas[0]);">
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
            <c:if test='${param.llave != null && param.llave !=""}'>
            <sql:query var="r" sql="SELECT * FROM actividadsalud WHERE codactividadsalud=${param.llave}" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codactividadsalud" value="${fila.codactividadsalud}"/>
              <c:set var="descripcion" value="${fila.descripcion}"/>
              <c:set var="observacion" value="${fila.observacion}"/>
              <c:set var="codgrupoactividadf" value="${fila.codgrupoactividad}"/>
              <c:set var="codambito" value="${fila.codambito}"/>             
              <c:set var="codclaseactividad" value="${fila.codclaseactividad}"/>
              <c:set var="codconceptoservicio" value="${fila.codconceptoservicio}"/>
              <c:set var="codtipoactividad" value="${fila.codtipoactividad}"/>              
              <c:set var="codcategactividad" value="${fila.codcategactividad}"/>              
              <c:set var="codprotocolo" value="${fila.codprotocolo}"/>
              <c:set var="codmanualactividad" value="${fila.codmanualactividad}"/>
              <c:set var="codnivelcomplejidad" value="${fila.codnivelcomplejidad}"/>
              <c:set var="codigoalterno" value="${fila.codigoalterno}"/>
              <c:set var="codigorips" value="${fila.codigorips}"/>
              <c:set var="costo" value="${fila.costo}"/>             
              <c:set var="cantidadmaxautorizar" value="${fila.cantidadmaxautorizar}"/>
              <c:set var="resultadofinal" value="${fila.resultadofinal}"/>
              <c:set var="codigobarras" value="${fila.codigobarras}"/>
              <c:set var="permitehombre" value="${fila.permitehombre}"/>
              <c:set var="permitemujer" value="${fila.permitemujer}"/>
              <c:set var="tiempoaprox" value="${fila.tiempoaprox}"/>
              <c:set var="tarifasmlv" value="${fila.tarifasmlv}"/>
              <c:set var="cantidaduvr" value="${fila.cantidaduvr}"/>
            </jsp2:forEach>
            <form name="formulario" id="formulario" method="post" action="ActividadSalud.jsp">
            <table width="811" border="0" class="tablaContenido">
              <span id="mensajeControlador">${msj}</span>
              <tr>
                <td colspan="6"><div align="center" class="titulo1">Actividad Salud</div></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td width="30">&nbsp;</td>
                <td><span class="bgDescTablas"><strong>C&oacute;digo Actividad Salud</strong></span></td>
                <td><span class="sinBgDescTablas">
                  <input name="codactividadsalud" type="text" id="codactividadsalud" value="${codactividadsalud}" size="20" maxlength="4" onKeyPress="javascript:return permite(event, 'nume')" tabindex="1"/>
                </span></td>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">C&oacute;digo Alterno</strong></td>
                <td><label>
                  <input name="codigoalterno" type="text" id="codigoalterno" value="${codigoalterno}" size="20" maxlength="15" onKeyPress="javascript:return permite(event, 'num_car_cod')" tabindex="2">
                </label></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td width="30">&nbsp;</td>
                <td width="128"><span class="bgDescTablas"><strong>Grupo Actividad</strong></span></td>
                <td width="168"><select name="codgrupoactividads" id="codgrupoactividads" style="width: 150px" tabindex="3">
                  <option id="codgrupoactividads" value=""></option>
                  <sql:query var="r" sql="select codgrupoactividad, codsubgrupo, descripcion from subgrupoactividad" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                    <c:choose>
                      <c:when test='${fila.codgrupoactividad == codgrupoactividadf && fila.codsubgrupo == codsubgrupo}'>
                        <option value="${fila.codgrupoactividad} ${fila.codsubgrupo}" selected="selected">${fila.descripcion}</option>
                      </c:when>
                      <c:otherwise>
                        <option value="${fila.codgrupoactividad} ${fila.codsubgrupo}">${fila.descripcion}</option>
                      </c:otherwise>
                    </c:choose>
                  </jsp2:forEach>
                </select></td>
                <td width="15">&nbsp;</td>
                <td width="140"><span class="bgDescTablas"><strong>Ambito Actividad</strong></span></td>
                <td width="164"><select name="codambito" id="codambito" style="width: 150px" tabindex="4">
                  <option id="codambito" value=""></option>
                  <sql:query var="r" sql="select codambito, descripcion from ambitoactividad" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                    <c:choose>
                      <c:when test='${fila.codambito == codambito}'>
                        <option value="${fila.codambito}" selected="selected">${fila.descripcion}</option>
                      </c:when>
                      <c:otherwise>
                        <option value="${fila.codambito}">${fila.descripcion}</option>
                      </c:otherwise>
                    </c:choose>
                  </jsp2:forEach>
                </select></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><span class="bgDescTablas" style="width: 7%"><strong>Clase Actividad</strong></span></td>
                <td><span class="sinBgDescTablas" style="width: 20%">
                  <select name="codclaseactividad" id="codclaseactividad" style="width: 150px" tabindex="5">
                    <option id="codclaseactividad" value=""></option>
                    <sql:query var="r" sql="select codclaseactividad, descripcion from claseactividad" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.codclaseactividad == codclaseactividad}'>
                          <option value="${fila.codclaseactividad}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.codclaseactividad}">${fila.descripcion}</option>
                        </c:otherwise>
                      </c:choose>
                    </jsp2:forEach>
                  </select>
                </span></td>
                <td>&nbsp;</td>
                <td><span class="bgDescTablas"><strong>Concepto Servicio</strong></span></td>
                <td><span class="sinBgDescTablas">
                  <label>                  </label>
                </span>
                  <label><span class="sinBgDescTablas" style="width: 20%">
                  <select name="codconceptoservicio" id="codconceptoservicio" style="width: 150px" tabindex="6">
                    <option id="codconceptoservicio" value=""></option>
                    <sql:query var="r" sql="select codconceptoservicio, descripcion from conceptoservicio" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.codconceptoservicio == codconceptoservicio}'>
                          <option value="${fila.codconceptoservicio}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.codconceptoservicio}">${fila.descripcion}</option>
                        </c:otherwise>
                      </c:choose>
                    </jsp2:forEach>
                  </select>
                  </span></label></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><span class="bgDescTablas"><strong>Tipo Actividad</strong></span></td>
                <td><span class="sinBgDescTablas" style="width: 20%">
                  <select name="codtipoactividad" id="codtipoactividad" style="width: 150px" tabindex="7">
                    <option id="codtipoactividad" value=""></option>
                    <sql:query var="r" sql="select codtipoactividad, descripcion from tipoactividad" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.codtipoactividad == codtipoactividad}'>
                          <option value="${fila.codtipoactividad}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.codtipoactividad}">${fila.descripcion}</option>
                        </c:otherwise>
                      </c:choose>
                    </jsp2:forEach>
                  </select>
                </span></td>
                <td>&nbsp;</td>
                <td class="bgDescTablas"><strong>Categor&iacute;a Actividad</strong></td>
                <td><span class="sinBgDescTablas" style="width: 20%">
                  <select name="codcategactividad" id="codcategactividad" style="width: 150px" tabindex="8">
                    <option id="codcategactividad" value=""></option>
                    <sql:query var="r" sql="select codcategactividad, descripcion from categoriaactividad" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.codcategactividad == codcategactividad}'>
                          <option value="${fila.codcategactividad}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.codcategactividad}">${fila.descripcion}</option>
                        </c:otherwise>
                      </c:choose>
                    </jsp2:forEach>
                  </select>
                </span></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>Protocolo</strong></td>
                <td><span class="sinBgDescTablas" style="width: 20%"><span class="sinBgDescTablas" style="width: 20%">
                  <select name="codprotocolo" id="codprotocolo" style="width: 150px" tabindex="9">
                    <option id="codprotocolo" value=""></option>
                    <sql:query var="r" sql="select codprotocolo, descripcion from protocoloactividad" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.codprotocolo == codprotocolo}'>
                          <option value="${fila.codprotocolo}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.codprotocolo}">${fila.descripcion}</option>
                        </c:otherwise>
                      </c:choose>
                    </jsp2:forEach>
                  </select>
                </span></span></td>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">Manual Actividad</strong></td>
                <td><span class="sinBgDescTablas" style="width: 20%"><span class="sinBgDescTablas" style="width: 20%">
                <select name="codmanualactividad" id="codmanualactividad" style="width: 150px" tabindex="10">
                  <option id="codmanualactividad" value=""></option>
                  <sql:query var="r" sql="select codmanualactividad, descripcion from manualactividad" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                    <c:choose>
                      <c:when test='${fila.codmanualactividad == codmanualactividad}'>
                        <option value="${fila.codmanualactividad}" selected="selected">${fila.descripcion}</option>
                      </c:when>
                      <c:otherwise>
                        <option value="${fila.codmanualactividad}">${fila.descripcion}</option>
                      </c:otherwise>
                    </c:choose>
                  </jsp2:forEach>
                </select>
                </span></span></td>
              </tr>
              <tr>
                <td colspan="6" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>Nivel Complejidad</strong></td>
                <td><span class="sinBgDescTablas" style="width: 20%">
                  <select name="codnivelcomplejidad" id="codnivelcomplejidad" style="width: 150px" tabindex="11">
                    <option id="codnivelcomplejidad" value=""></option>
                    <sql:query var="r" sql="select codnivelcomplejidad, descripcion from nivelcomplejidad" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.codnivelcomplejidad == codnivelcomplejidad}'>
                          <option value="${fila.codnivelcomplejidad}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.codnivelcomplejidad}">${fila.descripcion}</option>
                        </c:otherwise>
                      </c:choose>
                    </jsp2:forEach>
                  </select>
                </span></td>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">C&oacute;digo RIPS</strong></td>
                <td><label>
                  <input name="codigorips" type="text" id="codigorips" value="${codigorips}" size="20" maxlength="10" onKeyPress="javascript:return permite(event, 'num_car_cod')" tabindex="12">
                </label></td>
              </tr>
              <tr>
                <td colspan="6" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>Costo</strong></td>
                <td><label>
                  <input name="costo" type="text" id="costo" value="${costo}" size="20" maxlength="15" onKeyPress="javascript:return permite(event, 'numd')" tabindex="13">
                </label></td>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">Cantidad Max. Autorizar</strong></td>
                <td><label>
                  <input name="cantidadmaxautorizar" type="text" id="cantidadmaxautorizar" value="${cantidadmaxautorizar}" size="20" maxlength="8" onKeyPress="javascript:return permite(event, 'nume')" tabindex="14">
                </label></td>
              </tr>
              <tr>
                <td colspan="6" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>Resultado Final</strong></td>
                <td class="bgDescTablas"><c:choose>
                            <c:when test = '${resultadofinal == "S"}'>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="resultadofinal" value="S" id="resultadofinal_0" checked="true" tabindex="15"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="resultadofinal" value="N" id="resultadofinal_1" tabindex="15"/>
                                    </span>                                </label>
                            </c:when>
                            <c:otherwise>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="resultadofinal" value="S" id="resultadofinal_0" tabindex="15"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="resultadofinal" value="N" id="resultadofinal_1" checked="true" tabindex="15"/>
                                    </span>                                </label>
                            </c:otherwise>
                </c:choose></td>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">C&oacute;digo Barras</strong></td>
                <td><label>
                  <input name="codigobarras" type="text" id="codigobarras" value="${codigobarras}" size="20" maxlength="70" onKeyPress="javascript:return permite(event, 'num_car_cod')" tabindex="16">
                </label></td>
              </tr>
              <tr>
                <td colspan="6" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>Permite Hombre</strong></td>
                <td class="bgDescTablas"><c:choose>
                            <c:when test = '${permitehombre == "S"}'>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="permitehombre" value="S" id="permitehombre_0" checked="true" tabindex="17"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="permitehombre" value="N" id="permitehombre_1" tabindex="17"/>
                                    </span>                                </label>
                            </c:when>
                            <c:otherwise>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="permitehombre" value="S" id="permitehombre_0" tabindex="17"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="permitehombre" value="N" id="permitehombre_1" checked="true" tabindex="17"/>
                                    </span>                                </label>
                            </c:otherwise>
                </c:choose></td>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">Permite Mujer</strong></td>
                <td class="bgDescTablas"><c:choose>
                            <c:when test = '${permitemujer == "S"}'>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="permitemujer" value="S" id="permitemujer_0" checked="true" tabindex="18"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="permitemujer" value="N" id="permitemujer_1" tabindex="18"/>
                                    </span>                                </label>
                            </c:when>
                            <c:otherwise>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="permitemujer" value="S" id="permitemujer_0" tabindex="18"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="permitemujer" value="N" id="permitemujer_1" checked="true" tabindex="18"/>
                                    </span>                                </label>
                            </c:otherwise>
                </c:choose></td>
              </tr>
              <tr>
                <td colspan="6" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>Tiempo Aproximado Ejecuci&oacute;n</strong></td>
                <td><label>
                  <input name="tiempoaprox" type="text" id="tiempoaprox" value="${tiempoaprox}" size="20" maxlength="4" onKeyPress="javascript:return permite(event, 'nume')" tabindex="19">
                </label></td>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">Tarifa en SMLV</strong></td>
                <td><label>
                <input name="tarifasmlv" type="text" id="tarifasmlv" value="${tarifasmlv}" size="20" maxlength="15" onKeyPress="javascript:return permite(event, 'numd')" tabindex="20">
                </label></td>
              </tr>
              <tr>
                <td colspan="6" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>Cantidad UVR </strong></td>
                <td colspan="4"><label>
                  <input name="cantidaduvr" type="text" id="cantidaduvr" value="${cantidaduvr}" size="20" maxlength="4" onKeyPress="javascript:return permite(event, 'nume')" tabindex="21">
                </label></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td colspan="6"><p align="center"><strong class="bgDescTablas">Descripci&oacute;n</strong></p>
                  <p align="center">
                    <label>
                    <input name="descripcion" type="text" id="descripcion" value="${descripcion}" size="75" maxlength="40" onKeyPress="javascript:return permite(event, 'com')" tabindex="22">
                    </label>
                  </p></td>
              </tr>
              <tr>
                <td colspan="6"><p align="center" class="bgDescTablas"><strong>Observaciones</strong></p>
                <p align="center">
                  <label>
                  <textarea name="observacion" id="observacion" cols="75" rows="3" onKeyPress="javascript:return permite(event, 'com')" tabindex="23">${observacion}</textarea>
                  </label>
                </p></td>
              </tr>
              <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="llave" id="llave" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="27"> -->
		  <label>&nbsp;</label>
                  <!--<input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="24"/>
                  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="25"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="26"/> -->
                  <jsp:include page="../BarraNavegacion.jsp?tabBuscar=17&tabGuardar=14&tabEditar=15&tabEliminar=16" />
               </div>            </td>
           </tr>
          </table>
        </form>
        </center>
        
    </td>
</tr>
<tr>
    <td>
        <jsp:include page="../footer.jsp" /> </td>
</tr>

</table>
</center>
<!-- End ImageReady Slices -->
<script>
    //funciones control
    function accion(x)
    {        
        if(validar(arrayNonulos, arrayNumerosEnteros, arrayCombos, arrayCadenasANCod, arrayCadenasA, arrayComentarios, arrayNumerosDoubles))
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
        llaves = 'codactividadsalud='+document.getElementById('codactividadsalud').value;
        validarLlave('actividadsalud',llaves);
    } 
    
    //
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=actividadsalud&";
        url = url + "campos=codactividadsalud,descripcion,codgrupoactividad,codigoalterno,codigorips,costo,cantidadmaxautorizar,resultadofinal&";
        url = url + "campoLlave=codactividadsalud";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>