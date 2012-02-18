<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<%@ taglib prefix="jsp2" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>

<html>
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
        <script type="text/javascript" src="../js/treeview/ua.js"></script>
        <script type="text/javascript" src="../js/treeview/ftiens4.js"></script>

        <script type="text/javascript" src="../js/treeview/demoFramelessNodes.js"></script>
        
        <script type="text/javascript" src="../js/pestanas/animatedcollapse.js"></script>
        <script type="text/javascript" src="../js/validaciones/validador.js"></script>
        <script type="text/javascript" src="../js/validaciones/validadorkp.js"></script>
        <script type="text/javascript" src="../js/validaciones/validadorcontrol.js"></script>
        <script type="text/javascript">
            
            //totalidad de elementos en el form
            var cajas = new Array('codcuentacontable','descripcion');
            var combos = new Array('codgrupocuencontab','codtipocuentacontable','codestadocuencontab','coddisponibcuencontab','codnaturacuencontab');
            
            //validar
            var arrayNonulos               	= new Array('codcuentacontable');
            var arrayNumerosEnteros        	= null;
            var arrayCombos               	= new Array('codgrupocuencontab','codtipocuentacontable','codestadocuencontab','coddisponibcuencontab','codnaturacuencontab');
            var arrayCadenasANCod          	= new Array('codcuentacontable');
            var arrayCadenasA              	= null;
            var arrayComentarios           	= new Array('descripcion');
            var arrayNumerosDoubles             = null;
            
	</script>
        <style type="text/css">
<!--
.style1 {font-weight: bold}
-->
        </style>
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
            <c:if test="${param.llave != null}">
            <sql:query var="r" sql="SELECT * FROM cuentacontable WHERE codcuentacontable='${param.llave}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="codcuentacontable" value="${fila.codcuentacontable}"/>
              <c:set var="descripcion" value="${fila.descripcion}"/>
              <c:set var="codgrupocuencontab" value="${fila.codgrupocuencontab}"/>
              <c:set var="codtipocuentacontable" value="${fila.codtipocuentacontable}"/>      
              <c:set var="tercero" value="${fila.tercero}"/>  
              <c:set var="movimiento" value="${fila.movimiento}"/>  
              <c:set var="codestadocuencontab" value="${fila.codestadocuencontab}"/>  
              <c:set var="coddisponibcuencontab" value="${fila.coddisponibcuencontab}"/>  
              <c:set var="codnaturacuencontab" value="${fila.codnaturacuencontab}"/>      
            </jsp2:forEach>
          <table width="819" border="0" class="tablaContenido">
            <form name="formulario" id="formulario" method="post" action="CuentaContable.jsp">
              <span id="mensajeControlador">${msj}</span>
              <tr>
                <td colspan="6"><div align="center" class="titulo1">Cuenta Contable</div></td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td width="30" class="bgDescTablas">&nbsp;</td>
                <td width="147" class="bgDescTablas"><strong>C&oacute;digo Cuenta Contable</strong></td>
                <td width="182"><input name="codcuentacontable" type="text" id="codcuentacontable" value="${codcuentacontable}" size="20" maxlength="20" onKeyPress="javascript:return permite(event, 'num_car_cod')" tabindex="1"></td>
                <td width="11">&nbsp;</td>
                <td width="132" class="bgDescTablas"><strong>Grupo Cuenta Contable</strong></td>
                <td width="174"><label>
                  <select name="codgrupocuencontab" id="codgrupocuencontab" style="width: 150px" tabindex="2">
                  <option id="codgrupocuencontab" value=""></option>
                  <sql:query var="r" sql="select codgrupocuencontab, descripcion from grupocuentacontable" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                   <c:choose>
                        <c:when test='${fila.codgrupocuencontab == codgrupocuencontab}'>
                        <option value="${fila.codgrupocuencontab}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                    <c:otherwise>
                        <option value="${fila.codgrupocuencontab}">${fila.descripcion}</option>
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
                <td class="bgDescTablas"><span class="style1">
                  <label>Tipo Cuenta Contable</label>
                </span></td>
                <td class="bgDescTablas">
                <select name="codtipocuentacontable" id="codtipocuentacontable" style="width: 150px" tabindex="3">
                  <option id="codtipocuentacontable" value=""></option>
                  <sql:query var="r" sql="select codtipocuentacontable, descripcion from tipocuentacontable" dataSource="jdbc/delphos" scope="page"/>
                  <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                    <c:choose>
                      <c:when test='${fila.codtipocuentacontable == codtipocuentacontable}'>
                        <option value="${fila.codtipocuentacontable}" selected="selected">${fila.descripcion}</option>
                      </c:when>
                      <c:otherwise>
                        <option value="${fila.codtipocuentacontable}">${fila.descripcion}</option>
                      </c:otherwise>
                    </c:choose>
                  </jsp2:forEach>
                </select></td>
                <td class="bgDescTablas">&nbsp;</td>
                <td class="bgDescTablas"><strong>Maneja Terceros</strong>
                  <label></label></td>
                <td class="bgDescTablas">
                      <c:choose>
                            <c:when test = '${tercero == "S"}'>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="tercero" value="S" id="tercero_0" checked="true" tabindex="4"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="tercero" value="N" id="tercero_1" tabindex="4"/>
                                    </span>                                </label>
                            </c:when>
                            <c:otherwise>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="tercero" value="S" id="tercero_0" tabindex="4"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="tercero" value="N" id="tercero_1" checked="true" tabindex="4"/>
                                    </span>                                </label>
                            </c:otherwise>
                        </c:choose>                    </td>
              </tr>
              <tr>
                <td colspan="6">&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">Es de Movimiento</strong></td>
                <td><span class="bgDescTablas">
                         <c:choose>
                            <c:when test = '${movimiento == "S"}'>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="movimiento" value="S" id="movimiento_0" checked="true" tabindex="5"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="movimiento" value="N" id="movimiento_1" tabindex="5"/>
                                    </span>                                </label>
                            </c:when>
                            <c:otherwise>
                                <label>
                                    <span class="descCampoForm">Si
                                        <input type="radio" name="movimiento" value="S" id="movimiento_0" tabindex="5"/>
                                    </span>                                </label> 
                                <label>
                                    <span class="descCampoForm">No
                                        <input type="radio" name="movimiento" value="N" id="movimiento_1" checked="true" tabindex="5"/>
                                    </span>                                </label>
                            </c:otherwise>
                        </c:choose>
                  </span></td>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">Estado Cuenta Contable</strong></td>
                <td><span class="bgDescTablas">
                  <select name="codestadocuencontab" id="codestadocuencontab" style="width: 150px" tabindex="6">
                    <option id="codestadocuencontab" value=""></option>
                    <sql:query var="r" sql="select codestadocuencontab, descripcion from estadocuentacontable" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.codestadocuencontab == codestadocuencontab}'>
                          <option value="${fila.codestadocuencontab}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.codestadocuencontab}">${fila.descripcion}</option>
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
                <td><strong class="bgDescTablas">Disponibilidad Cuenta Contable</strong></td>
                <td><span class="bgDescTablas">
                  <select name="coddisponibcuencontab" id="coddisponibcuencontab" style="width: 150px" tabindex="7">
                    <option id="coddisponibcuencontab" value=""></option>
                    <sql:query var="r" sql="select coddisponibcuencontab, descripcion from disponibcuentacontable" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.coddisponibcuencontab == coddisponibcuencontab}'>
                          <option value="${fila.coddisponibcuencontab}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.coddisponibcuencontab}">${fila.descripcion}</option>
                        </c:otherwise>
                      </c:choose>
                    </jsp2:forEach>
                  </select>
                </span></td>
                <td>&nbsp;</td>
                <td><strong class="bgDescTablas">Naturaleza Cuenta Contable</strong></td>
                <td><span class="bgDescTablas">
                  <select name="codnaturacuencontab" id="codnaturacuencontab" style="width: 150px" tabindex="8">
                    <option id="codnaturacuencontab" value=""></option>
                    <sql:query var="r" sql="select codnaturacuencontab, descripcion from naturalezacuentacontable" dataSource="jdbc/delphos" scope="page"/>
                    <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                      <c:choose>
                        <c:when test='${fila.codnaturacuencontab == codnaturacuencontab}'>
                          <option value="${fila.codnaturacuencontab}" selected="selected">${fila.descripcion}</option>
                        </c:when>
                        <c:otherwise>
                          <option value="${fila.codnaturacuencontab}">${fila.descripcion}</option>
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
                <td colspan="6"><p align="center"><strong class="bgDescTablas">Descripci&oacute;n</strong></p>
                <p align="center"><strong>
                  <label>
                  <input name="descripcion" type="text" id="descripcion" value="${descripcion}" size="75" maxlength="60" onKeyPress="javascript:return permite(event, 'com')" tabindex="9">
                  </label>
                </strong></p></td>
              </tr>
              <tr>
                <td colspan="6"><div align="center">
                  <input type="hidden" name="llave" id="llave" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <!--<input type="button" onClick="buscar();" value="Buscar" tabindex="13"> -->
		  <label>&nbsp;</label>
                  <!--<input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="10"/>
                  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="11"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="12"/> -->
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
        llaves = 'codcuentacontable='+document.getElementById('codcuentacontable').value;
        //llaves+= 'codmunicipio='+document.getElementById('codmunicipio').value+',';
        validarLlave('cuentacontable',llaves);
    } 
    
    //
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=cuentacontable&";
        url = url + "campos=codcuentacontable,descripcion,codgrupocuencontab,codtipocuentacontable,tercero,movimiento,codestadocuencontab,coddisponibcuencontab&";
        url = url + "campoLlave=codcuentacontable";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>