<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Registro de Postulante</title>
</head>
<body>
    <h2>Registro de Juez</h2>
    <form action="RegistroServlet" method="post">
        <label>DNI:</label><br>
        <input type="text" name="dni" required><br>
        
        <label>Nombre:</label><br>
        <input type="text" name="nombre" required><br>
        
        <label>Apellido:</label><br>
        <input type="text" name="apellido" required><br>
        
        <label>Email:</label><br>
        <input type="email" name="email" required><br>
        
        <label>Contraseña:</label><br>
        <input type="password" name="password" required><br><br>
        
        <button type="submit">Registrar</button>
    </form>

    <% if (request.getParameter("exito") != null) { %>
        <p style="color:green;">¡Registro exitoso! Ahora puedes iniciar sesión.</p>
    <% } else if (request.getParameter("error") != null) { %>
        <p style="color:red;">Error: El correo ya está registrado.</p>
    <% } %>
</body>
</html>
