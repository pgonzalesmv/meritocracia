<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <title>Login - Meritocracia</title>
        <!-- SweetAlert2 CSS + JS -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    </head>
    <body>
        <h2>Iniciar sesión</h2>
        <form action="LoginServlet" method="post">
            <label>Email:</label>
            <input type="text" name="email" required><br>
            <label>Contraseña:</label>
            <input type="password" name="password" required><br>
            <button type="submit">Ingresar</button>
        </form>

        <script>
            <% if (request.getParameter("error") != null) { %>
        Swal.fire({
            icon: 'error',
            title: 'Acceso denegado',
            text: 'Email o contraseña incorrectos, o cuenta inactiva.',
            //confirmButtonText: 'Intentar de nuevo'
            timer: 3000,
            showConfirmButton: false
        });
            <% } else if (request.getParameter("rol") != null) { %>
        Swal.fire({
            icon: 'warning',
            title: 'Rol no permitido',
            text: 'Tu rol no está autorizado para ingresar.',
            //confirmButtonText: 'OK'
            timer: 3000,
            showConfirmButton: false
        });
            <% }%>
        </script>
    </body>
</html>
