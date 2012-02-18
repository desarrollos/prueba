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
        
        
        <script type="text/javascript" src="../js/pestanas/animatedcollapse.js"></script>
        <script type="text/javascript" src="../js/validaciones/validador.js"></script>
        <script type="text/javascript" src="../js/validaciones/validadorkp.js"></script>
         <script type="text/javascript" src="../js/validaciones/validadorcontrol.js"></script>
        <script type="text/javascript">
            function configurar()
            {
                Calendar.setup({inputField : "encuenfecha",ifFormat : "%d/%m/%Y %H:%M:%S",button : "botonEncuenfecha", showsTime:true, timeFormat:"24",daFormat : "%d/%m/%Y %H:%M:%S"});
                Calendar.setup({inputField : "encufechinfo",ifFormat : "%d/%m/%Y %H:%M:%S",button : "botonEncufechinfo", showsTime:true, timeFormat:"24",daFormat : "%d/%m/%Y %H:%M:%S"});
	    }
            
            
            var cajas = new Array('encuencodigo','encuendirecc','enculugarefe','encuenfecha','encunumepart','encutemaprin','encidemadlid','encufechinfo','encuarchdocu','encuenpropos','encuenobjeti','encusoluenco','encuenobserv');
            var combos = new Array('coddepartamento','codmunicipio','coditiporeun','codtipoidentidad','tisiscodigo')
			
			//validar
            var arrayNonulos               = new Array('encuencodigo','encuenfecha','encufechinfo','encunumepart');
            var arrayNumerosEnteros        = new Array('encunumepart');
            var arrayCombos                = new Array('coddepartamento','codmunicipio','coditiporeun','codtipoidentidad','tisiscodigo');
            var arrayCadenasANCod          = new Array('encuencodigo','encidemadlid');
            var arrayCadenasA              = null;
            var arrayComentarios           = new Array('enculugarefe','encutemaprin','encuarchdocu','encuenpropos','encuenobjeti','encusoluenco','encuenobserv');
            var arrayNumerosDoubles        = null;
            
            var arrayPorcentajes        	= null;
            var arrayDirecciones        	= null;
            var arrayCorreos                    = null;
                        
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
            <c:if test="${param.llave != null}">
            <sql:query var="r" sql="SELECT * FROM encuentroreunion WHERE encuencodigo='${param.llave}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="encuencodigo" value="${fila.encuencodigo}"/>
              <c:set var="coddepartamento" value="${fila.coddepartamento}"/>
              <c:set var="codmunicipio" value="${fila.codmunicipio}"/>
              <c:set var="encuendirecc" value="${fila.encuendirecc}"/>
              <c:set var="enculugarefe" value="${fila.enculugarefe}"/>
              <fmt:formatDate value="${fila.encuenfecha}" pattern="dd/MM/yyyy HH:mm:ss" var="encuenfecha"/>
             
              <c:set var="encunumepart" value="${fila.encunumepart}"/>
              <c:set var="encutemaprin" value="${fila.encutemaprin}"/>
              <c:set var="coditiporeun" value="${fila.coditiporeun}"/>
              
              <c:set var="codtipoidentidad" value="${fila.codtipoidentidad}"/>
              
              <c:set var="encidemadlid" value="${fila.encidemadlid}"/>
              <c:set var="encuenpropos" value="${fila.encuenpropos}"/>
              <c:set var="encuenobjeti" value="${fila.encuenobjeti}"/>
              <c:set var="encusoluenco" value="${fila.encusoluenco}"/>
              <c:set var="encuenobserv" value="${fila.encuenobserv}"/>
              <c:set var="encuarchdocu" value="${fila.encuarchdocu}"/>
              <c:set var="tisiscodigo" value="${fila.tisiscodigo}"/>
              <fmt:formatDate value="${fila.encufechinfo}" dateStyle="short" pattern="dd/MM/yyyy HH:mm:ss" var="encufechinfo"/>
              
              
              <%--Carga del archivo de la base de datos---------------------%>
              <%
              String ruta = request.getSession().getServletContext().getRealPath("temp")+"\\";
              ruta = ruta.replaceAll("\\\\","/");
              pageContext.setAttribute("ruta",ruta);
              %>
              <sql:query var="r" sql="select lo_export(encuentroreunion.archivofi, '${ruta}${encuarchdocu}') from encuentroreunion where encuencodigo='${param.llave}'" dataSource="jdbc/delphos" scope="page"/>
              <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <%------------------------------------------------------------%>
              </jsp2:forEach>
              <%------------------------------------------------------------%>
              
            </jsp2:forEach>
            <form name="formulario" id="formulario" method="post" action="EncuentrosOReuniones.jsp">
            <table width="811" border="0" class="tablaContenido">
                <span id="mensajeControlador">${msj}</span>
              <tr>
                <td colspan="6"><div align="center" class="titulo1">Encuentros o Reuniones</div></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td width="30">&nbsp;</td>
                <td width="139"><span class="bgDescTablas"><strong>C&oacute;digo</strong></span></td>
                <td width="190"><span class="sinBgDescTablas">
                  <input name="encuencodigo" type="text" id="encuencodigo" value="${encuencodigo}" size="20" maxlength="6" onKeyPress="javascript:return permite(event, 'num_car_cod')"/>
                </span></td>
                <td colspan="3">&nbsp;</td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">Departamento</strong></td>
                <td><select name="coddepartamento" id="coddepartamento" onChange="cargarMunicipios();">
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
                <td>
                <span id="spanMunicipio">
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
                <td><span class="bgDescTablas"><strong>Direcci&oacute;n</strong></span></td>
                <td><span class="sinBgDescTablas">
                  <input size="20" type="text" name="encuendirecc" id="encuendirecc" value="${encuendirecc}"/>
                </span></td>
                <td width="11">&nbsp;</td>
                <td width="132"><span class="bgDescTablas"><strong>Lugar Referencia</strong></span></td>
                <td width="174"><span class="sinBgDescTablas" style="width: 25%">
                  <input type="text" name="enculugarefe" id="enculugarefe" value="${enculugarefe}" onKeyPress="javascript:return permite(event, 'com')"/>
                </span></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><span class="bgDescTablas" style="width: 7%"><strong>Fecha</strong></span></td>
                <td><span class="sinBgDescTablas" style="width: 20%">
                  <input name="encuenfecha" type="text" id="encuenfecha"  value="${encuenfecha}" size="19" maxlength="19" readonly="readonly"/>
                  <span class="sinBgDescTablas" style="width: 20%">
                  <input name="button" type="button" id="botonEncuenfecha" value="..." />
                </span></span></td>
                <td>&nbsp;</td>
                <td><span class="bgDescTablas"><strong>Nro. Participantes</strong></span></td>
                <td><span class="sinBgDescTablas">
                  <label>                  </label>
                </span>
                  <label><span class="sinBgDescTablas">
                  <input size="5" type="text" name="encunumepart" id="encunumepart" value="${encunumepart}" onKeyPress="javascript:return permite(event, 'nume')"/>
                  </span></label></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><span class="bgDescTablas"><strong>Tipo Reuni&oacute;n</strong></span></td>
                <td colspan="4"><span class="sinBgDescTablas">
                  <select name="coditiporeun" id="coditiporeun">
                  <option  value=""></option>
                  <sql:query var="r" sql="select coditiporeun, desctiporeun from tiporeunion" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                   <c:choose>
                        <c:when test='${fila.coditiporeun == coditiporeun}'>
                        <option value="${fila.coditiporeun}" selected="selected">${fila.desctiporeun}</option>
                        </c:when>
                    <c:otherwise>
                        <option value="${fila.coditiporeun}">${fila.desctiporeun}</option>
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
                <td><span class="bgDescTablas"><strong>Tema Principal</strong></span></td>
                <td colspan="4"><span class="sinBgDescTablas" style="width: 20%">
                  <label>
                  <textarea name="encutemaprin" cols="60" rows="5" id="encutemaprin" onKeyPress="javascript:return permite(event, 'com')">${encutemaprin}</textarea>
                  </label>
                </span></td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>Tipo Id. Madre Lider </strong></td>
                <td><label>
                 <select name="codtipoidentidad" id="codtipoidentidad">
                 <option id="codtipoidentidad" value=""></option>
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
                </label></td>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas"> Nro. Id. Madre L&iacute;der</strong></td>
                <td><span class="sinBgDescTablas">
                  <input size="15" type="text" name="encidemadlid" id="encidemadlid"  value="${encidemadlid}" onKeyPress="javascript:return permite(event, 'num_car_cod')"/>
                </span></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><span class="bgDescTablas" style="width: 8%"><strong>Fecha Informe</strong></span></td>
                <td><span class="sinBgDescTablas" style="width: 20%">
                  <input name="encufechinfo" type="text" id="encufechinfo"  value="${encufechinfo}" size="19" maxlength="19" readonly="readonly"/>
                  <span class="sinBgDescTablas" style="width: 20%">
                  <input name="button2" type="button" id="botonEncufechinfo" value="..." />
                </span></span></td>
                <td>&nbsp;</td>
                <td><span class="bgDescTablas"><strong>Archivo<br />
                Documento</strong></span></td>
                <td><span class="sinBgDescTablas" style="width: 20%">
                  <input name="encuarchdocu" type="text" id="encuarchdocu" size="15"  value="${encuarchdocu}" readonly/><a href="#" onClick="abrirCargaArchivo();"><img src="../images/Buscar16x16.gif" alt="Cargar Archivo" border="0"/></a>
                  <c:if test='${encuarchdocu != null && encuarchdocu != ""}'><br>
                    <a href="../temp/${encuarchdocu}" target="_blank">Descargar ${encuarchdocu}</a>
                  </c:if>
                </span></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>Tipo Sistema</strong></td>
                <td colspan="4"><label>
                  <select name="tisiscodigo" id="tisiscodigo">
                 <option id="tisiscodigo" value=""></option>
                  <sql:query var="r" sql="select tisiscodigo, tisisdescrip from tiposistema" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                   <c:choose>
                        <c:when test='${fila.tisiscodigo == tisiscodigo}'>
                        <option value="${fila.tisiscodigo}" selected="selected">${fila.tisisdescrip}</option>
                        </c:when>
                    <c:otherwise>
                        <option value="${fila.tisiscodigo}">${fila.tisisdescrip}</option>
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
                <td><span class="bgDescTablas" style="width: 15%; height: 85px"><strong>Prop&oacute;sito</strong></span></td>
                <td><span class="sinBgDescTablas" style="width: 30%; height: 85px">
                  <textarea name="encuenpropos" id="encuenpropos" cols="20" rows="4" onKeyPress="javascript:return permite(event, 'com')">${encuenpropos}</textarea>
                </span></td>
                <td>&nbsp;</td>
                <td><span class="bgDescTablas" style="width: 15%; height: 85px"><strong>Objetivo</strong></span></td>
                <td><span class="sinBgDescTablas" style="width: 30%; height: 85px">
                  <textarea name="encuenobjeti" id="encuenobjeti" cols="20" rows="4" onKeyPress="javascript:return permite(event, 'com')">${encuenobjeti}</textarea>
                </span></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><span class="bgDescTablas" style="width: 15%; height: 85px"><strong>Soluciones<br />
                encontradas</strong></span></td>
                <td><span class="sinBgDescTablas" style="width: 30%; height: 85px">
                  <textarea name="encusoluenco" id="encusoluenco" cols="20" rows="4" onKeyPress="javascript:return permite(event, 'com')">${encusoluenco}</textarea>
                </span></td>
                <td>&nbsp;</td>
                <td><span class="bgDescTablas" style="width: 15%; height: 85px"><strong>Observaciones</strong></span></td>
                <td><span class="sinBgDescTablas" style="width: 30%; height: 85px">
                  <textarea name="encuenobserv" cols="20" rows="4" id="encuenobserv" onKeyPress="javascript:return permite(event, 'com')">${encuenobserv}</textarea>
                </span></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="llave" id="llave" value="" >
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
        <jsp:include page="../footer.jsp" />    </td>
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
        llaves = 'encuencodigo='+document.getElementById('encuencodigo').value+',';

        validarLlave('encuentroreunion',llaves);
    }
    
    configurar();
    
    function abrirCargaArchivo()
    {
        var url;
        url = "../FamiliasEnAccion/PopUpCargaArchivo.jsp?";
        url = url + "campo=encuarchdocu";
        
        window.open(url,"_blank","width=500,height=190,scrollbars=1,left=350,top=100");
    }
    
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=encuentroreunion&";
        url = url + "campos=encuencodigo,encuendirecc,encutemaprin,encunumepart&";
        url = url + "campoLlave=encuencodigo";
        
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