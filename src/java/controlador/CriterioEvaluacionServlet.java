package controlador;

import dao.CriterioEvaluacionDao;
import modelo.CriterioEvaluacion;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/CriterioEvaluacionServlet")
public class CriterioEvaluacionServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int convocatoriaId = Integer.parseInt(request.getParameter("convocatoria_id"));

        CriterioEvaluacion c = new CriterioEvaluacion();
        c.setConvocatoriaId(convocatoriaId);
        c.setCategoria(request.getParameter("categoria"));
        c.setSubcategoria(request.getParameter("subcategoria"));
        c.setDescripcion(request.getParameter("descripcion"));
        c.setPuntajeMaximo(Double.parseDouble(request.getParameter("puntaje_maximo")));
        c.setFormulaCalculo(request.getParameter("formula_calculo"));
        c.setOrden(Integer.parseInt(request.getParameter("orden")));
        c.setActivo(true);

        CriterioEvaluacionDao dao = new CriterioEvaluacionDao();
        dao.crear(c);

        response.sendRedirect("superadmin/criterios.jsp?convocatoria_id=" + convocatoriaId + "&creado=1");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String accion = request.getParameter("accion");
        int convocatoriaId = Integer.parseInt(request.getParameter("convocatoria_id"));

        if ("predefinidos".equals(accion)) {
            CriterioEvaluacionDao dao = new CriterioEvaluacionDao();
            boolean ok = dao.cargarPredefinidos(convocatoriaId);
            String estado = ok ? "predefinidos_ok=1" : "predefinidos_error=1";
            response.sendRedirect("superadmin/criterios.jsp?convocatoria_id=" + convocatoriaId + "&" + estado);
        }
    }
}
