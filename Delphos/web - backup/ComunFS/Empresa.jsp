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
            
            //totalidad de elementos en el form
            var cajas = new Array('codempresas','digitoverificacion','nombreempresa','sigla','telefono','fax','lineagratuita','direccion','gerente','email','paginaweb','empcodigodane');
            var combos = new Array('codtipoidentidads','codbarrio','codactividadeconomica','codsectorentidad','codtipoaportante','codtipocontribuyente','codclasepersona');
			
            var arrayNonulos               	= new Array('codempresas');
            var arrayNumerosEnteros        	= null;
            var arrayCombos               	= new Array('codtipoidentidads','codbarrio','codactividadeconomica','codsectorentidad','codtipoaportante','codtipocontribuyente','codclasepersona');			
            var arrayCadenasANCod          	= new Array('codempresas','digitoverificacion','telefono','fax','lineagratuita','direccion','paginaweb','empcodigodane');
            var arrayCadenasA              	= new Array('nombreempresa','sigla','gerente');
            var arrayComentarios           	= null;
            var arrayNumerosDoubles        	= null;
			
            var arrayPorcentajes        	= null;
            var arrayDirecciones        	= null;
            var arrayCorreos                    = new Array('email');

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
            <c:if test="${param.codtipoidentidad != null && param.codempresa != null}">
            <sql:query var="r" sql="SELECT * FROM empresa WHERE codtipoidentidad='${param.codtipoidentidad}' AND codempresa='${param.codempresa}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codtipoidentidadf" value="${fila.codtipoidentidad}"/>
              <c:set var="codempresaf" value="${fila.codempresa}"/>
              <c:set var="digitoverificacion" value="${fila.digitoverificacion}"/>
              <c:set var="nombreempresa" value="${fila.nombre}"/>             
              <c:set var="sigla" value="${fila.sigla}"/>
              <c:set var="telefono" value="${fila.telefono}"/>
              <c:set var="fax" value="${fila.fax}"/>              
              <c:set var="lineagratuita" value="${fila.lineagratuita}"/>              
              <c:set var="codbarrio" value="${fila.codbarrio}"/>
              <c:set var="direccion" value="${fila.direccion}"/>
              <c:set var="gerente" value="${fila.gerente}"/>
              <c:set var="codactividadeconomica" value="${fila.codactividadeconomica}"/>
              <c:set var="codsectorentidad" value="${fila.codsectorentidad}"/>
              <c:set var="codtipoaportante" value="${fila.codtipoaportante}"/>             
              <c:set var="email" value="${fila.email}"/>
              <c:set var="paginaweb" value="${fila.paginaweb}"/>
              <c:set var="codtipocontribuyente" value="${fila.codtipocontribuyente}"/>
              <c:set var="codclasepersona" value="${fila.codclasepersona}"/>
              <c:set var="empresasistema" value="${fila.empresasistema}"/>
              <c:set var="empcodigodane" value="${fila.empcodigodane}"/>
            </jsp2:forEach>
            <form name="formulario" id="formulario" method="post" action="Empresa.jsp">
            <table width="811" border="0" class="tablaContenido">
              <span id="mensajeControlador">${msj}</span>
              <tr>
                <td colspan="6"><div align="center" class="titulo1">Empresa</div></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td width="25">&nbsp;</td>
                <td><span class="bgDescTablas"><strong>Tipo Identificaci&oacute;n</strong></span></td>
                <td><label>
               <select name="codtipoidentidads" id="codtipoidentidads" tabindex="1">
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
                </select>
                </label></td>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">C&oacute;digo Empresa</strong></td>
                <td><label>
                  <input name="codempresas" type="text" id="codempresas" value="${codempresaf}" size="20" maxlength="18" onKeyPress="javascript:return permite(event, 'num_car_cod')" tabindex="2">
                </label></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td colspan="6"><p align="center"><strong class="bgDescTablas">Nombre</strong></p>
                  <p align="center"><strong>
                  <label>
                  <input name="nombreempresa" type="text" id="nombreempresa" value="${nombreempresa}" size="75" maxlength="60" onKeyPress="javascript:return permite(event, 'carac')" tabindex="3">
                  </label>
                </strong></p></td>
              </tr>
              <tr>
                <td colspan="6"><p align="center"><strong class="bgDescTablas">Sigla</strong></p>
                  <p align="center"><strong>
                  <label>
                  <input name="sigla" type="text" id="sigla" value="${sigla}" size="75" maxlength="40" onKeyPress="javascript:return permite(event, 'carac')" tabindex="4">
                  </label>
                </strong></p></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td width="25">&nbsp;</td>
                <td width="150"><strong class="bgDescTablas">D&iacute;gito Verificaci&oacute;n</strong></td>
                <td width="160"><label>
                  <input name="digitoverificacion" type="text" id="digitoverificacion" value="${digitoverificacion}" size="20" maxlength="1" onKeyPress="javascript:return permite(event, 'num_car_cod')" tabindex="5">
                </label></td>
                <td width="12">&nbsp;</td>
                <td width="128" class="bgDescTablas"><strong>Telefono</strong></td>
                <td width="167"><label>
                  <input name="telefono" type="text" id="telefono" value="${telefono}" size="20" maxlength="30" onKeyPress="javascript:return permite(event, 'num_car_cod')" tabindex="6">
                </label></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><span class="bgDescTablas" style="width: 7%"><strong>Fax</strong></span></td>
                <td><label>
                  <input name="fax" type="text" id="fax" value="${fax}" size="20" maxlength="30" onKeyPress="javascript:return permite(event, 'num_car_cod')" tabindex="7">
                </label></td>
                <td>&nbsp;</td>
                <td><span class="bgDescTablas"><strong>Linea Gratuita</strong></span></td>
                <td><span class="sinBgDescTablas">
                </span>
                  <label>
                  <input name="lineagratuita" type="text" id="lineagratuita" value="${lineagratuita}" size="20" maxlength="20" onKeyPress="javascript:return permite(event, 'num_car_cod')" tabindex="8">
                  </label></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>Barrio</strong></td>
                <td><span class="sinBgDescTablas" style="width: 20%">
                  <select name="codbarrio" id="codbarrio" style="width: 150px" tabindex="9">
                    <option id="codbarrio" value=""></option>
                    <sql:query var="r" sql="select coddepartamento, codmunicipio, codsubgrupo, codbarrio, nombre from barrio" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.codbarrio == codbarrio}'>
                          <option value="${fila.coddepartamento} ${fila.codmunicipio} ${fila.codsubgrupo} ${fila.codbarrio}" selected="selected">${fila.nombre}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.coddepartamento} ${fila.codmunicipio} ${fila.codsubgrupo} ${fila.codbarrio}">${fila.nombre}</option>
                        </c:otherwise>
                      </c:choose>
                    </jsp2:forEach>
                  </select>
                </span></td>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">Direcci&oacute;n</strong></td>
                <td><label>
                  <input name="direccion" type="text" id="direccion" value="${direccion}" size="20" maxlength="100" onKeyPress="javascript:return permite(event, 'dir')"tabindex="10">
                </label></td>
              </tr>
              <tr>
                <td colspan="6" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong class="bgDescTablas">Actividad Economica</strong></td>
                <td><label><span class="sinBgDescTablas" style="width: 20%">
                  <select name="codactividadeconomica" id="codactividadeconomica" style="width: 150px" tabindex="11">
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
                </span></label></td>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas"><strong>Gerente</strong></strong></td>
                <td><label>
                  <input name="gerente" type="text" id="gerente" value="${gerente}" size="20" maxlength="60" onKeyPress="javascript:return permite(event, 'carac')" tabindex="12">
                </label></td>
              </tr>
              <tr>
                <td colspan="6" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>Sector Entidad</strong></td>
                <td><label><span class="sinBgDescTablas" style="width: 20%">
                  <select name="codsectorentidad" id="codsectorentidad" style="width: 150px" tabindex="13">
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
                </span></label></td>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">Tipo Aportante</strong></td>
                <td class="bgDescTablas"><span class="sinBgDescTablas" style="width: 20%">
                  <select name="codtipoaportante" id="codtipoaportante" style="width: 150px" tabindex="14">
                    <option id="codtipoaportante" value=""></option>
                    <sql:query var="r" sql="select codtipoaportante, descripcion from tipoaportante" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.codtipoaportante == codtipoaportante}'>
                          <option value="${fila.codtipoaportante}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.codtipoaportante}">${fila.descripcion}</option>
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
                <td class="bgDescTablas"><strong>E-mail</strong></td>
                <td class="bgDescTablas"><label>
                  <input name="email" type="text" id="email" value="${email}" size="20" maxlength="60" onKeyPress="javascript:return permite(event, 'correo')" tabindex="15">
                </label></td>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">Pagina Web</strong></td>
                <td><label>
                  <input name="paginaweb" type="text" id="paginaweb" value="${paginaweb}" size="20" maxlength="60" tabindex="16">
                </label></td>
              </tr>
              <tr>
                <td colspan="6" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>Tipo Contribuyente</strong></td>
                <td class="bgDescTablas"><label><span class="sinBgDescTablas" style="width: 20%">
                  <select name="codtipocontribuyente" id="codtipocontribuyente" style="width: 150px" tabindex="17">
                    <option id="codtipocontribuyente" value=""></option>
                    <sql:query var="r" sql="select codtipocontribuyente, descripcion from tipocontribuyente" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.codtipocontribuyente == codtipocontribuyente}'>
                          <option value="${fila.codtipocontribuyente}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.codtipocontribuyente}">${fila.descripcion}</option>
                        </c:otherwise>
                      </c:choose>
                    </jsp2:forEach>
                  </select>
                </span></label></td>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">Clase Persona</strong></td>
                <td class="bgDescTablas"><span class="sinBgDescTablas" style="width: 20%">
                  <select name="codclasepersona" id="codclasepersona" style="width: 150px" tabindex="18">
                    <option id="codclasepersona" value=""></option>
                    <sql:query var="r" sql="select codclasepersona, descripcion from clasepersona" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.codclasepersona == codclasepersona}'>
                          <option value="${fila.codclasepersona}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.codclasepersona}">${fila.descripcion}</option>
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
                <td class="bgDescTablas"><strong>Esta instalado el sistema</strong></td>
                <td class="bgDescTablas"><c:choose>
                            <c:when test = '${empresasistema == "S"}'>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="empresasistema" value="S" id="empresasistema_0" checked="true" tabindex="19"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="empresasistema" value="N" id="empresasistema_1" tabindex="19"/>
                                    </span>                                </label>
                            </c:when>
                            <c:otherwise>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="empresasistema" value="S" id="empresasistema_0" tabindex="19"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="empresasistema" value="N" id="empresasistema_1" checked="true" tabindex="19"/>
                                    </span>                                </label>
                            </c:otherwise>
                </c:choose></td>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">C&oacute;digo DANE Empresa</strong></td>
        <td class="bgDescTablas"><label>
          <input name="empcodigodane" type="text" id="empcodigodane" value="${empcodigodane}" size="20" maxlength="18" onKeyPress="javascript:return permite(event, 'num_car_cod')" tabindex="20">
        </label></td>
              </tr>
              <tr>
                <td colspan="6" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="codtipoidentidad" id="codtipoidentidad" value="" >
                  <input type="hidden" name="codempresa" id="codempresa" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="24"> -->
		  <label>&nbsp;</label>
                  <!--<input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="21"/>
                  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="22"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="23"/> -->
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
        llaves = 'codtipoidentidad='+document.getElementById('codtipoidentidads').value+',';
	llaves+= 'codempresa='+document.getElementById('codempresas').value;
        validarLlave('empresa',llaves);
    } 
    
    //
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=empresa&";
        url = url + "campos=codtipoidentidad,codempresa,digitoverificacion,nombre,sigla,telefono,fax,lineagratuita&";
        url = url + "campoLlave=codtipoidentidad,codempresa";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>