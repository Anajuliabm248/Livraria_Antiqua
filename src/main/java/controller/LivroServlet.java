package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Livro;
import model.Usuario;
import service.CategoriaService;
import service.LivroService;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Set;

@WebServlet("/livro")
@MultipartConfig
public class LivroServlet extends HttpServlet {

    private final LivroService livroService = new LivroService();
    private final CategoriaService categoriaService = new CategoriaService();

    private static final Set<String> MIME_IMAGENS_PERMITIDOS = Set.of(
            "image/jpeg", "image/png", "image/gif", "image/webp"
    );

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");

        String acao = req.getParameter("acao");

        if ("detalhe".equals(acao)) {
            int id;
            try { id = Integer.parseInt(req.getParameter("id")); }
            catch (NumberFormatException e) { resp.sendRedirect("livro"); return; }

            Livro livro = livroService.buscarPorId(id);
            if (livro == null) { resp.sendRedirect("livro"); return; }
            req.setAttribute("livro", livro);
            req.setAttribute("categoria", categoriaService.buscarPorId(livro.getCategoriaId()));
            req.getRequestDispatcher("WEB-INF/pages/livro/detalhe.jsp").forward(req, resp);
            return;
        }

        if ("novo".equals(acao) || "editar".equals(acao) || "excluir".equals(acao)) {
            Usuario vendedor = getVendedor(req);
            if (vendedor == null) { resp.sendRedirect("login"); return; }

            if ("excluir".equals(acao)) {
                try {
                    int id = Integer.parseInt(req.getParameter("id"));
                    // excluir só procede se o livro pertencer ao vendedor logado
                    boolean excluido = livroService.excluir(id, vendedor.getId());
                    String msg = excluido ? "excluido" : "negado";
                    resp.sendRedirect("vendedor?acao=estoque&msg=" + msg);
                } catch (NumberFormatException e) {
                    resp.sendRedirect("vendedor?acao=estoque");
                }
                return;
            }

            if ("editar".equals(acao)) {
                try {
                    int id = Integer.parseInt(req.getParameter("id"));
                    Livro livro = livroService.buscarPorId(id);
                    // Bloqueia edição de livros de outro vendedor
                    if (livro == null || livro.getVendedorId() != vendedor.getId()) {
                        resp.sendRedirect("vendedor?acao=estoque&msg=negado");
                        return;
                    }
                    req.setAttribute("livro", livro);
                } catch (NumberFormatException e) {
                    resp.sendRedirect("vendedor?acao=estoque");
                    return;
                }
            }

            req.setAttribute("categorias", categoriaService.listar());
            req.getRequestDispatcher("WEB-INF/pages/livro/form.jsp").forward(req, resp);
            return;
        }

        // Listagem pública: todos os livros de todos os vendedores
        String busca      = req.getParameter("busca");
        String catIdParam = req.getParameter("categoriaId");

        List<Livro> livros;
        if (busca != null && !busca.isBlank()) {
            livros = livroService.buscarPorNome(busca);
        } else if (catIdParam != null && !catIdParam.isBlank()) {
            try { livros = livroService.buscarPorCategoria(Integer.parseInt(catIdParam)); }
            catch (NumberFormatException e) { livros = livroService.listar(); }
        } else {
            livros = livroService.listar();
        }

        req.setAttribute("livros", livros);
        req.setAttribute("categorias", categoriaService.listar());
        req.getRequestDispatcher("WEB-INF/pages/livro/catalogo.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        Usuario vendedor = getVendedor(req);
        if (vendedor == null) { resp.sendRedirect("login"); return; }

        Part arquivo = req.getPart("imgCapa");
        String nomeArquivo = null;

        String uploadPath = System.getProperty("uploads.dir",
                System.getProperty("user.home") + "/livraria-uploads");
        File pasta = new File(uploadPath);
        if (!pasta.exists()) pasta.mkdirs();

        if (arquivo != null && arquivo.getSize() > 0) {
            String contentType = arquivo.getContentType();
            if (contentType == null || !MIME_IMAGENS_PERMITIDOS.contains(contentType.toLowerCase())) {
                req.setAttribute("erro", "Formato de imagem inválido. Use JPG, PNG, GIF ou WEBP.");
                req.setAttribute("categorias", categoriaService.listar());
                req.getRequestDispatcher("WEB-INF/pages/livro/form.jsp").forward(req, resp);
                return;
            }
            String nomeSeguro = new File(arquivo.getSubmittedFileName()).getName();
            nomeArquivo = System.currentTimeMillis() + "_" + nomeSeguro;
            arquivo.write(uploadPath + File.separator + nomeArquivo);
        }

        String idParam = req.getParameter("id");
        String nome = req.getParameter("nome");
        String autor = req.getParameter("autor");
        String isbn = req.getParameter("isbn");
        String descricao = req.getParameter("descricao");
        int numPagina, anoLancamento, quantidade, categoriaId;
        double preco;

        try {
            numPagina     = Integer.parseInt(req.getParameter("numPagina"));
            anoLancamento = Integer.parseInt(req.getParameter("anoLancamento"));
            preco         = Double.parseDouble(req.getParameter("preco"));
            quantidade    = Integer.parseInt(req.getParameter("quantidade"));
            categoriaId   = Integer.parseInt(req.getParameter("categoriaId"));
        } catch (NumberFormatException e) {
            req.setAttribute("erro", "Valores numéricos inválidos.");
            req.setAttribute("categorias", categoriaService.listar());
            req.getRequestDispatcher("WEB-INF/pages/livro/form.jsp").forward(req, resp);
            return;
        }

        Livro livro = new Livro();
        livro.setNome(nome);
        livro.setAutor(autor);
        livro.setIsbn(isbn);
        livro.setDescricao(descricao);
        livro.setNumPagina(numPagina);
        livro.setAnoLancamento(anoLancamento);
        livro.setPreco(preco);
        livro.setQuantidade(quantidade);
        livro.setCategoriaId(categoriaId);
        livro.setVendedorId(vendedor.getId()); // ← sempre usa o vendedor da sessão

        if (idParam != null && !idParam.isEmpty()) {
            try {
                int id = Integer.parseInt(idParam);
                Livro existente = livroService.buscarPorId(id);

                // Segurança: impede edição de livro de outro vendedor via POST forjado
                if (existente == null || existente.getVendedorId() != vendedor.getId()) {
                    resp.sendRedirect("vendedor?acao=estoque&msg=negado");
                    return;
                }

                livro.setId(id);
                livro.setImgCapa(nomeArquivo != null ? nomeArquivo : existente.getImgCapa());
                livroService.atualizar(livro);
                resp.sendRedirect("vendedor?acao=estoque&msg=editado");
            } catch (NumberFormatException e) {
                resp.sendRedirect("vendedor?acao=estoque");
            }
        } else {
            livro.setImgCapa(nomeArquivo);
            livroService.inserir(livro);
            resp.sendRedirect("vendedor?acao=estoque&msg=salvo");
        }
    }

    // Retorna o usuário logado se for VENDEDOR, null caso contrário
    private Usuario getVendedor(HttpServletRequest req) {
        HttpSession session = req.getSession(false);
        if (session == null) return null;
        Usuario u = (Usuario) session.getAttribute("usuario");
        return (u != null && "VENDEDOR".equals(u.getTipo())) ? u : null;
    }
}
