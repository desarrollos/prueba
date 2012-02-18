<!--
	Familias en accion
-->
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
           
            function configurar()
            {
		Calendar.setup({inputField : "escnovfecha",ifFormat : "%d/%m/%Y",button : "botonescnovfecha"});
	    }
			
			//totalidad de elementos en el form
            var cajas = new Array('escnovconsecs','escnovfecha','escnovarchi','escnovobserv');
            var combos = new Array('escidentificests','codtiponovedad','codempresa','codempresaact');
			
            var arrayNonulos               	= new Array('escnovconsecs');
            var arrayNumerosEnteros        	= new Array('escnovconsecs');
            var arrayCombos               	= new Array('escidentificests','codtiponovedad','codempresa','codempresaact');
            var arrayCadenasANCod          	= null;
            var arrayCadenasA              	= null;
            var arrayComentarios           	= new Array('escnovobserv');
            var arrayNumerosDoubles        	= null;
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
            <c:if test='${param.codtipoideninsact != null && param.codempresaact != null && param.codtipoidentidadest != null && param.escidentificest != null && param.escvigencia != null && param.escnovconsec != null && param.escvigencia != "" && param.escnovconsec != ""}'>
            <sql:query var="r" sql="SELECT * FROM escolaridadnovedad WHERE codtipoideninsact='${param.codtipoideninsact}' AND codempresaact='${param.codempresaact}' AND codtipoidentidadest='${param.codtipoidentidadest}' AND escidentificest='${param.escidentificest}' AND escvigencia=${param.escvigencia} AND escnovconsec=${param.escnovconsec}" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codtipoideninsactf" value="${fila.codtipoideninsact}"/>
              <c:set var="codempresaactf" value="${fila.codempresaact}"/>
              <c:set var="codtipoidentidadestf" value="${fila.codtipoidentidadest}"/>
              <c:set var="escidentificestf" value="${fila.escidentificest}"/>
              <c:set var="escvigenciaf" value="${fila.escvigencia}"/>
              <c:set var="escnovconsecf" value="${fila.escnovconsec}"/>
              <fmt:formatDate value="${fila.escnovfecha}" pattern="dd/MM/yyyy" var="escnovfecha"/>
              <c:set var="codtipoidentidad" value="${fila.codtipoidentidad}"/>              
              <c:set var="codempresa" value="${fila.codempresa}"/>
              <c:set var="codtiponovedad" value="${fila.codtiponovedad}"/>
              <c:set var="escnovarchi" value="${fila.escnovarchi}"/>
              <c:set var="escnovobserv" value="${fila.escnovobserv}"/>
              
              <%--Carga del archivo de la base de datos---------------------%>
              <%
              String ruta = request.getSession().getServletContext().getRealPath("temp")+"\\";
              ruta = ruta.replaceAll("\\\\","/");
              pageContext.setAttribute("ruta",ruta);
              %>
              <sql:query var="r" sql="select lo_export(escolaridadnovedad.archivofi, '${ruta}${escnovarchi}') from escolaridadnovedad WHERE codtipoideninsact='${param.codtipoideninsact}' AND codempresaact='${param.codempresaact}' AND codtipoidentidadest='${param.codtipoidentidadest}' AND escidentificest='${param.escidentificest}' AND escvigencia=${param.escvigencia} AND escnovconsec=${param.escnovconsec}" dataSource="jdbc/delphos" scope="page"/>
              <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <%------------------------------------------------------------%>
              </jsp2:forEach>
              <%------------------------------------------------------------%>
              
            </jsp2:forEach>
    
<form name="formulario" method="post" action="NovedadEscolaridad.jsp">
<span id="mensajeControlador">${msj}</span>
<table width="792" border="0" class="tablaContenido">

  <tr>
       <td colspan="6"><div align="center"><span class="titulo1">Novedad Escolaridad</span></div></td>
    </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td><label></label></td>
    <td><strong class="bgDescTablas">Estudiante</strong></td>
    <td width="159"><select name="escidentificests" id="escidentificests" style="width: 150px">
      <option id="escidentificests" value=""></option>
      <sql:query var="r" sql="select codtipoidentidadins, codempresa, codtipoidentidad, escidentific, escvigencia from escolaridad" dataSource="jdbc/delphos" scope="page"/>
      <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
        <c:choose>
          <c:when test='${fila.codtipoidentidadins == codtipoideninsactf && fila.codempresa == codempresaactf && fila.codtipoidentidad == codtipoidentidadestf && fila.escidentific == escidentificestf && fila.escvigencia == escvigenciaf}'>
            <option value="${fila.codtipoidentidadins} ${fila.codempresa} ${fila.codtipoidentidad} ${fila.escidentific} ${fila.escvigencia}" selected="selected">${fila.escidentific}</option>
          </c:when>
          <c:otherwise>
            <option value="${fila.codtipoidentidadins} ${fila.codempresa} ${fila.codtipoidentidad} ${fila.escidentific} ${fila.escvigencia}">${fila.escidentific}</option>
          </c:otherwise>
        </c:choose>
      </jsp2:forEach>
    </select></td>
    <td width="10">&nbsp;</td>
    <td width="123"><span class="bgDescTablas" style="width: 15%"><strong>Consecutivo Novedad</strong></span></td>
    <td width="174"><span class="sinBgDescTablas" style="width: 15%">
      <input name="escnovconsecs" type="text" id="escnovconsecs" value="${escnovconsecf}" size="20" onkeypress="javascript:return permite(event, 'nume')"/>
    </span></td>
  </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td width="28">&nbsp;</td>
    <td width="148" class="bgDescTablas"><strong class="bgDescTablas">Nueva Instituci&oacute;n Educativa</strong></td>
    <td><select name="codempresa" id="codempresa" style="width: 150px">
      <option id="codempresa" value=""></option>
      <sql:query var="r" sql="select codtipoidentidad, codempresa, nombre from empresa" dataSource="jdbc/delphos" scope="page"/>
      <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
        <c:choose>
          <c:when test="${fila.codtipoidentidad == codtipoidentidad && fila.codempresa == codempresa}">
            <option value="${fila.codtipoidentidad} ${fila.codempresa}" selected="selected">${fila.nombre}</option>
          </c:when>
          <c:otherwise>
            <option value="${fila.codtipoidentidad} ${fila.codempresa}">${fila.nombre}</option>
          </c:otherwise>
        </c:choose>
      </jsp2:forEach>
    </select></td>
    <td>&nbsp;</td>
    <td><span class="bgDescTablas" style="width: 20%"><strong>Tipo Novedad</strong></span></td>
    <td><span class="sinBgDescTablas" style="width: 15%">
      <select name="codtiponovedad" id="codtiponovedad" style="width: 150px">
        <option id="codtiponovedad" value=""></option>
        <sql:query var="r" sql="select codtiponovedad, descripcion from tiponovedad" dataSource="jdbc/delphos" scope="page"/>
        <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
          <c:choose>
            <c:when test='${fila.codtiponovedad == codtiponovedad}'>
              <option value="${fila.codtiponovedad}" selected="selected">${fila.descripcion}</option>
            </c:when>
            <c:otherwise>
              <option value="${fila.codtiponovedad}">${fila.descripcion}</option>
            </c:otherwise>
          </c:choose>
        </jsp2:forEach>
      </select>
    </span></td>
  </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td class="bgDescTablas">&nbsp;</td>
    <td class="bgDescTablas"><strong>Nombres</strong></td>
    <td class="sinBgDescTablas"><label>
      <input type="text" name="escnom" id="escnom" readonly="true" onkeypress="javascript:return permite(event, 'carac')"/>
    </label></td>
    <td>&nbsp;</td>
    <td class="bgDescTablas"><strong>Apellidos</strong></td>
    <td class="sinBgDescTablas"><label>
      <input type="text" name="escape" id="escape" readonly="true" onkeypress="javascript:return permite(event, 'carac')"/>
    </label></td>
  </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td class="bgDescTablas">&nbsp;</td>
    <td class="bgDescTablas"><strong>Direccion</strong></td>
    <td class="sinBgDescTablas"><label>
      <input type="text" name="escdir" id="escdir" readonly="true"/>
    </label></td>
    <td>&nbsp;</td>
    <td class="bgDescTablas"><strong>Telefono</strong></td>
    <td class="sinBgDescTablas"><label>
      <input type="text" name="esctel" id="esctel" readonly="true" onkeypress="javascript:return permite(event, 'num_car_cod')"/>
    </label></td>
  </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td>&nbsp;</td>
    <td><span class="bgDescTablas" style="width: 7%"><strong>Fecha</strong></span></td>
    <td><label><span class="sinBgDescTablas" style="width: 16%">
      <input name="escnovfecha" type="text" id="escnovfecha" value="${escnovfecha}" size="15" readonly="readonly" />
      <span class="sinBgDescTablas" style="width: 16%">
      <input name="button" type="button" id="botonescnovfecha" value="..." />
      </span></span></label></td>
    <td>&nbsp;</td>
    <td><span class="bgDescTablas" style="width: 20%"><strong>Archivo Formato Novedad</strong></span></td>
    <td><span class="sinBgDescTablas" style="width: 20%">
      <input name="escnovarchi" type="text" id="escnovarchi" size="15"  value="${escnovarchi}" readonly="readonly"/>
      <a href="#" onclick="abrirCargaArchivo();"><img src="../images/Buscar16x16.gif" alt="Cargar Archivo" border="0" tabindex="4"/></a>
      <c:if test='${escnovarchi != null && escnovarchi != ""}'><br />
        <a href="../temp/${escnovarchi}" target="_blank">Descargar ${escnovarchi}</a> </c:if>
    </span></td>
  </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td colspan="6"><p align="center" class="bgDescTablas"><strong>Observaciones</strong></p>
      <p align="center"><strong>
        <textarea name="escnovobserv" cols="75" rows="3" id="escnovobserv" onkeypress="javascript:return permite(event, 'com')">${escnovobserv}</textarea>
        </strong></p></td>
  </tr>
  <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="codtipoideninsact" id="codtipoideninsact" value="" >
                  <input type="hidden" name="codempresaact" id="codempresaact" value="" >
                  <input type="hidden" name="codtipoidentidadest" id="codtipoidentidadest" value="" >
                  <input type="hidden" name="escidentificest" id="escidentificest" value="" >
                  <input type="hidden" name="escvigencia" id="escvigencia" value="" >
                  <input type="hidden" name="escnovconsec" id="escnovconsec" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="17"> -->
		  <label>&nbsp;</label>
		  <!--<input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="14"/>
		  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="15"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="16"/> -->
                  <jsp:include page="../BarraNavegacion.jsp?tabBuscar=17&tabGuardar=14&tabEditar=15&tabEliminar=16" />
               </div></td>
           </tr>
          </table>
        </form>
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
	
	function abrirCargaArchivo()
    {
        var url;
        url = "PopUpCargaArchivo.jsp?";
        url = url + "campo=escnovarchi";
        
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
        var cad = document.getElementById('escidentificests').value;
        var cad2 = cad.split(" ");
		
        llaves = 'codtipoideninsact='+cad2[0]+',';
		llaves+= 'codempresaact='+cad2[1]+',';
		llaves+= 'codtipoidentidadest='+cad2[2]+',';
		llaves+= 'escidentificest='+cad2[3]+',';
		llaves+= 'escvigencia='+cad2[4]+',';
        llaves+= 'escnovconsec='+document.getElementById('escnovconsecs').value;
        validarLlave('escolaridadnovedad',llaves);
    }
    
    configurar();
    
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=escolaridadnovedad&";
        url = url + "campos=codtipoideninsact,codempresaact,codtipoidentidadest,escidentificest,escvigencia,escnovconsec,escnovfecha,codtipoidentidad&";
        url = url + "campoLlave=codtipoideninsact,codempresaact,codtipoidentidadest,escidentificest,escvigencia,escnovconsec";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>