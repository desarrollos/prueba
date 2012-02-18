<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<%@ taglib prefix="jsp2" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%
clases.VerificarUsuarioSistema v;
v = new clases.VerificarUsuarioSistema(request,response);
%>

<html xmlns="http://www.w3.org/1999/xhtml">
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
            var cajas = new Array('codtipoturno','descripcion');
            var combos = new Array('hinicial','hinicialmin','hfinal','hfinalmin');
            
            //validar
            var arrayNonulos               	= new Array ('codtipoturno');
            var arrayNumerosEnteros        	= null;
            var arrayCombos               	= new Array ('hinicial','hinicialmin','hfinal','hfinalmin');
            var arrayCadenasANCod          	= new Array ('codtipoturno');
            var arrayCadenasA              	= null;
            var arrayComentarios           	= new Array ('descripcion');
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
</tr>
<%-- Datos sesion --%>

<%-- Datos sesion --%>
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
            <c:if test="${param.llave != null}">
            <sql:query var="r" sql="SELECT * FROM tipoturno WHERE codtipoturno='${param.llave}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codtipoturno" value="${fila.codtipoturno}"/>
              <c:set var="descripcion" value="${fila.descripcion}"/>
              <c:set var="horainicial" value="${fila.horainicial}"/> 
              <c:set var="horafinal" value="${fila.horafinal}"/>            
            </jsp2:forEach>
                
                <table width="801" border="0" class="tablaContenido">
		<form name="formulario" id="formulario" method="post" action="TipoTurno.jsp">
                  <span id="mensajeControlador">${msj}</span>
                  <tr>
                    <td colspan="6"><div align="center" class="titulo1">Tipo Turno</div></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>C&oacute;digo Tipo Turno</strong>
                      <label></label>                      <label></label></td>
                    <td colspan="4" class="bgDescTablas"><input name="codtipoturno" type="text" id="codtipoturno" value="${codtipoturno}" size="20" maxlength="6" onkeypress="javascript:return permite(event, 'num_car_cod')" tabindex="1"/></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="28" class="bgDescTablas">&nbsp;</td>
                    <td width="130" class="bgDescTablas"><strong>Hora Inicial</strong></td>
                    <td width="144" class="bgDescTablas"><label>
                      <select name="hinicial" id="hinicial" tabindex="2">
                          
                          <c:forEach begin="0" end="23" step="1" var="hour" varStatus="status">
                              <c:choose>
                                  <c:when test="${(status.count-1) == 0}">
                                      <c:choose>
                                        <c:when test="${(status.count-1) == fn:substring(horainicial, 0, 2)}">
                                            <option value="00" selected>00</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="00">00</option>
                                        </c:otherwise>
                                    </c:choose>
                                  </c:when>
                                  <c:when test="${(status.count-1) >= 1 && (status.count-1) <= 9}">
                                    <c:choose>
                                        
                                        <c:when test="${(status.count-1) == fn:substring(horainicial, 0, 2)}">
                                            <option value="${fn:substring(horainicial, 0, 2)}" selected>${fn:substring(horainicial, 0, 2)}</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="0${status.count-1}">0${status.count-1}</option>
                                        </c:otherwise>
                                    </c:choose>
                                    
                                </c:when>
                                <c:otherwise>
                                    <c:choose>
                                        <c:when test="${(status.count-1) == fn:substring(horainicial, 0, 2)}">
                                            <option value="${(status.count-1)}" selected>${(status.count-1)}</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="${status.count-1}">${status.count-1}</option>
                                        </c:otherwise>
                                    </c:choose>
                                </c:otherwise>
                              </c:choose>
                            </c:forEach>                     
                        
                    </select>
                    </label>
                      :
                      <label>
                      <select name="hinicialmin" id="hinicialmin" tabindex="3">
                        <c:forEach begin="0" end="59" step="1" var="hour" varStatus="status">
                              <c:choose>
                                  <c:when test="${(status.count-1) == 0}">
                                      <c:choose>
                                        <c:when test="${(status.count-1) == fn:substring(horainicial, 3, 5)}">
                                            <option value="00" selected>00</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="00">00</option>
                                        </c:otherwise>
                                    </c:choose>
                                  </c:when>
                                  <c:when test="${(status.count-1) >= 1 && (status.count-1) <= 9}">
                                    <c:choose>
                                        
                                        <c:when test="${(status.count-1) == fn:substring(horainicial, 3, 5)}">
                                            <option value="${fn:substring(horainicial, 3, 5)}" selected>${fn:substring(horainicial, 3, 5)}</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="0${status.count-1}">0${status.count-1}</option>
                                        </c:otherwise>
                                    </c:choose>
                                    
                                </c:when>
                                <c:otherwise>
                                    <c:choose>
                                        <c:when test="${(status.count-1) == fn:substring(horainicial, 3, 5)}">
                                            <option value="${(status.count-1)}" selected>${(status.count-1)}</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="${status.count-1}">${status.count-1}</option>
                                        </c:otherwise>
                                    </c:choose>
                                </c:otherwise>
                              </c:choose>
                            </c:forEach>                   
                        </select>
                      </label></td>
                    <td width="24" class="bgDescTablas">&nbsp;</td>
                    <td width="130" class="bgDescTablas"><strong>Hora Final</strong></td>
                    <td width="186" class="bgDescTablas"><label>
                      <select name="hfinal" id="hfinal" tabindex="4">
                        
                          <c:forEach begin="0" end="23" step="1" var="hour" varStatus="status">
                              <c:choose>
                                  <c:when test="${(status.count-1) == 0}">
                                      <c:choose>
                                        <c:when test="${(status.count-1) == fn:substring(horafinal, 0, 2)}">
                                            <option value="00" selected>00</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="00">00</option>
                                        </c:otherwise>
                                    </c:choose>
                                  </c:when>
                                  <c:when test="${(status.count-1) >= 1 && (status.count-1) <= 9}">
                                    <c:choose>
                                        
                                        <c:when test="${(status.count-1) == fn:substring(horafinal, 0, 2)}">
                                            <option value="${fn:substring(horafinal, 0, 2)}" selected>${fn:substring(horafinal, 0, 2)}</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="0${status.count-1}">0${status.count-1}</option>
                                        </c:otherwise>
                                    </c:choose>
                                    
                                </c:when>
                                <c:otherwise>
                                    <c:choose>
                                        <c:when test="${(status.count-1) == fn:substring(horafinal, 0, 2)}">
                                            <option value="${(status.count-1)}" selected>${(status.count-1)}</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="${status.count-1}">${status.count-1}</option>
                                        </c:otherwise>
                                    </c:choose>
                                </c:otherwise>
                              </c:choose>
                            </c:forEach> 
                      </select>
                    </label>
                    :
                    <label>
                    <select name="hfinalmin" id="hfinalmin" tabindex="5">
                        <c:forEach begin="0" end="59" step="1" var="hour" varStatus="status">
                              <c:choose>
                                  <c:when test="${(status.count-1) == 0}">
                                      <c:choose>
                                        <c:when test="${(status.count-1) == fn:substring(horafinal, 3, 5)}">
                                            <option value="00" selected>00</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="00">00</option>
                                        </c:otherwise>
                                    </c:choose>
                                  </c:when>
                                  <c:when test="${(status.count-1) >= 1 && (status.count-1) <= 9}">
                                    <c:choose>
                                        
                                        <c:when test="${(status.count-1) == fn:substring(horafinal, 3, 5)}">
                                            <option value="${fn:substring(horafinal, 3, 5)}" selected>${fn:substring(horafinal, 3, 5)}</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="0${status.count-1}">0${status.count-1}</option>
                                        </c:otherwise>
                                    </c:choose>
                                    
                                </c:when>
                                <c:otherwise>
                                    <c:choose>
                                        <c:when test="${(status.count-1) == fn:substring(horafinal, 3, 5)}">
                                            <option value="${(status.count-1)}" selected>${(status.count-1)}</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="${status.count-1}">${status.count-1}</option>
                                        </c:otherwise>
                                    </c:choose>
                                </c:otherwise>
                              </c:choose>
                            </c:forEach>
                    </select>
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas"><p align="center"><strong>Descripci&oacute;n</strong></p>
                    <p align="center">
                      <input name="descripcion" type="text" id="descripcion" value="${descripcion}" size="75" maxlength="50" onkeypress="javascript:return permite(event, 'com')" tabindex="6"/>
                    </p></td>
                  </tr>
                <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="llave" id="llave" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="10">-->
		  <label>&nbsp;</label>
                  <!--<input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="7"/>
                  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="8"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="9"/>-->
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
        <jsp:include page="../footer.jsp" />
	</td>
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
        llaves = 'codtipoturno='+document.getElementById('codtipoturno').value;
        //llaves+= 'codmunicipio='+document.getElementById('codmunicipio').value+',';
        validarLlave('tipoturno',llaves);
    } 
    
    //
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=tipoturno&";
        url = url + "campos=codtipoturno,descripcion,horainicial,horafinal&";
        url = url + "campoLlave=codtipoturno";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>