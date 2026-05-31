package dao;

import model.Venda;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class VendaDAO {

    private Venda map(ResultSet rs) throws SQLException {
        Venda v = new Venda();
        v.setId(rs.getInt("id"));
        v.setClienteId(rs.getInt("cliente_id"));
        v.setDtVenda(rs.getDate("dt_venda"));
        v.setValorTotal(rs.getDouble("valor_total"));
        v.setStatus(rs.getString("status"));
        return v;
    }

    public int inserir(Venda v) {
        String sql = "INSERT INTO venda (cliente_id, dt_venda, valor_total, status) "
                + "VALUES (?, CURRENT_DATE, ?, 'PENDENTE')";

        try (Connection conn = ConexaoDB.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setInt(1, v.getClienteId());
            stmt.setDouble(2, v.getValorTotal());
            stmt.executeUpdate();

            ResultSet keys = stmt.getGeneratedKeys();
            if (keys.next()) return keys.getInt(1);

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao inserir venda", e);
        }
        return -1;
    }

    public Venda buscarPorId(int id) {
        String sql = "SELECT * FROM venda WHERE id = ?";

        try (Connection conn = ConexaoDB.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) return map(rs);

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao buscar venda", e);
        }
        return null;
    }

    public List<Venda> listarPorCliente(int clienteId) {
        String sql = "SELECT * FROM venda WHERE cliente_id = ? ORDER BY dt_venda DESC";
        List<Venda> lista = new ArrayList<>();

        try (Connection conn = ConexaoDB.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, clienteId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) lista.add(map(rs));

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao listar vendas do cliente", e);
        }
        return lista;
    }

    /**
     * Retorna as vendas que contêm pelo menos um livro deste vendedor.
     * Usa DISTINCT para não duplicar a venda quando ela tiver vários itens do mesmo vendedor.
     */
    public List<Venda> listarPorVendedor(int vendedorId) {
        String sql = "SELECT DISTINCT v.* FROM venda v "
                + "INNER JOIN item_venda iv ON iv.venda_id = v.id "
                + "INNER JOIN livro l ON l.id = iv.livro_id "
                + "WHERE l.vendedor_id = ? "
                + "ORDER BY v.dt_venda DESC";
        List<Venda> lista = new ArrayList<>();

        try (Connection conn = ConexaoDB.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, vendedorId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) lista.add(map(rs));

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao listar vendas do vendedor", e);
        }
        return lista;
    }

    public List<Venda> listarTodas() {
        String sql = "SELECT * FROM venda ORDER BY dt_venda DESC";
        List<Venda> lista = new ArrayList<>();

        try (Connection conn = ConexaoDB.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) lista.add(map(rs));

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao listar todas as vendas", e);
        }
        return lista;
    }

    public void atualizarStatus(int vendaId, String status) {
        String sql = "UPDATE venda SET status = ? WHERE id = ?";

        try (Connection conn = ConexaoDB.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);
            stmt.setInt(2, vendaId);
            stmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao atualizar status da venda", e);
        }
    }
}
