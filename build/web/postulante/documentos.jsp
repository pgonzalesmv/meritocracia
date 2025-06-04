<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="modelo.Usuario, modelo.CriterioEvaluacion, modelo.DocumentoPostulante, dao.ConvocatoriaDao, dao.CriterioEvaluacionDao, dao.DocumentoPostulanteDao, modelo.Convocatoria, java.util.*" %>
<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");
    if (usuario == null || !"postulante".equals(usuario.getRol())) {
        response.sendRedirect("../login.jsp");
        return;
    }

    ConvocatoriaDao convocatoriaDao = new ConvocatoriaDao();
    List<Convocatoria> convocatorias = convocatoriaDao.listar();
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Valoración de Méritos</title>
        <%@ include file="../includes/head.jsp" %>
        <style>
            .modal-body { max-height: 70vh; overflow-y: auto; }
        </style>
    </head>
    <body>
        <%@ include file="../includes/navbar.jsp" %>

        <div class="container-fluid">
            <div class="row">
                <div class="col-md-2">
                    <%@ include file="../includes/sidebar.jsp" %>
                </div>
                <div class="col-md-10 mt-4">
                    <% if (!convocatorias.isEmpty()) { %>
                    <h3 class="mb-4">Valoración de Méritos</h3>
                    <% for (Convocatoria c : convocatorias) {
                            int idConv = c.getId();
                            if (idConv <= 0) {
                                continue; // Seguridad adicional
                            }%>
                    <div class="card mb-4">
                        <div class="card-body">
                            <div class="row mb-2">
                                <div class="col-md-10">
                                    <h5 class="card-title text-principal">
                                        <%= c.getTitulo()%> <%= c.getId()%>
                                    </h5>
                                    <p class="card-text"><%= c.getDescripcion()%></p>
                                </div>
                                <div class="col-md-2">
                                    <p class="pj-badge"><%= c.getEstado()%></p>
                                </div>
                            </div>
                            <div class="row mb-2">
                                <div class="col-md-4">Fecha de Inicio<br> <%= c.getFechaInicio()%></div>
                                <div class="col-md-4">Fecha de Fin<br> <%= c.getFechaFin()%></div>
                                <div class="col-md-4">Postulantes<br> N/D</div>
                            </div>
                            <hr>
                            <div class="d-flex gap-2">
                                <button class="btn btn-outline-primary btn-sm ver-detalles" 
                                        data-id="<%= idConv%>" 
                                        data-titulo="<%= c.getTitulo()%>">
                                    Ver detalles
                                </button>
                                <a href="postulacion.jsp?convocatoria_id=<%= c.getId()%>" class="btn btn-success postular-btn btn-sm">
                                    <i class="fas fa-file-upload"></i> Postular
                                </a>

                            </div>
                        </div>
                    </div>
                    <% } %>
                    <% } else { %>
                    <div class="alert alert-info">No hay convocatorias disponibles en este momento.</div>
                    <% }%>
                </div>
            </div>
        </div>

        <!-- Modal para POSTULAR -->
        <div class="modal fade" id="modalPostular" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-scrollable">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title"><i class="fas fa-file-upload"></i> Postulación a <span id="modalTituloConvocatoria"></span></h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body" id="modalContenidoCriterios">
                        <div class="text-center text-muted">
                            <i class="fas fa-spinner fa-spin"></i> Cargando criterios...
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%@ include file="../includes/footer.jsp" %>

        <script>
            

            // VER DETALLES: muestra popup con lista de criterios
            document.querySelectorAll('.ver-detalles').forEach(btn => {
                btn.addEventListener('click', () => {
                    const id = btn.dataset.id;
                    const titulo = btn.dataset.titulo;

                    if (!id || isNaN(id)) {
                        Swal.fire('Error', 'ID de convocatoria inválido.', 'error');
                        return;
                    }

                    Swal.fire({
                        title: 'Criterios - ' + titulo,
                        html: '<i class="fas fa-spinner fa-spin"></i> Cargando...',
                        didOpen: () => {
                            fetch(`../CriterioAjaxServlet?convocatoria_id=${id}`)
                                    .then(res => res.text())
                                    .then(html => {
                                        Swal.update({html});
                                    });
                        },
                        showCloseButton: true,
                        showConfirmButton: false,
                        width: 700
                    });
                });
            });
        </script>

    </body>
</html>
