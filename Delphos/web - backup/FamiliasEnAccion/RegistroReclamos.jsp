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
		Calendar.setup({inputField : "reclamfecha",ifFormat : "%d/%m/%Y",button : "botonReclamfecha"});
	    }
			
			//totalidad de elementos en el form
            var cajas = new Array('reclamconsecs','reclamidentiper','reclamfecha','reclciclpago','reclarchdocu','reclamobserv');
            var combos = new Array('codunifamis','codtipoidentidadper','coddepartamento','codmunicipio','recclacodigo','numidentfunc');
			
            var arrayNonulos               	= new Array('reclamconsecs');
            var arrayNumerosEnteros        	= new Array('reclamconsecs','reclciclpago');
            var arrayCombos               	= new Array('codunifamis','codtipoidentidadper','coddepartamento','codmunicipio','recclacodigo','numidentfunc');
            var arrayCadenasANCod          	= new Array('reclamidentiper');
            var arrayCadenasA              	= null;
            var arrayComentarios           	= new Array('reclarchdocu','reclamobserv');
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
            <c:if test='${param.codunifami != null && param.reclamconsec != null && param.reclamconsec != ""}'>
            <sql:query var="r" sql="SELECT * FROM reclamo WHERE codunifami='${param.codunifami}' AND reclamconsec=${param.reclamconsec}" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codunifamif" value="${fila.codunifami}"/>
              <c:set var="reclamconsecf" value="${fila.reclamconsec}"/>
              <c:set var="codtipoidentidadper" value="${fila.codtipoidentidadper}"/>
              <c:set var="reclamidentiper" value="${fila.reclamidentiper}"/>
              <fmt:formatDate value="${fila.reclamfecha}" pattern="dd/MM/yyyy" var="reclamfecha"/>
              <c:set var="coddepartamento" value="${fila.coddepartamento}"/>
              <c:set var="codmunicipio" value="${fila.codmunicipio}"/>
              <c:set var="rectipcodigo" value="${fila.rectipcodigo}"/>              
              <c:set var="recclacodigo" value="${fila.recclacodigo}"/>
              <c:set var="reclciclpago" value="${fila.reclciclpago}"/>
              <c:set var="codtipoidentidad" value="${fila.codtipoidentidad}"/>
              <c:set var="numidentfunc" value="${fila.numidentfunc}"/>
              <c:set var="reclarchdocu" value="${fila.reclarchdocu}"/>
              <c:set var="reclamobserv" value="${fila.reclamobserv}"/>
              
               <%--Carga del archivo de la base de datos---------------------%>
              <%
              String ruta = request.getSession().getServletContext().getRealPath("temp")+"\\";
              ruta = ruta.replaceAll("\\\\","/");
              pageContext.setAttribute("ruta",ruta);
              %>
              <sql:query var="r" sql="select lo_export(reclamo.archivofi, '${ruta}${reclarchdocu}') from reclamo WHERE codunifami='${param.codunifami}' AND reclamconsec=${param.reclamconsec}" dataSource="jdbc/delphos" scope="page"/>
              <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <%------------------------------------------------------------%>
              </jsp2:forEach>
              <%------------------------------------------------------------%>
              
            </jsp2:forEach>
            
          <form name="formulario" method="post" action="RegistroReclamos.jsp">
          <span id="mensajeControlador">${msj}</span>
          <table width="801" border="0" class="tablaContenido">

              <tr>
                <td colspan="6"><div align="center"><span class="titulo1">Registro Reclamos</span></div></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td width="30">&nbsp;</td>
                <td width="115"><span class="bgDescTablas" style="width: 10%"><strong>C&oacute;digo &Uacute;nico Familia</strong></span></td>
                <td width="180"><label>
                <select name="codunifamis" id="codunifamis" style="width: 150px">
                  <option id="codunifamis" value=""></option>
                  <sql:query var="r" sql="select codunifami from inscripcion" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                    <c:choose>
                      <c:when test='${fila.codunifami == codunifamif}'>
                        <option value="${fila.codunifami}" selected="selected">${fila.codunifami}</option>
                      </c:when>
                      <c:otherwise>
                        <option value="${fila.codunifami}">${fila.codunifami}</option>
                      </c:otherwise>
                    </c:choose>
                  </jsp2:forEach>
                </select>
                </label></td>
                <td width="25">&nbsp;</td>
                <td width="145"><span class="bgDescTablas" style="width: 10%"><strong>Consecutivo Reclamo</strong></span></td>
                <td width="164"><span class="sinBgDescTablas" style="width: 15%">
                  <input name="reclamconsecs" type="text" id="reclamconsecs" value="${reclamconsecf}" size="20" maxlength="9" onkeypress="javascript:return permite(event, 'nume')"/>
                </span></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><span class="bgDescTablas" style="width: 20%"><strong>Tipo Id.</strong></span></td>
                <td><span class="sinBgDescTablas" style="width: 20%">
                  <select name="codtipoidentidadper" id="codtipoidentidadper" style="width: 150px">
                   <option id="codtipoidentidadper" value=""></option>
                  <sql:query var="r" sql="select codtipoidentidad, descripcion from tipoidentificacion" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                   <c:choose>
                        <c:when test='${fila.codtipoidentidad == codtipoidentidad}'>
                        <option value="${fila.codtipoidentidad}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                    <c:otherwise>
                        <option value="${fila.codtipoidentidad}">${fila.descripcion}</option>
                    </c:otherwise>
                   </c:choose>
                 </jsp2:forEach>
                  </select>
                </span></td>
                <td>&nbsp;</td>
                <td><span class="bgDescTablas" style="width: 10%"><strong> Nro. Identificaci&oacute;n</strong></span></td>
                <td><span class="sinBgDescTablas" style="width: 20%">
                  <input name="reclamidentiper" type="text" id="reclamidentiper" value="${reclamidentiper}" size="20" maxlength="18" onkeypress="javascript:return permite(event, 'num_car_cod')"/>
                </span></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">Departamento</strong></td>
                <td><select name="coddepartamento" id="coddepartamento" onchange="cargarMunicipios();" style="width: 150px">
                  <option value=""></option>
                  <sql:query var="r" sql="select coddepartamento, nombre from departamento order by nombre" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                    <c:choose>
                      <c:when test='${fila.coddepartamento == coddepartamento}'>
                        <option value="${fila.coddepartamento}" selected="selected">${fila.nombre}</option>
                      </c:when>
                      <c:otherwise>
                        <option value="${fila.coddepartamento}">${fila.nombre}</option>
                      </c:otherwise>
                    </c:choose>
                  </jsp2:forEach>
                </select></td>
                <td>&nbsp;</td>
                <td><span class="bgDescTablas"><strong>Municipio</strong></span></td>
                <td><span id="spanMunicipio">
                    <c:choose>
                        <c:when test="${codmunicipio != null}">
                        <select name="codmunicipio" id="codmunicipio" style="width: 150px">
                        <option value=""></option>
                        <sql:query var="r" sql="select codmunicipio, nombre from municipio where coddepartamento='${coddepartamento}' order by nombre" dataSource="jdbc/delphos" scope="page"/>
                        <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                        <c:choose>
                            <c:when test='${fila.codmunicipio == codmunicipio}'>
                            <option value="${fila.codmunicipio}" selected="selected">${fila.nombre}</option>
                            </c:when>
                            <c:otherwise>
                            <option value="${fila.codmunicipio}">${fila.nombre}</option>
                            </c:otherwise>
                        </c:choose>
                        </jsp2:forEach>
                        </select>                        
                        </c:when>
                        <c:otherwise>
                        <select disabled style="width: 150px">
                            <option value=""></option>
                        </select>
                        </c:otherwise>
                    </c:choose>
                </span></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><span class="bgDescTablas" style="width: 10%"><strong>Fecha</strong></span></td>
                <td><span class="sinBgDescTablas" style="width: 20%">
                  <input name="reclamfecha" type="text" id="reclamfecha" value="${reclamfecha}" size="15" readonly="true" />
                  <span class="sinBgDescTablas" style="width: 20%">
                  <input name="button" type="button" id="botonReclamfecha" value="..." />
                </span></span></td>
                <td>&nbsp;</td>
                <td><span class="bgDescTablas" style="width: 10%"><strong>Clasificaci&oacute;n</strong></span></td>
                <td><span class="sinBgDescTablas" style="width: 20%">
                  <select name="recclacodigo" id="recclacodigo" style="width: 150px">
                   <option id="recclacodigo" value=""></option>
                  <sql:query var="r" sql="select rectipcodigo, recclacodigo, reccladescri from reclamoclasificacion" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                   <c:choose>
                        <c:when test='${fila.rectipcodigo == rectipcodigo && fila.recclacodigo == recclacodigo}'>
                        <option value="${fila.rectipcodigo} ${fila.recclacodigo}" selected="selected">${fila.reccladescri}</option>
                        </c:when>
                    <c:otherwise>
                        <option value="${fila.rectipcodigo} ${fila.recclacodigo}">${fila.reccladescri}</option>
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
                <td>&nbsp;</td>
                <td><span class="bgDescTablas" style="width: 10%"><strong>Ciclo Pago Afectado</strong></span></td>
                <td><span class="sinBgDescTablas" style="width: 20%">
                  <input name="reclciclpago" type="text" id="reclciclpago" value="${reclciclpago}" size="20" onkeypress="javascript:return permite(event, 'nume')"/>
                </span></td>
                <td>&nbsp;</td>
                <td><span class="bgDescTablas"><strong>Recibido por</strong></span></td>
                <td><span class="sinBgDescTablas" style="width: 20%">
                  <select name="numidentfunc" id="numidentfunc" style="width: 150px">
                    <option id="numidentfunc" value=""></option>
                    <sql:query var="r" sql="select codtipoidentidad, numidentfunc, nombre from funcionario" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.codtipoidentidad == codtipoidentidad && fila.numidentfunc == numidentfunc}'>
                          <option value="${fila.codtipoidentidad} ${fila.numidentfunc}" selected="selected">${fila.nombre}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.codtipoidentidad} ${fila.numidentfunc}">${fila.nombre}</option>
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
                <td>&nbsp;</td>
                <td><span class="bgDescTablas" style="width: 10%"><strong>Archivo Documento</strong></span></td>
                <td colspan="4"><span class="sinBgDescTablas" style="width: 20%">
                  <input name="reclarchdocu" type="text" id="reclarchdocu" size="15"  value="${reclarchdocu}" readonly="readonly"/>
                  <a href="#" onclick="abrirCargaArchivo();"><img src="../images/Buscar16x16.gif" alt="Cargar Archivo" border="0" tabindex="4"/></a>
                  <c:if test='${reclarchdocu != null && reclarchdocu != ""}'><br />
                    <a href="../temp/${reclarchdocu}" target="_blank">Descargar ${reclarchdocu}</a> </c:if>
                </span></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td colspan="6"><p align="center" class="bgDescTablas"><strong>Observaciones</strong></p>
                  <p align="center" class="tablaContenido"> 
                    <textarea name="reclamobserv" cols="75" rows="3" id="reclamobserv" onkeypress="javascript:return permite(event, 'com')">${reclamobserv}</textarea>
                  </p></td>
              </tr>
             <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="codunifami" id="codunifami" value="" >
                  <input type="hidden" name="reclamconsec" id="reclamconsec" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="17"> -->
		  <label>&nbsp;</label>
		  <!--<input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="14"/>
		  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="15"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="16"/> -->
                  <jsp:include page="../BarraNavegacion.jsp?tabBuscar=17&tabGuardar=14&tabEditar=15&tabEliminar=16" />
               </div>            </td>
           </tr>
          </table>
        </form>
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
    function abrirCargaArchivo()
    {
        var url;
        url = "PopUpCargaArchivo.jsp?";
        url = url + "campo=reclarchdocu";
        
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
        llaves = 'codunifami='+document.getElementById('codunifamis').value+',';
        llaves+= 'reclamconsec='+document.getElementById('reclamconsecs').value;
        validarLlave('reclamo',llaves);
    }
    
    configurar();
    
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=reclamo&";
        url = url + "campos=codunifami,reclamconsec,codtipoidentidadper,reclamidentiper,reclamfecha,coddepartamento,codmunicipio,rectipcodigo&";
        url = url + "campoLlave=codunifami,reclamconsec";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

    var req;

    function cargarMunicipios() 
    {
       var departamento = document.getElementById("coddepartamento");
       var url = "../ServletSeleccionarMunicipios?codDepartamento=" + encodeURIComponent(departamento.value);
       if (typeof XMLHttpRequest != "undefined") 
           req = new XMLHttpRequest();
       else if (window.ActiveXObject) 
           req = new ActiveXObject("Microsoft.XMLHTTP");
       req.open("GET", url, true);
       req.onreadystatechange = callbackSeleccionarMunicipios;
       req.send(null);
    }

    function callbackSeleccionarMunicipios() 
    {
        if (req.readyState == 4) 
            if (req.status == 200) 
                obtenerListadoMunicipios();
    }

    function obtenerListadoMunicipios()
    {
        var mdiv = document.getElementById("spanMunicipio");
        var select, xmlMunicipios, i, cantMunicipios, municipio, codMunicipio;

        xmlMunicipios = req.responseXML.getElementsByTagName("municipios")[0];
        cantMunicipios = xmlMunicipios.getElementsByTagName("municipio").length;

        select = "<select name=\"codmunicipio\" id=\"codmunicipio\">";
        select = select + "<option value=\"\">Seleccione el Municipio</option>";
        for(i=0; i<cantMunicipios; i++ )
        {
            codMunicipio = xmlMunicipios.getElementsByTagName("codMunicipio")[i];
            nombre = xmlMunicipios.getElementsByTagName("nombre")[i];

            select = select+"<option value=\""+codMunicipio.childNodes[0].nodeValue+"\">"+nombre.childNodes[0].nodeValue+"</option>";
        }
        select = select+"</select>";
        mdiv.innerHTML = select;
    }
</script>
</body>
</html>