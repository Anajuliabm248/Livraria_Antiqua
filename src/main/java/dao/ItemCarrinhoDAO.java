// dao/ItemCarrinhoDAO.java
package dao;

import model.ItemCarrinho;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ItemCarrinhoDAO {

    private ItemCarrinho map(ResultSet rs) throws SQLException {
        ItemCarrinho item = new ItemCarrinho();
        item.setId(rs.getInt("id"));
        item.setCarrinhoId(rs.getInt("carrinho_id"));
        item.setLivroId(rs.getInt("livro_id"));
        item.setQuantidade(rs.getInt("quantidade"));
        item.setSubtotal(rs.getDouble("subtotal"));
        return item;
    }

    public boolean inserir(ItemCarrinho item) {
        String sql = "INSERT INTO item_carrinho (carrinho_id, livro_id, quantidade, subtotal) VALUES (?, ?, ?, ?)";

        try (Connection conn = ConexaoDB.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, item.getCarrinhoId());
            stmt.setInt(2, item.getLivroId());
            stmt.setInt(3, item.getQuantidade());
            stmt.setDouble(4, item.getSubtotal());

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao inserir item no carrinho", e);
        }
    }

    public List<ItemCarrinho> listarPorCarrinho(int carrinhoId) {
        String sql = "SELECT * FROM item_carrinho WHERE carrinho_id = ?";
        List<ItemCarrinho> lista = new ArrayList<>();

        try (Connection conn = ConexaoDB.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, carrinhoId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                lista.add(map(rs));
            }

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao listar itens do carrinho", e);
        }

        return lista;
    }

    public ItemCarrinho buscarPorCarrinhoELivro(int carrinhoId, int livroId) {
        String sql = "SELECT * FROM item_carrinho WHERE carrinho_id = ? AND livro_id = ?";

        try (Connection conn = ConexaoDB.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, carrinhoId);
            stmt.setInt(2, livroId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return map(rs);
            }

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao buscar item no carrinho", e);
        }

        return null;
    }

    public void atualizar(ItemCarrinho item) {
        String sql = "UPDATE item_carrinho SET quantidade=?, subtotal=? WHERE id=?";

        try (Connection conn = ConexaoDB.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, item.getQuantidade());
            stmt.setDouble(2, item.getSubtotal());
            stmt.setInt(3, item.getId());
            stmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao atualizar item do carrinho", e);
        }
    }

    public void excluir(int id) {
        String sql = "DELETE FROM item_carrinho WHERE id = ?";

        try (Connection conn = ConexaoDB.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            stmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao remover item do carrinho", e);
        }
    }

    public void excluirPorCarrinho(int carrinhoId) {
        String sql = "DELETE FROM item_carrinho WHERE carrinho_id = ?";

        try (Connection conn = ConexaoDB.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, carrinhoId);
            stmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao limpar carrinho", e);
        }
    }
}