<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Login - Meritocracia</title>
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

    <% if (request.getParameter("error") != null) { %>
        <p style="color:red;">Credenciales incorrectas o usuario inactivo.</p>
    <% } %>
</body>
</html>
