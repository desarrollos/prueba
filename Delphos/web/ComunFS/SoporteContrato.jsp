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
            //totalidad de elementos en el form
            var cajas = new Array('archivo','observacion');
            var combos = new Array('codcontratos','codtiposoportes','aplicaa');
                      
            //validar
            var arrayNonulos               = null;
            var arrayNumerosEnteros        = null;
            var arrayCombos                = new Array('codcontratos','codtiposoportes','aplicaa');
            var arrayCadenasANCod          = null;
            var arrayCadenasA              = null;
            var arrayComentarios           = new Array('archivo','observacion');
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
            <c:if test="${param.codcontrato != null && param.codentidadsalud != null && param.codregimenes != null && param.codmodalidadcontrato != null && param.codclaseactividad != null && param.codtiposoporte != null}">
            <sql:query var="r" sql="SELECT * FROM soportecontrato WHERE codcontrato='${param.codcontrato}' AND codentidadsalud='${param.codentidadsalud}' AND codregimenes='${param.codregimenes}' AND codmodalidadcontrato='${param.codmodalidadcontrato}' AND codclaseactividad='${param.codclaseactividad}' AND codtiposoporte='${param.codtiposoporte}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codcontratof" value="${fila.codcontrato}"/>
              <c:set var="codentidadsaludf" value="${fila.codentidadsalud}"/>
              <c:set var="codregimenesf" value="${fila.codregimenes}"/>
              <c:set var="codmodalidadcontratof" value="${fila.codmodalidadcontrato}"/>
              <c:set var="codclaseactividadf" value="${fila.codclaseactividad}"/>              
              <c:set var="codtiposoportef" value="${fila.codtiposoporte}"/>
              <c:set var="aplicaa" value="${fila.aplicaa}"/>
              <c:set var="observacion" value="${fila.observacion}"/>
              <c:set var="archivo" value="${fila.archivo}"/> 
              
              <%--Carga del archivo de la base de datos---------------------%>
              <%
              String ruta = request.getSession().getServletContext().getRealPath("temp")+"\\";
              ruta = ruta.replaceAll("\\\\","/");
              pageContext.setAttribute("ruta",ruta);
              %>
              <sql:query var="r" sql="select lo_export(soportecontrato.archivofi, '${ruta}${archivo}') from soportecontrato where codcontrato='${param.codcontrato}' AND codentidadsalud='${param.codentidadsalud}' AND codregimenes='${param.codregimenes}' AND codmodalidadcontrato='${param.codmodalidadcontrato}' AND codclaseactividad='${param.codclaseactividad}' AND codtiposoporte='${param.codtiposoporte}'" dataSource="jdbc/delphos" scope="page"/>
              <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <%------------------------------------------------------------%>
              </jsp2:forEach>
              <%------------------------------------------------------------%>
              
            </jsp2:forEach>
                
                <table width="721" border="0" class="tablaContenido">
                <span id="mensajeControlador">${msj}</span>
				<form action="SoporteContrato.jsp" method="post" name="formulario">
                  <tr>
                    <td colspan="6"><div align="center" class="titulo1">Soportes Contrato </div></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="30">&nbsp;</td>
                    <td width="111"><strong class="bgDescTablas">Contrato</strong></td>
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
                    <td class="bgDescTablas"><strong><strong>Soporte Modalidad</strong></strong></td>
                    <td width="172" class="sinBgDescTablas"><label>
                      <select name="codtiposoportes" id="codtiposoportes" style="width: 150px">
                        <option id="codtiposoportes" value=""></option>
                        <sql:query var="r" sql="select codmodalidadcontrato, codclaseactividad, codtiposoporte from soportemodalcto" dataSource="jdbc/delphos" scope="page"/>
                        <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                          <c:choose>
                            <c:when test='${fila.codmodalidadcontrato == codmodalidadcontratof && fila.codclaseactividad == codclaseactividadf && fila.codtiposoporte == codtiposoportef}'>
                              <option value="${fila.codmodalidadcontrato} ${fila.codclaseactividad} ${fila.codtiposoporte}" selected="selected">${fila.codmodalidadcontrato}</option>
                            </c:when>
                            <c:otherwise>
                              <option value="${fila.codmodalidadcontrato} ${fila.codclaseactividad} ${fila.codtiposoporte}">${fila.codmodalidadcontrato}</option>
                            </c:otherwise>
                          </c:choose>
                        </jsp2:forEach>
                      </select>
                    </label></td>
                    <td width="24">&nbsp;</td>
                    <td width="109" class="bgDescTablas"><strong>Aplica a</strong></td>
                    <td width="199" class="sinBgDescTablas"><label>
                      <select name="aplicaa" id="aplicaa" style="width: 150px">
                        <option value="C">Contratante</option>
                        <option value="T">Contratista</option>
                        <option value="A">Ambos</option>
                      </select>
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Archivo</strong></td>
                    <td colspan="4" class="sinBgDescTablas"><label><span class="sinBgDescTablas" style="width: 20%">
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
                    <td colspan="6"><p align="center" class="bgDescTablas"><strong>Observaciones</strong></p>
                      <p align="center" class="bgDescTablas"> 
                        <textarea name="observacion" cols="75" rows="3" id="observacion">${observacion}</textarea>
                      </p></td>
                  </tr>
        <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="codcontrato" id="codcontrato" value="" >
                  <input type="hidden" name="codentidadsalud" id="codentidadsalud" value="" >
                  <input type="hidden" name="codregimenes" id="codregimenes" value="" >
                  <input type="hidden" name="codmodalidadcontrato" id="codmodalidadcontrato" value="" >
                  <input type="hidden" name="codclaseactividad" id="codclaseactividad" value="" >
                  <input type="hidden" name="codtiposoporte" id="codtiposoporte" value="" >
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
		
		var cad1 = document.getElementById('codtiposoportes').value;
        var cad3 = cad.split(" ");
		
        llaves = 'codcontrato='+cad2[2]+',';
		llaves+= 'codentidadsalud='+cad2[1]+',';
		llaves+= 'codregimenes='+cad2[0]+',';
				
		llaves+= 'codmodalidadcontrato='+cad3[0]+',';
		llaves+= 'codclaseactividad='+cad3[1]+',';
		llaves+= 'codtiposoporte='+cad3[2];
		
        validarLlave('soportecontrato',llaves);
    }
    
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=soportecontrato&";
        url = url + "campos=codcontrato,codentidadsalud,codregimenes,codmodalidadcontrato,codclaseactividad,codtiposoporte,aplicaa,observacion&";
        url = url + "campoLlave=codcontrato,codentidadsalud,codregimenes,codmodalidadcontrato,codclaseactividad,codtiposoporte";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>