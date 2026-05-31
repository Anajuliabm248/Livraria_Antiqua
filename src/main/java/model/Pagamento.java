package model;

import java.time.LocalDate;

public class Pagamento {
    private int id;
    private int vendaId;
    private String formaPagamento;
    private String status;
    private double valor;
    private LocalDate dtPagamento;

    public Pagamento() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getVendaId() { return vendaId; }
    public void setVendaId(int vendaId) { this.vendaId = vendaId; }

    public String getFormaPagamento() { return formaPagamento; }
    public void setFormaPagamento(String formaPagamento) { this.formaPagamento = formaPagamento; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public double getValor() { return valor; }
    public void setValor(double valor) { this.valor = valor; }

    public LocalDate getDtPagamento() { return dtPagamento; }
    public void setDtPagamento(java.sql.Date dtPagamento) {
        this.dtPagamento = dtPagamento != null ? dtPagamento.toLocalDate() : null;
    }
}
