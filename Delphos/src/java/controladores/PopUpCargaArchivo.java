package controladores;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.util.StringTokenizer;
import java.util.Vector;
import clases.ConexionBaseDatos;
import clases.FormatosFecha;
import clases.FormatoTimestamp;
import clases.edZip;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;
import java.util.List;
import java.util.Iterator;

public class PopUpCargaArchivo implements Control {

    private String msj, hacerSubmit, campoRetorno;
    private ConexionBaseDatos c;
    private String nombreArchivo;
    private String rutaServidor;
    private String llave, coddepartamento, codmunicipio, encuendirecc, enculugarefe, encuenfecha, tisiscodigo, encunumepart, encutemaprin, coditiporeun, codtipoidentidad, encidemadlid, encuenpropos, encuenobjeti, encusoluenco, encuenobserv, encuarchdocu, encufechinfo, encuencodigo;
    private edZip zip;

    public boolean doLogic(javax.servlet.http.HttpServletRequest request,
            javax.servlet.http.HttpServletResponse response)
            throws javax.servlet.ServletException, java.io.IOException {
        //rutaServidor = request.getSession().getServletContext().getRealPath(request.getContextPath())+"\\temp\\";
        rutaServidor = (request.getSession().getServletContext().getRealPath("temp") + File.separatorChar).replaceAll("\\\\", "/");

        obtenerValoresFormulario(request);

        if (hacerSubmit != null && !hacerSubmit.equals("0")) {
            msj = "La información ha sido cargada con exito<br>"
                    + "\n<script>alert('La información ha sido cargada con exito!')</script>"
                    + "<script>window.opener.document.getElementById('" + campoRetorno + "').value='" + nombreArchivo + "';window.opener.document.getElementById('nombreArchivo2').value='" + nombreArchivo + "';</script>"
                    + "<script>window.close();</script>";

            request.setAttribute("msj", msj);
            return true;
        }
        return true;
    }
//---------------------------------------------------------------------------------------------------

    private void procesarCampoFormulario(FileItem item) {
        if (item.isFormField()) {
            String name = item.getFieldName();
            String value = item.getString();

            if (name.equals("hacerSubmit")) {
                hacerSubmit = value;
            } else if (name.equals("campo")) {
                campoRetorno = value;
            }
        }
    }
//---------------------------------------------------------------------------------------------------

    private boolean processUploadedFile(FileItem item) {
        if (!item.isFormField()) {
            zip = new edZip();

            String fieldName = item.getFieldName();
            String fileName = item.getName();
            String contentType = item.getContentType();
            boolean isInMemory = item.isInMemory();
            long sizeInBytes = item.getSize();

            System.out.println("fileName: " + FilenameUtils.getName(fileName) + " |  " + fileName);
            System.out.println("fieldName: " + fieldName);
            System.out.println("contentType: " + contentType);

            if (fieldName.equals("archivo")) {
                encuarchdocu = fileName;
            }

            if (!FilenameUtils.getName(fileName).equals("")) {
                try {
                    //File uploadedFile = new File(rutaServidor+FilenameUtils.getName(fileName).replace(" ", "_"));
                    File uploadedFile = new File(rutaServidor + FilenameUtils.getName(fileName).replace(" ", "_"));
                    //System.out.println(" uploadedFile " + rutaServidor+FilenameUtils.getName(fileName));
                    nombreArchivo = FilenameUtils.getName(fileName).replace(" ", "_");
                    item.write(uploadedFile);

                    String[] extension = fileName.split("\\.");

                    System.out.println("extension.length" + extension.length + " " +extension[1] );
                    if (extension[1].toUpperCase().equals("ZIP")) {
                        nombreArchivo =  zip.ed_Extractar(rutaServidor + fileName, rutaServidor);
                    }
                    

                    String comando;
                    comando = "cacls " + rutaServidor.replace("\\\\", "/") + "*.* /E /G Users:R";
                    try {
                        Runtime.getRuntime().exec(comando);
                    } catch (Exception e) {
                    }

                    comando = "cacls " + rutaServidor.replace("\\\\", "/") + "*.* /E /G Guest:R";
                    try {
                        Runtime.getRuntime().exec(comando);
                    } catch (Exception e) {
                    }

                    comando = "cacls " + rutaServidor.replace("\\\\", "/") + "*.* /E /G Invitado:R";
                    try {
                        Runtime.getRuntime().exec(comando);
                    } catch (Exception e) {
                    }

                    comando = "cacls " + rutaServidor.replace("\\\\", "/") + "*.* /E /G Usuario:R";
                    try {
                        Runtime.getRuntime().exec(comando);
                    } catch (Exception e) {
                    }

                    return true;
                } catch (Exception e) {
                    System.err.println("Exception: " + e);
                    System.err.println("Error al subir el archivo: " + fileName);
                    return false;
                }
            } else {
                return true;
            }
        }
        return false;
    }

    private void obtenerValoresFormulario(javax.servlet.http.HttpServletRequest request) {
        try {
            FileItemFactory factory = new DiskFileItemFactory();
            ServletFileUpload upload = new ServletFileUpload(factory);
            List fileItems = upload.parseRequest(request);
            Iterator iter = fileItems.iterator();

            while (iter.hasNext()) {
                FileItem item = (FileItem) iter.next();

                if (item.isFormField()) {
                    procesarCampoFormulario(item);
                } else {
                    if (!processUploadedFile(item)) {
                        msj = "<p align=\"center\" class=\"errorSubmit\">Error al cargar el archivo</p>"
                                + "<script>alert('Error al cargar el archivo');</script>";

                        request.setAttribute("msj", msj);
                    }
                }
            }
        } catch (FileUploadException fe) {
            System.err.println("Error: " + fe);
        }
    }
}