package controlador;

import dao.UsuarioDao;
import modelo.Usuario;
import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/LoginServlet") // ← Esta línea registra el servlet
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        UsuarioDao dao = new UsuarioDao();
        Usuario usuario = dao.validarLogin(email, password);

        if (usuario != null) {
            HttpSession session = request.getSession();
            session.setAttribute("usuario", usuario);

            switch (usuario.getRol()) {
                case "postulante":
                    response.sendRedirect("postulante/dashboard.jsp");
                    break;
                case "administrador":
                    response.sendRedirect("admin/dashboard.jsp");
                    break;
                case "superadministrador":
                    response.sendRedirect("superadmin/dashboard.jsp");
                    break;
                default:
                    response.sendRedirect("login.jsp?error=rol");
            }
        } else {
            response.sendRedirect("login.jsp?error=1");
        }
    }
}
