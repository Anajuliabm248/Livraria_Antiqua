// controller/AuthController.java
package controller;

import model.Cliente;
import model.Usuario;
import model.Vendedor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import service.AuthService;
import service.ClienteService;
import service.VendedorService;

import javax.servlet.http.HttpSession;

@Controller
public class AuthController {

    private final AuthService authService = new AuthService();
    private final ClienteService clienteService = new ClienteService();
    private final VendedorService vendedorService = new VendedorService();

    @GetMapping("/login")
    public String exibirLogin() {
        return "auth/login";
    }

    @PostMapping("/login")
    public String processarLogin(@RequestParam String email,
                                 @RequestParam String senha,
                                 HttpSession session,
                                 Model model) {
        Usuario usuario = authService.login(email, senha);

        if (usuario == null) {
            model.addAttribute("erro", "Email ou senha inválidos.");
            return "auth/login";
        }

        session.setAttribute("usuarioLogado", usuario);

        if (usuario.getTipo().equals("VENDEDOR")) {
            return "redirect:/vendedor/dashboard";
        }

        return "redirect:/livros";
    }

    @GetMapping("/cadastro")
    public String exibirCadastro() {
        return "auth/cadastro";
    }

    @PostMapping("/cadastro")
    public String processarCadastro(@RequestParam String nome,
                                    @RequestParam String cpf,
                                    @RequestParam String email,
                                    @RequestParam String senha,
                                    @RequestParam String telefone,
                                    @RequestParam String tipo,
                                    Model model) {
        if (tipo.equals("CLIENTE")) {
            Cliente cliente = new Cliente();
            cliente.setNome(nome);
            cliente.setCpf(cpf);
            cliente.setEmail(email);
            cliente.setSenha(senha);
            cliente.setTelefone(telefone);

            boolean ok = clienteService.cadastrar(cliente);
            if (!ok) {
                model.addAttribute("erro", "Email ou CPF já cadastrado.");
                return "auth/cadastro";
            }
        } else {
            Vendedor vendedor = new Vendedor();
            vendedor.setNome(nome);
            vendedor.setCpf(cpf);
            vendedor.setEmail(email);
            vendedor.setSenha(senha);
            vendedor.setTelefone(telefone);

            boolean ok = vendedorService.cadastrar(vendedor);
            if (!ok) {
                model.addAttribute("erro", "Email ou CPF já cadastrado.");
                return "auth/cadastro";
            }
        }

        return "redirect:/login";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}