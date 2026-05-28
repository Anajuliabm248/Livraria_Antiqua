// dao/PagamentoDAO.java
package dao;

import model.Pagamento;

import java.sql.*;

public class PagamentoDAO {

    private Pagamento map(ResultSet rs) throws SQLException {
        Pagamento p = new Pagamento();
        p.setId(rs.getInt("id"));
        p.setVendaId(rs.getInt("venda_id"));
        p.setFormaPagamento(rs.getString("forma_pagamento"));
        p.setStatus(rs.getString("status"));
        p.setDtPagamento(rs.getDate("dt_pagamento"));
        p.setValor(rs.getDouble("valor"));
        return p;
    }

    public boolean inserir(Pagamento p) {
        String sql = "INSERT INTO pagamento (venda_id, forma_pagamento, status, valor) "
                + "VALUES (?, ?, 'PENDENTE', ?)";

        try (Connection conn = ConexaoDB.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, p.getVendaId());
            stmt.setString(2, p.getFormaPagamento());
            stmt.setDouble(3, p.getValor());

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao inserir pagamento", e);
        }
    }

    public Pagamento buscarPorVenda(int vendaId) {
        String sql = "SELECT * FROM pagamento WHERE venda_id = ?";

        try (Connection conn = ConexaoDB.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, vendaId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return map(rs);
            }

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao buscar pagamento", e);
        }

        return null;
    }

    public void atualizarStatus(int vendaId, String status) {
        String sql = "UPDATE pagamento SET status=?, dt_pagamento=CURRENT_DATE WHERE venda_id=?";

        try (Connection conn = ConexaoDB.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);
            stmt.setInt(2, vendaId);
            stmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao atualizar status do pagamento", e);
        }
    }
}