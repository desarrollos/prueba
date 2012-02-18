/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package ServletsAJAX;

import clases.ConexionBaseDatos;
import clases.UtilidadesDKDA;
import clases.bdS;
import java.io.IOException;
import java.io.PrintWriter;

import java.sql.*;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import servlets.*;

/**
 *
 * @author johnSH
 */
public class ServletEncabezadoValida extends HttpServlet {

    
    //Instancia de Clase que permite validar las fechas
    UtilidadesDKDA ValidarFechas = new UtilidadesDKDA();

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse Response)
            throws ServletException, IOException {
        Response.setContentType("text/xml");
        PrintWriter out = Response.getWriter();
        String errores = "";
        clases.ed_ValidacionCampos v;
        v = new clases.ed_ValidacionCampos();

        //System.out.println("REGIMEN  " + request.getParameter("codregimen")  );

        boolean error = false;
        if (request.getParameter("tipoValidacion").equals("encabezado")) {

            String camposAvalivadar[] = new String[]{
                "codregimen",
                "codentidadsalud",
                "grupopoblacion",
                "fechainicial",
                "fechafinal",
                /*"codarchivo",*/
                "coddepartamento",
                "codmunicipio",
                "codigoTipoArchivo",
                "nombreenvia",
                "telefonoenvia",
                "emailenvia",
                "fechaenvio",
                "fecharecibo",
                "registros",
                "nombreArchivo",
                "tipoCarga"
            };


            for (int n = 0; n < camposAvalivadar.length; n++) {

                String id = "";
                String mensaje = "";

                //i("Valor tipoRip", request.getParameter("tipoRip"));
                

                // ** VALIDAR  Codigo Regimen ** //
                if (camposAvalivadar[n].equals("codregimen")) {
                    id = "#id_regimen";
                    if (request.getParameter(camposAvalivadar[n]).equals("")) {
                        error = true;
                        mensaje += "<mensaje>Debe seleccionar un Regimen</mensaje>";

                    }
                    errores += "<error estado=\"" + (error ? "block" : "none") + "\" id=\"" + id + "\">";
                    errores += mensaje;
                    errores += "</error>";
                }

                // ** VALIDAR  Codigo Entidad Salud ** //
                if (camposAvalivadar[n].equals("codentidadsalud")) {
                    id = "#id_entidadSalud";
                    if (request.getParameter(camposAvalivadar[n]).equals("")) {
                        error = true;
                        mensaje += "<mensaje>Debe seleccionar una Entidad de Salud</mensaje>";
                    }
                    errores += "<error estado=\"" + (error ? "block" : "none") + "\" id=\"" + id + "\">";
                    errores += mensaje;
                    errores += "</error>";
                }
                if (camposAvalivadar[n].equals("grupopoblacion")  ) {
                    id = "#id_grupopoblacion";

                    if (request.getParameter(camposAvalivadar[n]).equals("") 
                            && request.getParameter("tipoCarga").equals("CargarPoblacion")
                            && ( request.getParameter("codregimen").equals("otr") || request.getParameter("codregimen").equals("par") ) ) {
                        error = true;
                        mensaje += "<mensaje>Debe seleccionar un grupo poblacion</mensaje>";
                    }
                    errores += "<error estado=\"" + (error ? "block" : "none") + "\" id=\"" + id + "\">";
                    errores += mensaje;
                    errores += "</error>";
                }

                // ** VALIDAR  Fecha Inicial ** //
                if (camposAvalivadar[n].equals("fechainicial")) {
                    id = "#id_fechaInicial";
                    if (request.getParameter(camposAvalivadar[n]).equals("")) {
                        error = true;
                        mensaje += "<mensaje>Debe Seleccionar una Fecha</mensaje>";
                    }
                    errores += "<error estado=\"" + (error ? "block" : "none") + "\" id=\"" + id + "\">";
                    errores += mensaje;
                    errores += "</error>";
                }

                // ** VALIDAR  Fecha Final ** //
                if (camposAvalivadar[n].equals("fechafinal")) {
                    id = "#id_fechaFinal";
                    if (request.getParameter(camposAvalivadar[n]).equals("")) {
                        error = true;
                        mensaje += "<mensaje>Debe seleccionar una Fecha</mensaje>";
                    }
                    if (UtilidadesDKDA.diasEntreFechas31Dias(UtilidadesDKDA.edStringAFecha(request.getParameter("fechainicial").replaceAll("/", "-")), UtilidadesDKDA.edStringAFecha(request.getParameter("fechafinal").replaceAll("/", "-"))) < 0) {
                        error = true;
                        mensaje += "<mensaje>La Fecha Final no debe ser menor a Fecha Inicial</mensaje>";
                        //System.out.println("Fecha Mala :(");
                    }

                    errores += "<error estado=\"" + (error ? "block" : "none") + "\" id=\"" + id + "\">";
                    errores += mensaje;
                    errores += "</error>";
                }



                // ** VALIDAR  Codigo Archivo ** //
                if (camposAvalivadar[n].equals("codarchivo")) {
                    id = "#id_codigoArchivo";
                    if (request.getParameter(camposAvalivadar[n]).equals("")) {
                        error = true;
                        mensaje += "<mensaje>Este Campo no puede estar Vacio</mensaje>";
                    }
//                if (request.getParameter(camposAvalivadar[n]).equals("169")) {
//                    error = true;
//                    mensaje += "<mensaje>Solo se permiten numeros en este Campo</mensaje>";
//                }

                    errores += "<error estado=\"" + (error ? "block" : "none") + "\" id=\"" + id + "\">";
                    errores += mensaje;
                    errores += "</error>";
                }

                // ** VALIDAR  Departamento ** //
                if (camposAvalivadar[n].equals("coddepartamento")) {
                    id = "#id_departamento";
                    if (request.getParameter(camposAvalivadar[n]).equals("")) {
                        error = true;
                        mensaje += "<mensaje>Debe seleccionar un Departamento</mensaje>";
                    }
                    errores += "<error estado=\"" + (error ? "block" : "none") + "\" id=\"" + id + "\">";
                    errores += mensaje;
                    errores += "</error>";
                }

                // ** VALIDAR  Municipio ** //
                if (camposAvalivadar[n].equals("codmunicipio")) {
                    id = "#id_municipio";
                    if (request.getParameter(camposAvalivadar[n]).equals("")) {
                        error = true;
                        mensaje += "<mensaje>Debe seleccionar un Municipio</mensaje>";
                    }
                    errores += "<error estado=\"" + (error ? "block" : "none") + "\" id=\"" + id + "\">";
                    errores += mensaje;
                    errores += "</error>";
                }
               
                // ** VALIDAR  Codigo Tipo Archivo ** //
                if (camposAvalivadar[n].equals("codigoTipoArchivo")) {
                    id = "#id_codigoTipoArchivo";
                    if (request.getParameter(camposAvalivadar[n]).equals("") /*&&  ! request.getParameter("tipoCarga").equals("CargarRips") */) {
                        error = true;
                        mensaje += "<mensaje>Debe seleccionar un Tipo de Archivo</mensaje>";
                    } else if( request.getParameter("tipoCarga").equals("CargarPoblacion") && request.getParameter(camposAvalivadar[n]).equals("rips") ) {
                        error = true;
                        mensaje += "<mensaje>Esta opcion solo esta disponible para Rips</mensaje>";
                    }
                    errores += "<error estado=\"" + (error ? "block" : "none") + "\" id=\"" + id + "\">";
                    errores += mensaje;
                    errores += "</error>";
                }

                // ** VALIDAR  Nombre Envia ** //
                if (camposAvalivadar[n].equals("nombreenvia")) {
                    id = "#id_nombreEnvia";
//                    if (request.getParameter(camposAvalivadar[n]).equals("")) {
//                        error = true;
//                        mensaje += "<mensaje>Este Campo no debe ir Vacio</mensaje>";
//                    }
                    if (!v.alfaNumericos(request.getParameter(camposAvalivadar[n])) && ! request.getParameter(camposAvalivadar[n]).equals("")) {
                        // Descomentar la linea error = true;
                        error = true;
                        mensaje += "<mensaje>En este campo solo se permiten Letras.</mensaje>";
                    }

                    errores += "<error estado=\"" + (error ? "block" : "none") + "\" id=\"" + id + "\">";
                    errores += mensaje;
                    errores += "</error>";

                }

                // ** VALIDAR  Telefono Envia  ** //
                if (camposAvalivadar[n].equals("telefonoenvia")) {
                    id = "#id_telefono";
                    if (request.getParameter(camposAvalivadar[n]).equals("")) {
                        //error = true;
                        //mensaje += "<mensaje>Este Campo no debe ir Vacio</mensaje>";
                    }
                    if (!v.numeros(request.getParameter(camposAvalivadar[n]).replace(" ", "")) && ! request.getParameter(camposAvalivadar[n]).equals("")) {
                        error = true;
                        mensaje += "<mensaje>En este Campo solo se permiten Numeros</mensaje>";
                    }
                    errores += "<error estado=\"" + (error ? "block" : "none") + "\" id=\"" + id + "\">";
                    errores += mensaje;
                    errores += "</error>";
                }

                // ** VALIDAR  Email Envia ** //
                if (camposAvalivadar[n].equals("emailenvia")) {
                    id = "#id_email";
                    if (!v.correo(request.getParameter(camposAvalivadar[n]).replace(" ", "")) && ! request.getParameter(camposAvalivadar[n]).equals("")) {
                        error = true;
                        mensaje += "<mensaje>Debe introduccir un Correo Electronico Valido</mensaje>";
                    }
                    errores += "<error estado=\"" + (error ? "block" : "none") + "\" id=\"" + id + "\">";
                    errores += mensaje;
                    errores += "</error>";
                }


                // ** VALIDAR  Fecha Envio ** //
                if (camposAvalivadar[n].equals("fechaenvio")) {
                    id = "#id_fehaEnvio";
                    if (request.getParameter(camposAvalivadar[n]).equals("")) {
                        error = true;
                        mensaje += "<mensaje>Debe Seleccionar una Fecha</mensaje>";
                    }
                    errores += "<error estado=\"" + (error ? "block" : "none") + "\" id=\"" + id + "\">";
                    errores += mensaje;
                    errores += "</error>";
                }

                // ** VALIDAR  Fecha Recibo ** //
                if (camposAvalivadar[n].equals("fecharecibo")) {
                    id = "#id_fechaRecibo";
                    if (request.getParameter(camposAvalivadar[n]).equals("")) {
                        error = true;
                        mensaje += "<mensaje>Debe seleccionar una Fecha</mensaje>";
                    }
                    if (UtilidadesDKDA.diasEntreFechas31Dias(UtilidadesDKDA.edStringAFecha(request.getParameter("fechaenvio").replaceAll("/", "-")), UtilidadesDKDA.edStringAFecha(request.getParameter("fecharecibo").replaceAll("/", "-"))) < 0) {
                        error = true;
                        mensaje += "<mensaje>La Fecha Recibo no debe ser menor a Fecha Envio</mensaje>";
                        //System.out.println("Fecha Mala :(");
                    }

                    errores += "<error estado=\"" + (error ? "block" : "none") + "\" id=\"" + id + "\">";
                    errores += mensaje;
                    errores += "</error>";
                }


                // ** VALIDAR Cantidad Registros ** //
                if (camposAvalivadar[n].equals("registros")) {
                    id = "#id_cantRegistros";
                    if (request.getParameter(camposAvalivadar[n]).equals("")) {
                       // error = true;
                       // mensaje += "<mensaje>Este Campo no debe ir Vacio</mensaje>";
                    }
                    if (!v.numeros(request.getParameter(camposAvalivadar[n]).replace(" ", "")) && ! request.getParameter(camposAvalivadar[n]).equals("")) {
                        error = true;
                        mensaje += "<mensaje>En este Campo solo se permiten Numeros</mensaje>";
                    }
                    errores += "<error estado=\"" + (error ? "block" : "none") + "\" id=\"" + id + "\">";
                    errores += mensaje;
                    errores += "</error>";
                }


                // ** VALIDAR Copia Documento Remisorio ** //
                if (camposAvalivadar[n].equals("nombreArchivo")) {
                    id = "#id_documentAdjunto";
                    mensaje = "";
                    if (request.getParameter(camposAvalivadar[n]).equals("")) {
                        mensaje += "<mensaje>Seleccione un documento adjunto</mensaje>";
                        error = true;
                    }
                    if (v.extensionInvalida(request.getParameter("nombreArchivo"))) {
                        mensaje += "<mensaje>El Archivo tiene un formato invalido</mensaje>";
                        error = true;
                    }

                    System.out.println("Archivo Rips Valido? "+v.archivoRips("AF", request.getParameter("nombreArchivo")));
                    errores += "<error estado=\"" + (error ? "block" : "none") + "\" id=\"" + id + "\">";
                    errores += mensaje;
                    errores += "</error>";
                }

                // ** VALIDAR Seleccionar Tipo Rip ** //
                if (camposAvalivadar[n].equals("tipoCarga")) {
                    id = "#id_tipoArchivo";
                    if (request.getParameter(camposAvalivadar[n]) == null
                            || (!request.getParameter(camposAvalivadar[n]).equals("CargarPoblacion")
                            && !request.getParameter(camposAvalivadar[n]).equals("CargarRips"))) {
                        error = true;
                        mensaje += "<mensaje>No ha seleccionado ningun Tipo de Rip</mensaje>";
                    }
                    errores += "<error estado=\"" + (error ? "block" : "none") + "\" id=\"" + id + "\">";
                    errores += mensaje;
                    errores += "</error>";
                }

            }

            // i( "tipoCarga " + request.getParameter("tipoCarga") );

            // El servlet encargado de llenar el encabezado es llamado ...
            int encabezado = 0;
            if (!error) {
                CargarArchivo c = new CargarArchivo();
                encabezado = c.doLogic(request, Response);

            }
            // Pregunta la hora del ultimo registro ...
            Connection conexion = bdS.getConexion();
            
            String fecha = "";
            try {
                PreparedStatement st = conexion.prepareStatement("SELECT fecharegistro AS fecharegistro FROM encabezadoarchivo ORDER BY idencabezado desc LIMIT 1");
                ResultSet res = st.executeQuery();
                res.next();
                fecha = res.getString("fecharegistro");
                res.close();
            } catch (SQLException sqlE) {
                System.out.println(sqlE.getMessage());
            }
            
            out.write("<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
                    + "<errores idEncabezado=\"" + encabezado + "\" fecha=\"" + fecha + "\">" + errores + "</errores>");

        }
        if (request.getParameter("tipoValidacion").equals("poblacionRips")) {
            String camposAvalivadar[] = new String[]{
                "nombreArchivo2",
                "delimitador"
            };

            for (int n = 0; n < camposAvalivadar.length; n++) {
                String id = "";
                String mensaje = "";
                if (camposAvalivadar[n].equals("nombreArchivo2")) {
                    id = "#id_nombreArchivo2";
                    if (request.getParameter(camposAvalivadar[n]).equals("")) {
                        error = true;
                        mensaje += "<mensaje>Seleccione un archivo</mensaje>";

                    }
                    errores += "<error estado=\"" + (error ? "block" : "none") + "\" id=\"" + id + "\">";
                    errores += mensaje;
                    errores += "</error>";
                }
                if (camposAvalivadar[n].equals("delimitador")) {
                    id = "#id_delimitador";
                    if (request.getParameter(camposAvalivadar[n]) == null
                            || (request.getParameter("delimitador").equals("otro") && request.getParameter("otroDelimitador").equals(""))) {
                        error = true;
                        mensaje += "<mensaje>Seleccione un delimitador</mensaje>";

                    }
                    errores += "<error estado=\"" + (error ? "block" : "none") + "\" id=\"" + id + "\">";
                    errores += mensaje;
                    errores += "</error>";
                }
            }


            out.write("<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
                    + "<errores>" + errores + "</errores>");


        } else if (request.getParameter("tipoValidacion").equals("rips")) {
            String camposAvalivadar[] = new String[]{
                "tiporips",
                "nombreArchivoPrimero",
                "delimitadorRips",
                "tiposRips_bd"
            };
            HashMap datos = new HashMap();
            datos = clases.UtilidadesDKDA.urlDecodificar(request.getParameter("ripsForm"), "");
            System.out.println( datos.get("archivoRip_US") );
//            for (int n = 0; n < camposAvalivadar.length; n++) {
//                String id = "";
//                String mensaje = "";
//                if (camposAvalivadar[n].equals("tiporips")) {
//                    id = "#id_tiporips";
//                    if (request.getParameter(camposAvalivadar[n]).equals("")) {
//                        error = true;
//                        mensaje += "<mensaje>Seleccione un tipo de Rips</mensaje>";
//
//                    }
//                    errores += "<error estado=\"" + (error ? "block" : "none") + "\" id=\"" + id + "\">";
//                    errores += mensaje;
//                    errores += "</error>";
//                }
//                if (camposAvalivadar[n].equals("nombreArchivoPrimero")) {
//                    id = "#id_nombreArchivoPrimero";
//                    if (request.getParameter(camposAvalivadar[n]).equals("")) {
//                        error = true;
//                        mensaje += "<mensaje>Seleccione un archivo</mensaje>";
//
//                    }
//                    errores += "<error estado=\"" + (error ? "block" : "none") + "\" id=\"" + id + "\">";
//                    errores += mensaje;
//                    errores += "</error>";
//                }
//                if (camposAvalivadar[n].equals("delimitadorRips")) {
//                    id = "#id_delimitadorRips";
//                    if (request.getParameter(camposAvalivadar[n]) == null
//                            || (request.getParameter("delimitadorRips").equals("otro") && request.getParameter("otroDelimitadorRips").equals(""))) {
//                        error = true;
//                        mensaje += "<mensaje>Seleccione un delimitador</mensaje>";
//
//                    }
//                    errores += "<error estado=\"" + (error ? "block" : "none") + "\" id=\"" + id + "\">";
//                    errores += mensaje;
//                    errores += "</error>";
//                }
//                if (camposAvalivadar[n].equals("tiposRips_bd")) {
//                    String formulario = request.getParameter("ripsForm");
//                    HashMap mapaClaveValor = new HashMap();
//                    String[] separacionVariables = formulario.split("&");
//                    for (int s = 0; s < separacionVariables.length; s++) {
//                        String[] claveValor = separacionVariables[s].split("=");
//                        String clave = claveValor[ 0];
//                        try {
//                            String valor = claveValor[ 1];
//                            if (clave.indexOf("archivoRip") != -1) {
//                                mapaClaveValor.put(clave, valor);
//                            }
//
//                        } catch (IndexOutOfBoundsException e) {
//                        }
//                    }
//                    con = new ConexionBaseDatos();
//                    con.abrirConexion();
//                    int cant = 0;
//                    try {
//                        PreparedStatement st = con.con.prepareStatement("SELECT COUNT(*) cant FROM tiporips WHERE upper(obligatorio)='S'");
//                        ResultSet res = st.executeQuery();
//                        res.next();
//                        cant = res.getInt("cant");
//                        for (int l = 1; l <= cant; l++) {
//                            error = false;
//                            String idRips = "archivoRip" + l;
//                            String mensajeRips = "";
//                            if (!mapaClaveValor.containsKey(idRips)) {
//                                error = true;
//                                mensajeRips += "<mensaje>Seleccione un archivo</mensaje>";
//
//                            }
//                            errores += "<error estado=\"" + (error ? "block" : "none") + "\" id=\"#id_" + idRips + "\">";
//                            errores += mensajeRips;
//                            errores += "</error>";
//                        }
//
//                        res.close();
//                    } catch (SQLException sqlE) {
//                        System.out.println(sqlE.getMessage());
//                    }
//
//
//
//                }
//
//
//
//            }
            out.write("<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
                    + "<errores>" + errores + "</errores>");
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
