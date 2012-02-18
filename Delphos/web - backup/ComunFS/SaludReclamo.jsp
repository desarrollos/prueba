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
            Calendar.setup({inputField : "salrecfecha",ifFormat : "%d/%m/%Y",button : "botonSalrecfecha"});
        }
            //totalidad de elementos en el form
            var cajas = new Array('salrecid','salrecidentidadper','salrecfecha','salrecarchivo','salrecobservacion');
            var combos = new Array('codtipoidentidadper','coddepartamento','codmunicipio','recclacodigo','numidentfunc');
                      
            //validar
            var arrayNonulos               = new Array('salrecid');
            var arrayNumerosEnteros        = new Array('salrecid');
            var arrayCombos                = new Array('codtipoidentidadper','coddepartamento','codmunicipio','recclacodigo','numidentfunc');
            var arrayCadenasANCod          = new Array('salrecidentidadper');
            var arrayCadenasA              = null;
            var arrayComentarios           = new Array('salrecarchivo','salrecobservacion');
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
            <c:if test='${param.llave != null && param.llave !=""}'>
            <sql:query var="r" sql="SELECT * FROM saludreclamo WHERE salrecid=${param.llave}" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              
              <c:set var="salrecid" value="${fila.salrecid}"/>
              <c:set var="codtipoidentidadper" value="${fila.codtipoidentidadper}"/>
              <c:set var="salrecidentidadper" value="${fila.salrecidentidadper}"/>
              <fmt:formatDate value="${fila.salrecfecha}" pattern="dd/MM/yyyy" var="salrecfecha"/>
              <c:set var="coddepartamento" value="${fila.coddepartamento}"/>
              <c:set var="codmunicipio" value="${fila.codmunicipio}"/>
              <c:set var="rectipcodigo" value="${fila.rectipcodigo}"/>              
              <c:set var="recclacodigo" value="${fila.recclacodigo}"/>
              <c:set var="codtipoidentidad" value="${fila.codtipoidentidad}"/>
              <c:set var="numidentfunc" value="${fila.numidentfunc}"/>
              <c:set var="salrecarchivo" value="${fila.salrecarchivo}"/>
              <c:set var="salrecobservacion" value="${fila.salrecobservacion}"/>
              
              <%--Carga del archivo de la base de datos---------------------%>
              <%
              String ruta = request.getSession().getServletContext().getRealPath("temp")+"\\";
              ruta = ruta.replaceAll("\\\\","/");
              pageContext.setAttribute("ruta",ruta);
              %>
              <sql:query var="r" sql="select lo_export(saludreclamo.archivofi, '${ruta}${salrecarchivo}') from saludreclamo where salrecid=${param.llave}" dataSource="jdbc/delphos" scope="page"/>
              <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <%------------------------------------------------------------%>
              </jsp2:forEach>
              <%------------------------------------------------------------%>
              
            </jsp2:forEach>
            
          <table width="801" border="0" class="tablaContenido">
          <span id="mensajeControlador">${msj}</span>
			<form name="formulario" method="post" action="SaludReclamo.jsp">
              <tr>
                <td colspan="6"><div align="center"><span class="titulo1">Registro Reclamos Salud</span></div></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td width="30">&nbsp;</td>
                <td width="115"><span class="bgDescTablas" style="width: 10%"><strong>Consecutivo Reclamo</strong></span></td>
                <td colspan="4"><label><span class="sinBgDescTablas" style="width: 15%">
                  <input name="salrecid" type="text" id="salrecid" value="${salrecid}" size="20" maxlength="9" />
                </span></label></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><span class="bgDescTablas" style="width: 20%"><strong>Tipo Id.</strong></span></td>
                <td width="183"><span class="sinBgDescTablas" style="width: 20%">
                  <select name="codtipoidentidadper" id="codtipoidentidadper" style="width: 150px">
                   <option id="codtipoidentidadper" value=""></option>
                  <sql:query var="r" sql="select codtipoidentidad, descripcion from tipoidentificacion" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                   <c:choose>
                        <c:when test='${fila.codtipoidentidad == codtipoidentidadper}'>
                        <option value="${fila.codtipoidentidad}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                    <c:otherwise>
                        <option value="${fila.codtipoidentidad}">${fila.descripcion}</option>
                    </c:otherwise>
                   </c:choose>
                 </jsp2:forEach>
                  </select>
                </span></td>
                <td width="22">&nbsp;</td>
                <td width="145"><span class="bgDescTablas" style="width: 10%"><strong> Nro. Identificaci&oacute;n</strong></span></td>
                <td width="164"><span class="sinBgDescTablas" style="width: 20%">
                  <input name="salrecidentidadper" type="text" id="salrecidentidadper" value="${salrecidentidadper}" size="20" maxlength="18" />
                </span></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">Departamento</strong></td>
                <td><select name="coddepartamento" id="coddepartamento" onChange="cargarMunicipios();" style="width: 150px">
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
                <td class="bgDescTablas"><strong>Funcionario:</strong></td>
                <td><span class="sinBgDescTablas" style="width: 18%">
                  <select name="numidentfunc2" id="numidentfunc2" style="width: 150px">
                    <option id="numidentfunc2" value=""></option>
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
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><span class="bgDescTablas" style="width: 10%"><strong>Fecha</strong></span></td>
                <td><span class="sinBgDescTablas" style="width: 20%">
                  <input name="salrecfecha" type="text" id="salrecfecha" value="${salrecfecha}" size="18" readonly="true" />
                  <span class="sinBgDescTablas" style="width: 20%">
                  <input name="button" type="button" id="botonSalrecfecha" value="..." />
                </span></span></td>
                <td>&nbsp;</td>
                <td><span class="bgDescTablas" style="width: 10%"><strong>Clasificaci&oacute;n</strong></span></td>
                <td><span class="sinBgDescTablas" style="width: 20%">
                  <select name="recclacodigo" id="recclacodigo" style="width: 150px">
                   <option id="recclacodigo" value=""></option>
                  <sql:query var="r" sql="select rectipcodigo, recclacodigo, reccladescri from reclamoclasificacion" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                   <c:choose>
                        <c:when test='${fila.rectipcodigo == rectipcodigo && recclacodigo == recclacodigo}'>
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
                <td><span class="bgDescTablas"><strong>Recibido por</strong></span></td>
                <td><span class="sinBgDescTablas" style="width: 20%">
                  <select name="numidentfunc" id="numidentfunc" style="width: 150px">
                    <option id="numidentfunc" value=""></option>
                    <sql:query var="r" sql="select codtipoidentidad, numidentfunc, nombre from funcionario" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.codtipoidentidad == codtipoidentidad &&  fila.numidentfunc == numidentfunc}'>
                          <option value="${fila.codtipoidentidad} ${fila.numidentfunc}" selected="selected">${fila.nombre}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.codtipoidentidad} ${fila.numidentfunc}">${fila.nombre}</option>
                        </c:otherwise>
                      </c:choose>
                    </jsp2:forEach>
                  </select>
                </span></td>
                <td>&nbsp;</td>
                <td><span class="bgDescTablas" style="width: 10%"><strong>Archivo Documento</strong></span></td>
                <td><span class="sinBgDescTablas" style="width: 20%">
                  <input name="salrecarchivo" type="text" id="salrecarchivo" size="15"  value="${salrecarchivo}" readonly="readonly"/>
                  <a href="#" onClick="abrirCargaArchivo();"><img src="../images/Buscar16x16.gif" alt="Cargar Archivo" border="0"/></a>
                  <c:if test='${salrecarchivo != null && salrecarchivo != ""}'><br>
                    <a href="../temp/${salrecarchivo}" target="_blank">Descargar ${salrecarchivo}</a> </c:if>
                </span></td>
              </tr>

              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td colspan="6"><p align="center" class="bgDescTablas"><strong>Observaciones</strong></p>
                  <p align="center" class="tablaContenido"> 
                    <textarea name="salrecobservacion" cols="75" rows="3" id="salrecobservacion">${salrecobservacion}</textarea>
                  </p></td>
              </tr>
           <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="llave" id="llave" value="" >
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
        llaves = 'salrecid='+document.getElementById('salrecid').value;
        validarLlave('saludreclamo',llaves);
    }
    
    function abrirCargaArchivo()
    {
        var url;
        url = "PopUpCargaArchivo.jsp?";
        url = url + "campo=salrecarchivo";
        
        window.open(url,"_blank","width=500,height=190,scrollbars=1,left=350,top=100");
    }
	
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=saludreclamo&";
        url = url + "campos=salrecid,salrecidentidadper,salrecfecha,coddepartamento,codmunicipio,recclacodigo,codtipoidentidad,numidentfunc&";
        url = url + "campoLlave=salrecid";
        
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