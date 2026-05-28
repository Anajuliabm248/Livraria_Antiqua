<!-- templates/livro/lista.html -->
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head><title>Livros</title></head>
<body>

<div th:replace="fragments/navbar :: navbar"></div>

<h1>Catálogo</h1>

<form method="get" action="/livros">
    <input type="text" name="nome" placeholder="Buscar por título..." />
    <select name="categoriaId">
        <option value="">Todas as categorias</option>
        <option th:each="cat : ${categorias}"
                th:value="${cat.id}"
                th:text="${cat.nome}"></option>
    </select>
    <button type="submit">Buscar</button>
</form>

<div th:if="${livros.isEmpty()}">
    <p>Nenhum livro encontrado.</p>
</div>

<div th:each="livro : ${livros}">
    <h3 th:text="${livro.nome}"></h3>
    <p th:text="${livro.autor}"></p>
    <p th:text="${'R$ ' + livro.preco}"></p>
    <p th:text="${'Estoque: ' + livro.quantidade}"></p>
    <a th:href="@{/livros/{id}(id=${livro.id})}">Ver detalhes</a>
</div>

</body>
</html>