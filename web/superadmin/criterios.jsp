<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="modelo.Usuario, dao.CriterioEvaluacionDao, modelo.CriterioEvaluacion, java.util.List" %>
<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");
    if (usuario == null || !"superadministrador".equals(usuario.getRol())) {
        response.sendRedirect("../login.jsp");
        return;
    }

    int convocatoriaId = Integer.parseInt(request.getParameter("convocatoria_id"));
    CriterioEvaluacionDao dao = new CriterioEvaluacionDao();
    List<CriterioEvaluacion> criterios = dao.listarPorConvocatoria(convocatoriaId);
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Criterios de Evaluación</title>
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
                    <h4><i class="fas fa-tags"></i> Criterios para Convocatoria #<%= convocatoriaId%></h4>
                    <% if (criterios.isEmpty()) {%>
                    <a href="../CriterioEvaluacionServlet?accion=predefinidos&convocatoria_id=<%= convocatoriaId%>" 
                       class="btn btn-outline-secondary mb-3">
                        <i class="fas fa-bolt"></i> Cargar criterios predefinidos 2025
                    </a>
                    <% }%>
                    <!-- Formulario -->
                    <form action="../CriterioEvaluacionServlet" method="post" class="card p-3 mb-4">
                        <input type="hidden" name="convocatoria_id" value="<%= convocatoriaId%>">
                        <div class="row">
                            <div class="col-md-4">
                                <label class="form-label">Categoría:</label>
                                <input type="text" name="categoria" class="form-control" required>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Subcategoría:</label>
                                <input type="text" name="subcategoria" class="form-control">
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Puntaje máximo:</label>
                                <input type="number" name="puntaje_maximo" step="0.1" class="form-control" required>
                            </div>
                            <div class="col-md-8">
                                <label class="form-label">Descripción:</label>
                                <input type="text" name="descripcion" class="form-control">
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Orden:</label>
                                <input type="number" name="orden" class="form-control" required>
                            </div>
                            <div class="col-md-12 mt-2">
                                <label class="form-label">Fórmula de cálculo (opcional):</label>
                                <input type="text" name="formula_calculo" class="form-control">
                            </div>
                        </div>
                        <div class="mt-3">
                            <button class="btn btn-primary"><i class="fas fa-plus-circle"></i> Agregar criterio</button>
                        </div>
                    </form>

                    <!-- Tabla -->
                    <h5><i class="fas fa-list"></i> Criterios existentes</h5>
                    <table class="table table-bordered table-hover">
                        <thead class="table-secondary">
                            <tr>
                                <th>Orden</th>
                                <th>Categoría</th>
                                <th>Subcategoría</th>
                                <th>Puntaje</th>
                                <th>Descripción</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (CriterioEvaluacion c : criterios) {%>
                            <tr>
                                <td><%= c.getOrden()%></td>
                                <td><%= c.getCategoria()%></td>
                                <td><%= c.getSubcategoria()%></td>
                                <td><%= c.getPuntajeMaximo()%></td>
                                <td><%= c.getDescripcion()%></td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <%@ include file="../includes/footer.jsp" %>
        <script>
            <% if (request.getParameter("creado") != null) { %>
            Swal.fire({
                icon: 'success',
                title: 'Criterio agregado',
                text: 'Se registró correctamente.',
                confirmButtonText: 'OK'
            });
            <% } else if (request.getParameter("predefinidos_ok") != null) { %>
            Swal.fire({
                icon: 'success',
                title: '¡Criterios cargados!',
                text: 'Los criterios predefinidos fueron registrados.',
                confirmButtonText: 'OK'
            });
            <% } else if (request.getParameter("predefinidos_error") != null) { %>
            Swal.fire({
                icon: 'error',
                title: 'Error al cargar criterios',
                text: 'Ocurrió un problema inesperado.',
                confirmButtonText: 'OK'
            });
            <% } %>
        </script>
    </body>
</html>
