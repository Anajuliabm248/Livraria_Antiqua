// controller/LivroController.java
package controller;

import model.Livro;
import model.Usuario;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import service.CategoriaService;
import service.LivroService;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/livros")
public class LivroController {

    private final LivroService livroService = new LivroService();
    private final CategoriaService categoriaService = new CategoriaService();

    @GetMapping
    public String listar(@RequestParam(required = false) String nome,
                         @RequestParam(required = false) Integer categoriaId,
                         Model model) {
        List<Livro> livros;

        if (nome != null && !nome.isBlank()) {
            livros = livroService.buscarPorNome(nome);
        } else if (categoriaId != null) {
            livros = livroService.buscarPorCategoria(categoriaId);
        } else {
            livros = livroService.listar();
        }

        model.addAttribute("livros", livros);
        model.addAttribute("categorias", categoriaService.listar());
        return "livro/lista";
    }

    @GetMapping("/{id}")
    public String detalhe(@PathVariable int id, Model model) {
        Livro livro = livroService.buscarPorId(id);
        if (livro == null) return "redirect:/livros";

        model.addAttribute("livro", livro);
        model.addAttribute("categoria", categoriaService.buscarPorId(livro.getCategoriaId()));
        return "livro/detalhe";
    }

    // --- Apenas Vendedor ---

    @GetMapping("/novo")
    public String formNovo(HttpSession session, Model model) {
        if (!isVendedor(session)) return "redirect:/login";

        model.addAttribute("categorias", categoriaService.listar());
        return "livro/form";
    }

    @PostMapping("/novo")
    public String salvarNovo(@RequestParam String nome,
                             @RequestParam String autor,
                             @RequestParam String isbn,
                             @RequestParam String descricao,
                             @RequestParam int numPagina,
                             @RequestParam int anoLancamento,
                             @RequestParam double preco,
                             @RequestParam double precoPromo,
                             @RequestParam int quantidade,
                             @RequestParam int categoriaId,
                             HttpSession session) {
        if (!isVendedor(session)) return "redirect:/login";

        Livro livro = new Livro();
        livro.setNome(nome);
        livro.setAutor(autor);
        livro.setIsbn(isbn);
        livro.setDescricao(descricao);
        livro.setNumPagina(numPagina);
        livro.setAnoLancamento(anoLancamento);
        livro.setPreco(preco);
        livro.setPrecoPromo(precoPromo);
        livro.setQuantidade(quantidade);
        livro.setCategoriaId(categoriaId);
        livroService.inserir(livro);

        return "redirect:/vendedor/estoque";
    }

    @GetMapping("/{id}/editar")
    public String formEditar(@PathVariable int id, HttpSession session, Model model) {
        if (!isVendedor(session)) return "redirect:/login";

        model.addAttribute("livro", livroService.buscarPorId(id));
        model.addAttribute("categorias", categoriaService.listar());
        return "livro/form";
    }

    @PostMapping("/{id}/editar")
    public String salvarEdicao(@PathVariable int id,
                               @RequestParam String nome,
                               @RequestParam String autor,
                               @RequestParam String isbn,
                               @RequestParam String descricao,
                               @RequestParam int numPagina,
                               @RequestParam int anoLancamento,
                               @RequestParam double preco,
                               @RequestParam double precoPromo,
                               @RequestParam int quantidade,
                               @RequestParam int categoriaId,
                               HttpSession session) {
        if (!isVendedor(session)) return "redirect:/login";

        Livro livro = livroService.buscarPorId(id);
        livro.setNome(nome);
        livro.setAutor(autor);
        livro.setIsbn(isbn);
        livro.setDescricao(descricao);
        livro.setNumPagina(numPagina);
        livro.setAnoLancamento(anoLancamento);
        livro.setPreco(preco);
        livro.setPrecoPromo(precoPromo);
        livro.setQuantidade(quantidade);
        livro.setCategoriaId(categoriaId);
        livroService.atualizar(livro);

        return "redirect:/vendedor/estoque";
    }

    @PostMapping("/{id}/excluir")
    public String excluir(@PathVariable int id, HttpSession session) {
        if (!isVendedor(session)) return "redirect:/login";
        livroService.excluir(id);
        return "redirect:/vendedor/estoque";
    }

    private boolean isVendedor(HttpSession session) {
        Usuario u = (Usuario) session.getAttribute("usuarioLogado");
        return u != null && u.getTipo().equals("VENDEDOR");
    }
}