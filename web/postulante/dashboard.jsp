<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="modelo.Usuario" %>
<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");
    if (usuario == null || !"postulante".equals(usuario.getRol())) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Panel del Postulante</title>
    <%@ include file="../includes/head.jsp" %>
</head>
<body>
<%@ include file="../includes/navbar.jsp" %>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-2">
            <%@ include file="../includes/sidebar.jsp" %>
        </div>
        <div class="col-md-10 mt-4">
            <h3><i class="fas fa-user-graduate"></i> Bienvenido, <%= usuario.getNombre() %></h3>
            <p>Desde este panel podrás:</p>
            <ul>
                <li>Subir documentos y declaraciones juradas</li>
                <li>Ver el estado de tu postulación</li>
                <li>Revisar tus puntajes asignados</li>
            </ul>
        </div>
    </div>
</div>

<%@ include file="../includes/footer.jsp" %>
</body>
</html>
