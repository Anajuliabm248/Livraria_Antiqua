package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import model.Cliente;

public class ClienteDAO {
    // JOIN das duas tabelas para montar o objeto completo
    private Cliente map(ResultSet rs) throws SQLException {
        Cliente c = new Cliente();
        c.setId(rs.getInt("id"));
        c.setNome(rs.getString("nome"));
        c.setCpf(rs.getString("cpf"));
        c.setTelefone(rs.getString("telefone"));
        c.setEmail(rs.getString("email"));
        c.setSenha(rs.getString("senha"));
        c.setDtCadastro(rs.getDate("dt_cadastro"));
        c.setAtivo(rs.getBoolean("ativo"));
        return c;
    }

    // Insere em usuario e cliente dentro de uma transação
    public boolean inserir(Cliente c) {
        String sqlUsuario = "INSERT INTO usuario (nome, cpf, telefone, email, senha, dt_cadastro, ativo, tipo) "
                + "VALUES (?, ?, ?, ?, ?, CURRENT_DATE, true, 'CLIENTE')";
        String sqlCliente = "INSERT INTO cliente (id) VALUES (?)";

        try (Connection conn = ConexaoDB.getConexao()) {

            conn.setAutoCommit(false);

            try (PreparedStatement stmtU = conn.prepareStatement(sqlUsuario, Statement.RETURN_GENERATED_KEYS)) {

                stmtU.setString(1, c.getNome());
                stmtU.setString(2, c.getCpf());
                stmtU.setString(3, c.getTelefone());
                stmtU.setString(4, c.getEmail());
                stmtU.setString(5, c.getSenha());
                stmtU.executeUpdate();

                ResultSet keys = stmtU.getGeneratedKeys();
                if (keys.next()) {
                    int idGerado = keys.getInt(1);
                    c.setId(idGerado);

                    try (PreparedStatement stmtC = conn.prepareStatement(sqlCliente)) {
                        stmtC.setInt(1, idGerado);
                        stmtC.executeUpdate();
                    }
                }

                conn.commit();
                return true;

            } catch (SQLException e) {
                conn.rollback();
                throw new RuntimeException("Erro ao inserir cliente", e);
            }

        } catch (SQLException e) {
            throw new RuntimeException("Erro de conexão ao inserir cliente", e);
        }
    }

    public Cliente buscarPorId(int id) {
        String sql = "SELECT u.* FROM usuario u "
                + "INNER JOIN cliente c ON c.id = u.id "
                + "WHERE u.id = ?";

        try (Connection conn = ConexaoDB.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return map(rs);
            }

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao buscar cliente", e);
        }

        return null;
    }

    public Cliente buscarPorEmail(String email) {
        String sql = "SELECT u.* FROM usuario u "
                + "INNER JOIN cliente c ON c.id = u.id "
                + "WHERE u.email = ?";

        try (Connection conn = ConexaoDB.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return map(rs);
            }

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao buscar cliente por email", e);
        }

        return null;
    }

    public List<Cliente> listar() {
        String sql = "SELECT u.* FROM usuario u "
                + "INNER JOIN cliente c ON c.id = u.id "
                + "WHERE u.ativo = true";
        List<Cliente> lista = new ArrayList<>();

        try (Connection conn = ConexaoDB.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                lista.add(map(rs));
            }

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao listar clientes", e);
        }

        return lista;
    }

    public void atualizar(Cliente c) {
        String sql = "UPDATE usuario SET nome=?, cpf=?, telefone=?, email=? WHERE id=?";

        try (Connection conn = ConexaoDB.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, c.getNome());
            stmt.setString(2, c.getCpf());
            stmt.setString(3, c.getTelefone());
            stmt.setString(4, c.getEmail());
            stmt.setInt(5, c.getId());
            stmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao atualizar cliente", e);
        }
    }

    public void excluir(int id) {
        // Excluir usuario já cascateia para cliente pelo ON DELETE CASCADE
        String sql = "DELETE FROM usuario WHERE id = ?";

        try (Connection conn = ConexaoDB.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            stmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao excluir cliente", e);
        }
    }
}
