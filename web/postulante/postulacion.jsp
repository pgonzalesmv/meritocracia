<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="modelo.Usuario, modelo.CriterioEvaluacion, modelo.DocumentoPostulante, dao.CriterioEvaluacionDao, dao.DocumentoPostulanteDao, java.util.*" %>
<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");
    if (usuario == null || !"postulante".equals(usuario.getRol())) {
        response.sendRedirect("../login.jsp");
        return;
    }

    String paramId = request.getParameter("convocatoria_id");
    int convocatoriaId = (paramId != null && !paramId.isEmpty()) ? Integer.parseInt(paramId) : -1;

    CriterioEvaluacionDao criterioDao = new CriterioEvaluacionDao();
    List<CriterioEvaluacion> criterios = criterioDao.listarPorConvocatoria(convocatoriaId);

    DocumentoPostulanteDao docDao = new DocumentoPostulanteDao();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Postulación</title>
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
      <h4 class="mb-4">Postulación: Carga de Documentos</h4>

      <form action="../DocumentoUploadServlet" method="post" enctype="multipart/form-data" class="row g-3 align-items-end">
        <input type="hidden" name="convocatoria_id" value="<%= convocatoriaId %>">

        <div class="col-md-4">
          <label for="criterio_id" class="form-label">Seleccione un criterio</label>
          <select name="criterio_id" id="criterio_id" class="form-select" required>
            <option value="">-- Elegir --</option>
            <% for (CriterioEvaluacion c : criterios) { %>
              <option value="<%= c.getId() %>"><%= c.getCategoria() %>
                <% if (c.getSubcategoria() != null) { %> - <%= c.getSubcategoria() %><% } %>
              </option>
            <% } %>
          </select>
        </div>

        <div class="col-md-4">
          <label for="archivo" class="form-label">Archivo</label>
          <input type="file" name="archivo" id="archivo" class="form-control" required>
        </div>

        <div class="col-md-3">
          <label for="comentario" class="form-label">Comentario</label>
          <input type="text" name="comentario" id="comentario" class="form-control" placeholder="Opcional">
        </div>

        <div class="col-md-1">
          <button type="submit" class="btn btn-primary w-100">Subir</button>
        </div>
      </form>

      <hr class="my-4">

      <h5>Resumen de carga de documentos</h5>

      <table class="table table-bordered table-sm">
        <thead>
          <tr class="table-light">
            <th style="width: 30%">Criterio</th>
            <th>Documentos Subidos</th>
          </tr>
        </thead>
        <tbody>
          <% for (CriterioEvaluacion c : criterios) {
              List<DocumentoPostulante> docs = docDao.listarPorCriterio(c.getId(), usuario.getId(), convocatoriaId);
          %>
          <tr>
            <td>
              <%= c.getCategoria() %><% if (c.getSubcategoria() != null) { %> - <%= c.getSubcategoria() %><% } %>
            </td>
            <td>
              <% if (docs.isEmpty()) { %>
                <em class="text-muted">Sin documentos</em>
              <% } else { %>
                <ul class="mb-0 ps-3">
                  <% for (DocumentoPostulante doc : docs) { %>
                    <li>
                      <a href="../<%= doc.getRutaArchivo() %>" target="_blank"><%= doc.getNombreArchivo() %></a>
                      <% if (doc.getComentario() != null && !doc.getComentario().isEmpty()) { %>
                        <small class="text-muted"> - <%= doc.getComentario() %></small>
                      <% } %>
                    </li>
                  <% } %>
                </ul>
              <% } %>
            </td>
          </tr>
          <% } %>
        </tbody>
      </table>

      <form action="firmarDeclaracion.jsp" method="post" class="mt-4">
        <input type="hidden" name="convocatoria_id" value="<%= convocatoriaId %>">
        <button type="submit" class="btn btn-success">Guardar cambios y firmar declaración jurada</button>
      </form>

    </div>
  </div>
</div>

<%@ include file="../includes/footer.jsp" %>
</body>
</html>
