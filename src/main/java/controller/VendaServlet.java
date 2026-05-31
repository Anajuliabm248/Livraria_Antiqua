package controller;

import dao.EnderecoDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.*;
import service.CarrinhoService;
import service.LivroService;
import service.VendaService;

import java.io.IOException;
import java.util.List;

@WebServlet("/venda")
public class VendaServlet extends HttpServlet {

    private final VendaService vendaService = new VendaService();
    private final CarrinhoService carrinhoService = new CarrinhoService();
    private final LivroService livroService = new LivroService();
    private final EnderecoDAO enderecoDAO = new EnderecoDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            resp.sendRedirect("login");
            return;
        }

        // FIX: usa Usuario (tipo correto armazenado na sessão pelo LoginServlet)
        // O cast para Cliente causava ClassCastException pois LoginServlet salva Usuario
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        String acao = req.getParameter("acao");

        if ("checkout".equals(acao)) {
            List<ItemCarrinho> itens = carrinhoService.listarItens(usuario.getId());
            Carrinho carrinho = carrinhoService.buscarCarrinho(usuario.getId());

            if (itens.isEmpty()) {
                resp.sendRedirect("carrinho");
                return;
            }

            // FIX: busca o endereço diretamente pelo DAO em vez de tentar obtê-lo
            // do objeto Usuario da sessão (que não é uma instância de Cliente e
            // não carrega o endereço)
            Endereco endereco = enderecoDAO.buscarPorClienteId(usuario.getId());
            if (endereco == null) {
                // Sem endereço cadastrado — redireciona para o formulário de endereço
                resp.sendRedirect("cliente?acao=endereco&msg=necessario");
                return;
            }

            req.setAttribute("endereco", endereco);
            req.setAttribute("itens", itens);
            req.setAttribute("carrinho", carrinho);
            req.setAttribute("livros", itens.stream()
                    .map(i -> livroService.buscarPorId(i.getLivroId()))
                    .toList());
            req.getRequestDispatcher("WEB-INF/pages/venda/checkout.jsp").forward(req, resp);
            return;
        }

        if ("confirmacao".equals(acao)) {
            int vendaId;
            try {
                vendaId = Integer.parseInt(req.getParameter("id"));
            } catch (NumberFormatException e) {
                resp.sendRedirect("livro");
                return;
            }
            Venda venda = vendaService.buscarPorId(vendaId);

            // FIX (IDOR): garante que a venda pertence ao usuário logado
            if (venda == null || venda.getClienteId() != usuario.getId()) {
                resp.sendRedirect("livro");
                return;
            }

            List<ItemVenda> itens = vendaService.listarItensDaVenda(vendaId);

            req.setAttribute("venda", venda);
            req.setAttribute("itens", itens);
            req.setAttribute("livros", itens.stream()
                    .map(i -> livroService.buscarPorId(i.getLivroId()))
                    .toList());
            req.getRequestDispatcher("WEB-INF/pages/venda/confirmacao.jsp").forward(req, resp);
            return;
        }

        if ("cancelar".equals(acao)) {
            int vendaId;
            try {
                vendaId = Integer.parseInt(req.getParameter("id"));
            } catch (NumberFormatException e) {
                resp.sendRedirect("venda?acao=historico");
                return;
            }

            // FIX (IDOR): só cancela se a venda for do usuário logado
            Venda venda = vendaService.buscarPorId(vendaId);
            if (venda != null && venda.getClienteId() == usuario.getId()) {
                vendaService.cancelarVenda(vendaId);
            }
            resp.sendRedirect("venda?acao=historico&msg=cancelado");
            return;
        }

        if ("historico".equals(acao)) {
            req.setAttribute("vendas", vendaService.listarPorCliente(usuario.getId()));
            req.getRequestDispatcher("WEB-INF/pages/cliente/historico.jsp").forward(req, resp);
            return;
        }

        resp.sendRedirect("livro");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            resp.sendRedirect("login");
            return;
        }

        Usuario usuario = (Usuario) session.getAttribute("usuario");
        String formaPagamento = req.getParameter("formaPagamento");

        Venda venda = vendaService.finalizarCompra(usuario.getId(), formaPagamento);

        if (venda == null) {
            resp.sendRedirect("carrinho?msg=erro");
            return;
        }

        resp.sendRedirect("venda?acao=confirmacao&id=" + venda.getId());
    }
}
