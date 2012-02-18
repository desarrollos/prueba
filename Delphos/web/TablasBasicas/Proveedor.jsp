<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<%@ taglib prefix="jsp2" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>

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
            var cajas = new Array('codproveedor','nombre','numeroidentprov','sigla','codhabilitacion','nombrehabilitac','telefono','fax','lineagratuita','email','direccion','codigobarras');
            var combos = new Array('codtipoidentprov','codtipoproveedor','codestadoprov','codsectorentidad','codactividadeconomica','numidentfuncgere','numidentfunccontac','codhabilitacion','coddepartamento','codmunicipio');
		
            //validar
            var arrayNonulos               	= new Array('codproveedor');
            var arrayNumerosEnteros        	= null;
            var arrayCombos               	= new Array('codtipoidentprov','codtipoproveedor','codestadoprov','codsectorentidad','codactividadeconomica','numidentfuncgere','numidentfunccontac','codhabilitacion','coddepartamento','codmunicipio');		
            var arrayCadenasANCod          	= new Array('codproveedor','numeroidentprov','sigla','telefono','fax','lineagratuita','direccion','codigobarras');
            var arrayCadenasA              	= new Array('nombre','nombrehabilitac');
            var arrayComentarios           	= null;
            var arrayNumerosDoubles        	= null;
			
            var arrayPorcentajes        	= null;
            var arrayDirecciones        	= null;
            var arrayCorreos                    = new Array('email');

	</script>
        <style type="text/css">
<!--
.style1 {font-weight: bold}
-->
        </style>
</head>
<body bgcolor="#FFFFFF" onLoad="borrarMensaje(cajas[0]);">
${msj}
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
            <c:if test="${param.llave != null}">
            <sql:query var="r" sql="SELECT * FROM proveedor WHERE codproveedor='${param.llave}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codproveedor" value="${fila.codproveedor}"/>
              <c:set var="nombre" value="${fila.nombre}"/>
              <c:set var="codtipoidentprov" value="${fila.codtipoidentprov}"/>
              <c:set var="numeroidentprov" value="${fila.numeroidentprov}"/>             
              <c:set var="codtipoproveedor" value="${fila.codtipoproveedor}"/>
              <c:set var="codestadoprov" value="${fila.codestadoprov}"/>
              <c:set var="codsectorentidad" value="${fila.codsectorentidad}"/>              
              <c:set var="codactividadeconomica" value="${fila.codactividadeconomica}"/>              
              <c:set var="numidentfuncgere" value="${fila.numidentfuncgere}"/>
              <c:set var="numidentfunccontac" value="${fila.numidentfunccontac}"/>
              <c:set var="sigla" value="${fila.sigla}"/>
              <c:set var="codhabilitacion" value="${fila.codhabilitacion}"/>
              <c:set var="nombrehabilitac" value="${fila.nombrehabilitac}"/>
              <c:set var="telefono" value="${fila.telefono}"/>             
              <c:set var="fax" value="${fila.fax}"/>
              <c:set var="lineagratuita" value="${fila.lineagratuita}"/>
              <c:set var="email" value="${fila.email}"/>
              <c:set var="coddepartamento" value="${fila.coddepartamento}"/>
              <c:set var="codmunicipio" value="${fila.codmunicipio}"/>
              <c:set var="direccion" value="${fila.direccion}"/>
              <c:set var="codigobarras" value="${fila.codigobarras}"/>
            </jsp2:forEach>
            <form name="formulario" id="formulario" method="post" action="Proveedor.jsp">
            <table width="811" border="0" class="tablaContenido">
              <span id="mensajeControlador">${msj}</span>
              <tr>
                <td colspan="6"><div align="center" class="titulo1">Proveedor</div></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td width="25">&nbsp;</td>
                <td><span class="bgDescTablas"><strong>C&oacute;digo Proveedor</strong></span></td>
                <td colspan="4"><span class="sinBgDescTablas">
                  <input name="codproveedor" type="text" id="codproveedor" value="${codproveedor}" size="20" maxlength="20" onKeyPress="javascript:return permite(event, 'num_car_cod')" tabindex="1"/>
                </span></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td colspan="6"><p align="center"><strong class="bgDescTablas">Nombre</strong></p>
                <p align="center"><strong>
                  <label>
                  <input name="nombre" type="text" id="nombre" value="${nombre}" size="75" maxlength="100" onKeyPress="javascript:return permite(event, 'carac')" tabindex="2">
                  </label>
                </strong></p></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td width="25">&nbsp;</td>
                <td width="134"><strong class="bgDescTablas">Tipo Identificaci&oacute;n</strong></td>
                <td width="163"><label><span class="sinBgDescTablas" style="width: 20%">
                  <select name="codtipoidentprov" id="codtipoidentprov" style="width: 150px" tabindex="3">
                 <option id="codtipoidentprov" value=""></option>
                  <sql:query var="r" sql="select codtipoidentidad, descripcion from tipoidentificacion" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                   <c:choose>
                        <c:when test='${fila.codtipoidentidad == codtipoidentprov}'>
                        <option value="${fila.codtipoidentidad}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                    <c:otherwise>
                        <option value="${fila.codtipoidentidad}">${fila.descripcion}</option>
                    </c:otherwise>
                   </c:choose>
                 </jsp2:forEach>
                </select>
                </span></label></td>
                <td width="14">&nbsp;</td>
                <td width="139" class="bgDescTablas"><strong>No. Identificaci&oacute;n</strong></td>
                <td width="167"><label>
                  <input name="numeroidentprov" type="text" id="numeroidentprov" value="${numeroidentprov}" size="20" maxlength="18" onKeyPress="javascript:return permite(event, 'num_car_cod')" tabindex="4">
                </label></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><span class="bgDescTablas" style="width: 7%"><strong>Tipo Proveedor</strong></span></td>
                <td><label><span class="sinBgDescTablas" style="width: 20%">
                  <select name="codtipoproveedor" id="codtipoproveedor" style="width: 150px" tabindex="5">
                    <option id="codtipoproveedor" value=""></option>
                    <sql:query var="r" sql="select codtipoproveedor, descripcion from tipoproveedor" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.codtipoproveedor == codtipoproveedor}'>
                          <option value="${fila.codtipoproveedor}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.codtipoproveedor}">${fila.descripcion}</option>
                        </c:otherwise>
                      </c:choose>
                    </jsp2:forEach>
                  </select>
                </span></label></td>
                <td>&nbsp;</td>
                <td><span class="bgDescTablas"><strong>Estado Proveedor</strong></span></td>
                <td><span class="sinBgDescTablas">
                  <label>                  </label>
                </span>
                  <label><span class="sinBgDescTablas" style="width: 20%">
                  <select name="codestadoprov" id="codestadoprov" style="width: 150px" tabindex="6">
                    <option id="codestadoprov" value=""></option>
                    <sql:query var="r" sql="select codestadoprov, descripcion from estadoproveedor" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.codestadoprov == codestadoprov}'>
                          <option value="${fila.codestadoprov}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.codestadoprov}">${fila.descripcion}</option>
                        </c:otherwise>
                      </c:choose>
                    </jsp2:forEach>
                  </select>
                  </span></label></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><span class="bgDescTablas"><strong><strong>Actividad Economica</strong></strong></span></td>
                <td><span class="sinBgDescTablas" style="width: 20%"><span class="sinBgDescTablas" style="width: 20%">
                  <select name="codactividadeconomica" id="codactividadeconomica" style="width: 150px" tabindex="7">
                    <option id="codactividadeconomica" value=""></option>
                    <sql:query var="r" sql="select codactividadeconomica, descripcion from actividadeconomica" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.codactividadeconomica == codactividadeconomica}'>
                          <option value="${fila.codactividadeconomica}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.codactividadeconomica}">${fila.descripcion}</option>
                        </c:otherwise>
                      </c:choose>
                    </jsp2:forEach>
                  </select>
                </span></span></td>
                <td>&nbsp;</td>
                <td class="bgDescTablas"><strong>Sector Entidad</strong></td>
                <td><span class="sinBgDescTablas" style="width: 20%">
                  <select name="codsectorentidad" id="codsectorentidad" style="width: 150px" tabindex="8">
                    <option id="codsectorentidad" value=""></option>
                    <sql:query var="r" sql="select codsectorentidad, descripcion from sectorentidad" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.codsectorentidad == codsectorentidad}'>
                          <option value="${fila.codsectorentidad}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.codsectorentidad}">${fila.descripcion}</option>
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
                <td class="bgDescTablas"><strong>Gerente</strong></td>
                <td><span class="sinBgDescTablas" style="width: 20%"><span class="sinBgDescTablas" style="width: 20%">
                  <select name="numidentfuncgere" id="numidentfuncgere" style="width: 150px" tabindex="9">
                    <option id="numidentfuncgere" value=""></option>
                    <sql:query var="r" sql="select codtipoidentidad, numidentfunc, nombre from funcionario" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.numidentfunc == numidentfuncgere}'>
                          <option value="${fila.codtipoidentidad} ${fila.numidentfunc}" selected="selected">${fila.nombre}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.codtipoidentidad} ${fila.numidentfunc}">${fila.nombre}</option>
                        </c:otherwise>
                      </c:choose>
                    </jsp2:forEach>
                  </select>
                </span></span></td>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">Contacto</strong></td>
                <td><span class="sinBgDescTablas" style="width: 20%">
                  <select name="numidentfunccontac" id="numidentfunccontac" style="width: 150px" tabindex="10">
                    <option id="numidentfunccontac" value=""></option>
                    <sql:query var="r" sql="select codtipoidentidad, numidentfunc, nombre from funcionario" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.numidentfunc == numidentfunccontac}'>
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
                <td colspan="6" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>Sigla</strong></td>
                <td><label>
                  <input name="sigla" type="text" id="sigla" value="${sigla}" size="20" maxlength="30" onKeyPress="javascript:return permite(event, 'num_car_cod')" tabindex="11">
                </label></td>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">C&oacute;digo Habilitaci&oacute;n</strong></td>
                <td><label>
                  <input name="codhabilitacion" type="text" id="codhabilitacion" value="${codhabilitacion}" size="20" maxlength="20" onKeyPress="javascript:return permite(event, 'num_car_cod')" tabindex="12">
                </label></td>
              </tr>
              <tr>
                <td colspan="6" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td colspan="6" class="bgDescTablas"><span class="style1">
                  <label>
                  <center>Nombre Habilitaci&oacute;n</center>
                  </label>
                </span>
                  <p align="center" class="style1"> 
                  <label>
                  <input name="nombrehabilitac" type="text" id="nombrehabilitac" value="${nombrehabilitac}" size="75" maxlength="100" onKeyPress="javascript:return permite(event, 'carac')" tabindex="13">
                  </label>
                </p></td>
              </tr>
              <tr>
                <td colspan="6" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>Telefono</strong></td>
                <td class="bgDescTablas"><label>
                  <input name="telefono" type="text" id="telefono" value="${telefono}" size="20" maxlength="30" onKeyPress="javascript:return permite(event, 'num_car_cod')" tabindex="14">
                </label></td>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">Fax</strong></td>
                <td><label>
                  <input name="fax" type="text" id="fax" value="${fax}" size="20" maxlength="30" onKeyPress="javascript:return permite(event, 'num_car_cod')" tabindex="15">
                </label></td>
              </tr>
              <tr>
                <td colspan="6" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>Linea Gratuita</strong></td>
                <td class="bgDescTablas"><label>
                  <input name="lineagratuita" type="text" id="lineagratuita" value="${lineagratuita}" size="20" maxlength="30" onKeyPress="javascript:return permite(event, 'num_car_cod')" tabindex="16">
                </label></td>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">E-mail</strong></td>
                <td class="bgDescTablas"><input name="email" type="text" id="email" value="${email}" size="20" maxlength="50" onKeyPress="javascript:return permite(event, 'correo')" tabindex="17"></td>
              </tr>
              <tr>
                <td colspan="6" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>Departamento</strong></td>
                <td class="bgDescTablas"><select name="coddepartamento" id="coddepartamento" onChange="cargarMunicipios();" style="width: 150px" tabindex="18">
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
                <td><strong class="bgDescTablas">Municipio</strong></td>
                <td class="bgDescTablas">
                <span id="spanMunicipio">
                    <c:choose>
                        <c:when test="${codmunicipio != null}">
                        <select name="codmunicipio" id="codmunicipio" tabindex="19">
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
                        <select disabled>
                            <option value=""></option>
                        </select>
                        </c:otherwise>
                    </c:choose>
                </span></td>
              </tr>
              <tr>
                <td colspan="6" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>Direcci&oacute;n</strong></td>
                <td class="bgDescTablas"><label>
                  <input name="direccion" type="text" id="direccion" value="${direccion}" size="20" maxlength="100" onKeyPress="javascript:return permite(event, 'dir')"tabindex="20">
                </label></td>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">C&oacute;digo Barras</strong></td>
                <td class="bgDescTablas"><label>
                  <input name="codigobarras" type="text" id="codigobarras" value="${codigobarras}" size="20" maxlength="70" onKeyPress="javascript:return permite(event, 'num_car_cod')" tabindex="21">
                </label></td>
              </tr>
              <tr>
                <td colspan="6" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="llave" id="llave" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="25">-->
		  <label>&nbsp;</label>
                  <!--<input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="22"/>
                  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="23"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="24"/>-->
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
        <jsp:include page="../footer.jsp" />
	</td>
</tr>
</table>
</center>
<!-- End ImageReady Slices -->
<script>
    //funciones control
    function accion(x)
    {        
        if(validar2(arrayNonulos, arrayNumerosEnteros, arrayCombos, arrayCadenasANCod, arrayCadenasA, arrayComentarios, arrayNumerosDoubles, arrayPorcentajes, arrayDirecciones, arrayCorreos))
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
        llaves = 'codproveedor='+document.getElementById('codproveedor').value;
        validarLlave('proveedor',llaves);
    } 
    
    //
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=proveedor&";
        url = url + "campos=codproveedor,nombre,codtipoidentprov,numeroidentprov,codtipoproveedor,codestadoprov,codsectorentidad,codactividadeconomica&";
        url = url + "campoLlave=codproveedor";
        
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