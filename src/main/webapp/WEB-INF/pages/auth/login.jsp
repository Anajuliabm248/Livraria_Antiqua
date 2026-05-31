
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth.css">
</head>
<body>
<jsp:include page="/WEB-INF/pages/included/navbar_auth.jsp" />

<main class="auth-shell">
    <section class="auth-card">
        <div class="auth-hero">
            <div>
                <div class="auth-hero__mark">
                    <img src="${pageContext.request.contextPath}/img/logo_branco.png" alt="Livraria Antiqua">
                    <span class="brand-name">Livraria Antiqua</span>
                </div>
                <h1>Bem-vinda à biblioteca que veste o livro como relíquia.</h1>
                <p>Entre para continuar navegando entre páginas, capas e histórias com aquele clima de papel antigo e café recém-passado.</p>
            </div>

            <div class="auth-quote">
                <p>"Um livro é um jardim que se leva no bolso."</p>
                <small>Virginia Woolf</small>
            </div>
        </div>

        <div class="auth-form">
            <p class="section-kicker">Acesso</p>
            <h2>Entrar</h2>
            <p class="lead">Use seu e-mail e senha para voltar ao acervo.</p>

            <c:if test="${param.msg == 'cadastrado'}">
                <div class="auth-alert text-success">
                    Cadastro realizado. Agora é só entrar.
                </div>
            </c:if>

            <c:if test="${not empty erro}">
                <div class="auth-alert text-danger">
                    ${erro}
                </div>
            </c:if>

            <form method="post" action="${pageContext.request.contextPath}/login">
                <div class="mb-3">
                    <label for="email" class="form-label">E-mail</label>
                    <input type="email" class="form-control" id="email" name="email" required placeholder="Digite seu e-mail">
                </div>

                <div class="mb-3">
                    <label for="senha" class="form-label">Senha</label>
                    <input type="password" class="form-control" id="senha" name="senha" required placeholder="Digite sua senha">
                </div>

                <button type="submit" class="btn btn-brand">Entrar</button>

                <div class="auth-foot">
                    <a class="auth-link" href="${pageContext.request.contextPath}/cadastro">Não tem conta? Cadastre-se</a>
                </div>
            </form>
        </div>
    </section>
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>
