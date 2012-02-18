<%@page contentType="text/html"%>
<%@page pageEncoding="ISO-8859-1"%>

<%@page import="clases.ConexionBaseDatos" %>
<%@page import="java.sql.*" %>
<%@page import="java.io.BufferedInputStream" %>
<%@page import="java.io.File" %>
<%@page import="java.io.FileReader" %>
<%@page import="java.io.BufferedReader" %>
<%@page import="java.io.FileNotFoundException" %>
<%@page import="java.io.IOException" %>
<%@page import="java.util.StringTokenizer" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>:: Secretaria de Salud ::</title>
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
<%

    File file = new File("C:\\ArchivosSubidos\\"+request.getParameter("nombreArchivo"));
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
        int i, contadorLineas = 0;
        boolean tablaCreada = false;
        StringTokenizer tokensLinea;
        String linea;
        while ((( linea = br.readLine()) != null) && contadorLineas < 6)
        {
            contadorLineas++;
            System.out.println("Linea: "+linea);
            tokensLinea = new StringTokenizer(linea,request.getParameter("delimitador"));

            //Para colocar solo los encabezados de la linea
            if(!tablaCreada)
            {
                %><tr><%
                for(i=0;i<tokensLinea.countTokens();i++)
                {
                    %>
                    <td align="center" bgcolor="#CCCCCC">
                        <select class="letraPequena">
                                    <option value=""></option>
                            <%
                            ConexionBaseDatos con;
                            con = new ConexionBaseDatos();

                            ResultSet rs, rs2;
                            PreparedStatement stmt, stmt2;

                            con.abrirConexion();

                            try
                            {
                                stmt = con.con.prepareStatement("SELECT * FROM estructuraarchivo WHERE codtipoestrucarch=? ORDER BY posicionarchivo");
                                stmt.setString(1,request.getParameter("codtipoestrucarch"));
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
                                con.cerrarConexion();
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
            while(tokensLinea.hasMoreTokens())
            {
                %><td class="letraPequena"><%=tokensLinea.nextToken()%></td><%
            }
                %></tr><%
        }
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
        <p>&nbsp;</p>
        <center>
            <input type="button" value="<< Anterior" onclick="javascript:history.back(1);">
            <input type="button" value="Siguiente >>" onclick="javascript:alert('Subiendo Informacion...')">
        </center>
    </body>
</html>
