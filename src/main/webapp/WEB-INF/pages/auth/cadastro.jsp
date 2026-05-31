
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Cadastro</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth.css">
</head>
<body>
<jsp:include page="/WEB-INF/pages/included/navbar_auth.jsp" />

<main class="auth-shell">
    <section class="auth-card auth-card-full">
        <div class="auth-form">
            <p class="section-kicker">Cadastro</p>
            <h2>Criar conta</h2>
            <p class="lead">Preencha seus dados para começar a usar a plataforma.</p>

            <c:if test="${not empty erro}">
                <div class="auth-alert text-danger">
                    ${erro}
                </div>
            </c:if>

            <form method="post" action="${pageContext.request.contextPath}/cadastro">
                <div class="row">
                    <div class="col">
                        <label for="nome" class="form-label">Nome</label>
                        <input type="text" class="form-control" id="nome" name="nome" required placeholder="Digite seu nome completo">
                    </div>

                    <div class="col">
                        <label for="cpf" class="form-label">CPF</label>
                        <input type="text" class="form-control" id="cpf" name="cpf" required placeholder="Digite seu CPF">
                    </div>
                </div>

                <div class="row">
                    <div class="col">
                        <label for="email" class="form-label">E-mail</label>
                        <input type="email" class="form-control" id="email" name="email" required placeholder="Digite seu e-mail">
                    </div>

                    <div class="col">
                        <label for="telefone" class="form-label">Telefone</label>
                        <input type="text" class="form-control" id="telefone" name="telefone" placeholder="Digite seu telefone (opcional)">
                    </div>
                </div>

                <div class="mb-3">
                    <label for="senha" class="form-label">Senha</label>
                    <input type="password" class="form-control" id="senha" name="senha" required placeholder="Crie uma senha segura">
                </div>

                <div class="mb-3">
                    <label for="tipo" class="form-label">Tipo de conta</label>
                    <select id="tipo" name="tipo" class="form-select">
                        <option value="CLIENTE" selected>Cliente</option>
                        <option value="VENDEDOR">Vendedor</option>
                    </select>
                </div>

                <button type="submit" class="btn btn-brand">Criar conta</button>

                <div class="auth-foot">
                    <a class="auth-link" href="${pageContext.request.contextPath}/login">Já tem conta? Entrar</a>
                </div>
            </form>
        </div>
    </section>
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>
