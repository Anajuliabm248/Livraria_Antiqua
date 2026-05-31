package model;

public class ItemVenda {
    private int id;
    private int vendaId;
    private int livroId;
    private int quantidade;
    private double precoUni;
    private double subtotal;

    public ItemVenda() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getVendaId() { return vendaId; }
    public void setVendaId(int vendaId) { this.vendaId = vendaId; }

    public int getLivroId() { return livroId; }
    public void setLivroId(int livroId) { this.livroId = livroId; }

    public int getQuantidade() { return quantidade; }
    public void setQuantidade(int quantidade) { this.quantidade = quantidade; }

    public double getPrecoUni() { return precoUni; }
    public void setPrecoUni(double precoUni) { this.precoUni = precoUni; }

    public double getSubtotal() { return subtotal; }
    public void setSubtotal(double subtotal) { this.subtotal = subtotal; }
}
