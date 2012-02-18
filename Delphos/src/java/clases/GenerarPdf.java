package clases;

//import com.itextpdf.text.Document;
//import com.itextpdf.text.DocumentException;
//import com.itextpdf.text.Element;
//import com.itextpdf.text.PageSize;
//import com.itextpdf.text.Paragraph;
//import com.itextpdf.text.Image;
//import com.itextpdf.text.Phrase;
//import com.itextpdf.text.pdf.PdfPCell;
//import com.itextpdf.text.pdf.PdfWriter;
//import com.itextpdf.text.pdf.PdfPTable;
//import java.awt.Desktop;
//import java.io.File;
//import java.io.FileOutputStream;
//import java.io.IOException;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
//import java.sql.SQLException;
import javax.servlet.http.HttpServletRequest;

public class GenerarPdf 
{
    public GenerarPdf() 
    {
    }
    
    public boolean generarPdf(String sql, String nombreArchivo,HttpServletRequest request)
    {

//            ConexionBaseDatos c;
//            c = new ConexionBaseDatos();
//	    Document documento = new Document(PageSize.LETTER.rotate());
//            PdfPTable tabla;
//            
//	    try {
//               
//                ResultSet rs;
//                PreparedStatement stmt;
//
//                c.abrirConexion();
//
//                stmt = c.con.prepareStatement(sql);
//                rs = stmt.executeQuery();
//
//                String ruta = request.getSession().getServletContext().getRealPath("temp")+"\\";
//                ruta = ruta.replaceAll("\\\\","/");
//                
//	        PdfWriter.getInstance(documento,new FileOutputStream(ruta + nombreArchivo));
//                documento.open();
//                
//                Image img1 = Image.getInstance(request.getRequestURL().toString().substring(0,request.getRequestURL().toString().lastIndexOf("Delphos")+7)+"/images/"+"cabezote.png");
//                img1.scalePercent(60);
//                float imgY = documento.top() - 80 ;
//                float imgX = documento.left() + 75;
//                img1.setAbsolutePosition(imgX, imgY);
//                documento.add(img1);
//                
//                for(int h=1; h<=6;h++)
//                { 
//                    Paragraph parrafo = new Paragraph(" ");
//                    documento.add(parrafo);
//                }
//                
//                tabla = new PdfPTable(rs.getMetaData().getColumnCount());
//                
//                for(int j=1; j<=rs.getMetaData().getColumnCount();j++)
//                { 
//                    PdfPCell celda = new PdfPCell(new Paragraph(rs.getMetaData().getColumnName(j)));
//                    celda.setHorizontalAlignment(Element.ALIGN_CENTER);
//                    celda.setColspan(1);
//                    tabla.addCell(celda);
//                }
//                
//                while(rs.next())
//                {
//                    int i;
//
//                    for(i=1; i<=rs.getMetaData().getColumnCount();i++)
//                    {   
//                        PdfPCell celda = new PdfPCell(new Paragraph( rs.getObject(i).toString()));
//                        celda.setHorizontalAlignment(Element.ALIGN_CENTER);
//                        celda.setColspan(1);
//                        tabla.addCell(celda);
//                    }
//                }
//            
//                documento.add(tabla);
//                
//                File path = new File (ruta + nombreArchivo);
//                Desktop.getDesktop().open(path);
//                
//	    } catch (DocumentException de) {
//	        System.err.println(de.getMessage());
//                return false;
//	    } catch (IOException ioe) {
//	        System.err.println(ioe.getMessage());
//                return false;
//	    }catch(SQLException sqle)
//        {
//            c.cerrarConexion();
//            System.err.println("Error al consultar los datos: "+sqle);
//            return false;
//        }
//
//	    documento.close();
//       
        return true;
   }
}
