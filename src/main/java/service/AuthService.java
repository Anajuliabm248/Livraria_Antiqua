package service;

import dao.UsuarioDAO;
import model.Usuario;

public class AuthService {

    private final UsuarioDAO usuarioDAO = new UsuarioDAO();

    public Usuario login(String email, String senha) {
        Usuario usuario = usuarioDAO.buscarPorEmail(email);

        if (usuario == null || !usuario.isAtivo()) {
            return null;
        }

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