package controller;

import dao.EnderecoDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Cliente;
import model.Endereco;
import model.Usuario;
import service.ClienteService;

import java.io.IOException;

@WebServlet("/cliente")
public class ClienteServlet extends HttpServlet {

    private final ClienteService clienteService = new ClienteService();
    private final EnderecoDAO enderecoDAO = new EnderecoDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            resp.sendRedirect("login");
            return;
        }

        Usuario usuario = (Usuario) session.getAttribute("usuario");
        String acao = req.getParameter("acao");

        if ("endereco".equals(acao)) {
            req.setAttribute("endereco", enderecoDAO.buscarPorClienteId(usuario.getId()));
            req.getRequestDispatcher("WEB-INF/pages/cliente/endereco.jsp").forward(req, resp);
            return;
        }

        if ("historico".equals(acao)) {
            resp.sendRedirect("venda?acao=historico");
            return;
        }

        // Default: perfil
        req.setAttribute("cliente", clienteService.buscarPorId(usuario.getId()));
        req.getRequestDispatcher("WEB-INF/pages/cliente/perfil.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            resp.sendRedirect("login");
            return;
        }

        Usuario usuario = (Usuario) session.getAttribute("usuario");
        String acao = req.getParameter("acao");

        if ("endereco".equals(acao)) {
            String logradouro  = req.getParameter("logradouro");
            String complemento = req.getParameter("complemento");
            String bairro      = req.getParameter("bairro");
            String cidade      = req.getParameter("cidade");
            String estado      = req.getParameter("estado");
            String cep         = req.getParameter("cep");

            // FIX: parseInt sem try-catch gerava HTTP 500 com entrada inválida
            int numero;
            try {
                numero = Integer.parseInt(req.getParameter("numero"));
            } catch (NumberFormatException e) {
                req.setAttribute("endereco", enderecoDAO.buscarPorClienteId(usuario.getId()));
                req.setAttribute("erro", "Número inválido.");
                req.getRequestDispatcher("WEB-INF/pages/cliente/endereco.jsp").forward(req, resp);
                return;
            }

            Endereco existente = enderecoDAO.buscarPorClienteId(usuario.getId());

            if (existente == null) {
                Endereco novo = new Endereco();
                novo.setClienteId(usuario.getId());
                novo.setLogradouro(logradouro);
                novo.setNumero(numero);
                novo.setComplemento(complemento);
                novo.setBairro(bairro);
                novo.setCidade(cidade);
                novo.setEstado(estado);
                novo.setCep(cep);
                novo.setPais("Brasil");
                enderecoDAO.inserir(novo);
            } else {
                existente.setLogradouro(logradouro);
                existente.setNumero(numero);
                existente.setComplemento(complemento);
                existente.setBairro(bairro);
                existente.setCidade(cidade);
                existente.setEstado(estado);
                existente.setCep(cep);
                enderecoDAO.atualizar(existente);
            }
            resp.sendRedirect("cliente?acao=endereco&msg=salvo");
            return;
        }

        String nome     = req.getParameter("nome");
        String telefone = req.getParameter("telefone");
        String email    = req.getParameter("email");

        Cliente cliente = clienteService.buscarPorId(usuario.getId());
        cliente.setNome(nome);
        cliente.setTelefone(telefone);
        cliente.setEmail(email);
        clienteService.atualizar(cliente);

        usuario.setNome(nome);
        session.setAttribute("usuario", usuario);

        resp.sendRedirect("cliente?msg=salvo");
    }
}
