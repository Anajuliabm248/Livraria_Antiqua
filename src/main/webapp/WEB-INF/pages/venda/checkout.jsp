<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Checkout</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
<c:set var="activeNav" value="carrinho" scope="request" />
<jsp:include page="/WEB-INF/pages/included/navbar.jsp" />

<main class="page-wrap py-4">
    <div class="page-head">
        <div>
            <p class="section-kicker">Checkout</p>
            <h1 class="page-title">Confirmar pedido</h1>
            <p class="page-subtitle">Confere endereço, itens e forma de pagamento antes de fechar o pacote.</p>
        </div>
    </div>

    <div class="cart-layout">
        <section class="surface panel">
            <div class="surface-soft p-4 mb-4">
                <p class="section-kicker">Endereço de entrega</p>
                <p class="mb-1">${endereco.logradouro}, ${endereco.numero}
                    <c:if test="${not empty endereco.complemento}"> - ${endereco.complemento}</c:if>
                </p>
                <p class="mb-1">${endereco.bairro} - ${endereco.cidade} / ${endereco.estado}</p>
                <p class="mb-0">CEP: ${endereco.cep}</p>
            </div>

            <div class="table-shell">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Livro</th>
                            <th>Qtd</th>
                            <th>Subtotal</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${itens}" varStatus="s">
                            <tr>
                                <td>${livros[s.index].nome}</td>
                                <td>${item.quantidade}</td>
                                <td>R$ ${item.subtotal}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <div class="mt-3">
                <a href="${pageContext.request.contextPath}/carrinho" class="btn btn-ghost">
                    <i class="bi bi-arrow-left me-2"></i> Voltar ao carrinho
                </a>
            </div>
        </section>

        <aside class="surface summary-card">
            <p class="section-kicker">Pagamento</p>
            <h2 class="section-title h3 mb-3">Resumo e pagamento</h2>

            <div class="summary-row">
                <span>Itens</span>
                <strong>${itens.size()}</strong>
            </div>
            <div class="summary-row">
                <span>Total</span>
                <strong>R$ ${carrinho.valorTotal}</strong>
            </div>

            <form method="post" action="${pageContext.request.contextPath}/venda" class="mt-4">
                <div class="mb-3">
                    <label class="form-label">Forma de pagamento</label>
                    <select name="formaPagamento" class="form-select">
                        <option value="PIX">PIX</option>
                        <option value="CARTAO">Cartão</option>
                        <option value="BOLETO">Boleto</option>
                    </select>
                </div>

                <button type="submit" class="btn btn-brand w-100">
                    Confirmar compra
                </button>
            </form>
        </aside>
    </div>
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>
