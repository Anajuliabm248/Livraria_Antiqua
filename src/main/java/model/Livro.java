package model;

public class Livro {
    private int id;
    private int categoriaId;
    private int vendedorId;   // ← novo: dono do livro
    private String nome;
    private String autor;
    private String isbn;
    private String descricao;
    private int numPagina;
    private int anoLancamento;
    private double preco;
    private int quantidade;
    private String imgCapa;

    public Livro() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getCategoriaId() { return categoriaId; }
    public void setCategoriaId(int categoriaId) { this.categoriaId = categoriaId; }

    public int getVendedorId() { return vendedorId; }
    public void setVendedorId(int vendedorId) { this.vendedorId = vendedorId; }

    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }

    public String getAutor() { return autor; }
    public void setAutor(String autor) { this.autor = autor; }

    public String getIsbn() { return isbn; }
    public void setIsbn(String isbn) { this.isbn = isbn; }

    public String getDescricao() { return descricao; }
    public void setDescricao(String descricao) { this.descricao = descricao; }

    public int getNumPagina() { return numPagina; }
    public void setNumPagina(int numPagina) { this.numPagina = numPagina; }

    public int getAnoLancamento() { return anoLancamento; }
    public void setAnoLancamento(int anoLancamento) { this.anoLancamento = anoLancamento; }

    public double getPreco() { return preco; }
    public void setPreco(double preco) { this.preco = preco; }

    public int getQuantidade() { return quantidade; }
    public void setQuantidade(int quantidade) { this.quantidade = quantidade; }

    public String getImgCapa() { return imgCapa; }
    public void setImgCapa(String imgCapa) { this.imgCapa = imgCapa; }
}
