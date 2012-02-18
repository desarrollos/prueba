<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<%@ taglib prefix="jsp2" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>

<%
clases.VerificarUsuarioSistema v;
v = new clases.VerificarUsuarioSistema(request,response);
%>

<html>
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
                Calendar.setup({inputField : "fechainicaplic",ifFormat : "%d/%m/%Y",button : "botonFechainicaplic", daFormat : "%d/%m/%Y"});
	    }            
            
            //totalidad de elementos en el form
            var cajas = new Array('anyoinicials','anyofinal','valoranyo','valormes','valordia');
            var combos = new Array('codregimens','mesinicials','codgrupopoblacion','mesfinal','codnormas');
            
            //validar
            var arrayNonulos               	= new Array('anyoinicials');
            var arrayNumerosEnteros        	= new Array('anyoinicials','anyofinal');
            var arrayCombos               	= new Array('codregimens','mesinicials','codgrupopoblacion','mesfinal','codnormas');
            var arrayCadenasANCod          	= null;
            var arrayCadenasA              	= null;
            var arrayComentarios           	= null;
            var arrayNumerosDoubles        	= new Array('valoranyo','valormes','valordia');
			
            var arrayPorcentajes        	= new Array('porcincremrelant');
            var arrayDirecciones        	= null;
            var arrayCorreos                    = null;
            
	</script></head>
<body bgcolor="#FFFFFF" onLoad="borrarMensaje(combos[0]);">
<center>
<table id="Table_01" width="906" style="height: 780; border: 0px" cellpadding="0" cellspacing="0">
<tr>
    <td colspan="3">
        <jsp:include page="../header.jsp" />
    </td>
</tr>
<%-- Datos sesion --%>

<%-- Datos sesion --%>
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
            <c:if test='${param.codregimen != null && param.codtipocubrimupc != null && param.anyoinicial != null && param.mesinicial != null && param.anyoinicial != "" && param.mesinicial != ""}'>
            <sql:query var="r" sql="SELECT * FROM upcs WHERE codregimen='${param.codregimen}' AND codtipocubrimupc='${param.codtipocubrimupc}' AND anyoinicial=${param.anyoinicial} AND mesinicial=${param.mesinicial}" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codregimenf" value="${fila.codregimen}"/>
              <c:set var="codtipocubrimupcf" value="${fila.codtipocubrimupc}"/>
              <c:set var="anyoinicialf" value="${fila.anyoinicial}"/>
              <c:set var="mesinicialf" value="${fila.mesinicial}"/>
              <c:set var="codgrupopoblacion" value="${fila.codgrupopoblacion}"/>
              <c:set var="anyofinal" value="${fila.anyofinal}"/>
              <c:set var="mesfinal" value="${fila.mesfinal}"/>
              <c:set var="valoranyo" value="${fila.valoranyo}"/>
              <c:set var="valormes" value="${fila.valormes}"/>
              <c:set var="valordia" value="${fila.valordia}"/>
              <c:set var="porcincremrelant" value="${fila.porcincremrelant}"/>
              <fmt:formatDate value="${fila.fechainicaplic}" pattern="dd/MM/yyyy" var="fechainicaplic"/>
              <c:set var="codtiponorma" value="${fila.codtiponorma}"/>
              <c:set var="codnorma" value="${fila.codnorma}"/>
              <c:set var="fechanorma" value="${fila.fechanorma}"/> 

            
            </jsp2:forEach>
            <table width="811" border="0" class="tablaContenido">
            <form name="formulario" id="formulario" method="post" action="Upcs.jsp">
              <span id="mensajeControlador">${msj}</span>
              <tr>
                <td colspan="6"><div align="center" class="titulo1">Upc</div></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td width="30" class="bgDescTablas">&nbsp;</td>
                <td width="133" class="bgDescTablas"><strong>Regimen</strong></td>
                <td colspan="4"><label>
                  <select name="codregimens" id="codregimens" style="width: 150px" tabindex="1">
                  <option id="codregimens" value=""></option>
                  <sql:query var="r" sql="select codregimen, codtipocubrimupc, descripcion from tipocubrimientoupc" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                   <c:choose>
                        <c:when test='${fila.codregimen == codregimenf && fila.codtipocubrimupc == codtipocubrimupcf}'>
                        <option value="${fila.codregimen} ${fila.codtipocubrimupc}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                    <c:otherwise>
                        <option value="${fila.codregimen} ${fila.codtipocubrimupc}">${fila.descripcion}</option>
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
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>Mes Inicial</strong></td>
                <td width="161">
                    <select name="mesinicials" id="mesinicials" style="width: 150px" tabindex="2">
                  <option id="mesinicials" value=""></option>
                        <c:forEach begin="1" end="12" step="1" var="mes" varStatus="status">
                              <c:choose>                                  
                                  <c:when test="${(status.count) >= 1 && (status.count) <= 9}">
                                    <c:choose>                                        
                                        <c:when test="${(status.count) == mesinicialf}">
                                            <option value="${mesinicialf}" selected>${mesinicialf}</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="0${status.count}">0${status.count}</option>
                                        </c:otherwise>
                                    </c:choose>
                                    
                                </c:when>
                                <c:otherwise>
                                    <c:choose>
                                        <c:when test="${(status.count) == mesinicialf}">
                                            <option value="${(status.count)}" selected>${(status.count)}</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="${status.count}">${status.count}</option>
                                        </c:otherwise>
                                    </c:choose>
                                </c:otherwise>
                              </c:choose>
                            </c:forEach>
                </select></td>
                <td width="27">&nbsp;</td>
                <td width="134"><strong class="bgDescTablas">A&ntilde;o Inicial</strong></td>
                <td width="164"><label>
                  <input name="anyoinicials" type="text" id="anyoinicials" value="${anyoinicialf}" size="20" maxlength="4" tabindex="3">
                </label></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>Grupo Poblaci&oacute;n</strong></td>
                <td colspan="4"><label>
                  <select name="codgrupopoblacion" id="codgrupopoblacion" style="width: 150px" tabindex="4">
                  <option id="codgrupopoblacion" value=""></option>
                  <sql:query var="r" sql="select codgrupopoblacion, descripcion from grupopoblacion" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                   <c:choose>
                        <c:when test='${fila.codgrupopoblacion == codgrupopoblacion}'>
                        <option value="${fila.codgrupopoblacion}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                    <c:otherwise>
                        <option value="${fila.codgrupopoblacion}">${fila.descripcion}</option>
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
                <td><span class="bgDescTablas" style="width: 7%"><strong>Mes Final</strong></span></td>
                <td><label>
                <select name="mesfinal" id="mesfinal" style="width: 150px" tabindex="5">
                  <option id="mesfinal" value=""></option>
                        <c:forEach begin="1" end="12" step="1" var="mes" varStatus="status">
                              <c:choose>                                  
                                  <c:when test="${(status.count) >= 1 && (status.count) <= 9}">
                                    <c:choose>                                        
                                        <c:when test="${(status.count) == mesfinal}">
                                            <option value="${mesfinal}" selected>${mesfinal}</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="0${status.count}">0${status.count}</option>
                                        </c:otherwise>
                                    </c:choose>
                                    
                                </c:when>
                                <c:otherwise>
                                    <c:choose>
                                        <c:when test="${(status.count) == mesfinal}">
                                            <option value="${(status.count)}" selected>${(status.count)}</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="${status.count}">${status.count}</option>
                                        </c:otherwise>
                                    </c:choose>
                                </c:otherwise>
                              </c:choose>
                            </c:forEach>
                </select>
                </label></td>
                <td>&nbsp;</td>
                <td><span class="bgDescTablas"><strong>A&ntilde;o Final</strong></span></td>
                <td><span class="sinBgDescTablas">
                  <label>                  </label>
                </span>
                  <label>
                  <input name="anyofinal" type="text" id="anyofinal" value="${anyofinal}" size="20" maxlength="4" tabindex="6">
                  </label></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">Valor A&ntilde;o</strong></td>
                <td><label>
                  <input name="valoranyo" type="text" id="valoranyo" value="${valoranyo}" size="20" maxlength="15" tabindex="7">
                </label></td>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">Valor Mes</strong></td>
                <td><label>
                  <input name="valormes" type="text" id="valormes" value="${valormes}" size="20" maxlength="15" tabindex="8">
                </label></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">Valor D&iacute;a</strong></td>
                <td colspan="4"><label>
                  <input name="valordia" type="text" id="valordia" value="${valordia}" size="20" maxlength="15" tabindex="9">
                </label></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>Porcentaje Incremento</strong></td>
                <td><label>
                  <input name="porcincremrelant" type="text" id="porcincremrelant" value="${porcincremrelant}" size="20" maxlength="8" tabindex="10">
                </label></td>
                <td>&nbsp;</td>
                <td class="bgDescTablas"><strong>Fecha Inicial Aplicaci&oacute;n</strong></td>
                <td><span class="sinBgDescTablas" style="width: 20%">
                  <input name="fechainicaplic" type="text" id="fechainicaplic" value="${fechainicaplic}" size="15" maxlength="10" readonly="readonly"/>
                  <span class="sinBgDescTablas" style="width: 20%"><span class="sinBgDescTablas" style="width: 20%">
                  <input name="button2" type="button" id="botonFechainicaplic" value="..." tabindex="11"/>
                </span></span>                </span></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><span class="bgDescTablas" style="width: 8%"><strong>Norma</strong></span></td>
                <td colspan="4"><label>
                  <select name="codnormas" id="codnormas" style="width: 150px" tabindex="12">
                  <option id="codnormas" value=""></option>
                  <sql:query var="r" sql="select codtiponorma, codnorma, fechanorma, referencia from normas" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                   <c:choose>
                        <c:when test='${fila.codtiponorma == codtiponorma && fila.codnorma == codnorma && fila.fechanorma == fechanorma}'>
                        <option value="${fila.codtiponorma} ${fila.fechanorma} ${fila.codnorma}" selected="selected">${fila.referencia}</option>
                        </c:when>
                    <c:otherwise>
                        <option value="${fila.codtiponorma} ${fila.fechanorma} ${fila.codnorma}">${fila.referencia}</option>
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
                <td colspan="6"><div align="center">
                  <input type="hidden" name="codregimen" id="codregimen" value="" >
                  <input type="hidden" name="codtipocubrimupc" id="codtipocubrimupc" value="" >
                  <input type="hidden" name="anyoinicial" id="anyoinicial" value="" >
                  <input type="hidden" name="mesinicial" id="mesinicial" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="16">-->
		  <label>&nbsp;</label>
                  <!--<input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="13"/>
                  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="14"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="15"/>-->
				  <jsp:include page="../BarraNavegacion.jsp?tabBuscar=17&tabGuardar=14&tabEditar=15&tabEliminar=16" />
               </div>            </td>
           </tr>
		    </form>
          </table>
        </center>
        
    </td>
</tr>

<tr>
    <td>
        <jsp:include page="../footer.jsp" />
	</td>
</tr>
</table>
</center>
<!-- End ImageReady Slices -->
<script>
    configurar();
    
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
        var cad = document.getElementById('codregimens').value;
        var cad2 = cad.split(" ");
    
        llaves = 'codregimen='+cad2[0]+',';
        llaves+= 'codtipocubrimupc='+cad2[1]+',';
        llaves+= 'anyoinicial='+document.getElementById('anyoinicials').value+',';
        llaves+= 'mesinicial='+document.getElementById('mesinicials').value;
        validarLlave('upcs',llaves);
    } 
    
    //
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=upcs&";
        url = url + "campos=codregimen,codtipocubrimupc,anyoinicial,mesinicial,anyofinal,mesfinal,valoranyo,valormes,valordia&";
        url = url + "campoLlave=codregimen,codtipocubrimupc,anyoinicial,mesinicial";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>