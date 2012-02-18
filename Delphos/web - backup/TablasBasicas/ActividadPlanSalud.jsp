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
            var cajas = new Array('edadinicials','edadfinal','costo','cantmaxautorizar','cantidadenperiodo','observacion','codalterno');
            var combos = new Array('codplansaluds','codactividadsaluds','codunidmedidaedadinis','codunidmedidaedadfin','codtipoperiodo');
            
            //validar
            var arrayNonulos               	= new Array('edadinicials');
            var arrayNumerosEnteros        	= new Array('edadinicials','edadfinal','cantmaxautorizar','cantidadenperiodo');
            var arrayCombos               	= new Array('codplansaluds','codactividadsaluds','codunidmedidaedadinis','codunidmedidaedadfin','codtipoperiodo');
            var arrayCadenasANCod          	= new Array('codalterno');
            var arrayCadenasA              	= null;
            var arrayComentarios           	= new Array('observacion');
            var arrayNumerosDoubles        	= new Array('costo');
            
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
            <c:if test='${param.codplansalud != null && param.codactividadsalud != null && param.codunidmedidaedadini != null && param.edadinicial != null && param.codplansalud != "" && param.codactividadsalud != "" && param.codunidmedidaedadini != "" && param.edadinicial != ""}'>
            <sql:query var="r" sql="SELECT * FROM actividadplansalud WHERE codplansalud=${param.codplansalud} AND codactividadsalud=${param.codactividadsalud} AND codunidmedidaedadini=${param.codunidmedidaedadini} AND edadinicial=${param.edadinicial}" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codplansaludf" value="${fila.codplansalud}"/>
              <c:set var="codactividadsaludf" value="${fila.codactividadsalud}"/>
              <c:set var="codunidmedidaedadinif" value="${fila.codunidmedidaedadini}"/>
              <c:set var="edadinicialf" value="${fila.edadinicial}"/>             
              <c:set var="codunidmedidaedadfin" value="${fila.codunidmedidaedadfin}"/>
              <c:set var="edadfinal" value="${fila.edadfinal}"/>
              <c:set var="observacion" value="${fila.observacion}"/>              
              <c:set var="codalterno" value="${fila.codalterno}"/>              
              <c:set var="costo" value="${fila.costo}"/>
              <c:set var="cantmaxautorizar" value="${fila.cantmaxautorizar}"/>
              <c:set var="codtipoperiodo" value="${fila.codtipoperiodo}"/>
              <c:set var="incluyetodoenperiodo" value="${fila.incluyetodoenperiodo}"/>
              <c:set var="cantidadenperiodo" value="${fila.cantidadenperiodo}"/>
            </jsp2:forEach>
            <form name="formulario" id="formulario" method="post" action="ActividadPlanSalud.jsp">
            <table width="811" border="0" class="tablaContenido">
              <span id="mensajeControlador">${msj}</span>
              <tr>
                <td colspan="6"><div align="center" class="titulo1">Actividad Plan Salud</div></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td width="25">&nbsp;</td>
                <td><span class="bgDescTablas"><strong>C&oacute;digo Plan Salud</strong></span></td>
                <td width="160"><select name="codplansaluds" id="codplansaluds" style="width: 150px" tabindex="1">
                  <option id="codplansaluds" value=""></option>
                  <sql:query var="r" sql="select codplansalud, descripcion from plansalud" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                    <c:choose>
                      <c:when test='${fila.codplansalud == codplansaludf}'>
                        <option value="${fila.codplansalud}" selected="selected">${fila.descripcion}</option>
                      </c:when>
                      <c:otherwise>
                        <option value="${fila.codplansalud}">${fila.descripcion}</option>
                      </c:otherwise>
                    </c:choose>
                  </jsp2:forEach>
                </select></td>
                <td width="12">&nbsp;</td>
                <td width="128"><strong class="bgDescTablas">C&oacute;digo Alterno</strong></td>
                <td width="167"><label>
                  <input name="codalterno" type="text" id="codalterno" value="${codalterno}" size="20" maxlength="15" onKeyPress="javascript:return permite(event, 'num_car_cod')" tabindex="2">
                </label></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td width="25">&nbsp;</td>
                <td width="150"><span class="bgDescTablas"><strong>Actividad Salud</strong></span></td>
                <td colspan="4">
                <select name="codactividadsaluds" id="codactividadsaluds" style="width: 150px" tabindex="3">
                  <option id="codactividadsaluds" value=""></option>
                  <sql:query var="r" sql="select codactividadsalud, descripcion from actividadsalud" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                    <c:choose>
                      <c:when test='${fila.codactividadsalud == codactividadsaludf}'>
                        <option value="${fila.codactividadsalud}" selected="selected">${fila.descripcion}</option>
                      </c:when>
                      <c:otherwise>
                        <option value="${fila.codactividadsalud}">${fila.descripcion}</option>
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
                <td><span class="bgDescTablas" style="width: 7%"><strong>Edad Inicial</strong></span></td>
                <td><span class="sinBgDescTablas" style="width: 20%">
                  <label>
                  <input name="edadinicials" type="text" id="edadinicials" value="${edadinicialf}" size="20" maxlength="3" onKeyPress="javascript:return permite(event, 'nume')" tabindex="4">
                  </label>
                </span></td>
                <td>&nbsp;</td>
                <td><span class="bgDescTablas"><strong>Unidad Medida Inicial</strong></span></td>
                <td class="sinBgDescTablas">
                  <label><span class="sinBgDescTablas" style="width: 20%">
                  <select name="codunidmedidaedadinis" id="codunidmedidaedadinis" style="width: 150px" tabindex="5">
                    <option id="codunidmedidaedadinis" value=""></option>
                    <sql:query var="r" sql="select codunidmedidaedad, descripcion from unidadmedidaedad" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.codunidmedidaedad == codunidmedidaedadinif}'>
                          <option value="${fila.codunidmedidaedad}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.codunidmedidaedad}">${fila.descripcion}</option>
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
                <td><span class="bgDescTablas"><strong>Edad Final</strong></span></td>
                <td><label>
                  <input name="edadfinal" type="text" id="edadfinal" value="${edadfinal}" size="20" maxlength="3" onKeyPress="javascript:return permite(event, 'nume')" tabindex="6">
                </label></td>
                <td>&nbsp;</td>
                <td class="bgDescTablas"><strong>Unidad Medida Final</strong></td>
                <td><span class="sinBgDescTablas" style="width: 20%">
                  <select name="codunidmedidaedadfin" id="codunidmedidaedadfin" style="width: 150px" tabindex="7">
                    <option id="codunidmedidaedadfin" value=""></option>
                    <sql:query var="r" sql="select codunidmedidaedad, descripcion from unidadmedidaedad" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.codunidmedidaedad == codunidmedidaedadfin}'>
                          <option value="${fila.codunidmedidaedad}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.codunidmedidaedad}">${fila.descripcion}</option>
                        </c:otherwise>
                      </c:choose>
                    </jsp2:forEach>
                  </select>
                </span></td>
              </tr>
              <tr>
                <td colspan="6" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>Costo</strong></td>
                <td><label>
                  <input name="costo" type="text" id="costo" value="${costo}" size="20" maxlength="15" onKeyPress="javascript:return permite(event, 'numd')" tabindex="8">
                </label></td>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">Cantidad Max. Utilizar</strong></td>
                <td class="bgDescTablas">
                <label>
                <input name="cantmaxautorizar" type="text" id="cantmaxautorizar" value="${cantmaxautorizar}" size="20" maxlength="6" onKeyPress="javascript:return permite(event, 'nume')" tabindex="9">
                </label></td>
              </tr>
              <tr>
                <td colspan="6" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>Tipo Periodo</strong></td>
                <td class="bgDescTablas">
                            <span class="sinBgDescTablas" style="width: 20%">
                            <select name="codtipoperiodo" id="codtipoperiodo" style="width: 150px" tabindex="10">
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
                </span></td>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">Incluye todas las actividades</strong></td>
                <td class="bgDescTablas"><c:choose>
                            <c:when test = '${incluyetodoenperiodo == "S"}'>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="incluyetodoenperiodo" value="S" id="incluyetodoenperiodo_0" checked="true" tabindex="11"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="incluyetodoenperiodo" value="N" id="incluyetodoenperiodo_1" tabindex="11"/>
                                    </span>                                </label>
                            </c:when>
                            <c:otherwise>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="incluyetodoenperiodo" value="S" id="incluyetodoenperiodo_0" tabindex="11"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="incluyetodoenperiodo" value="N" id="incluyetodoenperiodo_1" checked="true" tabindex="11"/>
                                    </span>                                </label>
                            </c:otherwise>
                        </c:choose></td>
              </tr>
              <tr>
                <td colspan="6" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>Cantidad</strong></td>
                <td colspan="4" class="bgDescTablas">
                                <input name="cantidadenperiodo" type="text" id="cantidadenperiodo" value="${cantidadenperiodo}" size="20" maxlength="6" onKeyPress="javascript:return permite(event, 'nume')" tabindex="12">                                </td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td colspan="6"><p align="center"><strong class="bgDescTablas">Observaciones</strong></p>
                  <p align="center">
                    <label>
                    <textarea name="observacion" cols="75" rows="3" id="observacion" onKeyPress="javascript:return permite(event, 'com')" tabindex="13">${observacion}</textarea>
                    </label>
                  </p></td>
              </tr>
              <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="codplansalud" id="codplansalud" value="" >
                  <input type="hidden" name="codactividadsalud" id="codactividadsalud" value="" >
                  <input type="hidden" name="codunidmedidaedadini" id="codunidmedidaedadini" value="" >
                  <input type="hidden" name="edadinicial" id="edadinicial" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="17"> -->
		  <label>&nbsp;</label>
		  <!--<input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="14"/>
		  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="15"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="16"/> -->
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
        <jsp:include page="../footer.jsp" />  </td>
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
        llaves = 'codplansalud='+document.getElementById('codplansaluds').value+',';
        llaves+= 'codactividadsalud='+document.getElementById('codactividadsaluds').value+',';
        llaves+= 'codunidmedidaedadini='+document.getElementById('codunidmedidaedadinis').value+',';
        llaves+= 'edadinicial='+document.getElementById('edadinicials').value;
        validarLlave('actividadplansalud',llaves);
    } 
    
    //
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=actividadplansalud&";
        url = url + "campos=codplansalud,codactividadsalud,codunidmedidaedadini,edadinicial,codunidmedidaedadfin,edadfinal,observacion,codalterno&";
        url = url + "campoLlave=codplansalud,codactividadsalud,codunidmedidaedadini,edadinicial";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>