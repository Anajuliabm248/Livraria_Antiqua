<!-- templates/venda/confirmacao.html -->
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head><title>Pedido Confirmado</title></head>
<body>

<div th:replace="fragments/navbar :: navbar"></div>

<h1>Pedido Confirmado!</h1>

<p th:text="${'Pedido #' + venda.id}"></p>
<p th:text="${'Data: ' + venda.dtVenda}"></p>
<p th:text="${'Status: ' + venda.status}"></p>

<table>
    <thead>
        <tr>
            <th>Livro</th>
            <th>Qtd</th>
            <th>Preço Unit.</th>
            <th>Subtotal</th>
        </tr>
    </thead>
    <tbody>
        <tr th:each="item, stat : ${itens}">
            <td th:text="${livros[stat.index].nome}"></td>
            <td th:text="${item.quantidade}"></td>
            <td th:text="${'R$ ' + item.precoUni}"></td>
            <td th:text="${'R$ ' + item.subtotal}"></td>
        </tr>
    </tbody>
</table>

<p th:text="${'Total pago: R$ ' + venda.valorTotal}"></p>

<a href="/livros">Continuar comprando</a>

</body>
</html>