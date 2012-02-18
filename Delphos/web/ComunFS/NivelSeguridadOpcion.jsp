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
            var cajas = new Array('niseopcodigo','niseopdescripcion');
            var combos = null;
			
            var arrayNonulos               = new Array('niseopcodigo');
            var arrayNumerosEnteros        = null;
            var arrayCombos                = null;
            var arrayCadenasANCod          = new Array('niseopcodigo');
            var arrayCadenasA              = null;
            var arrayComentarios           = new Array('niseopdescripcion');
            var arrayNumerosDoubles        = null;
	</script>
</head>
<body bgcolor="#FFFFFF" onLoad="borrarMensaje(cajas[0]);">
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
            <sql:query var="r" sql="SELECT * FROM nivelsegopcion WHERE niseopcodigo='${param.llave}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="niseopcodigo" value="${fila.niseopcodigo}"/>
              <c:set var="niseopdescripcion" value="${fila.niseopdescripcion}"/>
              <c:set var="niseopejecuta" value="${fila.niseopejecuta}"/>
              <c:set var="niseopadiciona" value="${fila.niseopadiciona}"/>
              <c:set var="niseopmodifica" value="${fila.niseopmodifica}"/>
              <c:set var="niseopelimina" value="${fila.niseopelimina}"/>
              <c:set var="niseopconsulta" value="${fila.niseopconsulta}"/>
              <c:set var="niseopbuscar" value="${fila.niseopbuscar}"/>
              <c:set var="niseopimprime" value="${fila.niseopimprime}"/>
              <c:set var="niseopocultar" value="${fila.niseopocultar}"/>
            </jsp2:forEach>
                
                <table width="799" border="0" class="tablaContenido">
		<form name="formulario" id="formulario" method="post" action="NivelSeguridadOpcion.jsp">
                  <span id="mensajeControlador">${msj}</span>
                  <tr>
                    <td colspan="6"><div align="center" class="titulo1">Nivel Seguridad Opci&oacute;n</div></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="30" class="bgDescTablas">&nbsp;</td>
                    <td width="127" class="bgDescTablas"><strong>C&oacute;digo Nivel Seguridad</strong></td>
                    <td width="179" class="bgDescTablas"><label>
                      <input name="niseopcodigo" type="text" id="niseopcodigo" value="${niseopcodigo}" size="25" maxlength="3" onkeypress="javascript:return permite(event, 'num_car_cod')" tabindex="1"/>
                    </label></td>
                    <td width="18" class="bgDescTablas">&nbsp;</td>
                    <td width="137" class="bgDescTablas"><strong>Descripci&oacute;n Nivel</strong></td>
                    <td width="185" class="bgDescTablas"><label>
                      <input name="niseopdescripcion" type="text" id="niseopdescripcion" value="${niseopdescripcion}" size="25" maxlength="50" onkeypress="javascript:return permite(event, 'com')" tabindex="2"/>
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                      <td class="bgDescTablas">&nbsp;
                          
                      </td>
                      <td class="bgDescTablas">
                          <strong>Ejecutar</strong>
                      </td>
                      <td class="bgDescTablas">
                      <c:choose>
                            <c:when test = '${niseopejecuta == "S"}'>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="niseopejecuta" value="S" id="niseopejecuta_0" checked="true" tabindex="3"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="niseopejecuta" value="N" id="niseopejecuta_1" tabindex="3"/>
                                    </span>                                </label>
                            </c:when>
                            <c:otherwise>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="niseopejecuta" value="S" id="niseopejecuta_0" tabindex="3"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="niseopejecuta" value="N" id="niseopejecuta_1" checked="true" tabindex="3"/>
                                    </span>                                </label>
                            </c:otherwise>
                      </c:choose></td>
                      <td class="bgDescTablas">&nbsp;
                          
                      </td>
                      <td class="bgDescTablas">
                          <strong>Adicionar</strong>
                      </td>
                      <td class="bgDescTablas">
                      <c:choose>
                            <c:when test = '${niseopadiciona == "S"}'>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="niseopadiciona" value="S" id="niseopadiciona_0" checked="true" tabindex="4"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="niseopadiciona" value="N" id="niseopadiciona_1" tabindex="4"/>
                                    </span>                                </label>
                            </c:when>
                            <c:otherwise>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="niseopadiciona" value="S" id="niseopadiciona_0" tabindex="4"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="niseopadiciona" value="N" id="niseopadiciona_1" checked="true"tabindex="4"/>
                                    </span>                                </label>
                            </c:otherwise>
                      </c:choose></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                      <td class="bgDescTablas">&nbsp;
                          
                      </td>
                      <td class="bgDescTablas">
                          <strong>Modificar</strong>
                      </td>
                      <td class="bgDescTablas">
                      <c:choose>
                            <c:when test = '${niseopmodifica == "S"}'>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="niseopmodifica" value="S" id="niseopmodifica_0" checked="true" tabindex="5"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="niseopmodifica" value="N" id="niseopmodifica_1" tabindex="5"/>
                                    </span>                                </label>
                            </c:when>
                            <c:otherwise>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="niseopmodifica" value="S" id="niseopmodifica_0" tabindex="5"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="niseopmodifica" value="N" id="niseopmodifica_1" checked="true" tabindex="5"/>
                                    </span>                                </label>
                            </c:otherwise>
                      </c:choose></td>
                      <td class="bgDescTablas">&nbsp;
                          
                      </td>
                      <td class="bgDescTablas">
                          <strong>Eliminar</strong>
                      </td>
                      <td class="bgDescTablas">
                      <c:choose>
                            <c:when test = '${niseopelimina == "S"}'>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="niseopelimina" value="S" id="niseopelimina_0" checked="true" tabindex="6"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="niseopelimina" value="N" id="niseopelimina_1" tabindex="6"/>
                                    </span>                                </label>
                            </c:when>
                            <c:otherwise>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="niseopelimina" value="S" id="niseopelimina_0" tabindex="6"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="niseopelimina" value="N" id="niseopelimina_1" checked="true" tabindex="6"/>
                                    </span>                                </label>
                            </c:otherwise>
                      </c:choose></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                      <td class="bgDescTablas">&nbsp;
                          
                      </td>
                      <td class="bgDescTablas">
                          <strong>Consultar</strong>
                      </td>
                      <td class="bgDescTablas">
                      <c:choose>
                            <c:when test = '${niseopconsulta == "S"}'>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="niseopconsulta" value="S" id="niseopconsulta_0" checked="true" tabindex="7"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="niseopconsulta" value="N" id="niseopconsulta_1" tabindex="7"/>
                                    </span>                                </label>
                            </c:when>
                            <c:otherwise>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="niseopconsulta" value="S" id="niseopconsulta_0" tabindex="7"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="niseopconsulta" value="N" id="niseopconsulta_1" checked="true" tabindex="7"/>
                                    </span>                                </label>
                            </c:otherwise>
                      </c:choose></td>
                      <td class="bgDescTablas">&nbsp;
                          
                      </td>
                      <td class="bgDescTablas">
                          <strong>Buscar</strong>
                      </td>
                      <td class="bgDescTablas">
                      <c:choose>
                            <c:when test = '${niseopbuscar == "S"}'>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="niseopbuscar" value="S" id="niseopbuscar_0" checked="true" tabindex="8"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="niseopbuscar" value="N" id="niseopbuscar_1" tabindex="8"/>
                                    </span>                                </label>
                            </c:when>
                            <c:otherwise>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="niseopbuscar" value="S" id="niseopbuscar_0" tabindex="8"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="niseopbuscar" value="N" id="niseopbuscar_1" checked="true" tabindex="8"/>
                                    </span>                                </label>
                            </c:otherwise>
                      </c:choose></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                      <td class="bgDescTablas">&nbsp;
                          
                      </td>
                      <td class="bgDescTablas">
                          <strong>Imprimir</strong>
                      </td>
                      <td class="bgDescTablas">
                      <c:choose>
                            <c:when test = '${niseopimprime == "S"}'>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="niseopimprime" value="S" id="niseopimprime_0" checked="true" tabindex="9"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="niseopimprime" value="N" id="niseopimprime_1" tabindex="9"/>
                                    </span>                                </label>
                            </c:when>
                            <c:otherwise>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="niseopimprime" value="S" id="niseopimprime_0" tabindex="9"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="niseopimprime" value="N" id="niseopimprime_1" checked="true" tabindex="9"/>
                                    </span>                                </label>
                            </c:otherwise>
                      </c:choose></td>
                      <td class="bgDescTablas">&nbsp;
                          
                      </td>
                      <td class="bgDescTablas">
                          <strong>Ocultar</strong>
                      </td>
                      <td class="bgDescTablas">
                      <c:choose>
                            <c:when test = '${niseopocultar == "S"}'>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="niseopocultar" value="S" id="niseopocultar_0" checked="true" tabindex="10"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="niseopocultar" value="N" id="niseopocultar_1" tabindex="10"/>
                                    </span>                                </label>
                            </c:when>
                            <c:otherwise>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="niseopocultar" value="S" id="niseopocultar_0" tabindex="10"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="niseopocultar" value="N" id="niseopocultar_1" checked="true" tabindex="10"/>
                                    </span>                                </label>
                            </c:otherwise>
                      </c:choose></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                      <td colspan="6"><div align="center">
                      <input type="hidden" name="llave" id="llave" value="" >
                      <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="14">-->
		  <label>&nbsp;</label>
                  <!--<input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="11"/>
                  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="12"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="13"/>-->
				  <jsp:include page="../BarraNavegacion.jsp?tabBuscar=17&tabGuardar=14&tabEditar=15&tabEliminar=16" />
               </div>
            </td>
           </tr>
                </form>
          </table>
        </center>
        
    </td>
</tr>
<tr>
    
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
        llaves = 'niseopcodigo='+document.getElementById('niseopcodigo').value;
        validarLlave('nivelsegopcion',llaves);
    } 
    
    //
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=nivelsegopcion&";
        url = url + "campos=niseopcodigo,niseopdescripcion&";
        url = url + "campoLlave=niseopcodigo";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>