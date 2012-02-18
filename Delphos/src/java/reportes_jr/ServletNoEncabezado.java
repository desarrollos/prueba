/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package reportes_jr;

import clases.ConexionBaseDatos;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;


import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;

// Excel


import net.sf.jasperreports.engine.export.*;
import net.sf.jasperreports.engine.*;
import java.io.*;


import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;

/**
 *
 * @author John J.S
 */
public class ServletNoEncabezado extends HttpServlet {

    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private Connection con = null;
    public String urlLogoDelphos;

    protected void processRequest(HttpServletRequest request, final HttpServletResponse response)
            throws ServletException, IOException {
        final ConexionBaseDatos con;
        con = new ConexionBaseDatos();
        con.abrirConexion();

        urlLogoDelphos = request.getSession().getServletContext().getRealPath("reportes") + File.separatorChar + "formatos" + File.separatorChar + "LogoDelphos.png";
        compilarJrxml(request);

        final HashMap ParametrosReport = new HashMap();
        ParametrosReport.put("URL_LOGO_DELPHOS", urlLogoDelphos);

        ParametrosReport.put("noEncabezado", Integer.parseInt(request.getParameter("noEncabezado")));

        final ServletOutputStream servletOutputStream = response.getOutputStream();

        final InputStream reportStream = getServletConfig().getServletContext().getResourceAsStream("/reportes/formatos/NoEncabezado.jasper");

        try {
            JasperRunManager.runReportToPdfStream(reportStream, servletOutputStream, ParametrosReport, con.con);
            
            //byte[] bytes = JasperRunManager.runReportToPdf(reportStream, new HashMap() ,con.con);
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition","attachment; filename=\""+ "fichero.pdf" + "\"");
            servletOutputStream.flush();
            servletOutputStream.close();
            // eliminarJasper(request);
        } catch (JRException e) {
            StringWriter stringWriter = new StringWriter();
            PrintWriter printWriter = new PrintWriter(stringWriter);
            e.printStackTrace(printWriter);
            response.setContentType("text/plain");
            response.getOutputStream().print(stringWriter.toString());
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

//    public void compilarJrxml(HttpServletRequest request) {
//        try {
//            JasperCompileManager.compileReportToFile(request.getRealPath("reportes/formatos/NoEncabezado.jrxml"), request.getRealPath("reportes/formatos/NoEncabezado.jasper"));
//            System.out.println("Reporte compilado");
//        } catch (JRException e) {
//            System.out.println("Problemas encontrados al compilar JRXML " + e.getMessage());
//        }
//    }
    public void compilarJrxml(HttpServletRequest request) {
        try {
            JasperCompileManager.compileReportToFile(request.getRealPath("reportes/formatos/NoEncabezado.jrxml"), request.getRealPath("reportes/formatos/NoEncabezado.jasper"));
            System.out.println("Reporte compilado ... ");
        } catch (JRException e) {
            System.out.println("Problemas encontrados al compilar JRXML " + e.getMessage());
        }
    }
}
