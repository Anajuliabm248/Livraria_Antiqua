<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>${livro.nome}</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
<c:set var="activeNav" value="catalogo" scope="request" />
<jsp:include page="/WEB-INF/pages/included/navbar.jsp" />

<main class="page-wrap py-4">
    <div class="page-head">
        <div>
            <p class="section-kicker">Produto</p>
            <h1 class="page-title">${livro.nome}</h1>
            <p class="page-subtitle">Detalhes da obra.</p>
        </div>
    </div>

    <div class="detail-layout">
        <div class="detail-cover">
            <c:choose>
                <c:when test="${not empty livro.imgCapa}">
                    <img src="${pageContext.request.contextPath}/uploads/${livro.imgCapa}" alt="${livro.nome}">
                </c:when>
                <c:otherwise>
                    <div class="empty-state rounded-0 h-100 d-flex align-items-center justify-content-center">
                        Sem capa disponível
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <section class="surface detail-panel">
            <p class="section-kicker">Informações</p>
            <h2 class="section-title h2 mb-2">${livro.nome}</h2>
            <p class="muted mb-3">${livro.autor}</p>

            <div class="detail-meta">
                <div class="meta-box">
                    <span class="label">Categoria</span>
                    <span class="value">${categoria.nome}</span>
                </div>
                <div class="meta-box">
                    <span class="label">ISBN</span>
                    <span class="value">${livro.isbn}</span>
                </div>
                <div class="meta-box">
                    <span class="label">Páginas</span>
                    <span class="value">${livro.numPagina}</span>
                </div>
                <div class="meta-box">
                    <span class="label">Ano</span>
                    <span class="value">${livro.anoLancamento}</span>
                </div>
                <div class="meta-box">
                    <span class="label">Preço</span>
                    <span class="value">R$ ${livro.preco}</span>
                </div>
                <div class="meta-box">
                    <span class="label">Estoque</span>
                    <span class="value">${livro.quantidade}</span>
                </div>
            </div>

            <div class="mt-4">
                <p class="section-kicker">Descrição</p>
                <p>${livro.descricao}</p>
            </div>

            <c:if test="${not empty erro}">
                <div class="alert-soft mt-3 text-danger">${erro}</div>
            </c:if>

            <div class="divider"></div>

            <c:if test="${sessionScope.usuario != null and sessionScope.usuario.tipo == 'CLIENTE'}">
                <c:choose>
                    <c:when test="${livro.quantidade > 0}">
                        <form method="post" action="${pageContext.request.contextPath}/carrinho" class="row g-3 align-items-end">
                            <input type="hidden" name="acao" value="adicionar" />
                            <input type="hidden" name="livroId" value="${livro.id}" />

                            <div class="col-sm-4">
                                <label class="form-label" for="quantidade">Quantidade</label>
                                <input id="quantidade" type="number" name="quantidade" value="1" min="1" max="${livro.quantidade}" class="form-control">
                            </div>

                            <div class="col-sm-8 d-flex gap-2 flex-wrap">
                                <button type="submit" class="btn btn-brand">
                                    <i class="bi bi-cart-plus me-2"></i> Adicionar ao carrinho
                                </button>
                                <a href="${pageContext.request.contextPath}/livro" class="btn btn-ghost">
                                    Voltar ao catálogo
                                </a>
                            </div>
                        </form>
                    </c:when>
                    <c:otherwise>
                        <div class="alert-soft">Produto indisponível no momento.</div>
                        <a href="${pageContext.request.contextPath}/livro" class="btn btn-ghost mt-3">Voltar ao catálogo</a>
                    </c:otherwise>
                </c:choose>
            </c:if>

            <c:if test="${sessionScope.usuario == null}">
                <div class="surface-soft p-3 mt-3">
                    <p class="mb-2">Faça login para levar este livro para casa.</p>
                    <a href="${pageContext.request.contextPath}/login" class="btn btn-brand">Entrar</a>
                </div>
            </c:if>
        </section>
    </div>
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>
