package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.*;

@WebServlet("/uploads/*")
public class UploadServlet extends HttpServlet {

    private static final int BUFFER_SIZE = 4096;

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String arquivo = request.getPathInfo();

        if (arquivo == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        File file = new File(
                System.getProperty("user.dir")
                        + File.separator
                        + "uploads",
                arquivo);

        if (!file.exists()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        String mime = getServletContext().getMimeType(file.getName());

        if (mime == null) {
            mime = "application/octet-stream";
        }

        response.setContentType(mime);
        response.setContentLengthLong(file.length());

        try (
                FileInputStream in = new FileInputStream(file);
                OutputStream out = response.getOutputStream()
        ) {

            byte[] buffer = new byte[BUFFER_SIZE];

            int bytesRead;

            while ((bytesRead = in.read(buffer)) != -1) {
                out.write(buffer, 0, bytesRead);
            }
        }
    }
}