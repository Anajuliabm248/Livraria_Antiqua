package model;

import java.util.List;

public class Carrinho {
    private int id;
    private Cliente cliente;
    private List<ItemCarrinho> itens;
    private float valor_total;
    private int clienteId;

    public Carrinho() {
    }

    public Carrinho(int id, Cliente cliente, List<ItemCarrinho> itens, float valor_total) {
        this.id = id;
        this.cliente = cliente;
        this.itens = itens;
        this.valor_total = valor_total;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Cliente getCliente() {
        return cliente;
    }

    public void setCliente(Cliente cliente) {
        this.cliente = cliente;
    }

    public List<ItemCarrinho> getItens() {
        return itens;
    }

    public void setItens(List<ItemCarrinho> itens) {
        this.itens = itens;
    }

    public float getValor_total() {
        return valor_total;
    }

    public void setValor_total(float valor_total) {
        this.valor_total = valor_total;
    }

    public int getClienteId() {
        return clienteId;
    }

    public void setClienteId(int clienteId) {
        this.clienteId = clienteId;
    }

    public double getValorTotal() {
        return valor_total;
    }

    public void setValorTotal(double valorTotal) {
        this.valor_total = (float) valorTotal;
    }
}

