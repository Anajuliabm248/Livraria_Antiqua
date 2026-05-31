
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Carrinho</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
<c:set var="activeNav" value="carrinho" scope="request" />
<jsp:include page="/WEB-INF/pages/included/navbar.jsp" />

<main class="page-wrap py-4">
    <div class="page-head">
        <div>
            <p class="section-kicker">Compra</p>
            <h1 class="page-title">Seu carrinho</h1>
            <p class="page-subtitle">Revise os itens antes de seguir para o ritual do checkout.</p>
        </div>
    </div>

    <c:if test="${empty itens}">
        <div class="empty-state">
            Seu carrinho está vazio. A estante está esperando um primeiro escolhido.
            <div class="mt-3">
                <a href="${pageContext.request.contextPath}/livro" class="btn btn-brand">Ver livros</a>
            </div>
        </div>
    </c:if>

    <c:if test="${not empty itens}">
        <div class="cart-layout">
            <section class="surface panel">
                <c:forEach var="item" items="${itens}" varStatus="s">
                    <article class="cart-item">
                        <div class="cart-thumb">
                            <c:choose>
                                <c:when test="${not empty livros[s.index].imgCapa}">
                                    <img src="${pageContext.request.contextPath}/uploads/${livros[s.index].imgCapa}" alt="${livros[s.index].nome}">
                                </c:when>
                                <c:otherwise>
                                    <div class="empty-state h-100 rounded-0 d-flex align-items-center justify-content-center">Sem capa</div>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <div class="cart-info">
                            <h3 class="book-card__title">${livros[s.index].nome}</h3>
                            <p class="author">${livros[s.index].autor}</p>
                            <div class="price">R$ ${item.subtotal}</div>
                        </div>

                        <div class="cart-actions">
                            <form method="post" action="${pageContext.request.contextPath}/carrinho" class="d-flex justify-content-end">
                                <input type="hidden" name="acao" value="remover" />
                                <input type="hidden" name="itemId" value="${item.id}" />
                                <button type="submit" class="btn btn-soft-danger">
                                    <i class="bi bi-trash3 me-1"></i> Excluir
                                </button>
                            </form>
                        </div>
                    </article>
                </c:forEach>

                <div class="mt-4">
                    <a href="${pageContext.request.contextPath}/livro" class="btn btn-ghost">
                        <i class="bi bi-arrow-left me-2"></i> Continuar comprando
                    </a>
                </div>
            </section>

            <aside class="surface summary-card">
                <p class="section-kicker">Resumo do pedido</p>
                <h2 class="section-title h3 mb-3">Resumo do pedido</h2>

                <div class="summary-row">
                    <span>Itens no carrinho</span>
                    <strong>${itens.size()}</strong>
                </div>
                <div class="summary-row">
                    <span>Frete</span>
                    <strong class="text-success">Grátis</strong>
                </div>

                <div class="summary-total">
                    <span>Total</span>
                    <strong>R$ ${carrinho.valorTotal}</strong>
                </div>

                <a class="btn btn-brand w-100 mt-4" href="${pageContext.request.contextPath}/venda?acao=checkout">
                    Finalizar compra
                </a>

                <a class="btn btn-ghost w-100 mt-3" href="${pageContext.request.contextPath}/livro">
                    Cancelar pedido
                </a>

                <div class="text-center mt-4 muted small">
                    <i class="bi bi-shield-lock me-1"></i> Pagamento seguro
                </div>
            </aside>
        </div>
    </c:if>
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>
