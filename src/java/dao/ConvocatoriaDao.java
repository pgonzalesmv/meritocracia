package dao;

import modelo.Convocatoria;
import util.ConexionBD;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ConvocatoriaDao {

    public void crear(Convocatoria c) {
        String sql = "INSERT INTO convocatoria (titulo, descripcion, fecha_inicio, fecha_fin, estado, creado_por, fecha_creacion) "
                + "VALUES (?, ?, ?, ?, ?, ?, NOW())";

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

    public List<Convocatoria> listar() {
        List<Convocatoria> lista = new ArrayList<>();
        String sql = "SELECT * FROM convocatoria ORDER BY fecha_creacion DESC";

        try (Connection con = ConexionBD.getConexion();
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Convocatoria c = new Convocatoria();
                c.setId(rs.getInt("id"));
                c.setTitulo(rs.getString("titulo"));
                c.setDescripcion(rs.getString("descripcion"));
                c.setFechaInicio(rs.getString("fecha_inicio"));
                c.setFechaFin(rs.getString("fecha_fin"));
                c.setEstado(rs.getString("estado"));
                c.setCreadoPor(rs.getInt("creado_por"));
                lista.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return lista;
    }

}
