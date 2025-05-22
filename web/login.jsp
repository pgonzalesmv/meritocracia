<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Login - Meritocracia</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    </head>
    <body class="bg-light">

        <div class="container mt-5">
            <div class="card mx-auto shadow" style="max-width: 450px;">
                <div class="card-body">
                    <h4 class="text-center">Iniciar sesión</h4>
                    <form action="LoginServlet" method="post">
                        <div class="mb-3">
                            <label>Email:</label>
                            <input type="email" name="email" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label>Contraseña:</label>
                            <input type="password" name="password" class="form-control" required>
                        </div>
                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary">Ingresar</button>
                        </div>
                    </form>
                    <p class="mt-3 text-center">
                        ¿No tienes cuenta? <a href="registro.jsp">Regístrate</a>
                    </p>
                </div>
            </div>
        </div>

        <!-- Alertas con SweetAlert2 -->
        <script>
            <% if (request.getParameter("error") != null) { %>
    Swal.fire({
        icon: 'error',
        title: 'Acceso denegado',
        text: 'Email o contraseña incorrectos, o cuenta inactiva.',
        confirmButtonText: 'Intentar de nuevo'
    });
            <% } else if (request.getParameter("rol") != null) { %>
    Swal.fire({
        icon: 'warning',
        title: 'Rol no permitido',
        text: 'Tu rol no está autorizado para ingresar.',
        confirmButtonText: 'OK'
    });
            <% } else if (request.getParameter("logout") != null) { %>
    Swal.fire({
        icon: 'success',
        title: 'Sesión finalizada',
        text: 'Has cerrado sesión correctamente',
        confirmButtonText: 'OK'
    });
            <% } else if (request.getParameter("registro") != null) { %>
    Swal.fire({
        icon: 'success',
        title: '¡Registro completado!',
        text: 'Ahora puedes iniciar sesión.',
        confirmButtonText: 'Iniciar sesión'
    });
            <% }%>
        </script>

    </body>
</html>
