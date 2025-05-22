<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="modelo.Usuario, modelo.Convocatoria, dao.ConvocatoriaDao, java.util.List" %>
<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");
    if (usuario == null || !"superadministrador".equals(usuario.getRol())) {
        response.sendRedirect("../login.jsp");
        return;
    }

    ConvocatoriaDao dao = new ConvocatoriaDao();
    List<Convocatoria> convocatorias = dao.listar();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Gestión de Convocatorias</title>
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
            <h4><i class="fas fa-folder-plus"></i> Nueva Convocatoria</h4>

            <!-- Formulario -->
            <form action="../ConvocatoriaServlet" method="post" class="card p-3 mb-4">
                <input type="hidden" name="accion" value="crear">
                <div class="row">
                    <div class="col-md-6">
                        <label class="form-label">Título:</label>
                        <input type="text" name="titulo" class="form-control" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Descripción:</label>
                        <input type="text" name="descripcion" class="form-control" required>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Fecha inicio:</label>
                        <input type="date" name="fecha_inicio" class="form-control" required>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Fecha fin:</label>
                        <input type="date" name="fecha_fin" class="form-control" required>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Estado:</label>
                        <select name="estado" class="form-select" required>
                            <option value="configuracion">Configuración</option>
                            <option value="activa">Activa</option>
                            <option value="evaluacion">Evaluación</option>
                            <option value="finalizada">Finalizada</option>
                        </select>
                    </div>
                </div>
                <div class="mt-3">
                    <button type="submit" class="btn btn-success">
                        <i class="fas fa-plus-circle"></i> Crear convocatoria
                    </button>
                </div>
            </form>

            <!-- Tabla -->
            <h5><i class="fas fa-list"></i> Convocatorias registradas</h5>
            <table class="table table-bordered table-hover">
                <thead class="table-secondary">
                    <tr>
                        <th>ID</th>
                        <th>Título</th>
                        <th>Fechas</th>
                        <th>Estado</th>
                    </tr>
                </thead>
                <tbody>
                <% for (Convocatoria c : convocatorias) { %>
                    <tr>
                        <td><%= c.getId() %></td>
                        <td><strong><%= c.getTitulo() %></strong><br><small><%= c.getDescripcion() %></small></td>
                        <td><%= c.getFechaInicio() %> → <%= c.getFechaFin() %></td>
                        <td><span class="badge bg-secondary"><%= c.getEstado() %></span></td>
                    </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<%@ include file="../includes/footer.jsp" %>

<!-- SweetAlert2 -->
<script>
<% if (request.getParameter("creado") != null) { %>
Swal.fire({
    icon: 'success',
    title: 'Convocatoria registrada',
    text: 'Se creó correctamente.',
    confirmButtonText: 'OK'
});
<% } %>
</script>

</body>
</html>
