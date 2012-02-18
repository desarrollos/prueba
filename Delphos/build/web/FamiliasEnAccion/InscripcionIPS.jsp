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
		Calendar.setup({inputField : "insipsfecins",ifFormat : "%d/%m/%Y",button : "botonInsipsfecins"});
	    }
			
			//totalidad de elementos en el form
            var cajas = new Array('insipsidenti','insipsfecins','insipshiscli','insipscenate','insipsarchiv','insipsobserv');
            var combos = new Array('codentidadsaluds','codtipoidentidads','esinipscodigo');
			
            var arrayNonulos               	= null;
            var arrayNumerosEnteros        	= null;
            var arrayCombos               	= new Array('codentidadsaluds','codtipoidentidads','esinipscodigo');
            var arrayCadenasANCod          	= new Array('insipsidenti','insipshiscli','insipscenate');
            var arrayCadenasA              	= null;
            var arrayComentarios           	= new Array('insipsarchiv','insipsobserv');
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
            <c:if test="${param.codregimenes != null && param.codentidadsalud != null && param.codtipoidentidad != null}">
            <sql:query var="r" sql="SELECT * FROM inscripcionips WHERE codregimenes='${param.codregimenes}' AND codentidadsalud='${param.codentidadsalud}' AND codtipoidentidad='${param.codtipoidentidad}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codregimenesf" value="${fila.codregimenes}"/>
              <c:set var="codentidadsaludf" value="${fila.codentidadsalud}"/>
              <c:set var="codtipoidentidadf" value="${fila.codtipoidentidad}"/>
              <c:set var="insipsidenti" value="${fila.insipsidenti}"/>
              <fmt:formatDate value="${fila.insipsfecins}" pattern="dd/MM/yyyy" var="insipsfecins"/>
              <c:set var="insipshiscli" value="${fila.insipshiscli}"/>
              <c:set var="insipscenate" value="${fila.insipscenate}"/>
              <c:set var="esinipscodigo" value="${fila.esinipscodigo}"/> 
              <c:set var="insipsarchiv" value="${fila.insipsarchiv}"/>
              <c:set var="insipsobserv" value="${fila.insipsobserv}"/>
              
              <%--Carga del archivo de la base de datos---------------------%>
              <%
              String ruta = request.getSession().getServletContext().getRealPath("temp")+"\\";
              ruta = ruta.replaceAll("\\\\","/");
              pageContext.setAttribute("ruta",ruta);
              %>
              <sql:query var="r" sql="select lo_export(inscripcionips.archivofi, '${ruta}${insipsarchiv}') from inscripcionips WHERE codregimenes='${param.codregimenes}' AND codentidadsalud='${param.codentidadsalud}' AND codtipoidentidad='${param.codtipoidentidad}'" dataSource="jdbc/delphos" scope="page"/>
              <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <%------------------------------------------------------------%>
              </jsp2:forEach>
              <%------------------------------------------------------------%>
              
            </jsp2:forEach>

                
                <form name="formulario" method="post" action="InscripcionIPS.jsp">
                <span id="mensajeControlador">${msj}</span>
                <table width="843" border="0" class="tablaContenido">
				
                  <tr>
                    <td colspan="6"><div align="center"><span class="titulo1">Inscripci&oacute;n IPS</span></div></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="30">&nbsp;</td>
                    <td width="171"><span class="bgDescTablas"><strong>Entidad Salud</strong></span></td>
                    <td colspan="4">
                    <select name="codentidadsaluds" id="codentidadsaluds" style="width: 150px">
                     <option id="codentidadsaluds" value=""></option>
                      <sql:query var="r" sql="select codentidadsalud, codregimenes, nombre from entidadsalud a join empresa b on a.codempresa = b.codempresa" dataSource="jdbc/delphos" scope="page"/>
                      <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                       <c:choose>
                            <c:when test='${fila.codentidadsalud == codentidadsaludf && fila.codregimenes == codregimenesf}'>
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
                    <td><strong class="bgDescTablas">Tipo Identificaci&oacute;n</strong></td>
                    <td width="164"><label>
                    <select name="codtipoidentidads" id="codtipoidentidads" style="width: 150px">
                     <option id="codtipoidentidads" value=""></option>
                  <sql:query var="r" sql="select codtipoidentidad, descripcion from tipoidentificacion" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                   <c:choose>
                        <c:when test='${fila.codtipoidentidad == codtipoidentidadf}'>
                        <option value="${fila.codtipoidentidad}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                    <c:otherwise>
                        <option value="${fila.codtipoidentidad}">${fila.descripcion}</option>
                    </c:otherwise>
                   </c:choose>
                 </jsp2:forEach>
                    </select>
                    </label></td>
                    <td width="19">&nbsp;</td>
                    <td width="139"><span class="bgDescTablas"><strong> Nro. Identificaci&oacute;n</strong></span></td>
                    <td width="153"><input name="insipsidenti" type="text" id="insipsidenti" value="${insipsidenti}" size="20" maxlength="18" onkeypress="javascript:return permite(event, 'num_car_cod')"/></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td><span class="bgDescTablas"><strong>Fecha Inscripci&oacute;n</strong></span></td>
                    <td colspan="4"><input name="insipsfecins" type="text" id="insipsfecins" value="${insipsfecins}" size="15" readonly="true" />
                    <input name="button" type="button" id="botonInsipsfecins" value="..." /></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td><span class="bgDescTablas"><strong>Nro. Historia Cl&iacute;nica</strong></span></td>
                    <td><input name="insipshiscli" type="text" id="insipshiscli" value="${insipshiscli}" size="20" maxlength="18" onkeypress="javascript:return permite(event, 'num_car_cod')"/></td>
                    <td>&nbsp;</td>
                    <td><span class="bgDescTablas"><strong>Centro Atenci&oacute;n</strong></span></td>
                    <td><input name="insipscenate" type="text" id="insipscenate" value="${insipscenate}" size="20" maxlength="70" onkeypress="javascript:return permite(event, 'num_car_cod')"/></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td><span class="bgDescTablas"><strong>Estado Inscripci&oacute;n</strong></span></td>
                    <td><select name="esinipscodigo" id="esinipscodigo" style="width: 150px">
                           <option id="esinipscodigo" value=""></option>
                          <sql:query var="r" sql="select esinipscodigo, esinipsdescri from estadoincripips" dataSource="jdbc/delphos" scope="page"/>
                          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                           <c:choose>
                                <c:when test='${fila.esinipscodigo == esinipscodigo}'>
                                <option value="${fila.esinipscodigo}" selected="selected">${fila.esinipsdescri}</option>
                                </c:when>
                            <c:otherwise>
                                <option value="${fila.esinipscodigo}">${fila.esinipsdescri}</option>
                            </c:otherwise>
                           </c:choose>
                         </jsp2:forEach>
                    </select></td>
                    <td>&nbsp;</td>
                    <td><span class="bgDescTablas"><strong>Archivo Documento Certificado</strong></span></td>
                    <td><span class="sinBgDescTablas" style="width: 20%">
                      <input name="insipsarchiv" type="text" id="insipsarchiv" size="15"  value="${insipsarchiv}" readonly="readonly"/>
                      <a href="#" onclick="abrirCargaArchivo();"><img src="../images/Buscar16x16.gif" alt="Cargar Archivo" border="0" tabindex="4"/></a>
                      <c:if test='${insipsarchiv != null && insipsarchiv != ""}'><br />
                        <a href="../temp/${insipsarchiv}" target="_blank">Descargar ${insipsarchiv}</a> </c:if>
                    </span></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="6"><p align="center" class="bgDescTablas"><strong>Observaciones</strong></p>
                      <p align="center" class="bgDescTablas"> 
                        <textarea name="insipsobserv" cols="75" rows="3" id="insipsobserv" onkeypress="javascript:return permite(event, 'com')">${insipsobserv}</textarea>
                      </p></td>
                  </tr>
                  <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="codregimenes" id="codregimenes" value="" >
                  <input type="hidden" name="codentidadsalud" id="codentidadsalud" value="" >
                  <input type="hidden" name="codtipoidentidad" id="codtipoidentidad" value="" >
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
	
	function abrirCargaArchivo()
    {
        var url;
        url = "PopUpCargaArchivo.jsp?";
        url = url + "campo=insipsarchiv";
        
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
        var cad = document.getElementById('codentidadsaluds').value;
        var cad2 = cad.split(" ");
		
		llaves = 'codregimenes='+cad2[0]+',';
		llaves+= 'codentidadsalud='+cad2[1]+',';
        llaves+= 'codtipoidentidad='+document.getElementById('codtipoidentidads').value;
        validarLlave('inscripcionips',llaves);
    }
    
    configurar();
    
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=inscripcionips&";
        url = url + "campos=codregimenes,codentidadsalud,codtipoidentidad,insipsidenti,insipsfecins,insipshiscli,insipscenate,esinipscodigo&";
        url = url + "campoLlave=codregimenes,codentidadsalud,codtipoidentidad";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>