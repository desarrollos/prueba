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
		Calendar.setup({inputField : "subasifecini",ifFormat : "%d/%m/%Y",button : "botonsubasifecini"});
		Calendar.setup({inputField : "subasifecfin",ifFormat : "%d/%m/%Y",button : "botonsubasifecfin"});
	    }
			
            //totalidad de elementos en el form
            var cajas = new Array('subasifecini','subasifecfin','subasivalsub','subasidescri','subasiobserv');
            var combos = new Array('codunifamis','subscodigo','coddepartamento','codmunicipio','codbanco');
			
            var arrayNonulos               	= new Array('subasifecini','subasifecfin','subasivalsub');
            var arrayNumerosEnteros        	= null;
            var arrayCombos               	= new Array('codunifamis','subscodigo','coddepartamento','codmunicipio','codbanco');	
            var arrayCadenasANCod          	= null;
            var arrayCadenasA              	= null;
            var arrayComentarios           	= new Array('subasidescri','subasiobserv');
            var arrayNumerosDoubles        	= new Array('subasivalsub');
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
            <sql:query var="r" sql="SELECT * FROM subsidioasignado WHERE codunifami='${param.codunifami}' AND codtipoidentidad='${param.codtipoidentidad}' AND subpotidenti='${param.subpotidenti}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codunifamif" value="${fila.codunifami}"/>
              <c:set var="codtipoidentidadf" value="${fila.codtipoidentidad}"/>
              <c:set var="subpotidentif" value="${fila.subpotidenti}"/>
              <fmt:formatDate value="${fila.subasifecini}" pattern="dd/MM/yyyy" var="subasifecini"/>
              <fmt:formatDate value="${fila.subasifecfin}" pattern="dd/MM/yyyy" var="subasifecfin"/>
              <c:set var="subscodigo" value="${fila.subscodigo}"/>
              <c:set var="subasivalsub" value="${fila.subasivalsub}"/>
              <c:set var="coddepartamento" value="${fila.coddepartamento}"/>
              <c:set var="codmunicipio" value="${fila.codmunicipio}"/>
             
              <c:set var="subasidescri" value="${fila.subasidescri}"/>
              <c:set var="codbanco" value="${fila.codbanco}"/>
              <c:set var="subasireqedu" value="${fila.subasireqedu}"/>
              
              <c:set var="subasireqsal" value="${fila.subasireqsal}"/>
              
              <c:set var="subasiusosub" value="${fila.subasiusosub}"/>
              <c:set var="subasiobserv" value="${fila.subasiobserv}"/>
              
            </jsp2:forEach>
            
<form name="formulario" method="post" action="SubsidioAsignado.jsp">
<table width="814" border="0" class="tablaContenido">
<span id="mensajeControlador">${msj}</span>
  <tr>
    <td colspan="6"><div align="center"><span class="titulo1">Subsidio Asignado</span></div></td>
    </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td width="25">&nbsp;</td>
    <td width="134"><span class="bgDescTablas" style="width: 20%"><strong>C&oacute;digo &Uacute;nico Familia</strong></span></td>
    <td width="162"><span class="sinBgDescTablas" style="width: 60%">
      <label>
      <select name="codunifamis" id="codunifamis" style="width: 150px">
              <option id="codunifamis" value=""></option>
              <sql:query var="r" sql="select codunifami, codtipoidentidad, subpotidenti from subsidiopotencial" dataSource="jdbc/delphos" scope="page"/>
              <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
               <c:choose>
                    <c:when test='${fila.codunifami == codunifamif && fila.codtipoidentidad == codtipoidentidadf && fila.subpotidenti == subpotidentif}'>
                    <option value="${fila.codunifami} ${fila.codtipoidentidad} ${fila.subpotidenti}" selected="selected">${fila.codunifami}</option>
                    </c:when>
                <c:otherwise>
                    <option value="${fila.codunifami} ${fila.codtipoidentidad} ${fila.subpotidenti}">${fila.codunifami}</option>
                </c:otherwise>
               </c:choose>
             </jsp2:forEach>
      </select>
      </label>
    </span></td>
    <td width="19">&nbsp;</td>
    <td width="118"><span class="bgDescTablas" style="width: 20%"><strong>Subsidio</strong></span></td>
    <td width="184"><select name="subscodigo" id="subscodigo" style="width: 150px">
      <option id="subscodigo" value=""></option>
      <sql:query var="r" sql="select subscodigo, subsdescripc from subsidio" dataSource="jdbc/delphos" scope="page"/>
      <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
        <c:choose>
          <c:when test='${fila.subscodigo == subscodigo}'>
            <option value="${fila.subscodigo}" selected="selected">${fila.subsdescripc}</option>
          </c:when>
          <c:otherwise>
            <option value="${fila.subscodigo}">${fila.subsdescripc}</option>
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
    <td><span class="bgDescTablas" style="width: 20%"><strong>Fecha Inicial Subsidio</strong></span></td>
    <td><span class="sinBgDescTablas" style="width: 20%">
      <input name="subasifecini" type="text" id="subasifecini" value="${subasifecini}" size="15" readonly="readonly" />
    </span><span class="sinBgDescTablas" style="width: 20%">
    <input name="button" type="button" id="botonsubasifecini" value="..." />
    </span></td>
    <td>&nbsp;</td>
    <td><span class="bgDescTablas" style="width: 20%"><strong>Fecha Final Subsidio</strong></span></td>
    <td><span class="sinBgDescTablas" style="width: 20%">
      <input name="subasifecfin" type="text" id="subasifecfin" value="${subasifecfin}" size="15" readonly="readonly" />
      <span class="sinBgDescTablas" style="width: 20%">
      <input name="button2" type="button" id="botonsubasifecfin" value="..." />
      </span></span></td>
  </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td>&nbsp;</td>
    <td><span class="bgDescTablas" style="width: 20%"><strong>Valor Subsidio</strong></span></td>
    <td colspan="4"><span class="sinBgDescTablas" style="width: 20%">
      <input name="subasivalsub" type="text" id="subasivalsub" value="${subasivalsub}" size="20" maxlength="14" onkeypress="javascript:return permite(event, 'numd')"/>
    </span></td>
    </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td class="bgDescTablas">&nbsp;</td>
    <td class="bgDescTablas"><strong>Departamento</strong></td>
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
    <td><strong class="bgDescTablas">Municipio</strong></td>
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
    <td><strong class="bgDescTablas">Cumple Requisito Salud</strong></td>
    <td><span class="bgDescTablas" style="width: 20%"><strong><c:choose>
                    <c:when test = '${subasireqsal == "S"}'>
                                <label>
                                    <span class="descCampoForm">Si
                                    <input type="radio" name="subasireqsal" value="S" id="subasireqsal_0" checked="true"/>
                                    </span>
                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                    <input type="radio" name="subasireqsal" value="N" id="subasireqsal_1" />
                                    </span> 
                                </label>
                    </c:when>
                            <c:otherwise>
                                <label>
                                    <span class="descCampoForm">Si
                                    <input type="radio" name="subasireqsal" value="S" id="subasireqsal_0"/>
                                    </span>
                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                    <input type="radio" name="subasireqsal" value="N" id="subasireqsal_1" checked="true"/>
                                    </span> 
                                </label>
                            </c:otherwise>
                        </c:choose>
    </strong></span></td>
    <td>&nbsp;</td>
    <td><span class="bgDescTablas" style="width: 20%"><strong>Cumple Requisito Educaci&oacute;n</strong></span></td>
    <td><span class="bgDescTablas" style="width: 20%"><strong><c:choose>
                    <c:when test = '${subasireqedu == "S"}'>
                                <label>
                                    <span class="descCampoForm">Si
                                    <input type="radio" name="subasireqedu" value="S" id="subasireqedu_0" checked="true"/>
                                    </span>
                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                    <input type="radio" name="subasireqedu" value="N" id="subasireqedu_1" />
                                    </span> 
                                </label>
                    </c:when>
                            <c:otherwise>
                                <label>
                                    <span class="descCampoForm">Si
                                    <input type="radio" name="subasireqedu" value="S" id="subasireqedu_0"/>
                                    </span>
                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                    <input type="radio" name="subasireqedu" value="N" id="subasireqedu_1" checked="true"/>
                                    </span> 
                                </label>
                            </c:otherwise>
                        </c:choose>
    </strong></span></td>
  </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td>&nbsp;</td>
    <td><strong class="bgDescTablas">Uso del Subsidio</strong></td>
    <td><span class="bgDescTablas" style="width: 20%"><strong><c:choose>
                    <c:when test = '${subasiusosub == "S"}'>
                                <label>
                                    <span class="descCampoForm">Si
                                    <input type="radio" name="subasiusosub" value="S" id="subasiusosub_0" checked="true"/>
                                    </span>
                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                    <input type="radio" name="subasiusosub" value="N" id="subasiusosub_1" />
                                    </span> 
                                </label>
                    </c:when>
                            <c:otherwise>
                                <label>
                                    <span class="descCampoForm">Si
                                    <input type="radio" name="subasiusosub" value="S" id="subasiusosub_0"/>
                                    </span>
                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                    <input type="radio" name="subasiusosub" value="N" id="subasiusosub_1" checked="true"/>
                                    </span> 
                                </label>
                            </c:otherwise>
                        </c:choose>
    </strong></span></td>
    <td>&nbsp;</td>
    <td><strong class="bgDescTablas">Banco</strong></td>
    <td><span class="sinBgDescTablas" style="width: 20%">
      <select name="codbanco" id="codbanco" style="width: 150px">
          <option id="codbanco" value=""></option>
          <sql:query var="r" sql="select codbanco, descripcion from banco" dataSource="jdbc/delphos" scope="page"/>
          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
           <c:choose>
                <c:when test='${fila.codbanco == codbanco}'>
                <option value="${fila.codbanco}" selected="selected">${fila.descripcion}</option>
                </c:when>
            <c:otherwise>
                <option value="${fila.codbanco}">${fila.descripcion}</option>
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
    <td colspan="6"><p align="center" class="style2"><span class="bgDescTablas" style="width: 20%; height: 85px;"><strong>Descripci&oacute;n</strong></span></p>
      <p align="center"><span class="sinBgDescTablas" style="width: 60%; height: 85px;">
        <input name="subasidescri" type="text" id="subasidescri" value="${subasidescri}" size="75" maxlength="50" onkeypress="javascript:return permite(event, 'com')"/>
        </span></p></td>
    </tr>
  <tr>
    <td colspan="6"><p align="center" class="style1"><span class="bgDescTablas" style="width: 20%; height: 85px;">Observaciones</span></p>
      <p align="center"><span class="sinBgDescTablas" style="width: 60%; height: 85px;">
        <textarea cols="75" rows="3" name="subasiobserv" id="subasiobserv" onkeypress="javascript:return permite(event, 'com')">${subasiobserv}</textarea>
        </span></p></td>
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
        <jsp:include page="../footer.jsp" />   </td>
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
        var d = document.getElementById('codunifamis').value;
        var dd = d.split(" ");
    
        llaves = 'codunifami='+dd[0]+',';
        llaves+= 'codtipoidentidad='+dd[1]+',';
        llaves+= 'subpotidenti='+dd[2];
        validarLlave('subsidioasignado',llaves);
    }
    
    configurar();
  
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=subsidioasignado&";
        url = url + "campos=codunifami,codtipoidentidad,subpotidenti,subasifecini,subasifecfin,subscodigo,coddepartamento,codmunicipio&";
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