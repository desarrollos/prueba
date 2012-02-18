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
            var cajas = new Array('subpotidentis','subpotvalsub','subpotdescri','subpotobserv');
            var combos = new Array('codunifamis','subscodigo','codtipoidentidads','coddepartamento','codmunicipio');
			
            var arrayNonulos               	= new Array('subpotidentis','subpotvalsub');
            var arrayNumerosEnteros        	= null;
            var arrayCombos               	= new Array('codunifamis','subscodigo','codtipoidentidads','coddepartamento','codmunicipio');
            var arrayCadenasANCod          	= new Array('subpotidentis');
            var arrayCadenasA              	= null;
            var arrayComentarios           	= new Array('subpotdescri','subpotobserv');
            var arrayNumerosDoubles        	= new Array('subpotvalsub');
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
            <c:if test="${param.codunifami != null && param.codtipoidentidad != null && param.subpotidenti != null}">
            <sql:query var="r" sql="SELECT * FROM subsidiopotencial WHERE codunifami='${param.codunifami}' AND codtipoidentidad='${param.codtipoidentidad}' AND subpotidenti='${param.subpotidenti}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codunifamis" value="${fila.codunifami}"/>
              <c:set var="codtipoidentidads" value="${fila.codtipoidentidad}"/>
              <c:set var="subpotidentis" value="${fila.subpotidenti}"/>
              <c:set var="subscodigo" value="${fila.subscodigo}"/>
              <c:set var="subpotvalsub" value="${fila.subpotvalsub}"/>
              <c:set var="coddepartamento" value="${fila.coddepartamento}"/>
              <c:set var="codmunicipio" value="${fila.codmunicipio}"/>
              <c:set var="subpotdescri" value="${fila.subpotdescri}"/>              
              <c:set var="subpotobserv" value="${fila.subpotobserv}"/>              
            </jsp2:forEach>

<form name="formulario" method="post" action="SubsidioPotencial.jsp">
<table width="811" border="0" class="tablaContenido">
<span id="mensajeControlador">${msj}</span>
  <tr>
    <td colspan="6"><div align="center"><span class="titulo1">Subsidio Potencial</span></div></td>
    </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td width="30">&nbsp;</td>
    <td width="150"><span class="bgDescTablas" style="width: 30%"><strong>C&oacute;digo &Uacute;nico Familia</strong></span></td>
    <td width="184"><span class="sinBgDescTablas" style="width: 60%">
      <label>
      <select name="codunifamis" id="codunifamis" style="width: 150px">
        <option id="codunifamis" value=""></option>
        <sql:query var="r" sql="select codunifami from inscripcion" dataSource="jdbc/delphos" scope="page"/>
        <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
          <c:choose>
            <c:when test='${fila.codunifami == codunifamis}'>
              <option value="${fila.codunifami}" selected="selected">${fila.codunifami}</option>
            </c:when>
            <c:otherwise>
              <option value="${fila.codunifami}">${fila.codunifami}</option>
            </c:otherwise>
          </c:choose>
        </jsp2:forEach>
      </select>
      </label>
    </span></td>
    <td width="28">&nbsp;</td>
    <td width="119"><span class="bgDescTablas" style="width: 20%"><strong>Subsidio</strong></span></td>
    <td width="165"><span class="sinBgDescTablas" style="width: 20%">
      <label>
      <select name="subscodigo" id="subscodigo" style="width: 150px">
        <option id="subscodigo" value=""></option>
        <sql:query var="r" sql="select subscodigo from subsidio" dataSource="jdbc/delphos" scope="page"/>
        <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
          <c:choose>
            <c:when test='${fila.subscodigo == subscodigo}'>
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
  </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td>&nbsp;</td>
    <td><span class="bgDescTablas" style="width: 20%"><strong>Tipo Id.</strong></span></td>
    <td><span class="sinBgDescTablas" style="width: 20%">
      <select name="codtipoidentidads" id="codtipoidentidads" style="width: 150px">
               <option id="codtipoidentidads" value=""></option>
          <sql:query var="r" sql="select codtipoidentidad, descripcion from tipoidentificacion" dataSource="jdbc/delphos" scope="page"/>
          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
           <c:choose>
                <c:when test='${fila.codtipoidentidad == codtipoidentidads}'>
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
    <td><span class="bgDescTablas" style="width: 20%"><strong>Nro. Identificaci&oacute;n</strong></span></td>
    <td><span class="sinBgDescTablas" style="width: 20%">
      <input name="subpotidentis" type="text" id="subpotidentis" value="${subpotidentis}" size="20" maxlength="18" onkeypress="javascript:return permite(event, 'num_car_cod')"/>
    </span></td>
  </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td>&nbsp;</td>
    <td><span class="bgDescTablas" style="width: 20%"><strong>Valor Subsidio</strong></span></td>
    <td colspan="4"><span class="sinBgDescTablas" style="width: 20%">
      <input name="subpotvalsub" type="text" id="subpotvalsub" value="${subpotvalsub}" size="20" maxlength="14" onkeypress="javascript:return permite(event, 'numd')"/>
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
    <td><span class="bgDescTablas" style="width: 20%"><strong>Municipio</strong></span></td>
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
    <td colspan="6"><p align="center"><span class="bgDescTablas" style="width: 20%; height: 85px;"><strong>Descripci&oacute;n</strong></span></p>
      <p align="center"><span class="sinBgDescTablas" style="width: 60%; height: 85px;">
        <input name="subpotdescri" type="text" id="subpotdescri" value="${subpotdescri}" size="75" maxlength="50" onkeypress="javascript:return permite(event, 'com')"/>
      </span></p></td>
    </tr>
  <tr>
    <td colspan="6"><p align="center"><span class="bgDescTablas" style="width: 20%; height: 85px;"><strong>Observaciones</strong></span></p>
      <p align="center"><span class="bgDescTablas" style="width: 20%; height: 85px;"> <span class="sinBgDescTablas" style="width: 60%; height: 85px;">
        <textarea cols="75" rows="3" name="subpotobserv" id="subpotobserv" onkeypress="javascript:return permite(event, 'com')">${subpotobserv}</textarea>
        </span></span></p></td>
    </tr>
 <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="codunifami" id="codunifami" value="" >
                  <input type="hidden" name="codtipoidentidad" id="codtipoidentidad" value="" >
                  <input type="hidden" name="subpotidenti" id="subpotidenti" value="" >
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
        llaves+= 'codtipoidentidad='+document.getElementById('codtipoidentidads').value+',';
        llaves+= 'subpotidenti='+document.getElementById('subpotidentis').value;
        validarLlave('subsidiopotencial',llaves);
    }
    
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=subsidiopotencial&";
        url = url + "campos=codunifami,codtipoidentidad,subpotidenti,subscodigo,subpotvalsub,coddepartamento,codmunicipio,subpotdescri&";
        url = url + "campoLlave=codunifami,codtipoidentidad,subpotidenti";
        
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