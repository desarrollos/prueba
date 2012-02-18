<%@page contentType="text/html"%>
<%@page pageEncoding="ISO-8859-1"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"  %>

<%@page import="clases.ConexionBaseDatos" %>
<%@page import="clases.UtilidadesDKDA" %>
<%@page import="java.sql.*" %>
<%@page import="java.io.BufferedInputStream" %>
<%@page import="java.io.File" %>
<%@page import="java.io.FileReader" %>
<%@page import="java.io.BufferedReader" %>
<%@page import="java.io.FileNotFoundException" %>
<%@page import="java.io.IOException" %>
<%--<%@page import="java.util.StringTokenizer" %>--%>
<%@page import="java.util.Vector" %>

<html>
    <head>
        <link rel="stylesheet" type="text/css" media="all" href="../css/delphos.css" />
        <link href="../images/favicon.ico" rel="Shortcut Icon" type="image/x-icon" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>:: DELPHOS ::</title>
        <style type="text/css">
        <!--
        .letraPequena {
                font-family: Arial, Helvetica, sans-serif;
                font-weight: bold;
                font-size: 12px;
        }
        -->
        </style>
    </head>
    <body>
    <table cellpadding="0" cellspacing="0" bgcolor="#D2E356" width="100%">
        <tr bgcolor="#D2E356">
            <td bgcolor="#D2E356">
                <img src="../images/cabezote.png" width="906" height="150" alt="" />
            </td>
        </tr>
    </table>

    <form name="formulario" action="../${param.accion}" method="post" onsubmit="return validarSubmit();">
        <c:if test="${param.accion}">
            <input type="hidden" name="tipoRip" value="${param.tipoRip}">
            <input type="hidden" name="archivoRip" value="${param.archivoRip}">
            <input type="hidden" name="tipoRips" value="${param.tipoRips}">
        </c:if>
        <input type="hidden" name="accion" value="${param.accion}">

<%
    int i, cantidadColumnas = 0;
    String ruta = request.getSession().getServletContext().getRealPath("temp")+"\\";
    //ruta = ruta.replaceAll("\\\\","/");

    String tipoRip = "", nombreArchivo = "";
    File file;
    if(request.getParameter("tipoRips") != null)
    {
        int j = Integer.parseInt(request.getSession().getAttribute("cantidadArchivos").toString());
        tipoRip = request.getSession().getAttribute("tipoRip"+j).toString();
        nombreArchivo = request.getSession().getAttribute("archivoRip"+j).toString();
    }
    else
    {
        nombreArchivo = request.getParameter("nombreArchivo");
    }

    file = new File(ruta+nombreArchivo);
    //File file = new File("\\home\\gpi\\Comercial\\ArchivosSubidos\\"+request.getParameter("nombreArchivo"));

    FileReader fr = null;
    BufferedReader br = null;

    try
    {
        fr = new FileReader(file);
        br =  new BufferedReader(new FileReader(file));
        %>
        <table border="1" align="center" style="border-collapse:collapse" cellspacing="0" cellpadding="0">
        <%
        int contadorLineas = 0;
        boolean tablaCreada = false;
        //StringTokenizer tokensLinea = null;
        Vector vectorItemsLinea = null;
        String linea;

        ConexionBaseDatos con;
        con = new ConexionBaseDatos();
        con.abrirConexion();

        while ((( linea = br.readLine()) != null) && contadorLineas < 18)
        {
            contadorLineas++;
            //System.out.println("Linea: "+linea);

            //tokensLinea = new StringTokenizer(linea,request.getParameter("delimitador"));
            vectorItemsLinea = UtilidadesDKDA.split(linea,request.getParameter("delimitador"));

            //Para colocar solo los encabezados de la linea
            if(!tablaCreada)
            {
                %><tr><%
                //cantidadColumnas = tokensLinea.countTokens();
                cantidadColumnas = vectorItemsLinea.size();
                for(i=0;i<cantidadColumnas;i++)
                {
                %>
                    <td align="center" bgcolor="#CCCCCC" class="titulo1">Columna <%=i+1%></td>
                <%
                }
                %></tr><%

                %><tr><%
                for(i=0;i<cantidadColumnas;i++)
                {
                    %>
                    <td align="center" bgcolor="#CCCCCC">
                        <select class="letraPequena" name="columna<%=i%>" id="columna<%=i%>">
                                    <option value=""></option>
                                    <option value="-1">*** IGNORAR ***</option>
                            <%

                            ResultSet rs, rs2;
                            PreparedStatement stmt, stmt2;

                            try
                            {
                                if(request.getParameter("tipoRips") != null)
                                {
                                    String sql;
                                    sql = "SELECT * FROM estructuraarchivo WHERE codtipoestrucarch=? ORDER BY posicionarchivo";
                                    stmt = con.con.prepareStatement(sql);
                                    stmt.setString(1,"2");
                                }
                                else
                                {
                                    stmt = con.con.prepareStatement("SELECT * FROM estructuraarchivo WHERE codtipoestrucarch=? ORDER BY posicionarchivo");
                                    stmt.setString(1,request.getParameter("codtipoestrucarch"));
                                }

                                rs = stmt.executeQuery();
                                while(rs.next())
                                {
                                    double codcampoarchivo;
                                    codcampoarchivo = rs.getDouble("codcampoarchivo");

                                    stmt2 = con.con.prepareStatement("SELECT * FROM listacamposarchivo WHERE codcampoarchivo=?");
                                    stmt2.setDouble(1,codcampoarchivo);
                                    rs2 = stmt2.executeQuery();
                                    rs2.next();

                                    if((i+1) == rs.getInt("posicionarchivo"))
                                    {
                                        %>
                                        <option selected value="<%=codcampoarchivo%>"><%=rs2.getString("descripcion")%></option>
                                        <%
                                    }
                                    else
                                    {
                                        %>
                                        <option value="<%=codcampoarchivo%>"><%=rs2.getString("descripcion")%></option>
                                        <%
                                    }
                                    rs2.close();
                                    stmt2.close();
                                }
                                rs.close();
                                stmt.close();
                            }
                            catch (SQLException e)
                            {
                                con.cerrarConexion();
                            }

                            %>
                        </select>
                    </td>
                    <%
                }
                %></tr><%
                tablaCreada = true;
            }
                %><tr><%
            //while(tokensLinea.hasMoreTokens())
            for(i=0;i<vectorItemsLinea.size();i++)
            {
                String token;
                token = vectorItemsLinea.get(i).toString();
                %><td class="letraPequena"><%=token%></td><%
            }
                %></tr><%
        }

        con.cerrarConexion();
        %>
        </table>
        <%
        fr.close();
        br.close();
    }
    catch (FileNotFoundException e)
    {
        e.printStackTrace();
    }
    catch (IOException e)
    {
        e.printStackTrace();
    }
%>
        <p>Archivo: <%=nombreArchivo%></p>
        <center>
            <input type="submit" value="Cargar Informacion">
        </center>

    <%if(request.getParameter("tipoRips") != null)
    {
        int cantidadArchivos;
        cantidadArchivos = Integer.parseInt(request.getSession().getAttribute("cantidadArchivos").toString());
    %>
        <input type="hidden" name="nombreArchivo" value="<%=request.getSession().getAttribute("archivoRip"+cantidadArchivos)%>">
        <input type="hidden" name="delimitador" value="${param.delimitador}">
        <input type="hidden" name="codtipoestrucarch" value="${param.codtipoestrucarch}">
        <input type="hidden" name="idencabezado" value="${param.idencabezado}">
        <input type="hidden" name="accion" value="${param.accion}">
        <input type="hidden" name="tipoRip" value="<%=request.getSession().getAttribute("tipoRip"+cantidadArchivos)%>">
        <input type="hidden" name="archivoRip" value="<%=request.getSession().getAttribute("archivoRip"+cantidadArchivos)%>">
        <input type="hidden" name="tipoRips" value="${param.tipoRips}">
        <input type="hidden" name="cantidadColumnas" value="<%=cantidadColumnas%>">
    <%
    }
    else
    {
    %>
        <input type="hidden" name="nombreArchivo" value="${param.nombreArchivo}">
        <input type="hidden" name="delimitador" value="${param.delimitador}">
        <input type="hidden" name="codtipoestrucarch" value="${param.codtipoestrucarch}">
        <input type="hidden" name="idencabezado" value="${param.idencabezado}">
        <input type="hidden" name="cantidadColumnas" value="<%=cantidadColumnas%>">
    <%
    }%>
    </form>
    </body>
</html>

