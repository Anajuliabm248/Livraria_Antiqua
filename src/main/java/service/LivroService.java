package service;

import dao.LivroDAO;
import model.Livro;

import java.util.List;

public class LivroService {

    private final LivroDAO livroDAO = new LivroDAO();

    // Catálogo público (clientes veem todos)
    public List<Livro> listar() {
        return livroDAO.listar();
    }

    // Estoque privado (vendedor vê só os seus)
    public List<Livro> listarPorVendedor(int vendedorId) {
        return livroDAO.listarPorVendedor(vendedorId);
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

    // Retorna false se o livro não pertencer ao vendedor
    public boolean excluir(int livroId, int vendedorId) {
        return livroDAO.excluir(livroId, vendedorId);
    }

    public void atualizarEstoque(int livroId, int quantidade) {
        livroDAO.atualizarEstoque(livroId, quantidade);
    }
}
