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
            var cajas = new Array('observacion');
            var combos = new Array('codcontratos','numidentfuncs','codtipofuncionario','codempresa','codcargo','aplicaa');
                      
            //validar
            var arrayNonulos               = null;
            var arrayNumerosEnteros        = null;
            var arrayCombos                = new Array('codcontratos','numidentfuncs','codtipofuncionario','codempresa','codcargo','aplicaa');
            var arrayCadenasANCod          = null;
            var arrayCadenasA              = null;
            var arrayComentarios           = new Array('observacion');
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
            <c:if test="${param.codtipoactacontrato != null && param.codregimenes != null && param.codentidadsalud != null && param.codcontrato != null && param.numeroacta != null && param.codtipoidentidad != null && param.numidentfunc != null}">
            <sql:query var="r" sql="SELECT * FROM funcionarioactacto WHERE codtipoactacontrato='${param.codtipoactacontrato}' AND codregimenes='${param.codregimenes}' AND codentidadsalud='${param.codentidadsalud}' AND codcontrato='${param.codcontrato}' AND numeroacta='${param.numeroacta}' AND codtipoidentidad='${param.codtipoidentidad}' AND numidentfunc='${param.numidentfunc}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codtipoactacontratof" value="${fila.codtipoactacontrato}"/>
              <c:set var="codregimenesf" value="${fila.codregimenes}"/>
              <c:set var="codentidadsaludf" value="${fila.codentidadsalud}"/>
              <c:set var="codcontratof" value="${fila.codcontrato}"/>
              <c:set var="numeroactaf" value="${fila.numeroacta}"/>              
              <c:set var="codtipoidentidadf" value="${fila.codtipoidentidad}"/>
              <c:set var="numidentfuncf" value="${fila.numidentfunc}"/>
              <c:set var="codtipofuncionario" value="${fila.codtipofuncionario}"/>
              <c:set var="codempresa" value="${fila.codempresa}"/>
              <c:set var="codcargo" value="${fila.codcargo}"/>
              <c:set var="aplicaa" value="${fila.aplicaa}"/>
              <c:set var="observacion" value="${fila.observacion}"/>
            </jsp2:forEach>
                
                <table width="741" border="0" class="tablaContenido">
                <span id="mensajeControlador">${msj}</span>
				<form action="FuncionariosActas.jsp" method="post" name="formulario">
                  <tr>
                    <td colspan="6"><div align="center" class="titulo1">Funcionarios Actas </div></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="30" class="bgDescTablas">&nbsp;</td>
                    <td width="116" class="bgDescTablas"><strong class="bgDescTablas"> Acta Contrato</strong></td>
                    <td colspan="4" class="sinBgDescTablas">
                    <select name="codcontratos" id="codcontratos" style="width: 150px">
                      <option id="codcontratos" value=""></option>
                      <sql:query var="r" sql="select codtipoactacontrato, codcontrato, codregimenes, codentidadsalud, numeroacta from actacontrato" dataSource="jdbc/delphos" scope="page"/>
                      <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                        <c:choose>
                          <c:when test='${fila.codtipoactacontrato == codtipoactacontratof && fila.codregimenes == codregimenesf && fila.codentidadsalud == codentidadsaludf && fila.codcontrato == codcontratof && fila.numeroacta == numeroactaf}'>
                            <option value="${fila.codtipoactacontrato} ${fila.codregimenes} ${fila.codentidadsalud} ${fila.codcontrato} ${fila.codregimenes}" selected="selected">${fila.numeroacta}</option>
                          </c:when>
                          <c:otherwise>
                            <option value="${fila.codtipoactacontrato} ${fila.codregimenes} ${fila.codentidadsalud} ${fila.codcontrato} ${fila.codregimenes}">${fila.numeroacta}</option>
                          </c:otherwise>
                        </c:choose>
                      </jsp2:forEach>
                    </select></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Funcionario</strong></td>
                    <td width="170" class="sinBgDescTablas">
                    <select name="numidentfuncs" id="numidentfuncs" style="width: 150px">
                      <option id="numidentfuncs" value=""></option>
                      <sql:query var="r" sql="select codtipoidentidad, numidentfunc, nombre from funcionario" dataSource="jdbc/delphos" scope="page"/>
                      <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                        <c:choose>
                          <c:when test='${fila.codtipoidentidad == codtipoidentidadf && fila.numidentfunc == numidentfuncf}'>
                            <option value="${fila.codtipoidentidad} ${fila.numidentfunc}" selected="selected">${fila.nombre}</option>
                          </c:when>
                          <c:otherwise>
                            <option value="${fila.codtipoidentidad} ${fila.numidentfunc}">${fila.nombre}</option>
                          </c:otherwise>
                        </c:choose>
                      </jsp2:forEach>
                    </select></td>
                    <td width="33">&nbsp;</td>
                    <td width="115" class="bgDescTablas"><strong>Tipo Funcionario</strong></td>
                    <td width="178" class="sinBgDescTablas"><label>
                      <select name="codtipofuncionario" id="codtipofuncionario" style="width: 150px">
                        <option id="codtipofuncionario" value=""></option>
                        <sql:query var="r" sql="select codtipofuncionario, descripcion from tipofuncionario" dataSource="jdbc/delphos" scope="page"/>
                        <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                          <c:choose>
                            <c:when test='${fila.codtipofuncionario == codtipofuncionario}'>
                              <option value="${fila.codtipofuncionario}" selected="selected">${fila.descripcion}</option>
                            </c:when>
                            <c:otherwise>
                              <option value="${fila.codtipofuncionario}">${fila.descripcion}</option>
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
                    <td height="27" class="bgDescTablas"><strong>Empresa</strong></td>
                    <td class="sinBgDescTablas"><label>
                      <select name="codempresa" id="codempresa" style="width: 150px">
                        <option id="codempresa" value=""></option>
                          <sql:query var="r" sql="select codempresa, nombre from empresa" dataSource="jdbc/delphos" scope="page"/>
                          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                           <c:choose>
                                <c:when test='${fila.codempresa == codempresa}'>
                                <option value="${fila.codempresa}" selected="selected">${fila.nombre}</option>
                                </c:when>
                            <c:otherwise>
                                <option value="${fila.codempresa}">${fila.nombre}</option>
                            </c:otherwise>
                           </c:choose>
                         </jsp2:forEach>
                      </select>
                    </label></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas"><strong>Cargo</strong></td>
                    <td class="sinBgDescTablas"><label>
                      <select name="codcargo" id="codcargo" style="width: 150px">
                        <option id="codcargo" value=""></option>
                          <sql:query var="r" sql="select codcargo, descripcion from cargo"  dataSource="jdbc/delphos" scope="page"/>
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
                    </select>
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Aplica a</strong></td>
                    <td colspan="4" class="sinBgDescTablas"><label>
                    <select name="aplicaa" id="aplicaa" style="width: 150px">
                      <option value="T">Contratista</option>
                      <option value="C">Contratante</option>
                      <option value="A">Ambos</option>
                    </select>
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="6"><p align="center" class="bgDescTablas"><strong>Observaciones</strong></p>
                      <p align="center" class="bgDescTablas"> 
                        <textarea name="observacion" cols="75" rows="3" id="observacion">${observacion}</textarea>
                      </p></td>
                  </tr>
          <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="codtipoactacontrato" id="codtipoactacontrato" value="" >
                  <input type="hidden" name="codregimenes" id="codregimenes" value="" >
                  <input type="hidden" name="codentidadsalud" id="codentidadsalud" value="" >
                  <input type="hidden" name="codcontrato" id="codcontrato" value="" >
                  <input type="hidden" name="numeroacta" id="numeroacta" value="" >
                  <input type="hidden" name="codtipoidentidad" id="codtipoidentidad" value="" >
                  <input type="hidden" name="numidentfunc" id="numidentfunc" value="" >
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
        var cad = document.getElementById('codcontratos').value;
        var cad2 = cad.split(" ");
		
        llaves = 'codtipoactacontrato='+cad2[0]+',';
		llaves+= 'codregimenes='+cad2[1]+',';
		llaves+= 'codentidadsalud='+cad2[2]+',';
		llaves+= 'codcontrato='+cad2[3]+',';
		llaves+= 'numeroacta='+cad2[4]+',';
		
		var cad1 = document.getElementById('numidentfuncs').value;
        var cad3 = cad.split(" ");
		
		llaves+= 'codtipoidentidad='+cad3[0]+',';
		llaves+= 'numidentfunc='+cad3[1];

        validarLlave('funcionarioactacto',llaves);
    } 
    
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=funcionarioactacto&";
        url = url + "campos=codtipoactacontrato,codregimenes,codentidadsalud,codcontrato,numeroacta,codtipoidentidad,numidentfunc,codtipofuncionario&";
        url = url + "campoLlave=codtipoactacontrato,codregimenes,codentidadsalud,codcontrato,numeroacta,codtipoidentidad,numidentfunc";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>