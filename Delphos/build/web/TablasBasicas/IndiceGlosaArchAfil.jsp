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
            
            //totalidad de elementos en el form
            var cajas = new Array('codindiceglosaarcafi','descripcion','quehaceglosa','infoadicional','observacion');
            var combos = new Array('codclaseglosaafil','codtipoglosaarchafil');
			
            var arrayNonulos               	= new Array ('codindiceglosaarcafi');
            var arrayNumerosEnteros        	= null;
            var arrayCombos               	= new Array ('codclaseglosaafil','codtipoglosaarchafil');			
            var arrayCadenasANCod          	= new Array ('codindiceglosaarcafi');
            var arrayCadenasA              	= null;
            var arrayComentarios           	= new Array ('descripcion','quehaceglosa','infoadicional','observacion');
            var arrayNumerosDoubles        	= null;

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
            <sql:query var="r" sql="SELECT * FROM indiceglosaarchafil WHERE codindiceglosaarcafi='${param.llave}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codindiceglosaarcafi" value="${fila.codindiceglosaarcafi}"/>
              <c:set var="codclaseglosaafil" value="${fila.codclaseglosaafil}"/>
              <c:set var="codtipoglosaarchafil" value="${fila.codtipoglosaarchafil}"/> 
              <c:set var="descripcion" value="${fila.descripcion}"/> 
              <c:set var="quehaceglosa" value="${fila.quehaceglosa}"/> 
              <c:set var="infoadicional" value="${fila.infoadicional}"/> 
              <c:set var="observacion" value="${fila.observacion}"/>          
            </jsp2:forEach>
                
                <table width="800" border="0" class="tablaContenido">
		<form name="formulario" id="formulario" method="post" action="IndiceGlosaArchAfil.jsp" >
                  <span id="mensajeControlador">${msj}</span>
                  <tr>
                    <td colspan="6"><div align="center" class="titulo1">Indice Glosa</div></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="30" class="bgDescTablas">&nbsp;</td>
                    <td width="128" class="bgDescTablas">
                        <strong>C&oacute;digo Clase Glosa</strong>
                    </td>
                    <td width="163" class="bgDescTablas">
                        <input name="codindiceglosaarcafi" type="text" id="codindiceglosaarcafi" value="${codindiceglosaarcafi}" size="20" maxlength="6" onkeypress="javascript:return permite(event, 'num_car_cod')" tabindex="1"/>                    
                    </td>
                    <td width="20" class="bgDescTablas">&nbsp;</td>
                    <td width="90" class="bgDescTablas"><strong>Clase Glosa</strong></td>
                    <td width="245" class="bgDescTablas"><label>
                      <select name="codclaseglosaafil" id="codclaseglosaafil" style="width: 150px" tabindex="2">
                          <option id="codclaseglosaafil" value=""></option>
                          <sql:query var="r" sql="select codclaseglosaafil, descripcion from claseglosaafil" dataSource="jdbc/delphos" scope="page"/>
                          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                           <c:choose>
                                <c:when test='${fila.codclaseglosaafil == codclaseglosaafil}'>
                                <option value="${fila.codclaseglosaafil}" selected="selected">${fila.descripcion}</option>
                                </c:when>
                            <c:otherwise>
                                <option value="${fila.codclaseglosaafil}">${fila.descripcion}</option>
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
                    <td class="bgDescTablas"><strong>Tipo Glosa</strong></td>
                    <td colspan="4" class="bgDescTablas"><label>
                      <select name="codtipoglosaarchafil" id="codtipoglosaarchafil" style="width: 150px" tabindex="3">
                          <option id="codtipoglosaarchafil" value=""></option>
                          <sql:query var="r" sql="select codtipoglosaarchafil, descripcion from tipoglosaarchafil" dataSource="jdbc/delphos" scope="page"/>
                          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                           <c:choose>
                                <c:when test='${fila.codtipoglosaarchafil == codtipoglosaarchafil}'>
                                <option value="${fila.codtipoglosaarchafil}" selected="selected">${fila.descripcion}</option>
                                </c:when>
                            <c:otherwise>
                                <option value="${fila.codtipoglosaarchafil}">${fila.descripcion}</option>
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
                    <td colspan="6" class="bgDescTablas"><p align="center"><strong>Descripci&oacute;n</strong></p>
                      <p align="center">
                        <textarea name="descripcion" id="descripcion" cols="75" rows="3" onkeypress="javascript:return permite(event, 'com')" tabindex="4">${descripcion}</textarea>
                      </p>                      </td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas"><p align="center"><strong>Que Hacer con la glosa</strong></p>
                      <p align="center"><strong>
                        <textarea name="quehaceglosa" id="quehaceglosa" cols="75" rows="3" onkeypress="javascript:return permite(event, 'com')" tabindex="5">${quehaceglosa}</textarea>
                      </strong></p></td>
                  </tr>
                  <tr>
                    <td colspan="6" class="bgDescTablas"><p align="center"><strong>Informaci&oacute;n Adicional</strong></p>
                    <p align="center">
                      <label>
                      <textarea name="infoadicional" id="infoadicional" cols="75" rows="3" onkeypress="javascript:return permite(event, 'com')" tabindex="6">${infoadicional}</textarea>
                      </label>
                    </p></td>
                  </tr>
                  <tr>
                    <td colspan="6"><p align="center" class="bgDescTablas"><strong>Observaciones</strong></p>
                      <p align="center" class="bgDescTablas">
                        <label>
                        <textarea name="observacion" id="observacion" cols="75" rows="3" onkeypress="javascript:return permite(event, 'com')" tabindex="7">${observacion}</textarea>
                        </label>
                      </p>                      </td>
                  </tr>
                <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="llave" id="llave" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="11"> -->
		  <label>&nbsp;</label>
                  <!--<input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="8"/>
                  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="9"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="10"/> -->
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
        llaves = 'codindiceglosaarcafi='+document.getElementById('codindiceglosaarcafi').value+',';
		llaves+= 'codclaseglosaafil='+document.getElementById('codclaseglosaafil').value+',';
		llaves+= 'codtipoglosaarchafil='+document.getElementById('codtipoglosaarchafil').value;
        //llaves+= 'codmunicipio='+document.getElementById('codmunicipio').value+',';
        validarLlave('indiceglosaarchafil',llaves);
    } 
    
    //
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=indiceglosaarchafil&";
        url = url + "campos=codindiceglosaarcafi,codclaseglosaafil,codtipoglosaarchafil,descripcion,quehaceglosa,infoadicional,observacion&";
        url = url + "campoLlave=codindiceglosaarcafi";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>