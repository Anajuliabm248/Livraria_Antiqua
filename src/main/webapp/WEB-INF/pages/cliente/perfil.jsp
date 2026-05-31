
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Perfil</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
<c:set var="activeNav" value="perfil" scope="request" />
<jsp:include page="/WEB-INF/pages/included/navbar.jsp" />

<main class="page-wrap py-4">
    <div class="page-head">
        <div>
            <p class="section-kicker">Conta</p>
            <h1 class="page-title">Meu perfil</h1>
            <p class="page-subtitle">Atualize nome, telefone e e-mail.</p>
        </div>
    </div>

    <div class="detail-layout">
        <section class="surface panel">
            <c:if test="${param.msg != null}">
                <div class="alert-soft mb-3">Dados atualizados com sucesso.</div>
            </c:if>

            <form method="post" action="${pageContext.request.contextPath}/cliente">
                <div class="mb-3">
                    <label for="nome" class="form-label">Nome</label>
                    <input type="text" class="form-control" id="nome" name="nome" value="${cliente.nome}" required>
                </div>

                <div class="mb-3">
                    <label for="telefone" class="form-label">Telefone</label>
                    <input type="text" class="form-control" id="telefone" name="telefone" value="${cliente.telefone}">
                </div>

                <div class="mb-3">
                    <label for="email" class="form-label">E-mail</label>
                    <input type="email" class="form-control" id="email" name="email" value="${cliente.email}" required>
                </div>

                <button type="submit" class="btn btn-brand">Salvar</button>
            </form>
        </section>

        <aside class="surface summary-card">
            <p class="section-kicker">Atalhos</p>
            <h2 class="section-title h3 mb-3">Endereço</h2>
            <p class="muted">Mantenha seus dados de entrega prontos para o próximo checkout.</p>
            <a class="btn btn-ghost w-100 mt-3" href="${pageContext.request.contextPath}/cliente?acao=endereco">
                <i class="bi bi-geo-alt me-2"></i> Gerenciar endereço
            </a>
        </aside>
    </div>
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>
