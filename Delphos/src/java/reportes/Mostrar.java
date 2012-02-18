/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Reportes;

import clases.ConexionBaseDatos;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;


import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;

// Excel


import net.sf.jasperreports.engine.export.*;
import net.sf.jasperreports.engine.*;
import java.io.*;


import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;

// SQL Dinamica
import clases.generacionSqlDinamica;

/**
 *
 * @author John J.S
 */
public class Mostrar extends HttpServlet {

    private String[] seleccionados = null;
    private Connection con = null;
    private String[] varsForm = null;
    public String urlLogoDelphos;

    // Esta variable almacenera el Tama?o .length() de la Descripcion de los campos
    // para calcular medidas del Reporte en pixeles.
    public int tamanoDesc = 0;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    public void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {


        ConexionBaseDatos con;
        con = new ConexionBaseDatos();
        con.abrirConexion();

        urlLogoDelphos = request.getSession().getServletContext().getRealPath("reportes") + File.separatorChar + "formatos" + File.separatorChar + "LogoDelphos.png";

        // Obtenemos los elementos seleccionados...
        obtenerSeleccion(request);
        crearJrxml(request);
        compilarJrxml(request);

       HashMap ParametrosReport = new HashMap();
       ParametrosReport.put("URL_LOGO_DELPHOS", urlLogoDelphos );

        ServletOutputStream servletOutputStream = response.getOutputStream();

        if (request.getParameter("tipoReporte").equals("pdf")) {


            InputStream reportStream = getServletConfig().getServletContext().getResourceAsStream("/reportes/formatos/reporte.jasper");

            try {
                JasperRunManager.runReportToPdfStream(reportStream, servletOutputStream, ParametrosReport , con.con);
                //byte[] bytes = JasperRunManager.runReportToPdf(reportStream, new HashMap() ,con.con);
                response.setContentType("application/pdf");
                servletOutputStream.flush();
                servletOutputStream.close();
                eliminarJasper(request);
            } catch (JRException e) {
                StringWriter stringWriter = new StringWriter();
                PrintWriter printWriter = new PrintWriter(stringWriter);
                e.printStackTrace(printWriter);
                response.setContentType("text/plain");
                response.getOutputStream().print(stringWriter.toString());
            }
        } else if (request.getParameter("tipoReporte").equals("excel")) {
            try {
                int bit;
                File f;
                InputStream in;
                ServletOutputStream out;

                
                JasperPrint jasperPrint = JasperFillManager.fillReport(request.getRealPath("reportes/formatos/reporte.jasper"), ParametrosReport , con.con);
                String xlsFileName = request.getRealPath("reportes/formatos/poblacion.xls");

                //Creacion del XLS
                JRXlsExporter exporter = new JRXlsExporter();
                exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
                exporter.setParameter(JRExporterParameter.OUTPUT_FILE_NAME, xlsFileName);
                exporter.setParameter(JRXlsExporterParameter.IS_ONE_PAGE_PER_SHEET, Boolean.TRUE);
                exporter.exportReport();

                // En este punto ya esta Creado el XLS
                // Ahora leemos el fichero y forzamos al navegador a que nos descargue el fichero.
                f = new File(request.getRealPath("reportes/formatos/poblacion.xls"));

                response.setContentType("application/vnd.ms-excel"); //Tipo de fichero.
                response.setHeader("Content-Disposition", "attachment;filename=\"" + "Reporte Delphos" + "\""); //Configurar cabecera http

                in = new FileInputStream(f);
                out = response.getOutputStream();

                bit = 256;
                while ((bit) >= 0) {
                    bit = in.read();
                    out.write(bit);
                }

                out.flush();
                out.close();
                in.close();
                eliminarJasper(request);
            } catch (JRException e) {
                System.out.println(e.getMessage());
                e.printStackTrace();
            }
        }
    }

    public String[] campo_tipo(int n) {
        String campo_tipo[] = seleccionados[n].split("-");
        return campo_tipo;
    }

    // Crear el .jrxml que sera compilado mas adelante.
    public void crearJrxml(HttpServletRequest request) {

        CalcularLongitudDatos();

        generacionSqlDinamica DiametrosDinamicos = new generacionSqlDinamica();

        /*** Mensajes de Control Tama?o Reporte
        System.out.println("Valor del length " + tamanoDesc);
        System.out.println("1.El Tamano de la Hoja sera " + DiametrosDinamicos.DimencionReport("Hoja", tamanoDesc) );
        System.out.println("2.El Tamano de las bandas y lineas " + DiametrosDinamicos.DimencionReport("Banda_Lineas", tamanoDesc) );
        System.out.println("3.La Posicion del Logo Sera " + DiametrosDinamicos.DimencionReport("Logo_Delphos", tamanoDesc) );
        System.out.println("4.El paginador estara ubicado entre " + DiametrosDinamicos.DimencionReport("Paginador1", tamanoDesc) + " y " + DiametrosDinamicos.DimencionReport("Paginador2", tamanoDesc) );
        System.out.println("5.La margen es " + DiametrosDinamicos.DimencionReport("Margen", tamanoDesc) );
         */
        String sql = sqlDinamica(request);

        File jrxml = new File(request.getRealPath("reportes" + File.separator + "/formatos/reporte.jrxml"));
        StringBuffer xml = new StringBuffer("<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>"
                + "<jasperReport xmlns=\"http://jasperreports.sourceforge.net/jasperreports\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:schemaLocation=\"http://jasperreports.sourceforge.net/jasperreports http://jasperreports.sourceforge.net/xsd/jasperreport.xsd\" name=\"PlantillaReporte\" language=\"groovy\" "
                + "pageWidth=\""+DiametrosDinamicos.DimencionReport("Hoja", tamanoDesc)+"\" pageHeight=\"595\"  orientation=\"Landscape\" columnWidth=\""+ DiametrosDinamicos.DimencionReport("Margen", tamanoDesc) +"\" leftMargin=\"20\" rightMargin=\"20\" topMargin=\"20\" bottomMargin=\"20\">"
                + "<property name=\"ireport.zoom\" value=\"0.826446280991736\"/>"
                + "<property name=\"ireport.x\" value=\"0\"/>"
                + "<property name=\"ireport.y\" value=\"0\"/>"
                + "<style name=\"Title\" fontName=\"Arial\" fontSize=\"26\" isBold=\"true\" pdfFontName=\"Helvetica-Bold\"/>"
                + "<style name=\"SubTitle\" forecolor=\"#666666\" fontName=\"Arial\" fontSize=\"18\"/>"
                + "<style name=\"Column header\" forecolor=\"#666666\" fontName=\"Arial\" fontSize=\"12\" isBold=\"true\"/>"
                + "<style name=\"Detail\" fontName=\"Arial\" fontSize=\"12\"/>"
                + "<style name=\"Row\" mode=\"Transparent\">"
                + "<conditionalStyle>"
                + "<conditionExpression><![CDATA[$V{REPORT_COUNT}%2 == 0]]></conditionExpression>"
                + "<style backcolor=\"#B2D65B\"/>"
                + "</conditionalStyle>"
                + "</style>");

                xml.append(" <parameter name=\"URL_LOGO_DELPHOS\" class=\"java.lang.String\">"
                        + " "
                        + " 	</parameter>");


        xml.append("<queryString>"
                + " <![CDATA[" + request.getParameter("sql") + "]]>"
                + " </queryString>");

        for (int n = 0; n < seleccionados.length; n++) {
            String campo_tipo[] = campo_tipo(n);
            String campo = campo_tipo[ 0];
            String tipoDato = campo_tipo[ 1];
            xml.append("<field name=\"" + campo + "\" class=\"" + tipoDato + "\"/>");
        }
        //<imageExpression class=\"java.lang.String\"><![CDATA[\"LogoDelphos.png\"]]></imageExpression>"
        //<imageExpression class=\"java.lang.String\"><![CDATA[\""+urlLogoDelphos+"\"]]></imageExpression>"
        xml.append("<background>"
                + "<band splitType=\"Stretch\"/>"
                + "	</background>"
                + "	<title>"
                + "		<band height=\"70\" splitType=\"Stretch\">"
                + "			<image onErrorType=\"Error\" isLazy=\"false\" >" //  Tratado de Errores al Cargar Imagen onErrorType="Icon"  , Blank , Error
                + "				<reportElement x=\""+ DiametrosDinamicos.DimencionReport("Logo_Delphos", tamanoDesc) +"\" y=\"0\" width=\"160\" height=\"64\"/>"
                + "				<imageExpression class=\"java.lang.String\"><![CDATA[$P{URL_LOGO_DELPHOS}]]></imageExpression>"
                + "			</image>"
                + "			<staticText>"
                + "				<reportElement style=\"Title\" x=\"0\" y=\"13\" width=\"486\" height=\"33\"/>"
                + "				<textElement verticalAlignment=\"Middle\"/>"
                + "				<text><![CDATA[DELPHOS - Inteligencia en Salud]]></text>"
                + "			</staticText>"
                + "			<staticText>"
                + "				<reportElement style=\"SubTitle\" x=\"100\" y=\"46\" width=\"205\" height=\"22\"/>"
                + "				<textElement/>"
                + "				<text><![CDATA[Reporte Poblacional]]></text>"
                + "			</staticText>"
                + "		</band>"
                + "	</title>"
                + "	<pageHeader>"
                + "		<band splitType=\"Stretch\"/>"
                + "	</pageHeader>"
                + "	<columnHeader>"
                + "		<band height=\"36\" splitType=\"Stretch\">");

                
                // Con ayuda de este for agregamos una descripcion a cada columna :)
              for (int n = 0; n < seleccionados.length; n++) {
                String campo_tipo[] = campo_tipo(n);
                String desc = campo_tipo[ 2];

                xml.append("<staticText>"
                        + " <reportElement style=\"Column header\" x=\"" + 105 * n + "\" y=\"19\" width=\"105\" height=\"15\"/>"
                        + " <textElement />" //Centrar los titulos de las Columnas textAlignment=\"Center\"
                        + " <text><![CDATA[" + desc + "]]></text>"
                        + " </staticText>");
                }



            xml.append("<line>"
                    + "	<reportElement positionType=\"FixRelativeToBottom\" x=\"0\" y=\"35\" width=\""+ DiametrosDinamicos.DimencionReport("Banda_Lineas", tamanoDesc) +"\" height=\"1\"/>"
                    + "	<graphicElement>"
                    + "	<pen lineWidth=\"0.5\" lineColor=\"#999999\"/>"
                    + "	</graphicElement>"
                    + "	</line>"
                    + "	</band>"
                    + "	</columnHeader>");

        xml.append("<detail>"
                + "		<band height=\"16\" splitType=\"Stretch\">"
                + "			<frame>"
                + "				<reportElement style=\"Row\" mode=\"Opaque\" x=\"0\" y=\"0\" width=\""+ DiametrosDinamicos.DimencionReport("Banda_Lineas", tamanoDesc) +"\" height=\"15\"/>");


        for (int n = 0; n < seleccionados.length; n++) {
            String campo_tipo[] = campo_tipo(n);
            String campo = campo_tipo[ 0];
            String tipoDato = campo_tipo[ 1];
            String desc = campo_tipo[ 2];

            /* Generacion del Area de detail dinamica*/
            xml.append("<textField>"
                    + "	<reportElement x=\"" + 105 * n + "\" y=\"0\" width=\"105\" height=\"15\"/>"
                    + "	<textElement/>"
                    + "	<textFieldExpression class=\"" + tipoDato + "\"><![CDATA[$F{" + campo + "}]]></textFieldExpression>"
                    + "	</textField>");

        }

        xml.append("</frame>"
                + "		</band>"
                + "	</detail>"
                + "	<pageFooter>"
                + "		<band height=\"20\" splitType=\"Stretch\">"
                + "			<textField>"
                + "				<reportElement style=\"Column header\" x=\""+ DiametrosDinamicos.DimencionReport("Paginador1", tamanoDesc) +"\" y=\"0\" width=\"80\" height=\"20\"/>"
                + "				<textElement textAlignment=\"Right\">"
                + "					<font size=\"10\" isBold=\"false\"/>"
                + "				</textElement>"
                + "				<textFieldExpression class=\"java.lang.String\"><![CDATA[\"Pagina \"+$V{PAGE_NUMBER}+\" de\"]]></textFieldExpression>"
                + "			</textField>"
                + "			<textField evaluationTime=\"Report\">"
                + "				<reportElement style=\"Column header\" x=\""+ DiametrosDinamicos.DimencionReport("Paginador2", tamanoDesc) +"\" y=\"0\" width=\"40\" height=\"20\"/>"
                + "				<textElement>"
                + "                                <font size=\"10\" isBold=\"false\"/>"
                + "				</textElement>"
                + "				<textFieldExpression class=\"java.lang.String\"><![CDATA[\" \" + $V{PAGE_NUMBER}]]></textFieldExpression>"
                + "			</textField>"
                + "			<textField pattern=\"EEEEE dd MMMMM yyyy\">"
                + "				<reportElement style=\"Column header\" x=\"99\" y=\"0\" width=\"108\" height=\"20\"/>"
                + "				<textElement>"
                + "					<font size=\"10\" isBold=\"false\"/>"
                + "				</textElement>"
                + "				<textFieldExpression class=\"java.util.Date\"><![CDATA[new java.util.Date()]]></textFieldExpression>"
                + "			</textField>"
                + "			<line>"
                + "				<reportElement positionType=\"FixRelativeToBottom\" x=\"0\" y=\"0\" width=\""+ DiametrosDinamicos.DimencionReport("Banda_Lineas", tamanoDesc) +"\" height=\"1\"/>"
                + "				<graphicElement>"
                + "					<pen lineWidth=\"0.5\" lineColor=\"#999999\"/>"
                + "				</graphicElement>"
                + "			</line>"
                + "			<staticText>"
                + "				<reportElement x=\"1\" y=\"0\" width=\"100\" height=\"20\" forecolor=\"#666666\" backcolor=\"#666666\"/>"
                + "				<textElement/>"
                + "				<text><![CDATA[Fecha Generacion :]]></text>"
                + "			</staticText>"
                + "			<textField pattern=\"h.mm a\">"
                + "				<reportElement x=\"202\" y=\"0\" width=\"100\" height=\"20\" forecolor=\"#666666\"/>"
                + "				<textElement/>"
                + "				<textFieldExpression class=\"java.util.Date\"><![CDATA[new java.util.Date()]]></textFieldExpression>"
                + "			</textField>"
                + "		</band>"
                + "	</pageFooter>"
                + "</jasperReport>");

        try {
            FileWriter fw = new FileWriter(jrxml);
            fw.write(xml.toString());
            fw.close();
        } catch (IOException e) {
            System.out.println("Problemas encontrados al Escribir Archivo: " + e);
            return;
        }

    }

    public void compilarJrxml(HttpServletRequest request) {
        try {
            JasperCompileManager.compileReportToFile(request.getRealPath("reportes/formatos/reporte.jrxml"), request.getRealPath("reportes/formatos/reporte.jasper"));
            System.out.println("Reporte compilado");
        } catch (JRException e) {
            System.out.println("Problemas encontrados al compilar JRXML " + e.getMessage());
        }

    }

    // Obtiene los valores de los checkbox seleccionados
    public void obtenerSeleccion(HttpServletRequest request) {
        // Por medio del request... obtenemos los elementos seleccionados en las listas
        String elementos[] = request.getParameterValues("seleccionados[]");
        // Mientras que haya alguna seleccion continuamos...
        if (elementos != null) {
            // Hacemos que la informacion este accesible por otras fuentes.
            seleccionados = elementos;
        }
    }

    public String sqlDinamica(HttpServletRequest request) {
        generacionSqlDinamica sqlO = new generacionSqlDinamica();
        String sql = sqlO.init( request );
        return "";
   }

    /**
     * Con esta funcion se captura el Tama?o de las Descripciones
     * y en base a ese se llena la variable tamanoDesc que
     * sera la que se enviara por parametro a DimencionReport()
     * para calcular en pixeles los tama?os de los elementos
     * del Reporte.
     *
     */

    public void CalcularLongitudDatos() {
        tamanoDesc = 0;
        for (int n = 0; n < seleccionados.length; n++) {
            String campo_tipo[] = campo_tipo(n);
            String desc = campo_tipo[ 2];
            tamanoDesc += desc.length();
        }
    }
/**
 * elimnarJasper elimina los archivos temporales  generados por el JasperREport
 *
 * @param request Peticion http.
 *
 */

    void eliminarJasper(HttpServletRequest request){
        String jasper = request.getSession().getServletContext().getRealPath("reportes") + File.separatorChar + "formatos" + File.separatorChar + "reporte.jasper";
        String jrxml = request.getSession().getServletContext().getRealPath("reportes") + File.separatorChar + "formatos" + File.separatorChar + "reporte.jrxml";
        File reporte_jasper = new File( jasper );
        File reporte_jrxml = new File( jrxml );
        
        if ( reporte_jasper.exists()){
            reporte_jasper.delete();
            System.out.println(".jasper Eliminado");
        }
        
        if ( reporte_jrxml.exists()){
            reporte_jrxml.delete();
            System.out.println(".jrxml Eliminado"); 
        }



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
