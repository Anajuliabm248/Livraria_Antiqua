package model;

import java.time.LocalDate;
import java.util.List;

public class Venda {
    private int id;
    private int clienteId;
    private Cliente cliente;
    private Pagamento pagamento;
    private LocalDate dt_venda;
    private float valor_total;
    private String status;
    private List<ItemVenda> itens;

    public Venda() {
    }

    public Venda(Cliente cliente, Pagamento pagamento, LocalDate dt_venda,
                 float valor_total, List<ItemVenda> itens) {
        this.cliente = cliente;
        this.pagamento = pagamento;
        this.dt_venda = dt_venda;
        this.valor_total = valor_total;
        this.itens = itens;
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

    public Pagamento getPagamento() {
        return pagamento;
    }

    public void setPagamento(Pagamento pagamento) {
        this.pagamento = pagamento;
    }

    public LocalDate getDt_venda() {
        return dt_venda;
    }

    public void setDt_venda(LocalDate dt_venda) {
        this.dt_venda = dt_venda;
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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public LocalDate getDtVenda() {
        return dt_venda;
    }

    public void setDtVenda(java.sql.Date dtVenda) {
        this.dt_venda = dtVenda != null ? dtVenda.toLocalDate() : null;
    }

    public List<ItemVenda> getItens() {
        return itens;
    }

    public void setItens(List<ItemVenda> itens) {
        this.itens = itens;
    }
}

