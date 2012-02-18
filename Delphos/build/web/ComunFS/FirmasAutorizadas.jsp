<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<%@ taglib prefix="jsp2" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
            function configurar()
            {                
                Calendar.setup({inputField : "firmfechinic",ifFormat : "%d/%m/%Y",button : "botonFirmfechinic", daFormat : "%d/%m/%Y"});
                Calendar.setup({inputField : "firmfechfina",ifFormat : "%d/%m/%Y",button : "botonFirmfechfina", daFormat : "%d/%m/%Y"});
            }
              
            //totalidad de elementos en el form
            var cajas = new Array('firmidentifis','firmnombre1','firmnombre2','firmapellido1','firmapellido2','firmfirma','firmarchivo','firmobservac','firmfechinic','firmfechfina');
            var combos = new Array('codtipoidentidadfirs','codempresa');
			
            var arrayNonulos               	= new Array ('firmidentifis');
            var arrayNumerosEnteros        	= null;
            var arrayCombos               	= new Array ('codtipoidentidadfirs','codempresa');			
            var arrayCadenasANCod          	= new Array ('firmidentifi','firmnombre1','firmnombre2','firmapellido1','firmapellido2','firmfirma');
            var arrayCadenasA              	= null;
            var arrayComentarios           	= new Array ('firmobservac','firmarchivo');
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
            <c:if test="${param.codtipoidentidadfir != null && param.firmidentifi != null}">
            <sql:query var="r" sql="SELECT * FROM firmasautorizadas WHERE codtipoidentidadfir='${param.codtipoidentidadfir}' AND firmidentifi='${param.firmidentifi}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codtipoidentidadfirf" value="${fila.codtipoidentidadfir}"/>
              <c:set var="firmidentifif" value="${fila.firmidentifi}"/>
              <c:set var="codtipoidentidad" value="${fila.codtipoidentidad}"/>
              <c:set var="codempresa" value="${fila.codempresa}"/>   
              <c:set var="firmnombre1" value="${fila.firmnombre1}"/> 
              <c:set var="firmnombre2" value="${fila.firmnombre2}"/> 
              <c:set var="firmapellido1" value="${fila.firmapellido1}"/> 
              <c:set var="firmapellido2" value="${fila.firmapellido2}"/>
              <fmt:formatDate value="${fila.firmfechinic}" pattern="dd/MM/yyyy" var="firmfechinic"/>
              <fmt:formatDate value="${fila.firmfechfina}" pattern="dd/MM/yyyy" var="firmfechfina"/> 
              <c:set var="firmfirma" value="${fila.firmfirma}"/> 
              <c:set var="firmarchivo" value="${fila.firmarchivo}"/> 
              <c:set var="firmobservac" value="${fila.firmobservac}"/>   
              
              <%--Carga del archivo de la base de datos---------------------%>
              <%
              String ruta = request.getSession().getServletContext().getRealPath("temp")+"\\";
              ruta = ruta.replaceAll("\\\\","/");
              pageContext.setAttribute("ruta",ruta);
              %>
              <sql:query var="r" sql="select lo_export(firmasautorizadas.archivofi, '${ruta}${firmarchivo}') from firmasautorizadas where codtipoidentidadfir='${param.codtipoidentidadfir}' AND firmidentifi='${param.firmidentifi}'" dataSource="jdbc/delphos" scope="page"/>
              <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <%------------------------------------------------------------%>
              </jsp2:forEach>
              <%------------------------------------------------------------%>
                   
            </jsp2:forEach>
                
                <table width="799" border="0" class="tablaContenido">
		<form action="FirmasAutorizadas.jsp" method="post" name="formulario" id="formulario">
                  <span id="mensajeControlador">${msj}</span>
                  <tr>
                    <td colspan="6"><div align="center" class="titulo1">Firmas Autorizadas</div></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="30" class="bgDescTablas">&nbsp;</td>
                    <td width="129" class="bgDescTablas"><strong>Tipo Identificaci&oacute;n</strong></td>
                    <td width="166" class="bgDescTablas"><label>
                      <select name="codtipoidentidadfirs" id="codtipoidentidadfirs" style="width: 150px" tabindex="1">
                          <option id="codtipoidentidadfirs" value=""></option>
                          <sql:query var="r" sql="select codtipoidentidad, descripcion from tipoidentificacion" dataSource="jdbc/delphos" scope="page"/>
                          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                           <c:choose>
                                <c:when test='${fila.codtipoidentidad == codtipoidentidadfirf}'>
                                <option value="${fila.codtipoidentidad}" selected="selected">${fila.descripcion}</option>
                                </c:when>
                            <c:otherwise>
                                <option value="${fila.codtipoidentidad}">${fila.descripcion}</option>
                            </c:otherwise>
                           </c:choose>
                         </jsp2:forEach>
                    </select>
                    </label></td>
                    <td width="10" class="bgDescTablas">&nbsp;</td>
                    <td width="112" class="bgDescTablas"><strong>Nro. Identificaci&oacute;n</strong></td>
                    <td width="172" class="bgDescTablas"><label>
                      <input name="firmidentifis" type="text" id="firmidentifis" value="${firmidentifif}" size="20" maxlength="18" onKeyPress="javascript:return permite(event, 'num_car_cod')" tabindex="2"/>
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Empresa</strong></td>
                    <td colspan="4" class="bgDescTablas">
                        <select name="codempresa" id="codempresa" style="width: 150px" tabindex="3">
                      <option id="codempresa" value=""></option>
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
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Nombre 1</strong></td>
                    <td class="bgDescTablas"><label>
                      <input name="firmnombre1" type="text" id="firmnombre1" value="${firmnombre1}" size="20" maxlength="25" onKeyPress="javascript:return permite(event, 'num_car_cod')" tabindex="4"/>
                    </label></td>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Nombre 2</strong></td>
                    <td class="bgDescTablas"><label>
                      <input name="firmnombre2" type="text" id="firmnombre2" value="${firmnombre2}" size="20" maxlength="25" onKeyPress="javascript:return permite(event, 'num_car_cod')" tabindex="5"/>
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Apellido 1</strong></td>
                    <td class="bgDescTablas"><label>
                      <input name="firmapellido1" type="text" id="firmapellido1" value="${firmapellido1}" size="20" maxlength="25" onKeyPress="javascript:return permite(event, 'num_car_cod')" tabindex="6"/>
                    </label></td>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Apellido 2</strong></td>
                    <td class="bgDescTablas"><label>
                      <input name="firmapellido2" type="text" id="firmapellido2" value="${firmapellido2}" size="20" maxlength="25" onKeyPress="javascript:return permite(event, 'num_car_cod')" tabindex="7"/>
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td><span class="bgDescTablas" style="width: 8%"><strong>Fecha Inicial Vigencia</strong></span></td>
                    <td><span class="sinBgDescTablas" style="width: 20%">
                      <input name="firmfechinic" type="text" id="firmfechinic"  value="${firmfechinic}" size="10" maxlength="19" readonly="readonly"/>
                      <span class="sinBgDescTablas" style="width: 20%">
                      <input name="button" type="button" id="botonFirmfechinic" value="..." tabindex="8"/>
                    </span></span></td>
                    <td>&nbsp;</td>
                    <td><span class="bgDescTablas" style="width: 8%"><strong>Fecha Final Vigencia</strong></span></td>
                    <td><span class="sinBgDescTablas" style="width: 20%">
                      <input name="firmfechfina" type="text" id="firmfechfina"  value="${firmfechfina}" size="10" maxlength="19" readonly="readonly"/>
                      <span class="sinBgDescTablas" style="width: 20%">
                      <input name="button2" type="button" id="botonFirmfechfina" value="..." tabindex="9"/>
                    </span></span></td>                    
                    
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Firma Autorizada</strong></td>
                    <td class="bgDescTablas"><label><span class="sinBgDescTablas" style="width: 20%">
                    <c:if test='${firmarchivo != null}'></c:if>
                    </span>
                        <input name="firmfirma" type="text" id="firmfirma" value="${firmfirma}" size="20" onKeyPress="javascript:return permite(event, 'num_car_cod')" tabindex="10"/>
                    </label></td>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Archivo Documento Autorizaci&oacute;n</strong></td>
                    <td class="bgDescTablas"><span class="sinBgDescTablas" style="width: 20%">
                      <input name="firmarchivo" type="text" id="firmarchivo" size="15"  value="${firmarchivo}" readonly="readonly"/>
                      <a href="#" onClick="abrirCargaArchivo();" tabindex="11"><img src="../images/Buscar16x16.gif" alt="Cargar Archivo" border="0"/></a>
                      <c:if test='${firmarchivo != null}'> <br />
                        <a href="../temp/${firmarchivo}" target="_blank">Descargar ${firmarchivo}</a></c:if>
                    </span></td>
              </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="6"><p align="center" class="bgDescTablas"><strong>Observaciones</strong></p>
                      <p align="center">
                      <label>
                      <textarea name="firmobservac" id="firmobservac" cols="75" rows="3" onKeyPress="javascript:return permite(event, 'com')" tabindex="12">${firmobservac}</textarea>
                      </label>
                    </p></td>
                  </tr>
                <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="codtipoidentidadfir" id="codtipoidentidadfir" value="" >
                  <input type="hidden" name="firmidentifi" id="firmidentifi" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <<!--input type="button" onClick="buscar();" value="Buscar" tabindex="16"> -->
		  <label>&nbsp;</label>
                  <!--<input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="13"/>
                  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="14"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="15"/> -->
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
    configurar();
    
    function abrirCargaArchivo()
    {
        var url;
        url = "PopUpCargaArchivo.jsp?";
        url = url + "campo=firmarchivo";
        
        window.open(url,"_blank","width=500,height=190,scrollbars=1,left=350,top=100");
    }
	
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
        llaves = 'codtipoidentidadfir='+document.getElementById('codtipoidentidadfirs').value+',';
	llaves+= 'firmidentifi='+document.getElementById('firmidentifis').value;
        validarLlave('firmasautorizadas',llaves);
    } 
    
    //
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=firmasautorizadas&";
        url = url + "campos=codtipoidentidadfir,firmidentifi,codtipoidentidad,codempresa,firmnombre1,firmnombre2,firmapellido1,firmapellido2&";
        url = url + "campoLlave=codtipoidentidadfir,firmidentifi";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>