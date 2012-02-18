package clases;

import java.io.*;
import java.util.*;
import java.util.zip.*;

public class edZip {

    public void edZip() {
        // comprimir("/media/d/Desarrollos/Delphos/Delphos/build/web/temp/615/Inconsistencias_1DatosCortos.zip", "/media/d/Desarrollos/Delphos/Delphos/build/web/temp/615/Inconsistencias_1DatosCortos.txt");
    }

    public void comprimir(String urlZip, String urlArchivo) {
        try {
            /*
             * "C:/FileIO/zipdemo.zip";
             *   "C:/FileIO/sourcefile.doc";
             */
            String zipFile = urlZip;
            String sourceFile = urlArchivo;

            //create byte buffer
            byte[] buffer = new byte[1024];
            /*
             * To create a zip file, use
             *
             * ZipOutputStream(OutputStream out)
             * constructor of ZipOutputStream class.
             *
             */

            //create object of FileOutputStream
            FileOutputStream fout = new FileOutputStream(zipFile);

            //create object of ZipOutputStream from FileOutputStream
            ZipOutputStream zout = new ZipOutputStream(fout);

            //create object of FileInputStream for source file
            FileInputStream fin = new FileInputStream(sourceFile);

            /*
             * To begin writing ZipEntry in the zip file, use
             *
             * void putNextEntry(ZipEntry entry)
             * method of ZipOutputStream class.
             *
             * This method begins writing a new Zip entry to
             * the zip file and positions the stream to the start
             * of the entry data.
             */

            zout.putNextEntry(new ZipEntry(sourceFile));

            /*
             * After creating entry in the zip file, actually
             * write the file.
             */
            int length;

            while ((length = fin.read(buffer)) > 0) {
                zout.write(buffer, 0, length);
            }

            /*
             * After writing the file to ZipOutputStream, use
             *
             * void closeEntry() method of ZipOutputStream class to
             * close the current entry and position the stream to
             * write the next entry.
             */

            zout.closeEntry();

            //close the InputStream
            fin.close();

            //close the ZipOutputStream
            zout.close();

            System.out.println("Zip file has been created!");

        } catch (IOException ioe) {
            System.out.println("IOException :" + ioe);
        }
    }

    /**
     * Extraccion de Archivos Comprimidos Zip
     * 
     * @param rutaZip Ruta del Archivo comprimido con extension zip
     * @param rutaExtraccion  Ruta donde se sera extractado el archivo(s).
     * @see SOLO ARCHIVOS ZIP  http://www.javahispano.org/contenidos/es/compresrion_en_java/
     */
    public String ed_Extractar(String rutaZip, String rutaExtraccion) {
        //Extracción
        final int BUFFER = 2048;
        String nArchivoExtraido = "unknown";

        try {
            BufferedOutputStream dest = null;
            BufferedInputStream is = null;
            ZipEntry entry;
            ZipFile zipfile = new ZipFile(rutaZip);
            Enumeration e = zipfile.entries();
            while (e.hasMoreElements()) {

                entry = (ZipEntry) e.nextElement();
                System.out.println("Extracting: " + entry);
                is = new BufferedInputStream(zipfile.getInputStream(entry));
                int count;
                byte data[] = new byte[BUFFER];             ///home/gaso/Documentos/
                FileOutputStream fos = new FileOutputStream(rutaExtraccion + entry.getName().replace(" ", "_"));
                nArchivoExtraido = entry.getName().replace(" ", "_");
                dest = new BufferedOutputStream(fos, BUFFER);
                while ((count = is.read(data, 0, BUFFER))
                        != -1) {
                    dest.write(data, 0, count);
                }
                dest.flush();
                dest.close();
                is.close();
                eliminarArchivoTmp(rutaZip);
                
            }
        } catch (Exception e) {
            e.printStackTrace();
            
        }

        return nArchivoExtraido;
    }

    void eliminarArchivoTmp(String urlT) {
        File fichero = new File(urlT);
        try {
            if (fichero.exists()) {
                fichero.delete();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}
