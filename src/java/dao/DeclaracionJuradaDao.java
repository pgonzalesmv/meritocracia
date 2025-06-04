package dao;

import util.ConexionBD;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class DeclaracionJuradaDao {

    public boolean guardar(int idUsuario, int idConvocatoria, String rutaPdf) {
        String sql = "INSERT INTO declaracion_jurada (id_usuario, id_convocatoria, ruta_pdf) VALUES (?, ?, ?)";
        try (Connection con = ConexionBD.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, idUsuario);
            ps.setInt(2, idConvocatoria);
            ps.setString(3, rutaPdf);

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
