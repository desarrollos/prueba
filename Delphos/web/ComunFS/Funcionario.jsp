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
		Calendar.setup({inputField : "fechanacimiento",ifFormat : "%d/%m/%Y",button : "botonFechanacimiento"});
	    }
            
            //totalidad de elementos en el form
            var cajas = new Array('numidentfuncs','nombres','matriculaprofesional','telefonofijo','telefonomovil','fechanacimiento');
            var combos = new Array('codtipoidentidads','codtipofuncionario','codempresas','codcargo','codocupacion','codentidadsaludeapbs','codentidadsaludipss','codestadofuncionario','codespecialidad','codgruposanguineo','codactividadeconomica');
			
            var arrayNonulos               	= new Array('numidentfuncs');
            var arrayNumerosEnteros        	= null;
            var arrayCombos               	= new Array('codtipoidentidads','codtipofuncionario','codempresas','codcargo','codocupacion','codentidadsaludeapbs','codentidadsaludipss','codestadofuncionario','codespecialidad','codgruposanguineo','codactividadeconomica');			
            var arrayCadenasANCod          	= new Array('numidentfuncs','matriculaprofesional','telefonofijo','telefonomovil');
            var arrayCadenasA              	= new Array('nombres');
            var arrayComentarios           	= null;
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
            <c:if test="${param.codtipoidentidad != null && param.numidentfunc != null}">
            <sql:query var="r" sql="SELECT * FROM funcionario WHERE codtipoidentidad='${param.codtipoidentidad}' AND numidentfunc='${param.numidentfunc}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codtipoidentidadf" value="${fila.codtipoidentidad}"/>
              <c:set var="numidentfuncf" value="${fila.numidentfunc}"/>
              <c:set var="codtipofuncionario" value="${fila.codtipofuncionario}"/>
              <c:set var="nombref" value="${fila.nombre}"/>             
              <c:set var="matriculaprofesional" value="${fila.matriculaprofesional}"/>
              <c:set var="codtipoidentidadempf" value="${fila.codtipoidentidademp}"/>
              <c:set var="codempresaf" value="${fila.codempresa}"/>
              <c:set var="codcargo" value="${fila.codcargo}"/>              
              <c:set var="codocupacion" value="${fila.codocupacion}"/>
              <fmt:formatDate value="${fila.fechanacimiento}" pattern="dd/MM/yyyy" var="fechanacimiento"/>             
              <c:set var="telefonofijo" value="${fila.telefonofijo}"/>
              <c:set var="telefonomovil" value="${fila.telefonomovil}"/>
              <c:set var="codregimeneapbf" value="${fila.codregimeneapb}"/>
              <c:set var="codentidadsaludeapbf" value="${fila.codentidadsaludeapb}"/>
              <c:set var="codregimenipsf" value="${fila.codregimenips}"/>
              <c:set var="codentidadsaludipsf" value="${fila.codentidadsaludips}"/>
              
              <c:set var="fotodocumentoidentidad" value="${fila.fotodocumentoidentidad}"/>
              
              <c:set var="codestadofuncionario" value="${fila.codestadofuncionario}"/>
              <c:set var="codespecialidad" value="${fila.codespecialidad}"/>
              <c:set var="codgruposanguineo" value="${fila.codgruposanguineo}"/>
              <c:set var="codactividadeconomica" value="${fila.codactividadeconomica}"/>
              
              <%--Carga del archivo de la base de datos---------------------%>
              <%
              String ruta = request.getSession().getServletContext().getRealPath("temp")+"\\";
              ruta = ruta.replaceAll("\\\\","/");
              pageContext.setAttribute("ruta",ruta);
              %>
              <sql:query var="r" sql="select lo_export(funcionario.archivofi, '${ruta}${fotodocumentoidentidad}') from funcionario where codtipoidentidad='${param.codtipoidentidad}' AND numidentfunc='${param.numidentfunc}'" dataSource="jdbc/delphos" scope="page"/>
              <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <%------------------------------------------------------------%>
              </jsp2:forEach>
              <%------------------------------------------------------------%>
              
            </jsp2:forEach>
            <form action="Funcionario.jsp" method="post" name="formulario" id="formulario">
            <table width="811" border="0" class="tablaContenido">
              <span id="mensajeControlador">${msj}</span>
              <tr>
                <td colspan="6"><div align="center" class="titulo1">Funcionario</div></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td width="30">&nbsp;</td>
                <td><span class="bgDescTablas"><strong>Tipo Identificaci&oacute;n</strong></span></td>
                <td><select name="codtipoidentidads" id="codtipoidentidads" style="width: 150px" tabindex="1">
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
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">No. Identificaci&oacute;n</strong></td>
                <td><label>
                  <input name="numidentfuncs" type="text" id="numidentfuncs" value="${numidentfuncf}" size="20" maxlength="18" onKeyPress="javascript:return permite(event, 'num_car_cod')" tabindex="2">
                </label></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td width="30">&nbsp;</td>
                <td width="150"><span class="bgDescTablas"><strong>Tipo Funcionario</strong></span></td>
                <td width="160">
                <select name="codtipofuncionario" id="codtipofuncionario" style="width: 150px" tabindex="3">
                  <option id="codtipofuncionario" value=""></option>
                  <sql:query var="r" sql="select codtipofuncionario, descripcion from tipofuncionario" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                    <c:choose>
                      <c:when test='${fila.codtipofuncionario == codtipofuncionario}'>
                        <option value="${fila.codtipofuncionario}" selected="selected">${fila.descripcion}</option>
                      </c:when>
                      <c:otherwise>
                        <option value="${fila.codtipofuncionario}">${fila.descripcion}</option>
                      </c:otherwise>
                    </c:choose>
                  </jsp2:forEach>
                </select></td>
                <td width="12">&nbsp;</td>
                <td width="128" class="bgDescTablas"><strong>Nombre</strong></td>
                <td width="167"><label>
                  <input name="nombres" type="text" id="nombres" value="${nombref}" size="20" maxlength="60" onKeyPress="javascript:return permite(event, 'carac')" tabindex="4">
                </label></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><span class="bgDescTablas" style="width: 7%"><strong>No. Matricula Profesional</strong></span></td>
                <td><label>
                  <input name="matriculaprofesional" type="text" id="matriculaprofesional" value="${matriculaprofesional}" size="20" maxlength="20" onKeyPress="javascript:return permite(event, 'num_car_cod')" tabindex="5">
                </label></td>
                <td>&nbsp;</td>
                <td><span class="bgDescTablas"><strong>Empresa</strong></span></td>
                <td><span class="sinBgDescTablas">
                </span>
                  <label><span class="sinBgDescTablas" style="width: 20%">
                  <select name="codempresas" id="codempresas" style="width: 150px" tabindex="6">
                    <option id="codempresas" value=""></option>
                    <sql:query var="r" sql="select codempresa, codtipoidentidad, nombre from empresa" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.codempresa == codempresaf && fila.codtipoidentidad == codtipoidentidadempf}'>
                          <option value="${fila.codtipoidentidad} ${fila.codempresa}" selected="selected">${fila.nombre}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.codtipoidentidad} ${fila.codempresa}">${fila.nombre}</option>
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
                <td><span class="bgDescTablas"><strong>Cargo</strong></span></td>
                <td><span class="sinBgDescTablas" style="width: 20%">
                  <select name="codcargo" id="codcargo" style="width: 150px" tabindex="7">
                    <option id="codcargo" value=""></option>
                    <sql:query var="r" sql="select codcargo, descripcion from cargo" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.codcargo == codcargo}'>
                          <option value="${fila.codcargo}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.codcargo}">${fila.descripcion}</option>
                        </c:otherwise>
                      </c:choose>
                    </jsp2:forEach>
                  </select>
                </span></td>
                <td>&nbsp;</td>
                <td class="bgDescTablas"><strong>Ocupaci&oacute;n</strong></td>
                <td><span class="sinBgDescTablas" style="width: 20%">
                  <select name="codocupacion" id="codocupacion" style="width: 150px" tabindex="8">
                    <option id="codocupacion" value=""></option>
                    <sql:query var="r" sql="select codocupacion, descripcion from ocupacion" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.codocupacion == codocupacion}'>
                          <option value="${fila.codocupacion}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.codocupacion}">${fila.descripcion}</option>
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
                <td class="bgDescTablas"><strong>Fecha Nacimiento</strong></td>
                <td><span class="sinBgDescTablas" style="width: 20%">
                  <input name="fechanacimiento" type="text" id="fechanacimiento"  value="${fechanacimiento}" size="19" maxlength="19" readonly="readonly"/>
                  <span class="sinBgDescTablas" style="width: 20%">
                  <input name="button" type="button" id="botonFechanacimiento" value="..." tabindex="9"/>
                  </span></span></td>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">Telefono Fijo</strong></td>
                <td><label>
                  <input name="telefonofijo" type="text" id="telefonofijo" value="${telefonofijo}" size="20" maxlength="20" onKeyPress="javascript:return permite(event, 'num_car_cod')" tabindex="10">
                </label></td>
              </tr>
              <tr>
                <td colspan="6" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>Telefono Movil</strong></td>
                <td><label>
                  <input name="telefonomovil" type="text" id="telefonomovil" value="${telefonomovil}" size="20" maxlength="20" onKeyPress="javascript:return permite(event, 'num_car_cod')" tabindex="11">
                </label></td>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">Entidad Salud EAPB</strong></td>
                <td><label><span class="sinBgDescTablas" style="width: 20%">
                <select name="codentidadsaludeapbs" id="codentidadsaludeapbs" style="width: 150px" tabindex="12">
                  <option id="codentidadsaludeapbs" value=""></option>
                  <sql:query var="r" sql="select codregimenes, codentidadsalud, nombre from entidadsalud a join empresa b on a.codempresa = b.codempresa" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                    <c:choose>
                      <c:when test='${fila.codentidadsalud == codentidadsaludeapbf && fila.codregimenes == codregimeneapbf}'>
                        <option value="${fila.codregimenes} ${fila.codentidadsalud}" selected="selected">${fila.nombre}</option>
                      </c:when>
                      <c:otherwise>
                        <option value="${fila.codregimenes} ${fila.codentidadsalud}">${fila.nombre}</option>
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
                <td class="bgDescTablas"><strong>Entidad Salud IPS</strong></td>
                <td><label><span class="sinBgDescTablas" style="width: 20%">
                <select name="codentidadsaludipss" id="codentidadsaludipss" style="width: 150px" tabindex="13">
                  <option id="codentidadsaludipss" value=""></option>
                  <sql:query var="r" sql="select codregimenes, codentidadsalud, nombre from entidadsalud a join empresa b on a.codempresa = b.codempresa" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                    <c:choose>
                      <c:when test='${fila.codentidadsalud == codentidadsaludipsf && fila.codregimenes == codregimenipsf}'>
                        <option value="${fila.codregimenes} ${fila.codentidadsalud}" selected="selected">${fila.nombre}</option>
                      </c:when>
                      <c:otherwise>
                        <option value="${fila.codregimenes} ${fila.codentidadsalud}">${fila.nombre}</option>
                      </c:otherwise>
                    </c:choose>
                  </jsp2:forEach>
                </select>
                </span></label></td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td colspan="6" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>Estado Funcionario</strong></td>
                <td><span class="sinBgDescTablas" style="width: 20%"><span class="sinBgDescTablas" style="width: 20%">
                  <select name="codestadofuncionario" id="codestadofuncionario" style="width: 150px" tabindex="15">
                    <option id="codestadofuncionario" value=""></option>
                    <sql:query var="r" sql="select codestadofuncionario, descripcion from estadofuncionario" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.codestadofuncionario == codestadofuncionario}'>
                          <option value="${fila.codestadofuncionario}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.codestadofuncionario}">${fila.descripcion}</option>
                        </c:otherwise>
                      </c:choose>
                    </jsp2:forEach>
                  </select>
                </span></span></td>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">Especialidad</strong></td>
                <td><span class="sinBgDescTablas" style="width: 20%">
                  <select name="codespecialidad" id="codespecialidad" style="width: 150px" tabindex="16">
                    <option id="codespecialidad" value=""></option>
                    <sql:query var="r" sql="select codespecialidad, descripcion from especialidad" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.codespecialidad == codespecialidad}'>
                          <option value="${fila.codespecialidad}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.codespecialidad}">${fila.descripcion}</option>
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
                <td class="bgDescTablas"><strong>Grupo Sanguineo</strong></td>
                <td><span class="sinBgDescTablas" style="width: 20%">
                  <select name="codgruposanguineo" id="codgruposanguineo" style="width: 150px" tabindex="17">
                    <option id="codgruposanguineo" value=""></option>
                    <sql:query var="r" sql="select codgruposanguineo, descripcion from gruposanguineo" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.codgruposanguineo == codgruposanguineo}'>
                          <option value="${fila.codgruposanguineo}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.codgruposanguineo}">${fila.descripcion}</option>
                        </c:otherwise>
                      </c:choose>
                    </jsp2:forEach>
                  </select>
                </span></td>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">Actividad Economica</strong></td>
                <td><span class="sinBgDescTablas" style="width: 20%">
                  <select name="codactividadeconomica" id="codactividadeconomica" style="width: 150px" tabindex="18">
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
                </span></td>
              </tr>
              <tr>
                <td colspan="6" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>Foto Documento</strong></td>
                <td><span class="sinBgDescTablas" style="width: 20%">
                  <input name="fotodocumentoidentidad" type="text" id="fotodocumentoidentidad" size="15"  value="${fotodocumentoidentidad}" readonly="readonly"/>
                  <a href="#" onClick="abrirCargaArchivo();"><img src="../images/Buscar16x16.gif" alt="Cargar Archivo" border="0" tabindex="4"/></a>
                  <c:if test='${fotodocumentoidentidad != null && fotodocumentoidentidad != ""}'><br>
                    <a href="../temp/${fotodocumentoidentidad}" target="_blank">Descargar ${fotodocumentoidentidad}</a> </c:if>
                </span></td>
                <td>&nbsp;</td>
                <td class="bgDescTablas">&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td colspan="6" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="codtipoidentidad" id="codtipoidentidad" value="" >
                  <input type="hidden" name="numidentfunc" id="numidentfunc" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="22"> -->
		  <label>&nbsp;</label>
                  <!--<input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="19"/>
                  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="20"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="21"/> -->
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
    configurar();
	
	function abrirCargaArchivo()
    {
        var url;
        url = "PopUpCargaArchivo.jsp?";
        url = url + "campo=fotodocumentoidentidad";
        
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
        llaves = 'codtipoidentidad='+document.getElementById('codtipoidentidads').value+',';
	llaves+= 'numidentfunc='+document.getElementById('numidentfuncs').value;
        validarLlave('actividadeconomica',llaves);
    } 
    
    //
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=funcionario&";
        url = url + "campos=codtipoidentidad,numidentfunc,codtipofuncionario,nombre,matriculaprofesional,codempresa,codcargo,codocupacion&";
        url = url + "campoLlave=codtipoidentidad,numidentfunc";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>