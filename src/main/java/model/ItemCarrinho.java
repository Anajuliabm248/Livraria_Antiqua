package model;

public class ItemCarrinho {
    private int id;
    private int carrinhoId;
    private int livroId;
    private Livro livro;
    private int quantidade;
    private float subtotal;

    public ItemCarrinho() {
    }

    public ItemCarrinho(int id, Livro livro, int quantidade, float subtotal) {
        this.id = id;
        this.livro = livro;
        this.quantidade = quantidade;
        this.subtotal = subtotal;
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

    public float getsubtotal() {
        return subtotal;
    }

    public void setsubtotal(float subtotal) {
        this.subtotal = subtotal;
    }

    public int getCarrinhoId() {
        return carrinhoId;
    }

    public void setCarrinhoId(int carrinhoId) {
        this.carrinhoId = carrinhoId;
    }

    public int getLivroId() {
        return livroId;
    }

    public void setLivroId(int livroId) {
        this.livroId = livroId;
    }

    public double getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(double subtotal) {
        this.subtotal = (float) subtotal;
    }
}
