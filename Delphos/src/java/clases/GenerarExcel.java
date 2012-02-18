package clases;

import java.awt.Desktop;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.http.HttpServletRequest;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFClientAnchor;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFPatriarch;
import org.apache.poi.hssf.usermodel.HSSFPicture;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;


/*
 * GenerarExcel.java
 *
 * Created on 15 de febrero de 2010, 05:08 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */



/**
 *
 * @author Mauricio
 */
public class GenerarExcel {
    
    /** Creates a new instance of GenerarExcel */
    public GenerarExcel() {
    }
    
     //Metodo que permite insertar imagenes a el excel

   private static int loadPicture( File path, HSSFWorkbook wb ) throws IOException

     {

     int pictureIndex;
     FileInputStream fis = null;
     ByteArrayOutputStream bos = null;

     try

     {

        // read in the image file

         fis = new FileInputStream(path);

         bos = new ByteArrayOutputStream( );

         int c;

        // copy the image bytes into the ByteArrayOutputStream

         while ( (c = fis.read()) != -1)

             bos.write( c );

     

        // add the image bytes to the workbook

         pictureIndex = wb.addPicture(bos.toByteArray(), HSSFWorkbook.PICTURE_TYPE_PNG );

  

      }

      finally

     {

         if (fis != null)

             fis.close();

         if (bos != null)

             bos.close();

   }
   return pictureIndex;
   }
    
    public boolean generarExcel(String sql, String nombreArchivo,HttpServletRequest request)
    {
        
        ConexionBaseDatos c;
        c = new ConexionBaseDatos();
            
        try
        {
            
        HSSFWorkbook libro = new HSSFWorkbook();
        HSSFSheet hoja = libro.createSheet();
        HSSFRow filaHeader = hoja.createRow((short) 0);
        HSSFCell celdaHeader = filaHeader.createCell(0);
        

   HSSFPatriarch patriarch = hoja.createDrawingPatriarch();

   HSSFClientAnchor anchor;

   anchor = new HSSFClientAnchor(500,100,600,200,(short)0,0,(short)1,0);

   anchor.setAnchorType( 2 );

   HSSFPicture picture =  patriarch.createPicture(anchor, loadPicture(new File(request.getRequestURL().toString().substring(0,request.getRequestURL().toString().lastIndexOf("Delphos")+7)+"/images/"+"cabezote.png"), libro ));
        
        ResultSet rs;
        PreparedStatement stmt;

        c.abrirConexion();

        stmt = c.con.prepareStatement(sql);
        rs = stmt.executeQuery();

        String ruta = request.getSession().getServletContext().getRealPath("temp")+"\\";
        ruta = ruta.replaceAll("\\\\","/");
        
        HSSFRow rowTitulos = hoja.createRow((short) 3);
        HSSFCellStyle cs = libro.createCellStyle();
            HSSFFont fuente = libro.createFont();
            fuente.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
            cs.setFont(fuente);
        
        for(int j=1; j<=rs.getMetaData().getColumnCount();j++)
        { 
            HSSFCell celda = rowTitulos.createCell(j);
            celda.setCellValue(rs.getMetaData().getColumnName(j));
            celda.setCellStyle(cs);
        } 
        
        int contador = 5;
        
        while(rs.next())
                {
                    HSSFRow rowResultados = hoja.createRow((short) contador);   
                    
                    for(int i=1; i<=rs.getMetaData().getColumnCount();i++)
                    {   
                        HSSFCell celda = rowResultados.createCell(i);
                        celda.setCellValue(rs.getObject(i).toString());
                    }
                    
                    contador ++;
                }
        
        for (int i = 0; i <= rs.getMetaData().getColumnCount(); i++) 
        {
            hoja.autoSizeColumn((short) i);
        }


        FileOutputStream stream = new 
         FileOutputStream(ruta + nombreArchivo);
        libro.write(stream);
        stream.close();
        
        File path = new File (ruta + nombreArchivo);
        Desktop.getDesktop().open(path);

        return true;

        }
        catch(FileNotFoundException e)
        {
           System.err.println(e.getMessage());
           return false;
        }
        catch(java.io.IOException e)
        {
           System.err.println(e.getMessage());
           return false;
        }catch(SQLException sqle)
            {
                c.cerrarConexion();
                System.err.println("Error al consultar los datos: "+sqle);
                return false;
            }


        }
    
}
