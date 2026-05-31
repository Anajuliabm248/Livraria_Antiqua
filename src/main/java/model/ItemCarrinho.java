package model;

public class ItemCarrinho {
    private int id;
    private int carrinhoId;
    private int livroId;
    private int quantidade;
    private double subtotal;

    public ItemCarrinho() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getCarrinhoId() { return carrinhoId; }
    public void setCarrinhoId(int carrinhoId) { this.carrinhoId = carrinhoId; }

    public int getLivroId() { return livroId; }
    public void setLivroId(int livroId) { this.livroId = livroId; }

    public int getQuantidade() { return quantidade; }
    public void setQuantidade(int quantidade) { this.quantidade = quantidade; }

    public double getSubtotal() { return subtotal; }
    public void setSubtotal(double subtotal) { this.subtotal = subtotal; }
}
