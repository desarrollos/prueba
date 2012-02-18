
<%@page import="clases.ConexionBaseDatos"%>
<%@page import="clases.UtilidadesDKDA"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.StringTokenizer"%>

<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<%@ taglib prefix="jsp2" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>

<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Reporte</title>
<link href="../css/delphos.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
.style5 {color: #FFFFFF}
-->
</style>
</head>

<body>
<form id="formularioReporte" method="post" action="Reporte.jsp" name="formularioReporte">
    <table width="906" border="0" align="center">
        <tr>
            <td colspan="6"><div align="center"><img src="../images/cabezote.png" width="906" height="150" alt="Delphos" /></div></td>
        </tr>
        <tr>
            <td width="6%"></td>
            <td width="74%">&nbsp;</td>
            <td width="6%"><div align="center"><img src="../images/impresora.gif" alt="Imprimir" width="35" height="35" onclick="printit();" /><a href="#" onclick="printit();">Imprimir</a></div></td>
            <td width="4%"><div align="center"><img src="../images/pdf.gif" alt="Exportar a PDF" width="35" height="35" /><a href="#" onclick="exportarPdf();">PDF</a></div></td>
            <td width="5%"><div align="center"><img src="../images/Excel.gif" alt="Exportar a Excel" width="35" height="35" /><a href="#" onclick="exportarExcel();"> Excel</a></div></td>
            <td width="5%"><div align="center"><img src="../images/Plano.gif" alt="Exportar a Plano" width="35" height="35" /><a href="#" onclick="exportarArchivo();">Plano</a></div></td>

        </tr>
        <tr>
            
            <%
            
            
            String sql, where="", tabla, cadenaCampos, sql1;
            
            int limite = 20, cantidadRegistros;
            
            cantidadRegistros = 0;
            
            tabla = request.getParameter("nombreTabla");
            cadenaCampos = request.getParameter("camposTabla");
            
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
            sql1 = "SELECT * FROM "+tabla;
            
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
            
            where = where + " " + campos[i] + " LIKE '%" + request.getParameter(campos[i])+ "%'";
            
            if(hechoWhere)
            where = where + " AND ";
            }
            }
            
            if(where.length()>3 && where.substring(where.length()-4,where.length()).equals("AND "))
            where = where.substring(0,where.length()-4); 
            
            sql = sql + where;
            sql1 = sql1 + where;
            }

            //Atributos para la JSP que genera el PDF
            request.getSession().setAttribute("sql",sql);
            request.getSession().setAttribute("where",where);
            request.getSession().setAttribute("tabla",tabla);
            
            //Atributos para la JSP que genera el Excel
            request.getSession().setAttribute("sql1",sql1);
            request.getSession().setAttribute("where",where);
            request.getSession().setAttribute("tabla",tabla);
            %>
            
            <table width="100%" border="0" align="center" id="idTable">
                <tr align="center">
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
                
                <%
                
                PreparedStatement pstmt;
                ResultSet rs;
                
                ConexionBaseDatos con;
                con = new ConexionBaseDatos();
                
                con.abrirConexion();
                try
                {
                pstmt = con.con.prepareStatement("SELECT COUNT(*) FROM "+tabla+where);
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
                    <td bgcolor="<%=color%>" align="center"><span><%=rs.getString(campos[j])%></span></td>
                    <%
                    }
                    i++;
                    
                    
                    StringTokenizer camposLlave = new StringTokenizer(request.getParameter("camposLlaveTabla"), ",");
                    
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
                    valoresLlaves = rs.getString(request.getParameter("camposLlaveTabla"));
                    }
                    
                    %>
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
                
                %>
            </table>
        </tr>
    </table>
</form>
</body>

</html>
<script>
function printit()
{     
   window.print();   
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

function exportarPdf()
{
    window.open('GenerarPDF.jsp',"blank","width=10,height=10,scrollbars=1,left=350,top=100");
}

function exportarExcel()
{
    window.open('GenerarExcel.jsp',"blank","width=10,height=10,scrollbars=1,left=350,top=100");
}
</script>
