<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Registro de Postulante</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- SweetAlert2 CSS + JS -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    </head>
    <body class="bg-light">
        <div class="container mt-5">
            <div class="card mx-auto shadow" style="max-width: 500px;">
                <div class="card-body">
                    <h4 class="card-title text-center">Registro de Juez</h4>
                    <form action="RegistroServlet" method="post">
                        <div class="mb-3">
                            <label class="form-label">DNI:</label>
                            <input type="text" name="dni" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Nombre:</label>
                            <input type="text" name="nombre" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Apellido:</label>
                            <input type="text" name="apellido" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Email:</label>
                            <input type="email" name="email" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Contraseña:</label>
                            <input type="password" name="password" class="form-control" required>
                        </div>
                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary">Registrar</button>
                        </div>
                    </form>
                    <p class="mt-3 text-center">
                        ¿Ya tienes una cuenta? <a href="login.jsp">Inicia sesión</a>
                    </p>

                </div>
            </div>
        </div>

        <script>
            <% if (request.getParameter("exito") != null) { %>
            Swal.fire({
                icon: 'success',
                title: '¡Registro exitoso!',
                text: 'Ahora puedes iniciar sesión.',
                //confirmButtonText: 'OK'
                timer: 3000,
                showConfirmButton: false
            });
            <% } else if (request.getParameter("error") != null) { %>
            Swal.fire({
                icon: 'error',
                title: 'Error de registro',
                text: 'DNI o correo ya registrado.',
                //confirmButtonText: 'Intentar nuevamente'
                timer: 3000,
                showConfirmButton: false
            });
            <% }%>
        </script>
    </body>
</html>
