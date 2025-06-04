<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="../includes/head.jsp" %>
<%@ include file="../includes/navbar.jsp" %>

<div class="container mt-4">
    <% String exito = request.getParameter("exito"); %>
    <% if ("1".equals(exito)) { %>
        <div class="alert alert-success">
            Tu declaración jurada ha sido registrada exitosamente.
        </div>
        <a href="documentos.jsp" class="btn btn-primary">Volver</a>
    <% } else { %>
        <div class="alert alert-danger">
            Ocurrió un error al registrar tu declaración jurada.
        </div>
        <a href="postulacion.jsp" class="btn btn-warning">Intentar nuevamente</a>
    <% } %>
</div>

<%@ include file="../includes/footer.jsp" %>
