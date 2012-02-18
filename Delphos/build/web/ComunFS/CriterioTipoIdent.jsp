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
<head><script type="text/javascript" src="../js/jquery/jquery.js"></script>
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
        
        <script type="text/javascript" src="../js/pestanas/animatedcollapse.js"></script>
        <script type="text/javascript" src="../js/validaciones/validador.js"></script>
        <script type="text/javascript" src="../js/validaciones/validadorkp.js"></script>
        <script type="text/javascript" src="../js/validaciones/validadorcontrol.js"></script>
        <script type="text/javascript">
            
            
            //totalidad de elementos en el form
            var cajas = new Array('consecutivos','edadinicial','edadfinal','longmaxident','descripcion','observacion');
            var combos = new Array('codtipoidentidads');
            
            //validar
            var arrayNonulos               	= new Array('consecutivos');
            var arrayNumerosEnteros        	= new Array('consecutivos','edadinicial','edadfinal','longmaxident');
            var arrayCombos               	= new Array('codtipoidentidads');
            var arrayCadenasANCod          	= null;
            var arrayCadenasA              	= null;
            var arrayComentarios           	= new Array ('descripcion','observacion');
            var arrayNumerosDoubles             = null;
            
	</script></head>
<body bgcolor="#FFFFFF" onLoad="borrarMensaje(combos[0]);">
<!-- ImageReady Slices (panel.psd) -->

<center>
<table id="Table_01" width="906" style="height: 780; border: 0px" cellpadding="0" cellspacing="0">
<tr>
    <td colspan="3">
        <jsp:include page="../header.jsp" />
    </td>
</tr>
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
            <c:if test='${param.codtipoidentidad != null && param.consecutivo !=null && param.consecutivo !=""}'>
            <sql:query var="r" sql="SELECT * FROM criteriotipoident WHERE codtipoidentidad='${param.codtipoidentidad}' AND consecutivo=${param.consecutivo}" dataSource="jdbc/delphos" scope="page"/>
            
        </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codtipoidentidadf" value="${fila.codtipoidentidad}"/>
              <c:set var="consecutivof" value="${fila.consecutivo}"/>
              <c:set var="descripcion" value="${fila.descripcion}"/>   
              <c:set var="edadinicial" value="${fila.edadinicial}"/>
              <c:set var="edadfinal" value="${fila.edadfinal}"/>
              <c:set var="aplicahombre" value="${fila.aplicahombre}"/>
              <c:set var="aplicamujer" value="${fila.aplicamujer}"/>
              <c:set var="longmaxident" value="${fila.longmaxident}"/>
              <c:set var="observacion" value="${fila.observacion}"/>     
</jsp2:forEach>
                
                <table width="849" border="0" class="tablaContenido">
		<form name="formulario" id="formulario" method="post" action="CriterioTipoIdent.jsp">
                  <span id="mensajeControlador">${msj}</span>
                  <tr>
                    <td colspan="6"><div align="center" class="titulo1">Critero Tipo Identificaci&oacute;n</div></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="30" class="bgDescTablas">&nbsp;</td>
                    <td width="177" class="bgDescTablas"><strong>Tipo Identificaci&oacute;n</strong></td>
                    <td width="153" class="bgDescTablas"><label>
                    <select name="codtipoidentidads" id="codtipoidentidads" style="width: 150px" tabindex="1">
                          <option id="codtipoidentidads" value=""></option>
                          <sql:query var="r" sql="select codtipoidentidad, descripcion from tipoidentificacion" dataSource="jdbc/delphos" scope="page"/>
                          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                           <c:choose>
                                <c:when test='${fila.codtipoidentidad == codtipoidentidadf}'>
                                <option value="${fila.codtipoidentidad}" selected="selected">${fila.descripcion}</option>
                                </c:when>
                            <c:otherwise>
                                <option value="${fila.codtipoidentidad}">${fila.descripcion}</option>
                            </c:otherwise>
                           </c:choose>
                         </jsp2:forEach>
                    </select>
                    </label></td>
                    <td width="23" class="bgDescTablas">&nbsp;</td>
                    <td width="129" class="bgDescTablas"><strong>Consecutivo</strong></td>
                    <td width="164" class="bgDescTablas"><label>
                      <input name="consecutivos" type="text" id="consecutivos" value="${consecutivof}" size="20" maxlength="4" onkeypress="javascript:return permite(event, 'nume')" tabindex="2"/>
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Edad Inicial</strong></td>
                    <td class="bgDescTablas"><label>
                    <input name="edadinicial" type="text" id="edadinicial" value="${edadinicial}" size="20" maxlength="4" onkeypress="javascript:return permite(event, 'nume')" tabindex="3"/>
                    </label></td>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Edad Final</strong></td>
                    <td class="bgDescTablas"><label>
                    <input name="edadfinal" type="text" id="edadfinal" value="${edadfinal}" size="20" maxlength="4" onkeypress="javascript:return permite(event, 'nume')" tabindex="4"/>
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Aplica Hombre</strong></td>
                    <td class="bgDescTablas">
                          <c:choose>
                            <c:when test = '${aplicahombre == "S"}'>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="aplicahombre" value="S" id="aplicahombre_0" checked="true" tabindex="5"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="aplicahombre" value="N" id="aplicahombre_1" tabindex="5"/>
                                    </span>                                </label>
                            </c:when>
                            <c:otherwise>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="aplicahombre" value="S" id="aplicahombre_0" tabindex="5"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="aplicahombre" value="N" id="aplicahombre_1" checked="true" tabindex="5"/>
                                    </span>                                </label>
                            </c:otherwise>
                        </c:choose>					</td>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Aplica Mujer</strong></td>
                    <td class="bgDescTablas">
                     <c:choose>
                        <c:when test = '${aplicamujer == "S"}'>
                            <label>
                                <span class="descCampoForm">Si
                                    <input type="radio" name="aplicamujer" value="S" id="aplicamujer_0" checked="true" tabindex="6"/>
                                </span>                            </label> 
                            <label>
                                <span class="descCampoForm">No
                                    <input type="radio" name="aplicamujer" value="N" id="aplicamujer_1" tabindex="6"/>
                                </span>                            </label>
                        </c:when>
                        <c:otherwise>
                            <label>
                                <span class="descCampoForm">Si
                                    <input type="radio" name="aplicamujer" value="S" id="aplicamujer_0" tabindex="6"/>
                                </span>                            </label> 
                            <label>
                                <span class="descCampoForm">No
                                    <input type="radio" name="aplicamujer" value="N" id="aplicamujer_1" checked="true" tabindex="6"/>
                                </span>                            </label>
                        </c:otherwise>
                    </c:choose>					</td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Longitud Maxima Identificaci&oacute;n</strong></td>
                    <td colspan="4" class="bgDescTablas"><label>
                      <input name="longmaxident" type="text" id="longmaxident" value="${longmaxident}" size="20" maxlength="2" onkeypress="javascript:return permite(event, 'nume')" tabindex="7"/>
                    </label></td>
              </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas"><p align="center"><strong>Descripci&oacute;n</strong></p>
                      <p align="center">
                        <input name="descripcion" type="text" id="descripcion" value="${descripcion}" size="75" maxlength="60" onkeypress="javascript:return permite(event, 'com')" tabindex="8"/>
                      </p></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas"><p align="center"><strong>Observaciones</strong></p>
                    <p align="center">
                      <textarea name="observacion" id="observacion" cols="75" rows="3" onkeypress="javascript:return permite(event, 'com')" tabindex="9">${observacion}</textarea>
                    </p></td>
                  </tr>
                <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="codtipoidentidad" id="codtipoidentidad" value="" >
                  <input type="hidden" name="consecutivo" id="consecutivo" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="13"> -->
		  <label>&nbsp;</label>
                  <!--<input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="10"/>
                  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="11"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="12"/> -->
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
        <jsp:include page="../footer.jsp" />   </td>
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
        llaves = 'codtipoidentidad='+document.getElementById('codtipoidentidads').value+',';
	llaves+= 'consecutivo='+document.getElementById('consecutivos').value;
        validarLlave('criteriotipoident',llaves);
    } 
    
    //
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=criteriotipoident&";
        url = url + "campos=codtipoidentidad,consecutivo,descripcion,edadinicial,edadfinal,aplicahombre,aplicamujer,longmaxident&";
        url = url + "campoLlave=codtipoidentidad,consecutivo";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>