package controlador;

import dao.DocumentoPostulanteDao;
import modelo.DocumentoPostulante;
import modelo.Usuario;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;

@WebServlet("/DocumentoUploadServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
                 maxFileSize = 1024 * 1024 * 10,       // 10MB
                 maxRequestSize = 1024 * 1024 * 50)    // 50MB
public class DocumentoUploadServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuario");

        int convocatoriaId = Integer.parseInt(request.getParameter("convocatoria_id"));
        int criterioId = Integer.parseInt(request.getParameter("criterio_id"));
        String comentario = request.getParameter("comentario");

        Part archivo = request.getPart("archivo");

        String nombreArchivo = archivo.getSubmittedFileName();
        String rutaRelativa = "documentos/convocatoria_" + convocatoriaId + "/postulante_" + usuario.getId();
        String rutaAbsoluta = getServletContext().getRealPath("/") + rutaRelativa;

        File carpeta = new File(rutaAbsoluta);
        if (!carpeta.exists()) {
            carpeta.mkdirs();
        }

        String rutaCompleta = rutaAbsoluta + File.separator + nombreArchivo;
        archivo.write(rutaCompleta);

        DocumentoPostulante doc = new DocumentoPostulante();
        doc.setIdPostulante(usuario.getId());
        doc.setConvocatoriaId(convocatoriaId);
        doc.setCriterioId(criterioId);
        doc.setNombreArchivo(nombreArchivo);
        doc.setRutaArchivo(rutaRelativa + "/" + nombreArchivo);
        doc.setComentario(comentario);

        DocumentoPostulanteDao dao = new DocumentoPostulanteDao();
        dao.guardar(doc);

        response.sendRedirect("postulante/documentos.jsp?convocatoria_id=" + convocatoriaId + "&subido=1");
    }
}
