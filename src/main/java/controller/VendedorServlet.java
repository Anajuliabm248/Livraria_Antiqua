package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Usuario;
import model.Venda;
import service.LivroService;
import service.VendaService;

import java.io.IOException;
import java.util.List;

@WebServlet("/vendedor")
public class VendedorServlet extends HttpServlet {

    private final LivroService livroService = new LivroService();
    private final VendaService vendaService = new VendaService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            resp.sendRedirect("login");
            return;
        }

        Usuario usuario = (Usuario) session.getAttribute("usuario");
        if (!"VENDEDOR".equals(usuario.getTipo())) {
            resp.sendRedirect("livro");
            return;
        }

        int vendedorId = usuario.getId();
        String acao = req.getParameter("acao");

        if ("estoque".equals(acao)) {
            // Só os livros deste vendedor
            req.setAttribute("livros", livroService.listarPorVendedor(vendedorId));
            req.setAttribute("msg", req.getParameter("msg"));
            req.getRequestDispatcher("WEB-INF/pages/vendedor/estoque.jsp").forward(req, resp);
            return;
        }

        if ("relatorio".equals(acao)) {
            // Só as vendas que contêm livros deste vendedor
            List<Venda> vendas = vendaService.listarPorVendedor(vendedorId);
            double totalGeral = vendas.stream().mapToDouble(Venda::getValorTotal).sum();
            req.setAttribute("vendas", vendas);
            req.setAttribute("totalGeral", totalGeral);
            req.getRequestDispatcher("WEB-INF/pages/vendedor/relatorio.jsp").forward(req, resp);
            return;
        }

        // Dashboard: contagens filtradas por este vendedor
        req.setAttribute("totalVendas", vendaService.listarPorVendedor(vendedorId).size());
        req.setAttribute("totalLivros", livroService.listarPorVendedor(vendedorId).size());
        req.getRequestDispatcher("WEB-INF/pages/vendedor/dashboard.jsp").forward(req, resp);
    }
}
