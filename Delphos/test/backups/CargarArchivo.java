package backups;

import clases.UtilidadesDKDA;
import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import clases.ConexionBaseDatos;
import controladores.Control;
import java.util.List;
import java.util.Iterator;

public class CargarArchivo implements Control {

    private String msj, ruta, delimitador, otroDelimitador, nombreArchivo, codregimen, codentidadsalud, codarchivo, nombrearchivo, codtipoarchivo, nombreenvia, telefonoenvia, emailenvia, copiadctoremis, proceso;
    private ConexionBaseDatos con;
    private java.sql.Date fechainicial, fechafinal, horaenvio;
    private java.sql.Timestamp fechaenvio, fecharecibo;
    private int idEncabezado;
    private double coddepartamento, codmunicipio, registros;

    public boolean doLogic(javax.servlet.http.HttpServletRequest request,
            javax.servlet.http.HttpServletResponse response)
            throws javax.servlet.ServletException, java.io.IOException {

        if (request.getParameter("hacerSubmit") != null && request.getParameter("hacerSubmit").equals("1")) {
            msj = "";

            con = new ConexionBaseDatos();

            String codtipoestrucarch = "";

            ResultSet rs;
            PreparedStatement stmt;

            con.abrirConexion();

            procesarParametros(request);

            //Carga del tipo de estructura del archivo segun el regimen. Tabla: tipoestructarch
            try {
                stmt = con.con.prepareStatement("SELECT codtipoestrucarch FROM tipoestructarch WHERE codregimen=?");
                stmt.setString(1, codregimen);
                rs = stmt.executeQuery();
                rs.next();
                codtipoestrucarch = rs.getString("codtipoestrucarch");
                rs.close();
                stmt.close();
            } catch (SQLException e) {
                con.cerrarConexion();
                msj = "Error al consultar la estructura del archivo: " + e
                        + "<script>alert('Error al consultar la estructura del archivo');</script>";
                request.setAttribute("msj", msj);
                return true;
            }

            //Registro en la base de datos del encabezado
            try {
                //Se obtiene el valor de la secuencia del encabezado
                stmt = con.con.prepareStatement("SELECT nextval('idencabezado_seq') AS idEncabezado");
                rs = stmt.executeQuery();
                rs.next();
                idEncabezado = rs.getInt("idEncabezado");
                rs.close();
                stmt.close();

                //Se ingresa el encabezado
                //idencabezado,codregimenes,codentidadsalud,fechainicial,fechafinal,codarchivo,coddepartamento,codmunicipio,nombrearchivo,codtipoarchivo,nombreenvia,telefonoenvia,emailenvia,fechaenvio,horaenvio,fecharecibo,registros,copiadctoremis,proceso
                String sql;
                sql = "INSERT INTO encabezadoarchivo (idencabezado," + //1
                        "codregimenes," + //2
                        "codentidadsalud," + //3
                        "fechainicial," + //4
                        "fechafinal," + //5
                        "codarchivo," + //6
                        "coddepartamento," + //7
                        "codmunicipio," + //8
                        "nombrearchivo," + //9
                        "codtipoarchivo," + //10
                        "nombreenvia," + //11
                        "telefonoenvia," + //12
                        "emailenvia," + //13
                        "fechaenvio," + //14
                        "fecharecibo," + //15
                        "registros," + //16
                        "proceso)" + //17
                        "VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
                stmt = con.con.prepareStatement(sql);
                stmt.setDouble(1, idEncabezado);
                stmt.setString(2, codregimen);
                stmt.setString(3, codentidadsalud);
                stmt.setDate(4, fechainicial);
                stmt.setDate(5, fechafinal);
                stmt.setString(6, codarchivo);
                stmt.setDouble(7, coddepartamento);
                stmt.setDouble(8, codmunicipio);
                stmt.setString(9, nombrearchivo);
                stmt.setString(10, codtipoarchivo);
                stmt.setString(11, nombreenvia);
                stmt.setString(12, telefonoenvia);
                stmt.setString(13, emailenvia);
                stmt.setTimestamp(14, fechaenvio);
                stmt.setTimestamp(15, fecharecibo);
                stmt.setDouble(16, registros);
                stmt.setString(17, proceso);

                stmt.executeUpdate();
                stmt.close();
            } catch (SQLException e) {
                con.cerrarConexion();
                msj = "Error al registrar el encabezado del archivo: " + e
                        + "<script>alert('Error al registrar el encabezado del archivo');</script>";
                request.setAttribute("msj", msj);
                return true;
            }

            con.cerrarConexion();

            /*if(delimitador.equals("otro"))
            delimitador = otroDelimitador;*/

            String pagina = "";
            if (request.getParameter("tipoCarga").equals("CargarPoblacion")) {
                pagina = "CargaArchivoPoblacion.jsp";
            } else if (request.getParameter("tipoCarga").equals("CargarRips")) {
                pagina = "CargaArchivoRips.jsp";
            }

            msj = "El encabezado ha sido registrado con exito"
                    + "<script>alert('El encabezado ha sido registrado con exito');</script>"
                    + "<script>window.top.location='" + pagina + "?codtipoestrucarch=" + codtipoestrucarch + "&idencabezado=" + idEncabezado + "&accion=" + request.getParameter("tipoCarga") + "&tipoRips=" + request.getParameter("tipoRip") + "';</script>";
            //"<script>window.top.location='SeleccionarColumnas.jsp?nombreArchivo="+nombreArchivo+"&delimitador="+delimitador+"&codtipoestrucarch="+codtipoestrucarch+"&idencabezado="+idEncabezado+"&accion="+request.getParameter("accion")+"';</script>";
            request.setAttribute("msj", msj);
            return true;
        } else {
            return true;
        }
    }
//--------------------------------------------------------------------------------------------------- 

    private void procesarParametros(javax.servlet.http.HttpServletRequest request) {
        nombreArchivo = request.getParameter("archivoASubir");
        delimitador = request.getParameter("delimitador");
        otroDelimitador = request.getParameter("otroDelimitador");
        codregimen = request.getParameter("codregimen");
        codentidadsalud = request.getParameter("codentidadsalud");
        fechainicial = UtilidadesDKDA.fechaToDate(request.getParameter("fechainicial"));
        fechafinal = UtilidadesDKDA.fechaToDate(request.getParameter("fechafinal"));
        codarchivo = request.getParameter("codarchivo");
        coddepartamento = Double.parseDouble(request.getParameter("coddepartamento"));
        codmunicipio = Double.parseDouble(request.getParameter("codmunicipio"));
        nombrearchivo = request.getParameter("nombrearchivo");
        codtipoarchivo = request.getParameter("codtipoarchivo");
        nombreenvia = request.getParameter("nombreenvia");
        telefonoenvia = request.getParameter("telefonoenvia");
        emailenvia = request.getParameter("emailenvia");
        fechaenvio = UtilidadesDKDA.fechaToTimeStamp(request.getParameter("fechaenvio"));
        fecharecibo = UtilidadesDKDA.fechaToTimeStamp(request.getParameter("fecharecibo"));
        registros = Double.parseDouble(request.getParameter("registros"));
        copiadctoremis = request.getParameter("copiadctoremis");
        proceso = request.getParameter("proceso");
    }
}
