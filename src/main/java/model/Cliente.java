package model;

public class Cliente extends Usuario {
    private Endereco endereco;
    private Carrinho carrinho;

    public Cliente() {
        super();
    }

    public Cliente(String senha, String email, String telefone, String cpf, String nome, Endereco endereco, Carrinho carrinho) {
        super(senha, email, telefone, cpf, nome);
        this.endereco = endereco;
        this.carrinho = carrinho;
    }

    public Cliente(int id, String senha, String email, String telefone, String cpf, String nome, Endereco endereco, Carrinho carrinho) {
        super(id, senha, email, telefone, cpf, nome);
        this.endereco = endereco;
        this.carrinho = carrinho;
    }

    public Endereco getEndereco() {
        return endereco;
    }

    public void setEndereco(Endereco endereco) {
        this.endereco = endereco;
    }

    public Carrinho getCarrinho() {
        return carrinho;
    }

    public void setCarrinho(Carrinho carrinho) {
        this.carrinho = carrinho;
    }
}

