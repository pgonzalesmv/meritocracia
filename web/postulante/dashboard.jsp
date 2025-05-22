<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="modelo.Usuario" %>
<%@ page session="true" %>
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
    <meta charset="UTF-8">
    <title>Panel del Postulante</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="card shadow">
        <div class="card-body">
            <h3 class="card-title">Bienvenido, <%= usuario.getNombre() %> <%= usuario.getApellido() %> 👋</h3>
            <p class="card-text">Email: <%= usuario.getEmail() %></p>
            <p class="card-text">DNI: <%= usuario.getDni() %></p>

            <hr>
            <p>📌 Aquí podrás seguir tu postulación, subir documentos y ver tu progreso.</p>

            <a href="../LogoutServlet" class="btn btn-danger">Cerrar sesión</a>
        </div>
    </div>
</div>

</body>
</html>
