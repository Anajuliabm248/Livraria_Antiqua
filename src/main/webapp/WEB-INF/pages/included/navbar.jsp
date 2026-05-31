
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<nav class="navbar navbar-expand-lg site-navbar navbar-light">
  <div class="container-fluid px-3 px-xl-4">
    <a class="navbar-brand brand-link" href="${pageContext.request.contextPath}/livro">
      <img src="${pageContext.request.contextPath}/img/logo.png" alt="Livraria Antiqua" class="brand-logo">
      <span class="brand-name">Livraria Antiqua</span>
    </a>

    <button class="navbar-toggler site-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#siteNavbar" aria-controls="siteNavbar" aria-expanded="false" aria-label="Alternar navegação">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="siteNavbar">
      <c:choose>
        <c:when test="${sessionScope.usuario == null}">
          <ul class="navbar-nav mx-auto nav-pill-wrap">
            <li class="nav-item">
              <a class="${activeNav == 'catalogo' ? 'nav-link nav-pill active' : 'nav-link nav-pill'}" href="${pageContext.request.contextPath}/livro">
                <i class="bi bi-house-door"></i><span>Home</span>
              </a>
            </li>
            <li class="nav-item">
              <a class="${activeNav == 'login' ? 'nav-link nav-pill active' : 'nav-link nav-pill'}" href="${pageContext.request.contextPath}/login">
                <i class="bi bi-box-arrow-in-right"></i><span>Entrar</span>
              </a>
            </li>
            <li class="nav-item">
              <a class="${activeNav == 'cadastro' ? 'nav-link nav-pill active' : 'nav-link nav-pill'}" href="${pageContext.request.contextPath}/cadastro">
                <i class="bi bi-person-plus"></i><span>Cadastrar</span>
              </a>
            </li>
          </ul>
        </c:when>

        <c:when test="${sessionScope.usuario != null and sessionScope.usuario.tipo == 'CLIENTE'}">
          <ul class="navbar-nav mx-auto nav-pill-wrap">
            <li class="nav-item">
              <a class="${activeNav == 'catalogo' ? 'nav-link nav-pill active' : 'nav-link nav-pill'}" href="${pageContext.request.contextPath}/livro">
                <i class="bi bi-house-door"></i><span>Home</span>
              </a>
            </li>
            <li class="nav-item">
              <a class="${activeNav == 'carrinho' ? 'nav-link nav-pill active' : 'nav-link nav-pill'}" href="${pageContext.request.contextPath}/carrinho">
                <i class="bi bi-cart3"></i><span>Carrinho</span>
              </a>
            </li>
            <li class="nav-item">
              <a class="${activeNav == 'pedidos' ? 'nav-link nav-pill active' : 'nav-link nav-pill'}" href="${pageContext.request.contextPath}/venda?acao=historico">
                <i class="bi bi-receipt"></i><span>Meus pedidos</span>
              </a>
            </li>
          </ul>

          <div class="dropdown">
            <a class="dropdown-toggle profile-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
              <span>${sessionScope.usuario.nome}</span>
              <img src="${pageContext.request.contextPath}/img/user.png" alt="Perfil" class="profile-avatar">
            </a>
            <ul class="dropdown-menu dropdown-menu-end">
              <li><a class="dropdown-item" href="${pageContext.request.contextPath}/cliente">
                <i class="bi bi-person me-2"></i> Meu perfil
              </a></li>
              <li><a class="dropdown-item" href="${pageContext.request.contextPath}/cliente?acao=endereco">
                <i class="bi bi-geo-alt me-2"></i> Gerenciar endereço
              </a></li>
              <li><hr class="dropdown-divider"></li>
              <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout">
                <i class="bi bi-box-arrow-right me-2"></i> Sair
              </a></li>
            </ul>
          </div>
        </c:when>

        <c:otherwise>
          <ul class="navbar-nav mx-auto nav-pill-wrap">
            <li class="nav-item">
              <a class="${activeNav == 'dashboard' ? 'nav-link nav-pill active' : 'nav-link nav-pill'}" href="${pageContext.request.contextPath}/vendedor?acao=dashboard">
                <i class="bi bi-house-door"></i><span>Home</span>
              </a>
            </li>
            <li class="nav-item">
              <a class="${activeNav == 'novo_livro' ? 'nav-link nav-pill active' : 'nav-link nav-pill'}" href="${pageContext.request.contextPath}/livro?acao=novo">
                <i class="bi bi-plus-circle"></i><span>Novo produto</span>
              </a>
            </li>
            <li class="nav-item">
              <a class="${activeNav == 'estoque' ? 'nav-link nav-pill active' : 'nav-link nav-pill'}" href="${pageContext.request.contextPath}/vendedor?acao=estoque">
                <i class="bi bi-inbox"></i><span>Acervo</span>
              </a>
            </li>
            <li class="nav-item">
              <a class="${activeNav == 'relatorio' ? 'nav-link nav-pill active' : 'nav-link nav-pill'}" href="${pageContext.request.contextPath}/vendedor?acao=relatorio">
                <i class="bi bi-bag-check"></i><span>Vendas</span>
              </a>
            </li>
          </ul>

          <div class="dropdown">
            <a class="dropdown-toggle profile-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
              <span>${sessionScope.usuario.nome}</span>
              <img src="${pageContext.request.contextPath}/img/user.png" alt="Perfil" class="profile-avatar">
            </a>
            <ul class="dropdown-menu dropdown-menu-end">
              <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout">
                <i class="bi bi-box-arrow-right me-2"></i> Sair
              </a></li>
            </ul>
          </div>
        </c:otherwise>
      </c:choose>
    </div>
  </div>
</nav>
