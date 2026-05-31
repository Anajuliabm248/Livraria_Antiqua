<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Dashboard</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
<c:set var="activeNav" value="dashboard" scope="request" />
<jsp:include page="/WEB-INF/pages/included/navbar.jsp" />

<main class="page-wrap py-4">
    <div class="page-head">
        <div>
            <p class="section-kicker">Vendedor</p>
            <h1 class="page-title">Gestão de acervo</h1>
            <p class="page-subtitle">Um painel enxuto para olhar estoque, catálogo e vendas.</p>
        </div>
    </div>

    <div class="metric-grid">
        <section class="surface metric-card">
            <div>
                <span class="metric-label">Total de vendas</span>
                <div class="metric-value">${totalVendas}</div>
            </div>
            <div class="metric-note">Resumo do desempenho comercial.</div>
        </section>

        <section class="surface metric-card">
            <div>
                <span class="metric-label">Total de livros cadastrados</span>
                <div class="metric-value">${totalLivros}</div>
            </div>
            <div class="metric-note">Tudo o que já está no acervo.</div>
        </section>

        <section class="quote-card">
            <p>“Ler é viajar sem sair do lugar.”</p>
            <small>Mario Quintana</small>
        </section>
    </div>

    <section class="surface panel mt-4">
        <div class="d-flex align-items-center justify-content-between flex-wrap gap-3">
            <div>
                <p class="section-kicker mb-1">Atalhos</p>
                <h2 class="section-title h3 mb-0">Próximas ações</h2>
            </div>
            <div class="d-flex gap-2 flex-wrap">
                <a href="${pageContext.request.contextPath}/livro?acao=novo" class="btn btn-brand">Cadastrar livro</a>
                <a href="${pageContext.request.contextPath}/vendedor?acao=estoque" class="btn btn-ghost">Gerenciar estoque</a>
                <a href="${pageContext.request.contextPath}/vendedor?acao=relatorio" class="btn btn-ghost">Ver relatórios</a>
            </div>
        </div>
    </section>
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>
