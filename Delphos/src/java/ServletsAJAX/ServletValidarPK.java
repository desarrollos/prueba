package ServletsAJAX;

import clases.ConexionBaseDatos;
import controladores.Concentracion;
import java.io.*;
import java.net.*;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.StringTokenizer;

import javax.servlet.*;
import javax.servlet.http.*;

public class ServletValidarPK extends HttpServlet 
{
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        ConexionBaseDatos con;
        con = new ConexionBaseDatos();
        
        ResultSet rs;
        PreparedStatement pstmt;
        
        String llaves, tabla, sql, existe = "NO";
        tabla = request.getParameter("tabla");
        llaves = request.getParameter("llaves");
        
        sql = "SELECT * FROM "+tabla+" WHERE ";
        
        StringTokenizer tokens, tokenLlave;
        tokens = new StringTokenizer(llaves, ",");
        while(tokens.hasMoreTokens())
        {
            tokenLlave = new StringTokenizer(tokens.nextToken(), "=");
            sql = sql + tokenLlave.nextToken()+"='"+tokenLlave.nextToken()+"' AND ";
        }
        
        sql = sql.substring(0,sql.length()-5);

        try
        {
            con.abrirConexion();
            pstmt = con.con.prepareStatement(sql);
            rs = pstmt.executeQuery();
            if(rs.next())
                existe = "SI";
            else
                existe = "NO";
            
            rs.close();
            pstmt.close();
            con.cerrarConexion();
            
            response.getWriter().write(existe);
        }
        catch(SQLException e)
        {
            con.cerrarConexion();
            System.err.println("Error: "+e);
            existe = "SI";
            response.getWriter().print(existe);
        }
    }
    
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }
    
    /** Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }
    
    /** Returns a short description of the servlet.
     */
    public String getServletInfo() {
        return "Short description";
    }
    // </editor-fold>
}
