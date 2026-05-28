// service/ClienteService.java
package service;

import dao.CarrinhoDAO;
import dao.ClienteDAO;
import model.Carrinho;
import model.Cliente;

public class ClienteService {

    private final ClienteDAO clienteDAO = new ClienteDAO();
    private final CarrinhoDAO carrinhoDAO = new CarrinhoDAO();
    private final AuthService authService = new AuthService();

    public boolean cadastrar(Cliente cliente) {
        if (authService.emailJaCadastrado(cliente.getEmail())) {
            return false;
        }
        if (authService.cpfJaCadastrado(cliente.getCpf())) {
            return false;
        }

        boolean inserido = clienteDAO.inserir(cliente);

        if (inserido) {
            // Cria o carrinho vazio junto com o cliente
            Carrinho carrinho = new Carrinho();
            carrinho.setClienteId(cliente.getId());
            carrinhoDAO.inserir(carrinho);
        }

        return inserido;
    }

    public Cliente buscarPorId(int id) {
        return clienteDAO.buscarPorId(id);
    }

    public void atualizar(Cliente cliente) {
        clienteDAO.atualizar(cliente);
    }
}