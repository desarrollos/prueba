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
import clases.PoolDB;
import clases.UtilidadesDKDA;
import clases.bdS;
import clases.ed_ValidacionCampos;
import clases.estadosSQL;
import java.sql.*;
import java.net.URLDecoder;

/**
 *
 * @author Sebas
 */
public class Empresas extends HttpServlet {

    ConexionBaseDatos con;
    HashMap vars = new HashMap();
    String respuesta = "";
    funciones fun = new funciones();
    UtilidadesDKDA dkda = new UtilidadesDKDA();
    HttpServletRequest request;
    private String string;
    ed_ValidacionCampos v = null;
    PoolDB p ;
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String parametros = new String(URLDecoder.decode(request.getParameter("parametros")).getBytes(), "UTF-8");
        vars = clases.UtilidadesDKDA.urlDecodificar(parametros, "");

        p = new PoolDB();

        con = new ConexionBaseDatos();
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        this.request = request;
        v = new clases.ed_ValidacionCampos();
        respuesta = "";

        try {
            String opcion = dkda.o(vars, "accion").toString();

            respuesta = "";
            String respuesta = validarFormulario_Empresas();


            if (respuesta.length() > 0 && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                out.println(respuesta);
            } else {

                System.out.println("OPCION : " + opcion);

                if (opcion.equals("Registrar")) {


                    out.println(registrar_Empresas(con));


                }
                if (opcion.equals("Obtener")) {

                    out.println(obtener_Empresas(con, dkda.o(vars, "codigo").toString()));



                }
                if (opcion.equals("Actualizar")) {

                    out.println(actualizar_Empresas(con));

                }
            }
        } finally {
            out.close();
        }

    }

    public String registrar_Empresas(ConexionBaseDatos con) {

        System.out.println("REGISGRANDO EMPRESAS");
        con.abrirConexion();
        // 
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "INSERT INTO empresa "
                    + "(codtipoidentidad, codempresa, digitoverificacion, nombre, sigla, "
                    + "telefono, fax, lineagratuita, coddepartamento, codmunicipio, "
                    + "codsubgrupo, codbarrio, direccion, gerente, codactividadeconomica, "
                    + "codsectorentidad, codtipoaportante, email, paginaweb, codtipocontribuyente, "
                    + "codclasepersona, empresasistema, empcodigodane, ususiscodigo, "
                    + "fecharegistro) "
                    + "VALUES("
                    + "'" + dkda.o(vars, "codtipoidentidad_empresa") + "',"
                    + "'" + dkda.o(vars, "codempresa_empresa") + "',"
                    + "'" + dkda.o(vars, "digitoverificacion_empresa") + "',"
                    + "'" + dkda.o(vars, "nombre_empresa") + "',"
                    + "'" + dkda.o(vars, "sigla_empresa") + "',"
                    + "'" + dkda.o(vars, "telefono_empresa") + "',"
                    + "'" + dkda.o(vars, "fax_empresa") + "',"
                    + "'" + dkda.o(vars, "lineagratuita_empresa") + "',"
                    + "'" + dkda.o(vars, "coddepartamento_empresa") + "',"
                    + "'" + dkda.o(vars, "codmunicipio_empresa") + "',"
                    + "'" + dkda.o(vars, "codsubgrupo_empresa") + "',"
                    + "'" + dkda.o(vars, "codbarrio_empresa") + "',"
                    + "'" + dkda.o(vars, "direccion_empresa") + "',"
                    + "'" + dkda.o(vars, "gerente_empresa") + "',"
                    + "'" + dkda.o(vars, "codactividadeconomica_empresa") + "',"
                    + "'" + dkda.o(vars, "codsectorentidad_empresa") + "',"
                    + "'" + dkda.o(vars, "codtipoaportante_empresa") + "',"
                    + "'" + dkda.o(vars, "email_empresa") + "',"
                    + "'" + dkda.o(vars, "paginaweb_empresa") + "',"
                    + "'" + dkda.o(vars, "codtipocontribuyente_empresa") + "',"
                    + "'" + dkda.o(vars, "codclasepersona_empresa") + "',"
                    + "'" + dkda.o(vars, "empresasistema_empresa") + "',"
                    + "'" + dkda.o(vars, "empcodigodane_empresa") + "',"
                    + "'DELPHOS',"
                    + "'NOW()')";



            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_empresa&&estado=si&&error=no&&errorDes=no";

        } catch (SQLException e) {
            //23503 - viola la llave foránea «Refbarrio301»  Detail: La llave
            String error = estadosSQL.getM(e.getSQLState(), e.getMessage());
            respuesta = "opcion=registrar_empresa&&estado=no&&error=si&&errorDes=" + error;
            System.out.println("Error registrar_Empresas.java: " + error);
        }

        con.cerrarConexion();
        return respuesta;

    }

    public String obtener_Empresas(ConexionBaseDatos con, String codigo) {
        System.out.println("obtener:  " + codigo);

        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = ""
                    + "SELECT "
                    + "empresa.codtipoidentidad AS empresa_codtipoidentidad,"
                    + "empresa.codempresa AS empresa_codempresa,"
                    + "empresa.digitoverificacion AS empresa_digitoverificacion,"
                    + "empresa.nombre AS empresa_nombre,"
                    + "empresa.sigla AS empresa_sigla,"
                    + "empresa.telefono AS empresa_telefono,"
                    + "empresa.fax AS empresa_fax,"
                    + "empresa.lineagratuita AS empresa_lineagratuita,"
                    + "empresa.coddepartamento AS empresa_coddepartamento,"
                    + "empresa.codmunicipio AS empresa_codmunicipio,"
                    + "empresa.codsubgrupo AS empresa_codsubgrupo,"
                    + "empresa.codbarrio AS empresa_codbarrio,"
                    + "empresa.direccion AS empresa_direccion,"
                    + "empresa.gerente AS empresa_gerente,"
                    + "empresa.codactividadeconomica AS empresa_codactividadeconomica,"
                    + "empresa.codsectorentidad AS empresa_codsectorentidad,"
                    + "empresa.codtipoaportante AS empresa_codtipoaportante,"
                    + "empresa.email AS empresa_email,"
                    + "empresa.paginaweb AS empresa_paginaweb,"
                    + "empresa.codtipocontribuyente AS empresa_codtipocontribuyente,"
                    + "empresa.codclasepersona AS empresa_codclasepersona,"
                    + "empresa.empresasistema AS empresa_empresasistema,"
                    + "empresa.empcodigodane AS empresa_empcodigodane,"
                    + "empresa.ususiscodigo AS empresa_ususiscodigo,"
                    + "empresa.fecharegistro AS empresa_fecharegistro,"
                    + "tipoidentificacion.codtipoidentidad AS tipoidentificacion_codtipoidentidad,"
                    + "tipoidentificacion.codalterno AS tipoidentificacion_codalterno,"
                    + "tipoidentificacion.descripcion AS tipoidentificacion_descripcion,"
                    + "tipoidentificacion.ususiscodigo AS tipoidentificacion_ususiscodigo,"
                    + "tipoidentificacion.fecharegistro AS tipoidentificacion_fecharegistro,"
                    + "tipocontribuyente.codtipocontribuyente AS tipocontribuyente_codtipocontribuyente,"
                    + "tipocontribuyente.descripcion AS tipocontribuyente_descripcion,"
                    + "tipocontribuyente.observacion AS tipocontribuyente_observacion,"
                    + "tipocontribuyente.ususiscodigo AS tipocontribuyente_ususiscodigo,"
                    + "tipocontribuyente.fecharegistro AS tipocontribuyente_fecharegistro,"
                    + "tipoaportante.codtipoaportante AS tipoaportante_codtipoaportante,"
                    + "tipoaportante.descripcion AS tipoaportante_descripcion,"
                    + "tipoaportante.ususiscodigo AS tipoaportante_ususiscodigo,"
                    + "tipoaportante.fecharegistro AS tipoaportante_fecharegistro,"
                    + "sectorentidad.codsectorentidad AS sectorentidad_codsectorentidad,"
                    + "sectorentidad.descripcion AS sectorentidad_descripcion,"
                    + "sectorentidad.ususiscodigo AS sectorentidad_ususiscodigo,"
                    + "sectorentidad.fecharegistro AS sectorentidad_fecharegistro,"
                    + "clasepersona.codclasepersona AS clasepersona_codclasepersona,"
                    + "clasepersona.descripcion AS clasepersona_descripcion,"
                    + "clasepersona.ususiscodigo AS clasepersona_ususiscodigo,"
                    + "clasepersona.fecharegistro AS clasepersona_fecharegistro,"
                    + "barrio.coddepartamento AS barrio_coddepartamento,"
                    + "barrio.codmunicipio AS barrio_codmunicipio,"
                    + "barrio.codsubgrupo AS barrio_codsubgrupo,"
                    + "barrio.codbarrio AS barrio_codbarrio,"
                    + "barrio.nombre AS barrio_nombre,"
                    + "barrio.representante AS barrio_representante,"
                    + "barrio.habitantes AS barrio_habitantes,"
                    + "barrio.mapa AS barrio_mapa,"
                    + "barrio.archivofi AS barrio_archivofi,"
                    + "barrio.ususiscodigo AS barrio_ususiscodigo,"
                    + "barrio.fecharegistro AS barrio_fecharegistro,"
                    + "actividadeconomica.codactividadeconomica AS actividadeconomica_codactividadeconomica,"
                    + "actividadeconomica.descripcion AS actividadeconomica_descripcion,"
                    + "actividadeconomica.ususiscodigo AS actividadeconomica_ususiscodigo,"
                    + "actividadeconomica.fecharegistro AS actividadeconomica_fecharegistro,"
                    + "departamento.nombre AS departamento_nombre, "
                    + "municipio.nombre AS municipio_nombre ,"
                    + "subgrupogeografico.nombre AS subgrupogeografico_nombre "
                    + " FROM "
                    + "public.tipoidentificacion tipoidentificacion INNER JOIN public.empresa empresa ON tipoidentificacion.codtipoidentidad = empresa.codtipoidentidad "
                    + "INNER JOIN public.tipocontribuyente tipocontribuyente ON empresa.codtipocontribuyente = tipocontribuyente.codtipocontribuyente "
                    + "INNER JOIN public.tipoaportante tipoaportante ON empresa.codtipoaportante = tipoaportante.codtipoaportante "
                    + "INNER JOIN public.sectorentidad sectorentidad ON empresa.codsectorentidad = sectorentidad.codsectorentidad "
                    + "INNER JOIN public.clasepersona clasepersona ON empresa.codclasepersona = clasepersona.codclasepersona "
                    + "INNER JOIN public.barrio barrio ON empresa.coddepartamento = barrio.coddepartamento "
                    + "AND barrio.codsubgrupo = empresa.codsubgrupo "
                    + "AND barrio.codbarrio = empresa.codbarrio "
                    + "AND barrio.codmunicipio = empresa.codmunicipio "
                    + "INNER JOIN public.actividadeconomica actividadeconomica ON empresa.codactividadeconomica = actividadeconomica.codactividadeconomica "
                    + "INNER JOIN public.departamento departamento ON empresa.coddepartamento = departamento.coddepartamento "
                    + "INNER JOIN public.municipio municipio ON empresa.codmunicipio = municipio.codmunicipio "
                    + "INNER JOIN public.subgrupogeografico subgrupogeografico ON empresa.coddepartamento = subgrupogeografico.coddepartamento "
                    + "AND empresa.codsubgrupo = subgrupogeografico.codsubgrupo "
                    + "AND empresa.codmunicipio = subgrupogeografico.codmunicipio "
                    + "AND municipio.coddepartamento = subgrupogeografico.coddepartamento "
                    + "AND municipio.codmunicipio = subgrupogeografico.codmunicipio "
                    + "AND subgrupogeografico.coddepartamento = barrio.coddepartamento "
                    + "AND subgrupogeografico.codsubgrupo = barrio.codsubgrupo "
                    + "AND subgrupogeografico.codmunicipio = barrio.codmunicipio "
                    + "AND departamento.coddepartamento = municipio.coddepartamento "
                    + " WHERE empresa.codempresa = '" + codigo + "'";


            //System.out.println(sql);


            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();

            info += "combo|#codtipoidentidad_empresa|" + rs.getString("empresa_codtipoidentidad")
                    + "|llenarCombo('codtipoidentidad_empresa', '" + rs.getString("empresa_codtipoidentidad")
                    + "', '" + rs.getString("tipoidentificacion_descripcion") + "'):_";
            
            info += "text|#codempresa_empresa|"
                    + (rs.getString("empresa_codempresa") == null ? ""
                    : rs.getString("empresa_codempresa")) + ":_";


            info += "text|#digitoverificacion_empresa|"
                    + (rs.getString("empresa_digitoverificacion") == null ? "" : rs.getString("empresa_digitoverificacion")) + ":_";

            info += "text|#nombre_empresa|"
                    + (rs.getString("empresa_nombre") == null ? "" : rs.getString("empresa_nombre")) + ":_";

            info += "text|#sigla_empresa|"
                    + (rs.getString("empresa_sigla") == null ? "" : rs.getString("empresa_sigla")) + ":_";

            info += "text|#sigla_empresa|"
                    + (rs.getString("empresa_sigla") == null ? "" : rs.getString("empresa_sigla")) + ":_";

            info += "text|#telefono_empresa|"
                    + (rs.getString("empresa_telefono") == null ? "" : rs.getString("empresa_telefono")) + ":_";

            info += "text|#fax_empresa|"
                    + (rs.getString("empresa_fax") == null ? "" : rs.getString("empresa_fax")) + ":_";

            info += "text|#lineagratuita_empresa|"
                    + (rs.getString("empresa_lineagratuita") == null ? "" : rs.getString("empresa_lineagratuita")) + ":_";


            info += "combo|#coddepartamento_empresa|" + rs.getString("empresa_coddepartamento")
                    + "|llenarCombo('coddepartamento_empresa', '" + rs.getString("empresa_coddepartamento")
                    + "', '" + rs.getString("departamento_nombre") + "'):_";

            info += "combo|#codmunicipio_empresa|" + rs.getString("empresa_codmunicipio")
                    + "|llenarCombo('codmunicipio_empresa', '" + rs.getString("empresa_codmunicipio")
                    + "', '" + rs.getString("municipio_nombre") + "'):_";

            info += "combo|#codsubgrupo_empresa|" + rs.getString("empresa_codsubgrupo")
                    + "|llenarCombo('codsubgrupo_empresa', '" + rs.getString("empresa_codsubgrupo")
                    + "', '" + rs.getString("subgrupogeografico_nombre") + "'):_";

            info += "combo|#codbarrio_empresa|" + rs.getString("empresa_codbarrio")
                    + "|llenarCombo('codbarrio_empresa', '" + rs.getString("empresa_codbarrio")
                    + "', '" + rs.getString("barrio_nombre") + "'):_";

            info += "text|#direccion_empresa|"
                    + (rs.getString("empresa_direccion") == null ? "" : rs.getString("empresa_direccion")) + ":_";

            info += "text|#gerente_empresa|"
                    + (rs.getString("empresa_gerente") == null ? "" : rs.getString("empresa_gerente")) + ":_";

            info += "combo|#codactividadeconomica_empresa|" + rs.getString("empresa_codactividadeconomica")
                    + "|llenarCombo('codactividadeconomica_empresa', '" + rs.getString("empresa_codactividadeconomica")
                    + "', '" + rs.getString("actividadeconomica_descripcion") + "'):_";


            info += "combo|#codsectorentidad_empresa|" + rs.getString("empresa_codsectorentidad")
                    + "|llenarCombo('codsectorentidad_empresa', '" + rs.getString("empresa_codsectorentidad")
                    + "', '" + rs.getString("sectorentidad_descripcion") + "'):_";

            info += "combo|#codtipoaportante_empresa|" + rs.getString("empresa_codtipoaportante")
                    + "|llenarCombo('codtipoaportante_empresa', '" + rs.getString("empresa_codtipoaportante")
                    + "', '" + rs.getString("tipoaportante_descripcion") + "'):_";

            info += "text|#email_empresa|"
                    + (rs.getString("empresa_email") == null ? "" : rs.getString("empresa_email")) + ":_";

            info += "text|#email_empresa|"
                    + (rs.getString("empresa_email") == null ? "" : rs.getString("empresa_email")) + ":_";

            info += "text|#paginaweb_empresa|"
                    + (rs.getString("empresa_paginaweb") == null ? "" : rs.getString("empresa_paginaweb")) + ":_";


            info += "combo|#codtipocontribuyente_empresa|" + rs.getString("empresa_codtipocontribuyente")
                    + "|llenarCombo('codtipocontribuyente_empresa', '" + rs.getString("empresa_codtipocontribuyente")
                    + "', '" + rs.getString("tipocontribuyente_descripcion") + "'):_";

            info += "combo|#codclasepersona_empresa|" + rs.getString("empresa_codclasepersona")
                    + "|llenarCombo('codclasepersona_empresa', '" + rs.getString("empresa_codclasepersona")
                    + "', '" + rs.getString("clasepersona_descripcion") + "'):_";

            info += "switch|switch_empresasistema_empresa|" + rs.getString("empresa_empresasistema") + ":_";

            info += "text|#empcodigodane_empresa|"
                    + (rs.getString("empresa_empcodigodane") == null ? "" : rs.getString("empresa_empcodigodane")) + ":_";


            respuesta = "opcion=obtener_empresa&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");

        } catch (SQLException e) {
            respuesta = "opcion=obtener_empresa&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error Empresa - Obtener.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        System.out.println(respuesta);
        return respuesta;

    }

    public String actualizar_Empresas(ConexionBaseDatos con) {
        con.abrirConexion();

        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE empresa SET "
                    + "codtipoidentidad='" + dkda.o(vars, "codtipoidentidad_empresa") + "', "
                    + "digitoverificacion='" + dkda.o(vars, "digitoverificacion_empresa") + "',"
                    + " nombre='" + dkda.o(vars, "nombre_empresa") + "', "
                    + "sigla='" + dkda.o(vars, "sigla_empresa") + "', "
                    + "telefono='" + dkda.o(vars, "telefono_empresa") + "', "
                    + "fax='" + dkda.o(vars, "fax_empresa") + "',"
                    + " lineagratuita='" + dkda.o(vars, "lineagratuita_empresa") + "',"
                    + " coddepartamento='" + dkda.o(vars, "coddepartamento_empresa") + "', "
                    + "codmunicipio='" + dkda.o(vars, "codmunicipio_empresa") + "',"
                    + " codsubgrupo='" + dkda.o(vars, "codsubgrupo_empresa") + "', "
                    + "codbarrio='" + dkda.o(vars, "codbarrio_empresa") + "',"
                    + " direccion='" + dkda.o(vars, "direccion_empresa") + "',"
                    + " gerente='" + dkda.o(vars, "gerente_empresa") + "', "
                    + "codactividadeconomica='" + dkda.o(vars, "codactividadeconomica_empresa") + "', "
                    + "codsectorentidad='" + dkda.o(vars, "codsectorentidad_empresa") + "',"
                    + " " + "codtipoaportante='" + dkda.o(vars, "codtipoaportante_empresa") + "', "
                    + "email='" + dkda.o(vars, "email_empresa") + "',"
                    + " paginaweb='" + dkda.o(vars, "paginaweb_empresa") + "',"
                    + " codtipocontribuyente='" + dkda.o(vars, "codtipocontribuyente_empresa") + "',"
                    + " codclasepersona='" + dkda.o(vars, "codclasepersona_empresa") + "', "
                    + "empresasistema='" + dkda.o(vars, "empresasistema_empresa") + "',"
                    + " empcodigodane='" + dkda.o(vars, "empcodigodane_empresa") + "', ususiscodigo='DELPHOS', fecharegistro='NOW()'"
                    + " WHERE codempresa = '" + dkda.o(vars, "codigo") + "'";

            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_empresa&&estado=si&&error=no&&errorDes=no&&codigo=4";

        } catch (SQLException e) {
            respuesta = "opcion=actualizar_empresa&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error Empresas.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;



    }

    public String validarFormulario_Empresas() {
        //noPool();
      //  Pool();
        pool2();
        // Estas urls yo las controlo ya las estoy configurando..
        // sirven para llamar el javascript para valir...
        String direccion = "opcion=validacion&&estado=no&&error=si&&errorDes=";
        String error = "";
        // Aqui en adelante se colocan las validaciones que uno quiere
        // en "error" se guarda el mensaje a mostrar
        // error solo contiene un mensaje por validacion
        // Ok... entonces para validar otro campo por ejemplo
        // eso que seleccione es el nombre del id en el .jsp
        // puede obtenerlo de dos maneras
        // 1 .  Desde el .jsp directamente ( recomendado )
        // -> Entonces el id o name jeje
        // -> mejor el id el name avces vario cuando es swhitch


        /*** Inicio Validar Existencia por codempresa*/
        if (existeEmpresa()) {
            error = "Identificación Empresa: Ya existe otra empresa con esa identificación. Verifiquela por favor";
        }
        /*** Fin Validar Existencia por codempresa*/
        /*** Inicio Validar Vacio */
        if (dkda.o(vars, "codtipoidentidad_empresa").equals("")) {
            error = "Tipo Identificación: no puede ser vacio.";
        } else if (dkda.o(vars, "codempresa_empresa").equals("")) {
            error = "Identificación Empresa: no puede ser vacio.";
        } else if (dkda.o(vars, "nombre_empresa").equals("")) {
            error = "Nombre Empresa: no se permite vacio.";
        } /*** Fin Validar Vacio */
        /*** Inicio Validar Tipo Dato */
        else if (!v.alfaNumericos(dkda.o(vars, "codempresa_empresa"))) {
            error = "Identificación Empresa: tiene caracteres no permitidos.";
        } //digito verificacion
        else if ((!v.numeros(dkda.o(vars, "digitoverificacion_empresa"))) && (!dkda.o(vars, "digitoverificacion_empresa").isEmpty())) {
            error = "Dígito Verificación: Solo es permitido un Numero.";
        } else if ((v.numeros(dkda.o(vars, "digitoverificacion_empresa"))) && (dkda.o(vars, "digitoverificacion_empresa").trim().length() > 1)) {
            error = "Dígito Verificación: Solo es permitido un Numero..";
        } else if (!v.alfaNumericos(dkda.o(vars, "nombre_empresa"))) {
            error = "Nombre Empresa: tiene caracteres no permitidos.";
        } else if ((!v.alfaNumericos(dkda.o(vars, "sigla_empresa"))) && (!dkda.o(vars, "sigla_empresa").isEmpty())) {
            error = "Sigla: tiene caracteres no permitidos.";
        } else if ((!v.alfaNumericos(dkda.o(vars, "telefono_empresa"))) && (!dkda.o(vars, "telefono_empresa").isEmpty())) {
            error = "Teléfono: tiene caracteres no permitidos.";
        } else if ((!v.alfaNumericos(dkda.o(vars, "fax_empresa"))) && (!dkda.o(vars, "fax_empresa").isEmpty())) {
            error = "Fax: tiene caracteres no permitidos.";
        } else if ((!v.alfaNumericos(dkda.o(vars, "lineagratuita_empresa"))) && (!dkda.o(vars, "lineagratuita_empresa").isEmpty())) {
            error = "Línea Gratuita: tiene caracteres no permitidos.";
        } //        else if ( (!v.alfaNumericos(dkda.o(vars, "direccion_empresa"))) || (!dkda.o(vars, "direccion_empresa").isEmpty())   ) {
        //            error = "Dirección: tiene caracteres no permitidos.";
        //        }
        else if ((!v.caracteres(dkda.o(vars, "gerente_empresa"))) && (!dkda.o(vars, "gerente_empresa").isEmpty())) {
            error = "Gerente: tiene caracteres no permitidos.";
        } else if ((!v.correo(dkda.o(vars, "email_empresa"))) && (!dkda.o(vars, "email_empresa").isEmpty())) {
            error = "Correo Electronico: No es un E-Mail valido";
        } else if ((!v.url(dkda.o(vars, "paginaweb_empresa"))) && (!dkda.o(vars, "paginaweb_empresa").isEmpty())) {
            error = "Página Web: No es una url Valida";
        } else if ((!v.alfaNumericos(dkda.o(vars, "empcodigodane_empresa"))) && (!dkda.o(vars, "empcodigodane_empresa").isEmpty())) {
            error = "Código Dane Empresa: tiene caracteres no permitidos.";
        }
        /*** Fin Validar Tipo Dato */

        
        respuesta = (error.length() > 1 ? direccion + "<strong>" + error + "</strong>" : "");

        return respuesta;
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

    public boolean existeEmpresa() {
        // UT004 - ESS207 - CCF045
        PreparedStatement pQuery = null;
        ResultSet rQuery = null;
        Connection conexion = bdS.getConexion();
        boolean existe = true;
        try {                                                                            //
            pQuery = conexion.prepareStatement("SELECT COUNT(*) FROM empresa WHERE codempresa ='" + dkda.o(vars, "codempresa_empresa") + "'");
            //System.out.println("1. SELECT codtipoestrucarch FROM tipoestructarch WHERE codregimen='" + codRegimen + "'");
            rQuery = pQuery.executeQuery();
            rQuery.next();
            existe = rQuery.getInt(1) > 0 ? true : false;
            System.out.println("existeEmpresa() => " + rQuery.getInt(1));
            pQuery.close();
            rQuery.close();

        } catch (SQLException e) {
            System.err.println("( existeEmpresa() ) " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
            
        }
        return existe;
    }


    void Pool(){
        
        PreparedStatement pQuery = null;
        ResultSet rQuery = null;

        boolean existe = true;
        try {
            Connection conexion = bdS.getConexionD().getConnection();
            pQuery = conexion.prepareStatement("SELECT COUNT(*) FROM poblacionperiodica");
            //System.out.println("1. SELECT codtipoestrucarch FROM tipoestructarch WHERE codregimen='" + codRegimen + "'");
            rQuery = pQuery.executeQuery();
            rQuery.next();
            //existe = rQuery.getInt(1) > 0 ? true : false;
            System.out.println("Pool()  Pool  Pool !! => " + rQuery.getInt(1));
            pQuery.close();
            rQuery.close();


            //bdS.liberaConexion(conexion);

        } catch (SQLException e) {
            System.err.println("( Pool() ) Error al consultar los campos de la tabla: " + e);
        }finally{
            
        }

    }
    void noPool(){
        
        PreparedStatement pQuery = null;
        ResultSet rQuery = null;

        boolean existe = true;
        try {
            Connection conexion = bdS.getConexion();
            pQuery = conexion.prepareStatement("SELECT COUNT(*) FROM poblacionperiodica");
            //System.out.println("1. SELECT codtipoestrucarch FROM tipoestructarch WHERE codregimen='" + codRegimen + "'");
            rQuery = pQuery.executeQuery();
            rQuery.next();
            //existe = rQuery.getInt(1) > 0 ? true : false;
            System.out.println("no Pool()  no Pool  no Pool !! => " + rQuery.getInt(1));
            pQuery.close();
            rQuery.close();

            

        } catch (SQLException e) {
            System.err.println("( Pool() ) Error al consultar los campos de la tabla: " + e);
        }
    }


    void pool2(){

        

        PreparedStatement pQuery = null;
        ResultSet rQuery = null;

        boolean existe = true;
        try {
            Connection conexion = p.extraerConexion();
            pQuery = conexion.prepareStatement("SELECT COUNT(*) FROM poblacionperiodica");
            //System.out.println("1. SELECT codtipoestrucarch FROM tipoestructarch WHERE codregimen='" + codRegimen + "'");
            rQuery = pQuery.executeQuery();
            rQuery.next();
            //existe = rQuery.getInt(1) > 0 ? true : false;
            System.out.println("Pool()  Pool  Pool !! => " + rQuery.getInt(1));
            pQuery.close();
            rQuery.close();


            p.liberarConexion(conexion);

        } catch (SQLException e) {
            System.err.println("( Pool() ) Error al consultar los campos de la tabla: " + e);
        }finally{

        }

    }
}
