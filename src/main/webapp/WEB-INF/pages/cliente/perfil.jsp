<!-- templates/cliente/perfil.html -->
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head><title>Perfil</title></head>
<body>

<div th:replace="fragments/navbar :: navbar"></div>

<h1>Meu Perfil</h1>

<form method="post" action="/cliente/perfil">
    <label>Nome</label>
    <input type="text" name="nome" th:value="${cliente.nome}" required />

    <label>Telefone</label>
    <input type="text" name="telefone" th:value="${cliente.telefone}" />

    <label>Email</label>
    <input type="email" name="email" th:value="${cliente.email}" required />

    <button type="submit">Salvar</button>
</form>

<a href="/cliente/endereco">Gerenciar Endereço</a>
<a href="/venda/historico">Meus Pedidos</a>

</body>
</html>