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

    public boolean registrarUsuario(Usuario u) {
        String sql = "INSERT INTO usuario (dni, nombre, apellido, email, password, rol, estado) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = ConexionBD.getConexion();
                PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, u.getDni());
            ps.setString(2, u.getNombre());
            ps.setString(3, u.getApellido());
            ps.setString(4, u.getEmail());
            ps.setString(5, u.getPassword()); // luego cifrado
            ps.setString(6, u.getRol());
            ps.setString(7, u.getEstado());

            int rows = ps.executeUpdate();
            return rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

}
