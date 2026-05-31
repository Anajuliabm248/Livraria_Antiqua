package model;

import java.time.LocalDate;

public class Venda {
    private int id;
    private int clienteId;
    private LocalDate dtVenda;
    private double valorTotal;
    private String status;

    public Venda() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getClienteId() { return clienteId; }
    public void setClienteId(int clienteId) { this.clienteId = clienteId; }

    public LocalDate getDtVenda() { return dtVenda; }
    public void setDtVenda(java.sql.Date dtVenda) {
        this.dtVenda = dtVenda != null ? dtVenda.toLocalDate() : null;
    }

    public double getValorTotal() { return valorTotal; }
    public void setValorTotal(double valorTotal) { this.valorTotal = valorTotal; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
