package model;

public class Cliente extends Usuario {
    private Endereco endereco;

    public Cliente() {
        super();
    }

    public Cliente(Endereco endereco) {
        this.endereco = endereco;
    }

    public Cliente(String senha, String email, String telefone, String cpf, String nome, Endereco endereco) {
        super(senha, email, telefone, cpf, nome);
        this.endereco = endereco;
    }

    public Endereco getEndereco() {
        return endereco;
    }

    public void setEndereco(Endereco endereco) {
        this.endereco = endereco;
    }
}
