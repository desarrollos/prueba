/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package formularios;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import clases.ConexionBaseDatos;
import clases.UtilidadesDKDA;
import formularios.funciones;

/**
 *
 * @author Sebas
 */
public class edinstancias extends HttpServlet {

    ConexionBaseDatos con;
    HashMap vars = new HashMap();
    int LIMITE_COLUMNAS = 20;
    UtilidadesDKDA dkda = new UtilidadesDKDA();
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        con = new ConexionBaseDatos();
        funciones fun = new funciones();
        vars = clases.UtilidadesDKDA.urlDecodificar(request.getParameter("parametros"), "-");
        

        if (vars.containsKey("opcion")) {
            
            if (vars.get("opcion").equals("tabla")) {
                
                con.abrirConexion();

                out.write("<?xml version=\"1.0\" encoding=\"UTF-8\"?>"  + fun.tabla(con, vars, request, LIMITE_COLUMNAS));
            }
            if (vars.get("opcion").equals("campos")) {
                con.abrirConexion();
                response.setContentType("text/json");

                
                out.write(fun.tablaJson(fun.camposTablaDesc(con, vars.get("tabla").toString(), LIMITE_COLUMNAS, dkda.o(vars, "columnas")), fun.camposTabla(con, vars.get("tabla").toString(), LIMITE_COLUMNAS, dkda.o(vars, "columnas"))));
            }
            if( vars.get("opcion").equals("usuarios") ) {
                response.setContentType("text/html");
                con.abrirConexion();
                out.write( fun.usuariosSistema(con, "")  );
            }
            if( vars.get("opcion").equals("paginas") ) {
                response.setContentType("text/html");
                con.abrirConexion();
                out.write( fun.usuariosPaginas(con, "", dkda.o(vars, "usuario"))  );
            }
            if( vars.get("opcion").equals("perfiles") ) {
                response.setContentType("text/html");
                con.abrirConexion();
                out.write( fun.usuariosPaginasPerfiles(con, "", dkda.o(vars, "usuario"), dkda.o(vars, "pagina"))  );
            }
            if( vars.get("opcion").equals("guardarPermiso") ) {
                response.setContentType("text/html");
                con.abrirConexion();
                out.write( fun.guardarUsuariosPaginasPerfiles(con, "", dkda.o(vars, "usuario"), dkda.o(vars, "pagina"), dkda.o(vars, "perfil"))  );
            }
            if( vars.get("opcion").equals("config") ) { 
                response.setContentType("text/json");
                String secuencias = "\"secuencias\" : [ " + fun.secJson( con,  vars.get("secuen").toString().split(","))  + " ]";
                
                out.println( "{ " + secuencias + " } " );
                
            }
            
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
