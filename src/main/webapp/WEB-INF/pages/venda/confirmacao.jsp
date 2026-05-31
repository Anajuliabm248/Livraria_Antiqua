<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Pedido confirmado</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
<c:set var="activeNav" value="pedidos" scope="request" />
<jsp:include page="/WEB-INF/pages/included/navbar.jsp" />

<main class="page-wrap py-4">
    <section class="hero-banner">
        <p class="section-kicker text-white-50">Sucesso</p>
        <h1 class="page-title text-white">Pedido confirmado!</h1>
        <p class="page-subtitle">Seu pedido saiu da estação com carimbo e destino certo.</p>
    </section>

    <section class="surface panel mt-4">
        <div class="row g-4">
            <div class="col-lg-4">
                <div class="meta-box h-100">
                    <span class="label">Pedido</span>
                    <span class="value">#${venda.id}</span>
                    <div class="mt-3">
                        <span class="label">Data</span>
                        <span class="value">${venda.dtVenda}</span>
                    </div>
                    <div class="mt-3">
                        <span class="label">Status</span>
                        <span class="tag tag-success">${venda.status}</span>
                    </div>
                    <div class="mt-3">
                        <span class="label">Total pago</span>
                        <span class="value">R$ ${venda.valorTotal}</span>
                    </div>
                </div>
            </div>

            <div class="col-lg-8">
                <div class="table-shell">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Livro</th>
                                <th>Qtd</th>
                                <th>Preço unit.</th>
                                <th>Subtotal</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${itens}" varStatus="s">
                                <tr>
                                    <td>${livros[s.index].nome}</td>
                                    <td>${item.quantidade}</td>
                                    <td>R$ ${item.precoUni}</td>
                                    <td>R$ ${item.subtotal}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <div class="d-flex gap-2 flex-wrap mt-4">
            <a href="${pageContext.request.contextPath}/livro" class="btn btn-brand">
                <i class="bi bi-book me-2"></i> Continuar comprando
            </a>
            <a href="${pageContext.request.contextPath}/venda?acao=historico" class="btn btn-ghost">
                Meus pedidos
            </a>
        </div>
    </section>
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>
