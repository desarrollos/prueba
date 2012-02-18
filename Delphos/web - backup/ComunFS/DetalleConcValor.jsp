<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<%@ taglib prefix="jsp2" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
                Calendar.setup({inputField : "fechainicials",ifFormat : "%d/%m/%Y",button : "botonFechainicial", daFormat : "%d/%m/%Y"});
		Calendar.setup({inputField : "fechafinal",ifFormat : "%d/%m/%Y",button : "botonFechafinal", daFormat : "%d/%m/%Y"});
            }
            
            //totalidad de elementos en el form
            var cajas = new Array('fechainicials','fechafinal','valor','observacion');
            var combos = new Array('codtipoconcvalors') ;
            
            //validar
            var arrayNonulos               	= new Array('fechainicials','fechafinal','valor');
            var arrayNumerosEnteros        	= null;
            var arrayCombos               	= new Array('codtipoconcvalors');            
            var arrayCadenasANCod          	= null;
            var arrayCadenasA              	= null;
            var arrayComentarios           	= new Array('observacion');
            var arrayNumerosDoubles        	= new Array('valor');
                        
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
            <c:if test='${param.codtipoconcvalor != null && param.fechainicial != null && param.fechainicial != ""}'>
            <sql:query var="r" sql="SELECT * FROM detalleconcvalor WHERE codtipoconcvalor='${param.codtipoconcvalor}' AND fechainicial='${param.fechainicial}'" dataSource="jdbc/delphos" scope="page"/>
            
        </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codtipoconcvalorf" value="${fila.codtipoconcvalor}"/>
              <fmt:formatDate value="${fila.fechainicial}" pattern="dd/MM/yyyy" dateStyle="short" var="fechainicialf"/>
              <fmt:formatDate value="${fila.fechafinal}" pattern="dd/MM/yyyy" dateStyle="short" var="fechafinal"/>
              <c:set var="valor" value="${fila.valor}"/>
              <c:set var="observacion" value="${fila.observacion}"/>     
            </jsp2:forEach>
            <table width="811" border="0" class="tablaContenido">
            <form name="formulario" id="formulario" method="post" action="DetalleConcValor.jsp">
              <span id="mensajeControlador">${msj}</span>
              <tr>
                <td colspan="6"><div align="center" class="titulo1">Detalle Concepto Valor</div></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td width="28" class="bgDescTablas">&nbsp;</td>
                <td width="142" class="bgDescTablas"><strong>Tipo Concepto Valor</strong></td>
                <td colspan="4"><label>
                  <select name="codtipoconcvalors" id="codtipoconcvalors" style="width: 150px" tabindex="1">
                  <option id="codtipoconcvalors" value=""></option>
                  <sql:query var="r" sql="select codtipoconcvalor, descripcion from tipoconceptovalor" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                   <c:choose>
                        <c:when test='${fila.codtipoconcvalor == codtipoconcvalorf}'>
                        <option value="${fila.codtipoconcvalor}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                    <c:otherwise>
                        <option value="${fila.codtipoconcvalor}">${fila.descripcion}</option>
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
                <td class="bgDescTablas"><strong>Fecha Inicial</strong></td>
                <td width="170"><span class="sinBgDescTablas" style="width: 20%">
                  <input type="text" size="15" name="fechainicials" id="fechainicials" readonly="readonly" value="${fechainicialf}"/>
                  <span class="sinBgDescTablas" style="width: 20%">
                  <input name="botonFechainicial" type="button" id="botonFechainicial" value="..." tabindex="2"/>
                  </span></span></td>
                <td width="10">&nbsp;</td>
                <td width="125"><strong class="bgDescTablas">Fecha Final</strong></td>
                <td width="167"><label><span class="sinBgDescTablas" style="width: 20%">
                <input type="text" size="15" name="fechafinal" id="fechafinal" readonly="readonly" value="${fechafinal}"/>
                <span class="sinBgDescTablas" style="width: 20%">
                <input name="botonFechainicaplic2" type="button" id="botonFechafinal" value="..." tabindex="3"/>
                </span></span></label></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>Valor</strong></td>
                <td colspan="4"><label>
                <input name="valor" type="text" id="valor" value="${valor}" size="20" maxlength="15" onKeyPress="javascript:return permite(event, 'numd')" tabindex="4">
                </label></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td colspan="6"><p align="center"><strong class="bgDescTablas">Observaciones</strong></p>
                <p align="center"><strong>
                  <textarea name="observacion" id="observacion" cols="75" rows="3" onKeyPress="javascript:return permite(event, 'com')" tabindex="5">${observacion}</textarea>
                  <label></label>
                </strong></p></td>
              </tr>
              <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="codtipoconcvalor" id="codtipoconcvalor" value="" >
                  <input type="hidden" name="fechainicial" id="fechainicial" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="9"> -->
		  <label>&nbsp;</label>
                  <!--<input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="6"/>
                  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="7"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="8"/> -->
                  <jsp:include page="../BarraNavegacion.jsp?tabBuscar=17&tabGuardar=14&tabEditar=15&tabEliminar=16" />
               </div>
            </td>
           </tr>
		    </form>
          </table>
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
        llaves = 'codtipoconcvalor='+document.getElementById('codtipoconcvalors').value+',';
        var fini = document.getElementById('fechainicials').value;
        var f = fini.substring(6,10)+"-"+fini.substring(3,5)+"-"+fini.substring(0,2);
        llaves+= 'fechainicial='+f;       
        validarLlave('detalleconcvalor',llaves);
    } 
    
    //
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=detalleconcvalor&";
        url = url + "campos=codtipoconcvalor,fechainicial,fechafinal,valor,observacion&";
        url = url + "campoLlave=codtipoconcvalor,fechainicial";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>