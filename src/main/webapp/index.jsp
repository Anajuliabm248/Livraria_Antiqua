<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/footer.css">
    <link rel="stylesheet" href="${resources['/css/styles.css']}">
    <title>Login</title>
</head>
<body>
<jsp:include page="/WEB-INF/pages/includes/header.jsp" />
<div class="container">
    <div class="box">
        <h2>Login</h2>
        <form action="login" method="post">
            <input type="email" name="email" placeholder="E-mail" required>
            <input type="password" name="senha" placeholder="Senha" required>
            <button type="submit">Entrar</button>
        </form>
        <a href="cadastro">Criar conta</a>
        <c:if test="${not empty erro}">
            <p style="color:red">${erro}</p>
        </c:if>
    </div>
</div>

</body>
</html>