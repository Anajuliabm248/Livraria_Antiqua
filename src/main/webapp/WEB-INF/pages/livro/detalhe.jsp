<!-- templates/livro/detalhe.html -->
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head><title th:text="${livro.nome}"></title></head>
<body>

<div th:replace="fragments/navbar :: navbar"></div>

<a href="/livros">Voltar</a>

<h1 th:text="${livro.nome}"></h1>
<p th:text="${'Autor: ' + livro.autor}"></p>
<p th:text="${'Categoria: ' + categoria.nome}"></p>
<p th:text="${'ISBN: ' + livro.isbn}"></p>
<p th:text="${'Páginas: ' + livro.numPagina}"></p>
<p th:text="${'Ano: ' + livro.anoLancamento}"></p>
<p th:text="${livro.descricao}"></p>
<p th:text="${'R$ ' + livro.preco}"></p>
<p th:text="${'Estoque: ' + livro.quantidade}"></p>

<p th:if="${erro}" th:text="${erro}"></p>

<form th:if="${session.usuarioLogado != null and session.usuarioLogado.tipo == 'CLIENTE'}"
      method="post" action="/carrinho/adicionar">
    <input type="hidden" name="livroId" th:value="${livro.id}" />
    <input type="number" name="quantidade" value="1" min="1" th:max="${livro.quantidade}" />
    <button type="submit">Adicionar ao Carrinho</button>
</form>

</body>
</html>