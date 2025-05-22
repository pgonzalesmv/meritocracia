<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, modelo.Usuario, dao.ConvocatoriaDao, modelo.Convocatoria" %>
<%@ page session="true" %>
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
        <meta charset="UTF-8">
        <title>Gestión de Convocatorias</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body class="bg-light">
        <div class="container mt-5">
            <h3>📋 Gestión de Convocatorias</h3>

            <!-- Formulario para nueva convocatoria -->
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
                    <button type="submit" class="btn btn-success">Crear convocatoria</button>
                </div>
            </form>

            <!-- Aquí irá la lista de convocatorias (lo agregamos luego con lógica del servlet) -->
            <h5>Convocatorias registradas</h5>
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
                    <%
                        for (Convocatoria c : convocatorias) {
                    %>
                    <tr>
                        <td><%= c.getId()%></td>
                        <td><%= c.getTitulo()%><br><small><%= c.getDescripcion()%></small></td>
                        <td>
                            <%= c.getFechaInicio()%> → <%= c.getFechaFin()%>
                        </td>
                        <td><%= c.getEstado()%></td>
                    </tr>
                    <% }%>
                </tbody>
            </table>

        </div>
                <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
<% if (request.getParameter("creado") != null) { %>
Swal.fire({
    icon: 'success',
    title: '¡Convocatoria registrada!',
    text: 'Se ha creado correctamente.',
    //confirmButtonText: 'OK'
    timer: 3000,
    showConfirmButton: false
});
<% } %>
</script>

    </body>
</html>
