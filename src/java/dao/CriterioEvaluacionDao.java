package dao;

import modelo.CriterioEvaluacion;
import util.ConexionBD;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CriterioEvaluacionDao {

    public boolean crear(CriterioEvaluacion c) {
        String sql = "INSERT INTO criterio_evaluacion (convocatoria_id, categoria, subcategoria, descripcion, puntaje_maximo, formula_calculo, orden, activo) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = ConexionBD.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, c.getConvocatoriaId());
            ps.setString(2, c.getCategoria());
            ps.setString(3, c.getSubcategoria());
            ps.setString(4, c.getDescripcion());
            ps.setDouble(5, c.getPuntajeMaximo());
            ps.setString(6, c.getFormulaCalculo());
            ps.setInt(7, c.getOrden());
            ps.setBoolean(8, c.isActivo());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<CriterioEvaluacion> listarPorConvocatoria(int convocatoriaId) {
        List<CriterioEvaluacion> lista = new ArrayList<>();
        String sql = "SELECT * FROM criterio_evaluacion WHERE convocatoria_id = ? ORDER BY orden ASC";

        try (Connection con = ConexionBD.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, convocatoriaId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                CriterioEvaluacion c = new CriterioEvaluacion();
                c.setId(rs.getInt("id"));
                c.setConvocatoriaId(rs.getInt("convocatoria_id"));
                c.setCategoria(rs.getString("categoria"));
                c.setSubcategoria(rs.getString("subcategoria"));
                c.setDescripcion(rs.getString("descripcion"));
                c.setPuntajeMaximo(rs.getDouble("puntaje_maximo"));
                c.setFormulaCalculo(rs.getString("formula_calculo"));
                c.setOrden(rs.getInt("orden"));
                c.setActivo(rs.getBoolean("activo"));
                lista.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return lista;
    }
}
