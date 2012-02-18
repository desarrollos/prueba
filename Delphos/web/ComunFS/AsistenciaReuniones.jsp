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
           
            //totalidad de elementos en el form
            var cajas = new Array('encuencodigos','asisteidentis');
            var combos = new Array('codunifami','codtipoidentidads');
			
            var arrayNonulos               	= new Array('encuencodigos');
            var arrayNumerosEnteros        	= null;
            var arrayCombos               	= new Array('codunifami','codtipoidentidads');
            var arrayCadenasANCod          	= new Array('encuencodigos','asisteidentis');
            var arrayCadenasA              	= null;
            var arrayComentarios           	= null;
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
            <c:if test="${param.encuencodigo != null && param.codtipoidentidad != null && param.asisteidenti != null}">
            <sql:query var="r" sql="SELECT * FROM asistentesreunion WHERE encuencodigo='${param.encuencodigo}' AND codtipoidentidad='${param.codtipoidentidad}' AND asisteidenti='${param.asisteidenti}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="encuencodigof" value="${fila.encuencodigo}"/>
              <c:set var="codtipoidentidadf" value="${fila.codtipoidentidad}"/>
              <c:set var="asisteidentif" value="${fila.asisteidenti}"/>
              <c:set var="asispertprog" value="${fila.asispertprog}"/>
              <c:set var="codunifami" value="${fila.codunifami}"/>
                   
            </jsp2:forEach>

        
      <form name="formulario" method="post" action="AsistenciaReuniones.jsp">
      <span id="mensajeControlador">${msj}</span>
      <table width="824" border="0" class="tablaContenido">
			
              <tr>
                <td colspan="6"><div align="center"><span class="titulo1">Asistencia Reuniones</span></div></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td width="25">&nbsp;</td>
                <td width="90"><span class="bgDescTablas"><strong>C&oacute;digo</strong></span></td>
                <td width="183"><select name="encuencodigos" id="encuencodigos" style="width: 150px">
                  <option id="encuencodigos" value=""></option>
                  <sql:query var="r" sql="select encuencodigo from encuentroreunion" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                    <c:choose>
                      <c:when test='${fila.encuencodigo == encuencodigof}'>
                        <option value="${fila.encuencodigo}" selected="selected">${fila.encuencodigo}</option>
                      </c:when>
                      <c:otherwise>
                        <option value="${fila.encuencodigo}">${fila.encuencodigo}</option>
                      </c:otherwise>
                    </c:choose>
                  </jsp2:forEach>
                </select></td>
                <td width="19">&nbsp;</td>
                <td width="150"><span class="bgDescTablas"><strong> C&oacute;digo Unico Familia</strong></span></td>
                <td width="175"><label>
                  <select name="codunifami" id="codunifami" style="width: 150px">
                 <option id="codunifami" value=""></option>
                  <sql:query var="r" sql="select codunifami from inscripcion" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                   <c:choose>
                        <c:when test='${fila.codunifami == codunifami}'>
                        <option value="${fila.codunifami}" selected="selected">${fila.codunifami}</option>
                        </c:when>
                    <c:otherwise>
                        <option value="${fila.codunifami}">${fila.codunifami}</option>
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
                <td height="28"><p><span class="bgDescTablas"><strong>Tipo Id.</strong></span></p></td>
                <td><p><span class="sinBgDescTablas" style="width: 15%">
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
                </span></p></td>
                <td>&nbsp;</td>
                <td><span class="bgDescTablas"><strong>Nro. Identificacion</strong></span></td>
                <td><span class="sinBgDescTablas" style="width: 20%">
                  <input name="asisteidentis" type="text" id="asisteidentis" value="${asisteidentif}" size="20" maxlength="18" onkeypress="javascript:return permite(event, 'num_car_cod')"/>
                </span></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                  <td colspan="6" class="bgDescTablas"><div align="center"><span ><strong>Pertenece al Programa</strong></span>
                      <c:choose>
                            <c:when test = '${asispertprog == "S"}'>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="asispertprog" value="S" id="asispertprog_0" checked="true"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="asispertprog" value="N" id="asispertprog_1" />
                                    </span>                                </label>
                            </c:when>
                            <c:otherwise>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="asispertprog" value="S" id="asispertprog_0"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="asispertprog" value="N" id="asispertprog_1" checked="true"/>
                                    </span>                                </label>
                            </c:otherwise>
                </c:choose></div></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="encuencodigo" id="encuencodigo" value="" >
                  <input type="hidden" name="codtipoidentidad" id="codtipoidentidad" value="" >
                  <input type="hidden" name="asisteidenti" id="asisteidenti" value="" >
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
        llaves = 'encuencodigo='+document.getElementById('encuencodigos').value+',';
        llaves+= 'codtipoidentidad='+document.getElementById('codtipoidentidads').value+',';
        llaves+= 'asisteidenti='+document.getElementById('asisteidentis').value;
        validarLlave('asistentesreunion',llaves);
    }
    
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=asistentesreunion&";
        url = url + "campos=encuencodigo,codtipoidentidad,asisteidenti,asispertprog,codunifami&";
        url = url + "campoLlave=encuencodigo,codtipoidentidad,asisteidenti";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>