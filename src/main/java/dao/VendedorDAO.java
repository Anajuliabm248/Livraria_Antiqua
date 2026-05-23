package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import model.Vendedor;

public class VendedorDAO {

    private Vendedor map(ResultSet rs) throws SQLException {
        Vendedor v = new Vendedor();
        v.setId(rs.getInt("id"));
        v.setNome(rs.getString("nome"));
        v.setCpf(rs.getString("cpf"));
        v.setTelefone(rs.getString("telefone"));
        v.setEmail(rs.getString("email"));
        v.setSenha(rs.getString("senha"));
        v.setDtCadastro(rs.getDate("dt_cadastro"));
        v.setAtivo(rs.getBoolean("ativo"));
        return v;
    }

    public boolean inserir(Vendedor v) {
        String sqlUsuario = "INSERT INTO usuario (nome, cpf, telefone, email, senha, dt_cadastro, ativo, tipo) "
                + "VALUES (?, ?, ?, ?, ?, CURRENT_DATE, true, 'VENDEDOR')";
        String sqlVendedor = "INSERT INTO vendedor (id) VALUES (?)";

        try (Connection conn = ConexaoDB.getConexao()) {

            conn.setAutoCommit(false);

            try (PreparedStatement stmtU = conn.prepareStatement(sqlUsuario, Statement.RETURN_GENERATED_KEYS)) {

                stmtU.setString(1, v.getNome());
                stmtU.setString(2, v.getCpf());
                stmtU.setString(3, v.getTelefone());
                stmtU.setString(4, v.getEmail());
                stmtU.setString(5, v.getSenha());
                stmtU.executeUpdate();

                ResultSet keys = stmtU.getGeneratedKeys();
                if (keys.next()) {
                    int idGerado = keys.getInt(1);
                    v.setId(idGerado);

                    try (PreparedStatement stmtV = conn.prepareStatement(sqlVendedor)) {
                        stmtV.setInt(1, idGerado);
                        stmtV.executeUpdate();
                    }
                }

                conn.commit();
                return true;

            } catch (SQLException e) {
                conn.rollback();
                throw new RuntimeException("Erro ao inserir vendedor", e);
            }

        } catch (SQLException e) {
            throw new RuntimeException("Erro de conexão ao inserir vendedor", e);
        }
    }

    public Vendedor buscarPorEmail(String email) {
        String sql = "SELECT u.* FROM usuario u "
                + "INNER JOIN vendedor v ON v.id = u.id "
                + "WHERE u.email = ?";

        try (Connection conn = ConexaoDB.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return map(rs);
            }

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao buscar vendedor por email", e);
        }

        return null;
    }

    public List<Vendedor> listar() {
        String sql = "SELECT u.* FROM usuario u "
                + "INNER JOIN vendedor v ON v.id = u.id "
                + "WHERE u.ativo = true";
        List<Vendedor> lista = new ArrayList<>();

        try (Connection conn = ConexaoDB.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                lista.add(map(rs));
            }

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao listar vendedores", e);
        }

        return lista;
    }

    public void atualizar(Vendedor v) {
        String sql = "UPDATE usuario SET nome=?, cpf=?, telefone=?, email=? WHERE id=?";

        try (Connection conn = ConexaoDB.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, v.getNome());
            stmt.setString(2, v.getCpf());
            stmt.setString(3, v.getTelefone());
            stmt.setString(4, v.getEmail());
            stmt.setInt(5, v.getId());
            stmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao atualizar vendedor", e);
        }
    }
}
