// service/AuthService.java
package service;

import dao.ClienteDAO;
import dao.UsuarioDAO;
import dao.VendedorDAO;
import model.Usuario;

public class AuthService {

    private final UsuarioDAO usuarioDAO = new UsuarioDAO();
    private final ClienteDAO clienteDAO = new ClienteDAO();
    private final VendedorDAO vendedorDAO = new VendedorDAO();

    // Retorna o Usuario se credenciais válidas, null se inválidas
    public Usuario login(String email, String senha) {
        Usuario usuario = usuarioDAO.buscarPorEmail(email);

        if (usuario == null || !usuario.isAtivo()) {
            return null;
        }

        // Comparação simples — em prod usaria BCrypt
        if (!usuario.getSenha().equals(senha)) {
            return null;
        }

        return usuario;
    }

    public boolean emailJaCadastrado(String email) {
        return usuarioDAO.existeEmail(email);
    }

    public boolean cpfJaCadastrado(String cpf) {
        return usuarioDAO.existeCpf(cpf);
    }
}