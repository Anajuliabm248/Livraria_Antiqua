package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Carrinho;
import model.ItemCarrinho;
import model.Livro;
import model.Usuario;
import service.CarrinhoService;
import service.LivroService;

import java.io.IOException;
import java.util.List;

@WebServlet("/carrinho")
public class CarrinhoServlet extends HttpServlet {

    private final CarrinhoService carrinhoService = new CarrinhoService();
    private final LivroService livroService = new LivroService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            resp.sendRedirect("login");
            return;
        }

        Usuario usuario = (Usuario) session.getAttribute("usuario");
        List<ItemCarrinho> itens = carrinhoService.listarItens(usuario.getId());
        Carrinho carrinho = carrinhoService.buscarCarrinho(usuario.getId());

        List<Livro> livros = itens.stream()
                .map(i -> livroService.buscarPorId(i.getLivroId()))
                .toList();

        req.setAttribute("itens", itens);
        req.setAttribute("carrinho", carrinho);
        req.setAttribute("livros", livros);

        req.getRequestDispatcher("WEB-INF/pages/carrinho/carrinho.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            resp.sendRedirect("login");
            return;
        }

        Usuario usuario = (Usuario) session.getAttribute("usuario");
        String acao = req.getParameter("acao");

        if ("adicionar".equals(acao)) {
            int livroId = Integer.parseInt(req.getParameter("livroId"));
            int quantidade = Integer.parseInt(req.getParameter("quantidade"));

            boolean ok = carrinhoService.adicionarItem(usuario.getId(), livroId, quantidade);

            if (!ok) {
                req.setAttribute("erro", "Estoque insuficiente.");
                req.setAttribute("livro", livroService.buscarPorId(livroId));
                req.getRequestDispatcher("WEB-INF/pages/livro/detalhe.jsp").forward(req, resp);
                return;
            }
            resp.sendRedirect("carrinho");
            return;
        }

        if ("remover".equals(acao)) {
            int itemId = Integer.parseInt(req.getParameter("itemId"));
            carrinhoService.removerItem(itemId, usuario.getId());
            resp.sendRedirect("carrinho");
        }
    }
}
