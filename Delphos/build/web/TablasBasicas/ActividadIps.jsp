<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<%@ taglib prefix="jsp2" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

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
        <script type="text/javascript" src="../js/formsAJAX/fomularioAjax.js"></script>
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
            var cajas = new Array('anyoinicials','cantidad','anyofinal');
            var combos = new Array('codgrupoactividads','mesinicials','codtipoperiodo','mesfinal');
            
            //validar
            var arrayNonulos               	= new Array('anyoinicials');
            var arrayNumerosEnteros        	= new Array('anyoinicials' ,'cantidad','anyofinal','mesfinal');
            var arrayCombos               	= new Array('mesinicials','codgrupoactividads','codtipoperiodo');
            var arrayCadenasANCod          	= null;
            var arrayCadenasA              	= null;
            var arrayComentarios           	= null;
            var arrayNumerosDoubles             = null;
            
	</script>
</head>
<body bgcolor="#FFFFFF" onLoad="borrarMensaje(cajas[0]);">
<center>
<table id="Table_01" width="906" style="height: 780; border: 0px" cellpadding="0" cellspacing="0">

<tr>
    <td colspan="3">
        <jsp:include page="../header.jsp" />
    </td>
<tr>
    <td style="background: url('../images/back.png')" width="234" valign="top">
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
            <c:if test='${param.codgrupoactividad != null && param.anyoinicial != null && param.mesinicial != null && param.codgrupoactividad != "" && param.anyoinicial != "" && param.mesinicial != ""}'>
            <sql:query var="r" sql="SELECT * FROM actividadips WHERE codgrupoactividad=${param.codgrupoactividad} AND anyoinicial=${param.anyoinicial} AND mesinicial=${param.mesinicial}" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codgrupoactividadf" value="${fila.codgrupoactividad}"/>
              <c:set var="anyoinicialf" value="${fila.anyoinicial}"/>  
              <c:set var="mesinicialf" value="${fila.mesinicial}"/>  
              <c:set var="cantidad" value="${fila.cantidad}"/>  
              <c:set var="codtipoperiodo" value="${fila.codtipoperiodo}"/>  
              <c:set var="anyofinal" value="${fila.anyofinal}"/>  
              <c:set var="mesfinal" value="${fila.mesfinal}"/>         
            </jsp2:forEach>
                
                <table width="791" border="0" class="tablaContenido">
		<form name="formulario" id="formulario" method="post" action="ActividadIps.jsp">
                  <span id="mensajeControlador">${msj}</span>
                  <tr>
                    <td colspan="6"><div align="center" class="titulo1">Actividad IPS</div></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="30" class="bgDescTablas">&nbsp;</td>
                    <td width="119" class="bgDescTablas"><strong>Grupo Actividad</strong></td>
                    <td colspan="4" class="bgDescTablas"><label>
                      <select name="codgrupoactividads" id="codgrupoactividads" style="width: 150px" tabindex="1">
                           <option id="codgrupoactividads" value=""></option>
                          <sql:query var="r" sql="select codgrupoactividad, descripcion from grupoactividad" dataSource="jdbc/delphos" scope="page"/>
                          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                           <c:choose>
                                <c:when test='${fila.codgrupoactividad == codgrupoactividadf}'>
                                <option value="${fila.codgrupoactividad}" selected="selected">${fila.descripcion}</option>
                                </c:when>
                            <c:otherwise>
                                <option value="${fila.codgrupoactividad}">${fila.descripcion}</option>
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
                    <td class="bgDescTablas"><strong>Mes Inicial</strong></td>
                    <td width="209" class="bgDescTablas"><label>
                    <select name="mesinicials" id="mesinicials" style="width: 150px" tabindex="2">
                      <option id="mesinicials" value=""></option>
                        <c:forEach begin="1" end="12" step="1" var="mes" varStatus="status">
                              <c:choose>                                  
                                  <c:when test="${(status.count) >= 1 && (status.count) <= 9}">
                                    <c:choose>                                        
                                        <c:when test="${(status.count) == mesinicialf}">
                                            <option value="0${mesinicialf}" selected>0${mesinicialf}</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="0${status.count}">0${status.count}</option>
                                        </c:otherwise>
                                    </c:choose>
                                    
                                </c:when>
                                <c:otherwise>
                                    <c:choose>
                                        <c:when test="${(status.count) == mesinicialf}">
                                            <option value="${(status.count)}" selected>${(status.count)}</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="${status.count}">${status.count}</option>
                                        </c:otherwise>
                                    </c:choose>
                                </c:otherwise>
                              </c:choose>
                            </c:forEach>
                    </select>
                    </label></td>
                    <td width="21" class="bgDescTablas">&nbsp;</td>
                    <td width="93" class="bgDescTablas"><strong>A&ntilde;o Inicial</strong></td>
                    <td width="204" class="bgDescTablas"><label>
                      <input name="anyoinicials" type="text" id="anyoinicials" value="${anyoinicialf}" size="20" maxlength="4" onkeypress="javascript:return permite(event, 'nume')" tabindex="3"/>
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Cantidad</strong></td>
                    <td class="bgDescTablas"><label>
                      <input name="cantidad" type="text" id="cantidad" value="${cantidad}" size="20" maxlength="6" onkeypress="javascript:return permite(event, 'nume')"tabindex="4"/>
                    </label></td>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Tipo Periodo</strong></td>
                    <td class="bgDescTablas"><label>
                      <select name="codtipoperiodo" id="codtipoperiodo" style="width: 150px" tabindex="5">
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
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Mes Final</strong></td>
                    <td class="bgDescTablas"><label>
                    <select name="mesfinal" id="mesfinal" style="width: 150px" tabindex="6">
                      <option id="mesfinal" value=""></option>
                        <c:forEach begin="1" end="12" step="1" var="mes" varStatus="status">
                              <c:choose>                                  
                                  <c:when test="${(status.count) >= 1 && (status.count) <= 9}">
                                    <c:choose>                                        
                                        <c:when test="${(status.count) == mesfinal}">
                                            <option value="0${mesfinal}" selected>0${mesfinal}</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="0${status.count}">0${status.count}</option>
                                        </c:otherwise>
                                    </c:choose>
                                    
                                </c:when>
                                <c:otherwise>
                                    <c:choose>
                                        <c:when test="${(status.count) == mesfinal}">
                                            <option value="${(status.count)}" selected>${(status.count)}</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="${status.count}">${status.count}</option>
                                        </c:otherwise>
                                    </c:choose>
                                </c:otherwise>
                              </c:choose>
                            </c:forEach>
                    </select>
                    </label></td>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>A&ntilde;o Final</strong></td>
                    <td class="bgDescTablas"><input name="anyofinal" type="text" id="anyofinal" value="${anyofinal}" size="20" maxlength="4" onkeypress="javascript:return permite(event, 'nume')" tabindex="7"/></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="codgrupoactividad" id="codgrupoactividad" value="" >
                  <input type="hidden" name="anyoinicial" id="anyoinicial" value="" >
                  <input type="hidden" name="mesinicial" id="mesinicial" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="11"> -->
		  <label>&nbsp;</label>
                  <!--<input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="8"/>
                  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="9"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="10"/> -->
                  <jsp:include page="../BarraNavegacion.jsp?tabBuscar=17&tabGuardar=14&tabEditar=15&tabEliminar=16" />
               </div>
            </td>
           </tr>
		    </form>
          </table>
        </center>
        
    </td>
</tr>
<tr>
    <td>
        <jsp:include page="../footer.jsp" />    </td>
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
        llaves = 'codgrupoactividad='+document.getElementById('codgrupoactividads').value+',';
        llaves+= 'anyoinicial='+document.getElementById('anyoinicials').value+',';
	llaves+= 'mesinicial='+document.getElementById('mesinicials').value;
        validarLlave('actividadips',llaves);
    } 
    
    //
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=actividadips&";
        url = url + "campos=codgrupoactividad,anyoinicial,mesinicial,cantidad,codtipoperiodo,anyofinal,mesfinal&";
        url = url + "campoLlave=codgrupoactividad,anyoinicial,mesinicial";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>