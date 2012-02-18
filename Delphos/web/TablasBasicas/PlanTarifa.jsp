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
<head>
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
        <script type="text/javascript" src="../js/pestanas/jquery-1.2.2.pack.js"></script>
        <script type="text/javascript" src="../js/pestanas/animatedcollapse.js"></script>
        <script type="text/javascript" src="../js/validaciones/validador.js"></script>
        <script type="text/javascript" src="../js/validaciones/validadorkp.js"></script>
        <script type="text/javascript" src="../js/validaciones/validadorcontrol.js"></script>
        <script type="text/javascript">
            
            //totalidad de elementos en el form
            var cajas = new Array('porcentaje','valoractividad','honorariomedico','honorarioanest','honorarioayudante','derechosala','valormasucu','valorperfusion');
            var combos =  new Array('codtipometodologias','codtipoplantarifas');
			
            //validar
            var arrayNonulos               	= null;
            var arrayNumerosEnteros        	= null;
            var arrayCombos               	= new Array('codtipometodologias','codtipoplantarifas');			
            var arrayCadenasANCod          	= null;
            var arrayCadenasA              	= null;
            var arrayComentarios           	= null;
            var arrayNumerosDoubles        	= new Array('valoractividad','honorariomedico','honorarioanest','honorarioayudante','derechosala','valormasucu','valorperfusion');
			
            var arrayPorcentajes        	= new Array('porcentaje');
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
            <c:if test='${param.codtipometodologia != null && param.codactividadsalud != null && param.anyo != null && param.mesinicial != null && param.codtipoplantarifa != null && param.codtipometodologia != "" && param.codactividadsalud != "" && param.anyo != "" && param.mesinicial != ""}'>
            <sql:query var="r" sql="SELECT * FROM plantarifa WHERE codtipometodologia=${param.codtipometodologia} AND codactividadsalud=${param.codactividadsalud} AND anyo=${param.anyo} AND mesinicial=${param.mesinicial} AND codtipoplantarifa='${param.codtipoplantarifa}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codtipometodologiaf" value="${fila.codtipometodologia}"/>
              <c:set var="codactividadsaludf" value="${fila.codactividadsalud}"/>
              <c:set var="anyof" value="${fila.anyo}"/>
              <c:set var="mesinicialf" value="${fila.mesinicial}"/>
              <c:set var="codtipoplantarifaf" value="${fila.codtipoplantarifa}"/>
              <c:set var="porcentaje" value="${fila.porcentaje}"/>  
              <c:set var="valoractividad" value="${fila.valoractividad}"/>  
              <c:set var="honorariomedico" value="${fila.honorariomedico}"/>  
              <c:set var="honorarioanest" value="${fila.honorarioanest}"/> 
              <c:set var="honorarioayudante" value="${fila.honorarioayudante}"/> 
              <c:set var="derechosala" value="${fila.derechosala}"/>       
              <c:set var="valormasucu" value="${fila.valormasucu}"/>  
              <c:set var="valorperfusion" value="${fila.valorperfusion}"/>      
            </jsp2:forEach>
                
                <table width="791" border="0" class="tablaContenido">
		<form action="PlanTarifa.jsp" method="post" name="formulario" id="formulario">
                  <span id="mensajeControlador">${msj}</span>
                  <tr>
                    <td colspan="6"><div align="center" class="titulo1">Plan Tarifa</div></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Tipo Metodolog&iacute;a</strong></td>
                    <td colspan="4" class="bgDescTablas"><label>
                      <select name="codtipometodologias" id="codtipometodologias" style="width: 150px" tabindex="1">
                        <option id="codtipometodologias" value=""></option>
                        <sql:query var="r" sql="select codtipometodologia, codactividadsalud, anyo, mesinicial from manualliquidacion" dataSource="jdbc/delphos" scope="page"/>
                          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                           <c:choose>
                             <c:when test='${fila.codtipometodologia == codtipometodologiaf && fila.codactividadsalud == codactividadsaludf && fila.anyo == anyof && fila.mesinicial == mesinicialf}'>
                               <option value="${fila.codtipometodologia} ${fila.codactividadsalud} ${fila.anyo} ${fila.mesinicial}" selected="selected">${fila.codtipometodologia}</option>
                             </c:when>
                            <c:otherwise>
                              <option value="${fila.codtipometodologia} ${fila.codactividadsalud} ${fila.anyo} ${fila.mesinicial}">${fila.codtipometodologia}</option>
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
                    <td width="27" class="bgDescTablas">&nbsp;</td>
                    <td width="121" class="bgDescTablas"><strong>Tipo Plan Tarifa</strong></td>
                    <td width="170" class="bgDescTablas"><label>
                    <select name="codtipoplantarifas" id="codtipoplantarifas" style="width: 150px" tabindex="2">
                      <option id="codtipoplantarifas" value=""></option>
                      <sql:query var="r" sql="select codtipoplantarifa, descripcion from tipoplantarifa" dataSource="jdbc/delphos" scope="page"/>
                      <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                        <c:choose>
                          <c:when test='${fila.codtipoplantarifa == codtipoplantarifaf}'>
                            <option value="${fila.codtipoplantarifa}" selected="selected">${fila.descripcion}</option>
                          </c:when>
                          <c:otherwise>
                            <option value="${fila.codtipoplantarifa}">${fila.descripcion}</option>
                          </c:otherwise>
                        </c:choose>
                      </jsp2:forEach>
                    </select>
                    </label></td>
                    <td width="23" class="bgDescTablas">&nbsp;</td>
                    <td width="113" class="bgDescTablas"><strong>Porcentaje</strong></td>
                    <td width="188" class="bgDescTablas"><label>
                      <input name="porcentaje" type="text" id="porcentaje" value="${porcentaje}" size="20" maxlength="8" onkeypress="javascript:return permite(event, 'numd')" tabindex="3"/>
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas"><strong class="titulo1">
                    <label></label>
                    <div align="center">Valores</div>
                    </strong></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">
                    <table width="617" border="0" align="center">
                      <tr class="bgDescTablas">
                        <td><div align="center"><strong>Honorarios</strong></div></td>
                        <td><div align="center"><strong>Anestesi&oacute;logo</strong></div></td>
                        <td><div align="center"><strong>Ayudant&iacute;a</strong></div></td>
                        <td><div align="center"><strong>Perfusi&oacute;n</strong></div></td>
                      </tr>
                      <tr class="sinBgDescTablas">
                        <td><div align="center">
                            <input name="honorariomedico" type="text" id="honorariomedico" value="${honorariomedico}" size="15" maxlength="15" onkeypress="javascript:return permite(event, 'numd')" tabindex="4"/>
                        </div></td>
                        <td><div align="center">
                            <input name="honorarioanest" type="text" id="honorarioanest" value="${honorarioanest}" size="15" maxlength="15" onkeypress="javascript:return permite(event, 'numd')" tabindex="5"/>
                        </div></td>
                        <td><div align="center">
                            <input name="honorarioayudante" type="text" id="honorarioayudante" value="${honorarioayudante}" size="15" maxlength="15" onkeypress="javascript:return permite(event, 'numd')" tabindex="6"/>
                        </div></td>
                        <td><div align="center">
                            <input name="valorperfusion" type="text" id="valorperfusion" value="${valorperfusion}" size="15" maxlength="15" onkeypress="javascript:return permite(event, 'numd')" tabindex="7"/>
                        </div></td>
                      </tr>
                    </table></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">
                    <center><table width="514" border="0">
                      <tr class="bgDescTablas">
                        <td width="165"><div align="center"><strong>Materiales</strong></div></td>
                        <td width="165"><div align="center"><strong>Sala</strong></div></td>
                        <td width="170"><div align="center"><strong>Actividad</strong></div></td>
                      </tr>
                      <tr class="sinBgDescTablas">
                        <td><div align="center">
                            <input name="valormasucu" type="text" id="valormasucu" value="${valormasucu}" size="15" maxlength="15" onkeypress="javascript:return permite(event, 'numd')" tabindex="8"/>
                        </div></td>
                        <td><div align="center">
                            <input name="derechosala" type="text" id="derechosala" value="${derechosala}" size="15" maxlength="15" onkeypress="javascript:return permite(event, 'numd')" tabindex="9"/>
                        </div></td>
                        <td><div align="center">
                            <input name="valoractividad" type="text" id="valoractividad" value="${valoractividad}" size="15" maxlength="15" onkeypress="javascript:return permite(event, 'numd')" tabindex="10"/>
                        </div></td>
                      </tr>
                    </table></center>
                    <div align="center"></div></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="codtipometodologia" id="codtipometodologia" value="" >
                  <input type="hidden" name="codactividadsalud" id="codactividadsalud" value="" >
                  <input type="hidden" name="anyo" id="anyo" value="" >
                  <input type="hidden" name="mesinicial" id="mesinicial" value="" >
                  <input type="hidden" name="codtipoplantarifa" id="codtipoplantarifa" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="14">-->
		  <label>&nbsp;</label>
                  <!--<input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="11"/>
                  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="12"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="13"/>-->
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
        var cad = document.getElementById('codtipometodologias').value;
        var cad2 = cad.split(" ");
        
        llaves = 'codtipometodologia='+cad2[0]+',';
	llaves+= 'codactividadsalud='+cad2[1]+',';
        llaves+= 'anyo='+cad2[2]+',';
        llaves+= 'mesinicial='+cad2[3]+',';
        llaves+= 'codtipoplantarifa='+document.getElementById('codtipoplantarifas').value;
        validarLlave('plantarifa',llaves);
    } 
    
    //
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=plantarifa&";
        url = url + "campos=codtipometodologia,codactividadsalud,anyo,mesinicial,codtipoplantarifa,porcentaje,valoractividad&";
        url = url + "campoLlave=codtipometodologia,codactividadsalud,anyo,mesinicial,codtipoplantarifa";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>