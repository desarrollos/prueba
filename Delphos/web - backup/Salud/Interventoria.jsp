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
            function configurar()
        {
            Calendar.setup({inputField : "fecha",ifFormat : "%d/%m/%Y",button : "botonFecha"});
        }
			
			//totalidad de elementos en el form
            var cajas = new Array('consecutivos','nroliquidaccto','fecha','archivo','descripcion','observacion');
            var combos = new Array('codcontratos','codtipointervcontrato');
                      
            //validar
            var arrayNonulos               = new Array('consecutivos');
            var arrayNumerosEnteros        = new Array('consecutivos');
            var arrayCombos                = new Array('codcontratos','codtipointervcontrato');
            var arrayCadenasANCod          = new Array('nroliquidaccto');
            var arrayCadenasA              = null;
            var arrayComentarios           = new Array('archivo','descripcion','observacion');
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
            <c:if test='${param.codregimenes != null && param.codentidadsalud != null && param.codcontrato != null && param.consecutivo != null && param.consecutivo != ""}'>
            <sql:query var="r" sql="SELECT * FROM intervencioncto WHERE codregimenes='${param.codregimenes}' AND codentidadsalud='${param.codentidadsalud}' AND codcontrato='${param.codcontrato}' AND consecutivo=${param.consecutivo}" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codregimenesf" value="${fila.codregimenes}"/>
              <c:set var="codentidadsaludf" value="${fila.codentidadsalud}"/>
              <c:set var="codcontratof" value="${fila.codcontrato}"/>
              <c:set var="consecutivof" value="${fila.consecutivo}"/>
              <c:set var="descripcion" value="${fila.descripcion}"/>
              <c:set var="observacion" value="${fila.observacion}"/>
              <fmt:formatDate value="${fila.fecha}" pattern="dd/MM/yyyy" var="fecha"/>          
              <c:set var="codtipointervcontrato" value="${fila.codtipointervcontrato}"/>
              <c:set var="nroliquidaccto" value="${fila.nroliquidaccto}"/>
              <c:set var="archivo" value="${fila.archivo}"/>
              
              <%--Carga del archivo de la base de datos---------------------%>
              <%
              String ruta = request.getSession().getServletContext().getRealPath("temp")+"\\";
              ruta = ruta.replaceAll("\\\\","/");
              pageContext.setAttribute("ruta",ruta);
              %>
              <sql:query var="r" sql="select lo_export(intervencioncto.archivofi, '${ruta}${archivo}') from intervencioncto where codregimenes='${param.codregimenes}' AND codentidadsalud='${param.codentidadsalud}' AND codcontrato='${param.codcontrato}' AND consecutivo=${param.consecutivo}" dataSource="jdbc/delphos" scope="page"/>
              <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <%------------------------------------------------------------%>
              </jsp2:forEach>
              <%------------------------------------------------------------%>
              
            </jsp2:forEach>
                
                <table width="741" border="0" class="tablaContenido">
                <span id="mensajeControlador">${msj}</span>
				<form action="Interventoria.jsp" method="post" name="formulario">
                  <tr>
                    <td colspan="6"><div align="center" class="titulo1">Interventor&iacute;a</div></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong class="bgDescTablas">Contrato</strong></td>
                    <td colspan="4" class="sinBgDescTablas"><select name="codcontratos" id="codcontratos" style="width: 150px">
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
                    </select></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="27">&nbsp;</td>
                    <td width="122"><span class="bgDescTablas"><strong><strong>Consecutivo</strong></strong></span></td>
                    <td width="168" class="sinBgDescTablas"><strong>
                      <input name="consecutivos" type="text" id="consecutivos" value="${consecutivof}" size="20" maxlength="4" />
                    </strong></td>
                    <td width="19">&nbsp;</td>
                    <td width="109" class="bgDescTablas"><strong>Tipo Intervencion</strong></td>
                    <td width="197" class="sinBgDescTablas">
                    <select name="codtipointervcontrato" id="codtipointervcontrato" style="width: 150px">
                      <option id="codtipointervcontrato" value=""></option>
                          <sql:query var="r" sql="select codtipointervcontrato, descripcion from tipointervenccontrato" dataSource="jdbc/delphos" scope="page"/>
                      <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                           <c:choose>
                                <c:when test='${fila.codtipointervcontrato == codtipointervcontrato}'>
                                <option value="${fila.codtipointervcontrato}" selected="selected">${fila.descripcion}</option>
                                </c:when>
                            <c:otherwise>
                                <option value="${fila.codtipointervcontrato}">${fila.descripcion}</option>
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
                    <td height="27" class="bgDescTablas"><strong>Nro. Liquidaci&oacute;n Contrato</strong></td>
                    <td class="sinBgDescTablas"><label>
                      <input name="nroliquidaccto" type="text" id="nroliquidaccto" value="${nroliquidaccto}" size="20" maxlength="12" />
                    </label></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas"><strong>Fecha</strong></td>
                    <td class="sinBgDescTablas"><label>
                      <input name="fecha" type="text" id="fecha" value="${fecha}" size="15" readonly="true" />
                      <input name="button" type="button" id="botonFecha" value="..." />
                    </label></td>
                  </tr>
                  <tr>
                    <td height="27" colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td height="27" class="bgDescTablas"><strong>Archivo</strong></td>
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
                    <td colspan="6" class="bgDescTablas"><p align="center"><strong>Descripci&oacute;n</strong></p>
                    <p align="center"><strong>
                      <label>
                      <input name="descripcion" type="text" id="descripcion" value="${descripcion}" size="75" maxlength="50" />
                      </label>
                    </strong></p></td>
                  </tr>
                  <tr>
                    <td colspan="6"><p align="center" class="bgDescTablas"><strong>Observaciones</strong></p>
                      <p align="center" class="bgDescTablas"> 
                        <textarea name="observacion" cols="75" rows="3" id="observacion">${observacion}</textarea>
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
                 <!-- <input type="button" onClick="buscar();" value="Buscar" tabindex="6"> -->
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
    configurar();
	
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
		
        llaves = 'codregimenes='+cad2[0]+',';
		llaves+= 'codentidadsalud='+cad2[1]+',';
		llaves+= 'codcontrato='+cad2[2]+',';
		
		llaves+= 'consecutivo='+document.getElementById('consecutivos').value;
		
        validarLlave('intervencioncto',llaves);
    } 
    
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=intervencioncto&";
        url = url + "campos=codregimenes,codentidadsalud,codcontrato,consecutivo,fecha,codtipointervcontrato,nroliquidaccto,archivo&";
        url = url + "campoLlave=codregimenes,codentidadsalud,codcontrato,consecutivo";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>