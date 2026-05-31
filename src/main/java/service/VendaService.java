package service;

import dao.ItemCarrinhoDAO;
import dao.ItemVendaDAO;
import dao.LivroDAO;
import dao.PagamentoDAO;
import dao.VendaDAO;
import model.*;

import java.util.List;

public class VendaService {

    private final VendaDAO vendaDAO = new VendaDAO();
    private final ItemVendaDAO itemVendaDAO = new ItemVendaDAO();
    private final PagamentoDAO pagamentoDAO = new PagamentoDAO();
    private final LivroDAO livroDAO = new LivroDAO();
    private final ItemCarrinhoDAO itemCarrinhoDAO = new ItemCarrinhoDAO();
    private final CarrinhoService carrinhoService = new CarrinhoService();

    public Venda finalizarCompra(int clienteId, String formaPagamento) {
        List<ItemCarrinho> itensCarrinho = carrinhoService.listarItens(clienteId);

        if (itensCarrinho.isEmpty()) return null;

        // Valida estoque antes de criar qualquer registro
        for (ItemCarrinho item : itensCarrinho) {
            Livro livro = livroDAO.buscarPorId(item.getLivroId());
            if (livro == null || livro.getQuantidade() < item.getQuantidade()) return null;
        }

        double total = 0;
        for (ItemCarrinho item : itensCarrinho) {
            Livro livro = livroDAO.buscarPorId(item.getLivroId());
            total += livro.getPreco() * item.getQuantidade();
        }

        Venda venda = new Venda();
        venda.setClienteId(clienteId);
        venda.setValorTotal(total);
        int vendaId = vendaDAO.inserir(venda);
        venda.setId(vendaId);

        for (ItemCarrinho item : itensCarrinho) {
            Livro livro = livroDAO.buscarPorId(item.getLivroId());

            ItemVenda itemVenda = new ItemVenda();
            itemVenda.setVendaId(vendaId);
            itemVenda.setLivroId(item.getLivroId());
            itemVenda.setQuantidade(item.getQuantidade());
            itemVenda.setPrecoUni(livro.getPreco());
            itemVenda.setSubtotal(livro.getPreco() * item.getQuantidade());
            itemVendaDAO.inserir(itemVenda);

            livroDAO.atualizarEstoque(livro.getId(), livro.getQuantidade() - item.getQuantidade());
        }

        Pagamento pagamento = new Pagamento();
        pagamento.setVendaId(vendaId);
        pagamento.setFormaPagamento(formaPagamento);
        pagamento.setValor(total);
        pagamentoDAO.inserir(pagamento);

        pagamentoDAO.atualizarStatus(vendaId, "APROVADO");
        vendaDAO.atualizarStatus(vendaId, "CONCLUIDA");

        carrinhoService.limpar(clienteId);

        return venda;
    }

    public void cancelarVenda(int vendaId) {
        List<ItemVenda> itens = itemVendaDAO.listarPorVenda(vendaId);
        for (ItemVenda item : itens) {
            Livro livro = livroDAO.buscarPorId(item.getLivroId());
            livroDAO.atualizarEstoque(livro.getId(), livro.getQuantidade() + item.getQuantidade());
        }
        vendaDAO.atualizarStatus(vendaId, "CANCELADA");
        pagamentoDAO.atualizarStatus(vendaId, "CANCELADO");
    }

    public Venda buscarPorId(int id) { return vendaDAO.buscarPorId(id); }

    public List<Venda> listarPorCliente(int clienteId) { return vendaDAO.listarPorCliente(clienteId); }

    // Vendas que contêm livros deste vendedor
    public List<Venda> listarPorVendedor(int vendedorId) { return vendaDAO.listarPorVendedor(vendedorId); }

    public List<Venda> listarTodas() { return vendaDAO.listarTodas(); }

    public List<ItemVenda> listarItensDaVenda(int vendaId) { return itemVendaDAO.listarPorVenda(vendaId); }
}
