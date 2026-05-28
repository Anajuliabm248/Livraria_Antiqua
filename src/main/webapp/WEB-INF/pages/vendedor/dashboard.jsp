<!-- templates/vendedor/dashboard.html -->
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head><title>Dashboard</title></head>
<body>

<div th:replace="fragments/navbar :: navbar"></div>

<h1>Painel do Vendedor</h1>

<p th:text="${'Total de vendas realizadas: ' + totalVendas}"></p>
<p th:text="${'Total de livros cadastrados: ' + livros.size()}"></p>

<a href="/livros/novo">Cadastrar Novo Livro</a>
<a href="/vendedor/estoque">Ver Estoque</a>
<a href="/vendedor/relatorio">Relatório de Vendas</a>

</body>
</html>