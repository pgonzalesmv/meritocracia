package controlador;

import dao.CriterioEvaluacionDao;
import dao.DocumentoPostulanteDao;
import modelo.CriterioEvaluacion;
import modelo.DocumentoPostulante;
import modelo.Usuario;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/CriterioAjaxServlet")
public class CriterioAjaxServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String paramId = request.getParameter("convocatoria_id");
int convocatoriaId = -1;
if (paramId != null && !paramId.isEmpty()) {
    try {
        convocatoriaId = Integer.parseInt(paramId);
    } catch (NumberFormatException e) {
        convocatoriaId = -1;
    }
}

if (convocatoriaId == -1) {
    response.getWriter().println("<p>Error: convocatoria no válida.</p>");
    return;
}

        
        String modo = request.getParameter("modo");

        CriterioEvaluacionDao criterioDao = new CriterioEvaluacionDao();
        List<CriterioEvaluacion> criterios = criterioDao.listarPorConvocatoria(convocatoriaId);

        if (criterios.isEmpty()) {
            out.println("<p>No hay criterios registrados para esta convocatoria.</p>");
            return;
        }

        HttpSession session = request.getSession();
        Usuario u = (Usuario) session.getAttribute("usuario");
        DocumentoPostulanteDao docDao = new DocumentoPostulanteDao();

        for (CriterioEvaluacion c : criterios) {
            out.println("<div class='card mb-3'>");
            out.println("<div class='card-header bg-light'>");
            out.println("<strong>" + c.getCategoria() + "</strong>");
            if (c.getSubcategoria() != null) {
                out.println(" - <em>" + c.getSubcategoria() + "</em>");
            }
            out.println("<span class='float-end badge bg-info'>Máx: " + c.getPuntajeMaximo() + " ptos</span>");
            out.println("</div>");
            out.println("<div class='card-body'>");

            out.println("<p>" + c.getDescripcion() + "</p>");

            // Si está en modo formulario, incluir formulario
            if ("form".equals(modo)) {
                out.println("<form action='../DocumentoUploadServlet' method='post' enctype='multipart/form-data' class='row g-2 align-items-center'>");
                out.println("<input type='hidden' name='criterio_id' value='" + c.getId() + "'>");
                out.println("<input type='hidden' name='convocatoria_id' value='" + convocatoriaId + "'>");
                out.println("<div class='col-md-4'>");
                out.println("<input type='file' name='archivo' class='form-control' required>");
                out.println("</div>");
                out.println("<div class='col-md-4'>");
                out.println("<input type='text' name='comentario' class='form-control' placeholder='Comentario opcional'>");
                out.println("</div>");
                out.println("<div class='col-md-2'>");
                out.println("<button class='btn btn-success'><i class='fas fa-upload'></i> Subir</button>");
                out.println("</div>");
                out.println("</form>");
            }

            // Documentos subidos (si está logueado y hay registros)
            if (u != null && "postulante".equals(u.getRol())) {
                List<DocumentoPostulante> docs = docDao.listarPorCriterio(c.getId(), u.getId(), convocatoriaId);
                if (!docs.isEmpty()) {
                    out.println("<div class='mt-3'><h6>Documentos enviados:</h6><ul class='list-group'>");
                    for (DocumentoPostulante doc : docs) {
                        out.println("<li class='list-group-item d-flex justify-content-between align-items-center'>");
                        out.println("<a href='../" + doc.getRutaArchivo() + "' target='_blank'><i class='fas fa-file'></i> " + doc.getNombreArchivo() + "</a>");
                        out.println("<span class='text-muted small'>" + doc.getFechaSubida() + "</span>");
                        out.println("</li>");
                    }
                    out.println("</ul></div>");
                }
            }

            out.println("</div>"); // .card-body
            out.println("</div>"); // .card
        }
    }
}
