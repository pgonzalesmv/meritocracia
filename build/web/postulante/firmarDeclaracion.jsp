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
    Map<String, List<String>> resumen = new LinkedHashMap<>();

    for (CriterioEvaluacion c : criterios) {
        List<DocumentoPostulante> docs = docDao.listarPorCriterio(c.getId(), usuario.getId(), convocatoriaId);
        List<String> nombres = new ArrayList<>();
        for (DocumentoPostulante d : docs) {
            nombres.add(d.getNombreArchivo());
        }
        resumen.put(c.getCategoria(), nombres);
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Declaración Jurada</title>
    <%@ include file="../includes/head.jsp" %>
</head>
<body>
<%@ include file="../includes/navbar.jsp" %>

<div class="container mt-4">
    <h4>Declaración Jurada</h4>
    <p class="lead">Yo, <strong><%= usuario.getNombre() %></strong>, manifiesto bajo juramento que los documentos presentados corresponden a información veraz y autorizo su uso para fines de evaluación.</p>

    <h5 class="mt-4">Resumen de documentos presentados</h5>
    <ul class="list-group mb-4">
        <% for (Map.Entry<String, List<String>> entry : resumen.entrySet()) {
            String criterio = entry.getKey();
            List<String> archivos = entry.getValue();
        %>
            <li class="list-group-item">
                <strong><%= criterio %></strong>
                <% if (archivos.isEmpty()) { %>
                    <span class="text-danger"> — Sin documentos</span>
                <% } else { %>
                    <ul class="mb-0 ps-3">
                        <% for (String archivo : archivos) { %>
                            <li><%= archivo %></li>
                        <% } %>
                    </ul>
                <% } %>
            </li>
        <% } %>
    </ul>
    <%
    boolean hayAlMenosUnDocumento = false;
    for (List<String> archivos : resumen.values()) {
        if (!archivos.isEmpty()) {
            hayAlMenosUnDocumento = true;
            break;
        }
    }
%>

    <form action="../GenerarDeclaracionServlet" method="post">
        <input type="hidden" name="convocatoria_id" value="<%= convocatoriaId %>">
        <button type="submit" class="btn btn-primary">Aceptar y firmar declaración jurada</button>
        <a href="postulacion.jsp?convocatoria_id=<%= convocatoriaId %>" class="btn btn-secondary">Volver</a>
    </form>
</div>

<%@ include file="../includes/footer.jsp" %>
</body>
</html>

