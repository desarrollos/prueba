package clases;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.swing.JOptionPane;
import org.apache.catalina.Session;

public final class VerificarUsuarioSistema {

   
    private String usuario, codGrupo, programa;
    private String tipoOpcionUsuario;

    

    public VerificarUsuarioSistema(HttpServletRequest request, HttpServletResponse response) {

        String uri = request.getRequestURI();
        int start = uri.lastIndexOf("/") + 1;
        int stop = uri.lastIndexOf(".");
        programa = "index";
        if (start < stop) {
            programa = uri.substring(start, stop);
        }

        Connection conexion = bdS.getConexion();

        try {
            usuario = request.getSession().getAttribute("login").toString();
            codGrupo = request.getSession().getAttribute("codGrupo").toString();

            System.out.println("Usuario:" + usuario + ". Codigo Grupo: " + codGrupo);

            if (!verificarEstadoUsuario()) {
                try {
                    System.out.println("verificarEstadoUsuario");
                    response.sendRedirect("../index.jsp?errorLogin=1");
                } catch (Exception e1) {
                    System.out.println("Exception-verificarEstadoUsuario");
                    response.sendRedirect("index.jsp?errorLogin=1");
                }
            } else if (!verificarUsuarioIndependiente()) {
                if (!verificarEstadoGrupo()) {
                    try {
                        response.sendRedirect("../index.jsp?errorLogin=1");
                    } catch (Exception e1) {
                        response.sendRedirect("index.jsp?errorLogin=1");
                    }
                }

//                if (!verificarGrupoUsuario()) {
//                    System.out.println("verificarGrupoUsuario");
//                    try {
//                        response.sendRedirect("../index.jsp?errorLogin=1");
//                    } catch (Exception e1) {
//                        response.sendRedirect("index.jsp?errorLogin=1");
//                    }
//
//                }

               
            }

            try {
                if (usuario == null && !programa.equals("index")) {

                    response.sendRedirect("index.jsp");
                }


            } catch (Exception e) {
                System.out.println("Usuario redireccionado para Autenticacion...");
            }
            System.out.println("*** Verificando usuario: " + usuario + " en programa: " + programa + " ***");

            try {
                if (usuario == null) {
                    try {

                        if (!uri.equals("/Delphos/") && !uri.equals("/Delphos/index.jsp")) {
                            response.sendRedirect("../index.jsp");
                        }
                    } catch (Exception e) {
                    }
                }
            } catch (StackOverflowError e) {
                System.err.println("VerificarUsuarioSistema() ERROR:  " + e.getMessage());
            }


        } catch (Exception e) {
            System.out.println("Error General (Verificar_UsuarioSistema) : " + e.getMessage());
            
        }

    }

    private boolean verificarEstadoGrupo() {

        Connection conexion = bdS.getConexion();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            pstmt = conexion.prepareStatement("SELECT g.esgrsecodigo FROM gruposeguridad g WHERE grusegcodigo=?");
            pstmt.setString(1, codGrupo);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                if (rs.getString("esgrsecodigo").equals("AC")) {
                    rs.close();
                    pstmt.close();
                    tipoOpcionUsuario = "grupo";
                    return true;
                } else {
                    rs.close();
                    pstmt.close();
                    return false;
                }
            } else {
                rs.close();
                pstmt.close();
                return false;
            }
        } catch (SQLException e) {
            try {
                rs.close();
                pstmt.close();
            } catch (SQLException e1) {
            }
            return false;
        }
    }

    private boolean verificarUsuarioIndependiente() {
        Connection conexion = bdS.getConexion();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            pstmt = conexion.prepareStatement("SELECT * FROM opcionusuario o, listaopcion l WHERE o.ususiscodigo=? AND l.lisopcprograma=? AND l.lisopccodigo=o.lisopccodigo");
            pstmt.setString(1, usuario);
            pstmt.setString(2, programa);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                rs.close();
                pstmt.close();
                tipoOpcionUsuario = "independiente";
                return true;
            } else {
                rs.close();
                pstmt.close();
                return false;
            }
        } catch (SQLException e) {
            System.out.println("Error 1 (verificarUsuarioIndependiente) " + e);
            try {
                rs.close();
                pstmt.close();
            } catch (SQLException e1) {
                System.out.println("Error catch2(verificarUsuarioIndependiente) " + e1);
            }
            return false;
        }
    }

    private boolean verificarGrupoUsuario() {
        Connection conexion = bdS.getConexion();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            if (!programa.equals("index")) {
                pstmt = conexion.prepareStatement("SELECT l.lisopcprograma FROM opciongruposeg o, listaopcion l WHERE o.grusegcodigo=? AND o.lisopccodigo=l.lisopccodigo");
                pstmt.setString(1, codGrupo);
                rs = pstmt.executeQuery();
                while (rs.next()) {
                    System.out.println("programa " + programa + " " + rs.getString("lisopcprograma"));
                    if (programa.equals(rs.getString("lisopcprograma"))) {
                        rs.close();
                        pstmt.close();
                        return true;
                    }
                }

                rs.close();
                pstmt.close();
                return false;
            } else {
                return true;
            }
        } catch (SQLException e) {
            System.err.println("Error(verificarGrupoUsuario): " + e);
            try {
                rs.close();
                pstmt.close();
            } catch (SQLException e1) {
                System.out.println("Error catch2(verificarGrupoUsuario) " + e1);
            }
            return false;
        }
    }

    private boolean verificarEstadoUsuario() {
        Connection conexion = bdS.getConexion();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {                       //Por el Request se obtiene el ususisusuario NO el ususiscodigo ; si son diferentes falla por que encuentra vacio
            pstmt = conexion.prepareStatement("SELECT codestusuasistema FROM usuariosistema WHERE ususisusuario=?");
            pstmt.setString(1, usuario);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                if (rs.getString("codestusuasistema").equals("AC")) {
                    rs.close();
                    pstmt.close();
                    return true;
                } else {
                    rs.close();
                    pstmt.close();
                    return false;
                }
            } else {
                rs.close();
                pstmt.close();
                return false;
            }
        } catch (SQLException e) {
            System.err.println("Error(verificarEstadoUsuario): " + e);
            try {
                rs.close();
                pstmt.close();
            } catch (SQLException e1) {
                System.out.println("Error catch2(verificarEstadoUsuario)" + e1);
            }
            return false;
        }
    }

    public boolean verificarPermisos(String permiso) {
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String busqueda = "N", ingreso = "N", eliminacion = "N", modificacion = "N", ejecutar = "N", sql = "";

        if (usuario.equals(usuario)) {
            return true;
        }


        if (tipoOpcionUsuario.equals("grupo")) {
            try {
                Connection conexion = bdS.getConexion();

                sql = "SELECT n.niseopejecuta, n.niseopadiciona, n.niseopmodifica, n.niseopelimina, n.niseopconsulta, n.niseopbuscar, n.niseopimprime, n.niseopocultar "
                        + "FROM nivelsegopcion n, opciongruposeg o, listaopcion l "
                        + "WHERE l.lisopccodigo=o.lisopccodigo AND n.niseopcodigo=o.niseopcodigo AND l.lisopcprograma=? AND o.grusegcodigo=? ";

                pstmt = conexion.prepareStatement(sql);
                pstmt.setString(1, programa);
                pstmt.setString(2, codGrupo);

                rs = pstmt.executeQuery();
                if (rs.next()) {
                    busqueda = rs.getString("niseopconsulta");
                    modificacion = rs.getString("niseopmodifica");
                    ingreso = rs.getString("niseopadiciona");
                    eliminacion = rs.getString("niseopelimina");

                    rs.close();
                    pstmt.close();
                    
                } else {
                    /*pstmt = con.con.prepareStatement("SELECT * FROM opcionesgrupousuarios WHERE codgrupo=?");
                    pstmt.setString(1,codGrupo);
                    rs = pstmt.executeQuery();
                    
                    if(rs.next())
                    {
                    busqueda = rs.getString("consulta");
                    modificacion = rs.getString("edicion");
                    ingreso = rs.getString("ingreso");
                    eliminacion = rs.getString("borrar");
                    
                    rs.close();
                    pstmt.close();
                    con.cerrarConexion();
                    }*/
                }

                //-------------------------------------------------------------
                if (permiso.equals("busqueda")) {
                    if (busqueda.equals("S")) {
                        return true;
                    } else {
                        return false;
                    }
                }

                if (permiso.equals("ingresar")) {
                    if (ingreso.equals("S")) {
                        return true;
                    } else {
                        return false;
                    }
                }

                if (permiso.equals("modificar")) {
                    if (modificacion.equals("S")) {
                        return true;
                    } else {
                        return false;
                    }
                }

                if (permiso.equals("eliminar")) {
                    if (eliminacion.equals("S")) {
                        return true;
                    } else {
                        return false;
                    }
                }
            } catch (SQLException e) {
                System.out.println("Error1 (verificarPermisos) " + e);
                try {
                    rs.close();
                    pstmt.close();
                    
                } catch (SQLException e1) {
                    System.out.println("Error11 (verificarPermisos) " + e1);
                }
                return false;
            }
        } else if (tipoOpcionUsuario.equals("independiente")) {
            try {
               Connection conexion = bdS.getConexion();

                sql = "SELECT n.niseopejecuta, n.niseopadiciona, n.niseopmodifica, n.niseopelimina, n.niseopconsulta, n.niseopbuscar, n.niseopimprime, n.niseopocultar "
                        + "FROM nivelsegopcion n, opcionusuario o, listaopcion l "
                        + "WHERE l.lisopccodigo=o.lisopccodigo AND n.niseopcodigo=o.niseopcodigo AND l.lisopcprograma=? AND o.ususiscodigo=? ";

                pstmt = conexion.prepareStatement(sql);
                pstmt.setString(1, programa);
                pstmt.setString(2, usuario);

                rs = pstmt.executeQuery();
                if (rs.next()) {
                    busqueda = rs.getString("niseopconsulta");
                    modificacion = rs.getString("niseopmodifica");
                    ingreso = rs.getString("niseopadiciona");
                    eliminacion = rs.getString("niseopelimina");

                    rs.close();
                    pstmt.close();
                    
                } else {
                    /*pstmt = con.con.prepareStatement("SELECT * FROM opcionesgrupousuarios WHERE codgrupo=?");
                    pstmt.setString(1,codGrupo);
                    rs = pstmt.executeQuery();
                    
                    if(rs.next())
                    {
                    busqueda = rs.getString("consulta");
                    modificacion = rs.getString("edicion");
                    ingreso = rs.getString("ingreso");
                    eliminacion = rs.getString("borrar");
                    
                    rs.close();
                    pstmt.close();
                    con.cerrarConexion();
                    }*/
                }

                //-------------------------------------------------------------
                if (permiso.equals("busqueda")) {
                    if (busqueda.equals("S")) {
                        return true;
                    } else {
                        return false;
                    }
                }

                if (permiso.equals("ingresar")) {
                    if (ingreso.equals("S")) {
                        return true;
                    } else {
                        return false;
                    }
                }

                if (permiso.equals("modificar")) {
                    if (modificacion.equals("S")) {
                        return true;
                    } else {
                        return false;
                    }
                }

                if (permiso.equals("eliminar")) {
                    if (eliminacion.equals("S")) {
                        return true;
                    } else {
                        return false;
                    }
                }
            } catch (SQLException e) {
                System.out.println("Error2 (verificarPermisos) " + e);
                try {
                    rs.close();
                    pstmt.close();
                    
                } catch (SQLException e1) {
                    System.out.println("Error22 (verificarPermisos) " + e);
                }
                return false;
            }
        }

        return false;
    }

    public boolean aCambiadoClave() {
        Connection conexion = bdS.getConexion();

        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            pstmt = conexion.prepareStatement("SELECT ususisfechamodi FROM usuariosistema WHERE ususisusuario = ? AND grusegcodigo = ?");
            pstmt.setString(1, usuario);
            pstmt.setString(2, codGrupo);
            rs = pstmt.executeQuery();
            rs.next();
            //System.out.println("rs.getString(1) " + rs.getString(1));
            if (rs.getString(1) == null) {
                rs.close();
                pstmt.close();
                return false;
            } else {
                rs.close();
                pstmt.close();
                return true;
            }


        } catch (SQLException e) {
            System.err.println("Error(chequerPwd): " + e);
            try {
                rs.close();
                pstmt.close();
            } catch (SQLException e1) {
                System.out.println("Error catch2(chequerPwd): " + e1);
            }
            return false;
        }

    }
}
