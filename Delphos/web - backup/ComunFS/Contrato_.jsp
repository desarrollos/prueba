<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<%@ taglib prefix="jsp2" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>

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
            var cajas = null;
            var combos = null;
                      
            //validar
            var arrayNonulos               = null;
            var arrayNumerosEnteros        = null;
            var arrayCombos                = null;
            var arrayCadenasANCod          = null;
            var arrayCadenasA              = null;
            var arrayComentarios           = null;
            var arrayNumerosDoubles        = null;
            
	</script>
</head>
<body bgcolor="#FFFFFF" onLoad="borrarMensaje(cajas[0]);">
<center>
<table id="Table_01" width="906" style="height: 780; border: 0px" cellpadding="0" cellspacing="0">
<tr>
    <td colspan="3">
        <img src="../images/cabezote.png" width="906" height="150" alt="" />
    </td>
</tr>
<%-- Datos sesion --%>
<tr valign="top">
    <td colspan="3" width="906" height="16" style="background: url('../images/panel_02.gif')" align="right">
        <span class="textoPequeno"><%=request.getSession().getAttribute("nombre")%> <%=request.getSession().getAttribute("apellido")%></span><a href="../logout.jsp"><img src="../images/log_out.png" border="0" alt="Cerrar sesion" width="20" height="20" /></a>
    </td>
</tr>
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
            <c:if test="${param.codregimenes != null && param.codentidadsalud != null && param.codcontrato != null}">
            <sql:query var="r" sql="SELECT * FROM contrato WHERE codregimenes='${param.codregimenes}' AND codentidadsalud='${param.codentidadsalud}' AND codcontrato='${param.codcontrato}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codregimenes" value="${fila.codregimenes}"/>
              <c:set var="codentidadsalud" value="${fila.codentidadsalud}"/>
              <c:set var="codcontrato" value="${fila.codcontrato}"/>
              <c:set var="numero" value="${fila.numero}"/>
              <c:set var="descripcion" value="${fila.descripcion}"/>           
              <c:set var="objeto" value="${fila.objeto}"/>
              <fmt:formatDate value="${fila.fechainicio}" pattern="dd/MM/yyyy" var="fechainicio"/>
              <fmt:formatDate value="${fila.fechafinal}" pattern="dd/MM/yyyy" var="fechafinal"/>
              <c:set var="codtipocontrato" value="${fila.codtipocontrato}"/>
              <c:set var="codgrupopoblacion" value="${fila.codgrupopoblacion}"/>
              <c:set var="codaplicacioncontrato" value="${fila.codaplicacioncontrato}"/>
              <c:set var="codclasecontrato" value="${fila.codclasecontrato}"/>
              <c:set var="codtipocubrimupc" value="${fila.codtipocubrimupc}"/>
              <c:set var="anyoinicial" value="${fila.anyoinicial}"/>
              <c:set var="mesinicial" value="${fila.mesinicial}"/>
              <c:set var="codestadocontrato" value="${fila.codestadocontrato}"/>
              <c:set var="formapago" value="${fila.formapago}"/>
              <c:set var="coddepartamento" value="${fila.coddepartamento}"/>
              <c:set var="codmunicipio" value="${fila.codmunicipio}"/>
              <c:set var="valor" value="${fila.valor}"/>
              <c:set var="archivo" value="${fila.archivo}"/>
              <c:set var="codigobarras" value="${fila.codigobarras}"/>
              <fmt:formatDate value="${fila.fechalegalizac}" pattern="dd/MM/yyyy" var="fechalegalizac"/>
              <c:set var="observacion" value="${fila.observacion}"/>
              <c:set var="codmodalidadcontrato" value="${fila.codmodalidadcontrato}"/>
              <c:set var="codtiponorma" value="${fila.codtiponorma}"/>
              <c:set var="codnorma" value="${fila.codnorma}"/>
              <c:set var="fechanorma" value="${fila.fechanorma}"/>
              <c:set var="nroradicacion" value="${fila.nroradicacion}"/>
              <fmt:formatDate value="${fila.fechasuscripcion}" pattern="dd/MM/yyyy" var="fechasuscripcion"/>
              <c:set var="codtipoidencontratante" value="${fila.codtipoidencontratante}"/>
              <c:set var="codemprcontratante" value="${fila.codemprcontratante}"/>
              <c:set var="codtipoidencontratista" value="${fila.codtipoidencontratista}"/>
              <c:set var="codemprcontratista" value="${fila.codemprcontratista}"/>
              <c:set var="usuariosconttrato" value="${fila.usuariosconttrato}"/>              
                        
              <%--Carga del archivo de la base de datos---------------------%>
              <%
              String ruta = request.getSession().getServletContext().getRealPath("temp")+"\\";
              ruta = ruta.replaceAll("\\\\","/");
              pageContext.setAttribute("ruta",ruta);
              %>
              <sql:query var="r" sql="select lo_export(contrato.archivofi, '${ruta}${archivo}') from contrato where codregimenes='${param.codregimenes}' AND codentidadsalud='${param.codentidadsalud}' AND codcontrato='${param.codcontrato}'" dataSource="jdbc/delphos" scope="page"/>
              <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <%------------------------------------------------------------%>
              </jsp2:forEach>
              <%------------------------------------------------------------%>
              
            </jsp2:forEach>
        
                <div style="margin-left: -5px; padding-left: 20px; text-align: left; background: url('../images/panel_02.gif'); width: 665">
                    <span class="pestana" onclick="animatedcollapse.show('layerDatosBasicos')">Datos Basicos</span>
                    | <span class="pestana" onclick="animatedcollapse.show('layerDatosContractuales')">Datos Contractuales</span>
                    | 
                </div>

                
                <form name="formulario" method="post" action="Contrato.jsp">
                    <div id="layerDatosBasicos"><%@include file="Contrato/DatosBasicos.jspf" %></div>
                    <div id="layerDatosContractuales" style="display:none"><%@include file="Contrato/DatosContractuales.jspf" %></div>
            <tr>
                <td colspan="3"><div align="center">
                  <input type="hidden" name="llave" id="llave" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <input type="button" onClick="buscar();" value="Buscar" tabindex="6">
		  <label>&nbsp;</label>
                  <input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="3" />
                  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="4"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="5"/>
               </div>
            </td>
           </tr>
	</form>
       </table>
     </center>
        
    </td>
</tr>
<tr>
    <td colspan="3">
        <img src="../images/panel_06.gif" width="906" height="1" alt="">
    </td>
</tr>
<tr>
    <td height="42" colspan="3">
        <img src="../images/panel_07.gif" width="906" height="23" alt="">    </td>
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
        llaves = 'codactividadeconomica='+document.getElementById('codactividadeconomica').value;
        validarLlave('actividadeconomica',llaves);
    }
    
    function abrirCargaArchivo()
    {
        var url;
        url = "PopUpCargaArchivo.jsp?";
        url = url + "campo=archivo";
        
        window.open(url,"_blank","width=500,height=190,scrollbars=1,left=350,top=100");
    }
	
	function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=contrato&";
        url = url + "campos=codregimenes,codentidadsalud,codcontrato,codregimen,numero,descripcion,objeto,fechainicio&";
        url = url + "campoLlave=codregimenes,codentidadsalud,codcontrato";
        
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
    
    select = "<select name=\"codmunicipio\" id=\"codmunicipio\" style=\"width:150px\">";
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
