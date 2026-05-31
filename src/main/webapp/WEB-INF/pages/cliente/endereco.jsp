
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Endereço</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
<c:set var="activeNav" value="endereco" scope="request" />
<jsp:include page="/WEB-INF/pages/included/navbar.jsp" />

<main class="page-wrap py-4">
    <div class="page-head">
        <div>
            <p class="section-kicker">Entrega</p>
            <h1 class="page-title">Meu endereço</h1>
            <p class="page-subtitle">Guarde aqui o destino da próxima remessa.</p>
        </div>
    </div>

    <section class="surface panel">
        <c:if test="${param.msg == 'salvo'}">
            <div class="alert-soft mb-3">Endereço salvo com sucesso.</div>
        </c:if>
        <c:if test="${param.msg == 'necessario'}">
            <div class="alert-soft mb-3">Cadastre um endereço antes de finalizar a compra.</div>
        </c:if>

        <form method="post" action="${pageContext.request.contextPath}/cliente">
            <input type="hidden" name="acao" value="endereco" />

            <div class="row g-3">
                <div class="col-md-3">
                    <label class="form-label" for="cep">CEP</label>
                    <input type="text" class="form-control" id="cep" name="cep" value="${endereco.cep}" required maxlength="9">
                </div>
                <div class="col-md-7">
                    <label class="form-label" for="logradouro">Logradouro</label>
                    <input type="text" class="form-control" id="logradouro" name="logradouro" value="${endereco.logradouro}" required>
                </div>
                <div class="col-md-2">
                    <label class="form-label" for="numero">Número</label>
                    <input type="number" class="form-control" id="numero" name="numero" value="${endereco.numero}" required min="1">
                </div>
                <div class="col-md-4">
                    <label class="form-label" for="complemento">Complemento</label>
                    <input type="text" class="form-control" id="complemento" name="complemento" value="${endereco.complemento}">
                </div>
                <div class="col-md-4">
                    <label class="form-label" for="bairro">Bairro</label>
                    <input type="text" class="form-control" id="bairro" name="bairro" value="${endereco.bairro}" required>
                </div>
                <div class="col-md-3">
                    <label class="form-label" for="cidade">Cidade</label>
                    <input type="text" class="form-control" id="cidade" name="cidade" value="${endereco.cidade}" required>
                </div>
                <div class="col-md-1">
                    <label class="form-label" for="estado">UF</label>
                    <input type="text" class="form-control text-uppercase" id="estado" name="estado" value="${endereco.estado}" maxlength="2" required>
                </div>
            </div>

            <div class="d-flex gap-2 flex-wrap mt-4">
                <button type="submit" class="btn btn-brand">Salvar endereço</button>
                <a href="${pageContext.request.contextPath}/cliente" class="btn btn-ghost">Voltar ao perfil</a>
            </div>
        </form>
    </section>
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>
