
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Login"/>
<jsp:include page="fragments/header.jsp"/>

<div class="auth-wrap">
    <div class="auth-card">
        <span class="eyebrow">WELCOME BACK</span>

        <h1 class="fw-bold mt-2">Sign in</h1>
        <p class="text-secondary">
            Your next great find is waiting.
        </p>

        <c:if test="${not empty error}">
            <div class="alert alert-danger">
                <c:out value="${error}"/>
            </div>
        </c:if>

        <c:if test="${param.registered eq '1'}">
            <div class="alert alert-success">
                Account created. You can sign in now.
            </div>
        </c:if>

        <form method="post"
              action="${pageContext.request.contextPath}/login">

            <label class="form-label mt-3">Email</label>
            <input class="form-control form-control-lg"
                   type="email"
                   name="email"
                   required
                   autocomplete="email">

            <label class="form-label mt-3">Password</label>
            <input class="form-control form-control-lg"
                   type="password"
                   name="password"
                   required
                   autocomplete="current-password">

            <button type="submit"
                    class="btn btn-dark btn-lg w-100 mt-4">
                Sign in
            </button>
        </form>

        <p class="text-center mt-4 mb-0">
            New to ShopSphere?
            <a href="${pageContext.request.contextPath}/register">
                Create an account
            </a>
        </p>
    </div>
</div>

<jsp:include page="fragments/footer.jsp"/>
