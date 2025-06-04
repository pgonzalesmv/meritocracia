<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="modelo.Usuario, java.sql.*, java.util.*, util.ConexionBD" %>
<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");
    if (usuario == null || !"postulante".equals(usuario.getRol())) {
        response.sendRedirect("../login.jsp");
        return;
    }

    Connection con = ConexionBD.getConexion();
    PreparedStatement ps = con.prepareStatement("SELECT * FROM declaracion_jurada WHERE id_usuario = ?");
    ps.setInt(1, usuario.getId());
    ResultSet rs = ps.executeQuery();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Mis Declaraciones</title>
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
            <h4>Mis Declaraciones Juradas</h4>

            <table class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Convocatoria</th>
                        <th>Fecha de firma</th>
                        <th>Archivo PDF</th>
                    </tr>
                </thead>
                <tbody>
                    <% while (rs.next()) { %>
                        <tr>
                            <td>#<%= rs.getInt("id_convocatoria") %></td>
                            <td><%= rs.getTimestamp("fecha_firma") %></td>
                            <td>
                                <a href="../<%= rs.getString("ruta_pdf") %>" target="_blank" class="btn btn-sm btn-outline-primary">
                                    Descargar PDF
                                </a>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>
<%@ include file="../includes/footer.jsp" %>
</body>
</html>
