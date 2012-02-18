package controladores;

import clases.UtilidadesDKDA;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.util.StringTokenizer;
import java.util.Vector;
import clases.ConexionBaseDatos;
import clases.FormatosFecha;
import clases.GenerarArchivoPlano;

public class GenerarPlanoPoblacion implements Control{
    
    private String msj;
    
    public boolean doLogic(javax.servlet.http.HttpServletRequest request,
            javax.servlet.http.HttpServletResponse response)
            throws javax.servlet.ServletException, java.io.IOException
    {
        /*if(request.getSession().getAttribute("login") == null)
            return true;*/

        /*if(request.getSession().getAttribute("login") != null)
            if(!request.getSession().getAttribute("perfil").equals("Administrador"))
                return true;*/
        
        if(request.getParameter("hacerSubmit") != null)
        {
            String nombreArchivo = "", sql = "";
            nombreArchivo = "Pob"+request.getParameter("codregimen").toUpperCase()+"."+UtilidadesDKDA.obtenerFechaActual()+" "+UtilidadesDKDA.obtenerHoraActual()+".txt";
            nombreArchivo = nombreArchivo.replaceAll(":","");
            
            GenerarArchivoPlano plano;
            plano = new GenerarArchivoPlano();

            sql = "SELECT p.codtipoidentafiliado, p.numeroidentafiliado, p.consecutivoafil, p.primernombre, p.segundonombre, "+
"p.primerapellido, p.segundoapellido, p.codsexo, p.codestadocivil, p.fechanacimiento, p.coddepartamentonac,  "+
"p.codmunicipionac, p.fechaafilsissegsoc, p.fechaafileps, p.codcondbeneficiario18,  "+
"p.codtipoafiliado, p.codactividadeconomica, p.codtipocotizante, p.tipoidentcotizante, "+ 
"p.numeroidentcotizante, p.tipoparentescocot, p.tipoidentaportante,  "+
"p.numeroidentaportante, p.fechavincaportante, p.coddepartamentore,  "+
"p.codmunicipiore, p.codzonageo, p.codsubgrupo, p.barriores, p.codsectorgeografico,  "+
"p.tamanogeografico, p.secciongeografica, p.manzanageografica, p.direccionres,  "+
"p.telefonores, p.energia, p.alcantarillado, p.gas, p.telefono, p.basura,  "+
"p.acueducto, p.agua, p.tipohogar, p.recoleccion, p.aplicafichasisben, p.fichasisben,  "+
"p.codtipoidentaplisisben, p.codestrato, p.codnivelclasificacion, p.codocupacion,  "+
"p.codtipoidentidadem, p.codempresa, p.codempresaaplisisben, p.numerocarne,  "+
"p.numeropatronal, p.nombrepadre, p.nombremadre, p.saldocredito, p.deudormoroso,  "+
"p.numerohistoriaclinica, p.codestadohistclinica, p.fechaultatencion,  "+
"p.tienehuella, /*p.huelladactilar, p.foto,*/ p.ubicacionacthistclinica, p.codcentroatencion,  "+
"p.codunidadfuncional, p.codareaservicio, p.codgrupopoblacion, p.codregimenctoppal,  "+
"p.codentidadsaludctoppal, p.codcontratoppal, p.codregimencto2, p.codentidadsaludcto2,  "+
"p.codcontrato2, p.codregimencto3, p.codentidadsaludcto3, p.codcontrato3,  "+
"p.codetnia, p.codmodalidadsubsidio, p.poliza, p.codtipopoliza, p.fechainiciopoliza,  "+
"p.encuestador, p.supervisor, p.digitador, p.fechasisben, p.vivienda, p.riesgo,  "+
"p.pared, p.piso, p.condicionhogar, p.tenedorvivienda, p.estadocuarto, p.estadodormitorio,  "+
"p.numerosanitario, p.usasanitario, p.usosanitario, p.tiposanitario, p.ducha,  "+
"p.cocinan, p.alumbrado, p.usatelefono, p.tienenevera, p.tienelavadora,  "+
"p.tienetvcolor, p.tienetvcable, p.tienecalendador, p.tienehorno, p.tieneaire,  "+
"p.totalpersona, p.orden, p.conyugevivienda, p.numerohijos, p.estaembarazada,  "+
"p.discapacidad, p.tipocarne, p.asisteass, p.tipoestado, p.grado, p.nivel,  "+
"p.tipoactividad, p.buscando, p.ingresosmes, p.edad, p.puntaje, p.fechamodificacion,  "+
"p.nucleofamiliar, p.parientesnucleo, p.codcapacpagousua, p.codestadoafil,  "+
"p.codcondicionusuario, p.codestadousuapoblac, p.codtipopoblacion, p.afiliadocarnetizado, p.afiliadoenbdua, p.codgruposanguineo "+
"FROM poblacion p, poblacioncto pc, regimen r, contrato c, entidadsalud e "+
"WHERE p.idusuario=pc.idusuario --Relacion tabla poblacion y poblacioncto "+
"AND pc.codregimenes=c.codregimenes AND pc.codentidadsalud=c.codentidadsalud AND pc.codcontrato=c.codcontrato --Relacion tabla poblacioncto y contrato "+
"AND c.codregimenes=e.codregimenes AND c.codentidadsalud=e.codentidadsalud -- Relacion tabla contrato y entidadsalud "+
"AND e.codregimenes=r.codregimen -- Relacion tabla entidadsalud y regimen "+
"AND r.codregimen='"+request.getParameter("codregimen")+"';";
            
            if(plano.generarArchivoPlano(sql,nombreArchivo,request))
            {
                msj = "<a href='../temp/"+nombreArchivo+"' target='_blank'>" +
                      "<img src='../images/Novedad.gif' border='0'>" +
                      "</a><br>Descargar";
            }
            else
            {
                msj = "";
            }
            
            request.setAttribute("msj",msj);
            
            return true;
        }
        return true;
    }
}