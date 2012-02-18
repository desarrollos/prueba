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
                    
            //totalidad de elementos en el form
            var cajas = new Array('idregistros','anyo','totalconsulta','totalproceddiagnost','totalprocedquirurg','totalprocednoquirur','totalpromprev','totalestancia','totalhonorarios','totalderechosala','totalmaterinsumos','totalbancosangre','totalprotesortesis','totalmedicampos','totalmedicamnopos','totaltraslpaciente');
            var combos = new Array('idencabezados','mes');
                      
            //validar
            var arrayNonulos               = new Array('idregistros');
            var arrayNumerosEnteros        = new Array('idregistros','anyo');
            var arrayCombos                = new Array('idencabezados','mes');
            var arrayCadenasANCod          = null;
            var arrayCadenasA              = null;
            var arrayComentarios           = null;
            var arrayNumerosDoubles        = new Array('totalconsulta','totalproceddiagnost','totalprocedquirurg','totalprocednoquirur','totalpromprev','totalestancia','totalhonorarios','totalderechosala','totalmaterinsumos','totalbancosangre','totalprotesortesis','totalmedicampos','totalmedicamnopos','totaltraslpaciente');
            
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
            <c:if test='${param.idencabezado != null && param.idencabezado != "" && param.idregistro != null && param.idregistro != ""}'>
            <sql:query var="r" sql="SELECT * FROM archivovlrtotaleapb WHERE idencabezado=${param.idencabezado} AND idregistro=${param.idregistro}" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="idencabezadof" value="${fila.idencabezado}"/>
              <c:set var="idregistrof" value="${fila.idregistro}"/>
              <c:set var="anyo" value="${fila.anyo}"/>
              <c:set var="mes" value="${fila.mes}"/>
              <c:set var="totalconsulta" value="${fila.totalconsulta}"/>              
              <c:set var="totalproceddiagnost" value="${fila.totalproceddiagnost}"/>
              <c:set var="totalprocedquirurg" value="${fila.totalprocedquirurg}"/>
              <c:set var="totalprocednoquirur" value="${fila.totalprocednoquirur}"/>             
              <c:set var="totalpromprev" value="${fila.totalpromprev}"/>
              <c:set var="totalestancia" value="${fila.totalestancia}"/>
              <c:set var="totalhonorarios" value="${fila.totalhonorarios}"/>
              <c:set var="totalderechosala" value="${fila.totalderechosala}"/>
              <c:set var="totalmaterinsumos" value="${fila.totalmaterinsumos}"/>
              <c:set var="totalbancosangre" value="${fila.totalbancosangre}"/>
              <c:set var="totalprotesortesis" value="${fila.totalprotesortesis}"/>
              <c:set var="totalmedicampos" value="${fila.totalmedicampos}"/>
              <c:set var="totalmedicamnopos" value="${fila.totalmedicamnopos}"/>
              <c:set var="totaltraslpaciente" value="${fila.totaltraslpaciente}"/>
            </jsp2:forEach>
                
                <table width="791" border="0" class="tablaContenido">
                <span id="mensajeControlador">${msj}</span>
				<form action="ArchivoValoresTotales.jsp" method="post" name="formulario">
                  <tr>
                    <td colspan="6"><div align="center" class="titulo1">Archivo Valores Totales</div></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="16" class="bgDescTablas">&nbsp;</td>
                    <td width="142" class="bgDescTablas"><strong>Id. Encabezado</strong></td>
                    <td colspan="4" class="sinBgDescTablas"><label>
                      <select name="idencabezados" id="idencabezados" style="width: 150px">
                        <option id="idencabezados" value=""></option>
                        <sql:query var="r" sql="select idencabezado from encabezadoarchivo" dataSource="jdbc/delphos" scope="page"/>
                        <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                          <c:choose>
                            <c:when test='${fila.idencabezado == idencabezadof}'>
                              <option value="${fila.idencabezado}" selected="selected">${fila.idencabezado}</option>
                            </c:when>
                            <c:otherwise>
                              <option value="${fila.idencabezado}">${fila.idencabezado}</option>
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
                    <td class="bgDescTablas"><strong>Nro. Registro</strong></td>
                    <td colspan="4" class="bgDescTablas"><label><span class="sinBgDescTablas">
                      <input name="idregistros" type="text" id="idregistros" value="${idregistrof}" size="20" maxlength="10" />
                    </span></label></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Mes</strong></td>
                    <td class="bgDescTablas"><label>
                      <select name="mes" id="mes" style="width: 150px" tabindex="1">
                        <option id="mes" value=""></option>
                        <c:forEach begin="1" end="12" step="1" var="hour" varStatus="status">
                          <c:choose>
                            <c:when test="${(status.count) >= 1 && (status.count) <= 9}">
                              <c:choose>
                                <c:when test="${(status.count) == mes}">
                                  <option value="${mes}" selected>${mes}</option>
                                </c:when>
                                <c:otherwise>
                                  <option value="0${status.count}">0${status.count}</option>
                                </c:otherwise>
                              </c:choose>
                            </c:when>
                            <c:otherwise>
                              <c:choose>
                                <c:when test="${(status.count) == mes}">
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
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong><strong>A&ntilde;o</strong></strong></td>
                    <td class="bgDescTablas"><label>
                      <input name="anyo" type="text" id="anyo" value="${anyo}" size="20" maxlength="4" />
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="6" class="titulo1"><div align="center">Totales Pagados</div></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Consultas</strong></td>
                    <td width="153" class="sinBgDescTablas"><label>
                      <input name="totalconsulta" type="text" id="totalconsulta" value="${totalconsulta}" size="20" maxlength="15" />
                    </label></td>
                    <td width="23">&nbsp;</td>
                    <td width="150" class="bgDescTablas"><p><strong>Procedimientos Diagn&oacute;sticos</strong></p></td>
                    <td width="158" class="sinBgDescTablas">
                      <span class="bgDescTablas">                      </span> <input name="totalproceddiagnost" type="text" id="totalproceddiagnost" value="${totalproceddiagnost}" size="20" maxlength="15" /></td>
                  </tr>
                  <tr>
                    <td height="21" colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td height="27" class="bgDescTablas"><strong>Procedimientos Quir&uacute;rgicos</strong></td>
                    <td class="sinBgDescTablas"><label>
                    <input name="totalprocedquirurg" type="text" id="totalprocedquirurg" value="${totalprocedquirurg}" size="20" maxlength="15"/>
                    </label></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas"><strong>Procedimientos No Quir&uacute;rgicos</strong></td>
                    <td class="sinBgDescTablas"><label>
                      <input name="totalprocednoquirur" type="text" id="totalprocednoquirur" value="${totalprocednoquirur}" size="20" maxlength="15" />
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Promoci&oacute;n y Prevenci&oacute;n</strong></td>
                    <td><input name="totalpromprev" type="text" id="totalpromprev" value="${totalpromprev}" size="20" maxlength="15"/></td>
                    <td>&nbsp;</td>
                    <td><strong class="bgDescTablas">Estancia</strong></td>
                    <td><input name="totalestancia" type="text" id="totalestancia" value="${totalestancia}" size="20" maxlength="15" /></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Honorarios</strong></td>
                    <td><input name="totalhonorarios" type="text" id="totalhonorarios" value="${totalhonorarios}" size="20" maxlength="15" /></td>
                    <td>&nbsp;</td>
                    <td><strong class="bgDescTablas">Derechos Sala</strong></td>
                    <td><input name="totalderechosala" type="text" id="totalderechosala" value="${totalderechosala}" size="20" maxlength="15" /></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td><strong class="bgDescTablas">Materiales e Insumos</strong></td>
                    <td><input name="totalmaterinsumos" type="text" id="totalmaterinsumos" value="${totalmaterinsumos}" size="20" maxlength="15"  /></td>
                    <td>&nbsp;</td>
                    <td><strong class="bgDescTablas">Banco de Sangre</strong></td>
                    <td><input name="totalbancosangre" type="text" id="totalbancosangre" value="${totalbancosangre}" size="20" maxlength="15"  /></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td><strong class="bgDescTablas">Pr&oacute;tesis y Ortosis</strong></td>
                    <td><input name="totalprotesortesis" type="text" id="totalprotesortesis" value="${totalprotesortesis}" size="20" maxlength="15"  /></td>
                    <td>&nbsp;</td>
                    <td><strong class="bgDescTablas">Medicamento POS</strong></td>
                    <td><input name="totalmedicampos" type="text" id="totalmedicampos" value="${totalmedicampos}" size="20" maxlength="15"  /></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td><strong class="bgDescTablas">Medicamento No POS</strong></td>
                    <td><input name="totalmedicamnopos" type="text" id="totalmedicamnopos" value="${totalmedicamnopos}" size="20" maxlength="15"  /></td>
                    <td>&nbsp;</td>
                    <td><strong class="bgDescTablas">Traslado Paciente</strong></td>
                    <td><input name="totaltraslpaciente" type="text" id="totaltraslpaciente" value="${totaltraslpaciente}" size="20" maxlength="15"  /></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  
            <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="idencabezado" id="idencabezado" value="" >
                  <input type="hidden" name="idregistro" id="idregistro" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                 <!-- <input type="button" onClick="buscar();" value="Buscar" tabindex="6"> -->
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
        llaves = 'idencabezado='+document.getElementById('idencabezados').value+',';
		llaves += 'idregistro='+document.getElementById('idregistros').value;
        validarLlave('archivovlrtotaleapb',llaves);
    } 
    
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=archivovlrtotaleapb&";
        url = url + "campos=idencabezado,idregistro,anyo,mes,totalconsulta,totalproceddiagnost,totalprocedquirurg,totalprocednoquirur&";
        url = url + "campoLlave=idencabezado,idregistro";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>