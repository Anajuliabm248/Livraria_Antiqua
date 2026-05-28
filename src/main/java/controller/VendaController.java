// controller/VendaController.java
package controller;

import model.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import service.CarrinhoService;
import service.LivroService;
import service.VendaService;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/venda")
public class VendaController {

    private final VendaService vendaService = new VendaService();
    private final CarrinhoService carrinhoService = new CarrinhoService();
    private final LivroService livroService = new LivroService();

    @GetMapping("/checkout")
    public String checkout(HttpSession session, Model model) {
        Usuario usuario = (Usuario) session.getAttribute("usuarioLogado");
        if (usuario == null) return "redirect:/login";

        List<ItemCarrinho> itens = carrinhoService.listarItens(usuario.getId());
        Carrinho carrinho = carrinhoService.buscarCarrinho(usuario.getId());

        if (itens.isEmpty()) return "redirect:/carrinho";

        model.addAttribute("itens", itens);
        model.addAttribute("carrinho", carrinho);
        model.addAttribute("livros", itens.stream()
                .map(i -> livroService.buscarPorId(i.getLivroId()))
                .toList());

        return "venda/checkout";
    }

    @PostMapping("/confirmar")
    public String confirmar(@RequestParam String formaPagamento,
                            HttpSession session) {
        Usuario usuario = (Usuario) session.getAttribute("usuarioLogado");
        if (usuario == null) return "redirect:/login";

        Venda venda = vendaService.finalizarCompra(usuario.getId(), formaPagamento);

        if (venda == null) return "redirect:/carrinho";

        return "redirect:/venda/" + venda.getId() + "/confirmacao";
    }

    @GetMapping("/{id}/confirmacao")
    public String confirmacao(@PathVariable int id, HttpSession session, Model model) {
        Usuario usuario = (Usuario) session.getAttribute("usuarioLogado");
        if (usuario == null) return "redirect:/login";

        Venda venda = vendaService.buscarPorId(id);
        List<ItemVenda> itens = vendaService.listarItensDaVenda(id);

        model.addAttribute("venda", venda);
        model.addAttribute("itens", itens);
        model.addAttribute("livros", itens.stream()
                .map(i -> livroService.buscarPorId(i.getLivroId()))
                .toList());

        return "venda/confirmacao";
    }

    @PostMapping("/{id}/cancelar")
    public String cancelar(@PathVariable int id, HttpSession session) {
        Usuario usuario = (Usuario) session.getAttribute("usuarioLogado");
        if (usuario == null) return "redirect:/login";

        vendaService.cancelarVenda(id);
        return "redirect:/cliente/pedidos";
    }

    @GetMapping("/historico")
    public String historico(HttpSession session, Model model) {
        Usuario usuario = (Usuario) session.getAttribute("usuarioLogado");
        if (usuario == null) return "redirect:/login";

        model.addAttribute("vendas", vendaService.listarPorCliente(usuario.getId()));
        return "venda/historico";
    }
}