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
		 Calendar.setup({inputField : "viointfecsuc",ifFormat : "%d/%m/%Y",button : "botonviointfecsuc"});
	    }
			
			//totalidad de elementos en el form
            var cajas = new Array('viointid','viointfecsuc','viointidenti','viointautori','viointideden','viointnombre','viointapelli','violidengen1','violnombre1','violapellid1','violidengen2','violnombre2','violapellid2','violarchivo','violrelato','violobservac');
            var combos = new Array('codtipoidentidadpe','tipviocodigo','codtipoidentidadde','codtipoidentidadg1','codtipoidentidad');
			
            var arrayNonulos               	= new Array('viointid');
            var arrayNumerosEnteros        	= new Array('viointid');
            var arrayCombos               	= new Array('codtipoidentidadpe','tipviocodigo');
            var arrayCadenasANCod          	= new Array('viointidenti','viointideden','violidengen1','violidengen2');
            var arrayCadenasA              	= new Array('viointautori','viointnombre','viointapelli','violnombre1','violapellid1','violnombre2','violapellid2');
            var arrayComentarios           	= new Array('violarchivo','violrelato','violobservac');
            var arrayNumerosDoubles        	= null;
</script>
</head>
<body bgcolor="#FFFFFF" onLoad="borrarMensaje(cajas[0]);">
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
    <c:if test='${param.llave != null && param.llave !=""}'>
            <sql:query var="r" sql="SELECT * FROM violenciaintrafamiliar WHERE viointid=${param.llave}" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="viointid" value="${fila.viointid}"/>
              <c:set var="codtipoidentidadpe" value="${fila.codtipoidentidadpe}"/>
              <c:set var="viointidenti" value="${fila.viointidenti}"/>
              <fmt:formatDate value="${fila.viointfecsuc}" pattern="dd/MM/yyyy" var="viointfecsuc"/>              
              <c:set var="tipviocodigo" value="${fila.tipviocodigo}"/>
              <c:set var="viointdenunc" value="${fila.viointdenunc}"/>
              <c:set var="viointautori" value="${fila.viointautori}"/>
              <c:set var="codtipoidentidadde" value="${fila.codtipoidentidadde}"/>               
              <c:set var="viointideden" value="${fila.viointideden}"/>
              <c:set var="viointapelli" value="${fila.viointapelli}"/>
              <c:set var="viointnombre" value="${fila.viointnombre}"/>
              <c:set var="codtipoidentidadg1" value="${fila.codtipoidentidadg1}"/>
              <c:set var="violidengen1" value="${fila.violidengen1}"/>
              <c:set var="violapellid1" value="${fila.violapellid1}"/>
              <c:set var="violnombre1" value="${fila.violnombre1}"/>
              <c:set var="codtipoidentidad" value="${fila.codtipoidentidad}"/> 
              <c:set var="violidengen2" value="${fila.violidengen2}"/>
              <c:set var="violapellid2" value="${fila.violapellid2}"/>
              <c:set var="violnombre2" value="${fila.violnombre2}"/>
              <c:set var="violrelato" value="${fila.violrelato}"/>
              <c:set var="violarchivo" value="${fila.violarchivo}"/>
              <c:set var="violobservac" value="${fila.violobservac}"/>
              
              <%--Carga del archivo de la base de datos---------------------%>
              <%
              String ruta = request.getSession().getServletContext().getRealPath("temp")+"\\";
              ruta = ruta.replaceAll("\\\\","/");
              pageContext.setAttribute("ruta",ruta);
              %>
              <sql:query var="r" sql="select lo_export(violenciaintrafamiliar.archivofi, '${ruta}${violarchivo}') from violenciaintrafamiliar where viointid=${param.llave}" dataSource="jdbc/delphos" scope="page"/>
              <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <%------------------------------------------------------------%>
              </jsp2:forEach>
              <%------------------------------------------------------------%>
              
            </jsp2:forEach>
  <form name="formulario" method="post" action="RegistroAccionViolencia.jsp">
  <table width="811" border="0" class="tablaContenido">
      <span id="mensajeControlador">${msj}</span>

  <tr>
    <td colspan="6"><div align="center"><span class="titulo1">Registro Acci&oacute;n Violencia</span></div></td>
    </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td width="24">&nbsp;</td>
    <td width="140"><span class="bgDescTablas" style="width: 20%"><strong>Id. Registro</strong></span></td>
    <td width="151"><span class="sinBgDescTablas" style="width: 60%">
      <input name="viointid" type="text" id="viointid" value="${viointid}" size="20" maxlength="9" onkeypress="javascript:return permite(event, 'nume')"/>
    </span></td>
    <td width="14">&nbsp;</td>
    <td width="137"><span class="bgDescTablas" style="width: 7%"><strong>Fecha Suceso</strong></span></td>
    <td width="176"><span class="sinBgDescTablas" style="width: 20%">
                  <input name="viointfecsuc" type="text" id="viointfecsuc"  value="${viointfecsuc}" size="15" maxlength="19" readonly="readonly"/>
                  <span class="sinBgDescTablas" style="width: 20%">
                  <input name="botonviointfecsuc" type="button" id="botonviointfecsuc" value="..." />
                </span></span></td>
  </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td>&nbsp;</td>
    <td><span class="bgDescTablas" style="width: 20%"><strong>Tipo Id.</strong></span></td>
    <td><span class="sinBgDescTablas" style="width: 20%">
      <select name="codtipoidentidadpe" id="codtipoidentidadpe" style="width: 150px">
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
      </select>
    </span></td>
    <td>&nbsp;</td>
    <td><span class="bgDescTablas" style="width: 20%"><strong>Id. Persona Afectada</strong></span></td>
    <td><span class="sinBgDescTablas" style="width: 20%">
      <input name="viointidenti" type="text" id="viointidenti" value="${viointidenti}" size="20" maxlength="18" onkeypress="javascript:return permite(event, 'num_car_cod')"/>
    </span></td>
  </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td>&nbsp;</td>
    <td><span class="bgDescTablas" style="width: 20%"><strong>Tipo Violencia</strong></span></td>
    <td><span class="sinBgDescTablas" style="width: 20%"><span class="sinBgDescTablas" style="width: 20%"><span class="sinBgDescTablas" style="width: 20%"><span class="sinBgDescTablas" style="width: 20%">
      <select name="tipviocodigo" id="tipviocodigo" style="width: 150px">
        <option id="tipviocodigo" value=""></option>
        <sql:query var="r" sql="select tipviocodigo, tipviodescri from tipoviolencia" dataSource="jdbc/delphos" scope="page"/>
        <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
          <c:choose>
            <c:when test='${fila.tipviocodigo == tipviocodigo}'>
              <option value="${fila.tipviocodigo}" selected="selected">${fila.tipviodescri}</option>
            </c:when>
            <c:otherwise>
              <option value="${fila.tipviocodigo}">${fila.tipviodescri}</option>
            </c:otherwise>
          </c:choose>
        </jsp2:forEach>
      </select>
    </span></span></span></span></td>
    <td>&nbsp;</td>
    <td><span class="bgDescTablas" style="width: 20%"><strong>Denunc&iacute;o la accion</strong></span></td>
    <td><span class="bgDescTablas" style="width: 20%"><strong><c:choose>
                            <c:when test = '${viointdenunc == "S"}'>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="viointdenunc" value="S" id="viointdenunc_0" checked="true"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="viointdenunc" value="N" id="viointdenunc_1" />
                                    </span>                                </label>
                            </c:when>
                            <c:otherwise>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="viointdenunc" value="S" id="viointdenunc_0"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="viointdenunc" value="N" id="viointdenunc_1" checked="true"/>
                                    </span>                                </label>
                            </c:otherwise>
                        </c:choose>
    </strong></span></td>
  </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td>&nbsp;</td>
    <td><span class="bgDescTablas" style="width: 20%"><strong>Autoridad  donde acudio</strong></span></td>
    <td colspan="4"><span class="sinBgDescTablas" style="width: 20%">
      <input name="viointautori" type="text" id="viointautori" value="${viointautori}" size="20" maxlength="10" onkeypress="javascript:return permite(event, 'carac')"/>
    </span></td>
    </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td>&nbsp;</td>
    <td><span class="bgDescTablas" style="width: 20%"><strong>Tipo Id.</strong></span></td>
    <td><span class="sinBgDescTablas" style="width: 20%">
      <select name="codtipoidentidadde" id="codtipoidentidadde" style="width: 150px">
         <option id="codtipoidentidadde" value=""></option>
          <sql:query var="r" sql="select codtipoidentidad, descripcion from tipoidentificacion" dataSource="jdbc/delphos" scope="page"/>
          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
           <c:choose>
                <c:when test='${fila.codtipoidentidad == codtipoidentidadde}'>
                <option value="${fila.codtipoidentidad}" selected="selected">${fila.descripcion}</option>
                </c:when>
            <c:otherwise>
                <option value="${fila.codtipoidentidad}">${fila.descripcion}</option>
            </c:otherwise>
           </c:choose>
         </jsp2:forEach>
      </select>
    </span></td>
    <td>&nbsp;</td>
    <td><span class="bgDescTablas" style="width: 20%"><strong>Id. denunciante</strong></span></td>
    <td><span class="sinBgDescTablas" style="width: 20%">
      <input name="viointideden" type="text" id="viointideden" value="${viointideden}" size="20" maxlength="19" onkeypress="javascript:return permite(event, 'num_car_cod')"/>
    </span></td>
  </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td>&nbsp;</td>
    <td><strong class="bgDescTablas">Nombres</strong></td>
    <td><span class="sinBgDescTablas" style="width: 20%">
      <input name="viointnombre" type="text" id="viointnombre" value="${viointnombre}" size="20" maxlength="40" onkeypress="javascript:return permite(event, 'carac')"/>
    </span></td>
    <td>&nbsp;</td>
    <td><strong class="bgDescTablas">Apellidos</strong></td>
    <td><span class="sinBgDescTablas" style="width: 20%">
      <input name="viointapelli" type="text" id="viointapelli" value="${viointapelli}" size="20" maxlength="40" onkeypress="javascript:return permite(event, 'carac')"/>
    </span></td>
  </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td>&nbsp;</td>
    <td><span class="bgDescTablas" style="width: 20%"><strong>Tipo Id. denunciado</strong></span></td>
    <td><span class="sinBgDescTablas" style="width: 20%">
      <select name="codtipoidentidadg1" id="codtipoidentidadg1" style="width: 150px">
         <option id="codtipoidentidadg1" value=""></option>
          <sql:query var="r" sql="select codtipoidentidad, descripcion from tipoidentificacion" dataSource="jdbc/delphos" scope="page"/>
          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
           <c:choose>
                <c:when test='${fila.codtipoidentidad == codtipoidentidadg1}'>
                <option value="${fila.codtipoidentidad}" selected="selected">${fila.descripcion}</option>
                </c:when>
            <c:otherwise>
                <option value="${fila.codtipoidentidad}">${fila.descripcion}</option>
            </c:otherwise>
           </c:choose>
         </jsp2:forEach>
      </select>
    </span></td>
    <td>&nbsp;</td>
    <td><span class="bgDescTablas" style="width: 20%"><strong>Identificaci&oacute;n denunciado 1 </strong></span></td>
    <td><span class="sinBgDescTablas" style="width: 20%">
      <input name="violidengen1" type="text" id="violidengen1" value="${violidengen1}" size="20" maxlength="18" onkeypress="javascript:return permite(event, 'num_car_cod')"/>
    </span></td>
  </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td>&nbsp;</td>
    <td><strong class="bgDescTablas">Nombres</strong></td>
    <td><span class="sinBgDescTablas" style="width: 20%">
      <input name="violnombre1" type="text" id="violnombre1" value="${violnombre1}" size="20" maxlength="40" onkeypress="javascript:return permite(event, 'carac')"/>
    </span></td>
    <td>&nbsp;</td>
    <td><strong class="bgDescTablas">Apellidos</strong></td>
    <td><span class="sinBgDescTablas" style="width: 20%">
      <input name="violapellid1" type="text" id="violapellid1" value="${violapellid1}" size="20" maxlength="40" onkeypress="javascript:return permite(event, 'carac')"/>
    </span></td>
  </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td>&nbsp;</td>
    <td><span class="bgDescTablas" style="width: 20%"><strong>Tipo Id. denunciado</strong></span></td>
    <td><span class="sinBgDescTablas" style="width: 20%">
      <select name="codtipoidentidad" id="codtipoidentidad" style="width: 150px">
         <option id="codtipoidentidad" value=""></option>
          <sql:query var="r" sql="select codtipoidentidad, descripcion from tipoidentificacion" dataSource="jdbc/delphos" scope="page"/>
          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
           <c:choose>
                <c:when test='${fila.codtipoidentidad == codtipoidentidad}'>
                <option value="${fila.codtipoidentidad}" selected="selected">${fila.descripcion}</option>
                </c:when>
            <c:otherwise>
                <option value="${fila.codtipoidentidad}">${fila.descripcion}</option>
            </c:otherwise>
           </c:choose>
         </jsp2:forEach>
      </select>
    </span></td>
    <td>&nbsp;</td>
    <td><span class="bgDescTablas" style="width: 20%"><strong>Identificaci&oacute;n denunciado 2 </strong></span></td>
    <td><span class="sinBgDescTablas" style="width: 20%">
      <input name="violidengen2" type="text" id="violidengen2" value="${violidengen2}" size="20" maxlength="18" onkeypress="javascript:return permite(event, 'num_car_cod')"/>
    </span></td>
  </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td>&nbsp;</td>
    <td><strong class="bgDescTablas">Nombres</strong></td>
    <td><span class="sinBgDescTablas" style="width: 20%">
      <input name="violnombre2" type="text" id="violnombre2" value="${violnombre2}" size="20" maxlength="40" onkeypress="javascript:return permite(event, 'carac')"/>
    </span></td>
    <td>&nbsp;</td>
    <td><strong class="bgDescTablas">Apellidos</strong></td>
    <td><span class="sinBgDescTablas" style="width: 20%">
      <input name="violapellid2" type="text" id="violapellid2" value="${violapellid2}" size="20" maxlength="40" onkeypress="javascript:return permite(event, 'carac')"/>
    </span></td>
  </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
  <td>&nbsp;</td>
    <td><span class="bgDescTablas"><strong>Documento Denuncio o Queja</strong></span></td>
      <td><span class="sinBgDescTablas" style="width: 20%">
                  <input name="violarchivo" type="text" id="violarchivo" size="15"  value="${violarchivo}" readonly/><a href="#" onClick="abrirCargaArchivo();"><img src="../images/Buscar16x16.gif" alt="Cargar Archivo" border="0"/></a>
                  <c:if test='${violarchivo != null && violarchivo != ""}'>
                      <br><a href="../temp/${violarchivo}" target="_blank">Descargar ${violarchivo}</a>                  </c:if>
                </span></td>
  </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="6"><p align="center" class="bgDescTablas"><strong>Relato de la Acci&oacute;n de Violencia</strong></p>
      <p align="center"><strong><span class="sinBgDescTablas" style="width: 60%; height: 85px">
        <textarea name="violrelato" cols="75" rows="3" id="violrelato" onkeypress="javascript:return permite(event, 'com')">${violrelato}</textarea>
        </span></strong></p></td>
  </tr>
  <tr>
    <td colspan="6"><p align="center"><strong><span class="bgDescTablas" style="width: 20%; height: 85px"><strong>Observaciones</strong></span></strong></p>
      <p align="center"> <span class="sinBgDescTablas" style="width: 60%; height: 85px">
        <textarea cols="75" rows="3" name="violobservac" id="violobservac" onkeypress="javascript:return permite(event, 'com')">${violobservac}</textarea>
        </span></p></td>
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
        <jsp:include page="../footer.jsp" />   </td>
</tr>
</table>
</center>
<!-- End ImageReady Slices -->
<script>
    
    configurar();
    
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
        llaves= 'viointid='+document.getElementById('viointid').value;
        validarLlave('violenciaintrafamiliar',llaves);
    }
        
    function abrirCargaArchivo()
    {
        var url;
        url = "PopUpCargaArchivo.jsp?";
        url = url + "campo=violarchivo";
        
        window.open(url,"_blank","width=500,height=190,scrollbars=1,left=350,top=100");
    }
    
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=violenciaintrafamiliar&";
        url = url + "campos=viointid,codtipoidentidadpe,viointidenti,viointfecsuc,tipviocodigo,viointdenunc,viointautori,codtipoidentidadde&";
        url = url + "campoLlave=viointid";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>