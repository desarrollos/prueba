<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<%@ taglib prefix="jsp2" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%
clases.VerificarUsuarioSistema v;
v = new clases.VerificarUsuarioSistema(request,response);
%>

<html xmlns="http://www.w3.org/1999/xhtml">
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
            
            //totalidad de elementos en el form
            var cajas = new Array('anyo','porcanyo','porcevento','valortopeanyo','valortopeevento');
            var combos = new Array('codestrato','codestrato','codtipoconcvalor');
            
            //validar
            var arrayNonulos               	= null;
            var arrayNumerosEnteros        	= new Array('anyo');
            var arrayCombos               	= new Array('codregimen','codestrato','codtipoconcvalor');
            var arrayCadenasANCod          	= null;
            var arrayCadenasA              	= null;
            var arrayComentarios           	= null;
            var arrayNumerosDoubles        	= new Array('valortopeanyo','valortopeevento');
			
            var arrayPorcentajes        	= new Array('porcanyo','porcevento');
            var arrayDirecciones        	= null;
            var arrayCorreos                    = null;
            
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
<%-- Datos sesion --%>

<%-- Datos sesion --%>
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
            <sql:query var="r" sql="SELECT * FROM valormaxevento WHERE codregimen='${param.llave}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codregimen" value="${fila.codregimen}"/>
              <c:set var="codestrato" value="${fila.codestrato}"/>
              <c:set var="anyo" value="${fila.anyo}"/>
              <c:set var="codtipoconcvalor" value="${fila.codtipoconcvalor}"/>
              
              <c:set var="fechainicial" value="${fila.fechainicial}"/>
              <c:set var="porcanyo" value="${fila.porcanyo}"/>
              <c:set var="porcevento" value="${fila.porcevento}"/>
              <c:set var="valortopeanyo" value="${fila.valortopeanyo}"/>
              <c:set var="valortopeevento" value="${fila.valortopeevento}"/>
            </jsp2:forEach>

                
                <table width="779" border="0" class="tablaContenido">
		<form action="ValorMaxEvento.jsp" method="post" name="formulario">
                  <span id="mensajeControlador">${msj}</span>
                  <tr>
                    <td colspan="6"><div align="center" class="titulo1">Valor Maximo Por Evento</div></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="30" class="bgDescTablas">&nbsp;</td>
                    <td width="107" class="bgDescTablas"><strong>Regimen</strong></td>
                    <td colspan="4" class="sinBgDescTablas"><label>
                    <select name="codregimen" id="codregimen" style="width: 150px" tabindex="1">
                         <option id="codregimen" value=""></option>
                          <sql:query var="r" sql="select codregimen, descripcion from regimen" dataSource="jdbc/delphos" scope="page"/>
                          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                           <c:choose>
                                <c:when test='${fila.codregimen == codregimen}'>
                                <option value="${fila.codregimen}" selected="selected">${fila.descripcion}</option>
                                </c:when>
                            <c:otherwise>
                                <option value="${fila.codregimen}">${fila.descripcion}</option>
                            </c:otherwise>
                           </c:choose>
                         </jsp2:forEach>
                    </select>
                    </label>                      <label></label></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td><span class="bgDescTablas"><strong>Estrato</strong></span></td>
                    <td colspan="4"><span class="sinBgDescTablas">
                      <select name="codestrato" id="codestrato" style="width: 150px" tabindex="2">
                        <option id="codestrato" value=""></option>
                        <sql:query var="r" sql="select codestrato, descripcion from estratosocioeconomico" dataSource="jdbc/delphos" scope="page"/>
                        <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                          <c:choose>
                            <c:when test='${fila.codestrato == codestrato}'>
                              <option value="${fila.codestrato}" selected="selected">${fila.descripcion}</option>
                            </c:when>
                            <c:otherwise>
                              <option value="${fila.codestrato}">${fila.descripcion}</option>
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
                    <td><strong class="bgDescTablas">A&ntilde;o</strong>
                      <label></label></td>
                    <td width="181"><strong>
                      <input name="anyo" type="text" id="anyo" value="${anyo}" size="20" maxlength="4" tabindex="3"/>
                    </strong></td>
                    <td width="28">&nbsp;</td>
                    <td width="124"><strong class="bgDescTablas">Tipo Concepto Valor</strong></td>
                    <td width="206"><label>
                      <select name="codtipoconcvalor" id="codtipoconcvalor" style="width: 150px" tabindex="4">
                          <option id="codtipoconcvalor" value=""></option>
                          <sql:query var="r" sql="select codtipoconcvalor, fechainicial from detalleconcvalor" dataSource="jdbc/delphos" scope="page"/>
                          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                           <c:choose>
                                <c:when test='${fila.codtipoconcvalor == codtipoconcvalor && fila.fechainicial == fechainicial}'>
                                <option value="${fila.fechainicial} ${fila.codtipoconcvalor}" selected="selected">${fila.codtipoconcvalor}</option>
                                </c:when>
                            <c:otherwise>
                                <option value="${fila.fechainicial} ${fila.codtipoconcvalor}">${fila.codtipoconcvalor}</option>
                            </c:otherwise>
                           </c:choose>
                         </jsp2:forEach>
                    </select>
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Porcentaje A&ntilde;o</strong></td>
                    <td class="sinBgDescTablas"><label>
                      <input name="porcanyo" type="text" id="porcanyo" value="${porcanyo}" size="20" maxlength="8" tabindex="5"/>
                    </label></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas"><p><strong>Valor Tope A&ntilde;o</strong></p></td>
                    <td class="sinBgDescTablas"><label></label>
                      <label></label>
                    <p>
                      <label>
                      <input name="valortopeanyo" type="text" id="valortopeanyo" value="${valortopeanyo}" size="20" maxlength="15" tabindex="6"/>
                      </label>
                    </p></td>
                  </tr>
                  <tr>
                    <td height="21" colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Porcentaje Evento</strong></td>
                    <td class="sinBgDescTablas"><label>
                      <input name="porcevento" type="text" id="porcevento" value="${porcevento}" size="20" maxlength="8" tabindex="7"/>
                    </label></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas"><strong>Valor Tope Evento</strong></td>
                    <td class="sinBgDescTablas"><label>
                      <input name="valortopeevento" type="text" id="valortopeevento" value="${valortopeevento}" size="20" maxlength="15" tabindex="8"/>
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="llave" id="llave" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="12">-->
		  <label>&nbsp;</label>
                  <!--<input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="9"/>
                  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="10"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="11"/>-->
				  <jsp:include page="../BarraNavegacion.jsp?tabBuscar=17&tabGuardar=14&tabEditar=15&tabEliminar=16" />
               </div>
            </td>
           </tr>
		</form>
                </table>
                <p>&nbsp;</p>
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
        llaves = 'codregimen='+document.getElementById('codregimen').value+',';
        llaves+= 'codestrato='+document.getElementById('codestrato').value+',';
        llaves+= 'anyo='+document.getElementById('anyo').value;
        validarLlave('valormaxevento',llaves);
    } 
    
    //
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=valormaxevento&";
        url = url + "campos=codregimen,codestrato,anyo,codtipoconcvalor,porcanyo,porcevento,valortopeanyo,valortopeevento&";
        url = url + "campoLlave=codregimen";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }    
</script>
</body>
</html>