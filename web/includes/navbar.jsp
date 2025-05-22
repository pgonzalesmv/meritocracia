<%@ page import="modelo.Usuario" %>
<%
    Usuario u = (Usuario) session.getAttribute("usuario");
%>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
  <div class="container-fluid">
    <span class="navbar-brand"><i class="fas fa-scale-balanced"></i> MERITOCRACIA</span>
    <div class="d-flex ms-auto text-white">
      <span class="me-3"><i class="fas fa-user"></i> <%= u.getNombre() %> <%= u.getApellido() %></span>
      <a href="../LogoutServlet" class="btn btn-sm btn-danger">
        <i class="fas fa-sign-out-alt"></i> Cerrar sesión
      </a>
    </div>
  </div>
</nav>
