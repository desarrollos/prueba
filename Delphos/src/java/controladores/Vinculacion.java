package controladores;

import clases.FormatosFecha;
import javax.servlet.*;

import java.sql.*;
import clases.ConexionBaseDatos;

public class Vinculacion implements Control{
    
    private String msj;
    private ConexionBaseDatos c;
    
    public boolean doLogic(javax.servlet.http.HttpServletRequest request,
            javax.servlet.http.HttpServletResponse response)
            throws javax.servlet.ServletException, java.io.IOException
    {
        /*if(request.getSession().getAttribute("login") == null)
            return true;*/

        /*if(request.getSession().getAttribute("login") != null)
            if(!request.getSession().getAttribute("perfil").equals("Administrador"))
                return true;*/
        
        if(request.getParameter("hacerSubmit") != null && request.getParameter("hacerSubmit").equals("1"))
        {
            PreparedStatement stmt = null;
            ResultSet rs = null;
            int idProyecto;
            
            
            try
            {
                c = new ConexionBaseDatos();
                c.abrirConexion();
                
                if( request.getParameter("hacerSubmit").equals("1") || request.getParameter("hacerSubmit").equals("2") )
                {
                    if( request.getParameter("hacerSubmit").equals("1") )
                    {
                        stmt = c.con.prepareStatement("INSERT INTO inscripcion (fechainscr, horainscri, codbarrio, tipobeneficiario_coditipben, meno7anyos, meno7a18anyos, residmunic, arcdocapro, numeraprob, estadofamilia_codiestfam, archcomins, tipoidentificacion_codtipoidentidad, idenjefhog, numerdecla, comproblig, entidadsalud_codentidadsalud, numcuebanc, banco_codbanco, funcionario_tipoidentificacion_codtipoidentidad, funcionario_numidentfunc, numeromesa, observacion, codunifami, coddepartamento, codmunicipio, codsubgrupo, entidadsalud_regimen_codregimen) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
                        msj = "ingresada";
                    }
                    else if( request.getParameter("hacerSubmit").equals("2") )
                    {
                        stmt = c.con.prepareStatement("UPDATE inscripcion SET (fechainscr, horainscri, codbarrio, tipobeneficiario_coditipben, meno7anyos, meno7a18anyos, residmunic, arcdocapro, numeraprob, estadofamilia_codiestfam, archcomins, tipoidentificacion_codtipoidentidad, idenjefhog, numerdecla, comproblig, entidadsalud_codentidadsalud, numcuebanc, banco_codbanco, funcionario_tipoidentificacion_codtipoidentidad, funcionario_numidentfunc, numeromesa, observacion, codunifami, coddepartamento, codmunicipio, codsubgrupo, entidadsalud_regimen_codregimen) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) WHERE codunifami=?");
                        msj = "modificada";

                        stmt.setString(28,request.getParameter("codunifami").toUpperCase());
                    }
                    
                    stmt.setDate(1,FormatosFecha.fechaToDate(request.getParameter("fechainscr")));
                    stmt.setTime(2,Time.valueOf(request.getParameter("horainscri")));
                    stmt.setInt(3,Integer.parseInt(request.getParameter("codbarrio").toUpperCase()));
                    stmt.setString(4,request.getParameter("tipobeneficiario_coditipben").toUpperCase());
                    stmt.setInt(5,Integer.parseInt(request.getParameter("meno7anyos").toUpperCase()));
                    stmt.setInt(6,Integer.parseInt(request.getParameter("meno7a18anyos").toUpperCase()));
                    stmt.setString(7,request.getParameter("residmunic").toUpperCase());
                    stmt.setString(8,request.getParameter("arcdocapro").toUpperCase());
                    stmt.setString(9,request.getParameter("numeraprob").toUpperCase());
                    stmt.setString(10,request.getParameter("estadofamilia_codiestfam").toUpperCase());
                    stmt.setString(11,request.getParameter("archcomins").toUpperCase());
                    stmt.setString(12,request.getParameter("tipoidentificacion_codtipoidentidad").toUpperCase());
                    stmt.setString(13,request.getParameter("idenjefhog").toUpperCase());
                    stmt.setString(14,request.getParameter("numerdecla").toUpperCase());
                    stmt.setString(15,request.getParameter("comproblig").toUpperCase());
                    stmt.setString(16,request.getParameter("entidadsalud_codentidadsalud").toUpperCase());
                    stmt.setString(17,request.getParameter("numcuebanc_titular").toUpperCase());
                    stmt.setString(18,request.getParameter("banco_codbanco_titular").toUpperCase());

                    //vars session
                    stmt.setString(19,"1");//request.getParameter("funcionario_tipoidentificacion_codtipoidentidad").toUpperCase());
                    stmt.setString(20,"1");//request.getParameter("funcionario_numidentfunc").toUpperCase());
                    stmt.setString(21,"1");//request.getParameter("numeromesa").toUpperCase());
                    stmt.setString(22,request.getParameter("observacion").toUpperCase());
                    stmt.setString(23,request.getParameter("codunifami").toUpperCase());
                    stmt.setInt(24,1);
                    stmt.setInt(25,1);
                    stmt.setInt(26,1);
                    stmt.setInt(27,1);
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM inscripcion WHERE codunifami=?");
                    msj = "eliminada";
                    
                    stmt.setString(1,request.getParameter("codunifami").toUpperCase());
                }
                
                stmt.executeUpdate();
                
                
                if( request.getParameter("hacerSubmit").equals("1") || request.getParameter("hacerSubmit").equals("2") )
                {
                    if( request.getParameter("hacerSubmit").equals("1") )
                    {
                        stmt = c.con.prepareStatement("INSERT INTO titularfamilia (tipoidentificacion_codtipoidentidad, identitfam, tipotitular_coditiptit, fechinitit, numecueban, vivehisjos, banco_codbanco, estadotitular_codiesttit, firmatitul, observacion, inscripcion_codunifami) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?) ");
                        msj = "ingresada";
                    }
                    else if( request.getParameter("hacerSubmit").equals("2") )
                    {
                        stmt = c.con.prepareStatement("UPDATE titularfamilia SET (tipoidentificacion_codtipoidentidad, identitfam, tipotitular_coditiptit, fechinitit, numecueban, vivehisjos, banco_codbanco, estadotitular_codiesttit, firmatitul, observacion, inscripcion_codunifami) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?) WHERE inscripcion_codunifami = ? and tipoidentificacion_codtipoidentidad=? and identitfam=?");
                        msj = "modificada";
                        
                        stmt.setString(12,request.getParameter("codunifami").toUpperCase());
                        stmt.setString(13,request.getParameter("tipoidentificacion_codtipoidentidad").toUpperCase());
                        stmt.setString(14,request.getParameter("identitfam").toUpperCase());
                    }
                    
                    stmt.setString(1,request.getParameter("tipoidentificacion_codtipoidentidad").toUpperCase());
                    stmt.setString(2,request.getParameter("identitfam").toUpperCase());
                    stmt.setString(3,request.getParameter("tipotitular_coditiptit").toUpperCase());
                    stmt.setDate(4,FormatosFecha.fechaToDate(request.getParameter("fechinitit")));
                    stmt.setString(5,request.getParameter("numcuebanc_titular").toUpperCase());
                    stmt.setString(6,request.getParameter("vivehisjos").toUpperCase());
                    stmt.setString(7,request.getParameter("banco_codbanco").toUpperCase());
                    stmt.setString(8,request.getParameter("estadotitular_codiesttit").toUpperCase());
                    stmt.setString(9,request.getParameter("firmatitul").toUpperCase());
                    stmt.setString(10,request.getParameter("observacion").toUpperCase());
                    stmt.setString(11,request.getParameter("codunifami").toUpperCase());
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM titularfamilia WHERE inscripcion_codunifami = ? and tipoidentificacion_codtipoidentidad=? and identitfam=?");
                    msj = "eliminada";
                    
                    stmt.setString(1,request.getParameter("codunifami").toUpperCase());
                    stmt.setString(2,request.getParameter("tipoidentificacion_codtipoidentidad").toUpperCase());
                    stmt.setString(3,request.getParameter("identitfam").toUpperCase());
                }
                
                stmt.executeUpdate();
                
                ResultSet subsidiosEncontrados = null;

                for( int i=0; i<Integer.parseInt(request.getParameter("contadorPeriodosPago")); i++ )
                {
                    if( request.getParameter("codtipoidentidad_beneficiario"+i) != null )
                    {
                        if( request.getParameter("hacerSubmit").equals("1") || request.getParameter("hacerSubmit").equals("2") )
                        {
                            if( request.getParameter("hacerSubmit").equals("1") )
                            {
                                stmt = c.con.prepareStatement("INSERT INTO beneficiario (codtipoidentidad, identbenef, fechanacim, codigbenef, tipoparentesco_codtipoparentesco, empresa_codempresa, numceresco, gradoactua, entidadsalud_codentidadsalud, banco_codbanco, vivecontit, estadobeneficiario_codiestben, observacion, inscripcion_codunifami, empresa_tipoidentificacion_codtipoidentidad, entidadsalud_regimen_codregimen) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
                                subsidiosEncontrados = encontrarSubsidios( FormatosFecha.edad(request.getParameter("fechanacim"+i)), 1, 1 );
                                msj = "ingresada";
                            }
                            else if( request.getParameter("hacerSubmit").equals("2") )
                            {
                                stmt = c.con.prepareStatement("UPDATE beneficiario SET (codtipoidentidad, identbenef, fechanacim, codigbenef, tipoparentesco_codtipoparentesco, empresa_codempresa, numceresco, gradoactua, entidadsalud_codentidadsalud, banco_codbanco, vivecontit, estadobeneficiario_codiestben, observacion, inscripcion_codunifami, empresa_tipoidentificacion_codtipoidentidad, entidadsalud_regimen_codregimen) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) WHERE inscripcion_codunifami = ? and codtipoidentidad = ? and identbenef = ?");
                                msj = "modificada";

                                stmt.setString(17,request.getParameter("codunifami").toUpperCase());
                                stmt.setString(18,request.getParameter("codtipoidentidad_beneficiario"+i).toUpperCase());
                                stmt.setString(19,request.getParameter("identbenef"+i).toUpperCase());
                            }

                            stmt.setString(1,request.getParameter("codtipoidentidad_beneficiario"+i).toUpperCase());
                            stmt.setString(2,request.getParameter("identbenef"+i).toUpperCase());
                            stmt.setDate(3,FormatosFecha.fechaToDate(request.getParameter("fechanacim"+i)));
                            stmt.setString(4,request.getParameter("codigbenef"+i).toUpperCase());
                            stmt.setString(5,request.getParameter("tipoparentesco_codtipoparentesco"+i).toUpperCase());
                            stmt.setString(6,request.getParameter("empresa_codempresa"+i).toUpperCase());
                            stmt.setString(7,request.getParameter("numceresco"+i).toUpperCase());
                            stmt.setString(8,request.getParameter("gradoactua"+i).toUpperCase());
                            stmt.setString(9,request.getParameter("entidadsalud_codentidadsalud_beneficiario"+i).toUpperCase());
                            stmt.setString(10,request.getParameter("banco_codbanco_beneficiario"+i).toUpperCase());
                            stmt.setString(11,request.getParameter("vivecontit"+i).toUpperCase());
                            stmt.setString(12,request.getParameter("estadobeneficiario_codiestben"+i).toUpperCase());
                            stmt.setString(13,request.getParameter("observacion_beneficiario"+i).toUpperCase());
                            stmt.setString(14,request.getParameter("codunifami").toUpperCase());
                            stmt.setInt(15,1);
                            stmt.setInt(16,1);
                        }
                        else
                        {
                            stmt = c.con.prepareStatement("DELETE FROM beneficiario WHERE inscripcion_codunifami = ? and codtipoidentidad = ? and identbenef = ?");
                            msj = "eliminada";

                            stmt.setString(1,request.getParameter("codunifami").toUpperCase());
                            stmt.setString(2,request.getParameter("codtipoidentidad_beneficiario"+i).toUpperCase());
                            stmt.setString(3,request.getParameter("identbenef"+i).toUpperCase());
                        }
                        
                        stmt.executeUpdate();
                        
                        if( request.getParameter("hacerSubmit").equals("1") )
                        {
                            while( subsidiosEncontrados!= null )
                            {
                                    int codigoSusidio = subsidiosEncontrados.getInt(1);
                                    
                                    stmt = c.con.prepareStatement("INSERT INTO beneficiario (codunifami, codtipoidentidad, subpotidenti, subpotcodsub, subpotvalsub, subtipcodigo, coddepartamento, codmunicipio) values (?, ?, ?, ?, ?, ?, ?, ?)");
                                    stmt.setString(1,request.getParameter("codunifami").toUpperCase());
                                    stmt.setString(2,request.getParameter("codtipoidentidad_beneficiario"+i).toUpperCase());
                                    stmt.setString(3,request.getParameter("identbenef"+i).toUpperCase());
                                    stmt.setInt(4,codigoSusidio);
                                    stmt.setString(5,"0");
                                    stmt.setString(6,"1");
                                    stmt.setString(7,"1");
                                    stmt.setString(8,"1");
                                    
                                    
                                    stmt.executeUpdate();
                            }
                        }
                    }
                }

                
                stmt.close();

                c.cerrarConexion();
            }
            catch(SQLException e)
            {
                c.cerrarConexion();
                msj = "Error al Actualizar la Base de Datos: "+e+"<br>\n<script>alert('Error al Actualizar el Proyecto')</script>";
                request.setAttribute("msj",msj);
                return true;
            }
            
            msj = "La información ha sido " +msj+ " con exito<br>"
                  +"\n<script>alert('La información ha sido " +msj+ " con exito!')</script>"
                  +"<script>window.top.location='Vinculacion.jsp';</script>";

            request.setAttribute("msj", msj);
            return true;
        }
        return true;
    }
    
    public ResultSet encontrarSubsidios( int edad, int codigodepartamento, int codigomunicipio  ) throws java.sql.SQLException
    {
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        stmt = c.con.prepareStatement("select"
	+"a.subscodigo"
        +"from (((( subsidio a join clasebeneficiario b"
	+"on a.clabencodigo = b.clabencodigo ) join escgrupogrado c"
	+"on a.grugracodigo = c.grugracodigo ) join subsidiomunicipio e"
	+"on a.subscodigo = e.subscodigo ) join tiposubsidio f"
	+"on a.subtipcodigo = f.subtipcodigo ) join subsidiocategoria g"
	+"on f.subcatcodigo = g.subcatcodigo"
        +"where"
	+"e.coddepartamento = ? and e.codmunicipio = ?"
	+"and b.clabenedaini < ? and b.clabenedafin > ?");
        
        stmt.setInt(1,codigodepartamento);
        stmt.setInt(2,codigomunicipio);
        stmt.setInt(3,edad);
        stmt.setInt(4,edad);
        
        rs = stmt.executeQuery();
        
        stmt.close();
        
        return rs;
    }
}