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
            var cajas = new Array('porcconcanyo','porcconcevento','valortopeanyo','valortopeevento');
            var combos = new Array('codcontratos','codestratos','codtipoconcvalor');
                      
            //validar
            var arrayNonulos               = null;
            var arrayNumerosEnteros        = null;
            var arrayCombos                = new Array('codcontratos','codestratos','codtipoconcvalor');
            var arrayCadenasANCod          = null;
            var arrayCadenasA              = null;
            var arrayComentarios           = null;
            var arrayNumerosDoubles        = new Array('valortopeanyo','valortopeevento');
			
			var arrayPorcentajes           = new Array('porcconcanyo','porcconcevento');
            var arrayDirecciones           = null;
            var arrayCorreos               = null;
            
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
            <c:if test='${param.codregimenes != null && param.codentidadsalud != null && param.codcontrato != null && param.codestrato != null && param.codestrato != ""}'>
            <sql:query var="r" sql="SELECT * FROM pagocompartidocto WHERE codregimenes='${param.codregimenes}' AND codentidadsalud='${param.codentidadsalud}' AND codcontrato='${param.codcontrato}' AND codestrato=${param.codestrato}" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codregimenesf" value="${fila.codregimenes}"/>
              <c:set var="codentidadsaludf" value="${fila.codentidadsalud}"/>
              <c:set var="codcontratof" value="${fila.codcontrato}"/>
              <c:set var="codestratof" value="${fila.codestrato}"/>
              <c:set var="codtipoconcvalor" value="${fila.codtipoconcvalor}"/>              
              <c:set var="porcconcanyo" value="${fila.porcconcanyo}"/>
              <c:set var="porcconcevento" value="${fila.porcconcevento}"/>
              <c:set var="valortopeanyo" value="${fila.valortopeanyo}"/>
              <c:set var="valortopeevento" value="${fila.valortopeevento}"/>
            </jsp2:forEach>
                
                <table width="741" border="0" class="tablaContenido">
                <span id="mensajeControlador">${msj}</span>
				<form action="PagoCompartido.jsp" method="post" name="formulario">
                  <tr>
                    <td colspan="6"><div align="center" class="titulo1">Pago Compartido </div></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="27">&nbsp;</td>
                    <td width="116"><strong class="bgDescTablas">Contrato</strong></td>
                  <td colspan="4" class="sinBgDescTablas"><label>
                  <select name="codcontratos" id="codcontratos" style="width: 150px">
                    <option id="codcontratos" value=""></option>
                    <sql:query var="r" sql="select codcontrato, codregimenes, codentidadsalud from contrato" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.codregimenes == codregimenesf && fila.codentidadsalud == codentidadsaludf && fila.codcontrato == codcontratof}'>
                          <option value="${fila.codregimenes} ${fila.codentidadsalud} ${fila.codcontrato}" selected="selected">${fila.codcontrato}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.codregimenes} ${fila.codentidadsalud} ${fila.codcontrato}">${fila.codcontrato}</option>
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
                    <td height="27" class="bgDescTablas"><strong>Estrato</strong></td>
                    <td width="160" class="sinBgDescTablas"><label>
                      <select name="codestratos" id="codestratos" style="width: 150px">
                        <option id="codestratos" value=""></option>
                          <sql:query var="r" sql="select codestrato, descripcion from estratosocioeconomico" dataSource="jdbc/delphos" scope="page"/>
                        <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                           <c:choose>
                                <c:when test='${fila.codestrato == codestratof}'>
                                <option value="${fila.codestrato}" selected="selected">${fila.descripcion}</option>
                                </c:when>
                            <c:otherwise>
                                <option value="${fila.codestrato}">${fila.descripcion}</option>
                            </c:otherwise>
                           </c:choose>
                        </jsp2:forEach>
                    </select>
                    </label></td>
                    <td width="17">&nbsp;</td>
                    <td width="141" class="bgDescTablas"><strong>Tipo Concepto Valor </strong></td>
                    <td width="181" class="sinBgDescTablas"><label>
                      <select name="codtipoconcvalor" id="codtipoconcvalor" style="width: 150px">
                        <option id="codtipoconcvalor" value=""></option>
                              <sql:query var="r" sql="select codtipoconcvalor, descripcion from tipoconceptovalor" dataSource="jdbc/delphos" scope="page"/>
                        <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                               <c:choose>
                                    <c:when test='${fila.codtipoconcvalor == codtipoconcvalor}'>
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
                    <td class="bgDescTablas"><strong>Porcentaje Por A&ntilde;o</strong></td>
                    <td class="sinBgDescTablas"><label>
                      <input name="porcconcanyo" type="text" id="porcconcanyo" value="${porcconcanyo}" size="20" maxlength="8" />
                    </label></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas"><strong>  Porcentaje Por Evento </strong></td>
                    <td class="sinBgDescTablas"><label>
                      <input name="porcconcevento" type="text" id="porcconcevento" value="${porcconcevento}" size="20" maxlength="8" />
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Valor Tope Por A&ntilde;o</strong></td>
                    <td class="sinBgDescTablas"><label>
                      <input name="valortopeanyo" type="text" id="valortopeanyo" value="${valortopeanyo}" size="20" maxlength="8" />
                    </label></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas"><strong>Valor Tope Por Evento</strong></td>
                    <td class="sinBgDescTablas"><label>
                      <input name="valortopeevento" type="text" id="valortopeevento" value="${valortopeevento}" size="20" maxlength="8" />
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
                  <input type="hidden" name="codestrato" id="codestrato" value="" >
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
        <jsp:include page="../footer.jsp" />  </td>
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
        var cad = document.getElementById('codcontratos').value;
        var cad2 = cad.split(" ");
		
        llaves = 'codregimenes='+cad2[0]+',';
		llaves+= 'codentidadsalud='+cad2[1]+',';
		llaves+= 'codcontrato='+cad2[2]+',';
		
		llaves+= 'codestrato='+document.getElementById('codestratos').value;
        validarLlave('pagocompartidocto',llaves);
    }
    
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=pagocompartidocto&";
        url = url + "campos=codregimenes,codentidadsalud,codcontrato,codestrato,codtipoconcvalor,porcconcanyo,porcconcevento,valortopeanyo&";
        url = url + "campoLlave=codregimenes,codentidadsalud,codcontrato,codestrato";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>