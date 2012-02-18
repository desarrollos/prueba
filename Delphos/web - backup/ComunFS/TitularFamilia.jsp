<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<%@ taglib prefix="jsp2" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>

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
		
            function configurar()
            {
                Calendar.setup({inputField : "fechinitit",ifFormat : "%d/%m/%Y",button : "botonFechinitit"});
            }
            
            //totalidad de elementos en el form
            var cajas = new Array('identitfams','fechinitit','numecueban','firmatitul','observacion');
            var combos = new Array ('codunifamis','codtipoidentidads','coditiptit','codbanco','codiesttit');
            
            //validar
            var arrayNonulos               	= new Array ('identitfams');
            var arrayNumerosEnteros        	= null;
            var arrayCombos               	= new Array ('codunifamis','codtipoidentidads','coditiptit','codbanco','codiesttit');
            var arrayCadenasANCod          	= new Array ('identitfams','numecueban');
            var arrayCadenasA              	= null;            
            var arrayComentarios           	= new Array ('firmatitul','observacion');
            var arrayNumerosDoubles        	= null;
                        
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
            <c:if test="${param.codunifami != null && param.codtipoidentidad != null && param.identitfam != null}">
            <sql:query var="r" sql="SELECT * FROM titularfamilia WHERE codunifami='${param.codunifami}' AND codtipoidentidad='${param.codtipoidentidad}' AND identitfam='${param.identitfam}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codunifamif" value="${fila.codunifami}"/>
              <c:set var="codtipoidentidadf" value="${fila.codtipoidentidad}"/>
              <c:set var="identitfamf" value="${fila.identitfam}"/>
              <c:set var="coditiptit" value="${fila.coditiptit}"/> 
              <fmt:formatDate value="${fila.fechinitit}" pattern="dd/MM/yyyy" var="fechinitit"/>
              <c:set var="vivehijos" value="${fila.vivehijos}"/>             
              <c:set var="numecueban" value="${fila.numecueban}"/>
              <c:set var="codbanco" value="${fila.codbanco}"/>
              <c:set var="codiesttit" value="${fila.codiesttit}"/>              
              <c:set var="firmatitul" value="${fila.firmatitul}"/>              
              <c:set var="observacion" value="${fila.observacion}"/>
              
              <%--Carga del archivo de la base de datos---------------------%>
              <%
              String ruta = request.getSession().getServletContext().getRealPath("temp")+"\\";
              ruta = ruta.replaceAll("\\\\","/");
              pageContext.setAttribute("ruta",ruta);
              %>
              <sql:query var="r" sql="select lo_export(titularfamilia.archivofi, '${ruta}${firmatitul}') from titularfamilia WHERE codunifami='${param.codunifami}' AND codtipoidentidad='${param.codtipoidentidad}' AND identitfam='${param.identitfam}'" dataSource="jdbc/delphos" scope="page"/>
              <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <%------------------------------------------------------------%>
              </jsp2:forEach>
              <%------------------------------------------------------------%>

            </jsp2:forEach>
            <form name="formulario" id="formulario" method="post" action="TitularFamilia.jsp">
            <table width="811" border="0" class="tablaContenido">
              <span id="mensajeControlador">${msj}</span>
              
              <tr align="center">
                <td colspan="6" class="titulo1" valign="middle" height="19">Titular Familia</td>
              </tr>
              <tr align="center">
                <td colspan="6" align="left" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr align="center">
                <td align="left" class="bgDescTablas">&nbsp;</td>
                <td align="left" class="bgDescTablas"><strong>C&oacute;digo Unico Familia</strong></td>
                <td colspan="4" align="left" class="bgDescTablas">
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
                </select></td>
              </tr>
              <tr align="center">
                <td colspan="6" align="left" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr align="center">
                <td width="30" align="left" class="bgDescTablas">&nbsp;</td>
                <td width="129" align="left" class="bgDescTablas"><b>Tipo id.</b></td>
                <td width="192" align="left" class="bgDescTablas">
                <select name="codtipoidentidads" id="codtipoidentidads" style="width: 150px">
                  <option id="codtipoidentidads" value=""></option>
                  <sql:query var="r" sql="select codtipoidentidad, descripcion from tipoidentificacion" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                    <c:choose>
                      <c:when test='${fila.codtipoidentidad == codtipoidentidadf}'>
                        <option value="${fila.codtipoidentidad}" selected="selected">${fila.descripcion}</option>
                      </c:when>
                      <c:otherwise>
                        <option value="${fila.codtipoidentidad}">${fila.descripcion}</option>
                      </c:otherwise>
                    </c:choose>
                  </jsp2:forEach>
                </select></td>
                <td class="bgDescTablas" width="22">&nbsp;</td>
                <td width="142" align="left" class="bgDescTablas"><p><b>Nro. Identificacion</b></p>    </td>
                <td width="161" align="left" class="bgDescTablas"><p>
                  <input name="identitfams" type="text" id="identitfams" value="${identitfamf}" size="20" maxlength="18"/>
            </p></td>
              </tr>
              <tr rowspan = "1">
                <td colspan="6" align="left" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr align="center">
                <td align="left" class="bgDescTablas">&nbsp;</td>
                <td align="left" class="bgDescTablas"><b>Tipo T&iacute;tular</b></td>
                <td class="bgDescTablas" align="left">
                <select name="coditiptit" id="coditiptit" style="width: 150px">
                  <option id="coditiptit" value=""></option>
                  <sql:query var="r" sql="select coditiptit, desctiptit from tipotitular" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                    <c:choose>
                      <c:when test='${fila.coditiptit == coditiptit}'>
                        <option value="${fila.coditiptit}" selected="selected">${fila.desctiptit}</option>
                      </c:when>
                      <c:otherwise>
                        <option value="${fila.coditiptit}">${fila.desctiptit}</option>
                      </c:otherwise>
                    </c:choose>
                  </jsp2:forEach>
                </select></td>
                <td class="bgDescTablas" width="22">&nbsp;</td>
                <td align="left" class="bgDescTablas"><p><strong>Fecha de Inicio</strong></p>    </td>
                <td class="bgDescTablas" align="left"><p>
                  <input name="fechinitit" type="text" id="fechinitit" value="${fechinitit}" size="15" readonly="readonly" />
                  <input name="button" type="button" id="botonFechinitit" value="..." />
                </p></td>
              </tr>
              <tr rowspan = "1">
                <td colspan="6" align="left" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas" align="left">&nbsp;</td>
                <td class="bgDescTablas" align="left"><b>Vive Con Hijos</b></td>
                <td colspan="4" align="left" class="bgDescTablas"><c:choose>
                <c:when test = '${vivehijos == "S"}'>
                  <label><span class="descCampoForm">Si
                    <input type="radio" name="vivehijos" value="S" id="vivehijos_0" checked="true"/>
                  </span> </label>
                  <label> <span class="descCampoForm">No
                    <input type="radio" name="vivehijos" value="N" id="vivehijos_1" />
                  </span> </label>
                </c:when>
                  <c:otherwise>
                    <label> <span class="descCampoForm">Si
                      <input type="radio" name="vivehijos" value="S" id="vivehijos_0"/>
                    </span> </label>
                    <label> <span class="descCampoForm">No
                      <input type="radio" name="vivehijos" value="N" id="vivehijos_1" checked="true"/>
                    </span> </label>
                  </c:otherwise>
                  </c:choose></td>
              </tr>
              <tr rowspan = "1">
                <td colspan="6" align="left" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr align="center">
                <td width="30" align="left" class="bgDescTablas">&nbsp;</td>
                <td align="left" class="bgDescTablas"><b>Banco</b></td>
                <td class="bgDescTablas" align="left">
                <select name="codbanco" id="codbanco" style="width: 150px">
                  <option id="codbanco" value=""></option>
                  <sql:query var="r" sql="select codbanco, nombre from banco a join empresa b on a.codempresa = b.codempresa" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                    <c:choose>
                      <c:when test='${fila.codbanco == codbanco}'>
                        <option value="${fila.codbanco}" selected="selected">${fila.nombre}</option>
                      </c:when>
                      <c:otherwise>
                        <option value="${fila.codbanco}">${fila.nombre}</option>
                      </c:otherwise>
                    </c:choose>
                  </jsp2:forEach>
                </select></td>
                <td class="bgDescTablas" width="22">&nbsp;</td>
                <td align="left" class="bgDescTablas"><b>Nro. Cuenta Bancaria </b></td>
                <td class="bgDescTablas" align="left"><input name="numecueban" type="text" id="numecueban" value="${numecueban}" size="20" maxlength="20" /></td>
              </tr>
              <tr rowspan = "1">
                <td colspan="6" align="left" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas" align="left">&nbsp;</td>
                <td class="bgDescTablas" align="left"><b>Estado</b></td>
                <td class="bgDescTablas" align="left">
                <select name="codiesttit" id="codiesttit" style="width: 150px">
                  <option id="codiesttit" value=""></option>
                  <sql:query var="r" sql="select codiesttit, descripcion from estadotitular" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                    <c:choose>
                      <c:when test='${fila.codiesttit == codiesttit}'>
                        <option value="${fila.codiesttit}" selected="selected">${fila.descripcion}</option>
                      </c:when>
                      <c:otherwise>
                        <option value="${fila.codiesttit}">${fila.descripcion}</option>
                      </c:otherwise>
                    </c:choose>
                  </jsp2:forEach>
                </select></td>
                <td class="bgDescTablas" align="left">&nbsp;</td>
                <td class="bgDescTablas" align="left"><b>Firma</b></td>
                <td class="bgDescTablas" align="left"><span class="sinBgDescTablas" style="width: 20%">
                  <input name="firmatitul" type="text" id="firmatitul" size="15"  value="${firmatitul}" readonly="readonly"/>
                  <a href="#" onClick="abrirCargaArchivo();"><img src="../images/Buscar16x16.gif" alt="Cargar Archivo" border="0" tabindex="4"/></a>
                  <c:if test='${firmatitul != null && firmatitul != ""}'><br>
                    <a href="../temp/${firmatitul}" target="_blank">Descargar ${firmatitul}</a> </c:if>
                </span></td>
              </tr>
              <tr rowspan = "1">
                <td colspan="6" align="left" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr rowspan = "1">
                <td colspan="6" align="left" class="bgDescTablas"><p align="center"><strong>Observaciones</strong></p>
                <p align="center">
                  <textarea name="observacion" id="observacion" cols="75" rows="3">${observacion}</textarea>
                </p></td>
              </tr>
              <tr rowspan = "1">
                <td colspan="6" align="left" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td colspan="7"><div align="center">
                  <input type="hidden" name="codunifami" id="codunifami" value="" >
                  <input type="hidden" name="codtipoidentidad" id="codtipoidentidad" value="" >
                  <input type="hidden" name="identitfam" id="identitfam" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="26"> -->
		  <label>&nbsp;</label>
                  <!--<input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="23"/>
                  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="24"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="25"/> -->
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
    configurar();
	
	function abrirCargaArchivo()
    {
        var url;
        url = "PopUpCargaArchivo.jsp?";
        url = url + "campo=firmatitul";
        
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
        llaves+= 'codtipoidentidad='+document.getElementById('codtipoidentidads').value+',';
		llaves+= 'identitfam='+document.getElementById('identitfams').value;
        validarLlave('titularfamilia',llaves);
    } 
    
    //
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=titularfamilia&";
        url = url + "campos=codunifami,codtipoidentidad,identitfam,coditiptit,fechinitit,vivehijos,numecueban,codbanco&";
        url = url + "campoLlave=codunifami,codtipoidentidad,identitfam";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>