<%@ page import="modelo.Usuario" %>
<%
    Usuario u = (Usuario) session.getAttribute("usuario");
%>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-1">
    <div class="container-fluid">
        <span class="navbar-brand"><i class="fas fa-scale-balanced"></i> Sistema de Meritocracia de Jueces</span>
        <div class="d-flex ms-auto align-items-center">
            <div class="card-pastel me-3">
                <div class="row d-flex align-items-center">
                    <div class="col-md-2">
                        <div class="circular siglas text-white">
                            <%= u.getNombre().charAt(0)%><%= u.getApellido().charAt(0)%></div>
                    </div>
                    <div class="col-md-10">
                        <div><strong class="text-pj"><%= u.getNombre()%> <%= u.getApellido()%></strong></div>
                        <div class="text-grey text-capitalize"><%= u.getRol()%></div>
                    </div>
                </div>
            </div>
            <div>
                <a href="../LogoutServlet" class="btn btn-sm btn-primary">
                    <i class="fas fa-sign-out-alt"></i> Cerrar sesión
                </a></div>
        </div>
    </div>
</nav>
