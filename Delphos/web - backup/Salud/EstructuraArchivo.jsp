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
            var cajas = new Array('posicionarchivo','separador','posicioninicial','posicionfinal');
            var combos = new Array('codtipoestrucarchs','codcampoarchivos','codtipoentidadsalud');
                      
            //validar
            var arrayNonulos               = null;
            var arrayNumerosEnteros        = new Array('posicionarchivo','posicioninicial','posicionfinal');
            var arrayCombos                = new Array('codtipoestrucarchs','codcampoarchivos','codtipoentidadsalud');
            var arrayCadenasANCod          = new Array('separador');
            var arrayCadenasA              = null;
            var arrayComentarios           = null;
            var arrayNumerosDoubles        = null;
            
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
            <c:if test='${param.codtipoestrucarch != null && param.codcampoarchivo != null && param.codcampoarchivo != ""}'>
            <sql:query var="r" sql="SELECT * FROM estructuraarchivo WHERE codtipoestrucarch='${param.codtipoestrucarch}' AND codcampoarchivo=${param.codcampoarchivo}" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codtipoestrucarchf" value="${fila.codtipoestrucarch}"/>
              <c:set var="codcampoarchivof" value="${fila.codcampoarchivo}"/>
              <c:set var="posicionarchivo" value="${fila.posicionarchivo}"/>
              <c:set var="separador" value="${fila.separador}"/>
              <c:set var="posicioninicial" value="${fila.posicioninicial}"/>              
              <c:set var="posicionfinal" value="${fila.posicionfinal}"/>
              <c:set var="aplicacotizante" value="${fila.aplicacotizante}"/>
              <c:set var="aplicabeneficiario" value="${fila.aplicabeneficiario}"/>
              <c:set var="permitenulo" value="${fila.permitenulo}"/>
              <c:set var="codtipoentidadsalud" value="${fila.codtipoentidadsalud}"/>
            </jsp2:forEach>

                
                <table width="791" border="0" class="tablaContenido">
                 <span id="mensajeControlador">${msj}</span>
				<form action="EstructuraArchivo.jsp" method="post" name="formulario">
                  <tr>
                    <td colspan="6"><div align="center" class="titulo1">Estructura Archivo Detalle</div></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="30" class="bgDescTablas">&nbsp;</td>
                    <td width="118" class="bgDescTablas"><strong>Tipo Estructura Archivo </strong></td>
                    <td width="166" class="sinBgDescTablas"><label>
                      <select name="codtipoestrucarchs" id="codtipoestrucarchs" style="width: 150px">
                        <option id="codtipoestrucarchs" value=""></option>
                          <sql:query var="r" sql="select codtipoestrucarch, descripcion from tipoestructarch" dataSource="jdbc/delphos" scope="page"/>
                        <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                           <c:choose>
                                <c:when test='${fila.codtipoestrucarch == codtipoestrucarchf}'>
                                <option value="${fila.codtipoestrucarch}" selected="selected">${fila.descripcion}</option>
                                </c:when>
                            <c:otherwise>
                                <option value="${fila.codtipoestrucarch}">${fila.descripcion}</option>
                            </c:otherwise>
                           </c:choose>
                        </jsp2:forEach>
                    </select>
                    </label></td>
                    <td width="24">&nbsp;</td>
                    <td width="117" class="bgDescTablas"><strong>Campo Archivo </strong></td>
                    <td width="194" class="sinBgDescTablas"><label>
                      <select name="codcampoarchivos" id="codcampoarchivos" style="width: 150px">
                        <option id="codcampoarchivos" value=""></option>
                          <sql:query var="r" sql="select codcampoarchivo, descripcion from listacamposarchivo" dataSource="jdbc/delphos" scope="page"/>
                        <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                           <c:choose>
                                <c:when test='${fila.codcampoarchivo == codcampoarchivof}'>
                                <option value="${fila.codcampoarchivo}" selected="selected">${fila.descripcion}</option>
                                </c:when>
                            <c:otherwise>
                                <option value="${fila.codcampoarchivo}">${fila.descripcion}</option>
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
                    <td class="bgDescTablas"><span class="sinBgDescTablas"><strong>Posici&oacute;n Archivo </strong></span></td>
                    <td class="sinBgDescTablas"><label>
                      <input name="posicionarchivo" type="text" id="posicionarchivo" value="${posicionarchivo}" size="20" maxlength="3" />
                    </label></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas"><strong>Separador</strong></td>
                    <td class="sinBgDescTablas"><input name="separador" type="text" id="separador" value="${separador}" size="20" maxlength="1" /></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Posici&oacute;n Inicial </strong></td>
                    <td class="sinBgDescTablas"><label>
                      <input name="posicioninicial" type="text" id="posicioninicial" value="${posicioninicial}" size="20" maxlength="3"/>
                    </label></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas"><p><strong>Posici&oacute;n Final </strong></p></td>
                    <td class="sinBgDescTablas">
                      <input name="posicionfinal" type="text" id="posicionfinal" value="${posicionfinal}" size="20" maxlength="3" /></td>
                  </tr>
                  <tr>
                    <td height="21" colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td height="21" class="bgDescTablas"><strong>Aplica Beneficiario</strong></td>
                    <td height="21" class="bgDescTablas"><strong>
                    <label>
                      <c:choose>
                        <c:when test = '${aplicabeneficiario == "S"}'>
                          <label>
                            Si
                          <input type="radio" name="aplicabeneficiario" value="S" id="aplicabeneficiario_0" checked="true"/>
                          </label> 
                          <label>
                            No
                          <input type="radio" name="aplicabeneficiario" value="N" id="aplicabeneficiario_1" />
                          </label>
                        </c:when>
                        <c:otherwise>
                          <label>
                            Si
                          <input type="radio" name="aplicabeneficiario" value="S" id="aplicabeneficiario_0"/>
                          </label> 
                          <label>
                            No
                          <input type="radio" name="aplicabeneficiario" value="N" id="aplicabeneficiario_1" checked="true"/>
                          </label>
                        </c:otherwise>
                      </c:choose>
                    </strong>
                    </label></td>
                    <td height="21" class="bgDescTablas">&nbsp;</td>
                    <td height="21" class="bgDescTablas"><strong>Aplica Cotizante</strong></td>
                    <td height="21" class="bgDescTablas"><strong><label>
                        <c:choose>
                          <c:when test = '${aplicacotizante == "S"}'>
                            <label> Si
                              <input type="radio" name="aplicacotizante" value="S" id="aplicacotizante_0" checked="true"/>
                            </label>
                            <label> No
                              <input type="radio" name="aplicacotizante" value="N" id="aplicacotizante_1" />
                            </label>
                          </c:when>
                          <c:otherwise>
                            <label> Si
                              <input type="radio" name="aplicacotizante" value="S" id="aplicacotizante_0"/>
                            </label>
                            <label> No
                              <input type="radio" name="aplicacotizante" value="N" id="aplicacotizante_1" checked="true"/>
                            </label>
                          </c:otherwise>
                        </c:choose>
                              </strong>
                          </label>                             
                    </td>
                  </tr>
                  <tr>
                    <td height="21" colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td height="27" class="bgDescTablas"><strong>Permite Nulo</strong></td>
                    <td class="sinBgDescTablas"><p class="bgDescTablas"><strong>
                      <c:choose>
                            <c:when test = '${permitenulo == "S"}'>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="permitenulo" value="S" id="permitenulo_0" checked="true"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="permitenulo" value="N" id="permitenulo_1" />
                                    </span>                                </label>
                            </c:when>
                            <c:otherwise>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="permitenulo" value="S" id="permitenulo_0"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="permitenulo" value="N" id="permitenulo_1" checked="true"/>
                                    </span>                                </label>
                            </c:otherwise>
                        </c:choose>
					</strong></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas"><strong>Tipo Entidad Salud </strong></td>
                    <td class="sinBgDescTablas"><label>
                      <select name="codtipoentidadsalud" id="codtipoentidadsalud" style="width: 150px">
                        <option id="codtipoentidadsalud" value=""></option>
                          <sql:query var="r" sql="select codtipoentidadsalud, descripcion from tipoentidadsalud" dataSource="jdbc/delphos" scope="page"/>
                          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                           <c:choose>
                                <c:when test='${fila.codtipoentidadsalud == codtipoentidadsalud}'>
                                <option value="${fila.codtipoentidadsalud}" selected="selected">${fila.descripcion}</option>
                                </c:when>
                            <c:otherwise>
                                <option value="${fila.codtipoentidadsalud}">${fila.descripcion}</option>
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
                <td colspan="6"><div align="center">
                  <input type="hidden" name="codtipoestrucarch" id="codtipoestrucarch" value="" >
                  <input type="hidden" name="codcampoarchivo" id="codcampoarchivo" value="" >
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
        llaves = 'codtipoestrucarch='+document.getElementById('codtipoestrucarchs').value+',';
		llaves+= 'codcampoarchivo='+document.getElementById('codcampoarchivos').value;
        validarLlave('estructuraarchivo',llaves);
    } 
    
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=estructuraarchivo&";
        url = url + "campos=codtipoestrucarch,codcampoarchivo,posicionarchivo,separador,posicioninicial,posicionfinal,aplicacotizante,aplicabeneficiario&";
        url = url + "campoLlave=codtipoestrucarch,codcampoarchivo";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>