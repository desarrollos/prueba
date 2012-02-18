/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import clases.UtilidadesDKDA;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Vector;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Administrador
 */
public class mostrarPrimerasLineas extends HttpServlet {

    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        int cantidadColumnas = 0;
        String ruta = request.getSession().getServletContext().getRealPath("temp") + System.getProperty("file.separator");
        //ruta = ruta.replaceAll("\\\\","/");
        File file = new File(ruta + request.getParameter("nombreArchivo"));
        //File file = new File("\\home\\gpi\\Comercial\\ArchivosSubidos\\"+request.getParameter("nombreArchivo"));
        FileReader fr = null;
        BufferedReader br = null;

        UtilidadesDKDA dkda = new UtilidadesDKDA();

        try {
            fr = new FileReader(file);
            br = new BufferedReader(new FileReader(file));

            String linea;
            Vector vectorTokensLinea;

            // <editor-fold defaultstate="collapsed" desc="Codigo que inserta y valida los registros del archivo">
            //Lee linea a linea el archivo

            int contador = 0;
            StringBuffer campo = new StringBuffer("");
            while ((linea = br.readLine()) != null && contador <= 4) {
                campo.append(dkda.convertirACarEspecial(linea) +  "<br />");
                contador++;
            }


            out.write(campo.toString());



        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
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
}
