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
            
            //totalidad de elementos en el form
            var cajas = null;
            var combos = new Array('codareageograficas','coddepartamentos','codmunicipios');
            
            //validar
            var arrayNonulos               	= null;
            var arrayNumerosEnteros        	= null;
            var arrayCombos               	= new Array('codareageograficas','coddepartamentos','codmunicipios');
            var arrayCadenasANCod          	= null;
            var arrayCadenasA              	= null;
            var arrayComentarios           	= null;
            var arrayNumerosDoubles             = null;
            
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
            <c:if test='${param.codareageografica != null && param.coddepartamento != null && param.codmunicipio != null && param.codareageografica != "" && param.coddepartamento != "" && param.codmunicipio != ""}'>
            <sql:query var="r" sql="SELECT * FROM agrupaciongeomunicipio WHERE codareageografica=${param.codareageografica} AND coddepartamento=${param.coddepartamento} AND codmunicipio=${param.codmunicipio}" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codareageograficaf" value="${fila.codareageografica}"/> 
              <c:set var="coddepartamentof" value="${fila.coddepartamento}"/>  
              <c:set var="codmunicipiof" value="${fila.codmunicipio}"/>   
            </jsp2:forEach>
            
            <form name="formulario" id="formulario" method="post" action="AgrupacionGeoMunicipio.jsp">
            <table width="811" border="0" class="tablaContenido">
              <span id="mensajeControlador">${msj}</span>
              <tr>
                <td colspan="6"><div align="center" class="titulo1">Agrupaci&oacute;n Geogr&aacute;fica Municipio</div></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">Agrupac&iacute;on Geografica</strong></td>
                <td colspan="4"><span class="bgDescTablas">
                  <select name="codareageograficas" id="codareageograficas" style="width: 150px" tabindex="1">
                    <option id="codareageograficas" value=""></option>
                    <sql:query var="r" sql="select codareageografica, descripcion from agrupaciongeografica" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.codareageografica == codareageograficaf}'>
                          <option value="${fila.codareageografica}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.codareageografica}">${fila.descripcion}</option>
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
                <td width="30">&nbsp;</td>
                <td width="139"><strong class="bgDescTablas">Departamento</strong></td>
                <td width="190">
                    <select name="coddepartamentos" id="coddepartamentos" onChange="cargarMunicipios();" style="width: 150px" tabindex="2">
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
                <td width="11">&nbsp;</td>
                <td width="132"><strong class="bgDescTablas">Municipio</strong></td>
                <td width="174">
                <span id="spanMunicipio">
                    <c:choose>
                        <c:when test="${codmunicipiof != null}">
                        <select name="codmunicipios" id="codmunicipios" style="width: 150px" tabindex="3">
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
                          <select name="select" disabled>
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
                <td colspan="6"><div align="center">
                  <input type="hidden" name="codareageografica" id="codareageografica" value="" >
                  <input type="hidden" name="coddepartamento" id="coddepartamento" value="" >
                  <input type="hidden" name="codmunicipio" id="codmunicipio" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="7"> -->
		  <label>&nbsp;</label>
                  <!--<input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="4"/>
                  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="5"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="6"/> -->
                  <jsp:include page="../BarraNavegacion.jsp?tabBuscar=17&tabGuardar=14&tabEditar=15&tabEliminar=16" />
               </div>            </td>
           </tr>
          </table>
        </form>
        </center>
        
    </td>
</tr>
<tr>
    <td">
        <jsp:include page="../footer.jsp" />    </td>
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
        llaves = 'codareageografica='+document.getElementById('codareageograficas').value+',';
        llaves+= 'coddepartamento='+document.getElementById('coddepartamentos').value+',';
        llaves+= 'codmunicipio='+document.getElementById('codmunicipios').value;
        validarLlave('agrupaciongeomunicipio',llaves);
    } 
    
    //
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=agrupaciongeomunicipio&";
        url = url + "campos=codareageografica,coddepartamento,codmunicipio&";
        url = url + "campoLlave=codareageografica,coddepartamento,codmunicipio";
        
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