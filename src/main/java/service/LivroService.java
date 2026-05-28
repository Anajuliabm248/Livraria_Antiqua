// service/LivroService.java
package service;

import dao.LivroDAO;
import model.Livro;

import java.util.List;

public class LivroService {

    private final LivroDAO livroDAO = new LivroDAO();

    public List<Livro> listar() {
        return livroDAO.listar();
    }

    public Livro buscarPorId(int id) {
        return livroDAO.buscarPorId(id);
    }

    public List<Livro> buscarPorNome(String nome) {
        return livroDAO.buscarPorNome(nome);
    }

    public List<Livro> buscarPorCategoria(int categoriaId) {
        return livroDAO.buscarPorCategoria(categoriaId);
    }

    public boolean inserir(Livro livro) {
        return livroDAO.inserir(livro);
    }

    public void atualizar(Livro livro) {
        livroDAO.atualizar(livro);
    }

    public void excluir(int id) {
        livroDAO.excluir(id);
    }

    public void atualizarEstoque(int livroId, int quantidade) {
        livroDAO.atualizarEstoque(livroId, quantidade);
    }
}