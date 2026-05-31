
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Meus pedidos</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
<c:set var="activeNav" value="pedidos" scope="request" />
<jsp:include page="/WEB-INF/pages/included/navbar.jsp" />

<main class="page-wrap py-4">
    <div class="page-head">
        <div>
            <p class="section-kicker">Pedidos</p>
            <h1 class="page-title">Meus pedidos</h1>
            <p class="page-subtitle">Histórico de compras.</p>
        </div>
    </div>

    <c:if test="${empty vendas}">
        <div class="empty-state">Nenhum pedido encontrado.</div>
    </c:if>

    <c:if test="${not empty vendas}">
        <div class="table-shell">
            <table class="table">
                <thead>
                    <tr>
                        <th scope="col">Pedido</th>
                        <th scope="col">Data</th>
                        <th scope="col">Total</th>
                        <th scope="col">Status</th>
                        <th scope="col">Ação</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="venda" items="${vendas}">
                        <tr>
                            <td>#${venda.id}</td>
                            <td>${venda.dtVenda}</td>
                            <td>R$ ${venda.valorTotal}</td>
                            <td><span class="tag tag-success">${venda.status}</span></td>
                            <td>
                                <c:if test="${venda.status == 'CONCLUIDA'}">
                                    <a class="btn btn-soft-danger" href="${pageContext.request.contextPath}/venda?acao=cancelar&id=${venda.id}" onclick="return confirm('Cancelar este pedido?')">Cancelar</a>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </c:if>

    <div class="mt-4">
        <a href="${pageContext.request.contextPath}/livro" class="btn btn-ghost">
            <i class="bi bi-arrow-left me-2"></i> Continuar comprando
        </a>
    </div>
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>
