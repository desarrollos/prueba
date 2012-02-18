package controladores;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import clases.ConexionBaseDatos;
import java.sql.*;
import beans.Login;
import java.util.Calendar;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import clases.FormatoTimestamp;

public class index implements Control
{

    String programa, usuario, codGrupo;
    
    public boolean doLogic(javax.servlet.http.HttpServletRequest request, 
                         javax.servlet.http.HttpServletResponse response) 
                      throws javax.servlet.ServletException, java.io.IOException  
    {
    
    String uri = request.getRequestURI();
    int start = uri.lastIndexOf("/")+1;
    int stop = uri.lastIndexOf(".");
    programa = "index";
    if ( start < stop ) 
        programa = uri.substring(start,stop);

    
      if(request.getParameter("login") != null)
      {
          Login login = new Login();

          if(request.getParameter("hacerSubmit") != null)
          {
              if(login.verificarLogin(request.getParameter("login")))
              {
                  if(login.verificarUsuario(request.getParameter("login"),request.getParameter("password")))
                  {
                      request.getSession().setAttribute("login",login.getLogin());
                      request.getSession().setAttribute("codGrupo",login.getCodGrupo());
                      request.getSession().setAttribute("nombre",login.getNombre());
                      request.getSession().setAttribute("apellido",login.getApellido());
                      
                      usuario = login.getLogin();
                      codGrupo = login.getCodGrupo();
                      System.out.println("Usuario " + usuario);
                      System.out.println("Grupo " + codGrupo);
                     // verificarSesion(request);
                  }
                  else
                  {
                      request.setAttribute("errorLogin",login.getError());
                      System.out.println("Upps Error 1");
                  }
              }
              else
              {
                   request.setAttribute("errorLogin",login.getError());
                   System.out.println("Upps Error 2");
              }
          }
      }
      return true;
    }
  
    private boolean verificarSesion(HttpServletRequest req)
    {
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        ConexionBaseDatos con;
        con = new ConexionBaseDatos();
        con.abrirConexion();

        try
        {
            int maxSesionId = 0;

            pstmt = con.con.prepareStatement("SELECT MAX(sesabiconsecutivo) AS id FROM sesionabierta");
            //pstmt.setString(1,usuario);
            rs = pstmt.executeQuery();
            rs.next();
            maxSesionId = rs.getInt("id");
            maxSesionId++;
            rs.close();
            pstmt.close();
            System.out.println("SELECT ususiscodigo FROM sesionabierta WHERE ususiscodigo="+usuario+" AND sesabifechacierre IS NULL");
            pstmt = con.con.prepareStatement("SELECT ususiscodigo FROM sesionabierta WHERE ususiscodigo=? AND sesabifechacierre IS NULL");
            pstmt.setString(1,usuario);
            rs = pstmt.executeQuery();
            if(rs.next())
            {
                rs.close();
                pstmt.close();

                //Aqui deberia de ser en el Where NO ususiscodigo sino ususisusuario(usuario en login)
                pstmt = con.con.prepareStatement("SELECT ususismultisesion FROM usuariosistema WHERE ususiscodigo=?");
                pstmt.setString(1,usuario);
                rs = pstmt.executeQuery();
                rs.next();
                if(rs.getString("ususismultisesion").equals("N"))
                {
                    rs.close();
                    pstmt.close();
                    con.cerrarConexion();
                    return false;
                }
                else
                {
                    rs.close();
                    pstmt.close();

                    pstmt = con.con.prepareStatement("INSERT INTO sesionabierta (sesabiconsecutivo,ususiscodigo,ususiscodigor) VALUES (?,?,?)");
                    pstmt.setInt(1,maxSesionId);
                    pstmt.setString(2,usuario);

                    pstmt.setString(3,usuario);

                    pstmt.executeUpdate();
                    pstmt.close();

                    req.getSession().setAttribute("idSesion",maxSesionId);

                    System.out.println("WTF!! " + Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+"00:00:00")) );
                    con.cerrarConexion();
                    return true;
                }
            }
            else //Si no hay sesiones abiertas abre una
            {
                rs.close();
                pstmt.close();

                pstmt = con.con.prepareStatement("INSERT INTO sesionabierta (sesabiconsecutivo,ususiscodigo,ususiscodigor) VALUES (?,?,?)");
                pstmt.setInt(1,maxSesionId);
                pstmt.setString(2,usuario);
                pstmt.setString(3,usuario);
                pstmt.executeUpdate();
                pstmt.close();

                req.getSession().setAttribute("idSesion",maxSesionId);

                con.cerrarConexion();
                return true;
            }
        }
        catch(SQLException e)
        {
            try
            {
                rs.close();
                pstmt.close();
                con.cerrarConexion();
            }
            catch(SQLException e1)
            {
            }
            return false;
        }
        
    }
  
}