package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Usuario;
import service.AuthService;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private final AuthService service = new AuthService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Se já está logado, redireciona
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("usuario") != null) {
            Usuario u = (Usuario) session.getAttribute("usuario");
            if ("VENDEDOR".equals(u.getTipo())) {
                resp.sendRedirect("vendedor?acao=dashboard");
            } else {
                resp.sendRedirect("livro");
            }
            return;
        }
        req.getRequestDispatcher("WEB-INF/pages/auth/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String senha = req.getParameter("senha");

        Usuario usuario = service.login(email, senha);

        if (usuario == null) {
            req.setAttribute("erro", "Email ou senha inválidos.");
            req.getRequestDispatcher("WEB-INF/pages/auth/login.jsp").forward(req, resp);
            return;
        }

        // FIX (session fixation): invalida a sessão antiga antes de criar uma nova.
        // Sem isso, um atacante poderia fixar o ID de sessão antes do login e
        // assumir a sessão autenticada da vítima.
        HttpSession oldSession = req.getSession(false);
        if (oldSession != null) {
            oldSession.invalidate();
        }
        HttpSession session = req.getSession(true);
        session.setAttribute("usuario", usuario);

        if ("VENDEDOR".equals(usuario.getTipo())) {
            resp.sendRedirect("vendedor?acao=dashboard");
        } else {
            resp.sendRedirect("livro");
        }
    }
}
