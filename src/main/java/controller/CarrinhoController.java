// controller/CarrinhoController.java
package controller;

import model.Carrinho;
import model.ItemCarrinho;
import model.Livro;
import model.Usuario;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import service.CarrinhoService;
import service.LivroService;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/carrinho")
public class CarrinhoController {

    private final CarrinhoService carrinhoService = new CarrinhoService();
    private final LivroService livroService = new LivroService();

    @GetMapping
    public String verCarrinho(HttpSession session, Model model) {
        Usuario usuario = (Usuario) session.getAttribute("usuarioLogado");
        if (usuario == null) return "redirect:/login";

        List<ItemCarrinho> itens = carrinhoService.listarItens(usuario.getId());
        Carrinho carrinho = carrinhoService.buscarCarrinho(usuario.getId());

        model.addAttribute("itens", itens);
        model.addAttribute("carrinho", carrinho);

        // Enriquece cada item com o objeto Livro para exibir o nome no template
        model.addAttribute("livros", itens.stream()
                .map(i -> livroService.buscarPorId(i.getLivroId()))
                .toList());

        return "carrinho/index";
    }

    @PostMapping("/adicionar")
    public String adicionar(@RequestParam int livroId,
                            @RequestParam(defaultValue = "1") int quantidade,
                            HttpSession session,
                            Model model) {
        Usuario usuario = (Usuario) session.getAttribute("usuarioLogado");
        if (usuario == null) return "redirect:/login";

        boolean ok = carrinhoService.adicionarItem(usuario.getId(), livroId, quantidade);

        if (!ok) {
            model.addAttribute("erro", "Estoque insuficiente.");
            Livro livro = livroService.buscarPorId(livroId);
            model.addAttribute("livro", livro);
            return "livro/detalhe";
        }

        return "redirect:/carrinho";
    }

    @PostMapping("/remover/{itemId}")
    public String remover(@PathVariable int itemId, HttpSession session) {
        Usuario usuario = (Usuario) session.getAttribute("usuarioLogado");
        if (usuario == null) return "redirect:/login";

        carrinhoService.removerItem(itemId, usuario.getId());
        return "redirect:/carrinho";
    }
}