<!-- templates/cliente/endereco.html -->
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head><title>Endereço</title></head>
<body>

<div th:replace="fragments/navbar :: navbar"></div>

<h1>Meu Endereço</h1>

<form method="post" action="/cliente/endereco">
    <label>CEP</label>
    <input type="text" name="cep" th:value="${endereco?.cep}" required />

    <label>Logradouro</label>
    <input type="text" name="logradouro" th:value="${endereco?.logradouro}" required />

    <label>Número</label>
    <input type="number" name="numero" th:value="${endereco?.numero}" required />

    <label>Complemento</label>
    <input type="text" name="complemento" th:value="${endereco?.complemento}" />

    <label>Bairro</label>
    <input type="text" name="bairro" th:value="${endereco?.bairro}" required />

    <label>Cidade</label>
    <input type="text" name="cidade" th:value="${endereco?.cidade}" required />

    <label>Estado</label>
    <input type="text" name="estado" th:value="${endereco?.estado}" maxlength="2" required />

    <button type="submit">Salvar Endereço</button>
</form>

</body>
</html>