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
           
            function configurar()
            {
		Calendar.setup({inputField : "regconfecate",ifFormat : "%d/%m/%Y",button : "botonRegconfecate"});
	    }
			
			//totalidad de elementos en el form
            var cajas = new Array('regconidenti','regconcantid','regconfecate','regconcersal','contarchivo','contobservac');
            var combos = new Array('salateidregi','codentidadsaludips','codtipoidentidadpe','codactividadsalud','codfinalidadconsulta','coddiagnostico','firmidentifi');
			
            var arrayNonulos               	= new Array('regconcantid','regconfecate');
            var arrayNumerosEnteros        	= new Array('regconcantid');
            var arrayCombos               	= new Array('salateidregi','codentidadsaludips','codtipoidentidadpe','codactividadsalud','codfinalidadconsulta','coddiagnostico','firmidentifi');
            var arrayCadenasANCod          	= new Array('regconidenti','regconcersal');
            var arrayCadenasA              	= null;
            var arrayComentarios           	= new Array('contarchivo','contobservac');
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
               <c:if test='${param.llave != null && param.llave != ""}'>
            <sql:query var="r" sql="SELECT * FROM registrocontrol WHERE salateidregi=${param.llave}" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="salateidregi" value="${fila.salateidregi}"/>
              <c:set var="codtipoidentidadpe" value="${fila.codtipoidentidadpe}"/>
              <c:set var="regconidenti" value="${fila.regconidenti}"/>
              <c:set var="codregimenips" value="${fila.codregimenips}"/>
              <c:set var="codentidadsaludips" value="${fila.codentidadsaludips}"/>
              <c:set var="codactividadsalud" value="${fila.codactividadsalud}"/>
              <c:set var="coddiagnostico" value="${fila.coddiagnostico}"/>
              <c:set var="codfinalidadconsulta" value="${fila.codfinalidadconsulta}"/>
              <c:set var="regconcantid" value="${fila.regconcantid}"/>
              <fmt:formatDate value="${fila.regconfecate}" pattern="dd/MM/yyyy" var="regconfecate"/>   
              <c:set var="regconcersal" value="${fila.regconcersal}"/>
              <c:set var="codtipoidentidadfi" value="${fila.codtipoidentidadfi}"/>
              <c:set var="firmidentifi" value="${fila.firmidentifi}"/>
              <c:set var="contcertreci" value="${fila.contcertreci}"/>
              <c:set var="contcumprequ" value="${fila.contcumprequ}"/>
              <c:set var="contarchivo" value="${fila.contarchivo}"/>
              <c:set var="contobservac" value="${fila.contobservac}"/>
              
              <%--Carga del archivo de la base de datos---------------------%>
              <%
              String ruta = request.getSession().getServletContext().getRealPath("temp")+"\\";
              ruta = ruta.replaceAll("\\\\","/");
              pageContext.setAttribute("ruta",ruta);
              %>
              <sql:query var="r" sql="select lo_export(registrocontrol.archivofi, '${ruta}${contarchivo}') from registrocontrol WHERE salateidregi=${param.llave}" dataSource="jdbc/delphos" scope="page"/>
              <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <%------------------------------------------------------------%>
              </jsp2:forEach>
              <%------------------------------------------------------------%>
              
            </jsp2:forEach>
                <form name="formulario" method="post" action="RegistroControles.jsp">
                <span id="mensajeControlador">${msj}</span>
                <table width="812" border="0" class="tablaContenido">

                  <tr>
                    <td colspan="6"><div align="center"><span class="titulo1">Registro Controles</span></div></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="20">&nbsp;</td>
                    <td width="159"><span class="bgDescTablas"><strong>Id. Registro</strong></span></td>
                    <td width="155"><select name="salateidregi" id="salateidregi" style="width: 150px">
                      <option id="salateidregi" value=""></option>
                      <sql:query var="r" sql="select salateidregi from saludatencion" dataSource="jdbc/delphos" scope="page"/>
                      <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                        <c:choose>
                          <c:when test='${fila.salateidregi == salateidregi}'>
                            <option value="${fila.salateidregi}" selected="selected">${fila.salateidregi}</option>
                          </c:when>
                          <c:otherwise>
                            <option value="${fila.salateidregi}">${fila.salateidregi}</option>
                          </c:otherwise>
                        </c:choose>
                      </jsp2:forEach>
                    </select></td>
                    <td width="15">&nbsp;</td>
                    <td width="141"><span class="bgDescTablas"><strong>IPS</strong></span></td>
                    <td width="152">
                    <select name="codentidadsaludips" id="codentidadsaludips" style="width: 150px">
                      <option id="codentidadsaludips" value=""></option>
                      <sql:query var="r" sql="select codentidadsalud, codregimenes, nombre from entidadsalud a join empresa b on a.codempresa = b.codempresa" dataSource="jdbc/delphos" scope="page"/>
                      <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                        <c:choose>
                          <c:when test='${fila.codentidadsalud == codentidadsaludips && fila.codregimenes == codregimenips}'>
                            <option value="${fila.codregimenes} ${fila.codentidadsalud}" selected="selected">${fila.nombre}</option>
                          </c:when>
                          <c:otherwise>
                            <option value="${fila.codregimenes} ${fila.codentidadsalud}">${fila.nombre}</option>
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
                    <td><span class="bgDescTablas"><strong>Tipo Identificaci&oacute;n</strong></span></td>
                    <td><select name="codtipoidentidadpe" id="codtipoidentidadpe" style="width: 150px">
                           <option id="codtipoidentidadpe" value=""></option>
                          <sql:query var="r" sql="select codtipoidentidad, descripcion from tipoidentificacion" dataSource="jdbc/delphos" scope="page"/>
                          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                           <c:choose>
                                <c:when test='${fila.codtipoidentidad == codtipoidentidadpe}'>
                                <option value="${fila.codtipoidentidad}" selected="selected">${fila.descripcion}</option>
                                </c:when>
                            <c:otherwise>
                                <option value="${fila.codtipoidentidad}">${fila.descripcion}</option>
                            </c:otherwise>
                           </c:choose>
                         </jsp2:forEach>
                    </select></td>
                    <td>&nbsp;</td>
                    <td><span class="bgDescTablas"><strong>Identificaci&oacute;n</strong></span></td>
                    <td><input name="regconidenti" type="text" id="regconidenti" value="${regconidenti}" size="20" maxlength="18" onkeypress="javascript:return permite(event, 'num_car_cod')"/></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td><span class="bgDescTablas"><strong>Actividad</strong></span></td>
                    <td><span class="sinBgDescTablas" style="width: 20%">
                      <select name="codactividadsalud" id="codactividadsalud" style="width: 150px">
                        <option id="codactividadsalud" value=""></option>
                        <sql:query var="r" sql="select codactividadsalud, descripcion from actividadsalud" dataSource="jdbc/delphos" scope="page"/>
                        <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                          <c:choose>
                            <c:when test='${fila.codactividadsalud == codactividadsalud}'>
                              <option value="${fila.codactividadsalud}" selected="selected">${fila.descripcion}</option>
                            </c:when>
                            <c:otherwise>
                              <option value="${fila.codactividadsalud}">${fila.descripcion}</option>
                            </c:otherwise>
                          </c:choose>
                        </jsp2:forEach>
                      </select>
                    </span></td>
                    <td>&nbsp;</td>
                    <td><span class="bgDescTablas"><strong>Cantidad</strong></span></td>
                    <td><input name="regconcantid" type="text" id="regconcantid" value="${regconcantid}" size="20" maxlength="9" onkeypress="javascript:return permite(event, 'nume')"/></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td><span class="bgDescTablas"><strong>Finalidad Consulta</strong></span></td>
                    <td><select name="codfinalidadconsulta" id="codfinalidadconsulta" style="width: 150px">
                          <option id="codfinalidadconsulta" value=""></option>
                          <sql:query var="r" sql="select codfinalidadconsulta, descripcion from finalidadconsulta" dataSource="jdbc/delphos" scope="page"/>
                          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                           <c:choose>
                                <c:when test='${fila.codfinalidadconsulta == codfinalidadconsulta}'>
                                <option value="${fila.codfinalidadconsulta}" selected="selected">${fila.descripcion}</option>
                                </c:when>
                            <c:otherwise>
                                <option value="${fila.codfinalidadconsulta}">${fila.descripcion}</option>
                            </c:otherwise>
                           </c:choose>
                         </jsp2:forEach>
                    </select></td>
                    <td>&nbsp;</td>
                    <td><span class="bgDescTablas"><strong>Dx Principal</strong></span></td>
                    <td><span class="sinBgDescTablas">
                      <select name="coddiagnostico" id="coddiagnostico" style="width: 150px">
                        <option id="coddiagnostico" value=""></option>
                        <sql:query var="r" sql="select coddiagnostico, descripcion from diagnostico" dataSource="jdbc/delphos" scope="page"/>
                        <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                          <c:choose>
                            <c:when test='${fila.coddiagnostico == coddiagnostico}'>
                              <option value="${fila.coddiagnostico}" selected="selected">${fila.descripcion}</option>
                            </c:when>
                            <c:otherwise>
                              <option value="${fila.coddiagnostico}">${fila.descripcion}</option>
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
                    <td><span class="bgDescTablas"><strong>Fecha Atenci&oacute;n</strong></span></td>
                    <td><input name="regconfecate" type="text" id="regconfecate" value="${regconfecate}" size="15" readonly="true" />
                    <input name="button" type="button" id="botonRegconfecate" value="..." /></td>
                    <td>&nbsp;</td>
                    <td><span class="bgDescTablas"><strong>Cumple con los requisitos</strong></span></td>
                    <td class="bgDescTablas"><c:choose>
                            <c:when test = '${contcumprequ == "S"}'>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="contcumprequ" value="S" id="contcumprequ_0" checked="true"/>
                                    </span>
                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="contcumprequ" value="N" id="contcumprequ_1" />
                                    </span> 
                                </label>
                            </c:when>
                            <c:otherwise>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="contcumprequ" value="S" id="contcumprequ_0"/>
                                    </span>
                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="contcumprequ" value="N" id="contcumprequ_1" checked="true"/>
                                    </span> 
                                </label>
                            </c:otherwise>
                        </c:choose></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td><span class="bgDescTablas"><strong>Nro. Certificado Salud</strong></span></td>
                    <td><input name="regconcersal" type="text" id="regconcersal" value="${regconcersal}" size="20" maxlength="12" onkeypress="javascript:return permite(event, 'num_car_cod')"/></td>
                    <td>&nbsp;</td>
                    <td><span class="bgDescTablas"><strong>Certificado Recibido</strong></span></td>
                    <td class="bgDescTablas"><c:choose>
                            <c:when test = '${contcertreci == "S"}'>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="contcertreci" value="S" id="contcertreci_0" checked="true"/>
                                    </span>
                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="contcertreci" value="N" id="contcertreci_1" />
                                    </span> 
                                </label>
                            </c:when>
                            <c:otherwise>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="contcertreci" value="S" id="contcertreci_0"/>
                                    </span>
                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="contcertreci" value="N" id="contcertreci_1" checked="true"/>
                                    </span> 
                                </label>
                            </c:otherwise>
                        </c:choose></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td><span class="bgDescTablas"><strong>Archivo Documento Certificado</strong></span></td>
                    <td colspan="4"><span class="sinBgDescTablas" style="width: 20%">
                      <input name="contarchivo" type="text" id="contarchivo" size="15"  value="${contarchivo}" readonly="readonly"/>
                      <a href="#" onclick="abrirCargaArchivo();"><img src="../images/Buscar16x16.gif" alt="Cargar Archivo" border="0" tabindex="4"/></a>
                      <c:if test='${contarchivo != null && contarchivo != ""}'><br />
                        <a href="../temp/${contarchivo}" target="_blank">Descargar ${contarchivo}</a> </c:if>
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
                    <td><span class="bgDescTablas"><strong>Nro. Identificaci&oacute;n</strong></span></td>
                    <td colspan="4"><select name="firmidentifi" id="firmidentifi" style="width: 150px">
                      <option id="firmidentifi" value=""></option>
                      <sql:query var="r" sql="select codtipoidentidadfir, firmidentifi from firmasautorizadas" dataSource="jdbc/delphos" scope="page"/>
                      <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                        <c:choose>
                          <c:when test='${fila.codtipoidentidadfir == codtipoidentidadfi && fila.firmidentifi == firmidentifi}'>
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
                        <textarea name="contobservac" id="contobservac" cols="75" rows="3" onkeypress="javascript:return permite(event, 'com')">${contobservac}</textarea>
                      </p></td>
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
        url = url + "campo=contarchivo";
        
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
        llaves = 'salateidregi='+document.getElementById('salateidregi').value;
        validarLlave('registrocontrol',llaves);
    }
    
    configurar();
    
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=registrocontrol&";
        url = url + "campos=salateidregi,codtipoidentidadpe,regconidenti,codregimenips,codentidadsaludips,codactividadsalud,coddiagnostico,codfinalidadconsulta&";
        url = url + "campoLlave=salateidregi";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>