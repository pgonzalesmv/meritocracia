<%
    String rol = u.getRol();
%>
<div class="aside bg-light shadow-1 mt-1 ms-0">
    <h2 class="p-3"><span class="text-logo">M</span> MERITOCRACIA</h2>
    <div class="list-group list-group-flush">
        <% if ("postulante".equals(rol)) { %>
        <a href="dashboard.jsp" class="list-group-item">
            <i class="fas fa-house"></i> Panel
        </a>
        <a href="documentos.jsp" class="list-group-item">
            <i class="fas fa-file-upload"></i> Valoración de Méritos
        </a>
        <a href="mis_declaraciones.jsp" class="list-group-item">Mis Declaraciones</a>
        <% } else if ("administrador".equals(rol)) { %>
        <a href="dashboard.jsp" class="list-group-item">
            <i class="fas fa-house"></i> Panel
        </a>
        <a href="#" class="list-group-item">
            <i class="fas fa-check-square"></i> Evaluar
        </a>
        <% } else if ("superadministrador".equals(rol)) { %>
        <a href="dashboard.jsp" class="list-group-item">
            <i class="fas fa-house"></i> Panel
        </a>
        <a href="convocatorias.jsp" class="list-group-item">
            <i class="fas fa-folder-open"></i> Valoración de méritos
        </a>
        <a href="dashboard.jsp" class="list-group-item">
            <i class="fas fa-list-alt"></i> Criterios de Evaluación
        </a>
        <a href="#" class="list-group-item">
            <i class="fas fa-cogs"></i> Configuración
        </a>
        <% }%>
    </div>
</div>
