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
            Calendar.setup({inputField : "fechanacim",ifFormat : "%d/%m/%Y",button : "botonFechanacim"});
		}
            
            //totalidad de elementos en el form
            var cajas = new Array('identbenefs','fechanacim','codigbenef','numceresco','numcuebanc','observacion');
            var combos = new Array ('codunifamis','codtipoidentidads','codtipoparentesco','codempresa','escgracodigo','codentidadsalud','codbanco','codiestben');
            
            //validar
            var arrayNonulos               	= new Array ('identbenefs');
            var arrayNumerosEnteros        	= null;
            var arrayCombos               	= new Array ('codunifamis','codtipoidentidads');
            var arrayCadenasANCod          	= new Array ('identbenefs','codigbenef','numceresco','numcuebanc');
            var arrayCadenasA              	= null;            
            var arrayComentarios           	= new Array ('observacion');
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
            <c:if test="${param.codunifami != null && param.codtipoidentidad != null && param.identbenef != null}">
            <sql:query var="r" sql="SELECT * FROM beneficiario WHERE codunifami='${param.codunifami}' AND codtipoidentidad='${param.codtipoidentidad}' AND identbenef='${param.identbenef}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codunifamif" value="${fila.codunifami}"/>
              <c:set var="codtipoidentidadf" value="${fila.codtipoidentidad}"/>
              <c:set var="identbeneff" value="${fila.identbenef}"/>
              <fmt:formatDate value="${fila.fechanacim}" pattern="dd/MM/yyyy" var="fechanacim"/>
              <c:set var="codigbenef" value="${fila.codigbenef}"/>             
              <c:set var="codtipoparentesco" value="${fila.codtipoparentesco}"/>
              <c:set var="codtipoidenemp" value="${fila.codtipoidenemp}"/>
              <c:set var="codempresa" value="${fila.codempresa}"/>              
              <c:set var="numceresco" value="${fila.numceresco}"/>              
              <c:set var="escgracodigo" value="${fila.escgracodigo}"/>
              <c:set var="codregimenes" value="${fila.codregimenes}"/>
              <c:set var="codentidadsalud" value="${fila.codentidadsalud}"/>
              <c:set var="numcuebanc" value="${fila.numcuebanc}"/>
              <c:set var="codbanco" value="${fila.codbanco}"/>
              <c:set var="vivecontit" value="${fila.vivecontit}"/>             
              <c:set var="permitehombre" value="${fila.permitehombre}"/>
              <c:set var="codiestben" value="${fila.codiestben}"/>
              <c:set var="observacion" value="${fila.observacion}"/>

            </jsp2:forEach>
            <form name="formulario" id="formulario" method="post" action="Beneficiario.jsp">
            <table width="811" border="0" class="tablaContenido">
              <span id="mensajeControlador">${msj}</span>
              <tr>
                <td colspan="6"><div align="center" class="titulo1">Beneficiario</div></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td width="25">&nbsp;</td>
                <td><span class="bgDescTablas"><strong>C&oacute;digo Unico Familia</strong></span></td>
                <td><select name="codunifamis" id="codunifamis" style="width: 150px" tabindex="3">
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
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">Tipo Identificaci&oacute;n</strong></td>
                <td><label>
                <select name="codtipoidentidads" id="codtipoidentidads" style="width: 150px" tabindex="4">
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
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td width="25">&nbsp;</td>
                <td width="150"><span class="bgDescTablas"><strong>No. Identificaci&oacute;n</strong></span></td>
                <td width="160"><label>
                  <input name="identbenefs" type="text" id="identbenefs" value="${identbeneff}" size="20" maxlength="18">
                </label></td>
                <td width="12">&nbsp;</td>
                <td width="128" class="bgDescTablas"><strong>Fecha Nacimiento</strong></td>
                <td width="167"><span class="sinBgDescTablas"><span class="bgDescTablas">
                  <input name="fechanacim" type="text" id="fechanacim" value="${fechanacim}" size="15" readonly="readonly" />
                </span><span class="bgDescTablas">
                <input name="botonFechanacim" type="button" id="botonFechanacim" value="..." />
                </span></span></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><span class="bgDescTablas" style="width: 7%"><strong>C&oacute;digo Beneficiario</strong></span></td>
                <td><label>
                  <input name="codigbenef" type="text" id="codigbenef" value="${codigbenef}" size="20" maxlength="18">
                </label></td>
                <td>&nbsp;</td>
                <td><span class="bgDescTablas"><strong>Tipo Parentesco</strong></span></td>
                <td><span class="sinBgDescTablas">
                  <label>                  </label>
                </span>
                  <label><span class="sinBgDescTablas" style="width: 20%">
                  <select name="codtipoparentesco" id="codtipoparentesco" style="width: 150px" tabindex="6">
                    <option id="codtipoparentesco" value=""></option>
                    <sql:query var="r" sql="select codtipoparentesco, descripcion from tipoparentesco" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.codtipoparentesco == codtipoparentesco}'>
                          <option value="${fila.codtipoparentesco}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.codtipoparentesco}">${fila.descripcion}</option>
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
                <td><span class="bgDescTablas"><strong>Empresa</strong></span></td>
                <td><span class="sinBgDescTablas" style="width: 20%">
                  <select name="codempresa" id="codempresa" style="width: 150px" tabindex="7">
                    <option id="codempresa" value=""></option>
                    <sql:query var="r" sql="select codtipoidentidad, codempresa, nombre from empresa" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.codtipoidentidad == codtipoidenemp && fila.codempresa == codempresa}'>
                          <option value="${fila.codtipoidentidad} ${fila.codempresa}" selected="selected">${fila.nombre}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.codtipoidentidad} ${fila.codempresa}">${fila.nombre}</option>
                        </c:otherwise>
                      </c:choose>
                    </jsp2:forEach>
                  </select>
                </span></td>
                <td>&nbsp;</td>
                <td class="bgDescTablas"><strong>No. Certificado Escolar Inicial</strong></td>
                <td><label>
                  <input name="numceresco" type="text" id="numceresco" value="${numceresco}" size="20" maxlength="18">
                </label></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>Grado Escolaridad Inicial</strong></td>
                <td><span class="sinBgDescTablas" style="width: 20%"><span class="sinBgDescTablas" style="width: 20%">
                  <select name="escgracodigo" id="escgracodigo" style="width: 150px" tabindex="9">
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
                  </select>
                </span></span></td>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">IPS Asignada</strong></td>
                <td><span class="sinBgDescTablas" style="width: 20%"><span class="sinBgDescTablas" style="width: 20%">
                <select name="codentidadsalud" id="codentidadsalud" style="width: 150px" tabindex="10">
                  <option id="codentidadsalud" value=""></option>
                  <sql:query var="r" sql="select codregimenes, codentidadsalud, nombre from entidadsalud a join empresa b on a.codempresa = b.codempresa" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                    <c:choose>
                      <c:when test='${fila.codregimenes == codregimenes && fila.codentidadsalud == codentidadsalud}'>
                        <option value="${fila.codregimenes} ${fila.codentidadsalud}" selected="selected">${fila.nombre}</option>
                      </c:when>
                      <c:otherwise>
                        <option value="${fila.codregimenes} ${fila.codentidadsalud}">${fila.nombre}</option>
                      </c:otherwise>
                    </c:choose>
                  </jsp2:forEach>
                </select>
                </span></span></td>
              </tr>
              <tr>
                <td colspan="6" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>No. Cuenta Bancaria</strong></td>
                <td><label>
                  <input name="numcuebanc" type="text" id="numcuebanc" value="${numcuebanc}" size="20" maxlength="20">
                </label></td>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">Banco</strong></td>
                <td><label><span class="sinBgDescTablas" style="width: 20%">
                <select name="codbanco" id="codbanco" style="width: 150px" tabindex="10">
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
                </select>
                </span></label></td>
              </tr>
              <tr>
                <td colspan="6" class="bgDescTablas">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>Estado Beneficiario</strong></td>
                <td><label><span class="sinBgDescTablas" style="width: 20%">
                <select name="codiestben" id="codiestben" style="width: 150px" tabindex="9">
                  <option id="codiestben" value=""></option>
                  <sql:query var="r" sql="select codiestben, descestben from estadobeneficiario" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                    <c:choose>
                      <c:when test='${fila.codiestben == codiestben}'>
                        <option value="${fila.codiestben}" selected="selected">${fila.descestben}</option>
                      </c:when>
                      <c:otherwise>
                        <option value="${fila.codiestben}">${fila.descestben}</option>
                      </c:otherwise>
                    </c:choose>
                  </jsp2:forEach>
                </select>
                </span></label></td>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">Vive con el titular</strong></td>
                <td class="bgDescTablas"><label><c:choose>
                            <c:when test = '${vivecontit == "S"}'>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="vivecontit" value="S" id="vivecontit_0" checked="true" tabindex="14"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="vivecontit" value="N" id="vivecontit_1" tabindex="14"/>
                                    </span>                                </label>
                            </c:when>
                            <c:otherwise>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="vivecontit" value="S" id="vivecontit_0" tabindex="14"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="vivecontit" value="N" id="vivecontit_1" checked="true" tabindex="14"/>
                                    </span>                                </label>
                            </c:otherwise>
                </c:choose></label></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td colspan="6"><p align="center"><strong class="bgDescTablas">Observaciones</strong></p>
                  <p align="center">
                    <label>
                    <textarea name="observacion" cols="75" rows="3" id="observacion">${observacion}</textarea>
                    </label>
                  </p></td>
              </tr>
              <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="codunifami" id="codunifami" value="" >
                  <input type="hidden" name="codtipoidentidad" id="codtipoidentidad" value="" >
                  <input type="hidden" name="identbenef" id="identbenef" value="" >
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
		llaves+= 'identbenef='+document.getElementById('identbenefs').value;
        validarLlave('beneficiario',llaves);
    } 
    
    //
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=beneficiario&";
        url = url + "campos=codunifami,codtipoidentidad,identbenef,fechanacim,codigbenef,codtipoparentesco,codtipoidenemp,codempresa&";
        url = url + "campoLlave=codunifami,codtipoidentidad,identbenef";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>