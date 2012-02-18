<%@page contentType="text/html"%>
<%@page pageEncoding="ISO-8859-1"%>

<%@page import="clases.ConexionBaseDatos"%>
<%@page import="clases.UtilidadesDKDA"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.StringTokenizer"%>
<%@ page session="true" %>

<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<%@ taglib prefix="jsp2" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>

<%
    ConexionBaseDatos con;
    con = new ConexionBaseDatos();
    con.abrirConexion();
%>

<html>
    <head><script type="text/javascript" src="../js/jquery/jquery.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Buscar</title>
        <link rel="stylesheet" type="text/css" media="all" href="../css/delphos.css" />
    </head>
    <body>
    <img src="../images/cabezote.png" width="100%" height="110" alt="" />        
    <form name="formBuscar" method="post" action="BuscadorPrueba.jsp" id="formBuscar">
    <%-- ------------------------------------------------------------------------------------ --%>
    <input type="hidden" name="tabla" value="${param.tabla}">
    <input type="hidden" name="campos" value="${param.campos}">
    <input type="hidden" name="campoLlave" value="${param.campoLlave}">
    <input type="hidden" name="hacerSubmit" value="1">
    <input type="hidden" name="exportar" id="exportar" value="NO">
    <input type="hidden" name="reporte" id="reporte" value="NO">
    <%
    int offSet = 0;
    if(request.getParameter("offSet") == null)
        offSet = 0;
    else
        offSet = Integer.parseInt(request.getParameter("offSet"));
    %>
    <input type="hidden" name="offSet" value="<%=offSet%>">
    
    <%-- ------------------------------------------------------------------------------------ --%>
    
    <%
    String sql, where="", tabla, cadenaCampos;
    
    int limite = 20, cantidadRegistros;
    
    cantidadRegistros = 0;
    
    tabla = request.getParameter("tabla");
    cadenaCampos = request.getParameter("campos");

    StringTokenizer tokens = new StringTokenizer(cadenaCampos, ",");
    int nDatos = tokens.countTokens();
    
    String campos[];
    campos = new String[nDatos];

    int i = 0;
    while(tokens.hasMoreTokens())
    {
        campos[i] = tokens.nextToken();
        i++;
    }
    
    sql = "SELECT "+cadenaCampos+" FROM "+tabla;
    
    if(campos.length > 0)
    {
        boolean hechoWhere = false;
        for(i=0; i<nDatos; i++)
        {
            if(request.getParameter(campos[i])!= null && (!request.getParameter(campos[i]).equals("")))
            {
                if(!hechoWhere)
                {
                    where = " WHERE";
                    hechoWhere = true;
                }
                boolean flag = false;
                PreparedStatement pt = null;
                ResultSet rs = null;
                try{
                     pt = con.con.prepareStatement("SELECT " + campos[ i ] + " FROM " + tabla );
                     rs = pt.executeQuery();
                     String tipoDato = rs.getMetaData().getColumnTypeName( 1 );
                     
                     if( tipoDato.equals("int4") || tipoDato.equals("numeric") ) {
                        flag = true;
                     }
                } catch( SQLException sqlE ) {
                    System.out.println( sqlE.getMessage() );
                }

                where = where + " " + campos[i] + ( flag ? " = " : " LIKE '%"  ) + request.getParameter(campos[i])+ ( flag ? "" : "%'" );

                if(hechoWhere)
                    where = where + " AND ";
            }
        }
        
        if(where.length()>3 && where.substring(where.length()-4,where.length()).equals("AND "))
            where = where.substring(0,where.length()-4); 
            
            
        if(request.getParameter("exportar")!= null && request.getParameter("exportar").equals("SI"))
        {
            String nombreArchivo;
            
            nombreArchivo = tabla+request.getSession().getAttribute("login")+UtilidadesDKDA.obtenerFechaActual2()+UtilidadesDKDA.obtenerHoraActual()+".txt";
            nombreArchivo = nombreArchivo.replaceAll(":","");
            
            clases.GenerarArchivoPlano generar;
            generar = new clases.GenerarArchivoPlano();
            generar.generarArchivoPlano(sql+where,nombreArchivo,request);

            String ruta = request.getSession().getServletContext().getRealPath("temp")+"\\";
            ruta = ruta.replaceAll("\\\\","/");
            pageContext.setAttribute("ruta",ruta);
            
            %>
            <script>window.open('../temp/<%=nombreArchivo%>',"blank","width=750,height=500,scrollbars=1,left=350,top=100");</script>
            <%
        }
        
        sql = sql + where + " LIMIT "+limite+" OFFSET "+request.getParameter("offSet");
    }
    %>

    <p class="titulo1">B&uacute;squeda <input type="submit" value="Buscar">
      <script type="text/javascript" src="../js/jquery/jquery.js"></script>
      <script type="text/javascript">
        $(document).ready( function() {
                if( document.getElementById("mostrarGenerarReporte") != null ) {
                    // Cuando hay resultados se cambia el tipo de imagen.
                    $("#imgPdf").attr("src");
                    $("#imgExcel").attr("src");
                    $("#imgPlano").attr("src");
                    $("#imgImprimir").attr("src");
                    return true;
                }   return false;
        });
        
      </script>
      <img src="../images/pdf.gif" id="imgPdf"  alt="Exportar a PDF" width="35" height="35" /><a href="#" onclick="return generarReporte('pdf')">PDF</a>
      <img src="../images/Excel.gif" id="imgExcel" alt="Exportar a Excel" width="35" height="35" /><a href="#" onclick="return generarReporte('excel')"> Excel</a>
      <img src="../images/Plano.gif" id="imgPlano" alt="Exportar a Plano" width="35" height="35" /><a href="#" onclick="return generarReporte('plano')">Plano</a>
      <img src="../images/impresora.gif" id="imgImpresora" alt="Imprimir" width="35" height="35" /><a href="#" onclick="return generarReporte('impresora')">Imprimir</a>
      
    </p>
    <table width="100%" border="0" align="center" id="idTable">
        <tr>
        <%
            for(i=0; i<nDatos; i++)
            {
            %>
            <th bgcolor="#EFEFEF" align="center" scope="col"><span class="bgDescTablas"><%=campos[i].toUpperCase()%></span></th>
            <%
            }
        %>            
            <th bgcolor="#EFEFEF" align="center" scope="col"><span class="">&nbsp;</span></th>
        </tr>
        <tr>
        <%
            for(i=0; i<nDatos; i++)
            {
                String valor = "";
                if(request.getParameter(campos[i])!=null)
                    valor = request.getParameter(campos[i]);
            %>
            <td bgcolor="#EFEFEF" align="center" scope="col"><input type="text" name="<%=campos[i]%>" value="<%=valor%>"></td>
            <%
            }
        %>            
            <td bgcolor="#EFEFEF" align="center" scope="col">&nbsp;</td>
        </tr>
    <%
    if(request.getParameter("hacerSubmit") != null)
    {
    String consulta = "SELECT COUNT(*) FROM "+tabla+where;
    pageContext.setAttribute("where", where);
    PreparedStatement pstmt;
    ResultSet rs;
    

    try
    {
        pstmt = con.con.prepareStatement( consulta );
        rs = pstmt.executeQuery();
        rs.next();
        cantidadRegistros = rs.getInt(1);
        rs.close();
        pstmt.close();
        
        pstmt = con.con.prepareStatement(sql);
        rs = pstmt.executeQuery();
        i = 0;
        
        %>
        
        <tr>
        <%
        String color = "#FFFFFF";
        while(rs.next())
        {
            if(i % 2 ==0)
                color = "#FFFFFF";
            else
                color = "#DDECFE";
                
            for(int j=0; j<nDatos; j++)
            {
        %>
            <td bgcolor="<%=color%>" ><span><%=rs.getString(campos[j])%></span></td>
        <%
            }
            i++;
            
            
            StringTokenizer camposLlave = new StringTokenizer(request.getParameter("campoLlave"), ",");

            String valoresLlaves = "";
            if(camposLlave.countTokens() > 1)
            {

                while(camposLlave.hasMoreTokens())
                {
                    valoresLlaves = valoresLlaves + rs.getString(camposLlave.nextToken()) + ",";
                }
                valoresLlaves = valoresLlaves.substring(0,valoresLlaves.length()-1);
            }
            else
            {
                valoresLlaves = rs.getString(request.getParameter("campoLlave"));
            }
            
        %>
            <td bgcolor="<%=color%>" align="center">
                <button type="button" onclick='seleccionar("<%=valoresLlaves%>");'>
                    <img src="../images/send.gif" alt="" style="vertical-align:middle;" />
                </button>
            </td>
        </tr>
        <%
        }
        rs.close();
        pstmt.close();
        con.cerrarConexion();
    }
    catch(SQLException e)
    {
        con.cerrarConexion();
    }
    }
    %>
    </table>
     
    <%
    if(cantidadRegistros>0)
    {
    %>

    <input type="hidden" id="mostrarGenerarReporte" name="mostrarGenerarReporte" />
    <table width="100%" border="0" align="center">
        <tr bgcolor="#EFEFEF">
            <td align="left">
                <a href="#" onClick="anterior();"><< Anterior</a>
            </td>
            <td align="center">
                <%
                int j, k;
                double iteraciones = Math.ceil(cantidadRegistros / limite) + 1;
                System.out.println("Itereaciones: "+iteraciones);
                System.out.println("Limite: "+limite);
                for(i=0; i< iteraciones; i++)
                {
                    j = i* limite;
                    k = i + 1;
                    %>
                    <a href="#" onClick="irA('<%=j%>')"><%=k%></a>
                    <%
                }
                %>
            </td>
            <td align="right">
                <a href="#" onClick="siguiente();">Siguiente >></a>
            </td>
        </tr>
    </table>
    <%}%>
    <p>&nbsp;</p>
    </form>
        <jsp:include page="../reportes/tablaReportes/tablasBuscar.jsp">
        <jsp:param name="tabla" value="${param.tabla}" />
        <jsp:param name="campos" value="${param.campos}" />
        <jsp:param name="where" value="${where}" />
    </jsp:include>
    <%
        if(request.getParameter("reporte")!= null && request.getParameter("reporte").equals("SI"))
        {
            String consultaReporte;
            consultaReporte = sql.substring(0,sql.indexOf("LIMIT"));
            %>
            <form name="formReporte" action="Reporte.jsp" method="post" target="_blank">
                <input type="hidden" name="consultaSQL" value="<%=consultaReporte%>">
                <input type="hidden" name="nombreTabla" value="<%=tabla%>">
                <input type="hidden" name="camposTabla" value="<%=cadenaCampos%>">
                <input type="hidden" name="camposLlaveTabla" value="${param.campoLlave}">
            </form>
            <script>
                document.formReporte.submit();
                document.getElementById("reporte").value = "NO";
                document.formBuscar.submit();
                
            </script>
            <%
        }
        %>
    </body>
</html>

<script>

function exportarArchivo()
{
    document.getElementById("exportar").value = 'SI';
    document.formBuscar.submit();
}
    
function printit(){  

    document.getElementById("reporte").value = 'SI';
    document.formBuscar.submit();
    //window.print() ;   
}

function exportToXL(eSrc) {
    var oExcel;
    var oExcelSheet;
    var oWkBooks;
    var cols;
    oExcel = new ActiveXObject('Excel.Application');
    oWkBooks = oExcel.Workbooks.Add;
    oExcelSheet = oWkBooks.Worksheets(1);
    oExcelSheet.Activate();
    if (eSrc.tagName != 'TABLE') 
    {
        alert('No ha sido posible exportar la tabla a excell');
        return false;
    }
    cols = Math.ceil(eSrc.cells.length / eSrc.rows.length);
    for (var i = 0; i < eSrc.cells.length; i ++)
    {
        var c, r;
        r = Math.ceil((i+1) / cols);
        c = (i+1)-((r-1)*cols)
        if (eSrc.cells(i).tagName == 'TH') 
        {
            oExcel.ActiveSheet.Cells(r,c).Font.Bold = true;
            oExcel.ActiveSheet.Cells(r,c).Interior.Color = 14474460;
        }
        if (eSrc.cells(i).childNodes.length > 0 && eSrc.cells(i).childNodes(0).tagName == "B")
            oExcel.ActiveSheet.Cells(r,c).Font.Bold = true;
        oExcel.ActiveSheet.Cells(r,c).Value = eSrc.cells(i).innerText;
    }
    oExcelSheet.Application.Visible = true;
}

function irA(offSet)
{
    document.formBuscar.offSet.value = offSet;
    document.formBuscar.submit();
}
    
function anterior()
{
    <%
    if(request.getParameter("offSet") != null &&  Integer.parseInt(request.getParameter("offSet")) > 0 )
    {    
    %>
    document.formBuscar.offSet.value = parseInt(document.formBuscar.offSet.value) - parseInt(<%=limite%>);
    document.formBuscar.submit();
    <%
    }
    %>
}

function siguiente()
{
    <%
    if(request.getParameter("offSet") != null &&  cantidadRegistros >= (Integer.parseInt(request.getParameter("offSet"))+limite) )
    {    
    %>
    document.formBuscar.offSet.value = parseInt(document.formBuscar.offSet.value) + parseInt(<%=limite%>);
    document.formBuscar.submit();
    <%
    }
    %>
}
    
function seleccionar(llaves)
{
    var id = llaves;
    id = id.split(",");

    if(id.length == 1)
    {
        window.opener.document.getElementById("hacerSubmit").value = 0;
        window.opener.document.getElementById("llave").value = id;
        window.opener.document.formulario.submit();
        window.close();
    }
    else if(id.length > 1)
    {
        var campos;
        campos = "${param.campoLlave}";
        campos = campos.split(",");
    
        for (var i=0;i<id.length;i++)
        {
            window.opener.document.getElementById(campos[i]).value = id[i];
        }
        
        window.opener.document.getElementById("hacerSubmit").value = 0;
        window.opener.document.formulario.submit();
        window.close();
    }
}
function exportarArchivo()
{
<%
    String nombreArchivo;

    nombreArchivo = tabla+request.getSession().getAttribute("login")+UtilidadesDKDA.obtenerFechaActual2()+UtilidadesDKDA.obtenerHoraActual()+".txt";
    nombreArchivo = nombreArchivo.replaceAll(":","");

    clases.GenerarArchivoPlano generar;
    generar = new clases.GenerarArchivoPlano();
    generar.generarArchivoPlano(sql+where,nombreArchivo,request);

    String ruta = request.getSession().getServletContext().getRealPath("temp")+"\\";
    ruta = ruta.replaceAll("\\\\","/");
    pageContext.setAttribute("ruta",ruta);
%>
    window.open('../temp/<%=nombreArchivo%>',"blank","width=750,height=500,scrollbars=1,left=350,top=100");
}
function printit()
{
   window.print();
}
function generarReporte( tipoReporte )
{
    if( document.getElementById("mostrarGenerarReporte") == null ) {
        return false;
    }
    if( tipoReporte == 'pdf' ) {
        document.tablasBuscar.submit();
        
    } else if( tipoReporte == 'excel' ) {
        exportarExcel();
    } else if( tipoReporte == 'plano' ) {
        exportarArchivo();
    } else if( tipoReporte == 'impresora' ) {
        printit();
    }

}
</script>