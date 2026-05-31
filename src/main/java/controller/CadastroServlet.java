package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Cliente;
import model.Vendedor;
import service.ClienteService;
import service.VendedorService;

import java.io.IOException;

@WebServlet("/cadastro")
public class CadastroServlet extends HttpServlet {

    private final ClienteService clienteService = new ClienteService();
    private final VendedorService vendedorService = new VendedorService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("WEB-INF/pages/auth/cadastro.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String nome     = req.getParameter("nome");
        String cpf      = req.getParameter("cpf");
        String email    = req.getParameter("email");
        String telefone = req.getParameter("telefone");
        String senha    = req.getParameter("senha");
        String tipo     = req.getParameter("tipo");

        boolean sucesso;

        if ("VENDEDOR".equals(tipo)) {
            Vendedor v = new Vendedor(nome, cpf, telefone, email, senha);
            sucesso = vendedorService.cadastrar(v);
        } else {
            Cliente c = new Cliente();
            c.setNome(nome);
            c.setCpf(cpf);
            c.setEmail(email);
            c.setTelefone(telefone);
            c.setSenha(senha);
            sucesso = clienteService.cadastrar(c);
        }

        if (sucesso) {
            resp.sendRedirect("login?msg=cadastrado");
        } else {
            req.setAttribute("erro", "Email ou CPF já cadastrado.");
            req.getRequestDispatcher("WEB-INF/pages/auth/cadastro.jsp").forward(req, resp);
        }
    }
}
