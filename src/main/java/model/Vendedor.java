package model;

public class Vendedor extends Usuario {

    public Vendedor() {
        super();
    }

    public Vendedor(String nome, String cpf, String telefone, String email, String senha) {
        this.setNome(nome);
        this.setCpf(cpf);
        this.setTelefone(telefone);
        this.setEmail(email);
        this.setSenha(senha);
    }
}
