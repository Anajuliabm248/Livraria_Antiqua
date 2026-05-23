package model;

public class ItemVenda {
    private int id;
    private int vendaId;
    private int livroId;
    private Livro livro;
    private int quantidade;
    private float subtotal;
    private float preco_unitario;

    public ItemVenda() {
    }

    public ItemVenda(int id, Livro livro, int quantidade, float subtotal, float preco_unitario) {
        this.id = id;
        this.livro = livro;
        this.quantidade = quantidade;
        this.subtotal = subtotal;
        this.preco_unitario = preco_unitario;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Livro getLivro() {
        return livro;
    }

    public void setLivro(Livro livro) {
        this.livro = livro;
    }

    public int getQuantidade() {
        return quantidade;
    }

    public void setQuantidade(int quantidade) {
        this.quantidade = quantidade;
    }

    public float getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(float subtotal) {
        this.subtotal = subtotal;
    }

    public float getPreco_unitario() {
        return preco_unitario;
    }

    public void setPreco_unitario(float preco_unitario) {
        this.preco_unitario = preco_unitario;
    }

    public int getVendaId() {
        return vendaId;
    }

    public void setVendaId(int vendaId) {
        this.vendaId = vendaId;
    }

    public int getLivroId() {
        return livroId;
    }

    public void setLivroId(int livroId) {
        this.livroId = livroId;
    }

    public double getPrecoUni() {
        return preco_unitario;
    }

    public void setPrecoUni(double precoUni) {
        this.preco_unitario = (float) precoUni;
    }

    public void setSubtotal(double subtotal) {
        this.subtotal = (float) subtotal;
    }
}
