<!-- templates/vendedor/relatorio.html -->
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head><title>Relatório de Vendas</title></head>
<body>

<div th:replace="fragments/navbar :: navbar"></div>

<h1>Relatório de Vendas</h1>

<p th:text="${'Total geral: R$ ' + totalGeral}"></p>

<table>
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
        <tr th:each="venda : ${vendas}">
            <td th:text="${'#' + venda.id}"></td>
            <td th:text="${venda.dtVenda}"></td>
            <td th:text="${venda.clienteId}"></td>
            <td th:text="${'R$ ' + venda.valorTotal}"></td>
            <td th:text="${venda.status}"></td>
        </tr>
    </tbody>
</table>

</body>
</html>