package controlador;

import dao.UsuarioDao;
import modelo.Usuario;
import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/RegistroServlet")
public class RegistroServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        Usuario usuario = new Usuario();
        usuario.setDni(request.getParameter("dni"));
        usuario.setNombre(request.getParameter("nombre"));
        usuario.setApellido(request.getParameter("apellido"));
        usuario.setEmail(request.getParameter("email"));
        usuario.setPassword(request.getParameter("password")); // luego ciframos
        usuario.setRol("postulante");
        usuario.setEstado("activo");

        UsuarioDao dao = new UsuarioDao();
        boolean registrado = dao.registrarUsuario(usuario);

        if (registrado) {
            response.sendRedirect("registro.jsp?exito=1");
        } else {
            response.sendRedirect("registro.jsp?error=1");
        }
    }
}
