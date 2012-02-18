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
            var cajas = new Array('consecutivos','descripcion','formatofecha','separadorcampo','separadoralterno','separadordecimal','separadormil','observacion');
            var combos = new Array('codclaseoperarchs');
			
            var arrayNonulos               	= new Array('consecutivos');
            var arrayNumerosEnteros        	= new Array('consecutivos');
            var arrayCombos               	= new Array('codclaseoperarchs');		
            var arrayCadenasANCod          	= new Array('formatofecha','separadorcampo','separadoralterno','separadordecimal','separadormil');
            var arrayCadenasA              	= null;
            var arrayComentarios           	= new Array('descripcion','observacion');
            var arrayNumerosDoubles        	= null;

	</script>
</head>
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
            <c:if test='${param.codclaseoperarch != null && param.consecutivo != null && param.consecutivo != ""}'>
            <sql:query var="r" sql="SELECT * FROM formatoarchivo WHERE codclaseoperarch='${param.codclaseoperarch}' AND consecutivo=${param.consecutivo}" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codclaseoperarchf" value="${fila.codclaseoperarch}"/>
              <c:set var="consecutivof" value="${fila.consecutivo}"/>
              <c:set var="descripcion" value="${fila.descripcion}"/>
              <c:set var="formatofecha" value="${fila.formatofecha}"/>
              <c:set var="separadorcampo" value="${fila.separadorcampo}"/>
              <c:set var="separadoralterno" value="${fila.separadoralterno}"/>
              <c:set var="separadordecimal" value="${fila.separadordecimal}"/>
              <c:set var="separadormil" value="${fila.separadormil}"/>
              <c:set var="observacion" value="${fila.observacion}"/>
            </jsp2:forEach>
            <table width="811" border="0" class="tablaContenido">
            <form name="formulario" id="formulario" method="post" action="FormatoArchivo.jsp">
              <span id="mensajeControlador">${msj}</span>
              <tr>
                <td colspan="6"><div align="center" class="titulo1">Formato Archivo</div></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td width="30" class="bgDescTablas">&nbsp;</td>
                <td width="139" class="bgDescTablas"><strong>Clase Operaci&oacute;n Archivo</strong></td>
                <td colspan="4"><label>
                  <select name="codclaseoperarchs" id="codclaseoperarchs" style="width: 150px" tabindex="1">
                  <option id="codclaseoperarchs" value=""></option>
                  <sql:query var="r" sql="select codclaseoperarch, descripcion from claseoperarch" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                   <c:choose>
                        <c:when test='${fila.codclaseoperarch == codclaseoperarchf}'>
                        <option value="${fila.codclaseoperarch}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                    <c:otherwise>
                        <option value="${fila.codclaseoperarch}">${fila.descripcion}</option>
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
                <td class="bgDescTablas"><strong>Consecutivo</strong></td>
                <td width="190"><label>
                  <input name="consecutivos" type="text" id="consecutivos" value="${consecutivof}" size="20" maxlength="6" onKeyPress="javascript:return permite(event, 'nume')" tabindex="2">
                </label></td>
                <td width="11">&nbsp;</td>
                <td width="132"><strong class="bgDescTablas">Formato Fecha</strong></td>
                <td width="174"><label>
                  <input name="formatofecha" type="text" id="formatofecha" value="${formatofecha}" size="20" maxlength="20" onKeyPress="javascript:return permite(event, 'num_car_cod')" tabindex="3">
                </label></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><span class="bgDescTablas" style="width: 7%"><strong>Separador Campo</strong></span></td>
                <td><label>
                  <input name="separadorcampo" type="text" id="separadorcampo" value="${separadorcampo}" size="20" maxlength="1" onKeyPress="javascript:return permite(event, 'num_car_cod')" tabindex="4">
                </label></td>
                <td>&nbsp;</td>
                <td><span class="bgDescTablas"><strong>Separador Alterno</strong></span></td>
                <td><span class="sinBgDescTablas">
                </span>
                  <label>
                  <input name="separadoralterno" type="text" id="separadoralterno" value="${separadoralterno}" size="20" maxlength="1" onKeyPress="javascript:return permite(event, 'num_car_cod')" tabindex="5">
                  </label></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">Separador Decimal</strong></td>
                <td><label>
                  <input name="separadordecimal" type="text" id="separadordecimal" value="${separadordecimal}" size="20" maxlength="1" onKeyPress="javascript:return permite(event, 'num_car_cod')" tabindex="6">
                </label></td>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">Separador Mil</strong></td>
                <td><label>
                  <input name="separadormil" type="text" id="separadormil" value="${separadormil}" size="20" maxlength="1" onKeyPress="javascript:return permite(event, 'num_car_cod')" tabindex="7">
                </label></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td colspan="6"><p align="center" class="bgDescTablas"><strong>Descripci&oacute;n</strong></p>
                  <p align="center">
                    <label>
                    <input name="descripcion" type="text" id="descripcion" value="${descripcion}" size="75" maxlength="50" onKeyPress="javascript:return permite(event, 'com')" tabindex="8">
                    </label>
                  </p></td>
              </tr>
              <tr>
                <td colspan="6"><p align="center" class="bgDescTablas"><strong>Observaciones</strong></p>
                <p align="center" class="bgDescTablas">
                  <label>
                  <textarea name="observacion" id="observacion" cols="75" rows="3" onKeyPress="javascript:return permite(event, 'com')" tabindex="9">${observacion}</textarea>
                  </label>
                </p></td>
              </tr>
              <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="codclaseoperarch" id="codclaseoperarch" value="" >
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
        llaves = 'codclaseoperarch='+document.getElementById('codclaseoperarchs').value+',';
	llaves+= 'consecutivo='+document.getElementById('consecutivos').value;
        validarLlave('formatoarchivo',llaves);
    } 
    
    //
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=formatoarchivo&";
        url = url + "campos=codclaseoperarch,consecutivo,descripcion,formatofecha,separadorcampo,separadoralterno,observacion&";
        url = url + "campoLlave=codclaseoperarch,consecutivo";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>