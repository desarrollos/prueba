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
		Calendar.setup({inputField : "subsfechinic",ifFormat : "%d/%m/%Y",button : "botonSubsfechinic"});
		Calendar.setup({inputField : "subsfechfina",ifFormat : "%d/%m/%Y",button : "botonSubsfechfina"});
	    }
			
            //totalidad de elementos en el form
            var cajas = new Array('subscodigo','subsfechinic','subsfechfina','subsvalobase','subsdescripc','subsobservac');
            var combos = new Array('subtipcodigo','clabencodigo','grugracodigo','codnorma');
			
            var arrayNonulos               	= new Array('subscodigo','subsvalobase','subsfechinic','subsfechfina');
            var arrayNumerosEnteros        	= null;
            var arrayCombos               	= new Array('subtipcodigo','clabencodigo','grugracodigo','codnorma');
            var arrayCadenasANCod          	= new Array('subscodigo');
            var arrayCadenasA              	= null;
            var arrayComentarios           	= new Array('subsdescripc','subsobservac');
            var arrayNumerosDoubles        	= new Array('subsvalobase');
</script>
        <style type="text/css">
<!--
.style1 {font-weight: bold}
-->
        </style>
</head>
<body bgcolor="#FFFFFF" onLoad="borrarMensaje(cajas[0]);">
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
            <c:if test="${param.llave != null}">
            <sql:query var="r" sql="SELECT * FROM subsidio WHERE subscodigo='${param.llave}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="subscodigo" value="${fila.subscodigo}"/>
              <c:set var="subsdescripc" value="${fila.subsdescripc}"/>
              <fmt:formatDate value="${fila.subsfechinic}" pattern="dd/MM/yyyy" var="subsfechinic"/>
              <fmt:formatDate value="${fila.subsfechfina}" pattern="dd/MM/yyyy" var="subsfechfina"/>
              <c:set var="subtipcodigo" value="${fila.subtipcodigo}"/>
              <c:set var="clabencodigo" value="${fila.clabencodigo}"/>
              <c:set var="grugracodigo" value="${fila.grugracodigo}"/>
              <c:set var="subsvalobase" value="${fila.subsvalobase}"/>              
              <c:set var="codtiponorma" value="${fila.codtiponorma}"/>
              <c:set var="codnorma" value="${fila.codnorma}"/>
              <c:set var="fechanorma" value="${fila.fechanorma}"/>
              <c:set var="subsobservac" value="${fila.subsobservac}"/>
            </jsp2:forEach>
                
 			<form name="formulario" method="post" action="Subsidios.jsp">           
            <table width="700" border="0" class="tablaContenido">
                <span id="mensajeControlador">${msj}</span>
              <tr>
                <td colspan="6"><div align="center"><span class="titulo1">Subsidios</span></div></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td width="32">&nbsp;</td>
                <td width="128"><span class="bgDescTablas" style="width: 20%"><strong>C&oacute;digo</strong></span></td>
                <td colspan="4"><span class="sinBgDescTablas" style="width: 20%">
                  <input name="subscodigo" type="text" id="subscodigo" value="${subscodigo}" size="20" maxlength="5" onkeypress="javascript:return permite(event, 'num_car_cod')"/>
                </span></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><span class="bgDescTablas" style="width: 20%"><strong>Fecha Inicio</strong></span></td>
                <td width="162"><span class="sinBgDescTablas" style="width: 20%">
                  <input name="subsfechinic" type="text" id="subsfechinic" value="${subsfechinic}" size="15" readonly="readonly" />
                  <span class="sinBgDescTablas" style="width: 20%">
                  <input name="button" type="button" id="botonSubsfechinic" value="..." />
                </span>                </span></td>
                <td width="20">&nbsp;</td>
                <td width="95"><span class="bgDescTablas" style="width: 20%"><strong>Fecha Fin</strong></span></td>
                <td width="205"><span class="sinBgDescTablas" style="width: 20%">
                  <input name="subsfechfina" type="text" id="subsfechfina" value="${subsfechfina}" size="15" readonly="readonly" />
                  <span class="sinBgDescTablas" style="width: 20%">
                  <input name="button2" type="button" id="botonSubsfechfina" value="..." />
                </span></span></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><span class="bgDescTablas" style="width: 20%"><strong>Tipo Subsidio</strong></span></td>
                <td><span class="sinBgDescTablas" style="width: 20%">
                  <select name="subtipcodigo" id="subtipcodigo" style="width: 150px">
                    <option id="subtipcodigo" value=""></option>
                  <sql:query var="r" sql="select subtipcodigo, subtipdescri from tiposubsidio" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                   <c:choose>
                        <c:when test='${fila.subtipcodigo == subtipcodigo}'>
                        <option value="${fila.subtipcodigo}" selected="selected">${fila.subtipdescri}</option>
                        </c:when>
                    <c:otherwise>
                        <option value="${fila.subtipcodigo}">${fila.subtipdescri}</option>
                    </c:otherwise>
                   </c:choose>
                 </jsp2:forEach>
                  </select>
                </span></td>
                <td>&nbsp;</td>
                <td><span class="bgDescTablas" style="width: 20%"><strong>Clase<br />
                Beneficiario</strong></span></td>
                <td><span class="sinBgDescTablas" style="width: 20%">
                  <select name="clabencodigo" id="clabencodigo" style="width: 150px">
                   <option id="clabencodigo" value=""></option>
                  <sql:query var="r" sql="select clabencodigo, clabendescri from clasebeneficiario" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                   <c:choose>
                        <c:when test='${fila.clabencodigo == clabencodigo}'>
                        <option value="${fila.clabencodigo}" selected="selected">${fila.clabendescri}</option>
                        </c:when>
                    <c:otherwise>
                        <option value="${fila.clabencodigo}">${fila.clabendescri}</option>
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
                <td>&nbsp;</td>
                <td><span class="bgDescTablas" style="width: 20%"><strong>Grupo Escolaridad</strong></span></td>
                <td><span class="sinBgDescTablas" style="width: 20%">
                  <select name="grugracodigo" id="grugracodigo" style="width: 150px">
                   <option id="grugracodigo" value=""></option>
                  <sql:query var="r" sql="select grugracodigo, grugradescri from escgrupogrado" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                   <c:choose>
                        <c:when test='${fila.grugracodigo == grugracodigo}'>
                        <option value="${fila.grugracodigo}" selected="selected">${fila.grugradescri}</option>
                        </c:when>
                    <c:otherwise>
                        <option value="${fila.grugracodigo}">${fila.grugradescri}</option>
                    </c:otherwise>
                   </c:choose>
                 </jsp2:forEach>
                  </select>
                </span></td>
                <td>&nbsp;</td>
                <td><span class="bgDescTablas" style="width: 20%"><strong>Valor Base</strong></span></td>
                <td><span class="sinBgDescTablas" style="width: 20%">
                  <input name="subsvalobase" type="text" id="subsvalobase" value="${subsvalobase}" size="20" maxlength="15" onkeypress="javascript:return permite(event, 'numd')"/>
                </span></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><span class="bgDescTablas" style="width: 20%"><strong>Norma</strong></span></td>
                <td colspan="4"><span class="sinBgDescTablas" style="width: 60%">
                  <select name="codnorma" id="codnorma" onchange="codtiponorma.value = this.value" style="width: 150px">
                   <option id="codnorma" value=""></option>
                  <sql:query var="r" sql="select codtiponorma, codnorma, referencia, fechanorma from normas" dataSource="jdbc/delphos" scope="page"/>
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
                </span></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td colspan="6"><p align="center" class="bgDescTablas"><strong>Descripci&oacute;n</strong></p>
                <p align="center" class="style1"><span class="sinBgDescTablas" style="width: 60%; height: 85px;">
                  <input name="subsdescripc" type="text" id="subsdescripc" value="${subsdescripc}" size="75" maxlength="45" onkeypress="javascript:return permite(event, 'com')"/>
                </span></p></td>
              </tr>
              <tr>
                <td colspan="6"><p align="center"><strong><span class="bgDescTablas" style="width: 20%; height: 85px;"><strong>Observaciones</strong></span></strong></p>
      <p align="center"><span class="sinBgDescTablas" style="width: 60%; height: 85px;">
                    <textarea name="subsobservac" cols="75" rows="3" id="subsobservac" onkeypress="javascript:return permite(event, 'com')">${subsobservac}</textarea>
                  </span></p></td>
              </tr>
              <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="llave" id="llave" value="" >
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
        llaves = 'subscodigo='+document.getElementById('subscodigo').value;
        validarLlave('subsidio',llaves);
    }
    
    configurar();
    
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=subsidio&";
        url = url + "campos=subscodigo,subsdescripc,subsfechinic,subsfechfina,subtipcodigo,clabencodigo,grugracodigo,subsvalobase&";
        url = url + "campoLlave=subscodigo";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>