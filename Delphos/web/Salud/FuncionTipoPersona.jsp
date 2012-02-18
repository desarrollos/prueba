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
            var combos = new Array('codcontratos','codtipofuncionarios','codlistafuncions','aplicaa');
                      
            //validar
            var arrayNonulos               = null;
            var arrayNumerosEnteros        = null;
            var arrayCombos                = new Array('codcontrato','codtipofuncionario','codlistafuncion','aplicaa');
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
            <c:if test="${param.codregimenes != null && param.codentidadsalud != null && param.codcontrato != null && param.codtipofuncionario != null && param.codlistafuncion != null}">
            <sql:query var="r" sql="SELECT * FROM funciontipofunccto WHERE codregimenes='${param.codregimenes}' AND codentidadsalud='${param.codentidadsalud}' AND codcontrato='${param.codcontrato}' AND codtipofuncionario='${param.codtipofuncionario}' AND codlistafuncion='${param.codlistafuncion}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codregimenesf" value="${fila.codregimenes}"/>
              <c:set var="codentidadsaludf" value="${fila.codentidadsalud}"/>
              <c:set var="codcontratof" value="${fila.codcontrato}"/>
              <c:set var="codtipofuncionariof" value="${fila.codtipofuncionario}"/>
              <c:set var="codlistafuncionf" value="${fila.codlistafuncion}"/>              
              <c:set var="aplicaa" value="${fila.aplicaa}"/>              
              <c:set var="observacion" value="${fila.observacion}"/>
            </jsp2:forEach>
                
                <table width="741" border="0" class="tablaContenido">
                <span id="mensajeControlador">${msj}</span>
				<form action="FuncionTipoPersona.jsp" method="post" name="formulario">
                  <tr>
                    <td colspan="6"><div align="center" class="titulo1">Funcion Tipo Persona</div></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="30">&nbsp;</td>
                    <td width="97"><strong class="bgDescTablas">Contrato</strong></td>
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
                    <td width="97" height="27" class="bgDescTablas"><strong>Tipo Funcionario</strong></td>
                    <td width="188" class="sinBgDescTablas"><label>
                      <select name="codtipofuncionarios" id="codtipofuncionarios" style="width: 150px">
                        <option id="codtipofuncionarios" value=""></option>
                              <sql:query var="r" sql="select codtipofuncionario, descripcion from tipofuncionario" dataSource="jdbc/delphos" scope="page"/>
                              <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                               <c:choose>
                                    <c:when test='${fila.codtipofuncionario == codtipofuncionariof}'>
                                    <option value="${fila.codtipofuncionario}" selected="selected">${fila.descripcion}</option>
                                    </c:when>
                                <c:otherwise>
                                    <option value="${fila.codtipofuncionario}">${fila.descripcion}</option>
                                </c:otherwise>
                               </c:choose>
                             </jsp2:forEach>
                    </select>
                    </label></td>
                    <td width="28">&nbsp;</td>
                    <td width="107" class="bgDescTablas"><strong>Lista Funciones </strong></td>
                    <td width="184" class="sinBgDescTablas"><label>
                      <select name="codlistafuncions" id="codlistafuncions" style="width: 150px">
                        <option id="codlistafuncions" value=""></option>
                              <sql:query var="r" sql="select codlistafuncion, descripcion from listafuncion" dataSource="jdbc/delphos" scope="page"/>
                              <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                               <c:choose>
                                    <c:when test='${fila.codlistafuncion == codlistafuncionf}'>
                                    <option value="${fila.codlistafuncion}" selected="selected">${fila.descripcion}</option>
                                    </c:when>
                                <c:otherwise>
                                    <option value="${fila.codlistafuncion}">${fila.descripcion}</option>
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
                    <td width="97"><span class="bgDescTablas"><strong>Aplica a</strong></span></td>
                    <td colspan="4"><select name="aplicaa" id="aplicaa">
                      <option value=" "> </option>
                      <option value="T">Contratista</option>
                      <option value="C">Contratante</option>
                      <option value="A">Ambos</option>
                                        </select></td>
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
                  <input type="hidden" name="codregimenes" id="codregimenes" value="" >
                  <input type="hidden" name="codentidadsalud" id="codentidadsalud" value="" >
                  <input type="hidden" name="codcontrato" id="codcontrato" value="" >
                  <input type="hidden" name="codtipofuncionario" id="codtipofuncionario" value="" >
                  <input type="hidden" name="codlistafuncion" id="codlistafuncion" value="" >
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
		
        llaves = 'codregimenes='+cad2[0]+',';
		llaves+= 'codentidadsalud='+cad2[1]+',';
		llaves+= 'codcontrato='+cad2[2]+',';
		
		llaves+= 'codtipofuncionario='+document.getElementById('codtipofuncionarios').value+',';
		llaves+= 'codlistafuncion='+document.getElementById('codlistafuncions').value;
        validarLlave('funciontipofunccto',llaves);
    }
    
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=funciontipofunccto&";
        url = url + "campos=codregimenes,codentidadsalud,codcontrato,codtipofuncionario,codlistafuncion,aplicaa&";
        url = url + "campoLlave=codregimenes,codentidadsalud,codcontrato,codtipofuncionario,codlistafuncion";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>