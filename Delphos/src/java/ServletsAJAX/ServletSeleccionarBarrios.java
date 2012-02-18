package ServletsAJAX;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import clases.ConexionBaseDatos;

public class ServletSeleccionarBarrios extends HttpServlet {
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
        if(request.getParameter("tabla").equals("barrio"))
            seleccionarBarrios(request,response);
        else if(request.getParameter("tabla").equals("subgrupogeografico"))
            seleccionarSubgrupos(request,response);
    }
    
    private void seleccionarSubgrupos(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        PreparedStatement stmt;
        ResultSet rs;
        
        ConexionBaseDatos con;
        con = new ConexionBaseDatos();
        con.abrirConexion();
        
        int codDepartamento, codMunicipio;
        String xmlSubgrupos = "";
        
        codMunicipio = Integer.parseInt(request.getParameter("codMunicipio"));
        codDepartamento = Integer.parseInt(request.getParameter("codDepartamento"));

        response.setContentType("text/xml; charset=iso-8859-1");
        response.setHeader("Cache-Control", "no-cache");

        try
        {
            stmt = con.con.prepareStatement("SELECT codsubgrupo, nombre FROM subgrupogeografico WHERE coddepartamento=? AND codmunicipio=?");
            stmt.setInt(1,codDepartamento);
            stmt.setInt(2,codMunicipio);
            rs = stmt.executeQuery();

            xmlSubgrupos = "<subgrupos>";
            
            while(rs.next())
            {
                xmlSubgrupos += " <subgrupo>" +
                                 "  <codsubgrupo>"+rs.getString("codsubgrupo")+"</codsubgrupo>" +
                                 "  <nombre>"+rs.getString("nombre")+"</nombre>" +
                                 " </subgrupo>";
            }
            xmlSubgrupos += "</subgrupos>";
            
            rs.close();
            stmt.close();
            con.cerrarConexion();
        }
        catch(SQLException e)
        {
            System.err.println("Exception: "+e);
            con.cerrarConexion();
        }

        response.getWriter().write(xmlSubgrupos);
    }
    
    private void seleccionarBarrios(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        PreparedStatement stmt;
        ResultSet rs;
        
        ConexionBaseDatos con;
        con = new ConexionBaseDatos();
        con.abrirConexion();
        
        int codDepartamento, codMunicipio, codSubgrupo;
        String xmlBarrios = "";
        
        codSubgrupo = Integer.parseInt(request.getParameter("codSubgrupo"));
        codMunicipio = Integer.parseInt(request.getParameter("codMunicipio"));
        codDepartamento = Integer.parseInt(request.getParameter("codDepartamento"));

        response.setContentType("text/xml; charset=iso-8859-1");
        response.setHeader("Cache-Control", "no-cache");

        try
        {
            stmt = con.con.prepareStatement("SELECT codbarrio, nombre FROM barrio WHERE coddepartamento=? AND codmunicipio=? AND codsubgrupo=?");
            stmt.setInt(1,codDepartamento);
            stmt.setInt(2,codMunicipio);
            stmt.setInt(3,codSubgrupo);
            rs = stmt.executeQuery();

            xmlBarrios = "<barrios>";
            
            while(rs.next())
            {
                xmlBarrios += " <barrio>" +
                                 "  <codbarrio>"+rs.getString("codbarrio")+"</codbarrio>" +
                                 "  <nombre>"+rs.getString("nombre")+"</nombre>" +
                                 " </barrio>";
            }
            xmlBarrios += "</barrios>";
            
            rs.close();
            stmt.close();
            con.cerrarConexion();
        }
        catch(SQLException e)
        {
            System.err.println("Exception: "+e);
            con.cerrarConexion();
        }

        response.getWriter().write(xmlBarrios);
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
