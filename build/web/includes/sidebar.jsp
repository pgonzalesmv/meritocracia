<%
    String rol = u.getRol();
%>
<div class="bg-light border-end" style="min-width: 200px;">
    <div class="list-group list-group-flush">
        <% if ("postulante".equals(rol)) { %>
        <a href="dashboard.jsp" class="list-group-item">
            <i class="fas fa-house"></i> Panel
        </a>
        <a href="#" class="list-group-item">
            <i class="fas fa-file-upload"></i> Mis Documentos
        </a>
        <% } else if ("administrador".equals(rol)) { %>
        <a href="dashboard.jsp" class="list-group-item">
            <i class="fas fa-house"></i> Panel
        </a>
        <a href="#" class="list-group-item">
            <i class="fas fa-check-square"></i> Evaluar Postulantes
        </a>
        <% } else if ("superadministrador".equals(rol)) { %>
        <a href="dashboard.jsp" class="list-group-item">
            <i class="fas fa-house"></i> Panel
        </a>
        <a href="convocatorias.jsp" class="list-group-item">
            <i class="fas fa-folder-open"></i> Convocatorias
        </a>
        <a href="dashboard.jsp" class="list-group-item">
            <i class="fas fa-list-alt"></i> Criterios por convocatoria
        </a>
        <a href="#" class="list-group-item">
            <i class="fas fa-cogs"></i> Configuración
        </a>
        <% }%>
    </div>
</div>
