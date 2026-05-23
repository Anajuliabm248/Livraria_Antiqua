package model;

public class Livro {
    private int id;
    private int categoriaId;
    private String nome;
    private String autor;
    private String isbn;
    private String descricao;
    private int num_pagina;
    private int ano_lancamento;
    private float preco;
    private float preco_promo;
    private int quantidade;
    private String img_capa;
    private Categoria categoria;

    public Livro() {
    }

    public Livro(int id, String nome, String autor, String isbn, String descricao, int num_pagina, int ano_lancamento, float preco, float preco_promo, int quantidade, String img_capa, Categoria categoria) {
        this.id = id;
        this.nome = nome;
        this.autor = autor;
        this.isbn = isbn;
        this.descricao = descricao;
        this.num_pagina = num_pagina;
        this.ano_lancamento = ano_lancamento;
        this.preco = preco;
        this.preco_promo = preco_promo;
        this.quantidade = quantidade;
        this.img_capa = img_capa;
        this.categoria = categoria;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getAutor() {
        return autor;
    }

    public void setAutor(String autor) {
        this.autor = autor;
    }

    public String getIsbn() {
        return isbn;
    }

    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public int getNum_pagina() {
        return num_pagina;
    }

    public void setNum_pagina(int num_pagina) {
        this.num_pagina = num_pagina;
    }

    public int getAno_lancamento() {
        return ano_lancamento;
    }

    public void setAno_lancamento(int ano_lancamento) {
        this.ano_lancamento = ano_lancamento;
    }

    public float getPreco() {
        return preco;
    }

    public void setPreco(float preco) {
        this.preco = preco;
    }

    public void setPreco(double preco) {
        this.preco = (float) preco;
    }

    public float getPreco_promo() {
        return preco_promo;
    }

    public void setPreco_promo(float preco_promo) {
        this.preco_promo = preco_promo;
    }

    public int getCategoriaId() {
        return categoriaId;
    }

    public void setCategoriaId(int categoriaId) {
        this.categoriaId = categoriaId;
    }

    public int getNumPagina() {
        return num_pagina;
    }

    public void setNumPagina(int num_pagina) {
        this.num_pagina = num_pagina;
    }

    public int getAnoLancamento() {
        return ano_lancamento;
    }

    public void setAnoLancamento(int ano_lancamento) {
        this.ano_lancamento = ano_lancamento;
    }

    public double getPrecoPromo() {
        return preco_promo;
    }

    public void setPrecoPromo(double precoPromo) {
        this.preco_promo = (float) precoPromo;
    }

    public int getQuantidade() {
        return quantidade;
    }

    public void setQuantidade(int quantidade) {
        this.quantidade = quantidade;
    }

    public String getImg_capa() {
        return img_capa;
    }

    public void setImg_capa(String img_capa) {
        this.img_capa = img_capa;
    }

    public String getImgCapa() {
        return img_capa;
    }

    public void setImgCapa(String imgCapa) {
        this.img_capa = imgCapa;
    }

    public Categoria getCategoria() {
        return categoria;
    }

    public void setCategoria(Categoria categoria) {
        this.categoria = categoria;
    }
}
