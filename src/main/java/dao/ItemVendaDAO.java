package dao;

import model.ItemVenda;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ItemVendaDAO {

    private ItemVenda map(ResultSet rs) throws SQLException {
        ItemVenda item = new ItemVenda();
        item.setId(rs.getInt("id"));
        item.setVendaId(rs.getInt("venda_id"));
        item.setLivroId(rs.getInt("livro_id"));
        item.setQuantidade(rs.getInt("quantidade"));
        item.setPrecoUni(rs.getDouble("preco_uni"));
        item.setSubtotal(rs.getDouble("subtotal"));
        return item;
    }

    public boolean inserir(ItemVenda item) {
        String sql = "INSERT INTO item_venda (venda_id, livro_id, quantidade, preco_uni, subtotal) "
                + "VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = ConexaoDB.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, item.getVendaId());
            stmt.setInt(2, item.getLivroId());
            stmt.setInt(3, item.getQuantidade());
            stmt.setDouble(4, item.getPrecoUni());
            stmt.setDouble(5, item.getSubtotal());

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao inserir item da venda", e);
        }
    }

    public List<ItemVenda> listarPorVenda(int vendaId) {
        String sql = "SELECT * FROM item_venda WHERE venda_id = ?";
        List<ItemVenda> lista = new ArrayList<>();

        try (Connection conn = ConexaoDB.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, vendaId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                lista.add(map(rs));
            }

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao listar itens da venda", e);
        }

        return lista;
    }
}
