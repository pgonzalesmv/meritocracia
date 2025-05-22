package controlador;

import dao.ConvocatoriaDao;
import modelo.Convocatoria;
import modelo.Usuario;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/ConvocatoriaServlet")
public class ConvocatoriaServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws IOException {
        HttpSession session = request.getSession();
        Usuario u = (Usuario) session.getAttribute("usuario");

        String accion = request.getParameter("accion");

        if ("crear".equals(accion)) {
            Convocatoria c = new Convocatoria();
            c.setTitulo(request.getParameter("titulo"));
            c.setDescripcion(request.getParameter("descripcion"));
            c.setFechaInicio(request.getParameter("fecha_inicio"));
            c.setFechaFin(request.getParameter("fecha_fin"));
            c.setEstado(request.getParameter("estado"));
            c.setCreadoPor(u.getId());

            ConvocatoriaDao dao = new ConvocatoriaDao();
            dao.crear(c);
        }

        response.sendRedirect("superadmin/convocatorias.jsp?creado=1");
    }
}
