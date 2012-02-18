package controladores;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import clases.ConexionBaseDatos;
import java.sql.*;
import clases.FormatoTimestamp;

public class logout implements Control{
    
     public boolean doLogic(javax.servlet.http.HttpServletRequest request, 
                         javax.servlet.http.HttpServletResponse response) 
                      throws javax.servlet.ServletException, java.io.IOException 
     {
//        PreparedStatement pstmt;
//        ConexionBaseDatos con;
//        con = new ConexionBaseDatos();
//
//        con.abrirConexion();
//
//        try
//        {
//            pstmt = con.con.prepareStatement("UPDATE sesionabierta SET sesabifechacierre=? WHERE sesabiconsecutivo=? AND ususiscodigo=?");
//            pstmt.setTimestamp(1,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));
//            pstmt.setInt(2,Integer.parseInt(request.getSession().getAttribute("idSesion").toString()));
//            pstmt.setString(3,request.getSession().getAttribute("login").toString());
//            pstmt.executeUpdate();
//            pstmt.close();
//            con.cerrarConexion();
//        }
//        catch(SQLException e)
//        {
//            System.err.println("Error: "+e);
//            con.cerrarConexion();
//        }

        request.getSession().invalidate();
        response.sendRedirect("index.jsp");
        return false;
     }
}
