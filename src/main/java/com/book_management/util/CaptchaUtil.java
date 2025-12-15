package com.book_management.util;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.Random;

public class CaptchaUtil {
    public static BufferedImage generateCaptchaImage(String captcha,int width, int height) {
        BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        Graphics2D g2d = image.createGraphics();

        g2d.setColor(Color.WHITE);
        g2d.fillRect(0, 0, width, height);
        g2d.setFont(new Font("Arial", Font.BOLD, 28));

        Random random = new Random();
        for (int i = 0; i < 4; i++) {
            g2d.setColor(new Color(random.nextInt(256), random.nextInt(256), random.nextInt(256)));
            g2d.drawLine(random.nextInt(width), random.nextInt(height), random.nextInt(width), random.nextInt(height));
        }

        for (int i = 0; i < captcha.length(); i++) {
            g2d.setColor(new Color(random.nextInt(256), random.nextInt(256), random.nextInt(256)));
            g2d.drawString(String.valueOf(captcha.charAt(i)), 20+i*25,30);
        }

        g2d.dispose();
        return image;
    }
    public static byte[] imageToByteArray(BufferedImage image) throws IOException {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        ImageIO.write(image,"png",baos);
        return baos.toByteArray();
    }
}
