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
                    <div><h3>Panel de Control</h3></div>
                    <main class="bg-pj">
                        <h3>👋 Bienvenido, <%= usuario.getNombre()%></h3>
                        <p>Desde este panel puedes:</p>
                        <ul>
                            <li>Ver convocatorias disponibles</li>
                            <li>Subir documentos para tu legajo</li>
                            <li>Realizar declaraciones juradas</li>
                            <li>Consultar el estado de tu evaluación</li>
                        </ul>
                    </main>
                </div>
            </div>
        </div>

        <%@ include file="../includes/footer.jsp" %>
    </body>
</html>
