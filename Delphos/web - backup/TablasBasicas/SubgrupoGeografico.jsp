<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<%@ taglib prefix="jsp2" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
clases.VerificarUsuarioSistema v;
v = new clases.VerificarUsuarioSistema(request,response);
%>

<html>
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
            var cajas = new Array('codsubgrupos','nombre','representante','habitantes','mapa');
            var combos = new Array('coddepartamentos','codmunicipios','codtiposubgrupogeo');
            
            //validar
            var arrayNonulos               	= new Array('codsubgrupos');
            var arrayNumerosEnteros        	= new Array('codsubgrupos','habitantes');
            var arrayCombos               	= new Array('coddepartamentos','codmunicipios','codtiposubgrupogeo');
            var arrayCadenasANCod          	= null;
            var arrayCadenasA              	= null;
            var arrayComentarios           	= new Array('nombresubgrupo','representante');
            var arrayNumerosDoubles             = null;

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
            <c:if test='${param.coddepartamento != null && param.codmunicipio != null && param.codsubgrupo != null && param.coddepartamento != "" && param.codmunicipio != "" && param.codsubgrupo != ""}'>
            <sql:query var="r" sql="SELECT * FROM subgrupogeografico WHERE coddepartamento=${param.coddepartamento} AND codmunicipio=${param.codmunicipio} AND codsubgrupo=${param.codsubgrupo}" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="coddepartamentof" value="${fila.coddepartamento}"/> 
              <c:set var="codmunicipiof" value="${fila.codmunicipio}"/>  
              <c:set var="codsubgrupof" value="${fila.codsubgrupo}"/>
              <c:set var="codtiposubgrupogeo" value="${fila.codtiposubgrupogeo}"/>
              <c:set var="nombresubgrupo" value="${fila.nombre}"/>
              <c:set var="habitantes" value="${fila.habitantes}"/>
              <c:set var="representante" value="${fila.representante}"/>
              <c:set var="mapa" value="${fila.mapa}"/>
              
              <%--Carga del archivo de la base de datos---------------------%>
              <%
              String ruta = request.getSession().getServletContext().getRealPath("temp")+"\\";
              ruta = ruta.replaceAll("\\\\","/");
              pageContext.setAttribute("ruta",ruta);
              %>
              <sql:query var="r" sql="select lo_export(subgrupogeografico.archivofi, '${ruta}${mapa}') from subgrupogeografico where coddepartamento='${param.coddepartamento}' AND codmunicipio='${param.codmunicipio}' AND codsubgrupo='${param.codsubgrupo}'" dataSource="jdbc/delphos" scope="page"/>
              <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <%------------------------------------------------------------%>
              </jsp2:forEach>
              <%------------------------------------------------------------%>
               
            </jsp2:forEach>
            
            <form name="formulario" id="formulario" method="post" action="SubgrupoGeografico.jsp">
            <table width="811" border="0" class="tablaContenido">
              <span id="mensajeControlador">${msj}</span>
              <tr>
                <td colspan="6"><div align="center" class="titulo1">Subgrupo Geografico</div></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td width="30">&nbsp;</td>
                <td width="126"><strong class="bgDescTablas">Departamento</strong></td>
                <td width="144"><select name="coddepartamentos" id="coddepartamentos" onChange="cargarMunicipios();" style="width: 150px" tabindex="1">
                  <option value=""></option>
                  <sql:query var="r" sql="select coddepartamento, nombre from departamento order by nombre" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                   <c:choose>
                        <c:when test='${fila.coddepartamento == coddepartamentof}'>
                        <option value="${fila.coddepartamento}" selected="selected">${fila.nombre}</option>
                        </c:when>
                    <c:otherwise>
                        <option value="${fila.coddepartamento}">${fila.nombre}</option>
                    </c:otherwise>
                   </c:choose>
                 </jsp2:forEach>
                </select></td>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">Municipio</strong></td>
                <td>
                <span id="spanMunicipio">
                    <c:choose>
                        <c:when test="${codmunicipiof != null}">
                        <select name="codmunicipios" id="codmunicipios" style="width: 150px" tabindex="2">
                        <option value=""></option>
                        <sql:query var="r" sql="select codmunicipio, nombre from municipio where coddepartamento='${coddepartamentof}' order by nombre" dataSource="jdbc/delphos" scope="page"/>
                        <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                        <c:choose>
                            <c:when test='${fila.codmunicipio == codmunicipiof}'>
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
                        <select disabled>
                            <option value=""></option>
                        </select>
                        </c:otherwise>
                    </c:choose>
                </span>                </td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><span class="bgDescTablas"><strong>C&oacute;digo Comuna</strong></span></td>
                <td><input name="codsubgrupos" type="text" id="codsubgrupos" value="${codsubgrupof}" size="20" maxlength="6" onKeyPress="javascript:return permite(event, 'nume')" tabindex="3"/></td>
                <td width="27">&nbsp;</td>
                <td width="120"><span class="bgDescTablas"><strong>Tipo Subgrupo</strong></span></td>
                <td width="198"><select name="codtiposubgrupogeo" id="codtiposubgrupogeo" style=" width: 150px" tabindex="4">
                  <option id="codtiposubgrupogeo" value=""></option>
                  <sql:query var="r" sql="select codtiposubgrupogeo, descripcion from tiposubgrupogeo" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                    <c:choose>
                      <c:when test='${fila.codtiposubgrupogeo == codtiposubgrupogeo}'>
                        <option value="${fila.codtiposubgrupogeo}" selected="selected">${fila.descripcion}</option>
                      </c:when>
                      <c:otherwise>
                        <option value="${fila.codtiposubgrupogeo}">${fila.descripcion}</option>
                      </c:otherwise>
                    </c:choose>
                  </jsp2:forEach>
                </select></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><span class="bgDescTablas" style="width: 7%"><strong>Nombre</strong></span></td>
                <td><span class="sinBgDescTablas" style="width: 20%">
                  <input name="nombresubgrupo" type="text" id="nombresubgrupo" value="${nombresubgrupo}" size="20" maxlength="40" onKeyPress="javascript:return permite(event, 'carac')" tabindex="5"/>
                </span></td>
                <td>&nbsp;</td>
                <td><span class="bgDescTablas"><strong>Habitantes</strong></span></td>
                <td><span class="sinBgDescTablas">
                </span>
                  <label>
                  <input name="habitantes" type="text" id="habitantes" value="${habitantes}" size="20" maxlength="8" onKeyPress="javascript:return permite(event, 'nume')" tabindex="6"/>
                  </label></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas"><label></label></td>
                <td class="bgDescTablas"><strong>Representante</strong></td>
                <td class="bgDescTablas"><input name="representante" type="text" id="representante" value="${representante}" size="20" maxlength="60" onKeyPress="javascript:return permite(event, 'carac')" tabindex="7"/></td>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>Mapa</strong></td>
                <td class="bgDescTablas"><span class="sinBgDescTablas" style="width: 20%">
                  <input name="mapa" type="text" id="mapa" size="15"  value="${mapa}" readonly="readonly"/>
                  <a href="#" onClick="abrirCargaArchivo();" tabindex="8"><img src="../images/Buscar16x16.gif" alt="Cargar Archivo" border="0"/></a>
                  <c:if test='${mapa != null && mapa != ""}'><br>
                    <a href="../temp/${mapa}" target="_blank">Descargar ${mapa}</a> </c:if>
                </span></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="coddepartamento" id="coddepartamento" value="" >
                  <input type="hidden" name="codmunicipio" id="codmunicipio" value="" >
                  <input type="hidden" name="codsubgrupo" id="codsubgrupo" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="12">-->
		  <label>&nbsp;</label>
                  <!--<input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="9"/>
                  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="10"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="11"/>-->
				  <jsp:include page="../BarraNavegacion.jsp?tabBuscar=17&tabGuardar=14&tabEditar=15&tabEliminar=16" />
               </div>
            </td>
           </tr>
          </table>
        </form>
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
       
    function abrirCargaArchivo()
    {
        var url;
        url = "PopUpCargaArchivo.jsp?";
        url = url + "campo=mapa";
        
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
        llaves = 'coddepartamento='+document.getElementById('coddepartamentos').value+',';
        llaves+= 'codmunicipio='+document.getElementById('codmunicipios').value+',';
        llaves+= 'codsubgrupo='+document.getElementById('codsubgrupos').value;
        validarLlave('subgrupogeografico',llaves);
    } 
    
    //
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=subgrupogeografico&";
        url = url + "campos=coddepartamento,codmunicipio,codsubgrupo,codtiposubgrupogeo,nombre,representante,habitantes,mapa&";
        url = url + "campoLlave=coddepartamento,codmunicipio,codsubgrupo";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

var req;

function cargarMunicipios() 
{
   var departamento = document.getElementById("coddepartamentos");
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
    
    select = "<select name=\"codmunicipios\" id=\"codmunicipios\" style=\"width:150px\">";
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