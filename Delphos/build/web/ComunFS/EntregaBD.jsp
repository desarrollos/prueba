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
		
		 function configurar()
        {
            Calendar.setup({inputField : "fechaentrega",ifFormat : "%d/%m/%Y",button : "botonFechaentrega"});
            Calendar.setup({inputField : "fechainicbd",ifFormat : "%d/%m/%Y",button : "botonFechainicbd"});
            Calendar.setup({inputField : "fechafinabd",ifFormat : "%d/%m/%Y",button : "botonFechafinabd"});
        }
		
            //totalidad de elementos en el form
            var cajas = new Array('consecutivo','nombrearchivo','fechaentrega','fechainicbd','fechafinalbd','nroregistros','archivo');
            var combos = new Array('codentidadsaluds');
                      
            //validar
            var arrayNonulos               = null;
            var arrayNumerosEnteros        = new Array('consecutivo','nroregistros');
            var arrayCombos                = new Array('codentidadsalud');
            var arrayCadenasANCod          = null;
            var arrayCadenasA              = null;
            var arrayComentarios           = new Array('archivo');
            var arrayNumerosDoubles        = null;
            
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
            <c:if test="${param.codregimenes != null && param.codentidadsalud != null}">
            <sql:query var="r" sql="SELECT * FROM entregabd WHERE codregimenes='${param.codregimenes}' AND codentidadsalud='${param.codentidadsalud}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codregimenes" value="${fila.codregimenes}"/>
              <c:set var="codentidadsaludf" value="${fila.codentidadsalud}"/>
              <c:set var="consecutivof" value="${fila.consecutivo}"/>
              <c:set var="nombrearchivo" value="${fila.nombrearchivo}"/>
              <c:set var="fechaentrega" value="${fila.fechaentrega}"/>              
              <c:set var="fechainicbd" value="${fila.fechainicbd}"/>
              <c:set var="fechafinalbd" value="${fila.fechafinalbd}"/>
              <c:set var="nroregistros" value="${fila.nroregistros}"/>
              <c:set var="archivo" value="${fila.archivo}"/>  
              
              <%--Carga del archivo de la base de datos---------------------%>
              <%
              String ruta = request.getSession().getServletContext().getRealPath("temp")+"\\";
              ruta = ruta.replaceAll("\\\\","/");
              pageContext.setAttribute("ruta",ruta);
              %>
              <sql:query var="r" sql="select lo_export(entregabd.archivofi, '${ruta}${archivo}') from entregabd where codregimenes='${param.codregimenes}' AND codentidadsalud='${param.codentidadsalud}'" dataSource="jdbc/delphos" scope="page"/>
              <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <%------------------------------------------------------------%>
              </jsp2:forEach>
              <%------------------------------------------------------------%>
                          
            </jsp2:forEach>
                
                <table width="784" border="0" class="tablaContenido">
                 <span id="mensajeControlador">${msj}</span>
				<form action="EntregaBD.jsp" method="post" name="formulario">
                  <tr>
                    <td colspan="6"><div align="center" class="titulo1">Entrega Base de Datos</div></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Consecutivo</strong></td>
                    <td class="sinBgDescTablas"><label>
                    <input name="consecutivo" type="text" id="consecutivo" value="${consecutivo}" size="20" maxlength="6" />
                    </label></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas"><strong>Entidad de Salud</strong></td>
                    <td class="sinBgDescTablas"><label>
                      <select name="codentidadsaluds" id="codentidadsaluds" style="width: 150px">
                      <option id="codentidadsaluds" value=""></option>
                          <sql:query var="r" sql="select codregimenes, codentidadsalud, nombre from entidadsalud a join empresa b on a.codempresa = b.codempresa" dataSource="jdbc/delphos" scope="page"/>
                          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                           <c:choose>
                                <c:when test='${fila.codregimenes == codregimenesf && fila.codentidadsalud == codentidadsaludf}'>
                                <option value="${fila.codregimenes} ${fila.codentidadsalud}" selected="selected">${fila.nombre}</option>
                                </c:when>
                            <c:otherwise>
                                <option value="${fila.codregimenes} ${fila.codentidadsalud}">${fila.nombre}</option>
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
                    <td>&nbsp;</td>
                    <td><strong class="bgDescTablas">Nombre Archivo</strong></td>
                    <td><label>
                      <input name="nombrearchivo" type="text" id="nombrearchivo" value="${nombrearchivo}" size="20" maxlength="60" />
                    </label></td>
                    <td>&nbsp;</td>
                    <td><strong class="bgDescTablas">Fecha Entrega</strong></td>
                    <td><input name="fechaentrega" type="text" id="fechaentrega" value="${fechaentrega}" size="15" readonly="true" />
                      <input name="botonFechaentrega" type="button" id="botonFechaentrega" value="..." /></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Fecha Inicial</strong></td>
                    <td><label>
                    <input name="fechainicbd" type="text" id="fechainicbd" value="${fechainicbd}" size="15" readonly="true" />
                    <input name="botonFechainicbd" type="button" id="botonFechainicbd" value="..." />
                    </label></td>
                    <td>&nbsp;</td>
                    <td><strong class="bgDescTablas">Fecha Final</strong></td>
                    <td><label>
                    <input name="fechafinalbd" type="text" id="fechafinalbd" value="${fechafinalbd}" size="15" readonly="true" />
                    <input name="botonFechafinalbd" type="button" id="botonFechafinalbd" value="..." />
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="30">&nbsp;</td>
                    <td width="139"><strong class="bgDescTablas">Nro. Registros</strong></td>
                  <td width="143" class="sinBgDescTablas"><strong>
  <label>
                      <input name="nroregistros" type="text" id="nroregistros" value="${nroregistros}" size="20" maxlength="9" />
                      </label>
                    </strong></td>
                    <td width="25">&nbsp;</td>
                    <td width="131" class="bgDescTablas"><strong>Archivo</strong></td>
                    <td width="175" class="sinBgDescTablas"><label><span class="sinBgDescTablas" style="width: 20%">
                      <input name="archivo" type="text" id="archivo" size="15"  value="${archivo}" readonly="readonly"/>
                      <a href="#" onClick="abrirCargaArchivo();"><img src="../images/Buscar16x16.gif" alt="Cargar Archivo" border="0" tabindex="4"/></a>
                      <c:if test='${archivo != null && archivo != ""}'><br>
                        <a href="../temp/${archivo}" target="_blank">Descargar ${archivo}</a> </c:if>
                    </span></label></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
          <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="codregimenes" id="codregimenes" value="" >
                  <input type="hidden" name="codentidadsalud" id="codentidadsalud" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="6"> -->
		  <label>&nbsp;</label>
                  <!--<input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="3" />
                  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="4"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="5"/> -->
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
        var cad = document.getElementById('codentidadsaluds').value;
        var cad2 = cad.split(" ");
		
        llaves = 'codregimenes='+cad2[0]+',';
		llaves+= 'codentidadsalud='+cad2[1];

        validarLlave('entregabd',llaves);
    }
    
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=entregabd&";
        url = url + "campos=codregimenes,codentidadsalud,consecutivo,nombrearchivo,fechaentrega,fechainicbd,fechafinalbd,nroregistros&";
        url = url + "campoLlave=codregimenes,codentidadsalud";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>