package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.*;
import java.nio.file.*;

@WebServlet("/uploads/*")
public class UploadServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Mesmo caminho base usado no LivroServlet
        String baseDir = System.getProperty("uploads.dir",
                System.getProperty("user.home") + "/livraria-uploads");

        // Extrai o nome do arquivo da URL: /uploads/123_capa.png → 123_capa.png
        String pathInfo = req.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        // Segurança: impede path traversal tipo /uploads/../../../etc/passwd
        String nomeArquivo = new File(pathInfo).getName();
        Path arquivo = Paths.get(baseDir, nomeArquivo);

        if (!Files.exists(arquivo)) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        // Define o Content-Type baseado na extensão
        String contentType = getServletContext().getMimeType(nomeArquivo);
        resp.setContentType(contentType != null ? contentType : "application/octet-stream");
        resp.setContentLengthLong(Files.size(arquivo));

        Files.copy(arquivo, resp.getOutputStream());
    }
}