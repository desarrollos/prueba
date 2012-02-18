/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import clases.ConexionBaseDatos;
import clases.UtilidadesDKDA;
import clases.ed_ValidacionCampos;
import poblacion.InconsistenciasPoblacion;
import clases.ed_ValidarArchivo;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.sql.*;
import java.util.HashMap;
import javax.crypto.Cipher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author John J.S
 */
public class todoInstancias extends HttpServlet {

    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    InconsistenciasPoblacion getCantidadInconsistencias;
    ed_ValidarArchivo getRutas;
    CargarPoblacion cA;
    // Instancia Conexion BD
    ConexionBaseDatos con;
    String colores[] = {"#439f00", "#FFFFFF"};
    int totalCoincidencias = 0;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Se abre conexion a la base de datos.
        con = new ConexionBaseDatos();
        con.abrirConexion();

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        if (request.getParameter("validaRips") != null) {

            if (ed_ValidacionCampos.archivoRips(request.getParameter("actualRip"), request.getParameter("nombreArchivo"))) {
                try {
                    out.println(1);
                } finally {
                }

            } else {
                try {
                    out.println(0);
                } finally {
                }
            }
        }
        if (request.getParameter("incon_nove") != null) {
            response.setContentType("text/xml");
            String xml = "<incon_nove>";


            getCantidadInconsistencias = new InconsistenciasPoblacion();
            getRutas = new ed_ValidarArchivo();
            cA = new CargarPoblacion();

            // Aqui se coloca solo inconcistencias
            xml += "<datos id=\"#tabs_incon_nove-1\"><![CDATA[";

            xml += "";
            int cantidad = getCantidadInconsistencias.setNoInconsistencias(Integer.parseInt(request.getParameter("encabezado")));

            xml += "<p> Inconsistencias Encontradas " + cantidad + "</p>";

            if (cantidad > 0) {
                xml += "<p><a href=\"../CertificadoCarga?noEncabezado="+ request.getParameter("encabezado") + "&tipoCarga=" +"\" target=\"_blank\">Descargar certificado de carga</a></p>";
                xml += "<p><a href=\"../descargarArchivo?id=" + request.getParameter("encabezado") + "&nombreArchivo=" +"descInconsistencias_" + request.getParameter("nombreArchivo") +  "\" target=\"_blanck\">Descargar Log de Inconsistencias</a></p>";
                xml += "<p><a href=\"../descargarArchivo?id=" + request.getParameter("encabezado") + "&nombreArchivo=datosInconsistentes_" + request.getParameter("nombreArchivo") + "\" target=\"_blanck\">Descargar Datos Inconsistentes</a></p>";
            } else {
                xml += "No se generaron Inconsistencias <strong>No hay archivos para descargar</strong>";
            }
            //xml += "<p><span onclick=\"desLogInconcistencias( 'Inconsistencias_' )\">Descargar Log de Inconsistencias</span></p>";+\"
            //xml += "<p><span onclick=\"desDatosInconcistentes( 'descInconsistencias_' )\" >Descargar Datos Inconsistentes</span></p>";




            xml += "]]></datos>";

            // Aqui se coloca solo novedades
            xml += "<datos id=\"#tabs_incon_nove-2\"><![CDATA[";

            String ruta = request.getSession().getServletContext().getRealPath("temp") + System.getProperty("file.separator");

            File file = new File(getRutas.rutaDatosCorrectos("" + request.getParameter("encabezado"), request.getParameter("nombreArchivo"), ruta));
            // Se comprueba que el archivo de datos correctos exista , para que no vaya a ocurrir un error ...
            if (file.exists()) {

                //  System.out.println("Ruta Archivo Correcto todoinstancias.java " + getRutas.rutaDatosCorrectos(""+request.getParameter("encabezado") , request.getParameter("nombreArchivo") , ruta));
                xml += "<div id=\"criterios\">";
                int veces = 0;
                for (int n = 1; n <= 5; n++) {
                    String criterio = "";
                    boolean entrar = true;
                    boolean hayDatos = false;
                    try {
                        Statement st = con.con.createStatement();
                        ResultSet rq = st.executeQuery("SELECT codcampoarchivo, descripcion FROM listacamposarchivo WHERE liscamcrit" + n + "  = 1");
                        while (rq.next()) {
                            hayDatos = true;
                            if (!columnaSeleccionada(request, rq.getString("codcampoarchivo"))) {
                                entrar = false;
                                break;
                            } else {
                                criterio += rq.getString("descripcion") + " , ";
                            }

                        }
                        //System.out.println(" ENTRAR " + entrar);
                        if (entrar && hayDatos) {
                            veces++;
                            //System.out.println("Criterios : " + criterio);
                            //criterio = criterio.substring(0, criterio.length() - 2) + "<br /><br />";
                            criterio = "<fieldset>"
                                    + "<legend>Criterio de busqueda : " + n + "<input type=\"submit\" onclick=\"procesarCriterio(" + n + ")\" value=\"Procesar por este criterio\" /> </legend>"
                                    + criterio
                                    + "</fieldset>";
                            xml += criterio;
                        }
                    } catch (SQLException e) {
                        System.out.println(e.getMessage());

                    }
                }
                if (veces == 0) {
                    xml += "<strong>Su selecci&oacute;n de columnas es insuficiente para mostrar los criterios de busqueda<br />Presione aqu&iacute;"
                            + " para seleccionar nuevamente las columnas</strong>";
                    
                    
                }

                xml += "</div>";




                xml += "</div>";
            } else {
                xml += "<p>Sin novedades</p>";
            }

            xml += "]]></datos>";


            xml += "</incon_nove>";

            out.println("<?xml version=\"1.0\" encoding=\"UTF-8\"?>" + xml);
        }
        if (request.getParameter("registrarNuevos") != null) {
            String estructuraColumnas = UtilidadesDKDA.estructuraColumnas(request);
            guardarNuevos(request, request.getParameter("encabezado"), estructuraColumnas);

        }

        if (request.getParameter("verCoincidencias") != null) {
            String idencabezado = request.getParameter("idencabezado");
            String paginador = "";
            String datos = "";
            int TAMANIO = 30;
            String pagina = request.getParameter("pagina") != null ? request.getParameter("pagina") : "1";
            int inicio = (Integer.parseInt(pagina) - 1) * TAMANIO;

            String estructuraColumnas = UtilidadesDKDA.estructuraColumnas(request);

            String datosTd = "";
            String datosRetorno = "";
            try {

                Statement st = con.con.createStatement();
                Statement st2 = con.con.createStatement();

                String[] campos = estructuraColumnas.split(",");
                //    System.out.println("COINCIDENCIAS-------->");
                ResultSet rq = st.executeQuery("SELECT DISTINCT  numeroidentafiliadopp AS numerop FROM coincpoblacion WHERE  idencabezado = " + idencabezado + " LIMIT " + TAMANIO + " OFFSET " + inicio);

                while (rq.next()) {

                    ResultSet rq2 = st2.executeQuery("SELECT * FROM poblacionperiodica WHERE idencabezado = " + idencabezado
                            + " AND numeroidentafiliado = '" + rq.getString("numerop") + "'");

                    while (rq2.next()) {

                        for (int n = 0; n < campos.length; n++) {
                            datosTd += "<td>" + rq2.getString(campos[n]) + "</td>";
                        }
                        datosRetorno += "<tr><td><strong style=\"color:#439f00\">" + registroCoincidentes(idencabezado, rq2.getString("numeroidentafiliado")) + "</strong></td><td><input type=\"submit\" value=\"Ver coincidencias de este registro\" onclick=\"verCoincidentesDelRegistro(this.id, 1)\" name=\"registro_coincide_" + rq2.getString("numeroidentafiliado") + "\" id=\"" + rq2.getString("numeroidentafiliado") + "_" + idencabezado + "\" /></td>" + datosTd + "</tr>";
                        datosTd = "";

                    }
                }

            } catch (SQLException e) {
                System.out.println(e.getMessage());

            }


            String[] estructura = estructuraColumnas.split(",");
            String columnas = "";
            for (int n = 0; n < estructura.length; n++) {
                columnas += "<th>" + reDescripcioListaCampoArchivo(estructura[n]) + "</th>";
            }


            datos = "<div id=\"registros_nuevos\">"
                    + "<table border=\"1\" cellspacing\"2\">"
                    + "<th>Cantidad de coincidencias</th><th>Seleccionar</th>" + columnas
                    + datosRetorno
                    + "</table>"
                    + "</div>";


            if (request.getParameter("devolver_paginador") != null) {

                float total_paginas = (float) Math.ceil((double) cantCoincidencias(idencabezado) / (double) TAMANIO);

                for (int n = 1; n <= total_paginas; n++) {
                    paginador += "<a href=\"#\" onclick=  \"paginaCoincidencias(" + n + ", " + idencabezado + "); return false\">" + n + "</a>&nbsp;";
                }

                paginador = "<div id=\"paginador_registros_nuevos\">P&aacute;gina "
                        + paginador
                        + "</div>";
            }
            out.println(datos + paginador);
        }

        if (request.getParameter("registrosNuevosNovedades") != null) {
            String idencabezado = request.getParameter("idencabezado");
            String paginador = "";
            String datos = "";
            int TAMANIO = 30;
            String pagina = request.getParameter("pagina") != null ? request.getParameter("pagina") : "1";

            String estructuraColumnas = UtilidadesDKDA.estructuraColumnas(request);

            int inicio = (Integer.parseInt(pagina) - 1) * TAMANIO;

            String datosTd = "";
            String datosRetorno = "";
            try {
                Statement st = con.con.createStatement();

                String[] campos = estructuraColumnas.split(",");

                ResultSet rq = st.executeQuery("SELECT idregistro," + estructuraColumnas + " FROM poblacionperiodica WHERE codestadousuapoblac = 'N' AND idencabezado = " + idencabezado + " LIMIT " + TAMANIO + " OFFSET " + inicio);
                System.out.println("PAGINA NUEVOS : " + "SELECT idregistro," + estructuraColumnas + " FROM poblacionperiodica WHERE codestadousuapoblac = 'N' AND idencabezado = " + idencabezado + " LIMIT " + TAMANIO + " OFFSET " + inicio);
                int registro = 0;
                int contador = 1;
                while (rq.next()) {
                    int color = contador % 2;
                    for (int n = 0; n < campos.length; n++) {

                        datosTd += "<td>" + rq.getString(campos[n]) + "</td>";
                    }
                    datosRetorno += "<tr style=\"background:" + color + "\"><td><input type=\"checkbox\" name=\"registro_nuevo_" + rq.getString("idregistro") + "\" id=\"" + rq.getString("idregistro") + "\" /></td>" + datosTd + "</tr>";
                    datosTd = "";
                    registro++;
                    contador++;
                }

            } catch (SQLException e) {
            }
            String[] estructura = estructuraColumnas.split(",");
            String columnas = "";
            for (int n = 0; n < estructura.length; n++) {
                columnas += "<th>" + reDescripcioListaCampoArchivo(estructura[n]) + "</th>";
            }


            datos = "<div id=\"registros_nuevos\">"
                    + "<table border=\"1\" cellspacing\"2\">"
                    + "<th><input type=\"checkbox\" onclick=\"seleccionarNuevos()\" name=\"seleccionarTodosLosNuevos\" id=\"seleccionarTodosLosNuevos\" /></th>" + columnas
                    + datosRetorno
                    + "</table>"
                    + "</div>";


            if (request.getParameter("devolver_paginador") != null) {

                float total_paginas = (float) Math.ceil((double) cantConEstadoN(idencabezado) / (double) TAMANIO);
                for (int n = 1; n <= total_paginas; n++) {
                    paginador += "<a href=\"#\" onclick=\"paginaNuevos(" + n + ", " + idencabezado + "); return false\">" + n + "</a>&nbsp;";
                }

                paginador = "<div id=\"paginador_registros_nuevos\">P&aacute;gina "
                        + paginador
                        + "</div>";
            }
            out.println(datos + paginador);
        }
        if (request.getParameter("productosNovedades") != null) {
            String idencabezado = request.getParameter("idencabezado");
            String datos = "<input type=\"submit\" onclick=\"if(  this.title == 0 ) { sin_registros(); } else { mostrarRegistrosNuevos(" + idencabezado + ") }\" title=\"" + cantConEstadoN(idencabezado) + "\" name=\"cantidadRegistrosNuevos\" id=\"cantidadRegistrosNuevos\" value=\"Registros nuevos ( " + cantConEstadoN(idencabezado) + " )\" /><br />"
                   /* + "<input type=\"submit\" name=\"cantidadCoincidencias\" onclick=\"if( " + cantCoincidencias(idencabezado) + " == 0 )  { sin_registros(); }  else {  mostrarRegistrosCoincidentes(" + idencabezado + ") }\" id=\"cantidadCoincidencias\" value=\"Cantidad de coincidencias (" + cantCoincidencias(idencabezado) + ")\" /><br />"*/
                    + "<input type=\"submit\" name=\"cantidadNovedades\" id=\"cantidadNovedades\" onclick=\"if( " + cantNovedades(idencabezado) + " == 0 ) { sin_registros(); } else { alert('Datos') } \" value=\"Cantidad de novedades (" + cantNovedades(idencabezado) + ")\" />";
            out.println(datos);
        }

        if (request.getParameter("posicionesCampos") != null) {
            String campos = request.getParameter("campos");
            try {
                Statement st = con.con.createStatement();
                ResultSet resultQ = st.executeQuery("SELECT codcampoarchivo, nombrecampotabla FROM listacamposarchivo WHERE codcampoarchivo IN (" + campos + ")");
                String retorno = "";
                while (resultQ.next()) {
                    retorno += resultQ.getString("codcampoarchivo") + "-" + resultQ.getString("nombrecampotabla") + ";";
                }
                out.println(retorno.substring(0, retorno.length() - 1));
            } catch (SQLException e) {
            }
        }

        if (request.getParameter("reigstroCoincidente") != null) {
            String estructuraColumnas = UtilidadesDKDA.estructuraColumnas(request);

            String dato = request.getParameter("dato");
            String[] encabezado_numero = dato.split("_");

            try {
                Statement st = con.con.createStatement();

                String[] campos = estructuraColumnas.split(",");

                ResultSet rq = st.executeQuery("SELECT idregistro," + estructuraColumnas + " FROM poblacionperiodica WHERE "
                        + " idencabezado = " + encabezado_numero[ 1] + " AND numeroidentafiliado = '" + encabezado_numero[ 0] + "'");

                String datosTh = "";
                String datosTd = "";
                while (rq.next()) {
                    for (int n = 0; n < campos.length; n++) {
                        datosTh += "<th>" + reDescripcioListaCampoArchivo(campos[n]) + "</th>";
                        datosTd += "<td>" + rq.getString(campos[n]) + "</td>";
                    }
                }
                String retorno = ""
                        + "<div id=\"registro\">"
                        + "<fieldset><legend>Coincidencias del registro seleccionado</legend>"
                        + "<table border=\"1\"><th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>" + datosTh + ""
                        + "<tr><td>Registro seleccionado</td>" + datosTd + "</tr>"
                        + coincidenciasDelRegistro(request, encabezado_numero, estructuraColumnas, campos, dato)
                        + "</table>"
                        + "</fieldset>"
                        + paginadorTotalCoincidencias(2, dato)
                        + "</div>";



                out.println(retorno);

            } catch (SQLException e) {
                System.out.println(e.getMessage());
            }

        }

        if (request.getParameter("compararRegistro") != null) {
            String dato = request.getParameter("dato");
            // Numero contiene el numero en poblacion periodica, el otro es el encabezado
            String[] numero_encabezado = dato.split("_");
            String numeroPoblacion = request.getParameter("registroPoblacion");

            String estructuraColumnas = UtilidadesDKDA.estructuraColumnas(request);

            String estructuraCorte[] = estructuraColumnas.split(",");

            //

            //
            HashMap registroPeriodica = null;
            HashMap registroPoblacion = null;
            try {
                registroPeriodica = retornarRegistroPoblacionPeriodica(estructuraColumnas, numero_encabezado[ 1], numero_encabezado[ 0]);
                registroPoblacion = retornarRegistroPoblacion(estructuraColumnas, numeroPoblacion);
            } catch (SQLException e) {
                System.out.println(e.getMessage());
            }

            String selects = "";
            String ths = "";
            for (int n = 0; n < estructuraCorte.length; n++) {

                ths += "<th>" + reDescripcioListaCampoArchivo(estructuraCorte[n]) + "</th>";
                String datosSelect1 = registroPoblacion.get(estructuraCorte[n]).toString();
                String datosSelect2 = registroPeriodica.get(estructuraCorte[n]).toString();
                selects += "<td><select name=\"regiComparado_" + estructuraCorte[n] + "\">"
                        + "<option value=\"" + datosSelect1 + "\">" + datosSelect1 + "</option>"
                        + "<option value=\"" + datosSelect2 + "\">" + datosSelect2 + "</option>"
                        + "</select></td>";


            }
            String htmlSelects = "<table border=\"1\">" + ths + "<tr>" + selects + "</tr></table>";



            out.println(htmlSelects);
        }
        if (request.getParameter("procesarComparacion") != null) {
            String valores = request.getParameter("valores");
            String idusuario = request.getParameter("idusuario");
            try {
                // Actualizar el registro de acuerdo a la seleccion en los selects
                Statement st = con.con.createStatement();
                st.executeUpdate("UPDATE poblacion SET " + valores + " WHERE idusuario = " + idusuario);
            } catch (SQLException e) {
                System.out.println(e.getMessage());
            }


        }

        if (request.getParameter("criterioDiferrente") != null) {
            out.println("Borrando datos");

            String ruta = request.getSession().getServletContext().getRealPath("temp") + System.getProperty("file.separator");
            //System.out.println("Ruta " + ruta + "Encabezado " + request.getParameter("encabezado") + "Nombre Archivo " + request.getParameter("nombreArchivo"));
            try {
                File aCoincidencias = new File(getRutas.rutaNovedades("" + request.getParameter("encabezado"), request.getParameter("nombreArchivo"), ruta, "coinci"));
                File aCoincidenciasDetalle = new File(getRutas.rutaNovedades("" + request.getParameter("encabezado"), request.getParameter("nombreArchivo"), ruta, "datoscoinci"));
                File aNovedad = new File(getRutas.rutaNovedades("" + request.getParameter("encabezado"), request.getParameter("nombreArchivo"), ruta, "novedades"));


                if (aCoincidencias.exists()) {
                    aCoincidencias.delete();
                    //System.out.println("Eliminado : " + aCoincidencias);
                }
                if (aCoincidenciasDetalle.exists()) {
                    aCoincidenciasDetalle.delete();
                    //System.out.println("Eliminado : " + aCoincidenciasDetalle);
                }
                if (aNovedad.exists()) {
                    aNovedad.delete();
                    //System.out.println("Eliminado : " + aNovedad);
                }

            } catch (Exception e) {
                System.out.println("Error ubicando archivos temporales carpeta <Nov> " + e);

            }
        }
        if (request.getParameter("cantidadNuevos") != null) {
            out.println(cantConEstadoN(request.getParameter("encabezado")));
        }
        if (request.getParameter("cargarTabla") != null) {
            out.println(request.getParameter("datos"));
        }
        if (request.getParameter("llenarComboSalud") != null) {
            out.println(llenarComboSalud(request.getParameter("regimen"), request.getParameter("entidadSalud")));

        }
        if (request.getParameter("llenarComboMunicipios") != null) {
            //
            response.getWriter().write(llenarComboMunicipios(request.getParameter("departamento"), request.getParameter("municipio")));

        }
        if (request.getParameter("retornarEncabezado") != null) {
            UtilidadesDKDA dkda = new UtilidadesDKDA();
            String mensaje = "";
            try {

                String encabezado = request.getParameter("encabezado");
                PreparedStatement st1 = null;
                ResultSet rs1 = null;
                st1 = con.con.prepareStatement("SELECT COUNT(*) as total FROM encabezadoarchivo WHERE idencabezado = '" + encabezado + "'");
                rs1 = st1.executeQuery();
                rs1.next();

                if (rs1.getInt("total") > 0) {
                    PreparedStatement st = null;
                    ResultSet rs = null;
                    st = con.con.prepareStatement("SELECT * FROM encabezadoarchivo WHERE idencabezado = '" + encabezado + "'");
                    rs = st.executeQuery();
                    rs.next();
                    String tipoCarga = rs.getString("tipoCarga");
                    if (tipoCarga != null) {
                        tipoCarga = tipoCarga.trim();
                        tipoCarga = (tipoCarga.equals("ips") ? "ips" : (tipoCarga.equals("eap") ? "eap" : "poblacion"));
                        mensaje += "text|#codarchivo|" + rs.getString("codarchivo") + ":";
                        mensaje += "text|#nombreenvia|" + rs.getString("nombreenvia") + ":";
                        mensaje += "text|#fechainicial|" + dkda.intertirFecha(rs.getString("fechainicial")) + ":";
                        mensaje += "text|#fechafinal|" + dkda.intertirFecha(rs.getString("fechafinal")) + ":";
                        mensaje += "text|#telefonoenvia|" + rs.getString("telefonoenvia") + ":";
                        mensaje += "text|#emailenvia|" + rs.getString("emailenvia") + ":";
                        mensaje += "text|#fechaenvio|" + dkda.intertirFecha(rs.getString("fechaenvio")) + ":";
                        mensaje += "text|#fecharecibo|" + dkda.intertirFecha(rs.getString("fecharecibo")) + ":";
                        mensaje += "text|#registros|" + rs.getString("registros") + ":";
                        mensaje += "text|#nombreArchivo|" + rs.getString("nombreArchivo") + ":";
                        mensaje += "radio|#" + tipoCarga + "|" + " seleccionarTipoRip('" + (tipoCarga.equals("poblacion") ? "" : tipoCarga) + "', 'true'); :";
                        mensaje += "combo|#codregimen|" + rs.getString("codregimenes") + "|" + "entidadSaludDeAcuerdoAregimen('"+ rs.getString("codentidadsalud") +"') :";
                        //mensaje += "combo|#codentidadsalud|" + rs.getString("codentidadsalud") + ":";
                        mensaje += "combo|#coddepartamento|" + rs.getString("coddepartamento") + "|llenarComboMunicipios('"+ rs.getString("codmunicipio") +"'):";
                        mensaje += "combo|#grupopoblacion|" + rs.getString("codgrupopoblacion") + ":"; 
                        mensaje += "combo|#codigoTipoArchivo|" + rs.getString("codtipoarchivo");
                        //mensaje += "combo|#codmunicipio|" + rs.getString("codmunicipio") + "|alert('prueba')";
                        
                    } else {
                        mensaje = "vacio";
                    }

                } else {
                    mensaje = "vacio";
                }


                out.println(mensaje);



            } catch (SQLException e) {
                System.out.println(e.getMessage());

            }


        }






    }

    private String llenarComboSalud(String regimen, String entidadSalud) {
        UtilidadesDKDA dkda = new UtilidadesDKDA();
        
        
        
        String combo = "";
        ResultSet rs = null;
        PreparedStatement ps = null;
        try {
            con.abrirConexion();
            Statement st = con.con.createStatement();
            rs = st.executeQuery("SELECT * FROM entidadsalud WHERE codregimenes = '" + regimen + "' ORDER BY(nombrehabilitacion) ASC");
            while (rs.next()) {
                
                combo += "<option value='" + rs.getString("codentidadsalud") + "' "+ ( rs.getString("codentidadsalud").equals(entidadSalud) ? "selected" : "" ) +">" + dkda.convertirACarEspecial(rs.getString("nombrehabilitacion")) + "</option>";
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return combo;
    }

    private String llenarComboMunicipios(String departamento, String municipio) {
        UtilidadesDKDA dkda = new UtilidadesDKDA();

        String combo = "";
        ResultSet rs = null;
        PreparedStatement ps = null;
        try {
            con.abrirConexion();
            Statement st = con.con.createStatement();
            rs = st.executeQuery("SELECT * FROM municipio WHERE coddepartamento = '" + departamento + "' "
                    + ( ! municipio.equals("") ? " AND codmunicipio = '"+ municipio +"'" : "" ) +" ORDER BY(nombre) ASC");
            while (rs.next()) {
                combo += "<option value='" + rs.getString("codmunicipio") + "'>" + dkda.convertirACarEspecial(rs.getString("nombre")) + "</option>";
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return combo;
    }

    private HashMap retornarRegistroPoblacionPeriodica(String estructuraColumnas, String idencabezado, String numero) throws SQLException {
        ResultSet rq = null;
        HashMap registros = new HashMap();


        try {
            Statement st = con.con.createStatement();
            rq = st.executeQuery("SELECT " + estructuraColumnas + " FROM poblacionperiodica WHERE idencabezado = " + idencabezado + " AND numeroidentafiliado = '" + numero + "'");
            registros = guardarEnMapa(estructuraColumnas, rq);

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }

        return registros;

    }

    private HashMap retornarRegistroPoblacion(String estructuraColumnas, String numero) throws SQLException {
        ResultSet rq = null;
        HashMap registros = new HashMap();


        try {
            Statement st = con.con.createStatement();
            rq = st.executeQuery("SELECT idusuario," + estructuraColumnas + " FROM poblacion WHERE idusuario = '" + numero + "'");


            registros = guardarEnMapa(estructuraColumnas, rq);

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }

        return registros;

    }

    private HashMap guardarEnMapa(String estructuraColumnas, ResultSet rq) throws SQLException {
        HashMap registros = new HashMap();
        rq.next();
        String estructuraCorte[] = estructuraColumnas.split(",");
        for (int n = 0; n < estructuraCorte.length; n++) {
            registros.put(estructuraCorte[n], rq.getString(estructuraCorte[n]));
        }
        return registros;


    }

    private int registroCoincidentes(String idencabezado, String numero) {
        int cantidad = 0;
        try {
            Statement st = con.con.createStatement();
            ResultSet resultQ = st.executeQuery("SELECT COUNT(*) as cantidad FROM coincpoblacion WHERE idencabezado = " + idencabezado + " AND numeroidentafiliadopp = '" + numero + "'");
            resultQ.next();
            cantidad = resultQ.getInt("cantidad");
        } catch (SQLException e) {
        }
        return cantidad;
    }

    private boolean columnaSeleccionada(HttpServletRequest request, String probar) {
        String columnas = request.getParameter("colsSeleccionadas");
        String columnasCorte[] = columnas.split(",");

        for (int n = 0; n < columnasCorte.length; n++) {
            if ((columnasCorte[n].substring(0, columnasCorte[n].length() - 2)).equals(probar)) {
                return true;
            }
        }
        return false;
        //return true;

    }

    private int cantNovedades(String idencabezado) {
        int cantidad = 0;

        try {

            Statement st = con.con.createStatement();
            ResultSet resultQ = st.executeQuery("SELECT COUNT ( * ) as cantidad FROM novedadcampo WHERE idencabezado = " + idencabezado);
            resultQ.next();
            cantidad = resultQ.getInt("cantidad");
        } catch (SQLException e) {
        }
        return cantidad;
    }

    private int cantCoincidencias(String idencabezado) {
        int cantidad = 0;

        try {

            Statement st = con.con.createStatement();
            ResultSet resultQ = st.executeQuery("SELECT COUNT (DISTINCT  numeroidentafiliadopp ) as cantidad FROM coincpoblacion WHERE idencabezado = " + idencabezado);
            resultQ.next();
            cantidad = resultQ.getInt("cantidad");
        } catch (SQLException e) {
        }
        return cantidad;
    }

    private int cantConEstadoN(String idencabezado) {
        int cantidad = 0;
        con = new ConexionBaseDatos();
        try {
            con.abrirConexion();
            Statement st = con.con.createStatement();
            ResultSet resultQ = st.executeQuery("SELECT COUNT(*) as cantidad FROM poblacionperiodica WHERE codestadousuapoblac = 'N' and idencabezado = " + idencabezado);
            resultQ.next();
            cantidad = resultQ.getInt("cantidad");
        } catch (SQLException e) {
        }
        return cantidad;

    }

    public void guardarNuevos(HttpServletRequest request, String encabezado, String estructura) {
        boolean estado = true;
        String sql = "";
        String opcion = request.getParameter("opcion");
        String seleccionados = request.getParameter("seleccionados");
        System.out.println( "ESTRUCTURA  " + estructura );
        
        try {
            if (opcion.equals("algunos")) {
                
                sql = "INSERT INTO poblacion (idusuario," + estructura + ") "
                        + "SELECT nextval('idusuario_seq')," + aplicarCambiosConsulta(request, estructura) + " FROM "
                        + "poblacionperiodica WHERE codestadousuapoblac = 'N' AND idencabezado = " + encabezado + " AND "
                        + " idregistro IN(" + seleccionados + ")";

            } else if (opcion.equals("todos")) {
                sql = "INSERT INTO poblacion (idusuario," + estructura + ") "
                        + "SELECT nextval('idusuario_seq')," + aplicarCambiosConsulta(request, estructura) + " FROM "
                        + "poblacionperiodica WHERE codestadousuapoblac = 'N' AND idencabezado = " + encabezado;

            }
            System.out.println( sql );
            Statement st = con.con.createStatement();
            ResultSet resultQ = st.executeQuery(sql);



        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        quitarEstadosNPoblacionPeriodica(opcion, encabezado, seleccionados);

        System.out.println(sql);

    }

    private void quitarEstadosNPoblacionPeriodica(String opcion, String idencabezado, String seleccionados) {
        try {
            Statement st = con.con.createStatement();


            ResultSet resultQ = st.executeQuery("UPDATE poblacionperiodica SET codestadousuapoblac = '' WHERE "
                    + (opcion.equals("algunos") ? " idregistro IN(" + seleccionados + ") AND " : "") + "  idencabezado = " + idencabezado);

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    private String reDescripcioListaCampoArchivo(String campo) {
        String descripcion = "";
        try {
            Statement st = con.con.createStatement();
            ResultSet rs = st.executeQuery("SELECT descripcion FROM listacamposarchivo WHERE nombrecampotabla = '" + campo + "'");
            rs.next();
            descripcion = rs.getString("descripcion");

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return descripcion;
    }

    private String aplicarCambiosConsulta(HttpServletRequest request, String estructura) {
        String nuevaEstructura = "";
        String[] estructuraCorte = estructura.split(",");

        for (int n = 0; n < estructuraCorte.length; n++) {
            if (tiposFecha(request, estructuraCorte[n])) {
                nuevaEstructura += "to_date( " + estructuraCorte[n] + ", '' ),";
                continue;
            }
            nuevaEstructura += estructuraCorte[n] + ",";
        }

        return nuevaEstructura.substring(0, nuevaEstructura.length() - 1);
    }

    private boolean tiposFecha(HttpServletRequest request, String comparar) {
        String tiposFechas = "fechanacimiento";
        String[] fechasCorte = tiposFechas.split(",");
        for (int n = 0; n < fechasCorte.length; n++) {
            if (fechasCorte[n].equals(comparar)) {
                return true;
            }
        }
        return false;

    }

    public void reestablecerCriteriosNovedades() {
        // Aqui me dice los parametros que necesita
    }

    private String coincidenciasDelRegistro(HttpServletRequest request, String[] encabezado_numero, String estructuraColumnas, String[] campos, String dato) {

        String datosTr = "";
        String paginador = "";

        int TAMANIO = 30;
        String pagina = request.getParameter("pagina") != null ? request.getParameter("pagina") : "1";
        int inicio = (Integer.parseInt(pagina) - 1) * TAMANIO;

        try {
            Statement st2 = con.con.createStatement();


            ResultSet rq2 = st2.executeQuery("SELECT numeroidentafiliadop FROM coincpoblacion WHERE numeroidentafiliadopp = '" + encabezado_numero[ 0] + "' "
                    + " AND idencabezado = '" + encabezado_numero[ 1] + "'");

            System.out.println(">> : " + "SELECT numeroidentafiliadop FROM coincpoblacion WHERE numeroidentafiliadopp = '" + encabezado_numero[ 0] + "' "
                    + " AND idencabezado = '" + encabezado_numero[ 1] + "'");


            String numeroidentafiliadop = "";

            Statement st3 = con.con.createStatement();
            int total_coincidencias = 0;
            while (rq2.next()) {
                numeroidentafiliadop += "'" + rq2.getString("numeroidentafiliadop") + "',";
                total_coincidencias++;
            }
            this.totalCoincidencias = total_coincidencias;

            ResultSet rq3 = st3.executeQuery("SELECT idusuario," + estructuraColumnas + " FROM poblacion WHERE numeroidentafiliado "
                    + "IN( " + numeroidentafiliadop.substring(0, numeroidentafiliadop.length() - 1) + " ) "
                    + "LIMIT " + TAMANIO + " OFFSET " + inicio);


            System.out.println(">>>>> : " + "SELECT idusuario," + estructuraColumnas + " FROM poblacion WHERE numeroidentafiliado "
                    + "IN( " + numeroidentafiliadop.substring(0, numeroidentafiliadop.length() - 1) + " ) "
                    + "LIMIT " + TAMANIO + " OFFSET " + inicio);


            String datosTd = "";

            while (rq3.next()) {

                for (int n = 0; n < campos.length; n++) {
                    datosTd += "<td>" + rq3.getString(campos[n]) + "</td>";
                }
                datosTr += "<tr><td><input type=\"submit\" value=\"Comparar con este registro\" name=\"comparar_" + rq3.getString("idusuario") + "\" id=\"" + rq3.getString("idusuario") + "\" onclick=\"compararRegistro(\'" + dato + "\', this.id)\" /></td>" + datosTd + "</tr>";
                datosTd = "";
            }


        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return datosTr;
    }

    private String paginadorTotalCoincidencias(int TAMANIO, String dato) {
        /* Paginador */
        String paginador = "";
        float total_paginas = (float) Math.ceil((double) this.totalCoincidencias / (double) TAMANIO);

        for (int n = 1; n <= total_paginas; n++) {
            paginador += " <a href=\"#\" onclick=\"verCoincidentesDelRegistro(\'" + dato + "\', " + n + "); return false\">" + n + "</a>&nbsp;";
        }
        return "P&aacute;gina " + paginador;

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
