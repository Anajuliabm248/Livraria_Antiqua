// controller/VendedorController.java
package controller;

import model.Usuario;
import model.Venda;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import service.LivroService;
import service.VendaService;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/vendedor")
public class VendedorController {

    private final LivroService livroService = new LivroService();
    private final VendaService vendaService = new VendaService();

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        if (!isVendedor(session)) return "redirect:/login";

        model.addAttribute("totalVendas", vendaService.listarTodas().size());
        model.addAttribute("livros", livroService.listar());
        return "vendedor/dashboard";
    }

    @GetMapping("/estoque")
    public String estoque(HttpSession session, Model model) {
        if (!isVendedor(session)) return "redirect:/login";

        model.addAttribute("livros", livroService.listar());
        return "vendedor/estoque";
    }

    @GetMapping("/relatorio")
    public String relatorio(HttpSession session, Model model) {
        if (!isVendedor(session)) return "redirect:/login";

        List<Venda> vendas = vendaService.listarTodas();
        double totalGeral = vendas.stream()
                .mapToDouble(Venda::getValorTotal)
                .sum();

        model.addAttribute("vendas", vendas);
        model.addAttribute("totalGeral", totalGeral);
        return "vendedor/relatorio";
    }

    private boolean isVendedor(HttpSession session) {
        Usuario u = (Usuario) session.getAttribute("usuarioLogado");
        return u != null && u.getTipo().equals("VENDEDOR");
    }
}