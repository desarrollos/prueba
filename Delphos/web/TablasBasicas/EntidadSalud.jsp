<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<%@ taglib prefix="jsp2" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>

<html>
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
		Calendar.setup({inputField : "fechaactoadmin",ifFormat : "%d/%m/%Y",button : "botonFechaactoadmin"});
	    }            
            
            //totalidad de elementos en el form
            var cajas = new Array('codentidadsaluds','contacto','cargocontacto','lineagratuita','codigobarras','slogan','codhabilitacion','nombrehabilitacion','numactoinscripcion','funcionarios','fechaactoadmin');
            var combos = new Array('codregimeness','codempresa','codtipoentidadsalud','codnivelcomplejidad','codclasifentidad','codtipoespecializacion','codtipoatencion','codestadoentidad');
			
            var arrayNonulos               	= new Array('codentidadsaluds','funcionarios','fechaactoadmin');
            var arrayNumerosEnteros        	= new Array('funcionarios');
            var arrayCombos               	= new Array('codregimeness','codentidadsalud','codempresa','codtipoentidadsalud','codnivelcomplejidad','codclasifentidad','codtipoespecializacion','codtipoatencion','codestadoentidad');		
            var arrayCadenasANCod          	= new Array('codentidadsaluds','lineagratuita','codigobarras','codhabilitacion','numactoinscripcion');
            var arrayCadenasA              	= new Array('contacto','cargocontacto','nombrehabilitacion');
            var arrayComentarios           	= new Array('slogan','logo','archivoactoadmin');
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
            <c:if test="${param.codregimenes != null && param.codentidadsalud != null}">
            <sql:query var="r" sql="SELECT * FROM entidadsalud WHERE codregimenes='${param.codregimenes}' AND codentidadsalud='${param.codentidadsalud}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codregimenesf" value="${fila.codregimenes}"/>
              <c:set var="codentidadsaludf" value="${fila.codentidadsalud}"/>
              <c:set var="codtipoidentidad" value="${fila.codtipoidentidad}"/>
              <c:set var="codempresa" value="${fila.codempresa}"/>             
              <c:set var="codtipoentidadsalud" value="${fila.codtipoentidadsalud}"/>
              <c:set var="codnivelcomplejidad" value="${fila.codnivelcomplejidad}"/>
              <c:set var="codclasifentidad" value="${fila.codclasifentidad}"/>              
              <c:set var="contacto" value="${fila.contacto}"/>              
              <c:set var="cargocontacto" value="${fila.cargocontacto}"/>
              <c:set var="lineagratuita" value="${fila.lineagratuita}"/>
              <c:set var="funcionarios" value="${fila.funcionarios}"/>
              <c:set var="codigobarras" value="${fila.codigobarras}"/>
              <c:set var="logo" value="${fila.logo}"/>
              <c:set var="slogan" value="${fila.slogan}"/>             
              <c:set var="codhabilitacion" value="${fila.codhabilitacion}"/>
              <c:set var="nombrehabilitacion" value="${fila.nombrehabilitacion}"/>
              <c:set var="codtipoespecializacion" value="${fila.codtipoespecializacion}"/>
              <c:set var="codtipoatencion" value="${fila.codtipoatencion}"/>
              <c:set var="codestadoentidad" value="${fila.codestadoentidad}"/>
              <c:set var="numactoinscripcion" value="${fila.numactoinscripcion}"/>
              <fmt:formatDate value="${fila.fechaactoadmin}" pattern="dd/MM/yyyy" var="fechaactoadmin"/>
              <c:set var="archivoactoadmin" value="${fila.archivoactoadmin}"/>
              
              <%--Carga del archivo de la base de datos---------------------%>
              <%
              String ruta = request.getSession().getServletContext().getRealPath("temp")+"\\";
              ruta = ruta.replaceAll("\\\\","/");
              pageContext.setAttribute("ruta",ruta);
              %>
              <sql:query var="r" sql="select lo_export(entidadsalud.archivofi, '${ruta}${archivoactoadmin}') from entidadsalud where codregimenes='${param.codregimenes}' AND codentidadsalud='${param.codentidadsalud}'" dataSource="jdbc/delphos" scope="page"/>
              <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <%------------------------------------------------------------%>
              </jsp2:forEach>
              <%------------------------------------------------------------%>
              
              <%--Carga del archivo de la base de datos---------------------%>
              <%
              String ruta1 = request.getSession().getServletContext().getRealPath("temp")+"\\";
              ruta1 = ruta1.replaceAll("\\\\","/");
              pageContext.setAttribute("ruta",ruta);
              %>
              <sql:query var="r" sql="select lo_export(entidadsalud.archivofi2, '${ruta}${logo}') from entidadsalud where codregimenes='${param.codregimenes}' AND codentidadsalud='${param.codentidadsalud}'" dataSource="jdbc/delphos" scope="page"/>
              <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <%------------------------------------------------------------%>
              </jsp2:forEach>
              <%------------------------------------------------------------%>
              
  </jsp2:forEach>
            <form name="formulario" id="formulario" method="post" action="EntidadSalud.jsp">
            <table width="811" border="0" class="tablaContenido">
              <span id="mensajeControlador">${msj}</span>
              <tr>
                <td colspan="6"><div align="center" class="titulo1">Entidad Salud</div></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td width="25">&nbsp;</td>
                <td><span class="bgDescTablas"><strong>Regimen</strong></span></td>
                <td><select name="codregimeness" id="codregimeness" style="width: 150px" tabindex="1">
                  <option id="codregimeness" value=""></option>
                  <sql:query var="r" sql="select codregimen, descripcion from regimen" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                    <c:choose>
                      <c:when test='${fila.codregimen == codregimenesf}'>
                        <option value="${fila.codregimen}" selected="selected">${fila.descripcion}</option>
                      </c:when>
                      <c:otherwise>
                        <option value="${fila.codregimen}">${fila.descripcion}</option>
                      </c:otherwise>
                    </c:choose>
                  </jsp2:forEach>
                </select></td>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">C&oacute;digo Entidad Salud</strong></td>
                <td><label>
                  <input name="codentidadsaluds" type="text" id="codentidadsaluds" value="${codentidadsaludf}" size="20" maxlength="18" onKeyPress="javascript:return permite(event, 'num_car_cod')" tabindex="2">
                </label></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td width="25">&nbsp;</td>
                <td width="137"><span class="bgDescTablas"><strong>Empresa</strong></span></td>
                <td width="162"><span class="sinBgDescTablas" style="width: 20%">
                  <select name="codempresa" id="codempresa" style="width: 150px" tabindex="3">
                    <option id="codempresa" value=""></option>
                    <sql:query var="r" sql="select codtipoidentidad, codempresa, nombre from empresa" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.codempresa == codempresa}'>
                          <option value="${fila.codtipoidentidad} ${fila.codempresa}" selected="selected">${fila.nombre}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.codtipoidentidad} ${fila.codempresa}">${fila.nombre}</option>
                        </c:otherwise>
                      </c:choose>
                    </jsp2:forEach>
                  </select>
                </span></td>
                <td width="17">&nbsp;</td>
                <td width="134" class="bgDescTablas"><strong>Tipo Entidad Salud</strong></td>
                <td width="167">
                <select name="codtipoentidadsalud" id="codtipoentidadsalud" style="width: 150px" tabindex="4">
                  <option id="codtipoentidadsalud" value=""></option>
                  <sql:query var="r" sql="select codtipoentidadsalud, descripcion from tipoentidadsalud" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                    <c:choose>
                      <c:when test='${fila.codtipoentidadsalud == codtipoentidadsalud}'>
                        <option value="${fila.codtipoentidadsalud}" selected="selected">${fila.descripcion}</option>
                      </c:when>
                      <c:otherwise>
                        <option value="${fila.codtipoentidadsalud}">${fila.descripcion}</option>
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
                <td><span class="bgDescTablas" style="width: 7%"><strong>Nivel Complejidad</strong></span></td>
                <td><span class="sinBgDescTablas" style="width: 20%">
                  <select name="codnivelcomplejidad" id="codnivelcomplejidad" style="width: 150px" tabindex="5">
                    <option id="codnivelcomplejidad" value=""></option>
                    <sql:query var="r" sql="select codnivelcomplejidad, descripcion from nivelcomplejidad" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.codnivelcomplejidad == codnivelcomplejidad}'>
                          <option value="${fila.codnivelcomplejidad}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.codnivelcomplejidad}">${fila.descripcion}</option>
                        </c:otherwise>
                      </c:choose>
                    </jsp2:forEach>
                  </select>
                </span></td>
                <td>&nbsp;</td>
                <td><span class="bgDescTablas"><strong>Clasificaci&oacute;n Entidad</strong></span></td>
                <td><span class="sinBgDescTablas">
                  <label>                  </label>
                </span>
                  <label><span class="sinBgDescTablas" style="width: 20%">
                  <select name="codclasifentidad" id="codclasifentidad" style="width: 150px" tabindex="6">
                    <option id="codclasifentidad" value=""></option>
                    <sql:query var="r" sql="select codclasifentidad, descripcion from clasificacionentidad" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.codclasifentidad == codclasifentidad}'>
                          <option value="${fila.codclasifentidad}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.codclasifentidad}">${fila.descripcion}</option>
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
                <td><span class="bgDescTablas"><strong>Contacto</strong></span></td>
                <td><label>
                  <input name="contacto" type="text" id="contacto" value="${contacto}" size="20" maxlength="60" onKeyPress="javascript:return permite(event, 'carac')" tabindex="7">
                </label></td>
                <td>&nbsp;</td>
                <td class="bgDescTablas"><strong>Cargo Contacto</strong></td>
                <td><label>
                  <input name="cargocontacto" type="text" id="cargocontacto" value="${cargocontacto}" size="20" maxlength="30" onKeyPress="javascript:return permite(event, 'carac')" tabindex="8">
                </label></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>Linea Gratuita</strong></td>
                <td><label>
                  <input name="lineagratuita" type="text" id="lineagratuita" value="${lineagratuita}" size="20" maxlength="20" onKeyPress="javascript:return permite(event, 'num_car_cod')" tabindex="9">
                </label></td>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">No. Funcionarios</strong></td>
                <td><label>
                  <input name="funcionarios" type="text" id="funcionarios" value="${funcionarios}" size="20" maxlength="6" onKeyPress="javascript:return permite(event, 'nume')" tabindex="10">
                </label></td>
              </tr>
              <tr>
                <td colspan="6" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>C&oacute;digo Barras</strong></td>
                <td><span class="sinBgDescTablas" style="width: 20%">
                  <label>
                  <input name="codigobarras" type="text" id="codigobarras" value="${codigobarras}" size="20" maxlength="70" onKeyPress="javascript:return permite(event, 'num_car_cod')" tabindex="11">
                  </label>
                </span></td>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">Logo</strong></td>
                <td><label><span class="sinBgDescTablas" style="width: 20%">
                <input name="logo" type="text" id="logo" size="15"  value="${logo}" readonly="readonly"/>
                <a href="#" onClick="abrirCargaArchivo2();" tabindex="12"><img src="../images/Buscar16x16.gif" alt="Cargar Archivo" border="0"/></a>
                <c:if test='${logo != null && logo != ""}'><br>
                  <a href="../temp/${logo}" target="_blank">Descargar ${logo}</a> </c:if>
                </span></label></td>
              </tr>
              <tr>
                <td colspan="6" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>C&oacute;digo Habilitaci&oacute;n</strong></td>
                <td><label>
                <input name="codhabilitacion" type="text" id="codhabilitacion" value="${codhabilitacion}" size="20" maxlength="18" onKeyPress="javascript:return permite(event, 'num_car_cod')" tabindex="13">
                </label></td>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">Nombre Habilitaci&oacute;n</strong></td>
                <td class="bgDescTablas"><label>
                  <input name="nombrehabilitacion" type="text" id="nombrehabilitacion" value="${nombrehabilitacion}" size="20" maxlength="60" onKeyPress="javascript:return permite(event, 'carac')" tabindex="14">
                </label></td>
              </tr>
              <tr>
                <td colspan="6" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>Tipo Especializaci&oacute;n</strong></td>
                <td class="bgDescTablas"><span class="sinBgDescTablas" style="width: 20%">
                  <select name="codtipoespecializacion" id="codtipoespecializacion" style="width: 150px" tabindex="15">
                    <option id="codtipoespecializacion" value=""></option>
                    <sql:query var="r" sql="select codtipoespecializacion, descripcion from tipoespecializacionsalud" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.codtipoespecializacion == codtipoespecializacion}'>
                          <option value="${fila.codtipoespecializacion}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.codtipoespecializacion}">${fila.descripcion}</option>
                        </c:otherwise>
                      </c:choose>
                    </jsp2:forEach>
                  </select>
                </span></td>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">Tipo Atenci&oacute;n</strong></td>
                <td><label><span class="sinBgDescTablas" style="width: 20%">
                  <select name="codtipoatencion" id="codtipoatencion" style="width: 150px" tabindex="16">
                    <option id="codtipoatencion" value=""></option>
                    <sql:query var="r" sql="select codtipoatencion, descripcion from tipoatencion" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.codtipoatencion == codtipoatencion}'>
                          <option value="${fila.codtipoatencion}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.codtipoatencion}">${fila.descripcion}</option>
                        </c:otherwise>
                      </c:choose>
                    </jsp2:forEach>
                  </select>
                </span></label></td>
              </tr>
              <tr>
                <td colspan="6" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>Estado Entidad</strong></td>
                <td class="bgDescTablas"><span class="sinBgDescTablas" style="width: 20%">
                  <select name="codestadoentidad" id="codestadoentidad" style="width: 150px" tabindex="17">
                    <option id="codestadoentidad" value=""></option>
                    <sql:query var="r" sql="select codestadoentidad, descripcion from estadoentidadsalud" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.codestadoentidad == codestadoentidad}'>
                          <option value="${fila.codestadoentidad}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.codestadoentidad}">${fila.descripcion}</option>
                        </c:otherwise>
                      </c:choose>
                    </jsp2:forEach>
                  </select>
                </span></td>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">No. Acto Inscripci&oacute;n</strong></td>
                <td class="bgDescTablas"><label>
                  <input name="numactoinscripcion" type="text" id="numactoinscripcion" value="${numactoinscripcion}" size="20" maxlength="20" onKeyPress="javascript:return permite(event, 'num_car_cod')" tabindex="18">
                </label></td>
              </tr>
              <tr>
                <td colspan="6" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>Fecha Acto Administrativo</strong></td>
                <td><label><span class="sinBgDescTablas" style="width: 20%">
                  <input name="fechaactoadmin" type="text" id="fechaactoadmin"  value="${fechaactoadmin}" size="15" maxlength="19" readonly="readonly"/>
                  <span class="sinBgDescTablas" style="width: 20%">
                  <input name="button" type="button" id="botonFechaactoadmin" value="..." tabindex="19"/>
                  </span></span></label></td>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">Archivo Acto Administrativo</strong></td>
                <td><label><span class="sinBgDescTablas" style="width: 20%">
                <input name="archivoactoadmin" type="text" id="archivoactoadmin" size="15"  value="${archivoactoadmin}" readonly="readonly"/>
                <a href="#" onClick="abrirCargaArchivo();" tabindex="20"><img src="../images/Buscar16x16.gif" alt="Cargar Archivo" border="0"/></a>
                <c:if test='${archivoactoadmin != null && archivoactoadmin != ""}'><br>
                  <a href="../temp/${archivoactoadmin}" target="_blank">Descargar ${archivoactoadmin}</a> </c:if>
                </span></label></td>
              </tr>
              <tr>
                <td colspan="6" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td colspan="6"><p align="center"><strong class="bgDescTablas">Slogan</strong></p>
                  <p align="center">
                    <label>
                    <textarea name="slogan" cols="75" rows="3" id="slogan" onKeyPress="javascript:return permite(event, 'com')" tabindex="21">${slogan}</textarea>
                    </label>
                  </p></td>
              </tr>
              <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="codregimenes" id="codregimenes" value="" >
                  <input type="hidden" name="codentidadsalud" id="codentidadsalud" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="25"> -->
		  <label>&nbsp;</label>
                  <!--<input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="22"/>
                  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="23"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="24"/> -->
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
        <jsp:include page="../footer.jsp" />    </td>
</tr>
</table>
</center>
<!-- End ImageReady Slices -->
<script>
    configurar();
    
    function abrirCargaArchivo()
    {
        var url;
        url = "PopUpCargaArchivo.jsp?";
        url = url + "campo=archivoactoadmin";
        
        window.open(url,"_blank","width=500,height=190,scrollbars=1,left=350,top=100");
    }
	
    function abrirCargaArchivo2()
    {
        var url;
        url = "PopUpCargaArchivo.jsp?";
        url = url + "campo=logo";
        
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
        llaves = 'codregimenes='+document.getElementById('codregimeness').value+',';
	llaves+= 'codentidadsalud='+document.getElementById('codentidadsaluds').value;
        //llaves+= 'codmunicipio='+document.getElementById('codmunicipio').value+',';
        validarLlave('entidadsalud',llaves);
    } 
    
    //
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=entidadsalud&";
        url = url + "campos=codregimenes,codentidadsalud,codtipoidentidad,codempresa,codtipoentidadsalud,codnivelcomplejidad,codclasifentidad,contacto&";
        url = url + "campoLlave=codregimenes,codentidadsalud";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>