// service/VendedorService.java
package service;

import dao.VendedorDAO;
import model.Vendedor;

public class VendedorService {

    private final VendedorDAO vendedorDAO = new VendedorDAO();
    private final AuthService authService = new AuthService();

    public boolean cadastrar(Vendedor vendedor) {
        if (authService.emailJaCadastrado(vendedor.getEmail())) {
            return false;
        }
        if (authService.cpfJaCadastrado(vendedor.getCpf())) {
            return false;
        }
        return vendedorDAO.inserir(vendedor);
    }

    public void atualizar(Vendedor vendedor) {
        vendedorDAO.atualizar(vendedor);
    }
}