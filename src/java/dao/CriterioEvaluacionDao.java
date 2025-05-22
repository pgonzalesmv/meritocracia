package dao;

import modelo.CriterioEvaluacion;
import util.ConexionBD;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CriterioEvaluacionDao {

    public boolean crear(CriterioEvaluacion c) {
        String sql = "INSERT INTO criterio_evaluacion (convocatoria_id, categoria, subcategoria, descripcion, puntaje_maximo, formula_calculo, orden, activo) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

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

    public boolean cargarPredefinidos(int convocatoriaId) {
        String sql = "INSERT INTO criterio_evaluacion (convocatoria_id, categoria, subcategoria, descripcion, puntaje_maximo, orden, activo) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = ConexionBD.getConexion();
                PreparedStatement ps = con.prepareStatement(sql)) {

            // Lista de criterios predefinidos
            String[][] criterios = {
                {"Producción Jurisdiccional", null, "Valoración de resoluciones y sentencias", "40", "1"},
                {"Antigüedad en el Cargo", "Jueces Superiores", "0.5 ptos x año / +1 ptos >10 años", "12", "2"},
                {"Grados Académicos", "Doctor Jurídico", "Hasta 9 puntos", "9", "3"},
                {"Grados Académicos", "Maestro Jurídico", "Hasta 8 puntos", "8", "4"},
                {"Estudios en AMAG", null, "PROFA / ASCENSO", "8", "5"},
                {"Perfeccionamiento", "Ofimática / Idiomas / Eventos", "Estudios adicionales diversos", "14", "6"},
                {"Publicaciones", null, "Publicaciones jurídicas", "3", "7"},
                {"Distinciones", null, "Premios, elecciones y reconocimientos", "3", "8"},
                {"Docencia Universitaria", null, "Últimos 7 años", "3", "9"},
                {"Deméritos", null, "Medidas disciplinarias", "0", "10"} // puntaje negativo lo definimos luego
            };

            for (String[] c : criterios) {
                ps.setInt(1, convocatoriaId);
                ps.setString(2, c[0]); // categoría
                ps.setString(3, c[1]); // subcategoría
                ps.setString(4, c[2]); // descripción
                ps.setDouble(5, Double.parseDouble(c[3]));
                ps.setInt(6, Integer.parseInt(c[4]));
                ps.setBoolean(7, true);
                ps.addBatch();
            }

            ps.executeBatch();
            return true;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
