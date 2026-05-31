package dao;

import model.Livro;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class LivroDAO {

    private Livro map(ResultSet rs) throws SQLException {
        Livro l = new Livro();
        l.setId(rs.getInt("id"));
        l.setCategoriaId(rs.getInt("categoria_id"));
        l.setVendedorId(rs.getInt("vendedor_id")); // ← novo campo
        l.setNome(rs.getString("nome"));
        l.setAutor(rs.getString("autor"));
        l.setIsbn(rs.getString("isbn"));
        l.setDescricao(rs.getString("descricao"));
        l.setNumPagina(rs.getInt("num_pagina"));
        l.setAnoLancamento(rs.getInt("ano_lancamento"));
        l.setPreco(rs.getDouble("preco"));
        l.setQuantidade(rs.getInt("quantidade"));
        l.setImgCapa(rs.getString("img_capa"));
        return l;
    }

    // Catálogo público: todos os livros (clientes podem ver tudo)
    public List<Livro> listar() {
        String sql = "SELECT * FROM livro ORDER BY nome";
        List<Livro> lista = new ArrayList<>();

        try (Connection conn = ConexaoDB.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) lista.add(map(rs));

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao listar livros", e);
        }
        return lista;
    }

    // Estoque do vendedor: só os livros dele
    public List<Livro> listarPorVendedor(int vendedorId) {
        String sql = "SELECT * FROM livro WHERE vendedor_id = ? ORDER BY nome";
        List<Livro> lista = new ArrayList<>();

        try (Connection conn = ConexaoDB.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, vendedorId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) lista.add(map(rs));

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao listar livros do vendedor", e);
        }
        return lista;
    }

    public boolean inserir(Livro l) {
        String sql = "INSERT INTO livro "
                + "(categoria_id, vendedor_id, nome, autor, isbn, descricao, "
                + "num_pagina, ano_lancamento, preco, quantidade, img_capa) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = ConexaoDB.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, l.getCategoriaId());
            stmt.setInt(2, l.getVendedorId()); // ← salva o dono
            stmt.setString(3, l.getNome());
            stmt.setString(4, l.getAutor());
            stmt.setString(5, l.getIsbn());
            stmt.setString(6, l.getDescricao());
            stmt.setInt(7, l.getNumPagina());
            stmt.setInt(8, l.getAnoLancamento());
            stmt.setDouble(9, l.getPreco());
            stmt.setInt(10, l.getQuantidade());
            stmt.setString(11, l.getImgCapa());

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao inserir livro", e);
        }
    }

    public Livro buscarPorId(int id) {
        String sql = "SELECT * FROM livro WHERE id = ?";

        try (Connection conn = ConexaoDB.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) return map(rs);

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao buscar livro", e);
        }
        return null;
    }

    public List<Livro> buscarPorNome(String nome) {
        String sql = "SELECT * FROM livro WHERE LOWER(nome) LIKE LOWER(?)";
        List<Livro> lista = new ArrayList<>();

        try (Connection conn = ConexaoDB.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, "%" + nome + "%");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) lista.add(map(rs));

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao buscar livros por nome", e);
        }
        return lista;
    }

    public List<Livro> buscarPorCategoria(int categoriaId) {
        String sql = "SELECT * FROM livro WHERE categoria_id = ? ORDER BY nome";
        List<Livro> lista = new ArrayList<>();

        try (Connection conn = ConexaoDB.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, categoriaId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) lista.add(map(rs));

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao buscar livros por categoria", e);
        }
        return lista;
    }

    public void atualizar(Livro l) {
        // vendedor_id não é alterado no update (dono não muda)
        String sql = "UPDATE livro SET categoria_id=?, nome=?, autor=?, isbn=?, descricao=?, "
                + "num_pagina=?, ano_lancamento=?, preco=?, quantidade=?, img_capa=? "
                + "WHERE id=? AND vendedor_id=?"; // ← AND vendedor_id garante que só o dono atualiza

        try (Connection conn = ConexaoDB.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, l.getCategoriaId());
            stmt.setString(2, l.getNome());
            stmt.setString(3, l.getAutor());
            stmt.setString(4, l.getIsbn());
            stmt.setString(5, l.getDescricao());
            stmt.setInt(6, l.getNumPagina());
            stmt.setInt(7, l.getAnoLancamento());
            stmt.setDouble(8, l.getPreco());
            stmt.setInt(9, l.getQuantidade());
            stmt.setString(10, l.getImgCapa());
            stmt.setInt(11, l.getId());
            stmt.setInt(12, l.getVendedorId()); // ← confirma propriedade no WHERE
            stmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao atualizar livro", e);
        }
    }

    public void atualizarEstoque(int livroId, int quantidade) {
        String sql = "UPDATE livro SET quantidade = ? WHERE id = ?";

        try (Connection conn = ConexaoDB.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, quantidade);
            stmt.setInt(2, livroId);
            stmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao atualizar estoque", e);
        }
    }

    public boolean excluir(int livroId, int vendedorId) {
        // WHERE com vendedor_id: vendedor só exclui os próprios livros
        String sql = "DELETE FROM livro WHERE id = ? AND vendedor_id = ?";

        try (Connection conn = ConexaoDB.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, livroId);
            stmt.setInt(2, vendedorId);
            return stmt.executeUpdate() > 0; // false se o livro não for dele

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao excluir livro", e);
        }
    }
}
