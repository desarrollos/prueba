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
		Calendar.setup({inputField : "espefechinics",ifFormat : "%d/%m/%Y",button : "botonEspefechinic"});
		Calendar.setup({inputField : "espefechfinas",ifFormat : "%d/%m/%Y",button : "botonEspefechfina"});
		Calendar.setup({inputField : "espefechregi",ifFormat : "%d/%m/%Y",button : "botonEspefechregi"});
	    }
			//totalidad de elementos en el form
            var cajas = new Array('espefechinics','espefechfinas','espefechregi','especlasprog','espenumefall','espefalljust','especertesco','espearchivo','espeobservac');
            var combos = new Array('escidentifics','firmidentifis');
			
            var arrayNonulos               	= new Array('espefechinics','espefechfinas','espefechregi','especlasprog','espenumefall','espefalljust');
            var arrayNumerosEnteros        	= new Array('especlasprog','espenumefall','espefalljust');
            var arrayCombos               	= new Array('escidentifics','firmidentifis');
            var arrayCadenasANCod          	= new Array('especertesco');
            var arrayCadenasA              	= null;
            var arrayComentarios           	= new Array('espearchivo','espeobservac');
            var arrayNumerosDoubles        	= null;
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
            <c:if test='${param.codtipoidentidadins != null && param.codempresa != null && param.codtipoidentidad != null && param.escidentific != null && param.escvigencia != null && param.espefechinic != null && param.espefechfina != null && param.escvigencia != "" && param.espefechinic != "" && param.espefechfina != ""}'>
            <sql:query var="r" sql="SELECT * FROM escregperiodico WHERE codtipoidentidadins='${param.codtipoidentidadins}' AND codempresa='${param.codempresa}' AND codtipoidentidad='${param.codtipoidentidad}' AND escidentific='${param.escidentific}' AND escvigencia=${param.escvigencia} AND espefechinic='${param.espefechinic}' AND espefechfina='${param.espefechfina}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codtipoidentidadinsf" value="${fila.codtipoidentidadins}"/>
              <c:set var="codempresaf" value="${fila.codempresa}"/>
              <c:set var="codtipoidentidadf" value="${fila.codtipoidentidad}"/>
              <c:set var="escidentificf" value="${fila.escidentific}"/>
              <c:set var="escvigenciaf" value="${fila.escvigencia}"/>
              <fmt:formatDate value="${fila.espefechinic}" pattern="dd/MM/yyyy" var="espefechinicf"/>
              <fmt:formatDate value="${fila.espefechfina}" pattern="dd/MM/yyyy" var="espefechfinaf"/>
              <c:set var="codtipoidentidadfir" value="${fila.codtipoidentidadfir}"/> 
              <c:set var="firmidentifi" value="${fila.firmidentifi}"/>
              <fmt:formatDate value="${fila.espefechregi}" pattern="dd/MM/yyyy" var="espefechregi"/>
              <c:set var="especlasprog" value="${fila.especlasprog}"/>
              <c:set var="espenumefall" value="${fila.espenumefall}"/>
              <c:set var="espefalljust" value="${fila.espefalljust}"/>
              <c:set var="especertesco" value="${fila.especertesco}"/>
              <c:set var="especertreci" value="${fila.especertreci}"/>
              <c:set var="especumprequ" value="${fila.especumprequ}"/>
              <c:set var="espearchivo" value="${fila.espearchivo}"/>
              <c:set var="espeobservac" value="${fila.espeobservac}"/> 
              
              <%--Carga del archivo de la base de datos---------------------%>
              <%
              String ruta = request.getSession().getServletContext().getRealPath("temp")+"\\";
              ruta = ruta.replaceAll("\\\\","/");
              pageContext.setAttribute("ruta",ruta);
              %>
              <sql:query var="r" sql="select lo_export(escregperiodico.archivofi, '${ruta}${espearchivo}') from escregperiodico WHERE codtipoidentidadins='${param.codtipoidentidadins}' AND codempresa='${param.codempresa}' AND codtipoidentidad='${param.codtipoidentidad}' AND escidentific='${param.escidentific}' AND escvigencia=${param.escvigencia} AND espefechinic='${param.espefechinic}' AND escvigencia='${param.escvigencia}'" dataSource="jdbc/delphos" scope="page"/>
              <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <%------------------------------------------------------------%>
              </jsp2:forEach>
              <%------------------------------------------------------------%>
              
</jsp2:forEach>    
                
                <table width="819" border="0" class="tablaContenido">
				<form name="formulario" method="post" action="RegistroPeriodicoEscolaridad.jsp">
                <span id="mensajeControlador">${msj}</span>
                  <tr>
                    <td colspan="6"><div align="center"><span class="titulo1">Registro Periodico de Escolaridad</span></div></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="30">&nbsp;</td>
                    <td width="147"><span class="bgDescTablas"><strong>Instituci&oacute;n Educativa</strong></span></td>
                    <td colspan="4"><select name="escidentifics" id="escidentifics" style="width: 150px">
                      <option id="escidentifics" value=""></option>
                      <sql:query var="r" sql="select codtipoidentidadins, codempresa, codtipoidentidad, escidentific, escvigencia from escolaridad" dataSource="jdbc/delphos" scope="page"/>
                      <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                        <c:choose>
                          <c:when test="${fila.codtipoidentidadins == codtipoidentidadinsf && fila.codempresa == codempresaf && fila.codtipoidentidad == codtipoidentidadf && fila.escidentific == escidentificf && fila.escvigencia == escvigenciaf}">
                            <option value="${fila.codtipoidentidadins} ${fila.codempresa} ${fila.codtipoidentidad} ${fila.escidentific} ${fila.escvigencia}" selected="selected">${fila.escidentific}</option>
                          </c:when>
                          <c:otherwise>
                            <option value="${fila.codtipoidentidadins} ${fila.codempresa} ${fila.codtipoidentidad} ${fila.escidentific} ${fila.escvigencia}">${fila.escidentific}</option>
                          </c:otherwise>
                        </c:choose>
                      </jsp2:forEach>
                    </select></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  
                  <tr>
                    <td>&nbsp;</td>
                    <td><span class="bgDescTablas"><strong>Fecha Inicial</strong></span></td>
                    <td><input name="espefechinics" type="text" id="espefechinics" value="${espefechinicf}" size="15" readonly="true" />
                    <input name="button" type="button" id="botonEspefechinic" value="..." /></td>
                    <td>&nbsp;</td>
                    <td><span class="bgDescTablas"><strong>Fecha Final</strong></span></td>
                    <td><input name="espefechfinas" type="text" id="espefechfinas" value="${espefechfinaf}" size="15" readonly="true" />
                    <input name="button2" type="button" id="botonEspefechfina" value="..." /></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td><span class="bgDescTablas"><strong>Fecha Registro</strong></span></td>
                    <td><input name="espefechregi" type="text" id="espefechregi" value="${espefechregi}" size="15" readonly="true" />
                    <input name="button3" type="button" id="botonEspefechregi" value="..." /></td>
                    <td>&nbsp;</td>
                    <td><span class="bgDescTablas"><strong> Nro. Clases Programadas</strong></span></td>
                    <td><input name="especlasprog" type="text" id="especlasprog" value="${especlasprog}" size="20" onkeypress="javascript:return permite(event, 'nume')"/></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td><span class="bgDescTablas"><strong>Nro. Fallas</strong></span></td>
                    <td><input name="espenumefall" type="text" id="espenumefall" value="${espenumefall}" size="20" onkeypress="javascript:return permite(event, 'nume')"/></td>
                    <td>&nbsp;</td>
                    <td><span class="bgDescTablas"><strong>Justificadas y Soportadas</strong></span></td>
                    <td><input name="espefalljust" type="text" id="espefalljust" value="${espefalljust}" size="20" onkeypress="javascript:return permite(event, 'nume')"/></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td><span class="bgDescTablas"><strong>Nro. Certificado Escolar</strong></span></td>
                    <td><input name="especertesco" type="text" id="especertesco" value="${especertesco}" size="20" maxlength="12" onkeypress="javascript:return permite(event, 'num_car_cod')"/></td>
                    <td>&nbsp;</td>
                    <td><span class="bgDescTablas"><strong>Certificado Recibido</strong></span></td>
                    <td class="bgDescTablas"><strong><c:choose>
                            <c:when test = '${especertreci == "S"}'>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="especertreci" value="S" id="especertreci_0" checked="true"/>
                                    </span>
                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="especertreci" value="N" id="especertreci_1" />
                                    </span> 
                                </label>
                            </c:when>
                            <c:otherwise>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="especertreci" value="S" id="especertreci_0"/>
                                    </span>
                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="especertreci" value="N" id="especertreci_1" checked="true"/>
                                    </span> 
                                </label>
                            </c:otherwise>
                        </c:choose>
                    </strong></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td><span class="bgDescTablas"><strong>Cumple con Requisitos</strong></span></td>
                    <td class="bgDescTablas"><strong><c:choose>
                            <c:when test = '${especumprequ == "S"}'>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="especumprequ" value="S" id="especumprequ_0" checked="true"/>
                                    </span>
                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="especumprequ" value="N" id="especumprequ_1" />
                                    </span> 
                                </label>
                            </c:when>
                            <c:otherwise>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="especumprequ" value="S" id="especumprequ_0"/>
                                    </span>
                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="especumprequ" value="N" id="especumprequ_1" checked="true"/>
                                    </span> 
                                </label>
                            </c:otherwise>
                        </c:choose>
                    </strong></td>
                    <td>&nbsp;</td>
                    <td><span class="bgDescTablas"><strong>Archivo Documento Certificado</strong></span></td>
                    <td><span class="sinBgDescTablas" style="width: 20%">
                      <input name="espearchivo" type="text" id="espearchivo" size="15"  value="${espearchivo}" readonly="readonly"/>
                      <a href="#" onclick="abrirCargaArchivo();"><img src="../images/Buscar16x16.gif" alt="Cargar Archivo" border="0" tabindex="4"/></a>
                    <c:if test='${espearchivo != null && espearchivo != ""}'><br>
                    <a href="../temp/${espearchivo}" target="_blank">Descargar ${espearchivo}</a> </c:if>
                    </span></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="6"><div align="center"><span class="titulo1">Persona que firma el certificado</span></div></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td><span class="bgDescTablas"><strong>Tipo Id.</strong></span></td>
                    <td colspan="4">
                        <select name="firmidentifis" id="firmidentifis" style="width: 150px">
                        <option id="firmidentifis" value=""></option>
                      <sql:query var="r" sql="select codtipoidentidadfir, firmidentifi from firmasautorizadas" dataSource="jdbc/delphos" scope="page"/>
                      <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                       <c:choose>
                            <c:when test="${fila.codtipoidentidadfir == codtipoidentidadfir && fila.firmidentifi == firmidentifi}">
                            <option value="${fila.codtipoidentidadfir} ${fila.firmidentifi}" selected="selected">${fila.firmidentifi}</option>
                            </c:when>
                        <c:otherwise>
                            <option value="${fila.codtipoidentidadfir} ${fila.firmidentifi}">${fila.firmidentifi}</option>
                        </c:otherwise>
                       </c:choose>
                     </jsp2:forEach>
                    </select></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  
                  <tr>
                    <td colspan="6"><p align="center" class="bgDescTablas"><strong>Observaciones</strong></p>
                      <p align="center" class="bgDescTablas">
                        <textarea name="espeobservac" id="espeobservac" cols="75" rows="3" onkeypress="javascript:return permite(event, 'com')">${espeobservac}</textarea>
                      </p></td>
                  </tr>
                  <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="codtipoidentidadins" id="codtipoidentidadins" value="" >
                  <input type="hidden" name="codempresa" id="codempresa" value="" >
                  <input type="hidden" name="codtipoidentidad" id="codtipoidentidad" value="" >
                  <input type="hidden" name="escidentific" id="escidentific" value="" >
                  <input type="hidden" name="escvigencia" id="escvigencia" value="" >
                  <input type="hidden" name="espefechinic" id="espefechinic" value="" >
                  <input type="hidden" name="espefechfina" id="espefechfina" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="17"> -->
		  <label>&nbsp;</label>
		 <!-- <input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="14"/>
		  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="15"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="16"/> -->
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
    function abrirCargaArchivo()
    {
        var url;
        url = "PopUpCargaArchivo.jsp?";
        url = url + "campo=espearchivo";
        
        window.open(url,"_blank","width=500,height=190,scrollbars=1,left=350,top=100");
    }
	
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
         var cad = document.getElementById('escidentifics').value;
        var cad2 = cad.split(" ");
		
        llaves = 'codtipoidentidadins='+cad2[0]+',';
	llaves+= 'codempresa='+cad2[1]+',';
        llaves+= 'codtipoidentidad='+cad2[2]+',';
        llaves+= 'escidentific='+cad2[3]+',';
	llaves+= 'escvigencia='+cad2[4]+',';		
	llaves+= 'espefechinic='+document.getElementById('espefechinics').value+',';
        llaves+= 'espefechfina='+document.getElementById('espefechfinas').value;

        validarLlave('escregperiodico',llaves);		
    }
    
    configurar();
    
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=escregperiodico&";
        url = url + "campos=codtipoidentidadins,codempresa,codtipoidentidad,escidentific,escvigencia,espefechinic,espefechfina,codtipoidentidadfir&";
        url = url + "campoLlave=codtipoidentidadins,codempresa,codtipoidentidad,escidentific,escvigencia,espefechinic,espefechfina";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>