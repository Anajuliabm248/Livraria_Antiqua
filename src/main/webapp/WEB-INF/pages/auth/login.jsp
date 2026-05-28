<!-- templates/auth/login.html -->
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head><title>Login</title></head>
<body>

<div th:replace="fragments/navbar :: navbar"></div>

<h1>Entrar</h1>

<p th:if="${erro}" th:text="${erro}"></p>

<form method="post" action="/login">
    <label>Email</label>
    <input type="email" name="email" required />

    <label>Senha</label>
    <input type="password" name="senha" required />

    <button type="submit">Entrar</button>
</form>

<a href="/cadastro">Não tem conta? Cadastre-se</a>

</body>
</html>