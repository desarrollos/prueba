<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<%@ taglib prefix="jsp2" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>

<html>
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
            var cajas = null;
            var combos = null;
                      
            //validar
            var arrayNonulos               = null;
            var arrayNumerosEnteros        = null;
            var arrayCombos                = null;
            var arrayCadenasANCod          = null;
            var arrayCadenasA              = null;
            var arrayComentarios           = null;
            var arrayNumerosDoubles        = null;
            
	</script>
</head>
<body bgcolor="#FFFFFF" onLoad="borrarMensaje(cajas[0]);">
<center>
<table id="Table_01" width="906" style="height: 780; border: 0px" cellpadding="0" cellspacing="0">
<tr>
    <td colspan="3">
        <img src="../images/cabezote.png" width="906" height="150" alt="" />
    </td>
</tr>
<%-- Datos sesion --%>
<tr valign="top">
    <td colspan="3" width="906" height="16" style="background: url('../images/panel_02.gif')" align="right">
        <span class="textoPequeno"><%=request.getSession().getAttribute("nombre")%> <%=request.getSession().getAttribute("apellido")%></span><a href="../logout.jsp"><img src="../images/log_out.png" border="0" alt="Cerrar sesion" width="20" height="20" /></a>
    </td>
</tr>
<%-- Datos sesion --%>
<tr>
    <td width="234" height="529" valign="top" style="background: url('../images/back.png')">
        <table cellpadding="0" cellspacing="0">
            <tr>
                <td align="left" valign="top">
                    <table border="0">
                        <tr>
                            <td>
                                <font size="-2"><a style="font-size:7pt;text-decoration:none;color:silver" href="http://www.treemenu.net/" target="_blank">Javascript Tree Menu</a></font>
                            </td>
                        </tr>
                    </table>
                     <span class="TreeviewSpanArea">

                     <script type="text/javascript">
				 initializeDocument();
                         </script> 
                     </span>
                </td>
            </tr>
        </table>
    </td>
    <td valign="top">
        
        <center>
            <c:if test="${param.llave != null}">
            <sql:query var="r" sql="SELECT * FROM novedadcampo WHERE idusuario='${param.llave}'" dataSource="jdbc/delphos" scope="page"/>
            </c:if>
            <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
              <c:set var="idusuario" value="${fila.idusuario}"/>
              <c:set var="codtiponovedad" value="${fila.codtiponovedad}"/>
              <c:set var="codcampoarchivo" value="${fila.codcampoarchivo}"/>
              <c:set var="fecha" value="${fila.fecha}"/>
              <c:set var="datoanterior" value="${fila.datoanterior}"/>              
              <c:set var="datoactualizado" value="${fila.datoactualizado}"/> 
              <c:set var="observacion" value="${fila.observacion}"/>
            </jsp2:forEach>
                
                <table width="662" border="0" class="tablaContenido">
				<form action="PagosContrato.jsp" method="post" name="formulario">
                  <tr>
                    <td colspan="5"><div align="center" class="titulo1">Novedad RIPS Dato</div></td>
                  </tr>
                  <tr>
                    <td colspan="5">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="120" class="bgDescTablas"><strong>Id. Usuario</strong></td>
                    <td width="174" class="sinBgDescTablas"><label>
                    <select name="idusuario" id="idusuario">
                      <option value=" " selected="selected"> </option>
                      <sql:query var="r" sql="select idusuario from poblacion" dataSource="jdbc/delphos" scope="page"/>
                      <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                        <option value="${fila.idusuario}">${fila.idusuario}</option>
                      </jsp2:forEach>
                    </select>
                    </label></td>
                    <td width="3">&nbsp;</td>
                    <td width="115" class="bgDescTablas"><strong>Tipo Novedad</strong></td>
                    <td width="226" class="sinBgDescTablas"><label>
                        <select name="codtiponovedad" id="codtiponovedad">
                        <option value=" " selected="selected"> </option>
                      <sql:query var="r" sql="select codtiponovedad, descripcion from tiponovedad" dataSource="jdbc/delphos" scope="page"/>
                      <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                        <option value="${fila.codtiponovedad}">${fila.descripcion}</option>
                      </jsp2:forEach>
                    </select>
                    </select>
                    </label></td>
                  </tr>
                  <tr>
                    <td colspan="5">&nbsp;</td>
                  </tr>
                  <tr>
                    <td><strong class="bgDescTablas">Campo Archivo</strong></td>
                    <td><label>
                    <select name="codcampoarchivo" id="codcampoarchivo">
                      <option value=" " selected="selected"> </option>
                      <sql:query var="r" sql="select codcampoarchivo, descripcion from listacamposarchivo" dataSource="jdbc/delphos" scope="page"/>
                      <jsp2:forEach items="${r.rows}" var="fila" varStatus="contador">
                        <option value="${fila.codcampoarchivo}">${fila.descripcion}</option>
                      </jsp2:forEach>
                    </select>
                    </label></td>
                    <td>&nbsp;</td>
                    <td><strong class="bgDescTablas">Fecha</strong></td>
                    <td><input type="text" size="10" name="fecha" id="fecha" readonly="true" />
                      <input name="botonFecha" type="button" id="botonFecha" value="..." /></td>
                  </tr>
                  <tr>
                    <td colspan="5">&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="5"><p align="center" class="bgDescTablas"><strong>Dato Anterior</strong></p>
                    <p align="center">
                      <label>
                      <textarea name="datoanterior" id="datoanterior" cols="75" rows="3"></textarea>
                      </label>
                    </p></td>
                  </tr>
                  <tr>
                    <td colspan="5"><p align="center" class="bgDescTablas"><strong>Dato Actualizado</strong></p>
                      <p align="center">
                        <label>
                        <textarea name="datoactualizado" id="datoactualizado" cols="75" rows="3"></textarea>
                        </label>
                      </p></td>
                  </tr>
                  <tr>
                    <td colspan="5" class="bgDescTablas"><p align="center" class="bgDescTablas"><strong>Observaciones</strong></p>
                      <p align="center">
                        <label>
                        <textarea name="observacion" id="observacion" cols="75" rows="3"></textarea>
                        </label>
                      </p></td>
                  </tr>
             <tr>
                <td colspan="3"><div align="center">
                  <input type="hidden" name="llave" id="llave" value="" >
                  <input type="hidden" name="hacerSubmit" id="hacerSubmit" value="0">
                  <input type="hidden" name="valpk" id="valpk" value="0">
                  <input type="button" onClick="buscar();" value="Buscar" tabindex="6">
		  <label>&nbsp;</label>
                  <input type="button" id="guardar2" name="guardar2" onClick="accion(1);" value="Guardar" tabindex="3" />
                  <input type="button" id="editar" name="editar" onClick="accion(2);" value="Actualizar" tabindex="4"/>
                  <input type="button" id="eliminar" name="eliminar" onClick="accion(3);" value="Eliminar" tabindex="5"/>
               </div>
            </td>
           </tr>
	</form>
       </table>
     </center>
        
    </td>
</tr>
<tr>
    <td colspan="3">
        <img src="../images/panel_06.gif" width="906" height="1" alt="">
    </td>
</tr>
<tr>
    <td height="42" colspan="3">
        <img src="../images/panel_07.gif" width="906" height="23" alt="">    </td>
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
        llaves = 'codactividadeconomica='+document.getElementById('codactividadeconomica').value;
        validarLlave('actividadeconomica',llaves);
    } 
    
    function buscar()
    {
        var url;
        url = "BuscadorPrueba.jsp?";
        url = url + "tabla=novedadcampo&";
        url = url + "campos=idusuario,codtiponovedad,codcampoarchivo,fecha,datoanterior,datoactualizado&";
        url = url + "campoLlave=idusuario";
        
        window.open(url,"_blank","width=750,height=500,scrollbars=1,left=350,top=100");
    }

</script>
</body>
</html>