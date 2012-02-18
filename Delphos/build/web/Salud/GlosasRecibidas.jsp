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
            var cajas = new Array('cantidad','anyos','descripcion','infoadicional','planaccion','observacion');
            var combos = new Array('codindiceglosaarcafis','mess');
                      
            //validar
            var arrayNonulos               = new Array('anyos');
            var arrayNumerosEnteros        = new Array('anyos','cantidad');
            var arrayCombos                = new Array('codindiceglosaarcafis','mess');
            var arrayCadenasANCod          = null;
            var arrayCadenasA              = null;
            var arrayComentarios           = new Array('descripcion','infoadicional','planaccion','observacion');
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
            <c:if test='${param.codindiceglosaarcafi != null && param.codclaseglosaafil != null && param.codtipoglosaarchafil != null && param.anyo != null && param.anyo != "" && param.mes != null && param.mes != ""}'>
            <sql:query var="r" sql="SELECT * FROM glosarecarchafil WHERE codindiceglosaarcafi='${param.codindiceglosaarcafi}' AND codclaseglosaafil='${param.codclaseglosaafil}' AND codtipoglosaarchafil='${param.codtipoglosaarchafil}' AND anyo=${param.anyo} AND mes=${param.mes}" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codindiceglosaarcafif" value="${fila.codindiceglosaarcafi}"/>
              <c:set var="codclaseglosaafilf" value="${fila.codclaseglosaafil}"/>
              <c:set var="codtipoglosaarchafilf" value="${fila.codtipoglosaarchafil}"/>
              <c:set var="anyof" value="${fila.anyo}"/>
              <c:set var="mes" value="${fila.mes}"/>             
              <c:set var="descripcion" value="${fila.descripcion}"/>
              <c:set var="cantidad" value="${fila.cantidad}"/>  
              <c:set var="observacion" value="${fila.observacion}"/>
              <c:set var="infoadicional" value="${fila.infoadicional}"/>
              <c:set var="planaccion" value="${fila.planaccion}"/>              
            </jsp2:forEach>
                
                <table width="791" border="0" class="tablaContenido">
                <span id="mensajeControlador">${msj}</span>
				<form action="GlosasRecibidas.jsp" method="post" name="formulario">
                  <tr>
                    <td colspan="6"><div align="center" class="titulo1">Glosas Recibidas</div></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Indice Glosa </strong></td>
                    <td class="bgDescTablas">
                    <select name="codindiceglosaarcafis" id="codindiceglosaarcafis" style="width: 150px">
                  <option id="codindiceglosaarcafis" value=""></option>
                          <sql:query var="r" sql="select codindiceglosaarcafi, codclaseglosaafil, codtipoglosaarchafil, descripcion from indiceglosaarchafil" dataSource="jdbc/delphos" scope="page"/>
                          <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                           <c:choose>
                                <c:when test='${fila.codindiceglosaarcafi == codindiceglosaarcafif && fila.codclaseglosaafil == codclaseglosaafilf && fila.codtipoglosaarchafil == codtipoglosaarchafilf}'>
                                <option value="${fila.codindiceglosaarcafi} ${fila.codclaseglosaafil} ${fila.codtipoglosaarchafil}" selected="selected">${fila.descripcion}</option>
                                </c:when>
                            <c:otherwise>
                                <option value="${fila.codindiceglosaarcafi} ${fila.codclaseglosaafil} ${fila.codtipoglosaarchafil}">${fila.descripcion}</option>
                            </c:otherwise>
                           </c:choose>
                         </jsp2:forEach>
                    </select></td>
                    <td class="bgDescTablas">&nbsp;</td>
                    <td class="bgDescTablas"><strong>Cantidad Glosas</strong></td>
                    <td class="bgDescTablas"><span class="sinBgDescTablas">
                      <input name="cantidad" type="text" id="cantidad" value="${cantidad}" size="20" maxlength="8"/>
                    </span></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="30" class="bgDescTablas">&nbsp;</td>
                    <td width="99" class="bgDescTablas"><strong>Mes</strong></td>
                    <td width="184" class="sinBgDescTablas"><label>
                    <select name="mess" id="mess" style="width: 150px" tabindex="1">
                      <option id="mess" value=""></option>
                      <c:forEach begin="1" end="12" step="1" var="hour" varStatus="status">
                        <c:choose>
                          <c:when test="${(status.count) >= 1 && (status.count) <= 9}">
                            <c:choose>
                              <c:when test="${(status.count) == mes}">
                                <option value="${mes}" selected>${mes}</option>
                              </c:when>
                              <c:otherwise>
                                <option value="0${status.count}">0${status.count}</option>
                              </c:otherwise>
                            </c:choose>
                          </c:when>
                          <c:otherwise>
                            <c:choose>
                              <c:when test="${(status.count) == mes}">
                                <option value="${(status.count)}" selected>${(status.count)}</option>
                              </c:when>
                              <c:otherwise>
                                <option value="${status.count}">${status.count}</option>
                              </c:otherwise>
                            </c:choose>
                          </c:otherwise>
                        </c:choose>
                      </c:forEach>
                    </select>
                    </label></td>
                    <td width="20">&nbsp;</td>
                    <td width="97" class="bgDescTablas"><strong>A&ntilde;o</strong></td>
                    <td width="215" class="sinBgDescTablas"><input name="anyos" type="text" id="anyos" value="${anyof}" size="20" maxlength="4" /></td>
                  </tr>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="6"><p align="center" class="bgDescTablas"><strong>Descripci&oacute;n</strong></p>
                    <p align="center">
                      <label>
                      <textarea name="descripcion" id="descripcion" cols="75" rows="3">${descripcion}</textarea>
                      </label>
                    </p></td>
                  </tr>
                  <tr>
                    <td height="21" colspan="6"><p align="center" class="bgDescTablas"><strong>Informaci&oacute;n Adicional</strong></p>
                      <p align="center"><strong>
                        <label>
                        <textarea name="infoadicional" cols="75" rows="3" id="infoadicional">${infoadicional}</textarea>
                        </label>
                      </strong></p></td>
                  </tr>
                  <tr>
                    <td height="21" colspan="6" class="bgDescTablas"><p align="center"><strong>Plan de Acci&oacute;n</strong></p>
                    <p align="center"><strong>
                      <label>
                      <textarea name="planaccion" cols="75" rows="3" id="planaccion">${planaccion}</textarea>
                      </label>
                    </strong></p></td>
                  </tr>
                  <tr>
                    <td colspan="6"><p align="center" class="bgDescTablas"><strong>Observaciones</strong></p>
                      <p align="center"><strong>
                        <label>
                        <textarea name="observacion" cols="75" rows="3" id="observacion">${observacion}</textarea>
                        </label>
                      </strong></p></td>
                  </tr>
          <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="codindiceglosaarcafi" id="codindiceglosaarcafi" value="" >
                  <input type="hidden" name="codclaseglosaafil" id="codclaseglosaafil" value="" >
                  <input type="hidden" name="codtipoglosaarchafil" id="codtipoglosaarchafil" value="" >
                  <input type="hidden" name="anyo" id="anyo" value="" >
                  <input type="hidden" name="mes" id="mes" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                 <!-- <input type="button" onClick="buscar();" value="Buscar" tabindex="6"> -->
		  <label>&nbsp;</label>
                  <!--<input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="3" />
                  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="4"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="5"/> -->
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
        var cad = document.getElementById('codindiceglosaarcafis').value;
        var cad2 = cad.split(" ");
		
        llaves = 'codindiceglosaarcafi='+cad2[0]+',';
		llaves+= 'codclaseglosaafil='+cad2[1]+',';
		llaves+= 'codtipoglosaarchafil='+cad2[2]+',';
		
		llaves+= 'anyo='+document.getElementById('anyos').value+',';
		llaves+= 'mes='+document.getElementById('mess').value;
        validarLlave('glosarecarchafil',llaves);
    } 
    
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=glosarecarchafil&";
        url = url + "campos=codindiceglosaarcafi,codclaseglosaafil,codtipoglosaarchafil,anyo,mes,descripcion,cantidad&";
        url = url + "campoLlave=codindiceglosaarcafi,codclaseglosaafil,codtipoglosaarchafil,anyo,mes";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>