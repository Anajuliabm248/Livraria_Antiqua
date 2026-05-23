package model;

public class Vendedor extends Usuario{

    public Vendedor() {
        super();
    }

    public Vendedor(String nome, String cpf, String telefone, String email, String senha) {
        super(senha, email, telefone, cpf, nome);
    }

    public Vendedor(int id, String nome, String cpf, String telefone, String email, String senha) {
        super(id, nome, cpf, telefone, email, senha);
    }
}
