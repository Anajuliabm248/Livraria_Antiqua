<!-- templates/fragments/navbar.html -->
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<body>
<nav th:fragment="navbar">
    <a href="/livros">Livros</a>

    <span th:if="${session.usuarioLogado == null}">
        <a href="/login">Entrar</a>
        <a href="/cadastro">Cadastrar</a>
    </span>

    <span th:if="${session.usuarioLogado != null and session.usuarioLogado.tipo == 'CLIENTE'}">
        <span th:text="${session.usuarioLogado.nome}"></span>
        <a href="/carrinho">Carrinho</a>
        <a href="/venda/historico">Meus Pedidos</a>
        <a href="/cliente/perfil">Perfil</a>
        <a href="/logout">Sair</a>
    </span>

    <span th:if="${session.usuarioLogado != null and session.usuarioLogado.tipo == 'VENDEDOR'}">
        <span th:text="${session.usuarioLogado.nome}"></span>
        <a href="/vendedor/dashboard">Dashboard</a>
        <a href="/vendedor/estoque">Estoque</a>
        <a href="/vendedor/relatorio">Relatório</a>
        <a href="/logout">Sair</a>
    </span>
</nav>
</body>
</html>