package model;

import java.time.LocalDate;

public class Pagamento {
    private int id;
    private int vendaId;
    private Venda venda;
    private String forma_pagamento;
    private String status;
    private float valor;
    private LocalDate dt_pagamento;

    public Pagamento() {
    }

    public Pagamento(int id, Venda venda, String forma_pagamento, String status, float valor, LocalDate dt_pagamento) {
        this.id = id;
        this.venda = venda;
        this.forma_pagamento = forma_pagamento;
        this.status = status;
        this.valor = valor;
        this.dt_pagamento = dt_pagamento;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Venda getVenda() {
        return venda;
    }

    public void setVenda(Venda venda) {
        this.venda = venda;
    }

    public String getForma_pagamento() {
        return forma_pagamento;
    }

    public void setForma_pagamento(String forma_pagamento) {
        this.forma_pagamento = forma_pagamento;
    }

    public String getFormaPagamento() {
        return forma_pagamento;
    }

    public void setFormaPagamento(String formaPagamento) {
        this.forma_pagamento = formaPagamento;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public float getValor() {
        return valor;
    }

    public void setValor(float valor) {
        this.valor = valor;
    }

    public LocalDate getDt_pagamento() {
        return dt_pagamento;
    }

    public void setDt_pagamento(LocalDate dt_pagamento) {
        this.dt_pagamento = dt_pagamento;
    }

    public int getVendaId() {
        return vendaId;
    }

    public void setVendaId(int vendaId) {
        this.vendaId = vendaId;
    }

    public void setValor(double valor) {
        this.valor = (float) valor;
    }

    public LocalDate getDtPagamento() {
        return dt_pagamento;
    }

    public void setDtPagamento(java.sql.Date dtPagamento) {
        this.dt_pagamento = dtPagamento != null ? dtPagamento.toLocalDate() : null;
    }
}

