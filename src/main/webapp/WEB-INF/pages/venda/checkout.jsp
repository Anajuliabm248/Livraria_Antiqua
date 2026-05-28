<!-- templates/venda/checkout.html -->
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head><title>Checkout</title></head>
<body>

<div th:replace="fragments/navbar :: navbar"></div>

<h1>Confirmar Pedido</h1>

<table>
    <thead>
        <tr>
            <th>Livro</th>
            <th>Qtd</th>
            <th>Subtotal</th>
        </tr>
    </thead>
    <tbody>
        <tr th:each="item, stat : ${itens}">
            <td th:text="${livros[stat.index].nome}"></td>
            <td th:text="${item.quantidade}"></td>
            <td th:text="${'R$ ' + item.subtotal}"></td>
        </tr>
    </tbody>
</table>

<p th:text="${'Total: R$ ' + carrinho.valorTotal}"></p>

<form method="post" action="/venda/confirmar">
    <label>Forma de Pagamento</label>
    <select name="formaPagamento">
        <option value="PIX">PIX</option>
        <option value="CARTAO">Cartão</option>
        <option value="BOLETO">Boleto</option>
    </select>

    <button type="submit">Confirmar Compra</button>
</form>

<a href="/carrinho">Voltar ao Carrinho</a>

</body>
</html>