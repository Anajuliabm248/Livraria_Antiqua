package dao;

import model.Carrinho;
import java.sql.*;


public class CarrinhoDao {

    private Carrinho map(ResultSet rs) throws SQLException {
        Carrinho c = new Carrinho();

        c.setId(rs.getInt("id"));
        c.setClienteId(rs.getInt("cliente_id"));
        c.setValorTotal(rs.getDouble("valor_total"));
        return c;
    }

    public boolean inserir(Carrinho c) {
        String sql = "INSERT INTO carrinho (cliente_id, valor_total) VALUES (?, 0.00)";

        try (Connection conn = ConexaoDB.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, c.getClienteId());
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao criar carrinho", e);
        }
    }

    public Carrinho buscarPorClienteId(int clienteId) {
        String sql = "SELECT * FROM carrinho WHERE cliente_id = ?";

        try (Connection conn = ConexaoDB.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, clienteId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return map(rs);
            }

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao buscar carrinho", e);
        }

        return null;
    }

    public void atualizarTotal(int carrinhoId, double total) {
        String sql = "UPDATE carrinho SET valor_total = ? WHERE id = ?";

        try (Connection conn = ConexaoDB.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setDouble(1, total);
            stmt.setInt(2, carrinhoId);
            stmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao atualizar total do carrinho", e);
        }
    }
}
