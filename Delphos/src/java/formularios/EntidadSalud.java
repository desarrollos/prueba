/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package formularios;

import clases.ed_ValidacionCampos;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import clases.ConexionBaseDatos;
import clases.UtilidadesDKDA;
import clases.bdS;
import java.io.UnsupportedEncodingException;
import java.sql.*;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.charset.CharsetDecoder;

/**
 *
 * @author Sebas
 */
public class EntidadSalud extends HttpServlet {

    ConexionBaseDatos con;
    HashMap vars = new HashMap();
    String respuesta = "";
    funciones fun = new funciones();
    UtilidadesDKDA dkda = new UtilidadesDKDA();
    HttpServletRequest request;
    private String string;
    private ed_ValidacionCampos v;
    HashMap sel,regimen,empresa,tipoentidadsalud,nivelcomplejidad,clasificacionentidad,tipoespecializacionsalud,tipoatencion,estadoentidadsalud;

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
        v = new clases.ed_ValidacionCampos();

        con = new ConexionBaseDatos();
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        this.request = request;
        respuesta = "";
        
        empresa= fun.map(dkda.o(vars, "empresa_entidadsalud").toString());
        sel = fun.map(dkda.o(vars, "codigo").toString());
        
        
        System.out.println( "EMPRESA :  " +  dkda.o(empresa, "codtipoidentidad") );
        String sql = "DELETE FROM entidadsalud WEHRE codregimenes = '"+ dkda.o(sel, "codregimenes") +"' AND codentidadsalud = '"+ dkda.o(sel, "codentidadsalud") +"' ";
        System.out.println( sql );
        
        
        //selEmpresa = fun.map(dkda.o(vars, "codempresa").toString());
        
        /*
        System.out.println("codtipoidentidad: "  +  dkda.o(selEmpresa, "codtipoidentidad") );  
        
        try {
            String opcion = dkda.o(vars, "accion").toString();
            
            if (opcion.equals("Registrar") || opcion.equals("Actualizar")) {
                respuesta = validarFormulario();
            }

            if (respuesta.length() > 0) {
                System.out.println("ENRTRA RESPUESTA");
                out.println(respuesta);
            } else {
                if (opcion.equals("Registrar")) {
                    out.println(registrarEntidadSalud(con));
                }
                if (opcion.equals("Obtener")) {
                    out.println(obtenerFormulario(con, dkda.o(vars, "codigo").toString()));
                }
                if (opcion.equals("Actualizar")) {
                    out.println(actualizarEntidadSalud(con));
                }
                if (opcion.equals("Eliminar")) {
                    out.println(eliminarEntidadSalud(con, dkda.o(vars, "codigo").toString()));
                }
                
            }
        } finally {
            out.close();
        }*/
    }

    public String registrarEntidadSalud(ConexionBaseDatos con) {
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            /*
            String sql = "INSERT INTO "
                    + "entidadsalud(codregimenes,codentidadsalud,codtipoentidadsalud,codempresa,codnivelcomplejidad, codclasifentidad, contacto,"
                    + "cargocontacto,lineagratuita, funcionarios,codigobarras,codhabilitacion,nombrehabilitacion,codtipoespecializacion,codtipoatencion,"
                    + "codestadoentidad,numactoinscripcion,fechaactoadmin, slogan, " + (dkda.o(vars, "logo").equals("") ? "" : "logo,") + (dkda.o(vars, "archivoactoadmin").equals("") ? "" : "archivoactoadmin,") + " logonombre,archivoactoadminnombre, "
                    + " " + (dkda.o(vars, "archivofi").equals("") ? "" : "archivofi,") + (dkda.o(vars, "archivofi2").equals("") ? "" : "archivofi2,") + " archivofi1nombre,"
                    + "archivofi2nombre, codtipoidentidad )"
                    + "  "
                    + "VALUES('" + dkda.o(vars, "codregimen") + "', '" + dkda.o(vars, "codentidadsaluds") + "', '" + dkda.o(vars, "codtipoentidadsalud") + "'"
                    + ", '" + dkda.o(vars, "codempresa") + "', '" + dkda.o(vars, "codnivelcomplejidad") + "', '" + dkda.o(vars, "codclasifentidad") + "',"
                    + "'" + dkda.o(vars, "contacto") + "', '" + dkda.o(vars, "cargocontacto") + "', '" + dkda.o(vars, "lineagratuita") + "', '" + dkda.o(vars, "funcionarios") + "',"
                    + "'" + dkda.o(vars, "codigobarras") + "', '" + dkda.o(vars, "codhabilitacion") + "', '" + dkda.o(vars, "nombrehabilitacion") + "',"
                    + "'" + dkda.o(vars, "codtipoespecializacion") + "', '" + dkda.o(vars, "codtipoatencion") + "', '" + dkda.o(vars, "codestadoentidad") + "',"
                    + "'" + dkda.o(vars, "numactoinscripcion") + "', '" + dkda.o(vars, "fechaactoadmin") + "', '"
                    + dkda.o(vars, "slogan") + "' " + (dkda.o(vars, "logo").equals("") ? "" : ", lo_import('" + fun.temp(request) + dkda.o(vars, "logo") + "')") + ""
                    + " " + (dkda.o(vars, "archivoactoadmin").equals("") ? "" : ",lo_import('" + fun.temp(request) + dkda.o(vars, "archivoactoadmin") + "')") + " , '" + dkda.o(vars, "logo") + "', '" + dkda.o(vars, "archivoactoadmin") + "'"
                    + " " + (dkda.o(vars, "archivofi").equals("") ? "" : ",lo_import('" + fun.temp(request) + dkda.o(vars, "archivofi") + "')") + (dkda.o(vars, "archivofi2").equals("") ? "" : ", lo_import('" + fun.temp(request) + dkda.o(vars, "archivofi2") + "')") + ","
                    + "'" + dkda.o(vars, "archivofi") + "', '" + dkda.o(vars, "archivofi2") + "', '" + fun.empresaNit(con, dkda.o(vars, "codempresa").toString()) + "')";
                */
            
            
            String sql = " INSERT INTO estadoentidadsalud (codregimenes,codentidadsalud,codtipoidentidad,codempresa,codtipoentidadsalud,codnivelcomplejidad,codclasifentidad,contacto,cargocontacto,lineagratuita,funcionarios,codigobarras,slogan,codhabilitacion,nombrehabilitacion,codtipoespecializacion,codtipoatencion,codestadoentidad,numactoinscripcion,fechaactoadmin,archivofi,archivofi2,ususiscodigo,fecharegistro,logo,logonombre,archivoactoadminnombre,archivofi1nombre,archivofi2nombre,archivoactoadmin) VALUES (" + ( dkda.o(regimen, "codregimen").equals("") ? null : "'" + dkda.o(regimen, "codregimen") + "'" ) + "," + ( dkda.o(vars, "codentidadsalud_entidadsalud").equals("") ? null : "'" + dkda.o(vars, "codentidadsalud_entidadsalud") + "'" ) + "," + ( dkda.o(empresa, "codtipoidentidad").equals("") ? null : "'" + dkda.o(empresa, "codtipoidentidad") + "'" ) + "," + ( dkda.o(empresa, "codempresa").equals("") ? null : "'" + dkda.o(empresa, "codempresa") + "'" ) + "," + ( dkda.o(tipoentidadsalud, "codtipoentidadsalud").equals("") ? null : "'" + dkda.o(tipoentidadsalud, "codtipoentidadsalud") + "'" ) + "," + ( dkda.o(nivelcomplejidad, "codnivelcomplejidad").equals("") ? null : "'" + dkda.o(nivelcomplejidad, "codnivelcomplejidad") + "'" ) + "," + ( dkda.o(clasificacionentidad, "codclasifentidad").equals("") ? null : "'" + dkda.o(clasificacionentidad, "codclasifentidad") + "'" ) + "," + ( dkda.o(vars, "contacto_entidadsalud").equals("") ? null : "'" + dkda.o(vars, "contacto_entidadsalud") + "'" ) + "," + ( dkda.o(vars, "cargocontacto_entidadsalud").equals("") ? null : "'" + dkda.o(vars, "cargocontacto_entidadsalud") + "'" ) + "," + ( dkda.o(vars, "lineagratuita_entidadsalud").equals("") ? null : "'" + dkda.o(vars, "lineagratuita_entidadsalud") + "'" ) + "," + ( dkda.o(vars, "funcionarios_entidadsalud").equals("") ? null : dkda.o(vars, "funcionarios_entidadsalud") ) + "," + ( dkda.o(vars, "codigobarras_entidadsalud").equals("") ? null : "'" + dkda.o(vars, "codigobarras_entidadsalud") + "'" ) + "," + ( dkda.o(vars, "slogan_entidadsalud").equals("") ? null : "'" + dkda.o(vars, "slogan_entidadsalud") + "'" ) + "," + ( dkda.o(vars, "codhabilitacion_entidadsalud").equals("") ? null : "'" + dkda.o(vars, "codhabilitacion_entidadsalud") + "'" ) + "," + ( dkda.o(vars, "nombrehabilitacion_entidadsalud").equals("") ? null : "'" + dkda.o(vars, "nombrehabilitacion_entidadsalud") + "'" ) + "," + ( dkda.o(tipoespecializacionsalud, "codtipoespecializacion").equals("") ? null : "'" + dkda.o(tipoespecializacionsalud, "codtipoespecializacion") + "'" ) + "," + ( dkda.o(tipoatencion, "codtipoatencion").equals("") ? null : "'" + dkda.o(tipoatencion, "codtipoatencion") + "'" ) + "," + ( dkda.o(estadoentidadsalud, "codestadoentidad").equals("") ? null : "'" + dkda.o(estadoentidadsalud, "codestadoentidad") + "'" ) + "," + ( dkda.o(vars, "numactoinscripcion_entidadsalud").equals("") ? null : "'" + dkda.o(vars, "numactoinscripcion_entidadsalud") + "'" ) + "," + ( dkda.o(vars, "fechaactoadmin_entidadsalud").equals("") ? null : "'" + dkda.o(vars, "fechaactoadmin_entidadsalud") + "'" ) + "," + ( dkda.o(vars, "archivofi_entidadsalud").equals("") ? null : "lo_import('"+ fun.temp(request) + dkda.o(vars, "archivofi_entidadsalud") +"')" ) + "," + ( dkda.o(vars, "archivofi2_entidadsalud").equals("") ? null : "lo_import('"+ fun.temp(request) + dkda.o(vars, "archivofi2_entidadsalud") +"')" ) + ","+ "'"+ fun.usuarioAutenticado(request) +"'" +","+ "NOW()::date" +"," + ( dkda.o(vars, "logo_entidadsalud").equals("") ? null : "lo_import('"+ fun.temp(request) + dkda.o(vars, "logo_entidadsalud") +"')" ) + "," + ( dkda.o(vars, "logonombre_entidadsalud").equals("") ? null : "'" + dkda.o(vars, "logonombre_entidadsalud") + "'" ) + "," + ( dkda.o(vars, "archivoactoadminnombre_entidadsalud").equals("") ? null : "'" + dkda.o(vars, "archivoactoadminnombre_entidadsalud") + "'" ) + "," + ( dkda.o(vars, "archivofi1nombre_entidadsalud").equals("") ? null : "'" + dkda.o(vars, "archivofi1nombre_entidadsalud") + "'" ) + "," + ( dkda.o(vars, "archivofi2nombre_entidadsalud").equals("") ? null : "'" + dkda.o(vars, "archivofi2nombre_entidadsalud") + "'" ) + "," + ( dkda.o(vars, "archivoactoadmin_entidadsalud").equals("") ? null : "lo_import('"+ fun.temp(request) + dkda.o(vars, "archivoactoadmin_entidadsalud") +"')" ) + ")";


            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_entidad&&estado=si&&error=no&&errorDes=no";

        } catch (SQLException e) {
            respuesta = "opcion=registrar_entidad&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error entidadSalud.java: " + e.getMessage());
        }

        con.cerrarConexion();
        return respuesta;
    }
            
    public String eliminarEntidadSalud(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        String codGrupo = request.getSession().getAttribute("codGrupo").toString();
        if (codGrupo.equals("IEP")) {
            return "opcion=actualizar_entidad&&estado=si&&error=no&&errorDes=No cuenta con permisos suficientes para actualizar este registro";
        }

        String[] codigos = codigo.split(",");
        String nuevosCodigos = "";
        for (int n = 0; n < codigos.length; n++) {
            nuevosCodigos += "'" + codigos[n] + "',";
        }
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;

            stmt = con.con.prepareStatement("DELETE FROM entidadsalud WHERE codentidadsalud IN(" + nuevosCodigos.substring(0, nuevosCodigos.length() - 1) + ")");
            stmt.execute();
            respuesta = "opcion=eliminar_entidad&&estado=si&&error=no&&errorDes=no";

        } catch (SQLException e) {
            respuesta = "opcion=eliminar_entidad&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error entidadSalud.java: " + e.getMessage());
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String actualizarEntidadSalud(ConexionBaseDatos con) {
        con.abrirConexion();

        String codGrupo = request.getSession().getAttribute("codGrupo").toString();
        if (codGrupo.equals("IEP")) {
            return "opcion=actualizar_entidad&&estado=si&&error=no&&errorDes=No cuenta con permisos suficientes para actualizar este registro";
        }

        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE entidadsalud SET "
                    + "codregimenes = '" + dkda.o(vars, "codregimen") + "' , "
                    + "codentidadsalud = '" + dkda.o(vars, "codentidadsaluds") + "' , "
                    + "codempresa = '" + dkda.o(vars, "codempresa") + "' , "
                    + "codnivelcomplejidad = '" + dkda.o(vars, "codnivelcomplejidad") + "' , "
                    + "codclasifentidad = '" + dkda.o(vars, "codclasifentidad") + "' , "
                    + "contacto = '" + dkda.o(vars, "contacto") + "' , "
                    + "cargocontacto = '" + dkda.o(vars, "cargocontacto") + "' , "
                    + "lineagratuita = '" + dkda.o(vars, "lineagratuita") + "' , "
                    + "funcionarios = '" + dkda.o(vars, "funcionarios") + "' , "
                    + "codigobarras = '" + dkda.o(vars, "codigobarras") + "' , "
                    + "codhabilitacion = '" + dkda.o(vars, "codhabilitacion") + "' , "
                    + "nombrehabilitacion = '" + dkda.o(vars, "nombrehabilitacion") + "' , "
                    + "codtipoespecializacion = '" + dkda.o(vars, "codtipoespecializacion") + "' , "
                    + "codtipoatencion = '" + dkda.o(vars, "codtipoatencion") + "' , "
                    + "numactoinscripcion = '" + dkda.o(vars, "numactoinscripcion") + "' , "
                    + "fechaactoadmin = '" + dkda.o(vars, "fechaactoadmin") + "' , "
                    + "archivofi1nombre = '" + dkda.o(vars, "archivofi") + "' , "
                    + "archivofi2nombre = '" + dkda.o(vars, "archivofi2") + "' , "
                    + "slogan = '" + dkda.o(vars, "slogan") + "' , "
                    + "codtipoidentidad = '" + fun.empresaNit(con, dkda.o(vars, "codempresa").toString()) + "' , "
                    + "logonombre = '" + dkda.o(vars, "logo") + "' , "
                    + "archivoactoadminnombre = '" + dkda.o(vars, "archivoactoadmin") + "' "
                    + (dkda.o(vars, "logo").equals("") ? "" : ", logo = lo_import('" + fun.temp(request) + dkda.o(vars, "logo") + "') ")
                    + (dkda.o(vars, "archivoactoadmin").equals("") ? "" : ", archivoactoadmin = lo_import('" + fun.temp(request) + dkda.o(vars, "archivoactoadmin") + "') ")
                    + (dkda.o(vars, "archivofi").equals("") ? "" : ", archivofi = lo_import('" + fun.temp(request) + dkda.o(vars, "archivofi") + "') ")
                    + (dkda.o(vars, "archivofi2").equals("") ? "" : ", archivofi2 = lo_import('" + fun.temp(request) + dkda.o(vars, "archivofi2") + "') ")
                    + " WHERE codentidadsalud = '" + dkda.o(vars, "codigo") + "' AND codregimenes = '" + dkda.o(vars, "codregimentabla") + "'";
            //System.out.println(sql);

            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_entidad&&estado=si&&error=no&&errorDes=no&&codigo=4";

        } catch (SQLException e) {
            respuesta = "opcion=actualizar_entidad&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error entidadSalud.java: " + dkda.convertirACarEspecial(e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String validarFormulario() {
        System.out.println("Validacion ed...");
        String direccion = "opcion=validacion&&estado=no&&error=si&&errorDes=";
        String error = "";

        /**Comprobar Existencia Entidad salud Tabla = entidadsalud*/
        if (existeTipoEntidadSalud()) {
            error = "Código Entidad Salud: Ya existe otra Entidad de Salud con este Codigo. Verifiquela por favor";
        }
        /***/
        /**Inicio Validar Vacios*/
        if (dkda.o(vars, "codempresa").equals("")) {
            error = "Empresa: Debe seleccionar una Empresa";
        } else if (dkda.o(vars, "codregimen").isEmpty()) {
            error = "Regimen: Debe Seleccionar un Regimen";
        } else if (dkda.o(vars, "codentidadsaluds").equals("")) {
            error = "Código Entidad Salud: Debe Seleccionar una Entidad Salud";
        } else if (dkda.o(vars, "codtipoentidadsalud").equals("")) {
            error = "Tipo Entidad Salud: Debe seleccionar un Tipo de Entidad";
        } else if (dkda.o(vars, "codnivelcomplejidad").equals("")) {
            error = "Nivel Complejidad: Debe seleccionar un Nivel.";
        } else if (dkda.o(vars, "codclasifentidad").equals("")) {
            error = "Clasificación Entidad: Debe seleccionar una Clasificacion para la Entidad";
        } else if (dkda.o(vars, "codhabilitacion").equals("")) {
            error = "Código Habilitación: Debe seleccionar un Código.";
        } else if (dkda.o(vars, "nombrehabilitacion").equals("")) {
            error = "Nombre Habilitación: No puede estar vacio.";
        } /**Fin Validar Vacios*/
        /*** Inicio Validar Tipo Dato */
        else if (!v.alfaNumericos(dkda.o(vars, "codempresa_empresa"))) {
            error = "Código Entidad Salud: tiene caracteres no permitidos.";
        } else if ((!v.alfaNumericos(dkda.o(vars, "contacto"))) && (!dkda.o(vars, "contacto").isEmpty())) {
            error = "Contacto: tiene caracteres no permitidos.";
        } else if ((!v.alfaNumericos(dkda.o(vars, "cargocontacto"))) && (!dkda.o(vars, "cargocontacto").isEmpty())) {
            error = "Cargo Contacto: tiene caracteres no permitidos.";
        } else if ((!v.alfaNumericos(dkda.o(vars, "lineagratuita"))) && (!dkda.o(vars, "lineagratuita").isEmpty())) {
            error = "Línea Gratuita: tiene caracteres no permitidos.";
        } else if ((!v.numeros(dkda.o(vars, "funcionarios"))) && (!dkda.o(vars, "funcionarios").isEmpty())) {
            error = "Número Funcionarios: Especifique un Numero en este campo.";
        } else if ((!v.alfaNumericos(dkda.o(vars, "codigobarras"))) && (!dkda.o(vars, "codigobarras").isEmpty())) {
            error = "Código Barras: tiene caracteres no permitidos.";
        } //        else if ( (!dkda.o(vars, "logo").isEmpty())) {
        //            error = "Logo: Archivo adjunto no valido";
        //        }
        else if (!v.alfaNumericos(dkda.o(vars, "codhabilitacion"))) {
            error = "Código Habilitación: tiene caracteres no permitidos";
        } else if (!v.alfaNumericos(dkda.o(vars, "codhabilitacion"))) {
            error = "Nombre Habilitación: tiene caracteres no permitidos";
        } else if ((!v.alfaNumericos(dkda.o(vars, "numactoinscripcion"))) && (!dkda.o(vars, "numactoinscripcion").isEmpty())) {
            error = "Numero Acto Inscripción: tiene caracteres no permitidos";
        } else if ((!v.fecha_AMD(dkda.o(vars, "fechaactoadmin"))) && (!dkda.o(vars, "fechaactoadmin").isEmpty())) {
            error = "Fecha Acto Administrativo: Error, fecha no valida.";
        }
        
        // Validar Longitud en cambios de Carga Archivo
        else if ( dkda.o(vars, "logo").length() > 80 ) {
            error = "Logo: El nombre del archivo es muy largo, renombrar el archivo a nombre con menos de 80 Caracteres.";
        }else if ( dkda.o(vars, "archivoactoadmin").length() > 80 ) {
          error = "Logo: El nombre del archivo es muy largo, renombrar el archivo a nombre con menos de 80 Caracteres.";
        }else if ( dkda.o(vars, "archivofi").length() > 80 ) {
            error = "Logo: El nombre del archivo es muy largo, renombrar el archivo a nombre con menos de 80 Caracteres.";
        }else if ( dkda.o(vars, "archivofi2").length() > 80 ) {
            error = "Logo: El nombre del archivo es muy largo, renombrar el archivo a nombre con menos de 80 Caracteres.";
        }


        /*** Fin Validar Tipo Dato */
        respuesta = (error.length() > 1 ? direccion + "<strong>" + error + "</strong>" : "");
        return respuesta;
    }

    public String obtenerFormulario(ConexionBaseDatos con, String codigo) {
        System.out.println("CODIGO : " + codigo);
        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = ""
                    + "SELECT "
                    + "entidadsalud.\"codregimenes\" AS entidadsalud_codregimenes,"
                    + "entidadsalud.\"codentidadsalud\" AS entidadsalud_codentidadsalud,"
                    + "entidadsalud.\"codtipoidentidad\" AS entidadsalud_codtipoidentidad,"
                    + "entidadsalud.\"codempresa\" AS entidadsalud_codempresa,"
                    + "entidadsalud.\"codtipoentidadsalud\" AS entidadsalud_codtipoentidadsalud,"
                    + "entidadsalud.\"codnivelcomplejidad\" AS entidadsalud_codnivelcomplejidad,"
                    + "entidadsalud.\"codclasifentidad\" AS entidadsalud_codclasifentidad,"
                    + "entidadsalud.\"contacto\" AS entidadsalud_contacto,"
                    + "entidadsalud.\"cargocontacto\" AS entidadsalud_cargocontacto,"
                    + "entidadsalud.\"lineagratuita\" AS entidadsalud_lineagratuita,"
                    + "entidadsalud.\"funcionarios\" AS entidadsalud_funcionarios,"
                    + "entidadsalud.\"codigobarras\" AS entidadsalud_codigobarras,"
                    + "entidadsalud.\"slogan\" AS entidadsalud_slogan,"
                    + "entidadsalud.\"codhabilitacion\" AS entidadsalud_codhabilitacion,"
                    + "entidadsalud.\"nombrehabilitacion\" AS entidadsalud_nombrehabilitacion,"
                    + "entidadsalud.\"codtipoespecializacion\" AS entidadsalud_codtipoespecializacion,"
                    + "entidadsalud.\"codtipoatencion\" AS entidadsalud_codtipoatencion,"
                    + "entidadsalud.\"codestadoentidad\" AS entidadsalud_codestadoentidad,"
                    + "entidadsalud.\"numactoinscripcion\" AS entidadsalud_numactoinscripcion,"
                    + "entidadsalud.\"fechaactoadmin\" AS entidadsalud_fechaactoadmin,"
                    + "entidadsalud.\"archivoactoadmin\" AS entidadsalud_archivoactoadmin,"
                    + "entidadsalud.\"archivofi\" AS entidadsalud_archivofi,"
                    + "entidadsalud.\"archivofi2\" AS entidadsalud_archivofi2,"
                    + "entidadsalud.\"ususiscodigo\" AS entidadsalud_ususiscodigo,"
                    + "entidadsalud.\"fecharegistro\" AS entidadsalud_fecharegistro,"
                    + "entidadsalud.\"logo\" AS entidadsalud_logo,"
                    + "entidadsalud.\"logonombre\" AS entidadsalud_logonombre,"
                    + "entidadsalud.\"archivoactoadminnombre\" AS entidadsalud_archivoactoadminnombre,"
                    + "entidadsalud.\"archivofi1nombre\" AS entidadsalud_archivofi1nombre,"
                    + "entidadsalud.\"archivofi2nombre\" AS entidadsalud_archivofi2nombre,"
                    + "empresa.\"codtipoidentidad\" AS empresa_codtipoidentidad,"
                    + "empresa.\"codempresa\" AS empresa_codempresa,"
                    + "empresa.\"nombre\" AS empresa_nombre,"
                    + "tipoespecializacionsalud.\"codtipoespecializacion\" AS tipoespecializacionsalud_codtipoespecializacion,"
                    + "tipoespecializacionsalud.\"descripcion\" AS tipoespecializacionsalud_descripcion,"
                    + "tipoentidadsalud.\"codtipoentidadsalud\" AS tipoentidadsalud_codtipoentidadsalud,"
                    + "tipoentidadsalud.\"descripcion\" AS tipoentidadsalud_descripcion,"
                    + "tipoatencion.\"codtipoatencion\" AS tipoatencion_codtipoatencion,"
                    + "tipoatencion.\"descripcion\" AS tipoatencion_descripcion,"
                    + "regimen.\"codregimen\" AS regimen_codregimen,"
                    + "regimen.\"descripcion\" AS regimen_descripcion,"
                    + "nivelcomplejidad.\"codnivelcomplejidad\" AS nivelcomplejidad_codnivelcomplejidad,"
                    + "nivelcomplejidad.\"descripcion\" AS nivelcomplejidad_descripcion,"
                    + "estadoentidadsalud.\"codestadoentidad\" AS estadoentidadsalud_codestadoentidad,"
                    + "estadoentidadsalud.\"descripcion\" AS estadoentidadsalud_descripcion,"
                    + "clasificacionentidad.\"codclasifentidad\" AS clasificacionentidad_codclasifentidad,"
                    + "clasificacionentidad.\"descripcion\" AS clasificacionentidad_descripcion,"
                    + "CASE WHEN entidadsalud.logonombre IS NULL OR entidadsalud.logonombre = '' THEN 0 "
                    + "ELSE lo_export(entidadsalud.logo, '" + fun.temp(request) + "' || logonombre) END,"
                    + "CASE WHEN entidadsalud.archivofi1nombre IS NULL OR entidadsalud.archivofi1nombre = '' THEN 0 "
                    + "ELSE lo_export(entidadsalud.archivofi, '" + fun.temp(request) + "' || archivofi1nombre) END,"
                    + "CASE WHEN entidadsalud.archivofi2nombre IS NULL OR entidadsalud.archivofi2nombre = '' THEN 0 "
                    + "ELSE lo_export(entidadsalud.archivofi2, '" + fun.temp(request) + "' || archivofi2nombre) END,"
                    + "CASE WHEN entidadsalud.archivoactoadminnombre IS NULL OR entidadsalud.archivoactoadminnombre = '' THEN 0 "
                    + "ELSE lo_export(entidadsalud.archivoactoadmin, '" + fun.temp(request) + "' || archivoactoadminnombre) END "
                    + "FROM "
                    + "public.empresa empresa INNER JOIN \"public\".\"entidadsalud\" entidadsalud ON empresa.\"codtipoidentidad\" = entidadsalud.\"codtipoidentidad\" "
                    + "AND empresa.\"codempresa\" = entidadsalud.\"codempresa\" "
                    + "INNER JOIN \"public\".\"tipoespecializacionsalud\" tipoespecializacionsalud ON entidadsalud.\"codtipoespecializacion\" = tipoespecializacionsalud.\"codtipoespecializacion\" "
                    + "INNER JOIN \"public\".\"tipoentidadsalud\" tipoentidadsalud ON entidadsalud.\"codtipoentidadsalud\" = tipoentidadsalud.\"codtipoentidadsalud\" "
                    + "INNER JOIN \"public\".\"tipoatencion\" tipoatencion ON entidadsalud.\"codtipoatencion\" = tipoatencion.\"codtipoatencion\" "
                    + "INNER JOIN \"public\".\"regimen\" regimen ON entidadsalud.\"codregimenes\" = regimen.\"codregimen\" "
                    + "INNER JOIN \"public\".\"nivelcomplejidad\" nivelcomplejidad ON entidadsalud.\"codnivelcomplejidad\" = nivelcomplejidad.\"codnivelcomplejidad\" "
                    + "INNER JOIN \"public\".\"estadoentidadsalud\" estadoentidadsalud ON entidadsalud.\"codestadoentidad\" = estadoentidadsalud.\"codestadoentidad\" "
                    + "INNER JOIN \"public\".\"clasificacionentidad\" clasificacionentidad ON entidadsalud.\"codclasifentidad\" = clasificacionentidad.\"codclasifentidad\" "
                    + " WHERE entidadsalud.codentidadsalud = '" + codigo + "'";

            


            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();

            rs.next();
            
            

            
            info += "combo|#codregimen|" + rs.getString("regimen_codregimen") + "|llenarCombo('codregimen', '" + rs.getString("regimen_codregimen") + "', '" + rs.getString("regimen_descripcion") + "'):_";
            info += "combo|#codtipoespecializacion|" + rs.getString("tipoespecializacionsalud_codtipoespecializacion") + "|llenarCombo('codtipoespecializacion', '" + rs.getString("tipoespecializacionsalud_codtipoespecializacion") + "', '" + rs.getString("tipoespecializacionsalud_descripcion") + "'):_";
            info += "combo|#codtipoentidadsalud|" + rs.getString("tipoentidadsalud_codtipoentidadsalud") + "|llenarCombo('codtipoentidadsalud', '" + rs.getString("tipoentidadsalud_codtipoentidadsalud") + "', '" + dkda.convertirACarEspecial(rs.getString("tipoentidadsalud_descripcion")) + "'):_";
            info += "combo|#codtipoatencion|" + rs.getString("tipoatencion_codtipoatencion") + "|llenarCombo('codtipoatencion', '" + rs.getString("tipoatencion_codtipoatencion") + "', '" + rs.getString("tipoatencion_descripcion") + "'):_";
            info += "combo|#codnivelcomplejidad|" + rs.getString("nivelcomplejidad_codnivelcomplejidad") + "|llenarCombo('codnivelcomplejidad', '" + rs.getString("nivelcomplejidad_codnivelcomplejidad") + "', '" + rs.getString("nivelcomplejidad_descripcion") + "'):_";
            info += "combo|#codestadoentidad|" + rs.getString("estadoentidadsalud_codestadoentidad") + "|llenarCombo('codestadoentidad', '" + rs.getString("estadoentidadsalud_codestadoentidad") + "', '" + rs.getString("estadoentidadsalud_descripcion") + "'):_";
            info += "combo|#codempresa|" + rs.getString("empresa_codempresa") + "|llenarCombo('codempresa', '" + rs.getString("empresa_codempresa") + "', '" + rs.getString("empresa_nombre") + "'):_";
            info += "combo|#codclasifentidad|" + rs.getString("clasificacionentidad_codclasifentidad") + "|llenarCombo('codclasifentidad', '" + rs.getString("clasificacionentidad_codclasifentidad") + "', '" + rs.getString("clasificacionentidad_descripcion") + "'):_";


            info += "text|#codentidadsaluds|" + (rs.getString("entidadsalud_codentidadsalud") == null ? "" : rs.getString("entidadsalud_codentidadsalud")) + ":_";
            info += "text|#contacto|" + (rs.getString("entidadsalud_contacto") == null ? "" : rs.getString("entidadsalud_contacto")) + ":_";
            info += "text|#cargocontacto|" + (rs.getString("entidadsalud_cargocontacto") == null ? "" : rs.getString("entidadsalud_cargocontacto")) + ":_";
            info += "text|#lineagratuita|" + (rs.getString("entidadsalud_lineagratuita") == null ? "" : rs.getString("entidadsalud_lineagratuita")) + ":_";
            info += "text|#funcionarios|" + (rs.getString("entidadsalud_funcionarios") == null ? "" : rs.getString("entidadsalud_funcionarios")) + ":_";
            info += "text|#codigobarras|" + (rs.getString("entidadsalud_codigobarras") == null ? "" : rs.getString("entidadsalud_codigobarras")) + ":_";
            info += "text|#codhabilitacion|" + (rs.getString("entidadsalud_codhabilitacion") == null ? "" : rs.getString("entidadsalud_codhabilitacion")) + ":_";
            info += "text|#nombrehabilitacion|" + (rs.getString("entidadsalud_nombrehabilitacion") == null ? "" : rs.getString("entidadsalud_nombrehabilitacion")) + ":_";
            info += "text|#numactoinscripcion|" + (rs.getString("entidadsalud_numactoinscripcion") == null ? "" : rs.getString("entidadsalud_numactoinscripcion")) + ":_";
            info += "text|#fechaactoadmin|" + (rs.getString("entidadsalud_fechaactoadmin") == null ? "" : rs.getString("entidadsalud_fechaactoadmin")) + ":_";
            info += "text|#slogan|" + (rs.getString("entidadsalud_slogan") == null ? "" : rs.getString("entidadsalud_slogan")) + ":_";


            info += "text|#logo|" + (rs.getString("entidadsalud_logonombre") == null ? "" : rs.getString("entidadsalud_logonombre")) + ":_";
            info += "text|#archivoactoadmin|" + (rs.getString("entidadsalud_archivoactoadminnombre") == null ? "" : rs.getString("entidadsalud_archivoactoadminnombre")) + ":_";
            info += "text|#archivofi|" + (rs.getString("entidadsalud_archivofi1nombre") == null ? "" : rs.getString("entidadsalud_archivofi1nombre")) + ":_";
            info += "text|#archivofi2|" + (rs.getString("entidadsalud_archivofi2nombre") == null ? "" : rs.getString("entidadsalud_archivofi2nombre")) + ":_";

            dkda.ed_permisosArchivo(fun.temp(request) + rs.getString("entidadsalud_logonombre"));
            dkda.ed_permisosArchivo(fun.temp(request) + rs.getString("entidadsalud_archivoactoadminnombre"));
            dkda.ed_permisosArchivo(fun.temp(request) + rs.getString("entidadsalud_archivofi1nombre"));
            dkda.ed_permisosArchivo(fun.temp(request) + rs.getString("entidadsalud_archivofi2nombre"));
            
            
            if( new java.io.File(fun.temp(request) + rs.getString("entidadsalud_logonombre")).exists() ) {
                java.io.File archivo = new java.io.File(fun.temp(request) + rs.getString("entidadsalud_logonombre"));   
                archivo.setWritable(true);
                archivo.setReadable(true);
                archivo.setExecutable(true);
            }
            if( new java.io.File(fun.temp(request) + rs.getString("entidadsalud_archivoactoadminnombre")).exists() ) {
                java.io.File archivo = new java.io.File(fun.temp(request) + rs.getString("entidadsalud_archivoactoadminnombre"));
                archivo.setWritable(true);
                archivo.setReadable(true);
                archivo.setExecutable(true);
            }
            if( new java.io.File(fun.temp(request) + rs.getString("entidadsalud_archivofi1nombre")).exists() ) {
                java.io.File archivo = new java.io.File(fun.temp(request) + rs.getString("entidadsalud_archivofi1nombre"));
                archivo.setWritable(true);
                archivo.setReadable(true);
                archivo.setExecutable(true);
            }            
            if( new java.io.File(fun.temp(request) + rs.getString("entidadsalud_archivofi2nombre")).exists() ) {
                java.io.File archivo = new java.io.File(fun.temp(request) + rs.getString("entidadsalud_archivofi2nombre"));
                archivo.setWritable(true);
                archivo.setReadable(true);
                archivo.setExecutable(true);
            }            
            
            respuesta = "opcion=obtener_entidad&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&codregimentabla=" + rs.getString("regimen_codregimen") + "&&info=" + info.replace("\"", "");


        } catch (SQLException e) {
            respuesta = "opcion=obtener_entidad&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error entidadSalud - Obtener.java: " + e.getMessage());
        }
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

    public boolean existeTipoEntidadSalud() {
        PreparedStatement pQuery = null;
        ResultSet rQuery = null;
        Connection conexion = bdS.getConexion();
        boolean existe = true;
        try {                                                                            //
            pQuery = conexion.prepareStatement("SELECT COUNT(*) FROM entidadsalud WHERE codtipoidentidad ='" + dkda.o(vars, "codentidadsaluds") + "'");
            //System.out.println("1. SELECT codtipoestrucarch FROM tipoestructarch WHERE codregimen='" + codRegimen + "'");
            rQuery = pQuery.executeQuery();
            rQuery.next();
            existe = rQuery.getInt(1) > 0 ? true : false;
            System.out.println("existeTipoEntidadSalud() => " + rQuery.getInt(1));
            pQuery.close();
            rQuery.close();

        } catch (SQLException e) {
            System.err.println("( existeTipoEntidadSalud() ) Error al consultar los campos de la tabla: " + e);
        }
        return existe;
    }
}
