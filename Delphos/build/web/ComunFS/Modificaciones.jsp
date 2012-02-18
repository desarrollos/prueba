<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<%@ taglib prefix="jsp2" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>

<%
clases.VerificarUsuarioSistema v;
v = new clases.VerificarUsuarioSistema(request,response);
%>

<html>
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
            Calendar.setup({inputField : "fechamodific",ifFormat : "%d/%m/%Y",button : "botonFechamodific"});
            Calendar.setup({inputField : "fechafinal",ifFormat : "%d/%m/%Y",button : "botonFechafinal"});
            Calendar.setup({inputField : "fechalegalizac",ifFormat : "%d/%m/%Y",button : "botonFechalegalizac"});
        }
		   
		    //totalidad de elementos en el form
            var cajas = new Array('consecutivos','fechamodific','valoradicion','tiempo','usuariosadic','fechafinal','fechalegalizac','nroradicacion','archivo','clausula','descripcion','observacion');
            var combos = new Array('codcontratos','codtipoperiodo');
                      
            //validar
            var arrayNonulos               = new Array('consecutivos');
            var arrayNumerosEnteros        = new Array('consecutivos','tiempo','usuariosadic');
            var arrayCombos                = new Array('codcontratos','codtipoperiodo');
            var arrayCadenasANCod          = new Array('nroradicacion');
            var arrayCadenasA              = null;
            var arrayComentarios           = new Array('archivo','clausula','descripcion','observacion');
            var arrayNumerosDoubles        = new Array('valoradicion');
            
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
<%-- Datos sesion --%>

<%-- Datos sesion --%>
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
            <c:if test='${param.codregimenes != null && param.codentidadsalud != null && param.codcontrato != null && param.consecutivo != null && param.consecutivo != ""}'>
            <sql:query var="r" sql="SELECT * FROM modifcontrato WHERE codregimenes='${param.codregimenes}' AND codentidadsalud='${param.codentidadsalud}' AND codcontrato='${param.codcontrato}' AND consecutivo=${param.consecutivo}" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codregimenesf" value="${fila.codregimenes}"/>
              <c:set var="codentidadsaludf" value="${fila.codentidadsalud}"/>
              <c:set var="codcontratof" value="${fila.codcontrato}"/>
              <c:set var="consecutivof" value="${fila.consecutivo}"/>
              <c:set var="clausula" value="${fila.clausula}"/>
              <c:set var="descripcion" value="${fila.descripcion}"/>
              <fmt:formatDate value="${fila.fechamodific}" pattern="dd/MM/yyyy" var="fechamodific"/>
              <c:set var="valoradicion" value="${fila.valoradicion}"/>
              <c:set var="codtipoperiodo" value="${fila.codtipoperiodo}"/>
              <c:set var="tiempo" value="${fila.tiempo}"/>
              <fmt:formatDate value="${fila.fechafinal}" pattern="dd/MM/yyyy" var="fechafinal"/>
              <c:set var="usuariosadic" value="${fila.usuariosadic}"/>
              <fmt:formatDate value="${fila.fechalegalizac}" pattern="dd/MM/yyyy" var="fechalegalizac"/>
              <c:set var="observacion" value="${fila.observacion}"/>
              <c:set var="nroradicacion" value="${fila.nroradicacion}"/>
              <c:set var="archivo" value="${fila.archivo}"/> 
              
              <%--Carga del archivo de la base de datos---------------------%>
              <%
              String ruta = request.getSession().getServletContext().getRealPath("temp")+"\\";
              ruta = ruta.replaceAll("\\\\","/");
              pageContext.setAttribute("ruta",ruta);
              %>
              <sql:query var="r" sql="select lo_export(modifcontrato.archivofi, '${ruta}${archivo}') from modifcontrato where codregimenes='${param.codregimenes}' AND codentidadsalud='${param.codentidadsalud}' AND codcontrato='${param.codcontrato}' AND consecutivo=${param.consecutivo}" dataSource="jdbc/delphos" scope="page"/>
              <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <%------------------------------------------------------------%>
              </jsp2:forEach>
              <%------------------------------------------------------------%>
              
</jsp2:forEach>
                
                <table width="801" border="0" class="tablaContenido">
                <span id="mensajeControlador">${msj}</span>
				<form action="Modificaciones.jsp" method="post" name="formulario">
                  <tr>
                    <td colspan="6"><div align="center" class="titulo1">Modificaciones</div></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="28">&nbsp;</td>
                    <td width="122"><span class="bgDescTablas"><strong>Contrato</strong></span></td>
                    <td colspan="4" class="sinBgDescTablas"><label>
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
                    </select>
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Consecutivo</strong></td>
                    <td width="172" class="sinBgDescTablas"><input  name="consecutivos" type="text" id="consecutivos" value="${consecutivof}" size="20" maxlength="4" /></td>
                    <td width="17">&nbsp;</td>
                    <td width="151" class="bgDescTablas"><strong>Fecha Modificaci&oacute;n </strong></td>
                    <td width="162" class="sinBgDescTablas"><label><span class="sinBgDescTablas" style="width: 20%">
                    <input name="fechamodific" type="text" id="fechamodific" value="${fechamodific}" size="15" readonly="readonly" />
                    <span class="sinBgDescTablas" style="width: 20%">
                    <input name="buttonFechamodific" type="button" id="buttonFechamodific" value="..." />
                    </span></span></label></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="6"><div align="center" class="titulo1">Adici&oacute;n</div></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Valor</strong></td>
                    <td class="sinBgDescTablas"><label>
                      <input name="valoradicion" type="text" id="valoradicion" value="${valoradicion}" size="20" maxlength="17" />
                    </label></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas"><strong>Tiempo</strong></td>
                    <td class="sinBgDescTablas">
                    <input name="tiempo" type="text" id="tiempo" value="${tiempo}" size="20" maxlength="4" /></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Tipo Periodo </strong></td>
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
                    <td>&nbsp;</td>
                    <td class="bgDescTablas"><strong>Usuarios</strong></td>
                    <td class="sinBgDescTablas"><label>
                      <input name="usuariosadic" type="text" id="usuariosadic" value="${usuariosadic}" size="20" maxlength="6" />
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td><strong class="bgDescTablas">Fecha Final </strong></td>
                    <td><span class="sinBgDescTablas" style="width: 20%">
                      <input name="fechafinal" type="text" id="fechafinal" value="${fechafinal}" size="15" readonly="readonly" />
                      <span class="sinBgDescTablas" style="width: 20%">
                      <input name="button" type="button" id="botonFechafinal" value="..." />
                      </span></span></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas"><strong>Fecha Legalizaci&oacute;n</strong></td>
                    <td><span class="sinBgDescTablas" style="width: 20%">
                      <input name="fechalegalizac" type="text" id="fechalegalizac" value="${fechalegalizac}" size="15" readonly="readonly" />
                      <span class="sinBgDescTablas" style="width: 20%">
                      <input name="button2" type="button" id="botonFechalegalizac" value="..." />
                      </span></span></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Nro. Radicaci&oacute;n </strong></td>
                    <td><label>
                      <input name="nroradicacion" type="text" id="nroradicacion" value="${nroradicacion}" size="20" maxlength="12" />
                    </label></td>
                    <td>&nbsp;</td>
                    <td><strong class="bgDescTablas">Archivo</strong></td>
                    <td><label><span class="sinBgDescTablas" style="width: 20%">
                      <input name="archivo" type="text" id="archivo" size="15"  value="${archivo}" readonly="readonly"/>
                      <a href="#" onClick="abrirCargaArchivo();"><img src="../images/Buscar16x16.gif" alt="Cargar Archivo" border="0" tabindex="4"/></a>
                    <c:if test='${archivo != null && archivo != ""}'><br>
                    <a href="../temp/${archivo}" target="_blank">Descargar ${archivo}</a> </c:if>
                    </span></label></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas"><p align="center"><strong>Clausula</strong></p>
                    <p align="center">
                      <input name="clausula" type="text" id="clausula" value="${clausula}" size="75" maxlength="30" />
                    </p></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas"><p align="center"><strong>Descripci&oacute;n</strong></p>
                    <p align="center">
                      <textarea name="descripcion" cols="75" rows="3" id="descripcion">${descripcion}</textarea>
                    </p></td>
                  </tr>
                  <tr>
                    <td colspan="6"><p align="center" class="bgDescTablas"><strong>Observaciones</strong></p>
                      <p align="center" class="tablaContenido">
                        <textarea cols="75" rows="3" name="observacion" id="observacion">${observacion}</textarea>
                      </p></td>
                  </tr>
           <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="codregimenes" id="codregimenes" value="" >
                  <input type="hidden" name="codentidadsalud" id="codentidadsalud" value="" >
                  <input type="hidden" name="codcontrato" id="codcontrato" value="" >
                  <input type="hidden" name="consecutivo" id="consecutivo" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="6">-->
		  <label>&nbsp;</label>
                  <!--<input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="3" />
                  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="4"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="5"/>-->
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
        <jsp:include page="../footer.jsp" />
	</td>
</tr>
</table>
</center>
<!-- End ImageReady Slices -->
<script>    
    //funciones control
    configurar();
	
	function abrirCargaArchivo()
    {
        var url;
        url = "PopUpCargaArchivo.jsp?";
        url = url + "campo=archivo";
        
        window.open(url,"_blank","width=500,height=190,scrollbars=1,left=350,top=100");
    }
	
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
        var cad = document.getElementById('codcontratos').value;
        var cad2 = cad.split(" ");
		
        llaves = 'codregimenes='+cad2[0]+',';
		llaves+= 'codentidadsalud='+cad2[1]+',';
		llaves+= 'codcontrato='+cad2[2]+',';
		
		llaves+= 'consecutivo='+document.getElementById('consecutivos').value+',';
        validarLlave('modifcontrato',llaves);
    }
    
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=modifcontrato&";
        url = url + "campos=codregimenes,codentidadsalud,codcontrato,consecutivo,clausula,fechamodific,valoradicion,codtipoperiodo,fechafinal,fechalegalizac&";
        url = url + "campoLlave=codregimenes,codentidadsalud,codcontrato,consecutivo";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>