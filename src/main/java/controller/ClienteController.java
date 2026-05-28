// controller/ClienteController.java
package controller;

import dao.EnderecoDAO;
import model.Cliente;
import model.Endereco;
import model.Usuario;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import service.ClienteService;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/cliente")
public class ClienteController {

    private final ClienteService clienteService = new ClienteService();
    private final EnderecoDAO enderecoDAO = new EnderecoDAO();

    @GetMapping("/perfil")
    public String perfil(HttpSession session, Model model) {
        Usuario usuario = (Usuario) session.getAttribute("usuarioLogado");
        if (usuario == null) return "redirect:/login";

        model.addAttribute("cliente", clienteService.buscarPorId(usuario.getId()));
        return "cliente/perfil";
    }

    @PostMapping("/perfil")
    public String salvarPerfil(@RequestParam String nome,
                               @RequestParam String telefone,
                               @RequestParam String email,
                               HttpSession session) {
        Usuario usuario = (Usuario) session.getAttribute("usuarioLogado");
        if (usuario == null) return "redirect:/login";

        Cliente cliente = clienteService.buscarPorId(usuario.getId());
        cliente.setNome(nome);
        cliente.setTelefone(telefone);
        cliente.setEmail(email);
        clienteService.atualizar(cliente);

        // Atualiza o nome na sessão
        usuario.setNome(nome);
        session.setAttribute("usuarioLogado", usuario);

        return "redirect:/cliente/perfil";
    }

    @GetMapping("/endereco")
    public String endereco(HttpSession session, Model model) {
        Usuario usuario = (Usuario) session.getAttribute("usuarioLogado");
        if (usuario == null) return "redirect:/login";

        Endereco endereco = enderecoDAO.buscarPorClienteId(usuario.getId());
        model.addAttribute("endereco", endereco);
        return "cliente/endereco";
    }

    @PostMapping("/endereco")
    public String salvarEndereco(@RequestParam String logradouro,
                                 @RequestParam int numero,
                                 @RequestParam String complemento,
                                 @RequestParam String bairro,
                                 @RequestParam String cidade,
                                 @RequestParam String estado,
                                 @RequestParam String cep,
                                 HttpSession session) {
        Usuario usuario = (Usuario) session.getAttribute("usuarioLogado");
        if (usuario == null) return "redirect:/login";

        Endereco existente = enderecoDAO.buscarPorClienteId(usuario.getId());

        if (existente == null) {
            Endereco novo = new Endereco();
            novo.setClienteId(usuario.getId());
            novo.setLogradouro(logradouro);
            novo.setNumero(numero);
            novo.setComplemento(complemento);
            novo.setBairro(bairro);
            novo.setCidade(cidade);
            novo.setEstado(estado);
            novo.setCep(cep);
            novo.setPais("Brasil");
            enderecoDAO.inserir(novo);
        } else {
            existente.setLogradouro(logradouro);
            existente.setNumero(numero);
            existente.setComplemento(complemento);
            existente.setBairro(bairro);
            existente.setCidade(cidade);
            existente.setEstado(estado);
            existente.setCep(cep);
            enderecoDAO.atualizar(existente);
        }

        return "redirect:/cliente/endereco";
    }
}