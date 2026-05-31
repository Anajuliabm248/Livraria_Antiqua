<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Estoque</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
<c:set var="activeNav" value="estoque" scope="request" />
<jsp:include page="/WEB-INF/pages/included/navbar.jsp" />

<main class="page-wrap py-4">
    <div class="page-head">
        <div>
            <p class="section-kicker">Acervo</p>
            <h1 class="page-title">Gestão de estoque</h1>
            <p class="page-subtitle">Livros cadastrados, quantidade, preço e edição em um clique.</p>
        </div>
    </div>

    <c:if test="${msg == 'salvo'}">
        <div class="alert-soft mb-3">Livro cadastrado com sucesso.</div>
    </c:if>
    <c:if test="${msg == 'editado'}">
        <div class="alert-soft mb-3">Livro atualizado com sucesso.</div>
    </c:if>
    <c:if test="${msg == 'excluido'}">
        <div class="alert-soft mb-3">Livro excluído.</div>
    </c:if>
    <c:if test="${msg == 'negado'}">
        <div class="alert-soft mb-3">Operação não permitida: este livro não pertence à sua conta.</div>
    </c:if>

    <section class="surface panel">
        <div class="d-flex justify-content-between align-items-center flex-wrap gap-3 mb-3">
            <div>
                <p class="section-kicker mb-1">Lista</p>
                <h2 class="section-title h3 mb-0">Livros cadastrados</h2>
            </div>
            <a href="${pageContext.request.contextPath}/livro?acao=novo" class="btn btn-brand">
                <i class="bi bi-plus-circle me-2"></i> Novo livro
            </a>
        </div>

        <div class="table-shell">
            <table class="table">
                <thead>
                    <tr>
                        <th>Título</th>
                        <th>Autor</th>
                        <th>Preço</th>
                        <th>Estoque</th>
                        <th>Ações</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="livro" items="${livros}">
                        <tr>
                            <td>${livro.nome}</td>
                            <td>${livro.autor}</td>
                            <td>R$ ${livro.preco}</td>
                            <td>${livro.quantidade}</td>
                            <td>
                                <div class="d-flex gap-2 flex-wrap">
                                    <a href="${pageContext.request.contextPath}/livro?acao=editar&id=${livro.id}" class="btn btn-soft-outline btn-sm">Editar</a>
                                    <a href="${pageContext.request.contextPath}/livro?acao=excluir&id=${livro.id}" class="btn btn-soft-danger btn-sm" onclick="return confirm('Excluir este livro?')">Excluir</a>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty livros}">
                        <tr>
                            <td colspan="5" class="text-center muted py-4">Nenhum livro cadastrado ainda.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </section>
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>
