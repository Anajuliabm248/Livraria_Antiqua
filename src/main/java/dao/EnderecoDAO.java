// dao/EnderecoDAO.java
package dao;

import model.Endereco;

import java.sql.*;

public class EnderecoDAO {

    private Endereco map(ResultSet rs) throws SQLException {
        Endereco e = new Endereco();
        e.setId(rs.getInt("id"));
        e.setClienteId(rs.getInt("cliente_id"));
        e.setLogradouro(rs.getString("logradouro"));
        e.setNumero(rs.getInt("numero"));
        e.setComplemento(rs.getString("complemento"));
        e.setBairro(rs.getString("bairro"));
        e.setCidade(rs.getString("cidade"));
        e.setEstado(rs.getString("estado"));
        e.setCep(rs.getString("cep"));
        e.setPais(rs.getString("pais"));
        return e;
    }

    public boolean inserir(Endereco e) {
        String sql = "INSERT INTO endereco (cliente_id, logradouro, numero, complemento, bairro, cidade, estado, cep, pais) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = ConexaoDB.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, e.getClienteId());
            stmt.setString(2, e.getLogradouro());
            stmt.setInt(3, e.getNumero());
            stmt.setString(4, e.getComplemento());
            stmt.setString(5, e.getBairro());
            stmt.setString(6, e.getCidade());
            stmt.setString(7, e.getEstado());
            stmt.setString(8, e.getCep());
            stmt.setString(9, e.getPais());

            return stmt.executeUpdate() > 0;

        } catch (SQLException ex) {
            throw new RuntimeException("Erro ao inserir endereço", ex);
        }
    }

    public Endereco buscarPorClienteId(int clienteId) {
        String sql = "SELECT * FROM endereco WHERE cliente_id = ?";

        try (Connection conn = ConexaoDB.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, clienteId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return map(rs);
            }

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao buscar endereço", e);
        }

        return null;
    }

    public void atualizar(Endereco e) {
        String sql = "UPDATE endereco SET logradouro=?, numero=?, complemento=?, bairro=?, cidade=?, estado=?, cep=?, pais=? "
                + "WHERE cliente_id=?";

        try (Connection conn = ConexaoDB.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, e.getLogradouro());
            stmt.setInt(2, e.getNumero());
            stmt.setString(3, e.getComplemento());
            stmt.setString(4, e.getBairro());
            stmt.setString(5, e.getCidade());
            stmt.setString(6, e.getEstado());
            stmt.setString(7, e.getCep());
            stmt.setString(8, e.getPais());
            stmt.setInt(9, e.getClienteId());
            stmt.executeUpdate();

        } catch (SQLException ex) {
            throw new RuntimeException("Erro ao atualizar endereço", ex);
        }
    }
}