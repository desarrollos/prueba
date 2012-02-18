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
            Calendar.setup({inputField : "fechacumplim",ifFormat : "%d/%m/%Y",button : "botonFechacumplim"});
		}
			
			//totalidad de ealementos en el form
            var cajas = new Array('consecutivos','fechacumplim','actividad','porque','como','recurso');
            var combos = new Array('consintervencions','codcargo','nroliquidacion','codestcumplimiento');
                      
            //validar
            var arrayNonulos               = new Array('consecutivos');
            var arrayNumerosEnteros        = new Array('consecutivos');
            var arrayCombos                = new Array('consintervencions','codcargo','nroliquidacion','codestcumplimiento');
            var arrayCadenasANCod          = null;
            var arrayCadenasA              = null;
            var arrayComentarios           = new Array('actividad','porque','como','recurso');
            var arrayNumerosDoubles        = null;
            
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
            <c:if test='${param.codregimenes != null && param.codentidadsalud != null && param.codcontrato != null && param.consintervencion != null && param.consintervencion != "" && param.consecutivo != null && param.consecutivo != ""}'>
            <sql:query var="r" sql="SELECT * FROM planaccintervcto WHERE codregimenes='${param.codregimenes}' AND codentidadsalud='${param.codentidadsalud}' AND codcontrato='${param.codcontrato}' AND consintervencion=${param.consintervencion} AND consecutivo=${param.consecutivo}" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codregimenesf" value="${fila.codregimenes}"/>
              <c:set var="codentidadsaludf" value="${fila.codentidadsalud}"/>
              <c:set var="codcontratof" value="${fila.codcontrato}"/>
              <c:set var="consintervencionf" value="${fila.consintervencion}"/>
              <c:set var="consecutivof" value="${fila.consecutivo}"/>
              <c:set var="actividad" value="${fila.actividad}"/>              
              <c:set var="codcargo" value="${fila.codcargo}"/>
              <fmt:formatDate value="${fila.fechacumplim}" pattern="dd/MM/yyyy" var="fechacumplim"/>              
              <c:set var="porque" value="${fila.porque}"/>
              <c:set var="como" value="${fila.como}"/>
              <c:set var="recurso" value="${fila.recurso}"/>  
              <c:set var="codestcumplimiento" value="${fila.codestcumplimiento}"/>
              <c:set var="nroliquidacion" value="${fila.nroliquidacion}"/>
            </jsp2:forEach>
                
                <table width="761" border="0" class="tablaContenido">
                <span id="mensajeControlador">${msj}</span>
				<form action="PlanInterventoria.jsp" method="post" name="formulario">
                  <tr>
                    <td colspan="6"><div align="center" class="titulo1">Plan Interventor&iacute;a </div></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="25" class="bgDescTablas">&nbsp;</td>
                    <td width="119" class="bgDescTablas"><strong class="bgDescTablas">No. Intervenci&oacute;n</strong></td>
                    <td width="170" class="sinBgDescTablas">
                    <select name="consintervencions" id="consintervencions" style="width: 150px">
                      <option id="consintervencions" value=""></option>
                      <sql:query var="r" sql="select codcontrato, codregimenes, codentidadsalud, consecutivo from intervencioncto" dataSource="jdbc/delphos" scope="page"/>
                      <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                        <c:choose>
                          <c:when test='${fila.codregimenes == codregimenesf && fila.codentidadsalud == codentidadsaludf && fila.codcontrato == codcontratof && fila.consecutivo == consintervencionf}'>
                            <option value="${fila.codregimenes} ${fila.codentidadsalud} ${fila.codcontrato} ${fila.consecutivo}" selected="selected">${fila.consecutivo}</option>
                          </c:when>
                          <c:otherwise>
                            <option value="${fila.codregimenes} ${fila.codentidadsalud} ${fila.codcontrato} ${fila.consecutivo}">${fila.consecutivo}</option>
                          </c:otherwise>
                        </c:choose>
                      </jsp2:forEach>
                    </select></td>
                    <td width="13">&nbsp;</td>
                    <td width="123" class="bgDescTablas"><strong>Consecutivo Plan de Acci&oacute;n</strong></td>
                    <td width="192" class="sinBgDescTablas"><input name="consecutivos" type="text" id="consecutivos" value="${consecutivof}" size="20" maxlength="4" /></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Cargo Laboral</strong></td>
                    <td class="sinBgDescTablas">
                    <select name="codcargo" id="codcargo" style="width: 150px">
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
                    </select></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas"><p><strong>Nro. Liquidaci&oacute;n</strong></p></td>
                    <td class="sinBgDescTablas"><label></label>
                    <p>
                      <select name="nroliquidacion" id="nroliquidacion" style="width: 150px">
                        <option id="nroliquidacion" value=""></option>
                          <sql:query var="r" sql="select nroliquidacion from liquidacioncto" dataSource="jdbc/delphos" scope="page"/>
                        <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                           <c:choose>
                                <c:when test='${fila.nroliquidacion == nroliquidacion}'>
                                <option value="${fila.nroliquidacion}" selected="selected">${fila.nroliquidacion}</option>
                                </c:when>
                            <c:otherwise>
                                <option value="${fila.nroliquidacion}">${fila.nroliquidacion}</option>
                            </c:otherwise>
                           </c:choose>
                        </jsp2:forEach>
                      </select>
                    </p></td>
                  </tr>
                  <tr>
                    <td height="21" colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td height="27" class="bgDescTablas"><strong>Estado Cumplimiento</strong></td>
                    <td class="sinBgDescTablas"><label>
                    <select name="codestcumplimiento" id="codestcumplimiento" style="width: 150px">
                      <option id="codestcumplimiento" value=""></option>
                          <sql:query var="r" sql="select codestcumplimiento, descripcion from estadocumplimiento" dataSource="jdbc/delphos" scope="page"/>
                      <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                           <c:choose>
                                <c:when test='${fila.codestcumplimiento == codestcumplimiento}'>
                                <option value="${fila.codestcumplimiento}" selected="selected">${fila.descripcion}</option>
                                </c:when>
                            <c:otherwise>
                                <option value="${fila.codestcumplimiento}">${fila.descripcion}</option>
                            </c:otherwise>
                           </c:choose>
                      </jsp2:forEach>
                    </select>
                    </label></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas"><strong>Fecha Cumplimiento</strong></td>
                    <td class="sinBgDescTablas"><label>
                      <input name="fechacumplim" type="text" id="fechacumplim" value="${fechacumplim}" size="15" readonly="true" />
                      <input name="button" type="button" id="botonFechacumplim" value="..." />
</label></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Actividad</strong></td>
                    <td class="sinBgDescTablas"><label>
                    <textarea name="actividad" rows="5" id="actividad">${actividad}</textarea>
                    </label></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas"><strong>  Por Que</strong></td>
                    <td class="sinBgDescTablas"><label>
                      <textarea name="porque" rows="5" id="porque">${porque}</textarea>
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Como </strong></td>
                    <td class="sinBgDescTablas"><label>
                      <textarea name="como" rows="5" id="como">${como}</textarea>
                    </label></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas"><strong>Recurso</strong></td>
                    <td class="sinBgDescTablas"><label>
                      <textarea name="recurso" rows="5" id="recurso">${recurso}</textarea>
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
           <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="codregimenes" id="codregimenes" value="" >
                  <input type="hidden" name="codentidadsalud" id="codentidadsalud" value="" >
                  <input type="hidden" name="codcontrato" id="codcontrato" value="" >
                  <input type="hidden" name="consintervencion" id="consintervencion" value="" >
                  <input type="hidden" name="consecutivo" id="consecutivo" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="6"> -->
		  <label>&nbsp;</label>
                  <!--<input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="3" />
                  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="4"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="5"/> -->
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
        var cad = document.getElementById('consintervencions').value;
        var cad2 = cad.split(" ");
		
        llaves = 'codregimenes='+cad2[0]+',';
		llaves+= 'codentidadsalud='+cad2[1]+',';
		llaves+= 'codcontrato='+cad2[2]+',';
		llaves+= 'consintervencion='+cad2[3]+',';
		
		llaves+= 'consecutivo='+document.getElementById('consecutivos').value;
        validarLlave('planaccintervcto',llaves);
    } 
    
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=planaccintervcto&";
        url = url + "campos=codregimenes,codentidadsalud,codcontrato,consintervencion,consecutivo,codcargo,fechacumplim,codestcumplimiento&";
        url = url + "campoLlave=codregimenes,codentidadsalud,codcontrato,consintervencion,consecutivo";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>