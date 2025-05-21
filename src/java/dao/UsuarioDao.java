package dao;

import java.sql.*;
import modelo.Usuario;
import util.ConexionBD;

public class UsuarioDao {

    public Usuario validarLogin(String email, String password) {
        Usuario usuario = null;
        String sql = "SELECT * FROM usuario WHERE email = ? AND password = ? AND estado = 'activo'";

        try (Connection con = ConexionBD.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, password); // luego se reemplaza por hash

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                usuario = new Usuario();
                usuario.setId(rs.getInt("id"));
                usuario.setDni(rs.getString("dni"));
                usuario.setNombre(rs.getString("nombre"));
                usuario.setApellido(rs.getString("apellido"));
                usuario.setEmail(rs.getString("email"));
                usuario.setRol(rs.getString("rol"));
                usuario.setEstado(rs.getString("estado"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return usuario;
    }
}
