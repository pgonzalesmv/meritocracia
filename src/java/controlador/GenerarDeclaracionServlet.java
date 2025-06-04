package controlador;

import dao.CriterioEvaluacionDao;
import dao.DeclaracionJuradaDao;
import dao.DocumentoPostulanteDao;
import modelo.CriterioEvaluacion;
import modelo.DocumentoPostulante;
import modelo.Usuario;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.Map;

@WebServlet("/GenerarDeclaracionServlet")
public class GenerarDeclaracionServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws IOException {
        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuario");

        int convocatoriaId = Integer.parseInt(request.getParameter("convocatoria_id"));
        String nombre = usuario.getNombre();

        // Obtener criterios y documentos
        CriterioEvaluacionDao criterioDao = new CriterioEvaluacionDao();
        DocumentoPostulanteDao docDao = new DocumentoPostulanteDao();
        List<CriterioEvaluacion> criterios = criterioDao.listarPorConvocatoria(convocatoriaId);

        Map<String, List<String>> resumen = new LinkedHashMap<>();
        for (CriterioEvaluacion c : criterios) {
            List<DocumentoPostulante> docs = docDao.listarPorCriterio(c.getId(), usuario.getId(), convocatoriaId);
            List<String> archivos = new ArrayList<>();
            for (DocumentoPostulante d : docs) {
                archivos.add(d.getNombreArchivo());
            }
            resumen.put(c.getCategoria(), archivos);
        }

        // Crear directorio
        String carpeta = getServletContext().getRealPath("/") + "declaraciones/";
        File dir = new File(carpeta);
        if (!dir.exists()) dir.mkdirs();

        // Ruta del PDF
        String nombreArchivo = "declaracion_" + usuario.getId() + "_conv" + convocatoriaId + ".pdf";
        String rutaCompleta = carpeta + nombreArchivo;

        // Generar PDF
        try {
            Document doc = new Document();
            PdfWriter.getInstance(doc, new FileOutputStream(rutaCompleta));
            doc.open();

            doc.add(new Paragraph("DECLARACIÓN JURADA", FontFactory.getFont(FontFactory.HELVETICA_BOLD, 16)));
            doc.add(new Paragraph(" "));
            doc.add(new Paragraph("Yo, " + nombre + ", declaro bajo juramento que la información proporcionada en los siguientes documentos es veraz y completa:"));
            doc.add(new Paragraph(" "));

            for (Map.Entry<String, List<String>> entry : resumen.entrySet()) {
                doc.add(new Paragraph("Criterio: " + entry.getKey(), FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12)));
                List<String> archivos = entry.getValue();
                if (archivos.isEmpty()) {
                    doc.add(new Paragraph("  - Sin documentos cargados", FontFactory.getFont(FontFactory.HELVETICA, 11)));
                } else {
                    for (String nombreDoc : archivos) {
                        doc.add(new Paragraph("  - " + nombreDoc, FontFactory.getFont(FontFactory.HELVETICA, 11)));
                    }
                }
                doc.add(new Paragraph(" "));
            }

            doc.add(new Paragraph("Fecha de firma: " + new Date()));
            doc.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Guardar en BD
        DeclaracionJuradaDao djDao = new DeclaracionJuradaDao();
        boolean exito = djDao.guardar(usuario.getId(), convocatoriaId, "declaraciones/" + nombreArchivo);

        if (exito) {
            response.sendRedirect("postulante/mensaje.jsp?exito=1");
        } else {
            response.sendRedirect("postulante/mensaje.jsp?exito=0");
        }
    }
}
