<!-- templates/vendedor/estoque.html -->
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head><title>Estoque</title></head>
<body>

<div th:replace="fragments/navbar :: navbar"></div>

<h1>Gerenciar Estoque</h1>

<a href="/livros/novo">Novo Livro</a>

<table>
    <thead>
        <tr>
            <th>Título</th>
            <th>Autor</th>
            <th>Preço</th>
            <th>Estoque</th>
            <th>Ações</th>
        </tr>
    </thead>
    <tbody>
        <tr th:each="livro : ${livros}">
            <td th:text="${livro.nome}"></td>
            <td th:text="${livro.autor}"></td>
            <td th:text="${'R$ ' + livro.preco}"></td>
            <td th:text="${livro.quantidade}"></td>
            <td>
                <a th:href="@{/livros/{id}/editar(id=${livro.id})}">Editar</a>
                <form method="post"
                      th:action="@{/livros/{id}/excluir(id=${livro.id})}"
                      style="display:inline">
                    <button type="submit">Excluir</button>
                </form>
            </td>
        </tr>
    </tbody>
</table>

</body>
</html>