package ServletsAJAX;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import clases.ConexionBaseDatos;

public class ServletSeleccionarMunicipios extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        seleccionarMunicipios(request, response);
    }

    private void seleccionarMunicipios(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PreparedStatement stmt;
        ResultSet rs;

        ConexionBaseDatos con;
        con = new ConexionBaseDatos();
        con.abrirConexion();

        int codDepartamento;
        String xmlMunicipios = "";

        codDepartamento = Integer.parseInt(request.getParameter("codDepartamento"));

        response.setContentType("text/xml; charset=iso-8859-1");
        response.setHeader("Cache-Control", "no-cache");

        try {
            String stringDepartamentos = request.getParameter("departamentos");
            stmt = con.con.prepareStatement("SELECT codmunicipio, nombre, coddepartamento FROM municipio WHERE coddepartamento=?");
            if (stringDepartamentos == null) {

                stmt.setInt(1, codDepartamento);
                rs = stmt.executeQuery();

                xmlMunicipios = "<municipios>";

                while (rs.next()) {
                    xmlMunicipios += " <municipio>"
                            + "  <codMunicipio>" + rs.getString("codmunicipio") + "</codMunicipio>"
                            + "  <nombre>" + rs.getString("nombre") + "</nombre>"
                            + " </municipio>";
                }
                xmlMunicipios += "</municipios>";

                rs.close();
                stmt.close();
            } else {
                String departamentos[] = stringDepartamentos.split("-");
                xmlMunicipios = "<municipios>";
                for (int n = 0; n < departamentos.length; n++) {

                    stmt.setInt(1, Integer.parseInt(departamentos[n]));
                    rs = stmt.executeQuery();
                    xmlMunicipios += "<departamentos>";
                    while (rs.next()) {
                        xmlMunicipios += " <municipio departamento='" + rs.getString("coddepartamento") + "'>"
                                + "  <codMunicipio>" + rs.getString("codmunicipio") + "</codMunicipio>"
                                + "  <nombre>" + rs.getString("nombre") + "</nombre>"
                                + " </municipio>";
                    }
                    xmlMunicipios += "</departamentos>";

                }
                xmlMunicipios += "</municipios>";
            }

            con.cerrarConexion();
        } catch (SQLException e) {
            System.err.println("Exception: " + e);
            con.cerrarConexion();
        }

        response.getWriter().write(xmlMunicipios);
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
