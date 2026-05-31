<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Catálogo</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
<c:set var="activeNav" value="catalogo" scope="request" />
<jsp:include page="/WEB-INF/pages/included/navbar.jsp" />

<main class="page-wrap pb-5">
    <section class="hero-banner mt-4">
        <p class="section-kicker text-white-50">Home</p>
        <h1 class="page-title text-white">Catálogo de livros</h1>
        <p class="page-subtitle">Navegue por obras, autores e categorias diretamente do aconchego de seu lar.</p>

        <div class="hero-actions mt-4">
            <a class="btn btn-brand" href="#acervo">
                <i class="bi bi-book-half me-2"></i> Ver acervo
            </a>
            <a class="btn btn-ghost text-white border-white" href="${pageContext.request.contextPath}/carrinho">
                <i class="bi bi-cart3 me-2"></i> Ir ao carrinho
            </a>
        </div>
    </section>

    <section class="surface search-panel mt-4">
        <form method="get" action="${pageContext.request.contextPath}/livro" class="search-bar">
            <div class="position-relative">
                <input type="text" name="busca" class="form-control" placeholder="Buscar por título..." value="${param.busca}">
            </div>

            <select name="categoriaId" class="form-select">
                <option value="">Todas as categorias</option>
                <c:forEach var="cat" items="${categorias}">
                    <option value="${cat.id}" <c:if test="${param.categoriaId == cat.id}">selected</c:if>>${cat.nome}</option>
                </c:forEach>
            </select>

            <button type="submit" class="btn btn-brand">
                <i class="bi bi-search me-1"></i> Buscar
            </button>
        </form>
    </section>

    <section class="mt-4" id="acervo">
        <div class="d-flex align-items-end justify-content-between gap-3 mb-3">
            <div>
                <p class="section-kicker mb-1">Produtos</p>
                <h2 class="section-title h2 mb-0">Livros em catálogo</h2>
            </div>
        </div>

        <c:if test="${empty livros}">
            <div class="empty-state">
                Nenhum livro encontrado. A estante está de molho por enquanto.
            </div>
        </c:if>

        <div class="grid-cards mt-3">
            <c:forEach var="livro" items="${livros}">
                <article class="book-card">
                    <div class="book-card__cover">
                        <c:choose>
                            <c:when test="${not empty livro.imgCapa}">
                                <img src="${pageContext.request.contextPath}/uploads/${livro.imgCapa}" alt="${livro.nome}">
                            </c:when>
                            <c:otherwise>
                                <div class="text-center px-3">
                                    <i class="bi bi-image fs-1 text-secondary"></i>
                                    <div class="muted mt-2">Sem capa</div>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="book-card__body">
                        <div>
                            <h3 class="book-card__title">${livro.nome}</h3>
                            <div class="book-card__meta">${livro.autor}</div>
                        </div>

                        <div class="book-card__footer">
                            <div>
                                <div class="price">R$ ${livro.preco}</div>
                                <div class="stock">Estoque: ${livro.quantidade}</div>
                            </div>

                            <a class="card-action" href="${pageContext.request.contextPath}/livro?acao=detalhe&id=${livro.id}" title="Ver detalhes">
                                <i class="bi bi-arrow-right"></i>
                            </a>
                        </div>
                    </div>
                </article>
            </c:forEach>
        </div>
    </section>
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>
