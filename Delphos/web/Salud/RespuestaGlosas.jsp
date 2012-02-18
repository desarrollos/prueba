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
            var cajas = new Array('consecutivoresps','actividadreal');
            var combos = new Array('codindiceglosaarcafis');
                      
            //validar
            var arrayNonulos               = new Array('consecutivoresps');
            var arrayNumerosEnteros        = new Array('consecutivoresps');
            var arrayCombos                = new Array('codindiceglosaarcafis');
            var arrayCadenasANCod          = null;
            var arrayCadenasA              = null;
            var arrayComentarios           = new Array('actividadreal');
            var arrayNumerosDoubles        = null;
            
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
            <c:if test='${param.consecutivoresp != null && param.consecutivoresp != "" && param.codindiceglosaarcafi != null && param.codclaseglosaafil != null && param.codtipoglosaarchafil != null && param.anyo != null && param.anyo != "" && param.mes != null && param.mes != "" && param.consecutivorecib != null && param.consecutivorecib != ""}'>
            <sql:query var="r" sql="SELECT * FROM detallerespglosa WHERE consecutivoresp=${param.consecutivoresp} AND codindiceglosaarcafi='${param.codindiceglosaarcafi}' AND codclaseglosaafil='${param.codclaseglosaafil}' AND codtipoglosaarchafil='${param.codtipoglosaarchafil}' AND anyo=${param.anyo} AND mes=${param.mes} AND consecutivorecib=${param.consecutivorecib}" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="consecutivorespf" value="${fila.consecutivoresp}"/>
              <c:set var="codindiceglosaarcafif" value="${fila.codindiceglosaarcafi}"/>
              <c:set var="codclaseglosaafilf" value="${fila.codclaseglosaafil}"/>
              <c:set var="codtipoglosaarchafilf" value="${fila.codtipoglosaarchafil}"/>
              <c:set var="anyof" value="${fila.anyo}"/>              
              <c:set var="mesf" value="${fila.mes}"/>
              <c:set var="consecutivorecibf" value="${fila.consecutivorecib}"/>  
              <c:set var="actividadreal" value="${fila.actividadreal}"/>              
            </jsp2:forEach>
                
                <table width="793" border="0" class="tablaContenido">
                <span id="mensajeControlador">${msj}</span>
				<form action="RespuestaGlosas.jsp" method="post" name="formulario">
                  <tr>
                    <td colspan="6"><div align="center" class="titulo1">Respuesta Glosas</div></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="27" class="bgDescTablas">&nbsp;</td>
                    <td width="114" class="bgDescTablas"><strong>Consecutivo</strong></td>
                    <td width="160" class="sinBgDescTablas"><label>
                    <input name="consecutivoresps" type="text" id="consecutivoresps" value="${consecutivorespf}" size="20" maxlength="12" />
                    </label></td>
                    <td width="13">&nbsp;</td>
                    <td width="109" class="bgDescTablas"><strong>Indice Glosa</strong></td>
                  <td width="219" class="sinBgDescTablas"><label>
                      <select name="codindiceglosaarcafis" id="codindiceglosaarcafis" style="width: 150px">
                       <option id="codindiceglosaarcafis" value=""></option>
                          <sql:query var="r" sql="select codindiceglosaarcafi, codclaseglosaafil, codtipoglosaarchafil, anyo, mes, consecutivorecib from detallerecibglosa" dataSource="jdbc/delphos" scope="page"/>
                          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                           <c:choose>
                                <c:when test='${fila.codindiceglosaarcafi == codindiceglosaarcafif && fila.codclaseglosaafil == codclaseglosaafilf && fila.codtipoglosaarchafil == codtipoglosaarchafilf && fila.anyo == anyof && fila.mes == mesf && fila.consecutivorecib == consecutivorecibf}'>
                                <option value="${fila.codindiceglosaarcafi} ${fila.codclaseglosaafil} ${fila.codtipoglosaarchafil} ${fila.anyo} ${fila.mes} ${fila.consecutivorecib}" selected="selected">${fila.codindiceglosaarcafi}</option>
                                </c:when>
                            <c:otherwise>
                                <option value="${fila.codindiceglosaarcafi} ${fila.codclaseglosaafil} ${fila.codtipoglosaarchafil} ${fila.anyo} ${fila.mes} ${fila.consecutivorecib}">${fila.codindiceglosaarcafi}</option>
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
                    <td colspan="6" class="bgDescTablas"><p align="center"><strong>Actividad Realizada</strong></p>
                      <p align="center">
                      <label>
                      <textarea name="actividadreal" id="actividadreal" cols="75" rows="3">${actividadreal}</textarea>
                      </label>
                    </p></td>
                  </tr>
          <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="consecutivoresp" id="consecutivoresp" value="" >
                  <input type="hidden" name="codindiceglosaarcafi" id="codindiceglosaarcafi" value="" >
                  <input type="hidden" name="codclaseglosaafil" id="codclaseglosaafil" value="" >
                  <input type="hidden" name="codtipoglosaarchafil" id="codtipoglosaarchafil" value="" >
                  <input type="hidden" name="anyo" id="anyo" value="" >
                  <input type="hidden" name="mes" id="mes" value="" >
                  <input type="hidden" name="consecutivorecib" id="consecutivorecib" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="6">-->
		  <label>&nbsp;</label>
                  <!--<input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="3" />
                  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="4"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="5"/>-->
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
        llaves = 'consecutivoresp='+document.getElementById('consecutivoresps').value+',';
		
		 var cad = document.getElementById('codindiceglosaarcafis').value;
        var cad2 = cad.split(" ");
		
        llaves+= 'codindiceglosaarcafi='+cad2[0]+',';
		llaves+= 'codclaseglosaafil='+cad2[1]+',';
		llaves+= 'codtipoglosaarchafil='+cad2[2]+',';
		llaves+= 'anyo='+cad2[3]+',';
		llaves+= 'mes='+cad2[4]+',';
		llaves+= 'consecutivorecib='+cad2[5]+',';
		
        validarLlave('detallerespglosa',llaves);
    }
	
	function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=detallerespglosa&";
        url = url + "campos=consecutivoresp,codindiceglosaarcafi,codclaseglosaafil,codtipoglosaarchafil,anyo,mes,consecutivorecib&";
        url = url + "campoLlave=consecutivoresp,codindiceglosaarcafi,codclaseglosaafil,codtipoglosaarchafil,anyo,mes,consecutivorecib";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>