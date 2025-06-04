package dao;

import modelo.DocumentoPostulante;
import util.ConexionBD;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DocumentoPostulanteDao {

    public boolean guardar(DocumentoPostulante doc) {
        String sql = "INSERT INTO documento_postulante (id_postulante, convocatoria_id, criterio_id, nombre_archivo, ruta_archivo, comentario) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection con = ConexionBD.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, doc.getIdPostulante());
            ps.setInt(2, doc.getConvocatoriaId());
            ps.setInt(3, doc.getCriterioId());
            ps.setString(4, doc.getNombreArchivo());
            ps.setString(5, doc.getRutaArchivo());
            ps.setString(6, doc.getComentario());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<DocumentoPostulante> listarPorCriterio(int criterioId, int postulanteId, int convocatoriaId) {
        List<DocumentoPostulante> lista = new ArrayList<>();
        String sql = "SELECT * FROM documento_postulante WHERE criterio_id = ? AND id_postulante = ? AND convocatoria_id = ? ORDER BY fecha_subida DESC";

        try (Connection con = ConexionBD.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, criterioId);
            ps.setInt(2, postulanteId);
            ps.setInt(3, convocatoriaId);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                DocumentoPostulante doc = new DocumentoPostulante();
                doc.setId(rs.getInt("id"));
                doc.setIdPostulante(rs.getInt("id_postulante"));
                doc.setConvocatoriaId(rs.getInt("convocatoria_id"));
                doc.setCriterioId(rs.getInt("criterio_id"));
                doc.setNombreArchivo(rs.getString("nombre_archivo"));
                doc.setRutaArchivo(rs.getString("ruta_archivo"));
                doc.setComentario(rs.getString("comentario"));
                doc.setFechaSubida(rs.getString("fecha_subida"));
                lista.add(doc);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return lista;
    }
}