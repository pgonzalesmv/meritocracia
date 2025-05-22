<%@ include file="../includes/head.jsp" %>
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
    <title>Panel Postulante</title>
</head>
<body>
<%@ include file="../includes/navbar.jsp" %>

<div class="container-fluid">
  <div class="row">
    <div class="col-md-2">
      <%@ include file="../includes/sidebar.jsp" %>
    </div>
    <div class="col-md-10 mt-4">
        <h3>Bienvenido, <%= usuario.getNombre() %> <i class="fa fa-hand"></i></h3>
        <p>Aquí verás tu avance, documentos cargados y puntajes.</p>
    </div>
  </div>
</div>

<%@ include file="../includes/footer.jsp" %>
</body>
</html>
