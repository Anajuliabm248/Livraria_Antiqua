<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>
        <c:choose>
            <c:when test="${livro != null}">Editar Livro</c:when>
            <c:otherwise>Adicionar novo livro</c:otherwise>
        </c:choose>
    </title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/form_livro.css">
</head>
<body>
<c:set var="activeNav" value="novo_livro" scope="request" />
<jsp:include page="/WEB-INF/pages/included/navbar.jsp" />

<main class="livro-container">
    <header class="livro-head">
        <div>
            <p class="section-kicker">Cadastro</p>
            <h1 class="page-title">
                <c:choose>
                    <c:when test="${livro != null}">Editar livro</c:when>
                    <c:otherwise>Adicionar novo livro</c:otherwise>
                </c:choose>
            </h1>
            <p class="page-subtitle">Organize aqui a obra.</p>
        </div>
        <small class="muted">* indica campo obrigatório</small>
    </header>

    <form method="post" action="${pageContext.request.contextPath}/livro" enctype="multipart/form-data" class="livro-form-card">
        <input type="hidden" name="id" value="${livro.id}" />

        <div class="livro-grid">
            <aside class="cover-column">
                <label class="field-label">Capa do livro</label>

                <div class="cover-preview">
                    <c:choose>
                        <c:when test="${not empty livro.imgCapa}">
                            <img src="${pageContext.request.contextPath}/uploads/${livro.imgCapa}" alt="Capa do livro">
                        </c:when>
                        <c:otherwise>
                            <div class="cover-placeholder">Sem capa</div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <div class="cover-hint">selecione uma imagem para a capa.</div>

                <label for="imagem" class="upload-btn">
                    <i class="bi bi-upload"></i> Faça upload de um arquivo
                </label>
                <input type="file" id="imagem" name="imgCapa" accept="image/*" class="d-none">
            </aside>

            <section class="form-card surface">
                <div class="form-section">
                    <div class="row g-2">
                        <div class="col-12">
                            <label for="nome" class="field-label">Nome do livro*</label>
                            <input type="text" class="form-control field-input" id="nome" name="nome" value="${livro.nome}" required>
                        </div>

                        <div class="col-md-7">
                            <label for="autor" class="field-label">Autor*</label>
                            <input type="text" class="form-control field-input" id="autor" name="autor" value="${livro.autor}" required>
                        </div>

                        <div class="col-md-5">
                            <label for="categoriaId" class="field-label">Gênero*</label>
                            <select name="categoriaId" id="categoriaId" class="form-select field-input" required>
                                <option value="">Selecione</option>
                                <c:forEach var="cat" items="${categorias}">
                                    <option value="${cat.id}" <c:if test="${livro != null and livro.categoriaId == cat.id}">selected</c:if>>
                                        ${cat.nome}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                </div>

                <div class="form-section">
                    <div class="row g-2">
                        <div class="col-md-3">
                            <label for="numPagina" class="field-label">Número de páginas*</label>
                            <input type="number" class="form-control field-input" id="numPagina" name="numPagina" value="${livro.numPagina}" min="1" required>
                        </div>

                        <div class="col-md-3">
                            <label for="anoLancamento" class="field-label">Ano de lançamento*</label>
                            <input type="number" class="form-control field-input" id="anoLancamento" name="anoLancamento" value="${livro.anoLancamento}" min="0" required>
                        </div>

                        <div class="col-md-6">
                            <label for="isbn" class="field-label">ISBN*</label>
                            <input type="text" class="form-control field-input" id="isbn" name="isbn" value="${livro.isbn}" required>
                        </div>
                    </div>
                </div>

                <div class="form-section">
                    <label for="descricao" class="field-label">Descrição*</label>
                    <textarea class="form-control field-input field-textarea" id="descricao" name="descricao" rows="6" required>${livro.descricao}</textarea>
                </div>

                <div class="form-section">
                    <div class="row g-2">
                        <div class="col-md-6">
                            <label for="preco" class="field-label">Preço (R$)*</label>
                            <input type="number" class="form-control field-input" id="preco" step="0.01" min="0" name="preco" value="${livro.preco}" required>
                        </div>

                        <div class="col-md-6">
                            <label for="quantidade" class="field-label">Quantidade em estoque*</label>
                            <input type="number" class="form-control field-input" id="quantidade" name="quantidade" value="${livro.quantidade}" min="0" required>
                        </div>
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn btn-brand">
                            <i class="bi bi-floppy me-2"></i> Salvar produto
                        </button>
                        <a href="${pageContext.request.contextPath}/vendedor?acao=estoque" class="btn btn-ghost">
                            Cancelar
                        </a>
                    </div>
                </div>
            </section>
        </div>
    </form>
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script>
    const inputImagem = document.getElementById('imagem');
    const preview = document.querySelector('.cover-preview');

    inputImagem.addEventListener('change', function () {
        const file = this.files && this.files[0];
        if (!file) return;

        const reader = new FileReader();
        reader.onload = function (e) {
            preview.innerHTML = `<img src="${e.target.result}" alt="Prévia da capa">`;
        };
        reader.readAsDataURL(file);
    });
</script>
</body>
</html>
