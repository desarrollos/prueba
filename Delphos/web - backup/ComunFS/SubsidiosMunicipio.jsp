<!--
	Familias en accion
-->
<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<%@ taglib prefix="jsp2" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head><script type="text/javascript" src="../js/jquery/jquery.js"></script>
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
        
        <script type="text/javascript" src="../js/pestanas/animatedcollapse.js"></script>
        <script type="text/javascript" src="../js/validaciones/validador.js"></script>
        <script type="text/javascript" src="../js/validaciones/validadorkp.js"></script>
        <script type="text/javascript" src="../js/validaciones/validadorcontrol.js"></script>
        <script type="text/javascript">
           
            //totalidad de elementos en el form
            var cajas = new Array('submunvalsub','submundescri','submunobserv');
            var combos = new Array('subscodigos','subtipcodigo','coddepartamentos','codmunicipios');
			
            var arrayNonulos               	= new Array('submunvalsub');
            var arrayNumerosEnteros        	= null;
            var arrayCombos               	= new Array('subscodigos','subtipcodigo','coddepartamentos','codmunicipios');
            var arrayCadenasANCod          	= null;
            var arrayCadenasA              	= null;
            var arrayComentarios           	= new Array('submundescri','submunobserv');
            var arrayNumerosDoubles        	= new Array('submunvalsub');
</script>
</head>
<body bgcolor="#FFFFFF" onLoad="borrarMensaje(combos[0]);">
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
                <c:if test='${param.subscodigo != null && param.coddepartamento != null && param.coddepartamento != "" && param.codmunicipio != null && param.codmunicipio != ""}'>
                <sql:query var="r" sql="SELECT * FROM subsidiomunicipio WHERE subscodigo='${param.subscodigo}' AND coddepartamento=${param.coddepartamento} AND codmunicipio=${param.codmunicipio}" dataSource="jdbc/delphos" scope="page"/>
                </c:if>
                <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                    <c:set var="subscodigof" value="${fila.subscodigo}"/>
                    <c:set var="coddepartamentos" value="${fila.coddepartamento}"/>
                    <c:set var="codmunicipios" value="${fila.codmunicipio}"/>
                    <c:set var="submunvalsub" value="${fila.submunvalsub}"/>
                    <c:set var="subtipcodigo" value="${fila.subtipcodigo}"/>
                    <c:set var="submundescri" value="${fila.submundescri}"/>
                    <c:set var="submunobserv" value="${fila.submunobserv}"/>                    
                </jsp2:forEach>
              <form name="formulario" method="post" action="SubsidiosMunicipio.jsp">
              <table width="818" border="0" class="tablaContenido">
                    <span id="mensajeControlador">${msj}</span>
                  <tr>
                    <td colspan="6"><div align="center"><span class="titulo1">Subsidios Municipio</span></div></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="27">&nbsp;</td>
                    <td width="106"><strong class="bgDescTablas">Subsidio</strong></td>
                    <td width="166"><span class="sinBgDescTablas" style="width: 20%">
                      <label>
                      <select name="subscodigos" id="subscodigos" style="width: 150px">
                       <option id="subscodigos" value=""></option>
                  <sql:query var="r" sql="select subscodigo from subsidio" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                   <c:choose>
                        <c:when test='${fila.subscodigo == subscodigof}'>
                        <option value="${fila.subscodigo}" selected="selected">${fila.subscodigo}</option>
                        </c:when>
                    <c:otherwise>
                        <option value="${fila.subscodigo}">${fila.subscodigo}</option>
                    </c:otherwise>
                   </c:choose>
                 </jsp2:forEach>
                      </select>
                      </label>
                    </span></td>
                    <td width="25">&nbsp;</td>
                    <td width="106"><span class="bgDescTablas"><strong>Tipo Subsidio</strong></span></td>
                    <td width="212"><span class="sinBgDescTablas" style="width: 20%">
                      <select name="subtipcodigo" id="subtipcodigo" style="width: 150px">
                        <option id="subtipcodigo" value=""></option>
                        <sql:query var="r" sql="select subtipcodigo, subtipdescri from tiposubsidio" dataSource="jdbc/delphos" scope="page"/>
                        <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                          <c:choose>
                            <c:when test='${fila.subtipcodigo == subtipcodigo}'>
                              <option value="${fila.subtipcodigo}" selected="selected">${fila.subtipdescri}</option>
                            </c:when>
                            <c:otherwise>
                              <option value="${fila.subtipcodigo}">${fila.subtipdescri}</option>
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
                    <td><strong class="bgDescTablas">Departamento</strong></td>
                    <td><label>
                      <select name="coddepartamentos" id="coddepartamentos" onchange="cargarMunicipios();" style="width: 150px">
                        <option value=""></option>
                        <sql:query var="r" sql="select coddepartamento, nombre from departamento order by nombre" dataSource="jdbc/delphos" scope="page"/>
                        <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                          <c:choose>
                            <c:when test='${fila.coddepartamento == coddepartamentos}'>
                              <option value="${fila.coddepartamento}" selected="selected">${fila.nombre}</option>
                            </c:when>
                            <c:otherwise>
                              <option value="${fila.coddepartamento}">${fila.nombre}</option>
                            </c:otherwise>
                          </c:choose>
                        </jsp2:forEach>
                      </select>
                    </label></td>
                    <td>&nbsp;</td>
                    <td><strong class="bgDescTablas">Municipio</strong></td>
                    <td><span id="spanMunicipio">
                    <c:choose>
                        <c:when test="${codmunicipios != null}">
                        <select name="codmunicipios" id="codmunicipios" style="width: 150px">
                        <option value=""></option>
                        <sql:query var="r" sql="select codmunicipio, nombre from municipio where coddepartamento='${coddepartamentos}' order by nombre" dataSource="jdbc/delphos" scope="page"/>
                        <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                        <c:choose>
                            <c:when test='${fila.codmunicipio == codmunicipios}'>
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
                    <td><span class="bgDescTablas"><strong>Valor Subsidio</strong></span></td>
                    <td colspan="4"><span class="sinBgDescTablas">
                      <input name="submunvalsub" type="text" id="submunvalsub" value="${submunvalsub}" size="20" maxlength="15" onkeypress="javascript:return permite(event, 'numd')"/>
                    </span></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="6"><p align="center" class="bgDescTablas"><strong>Descripci&oacute;n</strong></p>
                    <p align="center"><span class="sinBgDescTablas" style="height: 85px;">
                      <input name="submundescri" type="text" id="submundescri" value="${submundescri}" size="75" maxlength="70" onkeypress="javascript:return permite(event, 'com')"/>
                    </span></p></td>
                  </tr>
                  <tr>
                    <td colspan="6"><p align="center"><strong><span class="bgDescTablas" style="height: 85px;"><strong>Observaciones</strong></span></strong></p>
                      <p align="center"><span class="sinBgDescTablas" style="height: 85px;">
                      <textarea name="submunobserv" cols="75" rows="3" id="submunobserv" onkeypress="javascript:return permite(event, 'com')">${submunobserv}</textarea>
                    </span></p></td>
                  </tr>
                  <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="subscodigo" id="subscodigo" value="" >
                  <input type="hidden" name="coddepartamento" id="coddepartamento" value="" >
                  <input type="hidden" name="codmunicipio" id="codmunicipio" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <input type="button" onClick="buscar();" value="Buscar" tabindex="17">
		  <label>&nbsp;</label>
		  <input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="14"/>
		  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="15"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="16"/>
               </div>            </td>
           </tr>
          </table>
        </form>
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
        llaves = 'subscodigo='+document.getElementById('subscodigos').value+',';
        llaves+= 'coddepartamento='+document.getElementById('coddepartamentos').value+',';
        llaves+= 'codmunicipio='+document.getElementById('codmunicipios').value;
        validarLlave('subsidiomunicipio',llaves);
    }
    
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=subsidiomunicipio&";
        url = url + "campos=subscodigo,coddepartamento,codmunicipio,submunvalsub,subtipcodigo,submundescri&";
        url = url + "campoLlave=subscodigo,coddepartamento,codmunicipio";
        
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