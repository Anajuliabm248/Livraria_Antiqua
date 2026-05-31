<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Relatório de vendas</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
<c:set var="activeNav" value="relatorio" scope="request" />
<jsp:include page="/WEB-INF/pages/included/navbar.jsp" />

<main class="page-wrap py-4">
    <div class="page-head">
        <div>
            <p class="section-kicker">Vendas</p>
            <h1 class="page-title">Relatório de vendas</h1>
            <p class="page-subtitle">Uma visão enxuta da movimentação da loja.</p>
        </div>
    </div>

    <div class="metric-grid mb-4">
        <section class="surface metric-card">
            <div>
                <span class="metric-label">Total geral</span>
                <div class="metric-value">R$ ${totalGeral}</div>
            </div>
            <div class="metric-note">Somatório de vendas registradas.</div>
        </section>
    </div>

    <section class="surface panel">
        <div class="table-shell">
            <table class="table">
                <thead>
                    <tr>
                        <th>Pedido</th>
                        <th>Data</th>
                        <th>Cliente ID</th>
                        <th>Total</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="venda" items="${vendas}">
                        <tr>
                            <td>#${venda.id}</td>
                            <td>${venda.dtVenda}</td>
                            <td>${venda.clienteId}</td>
                            <td>R$ ${venda.valorTotal}</td>
                            <td><span class="tag tag-success">${venda.status}</span></td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty vendas}">
                        <tr>
                            <td colspan="5" class="text-center muted py-4">Nenhuma venda registrada.</td>
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
