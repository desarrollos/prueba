/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package clases;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.common.ByteMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel;
import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.OutputStream;
import java.util.Hashtable;
import javax.imageio.ImageIO;

public class ed_QR {


/**
 *
 * @param archivo
 * @param content
 * @param qrCodeSize
 * @param imageFormat
 */
    public static void createQrCode(String archivo, String content, int qrCodeSize, String imageFormat) {
        try {
            // Create the ByteMatrix for the QR-Code that encodes the given String.

            Hashtable<EncodeHintType, ErrorCorrectionLevel> hintMap = new Hashtable<EncodeHintType, ErrorCorrectionLevel>();
            hintMap.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.L);

            QRCodeWriter qrCodeWriter = new QRCodeWriter();
            ByteMatrix byteMatrix = qrCodeWriter.encode(content, BarcodeFormat.QR_CODE, qrCodeSize, qrCodeSize, hintMap);

            // Make the BufferedImage that are to hold the QRCode

            int matrixWidth = byteMatrix.getWidth();

            BufferedImage image = new BufferedImage(matrixWidth, matrixWidth, BufferedImage.TYPE_INT_RGB);
            image.createGraphics();

            Graphics2D graphics = (Graphics2D) image.getGraphics();
            graphics.setColor(Color.WHITE);
            graphics.fillRect(0, 0, matrixWidth, matrixWidth);

            // Paint and save the image using the ByteMatrix

            graphics.setColor(Color.BLACK);

            for (int i = 0; i < matrixWidth; i++) {
                for (int j = 0; j < matrixWidth; j++) {
                    if (byteMatrix.get(i, j) == 0) {
                        graphics.fillRect(i, j, 1, 1);
                    }
                }
            }
            java.io.File codigoQR = new java.io.File(archivo);
            ImageIO.write(image, imageFormat, codigoQR);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

}
