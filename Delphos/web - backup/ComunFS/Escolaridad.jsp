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
           
            function configurar()
            {
		Calendar.setup({inputField : "escfecharegi",ifFormat : "%d/%m/%Y",button : "botonEscfecharegi"});
		Calendar.setup({inputField : "escfechamatr",ifFormat : "%d/%m/%Y",button : "botonEscfechamatr"});
	    }
			
			//totalidad de elementos en el form
            var cajas = new Array('escidentifics','escfecharegi','escvigencias','escfechamatr','escnumermatr','escprofesor','escarchimatr','escarchicert','escobservaci');
            var combos = new Array('codempresas','codtipoidentidads','escgracodigo','escestcodigo');
			
            var arrayNonulos               	= new Array('escidentifics','escvigencias','escfecharegi','escfechamatr');
            var arrayNumerosEnteros        	= new Array('escvigencias');
            var arrayCombos               	= new Array('codempresas','codtipoidentidads','escgracodigo','escestcodigo');
            var arrayCadenasANCod          	= new Array('escidentifics','escnumermatr','escprofesor');
            var arrayCadenasA              	= null;
            var arrayComentarios           	= new Array('escobservaci','escarchimatr','escarchicert');
            var arrayNumerosDoubles        	= null;
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
            <c:if test='${param.codtipoidentidadins != null && param.codempresa != null && param.codtipoidentidad != null && param.escidentific != null && param.escvigencia != null && param.escvigencia != ""}'>
            <sql:query var="r" sql="SELECT * FROM escolaridad WHERE codtipoidentidadins='${param.codtipoidentidadins}' AND codempresa='${param.codempresa}' AND codtipoidentidad='${param.codtipoidentidad}' AND escidentific='${param.escidentific}' AND escvigencia=${param.escvigencia}" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codtipoidentidadinsf" value="${fila.codtipoidentidadins}"/>
              <c:set var="codempresaf" value="${fila.codempresa}"/>
              <c:set var="codtipoidentidadf" value="${fila.codtipoidentidad}"/>
              <c:set var="escidentificf" value="${fila.escidentific}"/>
              <c:set var="escvigenciaf" value="${fila.escvigencia}"/>
              <fmt:formatDate value="${fila.escfecharegi}" pattern="dd/MM/yyyy" var="escfecharegi"/>
              <c:set var="escfechamatr" value="${fila.escfechamatr}"/>
              <c:set var="escnumermatr" value="${fila.escnumermatr}"/>               
              <c:set var="escgracodigo" value="${fila.escgracodigo}"/>
              <c:set var="escprofesor" value="${fila.escprofesor}"/>
              <c:set var="escestcodigo" value="${fila.escestcodigo}"/>
              <c:set var="escarchimatr" value="${fila.escarchimatr}"/>
              <c:set var="escarchicert" value="${fila.escarchicert}"/>
              <c:set var="escobservaci" value="${fila.escobservaci}"/>
              
              <%--Carga del archivo de la base de datos---------------------%>
              <%
              String ruta = request.getSession().getServletContext().getRealPath("temp")+"\\";
              ruta = ruta.replaceAll("\\\\","/");
              pageContext.setAttribute("ruta",ruta);
              %>
              <sql:query var="r" sql="select lo_export(escolaridad.archivofi, '${ruta}${escarchimatr}') from escolaridad WHERE codtipoidentidadins='${param.codtipoidentidadins}' AND codempresa='${param.codempresa}' AND codtipoidentidad='${param.codtipoidentidad}' AND escidentific='${param.escidentific}' AND escvigencia=${param.escvigencia}" dataSource="jdbc/delphos" scope="page"/>
              <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <%------------------------------------------------------------%>
              </jsp2:forEach>
              <%------------------------------------------------------------%>
              
              <%--Carga del archivo de la base de datos---------------------%>
              <%
              String ruta1 = request.getSession().getServletContext().getRealPath("temp")+"\\";
              ruta1 = ruta1.replaceAll("\\\\","/");
              pageContext.setAttribute("ruta",ruta1);
              %>
              <sql:query var="r" sql="select lo_export(escolaridad.archivofi2, '${ruta}${escarchicert}') from escolaridad WHERE codtipoidentidadins='${param.codtipoidentidadins}' AND codempresa='${param.codempresa}' AND codtipoidentidad='${param.codtipoidentidad}' AND escidentific='${param.escidentific}' AND escvigencia=${param.escvigencia}" dataSource="jdbc/delphos" scope="page"/>
              <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <%------------------------------------------------------------%>
              </jsp2:forEach>
              <%------------------------------------------------------------%>
              
 </jsp2:forEach>
                
                <form name="formulario" method="post" action="Escolaridad.jsp">
                <span id="mensajeControlador">${msj}</span>
                <table width="829" border="0" class="tablaContenido">
				
                  <tr>
                    <td colspan="6"><div align="center"><span class="titulo1">Escolaridad</span></div></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td><span class="bgDescTablas"><strong>Instituci&oacute;n Educativa</strong></span></td>
                    <td colspan="4">
                    <select name="codempresas" id="codempresas" style="width: 150px">
                    <option id="codempresas" value=""></option>
                  <sql:query var="r" sql="select codtipoidentidad, codempresa, nombre from empresa" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                   <c:choose>
                        <c:when test='${fila.codtipoidentidad == codtipoidentidadinsf && fila.codempresa == codempresaf}'>
                        <option value="${fila.codtipoidentidad} ${fila.codempresa}" selected="selected">${fila.nombre}</option>
                        </c:when>
                    <c:otherwise>
                        <option value="${fila.codtipoidentidad} ${fila.codempresa}">${fila.nombre}</option>
                    </c:otherwise>
                   </c:choose>
                 </jsp2:forEach>
                    </select></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="30">&nbsp;</td>
                    <td width="157"><span class="bgDescTablas"><strong>Tipo Id.</strong></span></td>
                    <td width="201">
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
                    <td width="5">&nbsp;</td>
                    <td width="120"><span class="bgDescTablas"><strong>Nro. Identificaci&oacute;n</strong></span></td>
                    <td width="163"><input name="escidentifics" type="text" id="escidentifics" value="${escidentificf}" size="20" maxlength="18" onkeypress="javascript:return permite(event, 'num_car_cod')"/></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td><span class="bgDescTablas"><strong>Fecha Registro</strong></span></td>
                    <td><input name="escfecharegi" type="text" id="escfecharegi" value="${escfecharegi}" size="15" readonly="true" />
                    <input name="button" type="button" id="botonEscfecharegi" value="..." /></td>
                    <td>&nbsp;</td>
                    <td><span class="bgDescTablas"><strong>Vigencia</strong></span></td>
                    <td><input name="escvigencias" type="text" id="escvigencias" value="${escvigenciaf}" size="20" maxlength="4" onkeypress="javascript:return permite(event, 'nume')"/></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td><span class="bgDescTablas"><strong>Fecha Matricula</strong></span></td>
                    <td><input name="escfechamatr" type="text" id="escfechamatr" value="${escfechamatr}" size="15" readonly="true" />
                    <input name="button2" type="button" id="botonEscfechamatr" value="..." /></td>
                    <td>&nbsp;</td>
                    <td><span class="bgDescTablas"><strong>Nro. Matricula</strong></span></td>
                    <td><input name="escnumermatr" type="text" id="escnumermatr" value="${escnumermatr}" size="20" maxlength="15" onkeypress="javascript:return permite(event, 'num_car_cod')"/></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td><strong class="bgDescTablas">Grado Escolaridad Inicial</strong></td>
                    <td><select name="escgracodigo" id="escgracodigo" style="width: 150px">
                      <option id="escgracodigo" value=""></option>
                      <sql:query var="r" sql="select escgracodigo, escgradescri from escolaridadgrado" dataSource="jdbc/delphos" scope="page"/>
                      <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                        <c:choose>
                          <c:when test='${fila.escgracodigo == escgracodigo}'>
                            <option value="${fila.escgracodigo}" selected="selected">${fila.escgradescri}</option>
                          </c:when>
                          <c:otherwise>
                            <option value="${fila.escgracodigo}">${fila.escgradescri}</option>
                          </c:otherwise>
                        </c:choose>
                      </jsp2:forEach>
                    </select></td>
                    <td>&nbsp;</td>
                    <td><span class="bgDescTablas"><strong>Estado Escolaridad</strong></span></td>
                    <td>
                    <select name="escestcodigo" id="escestcodigo" style="width: 150px">
                     <option id="escestcodigo" value=""></option>
                  <sql:query var="r" sql="select escestcodigo, escescdescri from escolaridadestado" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                   <c:choose>
                        <c:when test='${fila.escestcodigo == escestcodigo}'>
                        <option value="${fila.escestcodigo}" selected="selected">${fila.escescdescri}</option>
                        </c:when>
                    <c:otherwise>
                        <option value="${fila.escestcodigo}">${fila.escescdescri}</option>
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
                    <td><span class="bgDescTablas"><strong>Profesor o coordinador referente</strong></span></td>
                    <td colspan="4"><input name="escprofesor" type="text" id="escprofesor" value="${escprofesor}" size="20" maxlength="70" onkeypress="javascript:return permite(event, 'num_car_cod')"/></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td><span class="bgDescTablas"><strong>Documento Matricula</strong></span></td>
                    <td><span class="sinBgDescTablas" style="width: 20%">
                      <input name="escarchimatr" type="text" id="escarchimatr" size="15"  value="${escarchimatr}" readonly="readonly"/>
                      <a href="#" onclick="abrirCargaArchivo();"><img src="../images/Buscar16x16.gif" alt="Cargar Archivo" border="0" tabindex="4"/></a>
                    <c:if test='${escarchimatr != null && escarchimatr != ""}'><br>
                    <a href="../temp/${escarchimatr}" target="_blank">Descargar ${escarchimatr}</a> </c:if>
                    </span></td>
                    <td>&nbsp;</td>
                    <td><span class="bgDescTablas"><strong>Documento Certificado</strong></span></td>
                    <td><span class="sinBgDescTablas" style="width: 20%">
                      <input name="escarchicert" type="text" id="escarchicert" size="15"  value="${escarchicert}" readonly="readonly"/>
                      <a href="#" onclick="abrirCargaArchivo1();"><img src="../images/Buscar16x16.gif" alt="Cargar Archivo" border="0" tabindex="4"/></a>
                      <c:if test='${escarchicert != null && escarchicert != ""}'><br>
                        <a href="../temp/${escarchicert}" target="_blank">Descargar ${escarchicert}</a> </c:if>
                    </span></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="6"><p align="center" class="bgDescTablas"><strong>Observaciones</strong></p>
                      <p align="center" class="bgDescTablas"><strong>
                      <textarea name="escobservaci" cols="75" rows="3" id="escobservaci" onkeypress="javascript:return permite(event, 'com')">${escobservaci}</textarea>
                      </strong></p></td>
                  </tr>
             <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="codtipoidentidadins" id="codtipoidentidadins" value="" >
                  <input type="hidden" name="codempresa" id="codempresa" value="" >
                  <input type="hidden" name="codtipoidentidad" id="codtipoidentidad" value="" >
                  <input type="hidden" name="escidentific" id="escidentific" value="" >
                  <input type="hidden" name="escvigencia" id="escvigencia" value="" >
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
	
	function abrirCargaArchivo()
    {
        var url;
        url = "PopUpCargaArchivo.jsp?";
        url = url + "campo=escarchimatr";
        
        window.open(url,"_blank","width=500,height=190,scrollbars=1,left=350,top=100");
    }
	
	function abrirCargaArchivo1()
    {
        var url;
        url = "PopUpCargaArchivo.jsp?";
        url = url + "campo=escarchicert";
        
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
        var cad = document.getElementById('codempresas').value;
        var cad2 = cad.split(" ");
		
        llaves = 'codtipoidentidadins='+cad2[0]+',';
		llaves+= 'codempresa='+cad2[1]+',';
		
        llaves+= 'codtipoidentidad='+document.getElementById('codtipoidentidads').value+',';
		llaves+= 'escidentific='+document.getElementById('escidentifics').value+',';
        llaves+= 'escvigencia='+document.getElementById('escvigencias').value;
        validarLlave('escolaridad',llaves);
    }
    
    configurar();
    
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=escolaridad&";
        url = url + "campos=codtipoidentidadins,codempresa,codtipoidentidad,escidentific,escvigencia,escfecharegi,escfechamatr,escnumermatr&";
        url = url + "campoLlave=codtipoidentidadins,codempresa,codtipoidentidad,escidentific,escvigencia";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>