package service;

import dao.CarrinhoDAO;
import dao.ItemCarrinhoDAO;
import dao.LivroDAO;
import model.Carrinho;
import model.ItemCarrinho;
import model.Livro;

import java.util.List;

public class CarrinhoService {

    private final CarrinhoDAO carrinhoDAO = new CarrinhoDAO();
    private final ItemCarrinhoDAO itemCarrinhoDAO = new ItemCarrinhoDAO();
    private final LivroDAO livroDAO = new LivroDAO();

    public Carrinho buscarCarrinho(int clienteId) {
        return carrinhoDAO.buscarPorClienteId(clienteId);
    }

    public List<ItemCarrinho> listarItens(int clienteId) {
        Carrinho carrinho = carrinhoDAO.buscarPorClienteId(clienteId);
        if (carrinho == null) return List.of();
        return itemCarrinhoDAO.listarPorCarrinho(carrinho.getId());
    }

    public boolean adicionarItem(int clienteId, int livroId, int quantidade) {
        Livro livro = livroDAO.buscarPorId(livroId);
        if (livro == null || livro.getQuantidade() < quantidade) {
            return false; // sem estoque suficiente
        }

        Carrinho carrinho = carrinhoDAO.buscarPorClienteId(clienteId);
        ItemCarrinho existente = itemCarrinhoDAO.buscarPorCarrinhoELivro(carrinho.getId(), livroId);

        if (existente != null) {
            // Livro já está no carrinho — apenas aumenta a quantidade
            int novaQtd = existente.getQuantidade() + quantidade;
            existente.setQuantidade(novaQtd);
            existente.setSubtotal(novaQtd * livro.getPreco());
            itemCarrinhoDAO.atualizar(existente);
        } else {
            ItemCarrinho item = new ItemCarrinho();
            item.setCarrinhoId(carrinho.getId());
            item.setLivroId(livroId);
            item.setQuantidade(quantidade);
            item.setSubtotal(quantidade * livro.getPreco());
            itemCarrinhoDAO.inserir(item);
        }

        recalcularTotal(carrinho.getId());
        return true;
    }

    public void removerItem(int itemId, int clienteId) {
        itemCarrinhoDAO.excluir(itemId);
        Carrinho carrinho = carrinhoDAO.buscarPorClienteId(clienteId);
        recalcularTotal(carrinho.getId());
    }

    public void limpar(int clienteId) {
        Carrinho carrinho = carrinhoDAO.buscarPorClienteId(clienteId);
        itemCarrinhoDAO.excluirPorCarrinho(carrinho.getId());
        carrinhoDAO.atualizarTotal(carrinho.getId(), 0.0);
    }

    private void recalcularTotal(int carrinhoId) {
        List<ItemCarrinho> itens = itemCarrinhoDAO.listarPorCarrinho(carrinhoId);
        double total = itens.stream()
                .mapToDouble(ItemCarrinho::getSubtotal)
                .sum();
        carrinhoDAO.atualizarTotal(carrinhoId, total);
    }
}