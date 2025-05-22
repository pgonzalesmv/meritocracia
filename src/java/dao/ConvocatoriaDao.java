package dao;

import modelo.Convocatoria;
import util.ConexionBD;

import java.sql.*;

public class ConvocatoriaDao {
    public void crear(Convocatoria c) {
        String sql = "INSERT INTO convocatoria (titulo, descripcion, fecha_inicio, fecha_fin, estado, creado_por, fecha_creacion) " +
                     "VALUES (?, ?, ?, ?, ?, ?, NOW())";

        try (Connection con = ConexionBD.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, c.getTitulo());
            ps.setString(2, c.getDescripcion());
            ps.setString(3, c.getFechaInicio());
            ps.setString(4, c.getFechaFin());
            ps.setString(5, c.getEstado());
            ps.setInt(6, c.getCreadoPor());

            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
