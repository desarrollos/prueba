<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<%@ taglib prefix="jsp2" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>

<%
clases.VerificarUsuarioSistema v;
v = new clases.VerificarUsuarioSistema(request,response);
%>

<html>
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
            var cajas = new Array('consecutivos','disponibilidadppto','nrocompromiso','valorobligado','archsolicdisponib','archcertifdisponib','archcertifregistro','observacion');
            var combos = new Array('codcontratos','codrubropresupuestals');
                      
            //validar
            var arrayNonulos               = new Array('consecutivos');
            var arrayNumerosEnteros        = new Array('consecutivos');
            var arrayCombos                = new Array('codcontratos','codrubropresupuestals');
            var arrayCadenasANCod          = new Array('disponibilidadppto','nrocompromiso');
            var arrayCadenasA              = null;
            var arrayComentarios           = new Array('archsolicdisponib','archcertifdisponib','archcertifregistro','observacion');
            var arrayNumerosDoubles        = new Array('valorobligado');
            
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
<%-- Datos sesion --%>

<%-- Datos sesion --%>
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
            <c:if test='${param.codregimenes != null && param.codentidadsalud != null && param.codcontrato != null && param.codrubropresupuestal != null && param.consecutivo != null && param.consecutivo != ""}'>
            <sql:query var="r" sql="SELECT * FROM rubropptocontrato WHERE codregimenes='${param.codregimenes}' AND codentidadsalud='${param.codentidadsalud}' AND codcontrato='${param.codcontrato}' AND codrubropresupuestal='${param.codrubropresupuestal}' AND consecutivo=${param.consecutivo}" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codregimenesf" value="${fila.codregimenes}"/>
              <c:set var="codentidadsaludf" value="${fila.codentidadsalud}"/>
              <c:set var="codcontratof" value="${fila.codcontrato}"/>
              <c:set var="codrubropresupuestalf" value="${fila.codrubropresupuestal}"/>
              <c:set var="consecutivof" value="${fila.consecutivo}"/>              
              <c:set var="disponibilidadppto" value="${fila.disponibilidadppto}"/>
              <c:set var="nrocompromiso" value="${fila.nrocompromiso}"/>
              <c:set var="valorobligado" value="${fila.valorobligado}"/>
              <c:set var="observacion" value="${fila.observacion}"/>
              <c:set var="archsolicdisponib" value="${fila.archsolicdisponib}"/>
              <c:set var="archcertifdisponib" value="${fila.archcertifdisponib}"/>
              <c:set var="archcertifregistro" value="${fila.archcertifregistro}"/> 
              
              <%--Carga del archivo de la base de datos---------------------%>
              <%
              String ruta = request.getSession().getServletContext().getRealPath("temp")+"\\";
              ruta = ruta.replaceAll("\\\\","/");
              pageContext.setAttribute("ruta",ruta);
              %>
              <sql:query var="r" sql="select lo_export(rubropptocontrato.archivofi, '${ruta}${archsolicdisponib}') from rubropptocontrato where codregimenes='${param.codregimenes}' AND codentidadsalud='${param.codentidadsalud}' AND codcontrato='${param.codcontrato}' AND codrubropresupuestal='${param.codrubropresupuestal}' AND consecutivo=${param.consecutivo}" dataSource="jdbc/delphos" scope="page"/>
              <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <%------------------------------------------------------------%>
              </jsp2:forEach>
              <%------------------------------------------------------------%>
              
              <%--Carga del archivo de la base de datos---------------------%>
              <%
              String ruta1 = request.getSession().getServletContext().getRealPath("temp")+"\\";
              ruta1 = ruta1.replaceAll("\\\\","/");
              pageContext.setAttribute("ruta",ruta1);
              %>
              <sql:query var="r" sql="select lo_export(rubropptocontrato.archivofi2, '${ruta}${archcertifdisponib}') from rubropptocontrato where codregimenes='${param.codregimenes}' AND codentidadsalud='${param.codentidadsalud}' AND codcontrato='${param.codcontrato}' AND codrubropresupuestal='${param.codrubropresupuestal}' AND consecutivo=${param.consecutivo}" dataSource="jdbc/delphos" scope="page"/>
              <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <%------------------------------------------------------------%>
              </jsp2:forEach>
              <%------------------------------------------------------------%>
              
              <%--Carga del archivo de la base de datos---------------------%>
              <%
              String ruta2 = request.getSession().getServletContext().getRealPath("temp")+"\\";
              ruta2 = ruta2.replaceAll("\\\\","/");
              pageContext.setAttribute("ruta",ruta2);
              %>
              <sql:query var="r" sql="select lo_export(rubropptocontrato.archivofi3, '${ruta}${archcertifregistro}') from rubropptocontrato where codregimenes='${param.codregimenes}' AND codentidadsalud='${param.codentidadsalud}' AND codcontrato='${param.codcontrato}' AND codrubropresupuestal='${param.codrubropresupuestal}' AND consecutivo=${param.consecutivo}" dataSource="jdbc/delphos" scope="page"/>
              <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <%------------------------------------------------------------%>
              </jsp2:forEach>
              <%------------------------------------------------------------%>
              
</jsp2:forEach>
                
                <table width="769" border="0" class="tablaContenido">
                <span id="mensajeControlador">${msj}</span>
				<form action="RubroPptoContrato.jsp" method="post" name="formulario">
                  <tr>
                    <td colspan="6"><div align="center" class="titulo1">Rubro Presupuestal </div></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="23">&nbsp;</td>
                    <td width="137"><strong class="bgDescTablas">Contrato</strong></td>
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
                    <td class="bgDescTablas"><strong><strong>Consecutivo</strong></strong></td>
                    <td width="149" class="sinBgDescTablas"><label>
                      <input name="consecutivos" type="text" id="consecutivos" value="${consecutivof}" size="20" maxlength="4" />
                    </label></td>
                    <td width="21">&nbsp;</td>
                    <td width="143" class="bgDescTablas"><strong>Rubro Presupuestal</strong></td>
                    <td width="169" class="sinBgDescTablas"><label>
                      <select name="codrubropresupuestals" id="codrubropresupuestals" style="width: 150px">
                        <option id="codrubropresupuestals" value=""></option>
                              <sql:query var="r" sql="select codrubropresupuestal, descripcion from rubropresupuestal" dataSource="jdbc/delphos" scope="page"/>
                        <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                               <c:choose>
                                    <c:when test='${fila.codrubropresupuestal == codrubropresupuestalf}'>
                                    <option value="${fila.codrubropresupuestal}" selected="selected">${fila.descripcion}</option>
                                    </c:when>
                                <c:otherwise>
                                    <option value="${fila.codrubropresupuestal}">${fila.descripcion}</option>
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
                    <td class="bgDescTablas"><strong> No. Disponibilidad Presupuestal
                    </strong></td>
                    <td class="sinBgDescTablas"><label>
                    <input name="disponibilidadppto" type="text" id="disponibilidadppto" value="${disponibilidadppto}" size="20" maxlength="15" />
                    </label></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas"><strong>No. Compromiso </strong></td>
                    <td class="sinBgDescTablas"><label>
                      <input name="nrocompromiso" type="text" id="nrocompromiso" value="${nrocompromiso}" size="20" maxlength="15" />
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td height="27" class="bgDescTablas"><strong>Valor Obligado
                        <label></label>
                    </strong></td>
                    <td class="sinBgDescTablas"><label>
                      <input name="valorobligado" type="text" id="valorobligado" value="${valorobligado}" size="20" maxlength="17" />
                    </label></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas"><strong>Solicitud Disponibilidad</strong></td>
                    <td class="sinBgDescTablas"><label><span class="sinBgDescTablas" style="width: 20%">
                      <input name="archsolicdisponib" type="text" id="archsolicdisponib" size="15"  value="${archsolicdisponib}" readonly="readonly"/>
                      <a href="#" onClick="abrirCargaArchivo();"><img src="../images/Buscar16x16.gif" alt="Cargar Archivo" border="0" tabindex="4"/></a>
                    <c:if test='${archsolicdisponib != null && archsolicdisponib != ""}'><br>
                    <a href="../temp/${archsolicdisponib}" target="_blank">Descargar ${archsolicdisponib}</a> </c:if>
                    </span></label></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Certificaci&oacute;n Disponibilidad </strong></td>
                    <td class="sinBgDescTablas"><label><span class="sinBgDescTablas" style="width: 20%">
                      <input name="archcertifdisponib" type="text" id="archcertifdisponib" size="15"  value="${archcertifdisponib}" readonly="readonly"/>
                      <a href="#" onClick="abrirCargaArchivo1();"><img src="../images/Buscar16x16.gif" alt="Cargar Archivo" border="0" tabindex="4"/></a>
                    <c:if test='${archcertifdisponib != null && archcertifdisponib != ""}'><br>
                    <a href="../temp/${archcertifdisponib}" target="_blank">Descargar ${archcertifdisponib}</a> </c:if>
                    </span></label></td>
                    <td>&nbsp;</td>
                    <td class="bgDescTablas"><strong>  Certificado de Registro </strong></td>
                    <td class="sinBgDescTablas"><label><span class="sinBgDescTablas" style="width: 20%">
                      <input name="archcertifregistro" type="text" id="archcertifregistro" size="15"  value="${archcertifregistro}" readonly="readonly"/>
                      <a href="#" onClick="abrirCargaArchivo2();"><img src="../images/Buscar16x16.gif" alt="Cargar Archivo" border="0" tabindex="4"/></a>
                      <c:if test='${archcertifregistro != null && archcertifregistro != ""}'><br>
                        <a href="../temp/${archcertifregistro}" target="_blank">Descargar ${archcertifregistro}</a> </c:if>
                    </span></label></td>
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
                  <input type="hidden" name="codrubropresupuestal" id="codrubropresupuestal" value="" >
                  <input type="hidden" name="consecutivo" id="consecutivo" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="6">-->
		  <label>&nbsp;</label>
                  <!--<input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="3" />
                  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="4"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="5"/>-->
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
    function abrirCargaArchivo()
    {
        var url;
        url = "PopUpCargaArchivo.jsp?";
        url = url + "campo=archsolicdisponib";
        
        window.open(url,"_blank","width=500,height=190,scrollbars=1,left=350,top=100");
    }
	
	function abrirCargaArchivo1()
    {
        var url;
        url = "PopUpCargaArchivo.jsp?";
        url = url + "campo=archcertifdisponib";
        
        window.open(url,"_blank","width=500,height=190,scrollbars=1,left=350,top=100");
    }
	
	function abrirCargaArchivo2()
    {
        var url;
        url = "PopUpCargaArchivo.jsp?";
        url = url + "campo=archcertifregistro";
        
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
        var cad = document.getElementById('codcontratos').value;
        var cad2 = cad.split(" ");
		
        llaves = 'codregimenes='+cad2[0]+',';
		llaves+= 'codentidadsalud='+cad2[1]+',';
		llaves+= 'codcontrato='+cad2[2]+',';
		
		llaves+= 'codrubropresupuestal='+document.getElementById('codrubropresupuestals').value+',';
		llaves+= 'consecutivo='+document.getElementById('consecutivos').value;
        validarLlave('rubropptocontrato',llaves);
    }
    
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=rubropptocontrato&";
        url = url + "campos=codregimenes,codentidadsalud,codcontrato,codrubropresupuestal,consecutivo,disponibilidadppto,nrocompromiso,valorobligado&";
        url = url + "campoLlave=codregimenes,codentidadsalud,codcontrato,codrubropresupuestal,consecutivo";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>