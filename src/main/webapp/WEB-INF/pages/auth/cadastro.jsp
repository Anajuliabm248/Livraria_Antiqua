<!-- templates/auth/cadastro.html -->
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head><title>Cadastro</title></head>
<body>

<div th:replace="fragments/navbar :: navbar"></div>

<h1>Criar Conta</h1>

<p th:if="${erro}" th:text="${erro}"></p>

<form method="post" action="/cadastro">
    <label>Nome</label>
    <input type="text" name="nome" required />

    <label>CPF</label>
    <input type="text" name="cpf" required />

    <label>Email</label>
    <input type="email" name="email" required />

    <label>Telefone</label>
    <input type="text" name="telefone" />

    <label>Senha</label>
    <input type="password" name="senha" required />

    <label>Tipo de conta</label>
    <select name="tipo">
        <option value="CLIENTE">Cliente</option>
        <option value="VENDEDOR">Vendedor</option>
    </select>

    <button type="submit">Cadastrar</button>
</form>

</body>
</html>