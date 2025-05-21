package dao;

import java.sql.*;
import modelo.Usuario;
import util.ConexionBD;

public class UsuarioDao {

    public Usuario validarLogin(String email, String password) {
        Usuario usuario = null;
        String sql = "SELECT * FROM usuario WHERE email = ? AND estado = 'activo'";

        try (Connection con = ConexionBD.getConexion();
                PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {

                String hash = rs.getString("password");
                System.out.println("pass ----" + password);

                if (org.mindrot.jbcrypt.BCrypt.checkpw(password, hash)) {
                    usuario = new Usuario();
                    usuario.setId(rs.getInt("id"));
                    usuario.setDni(rs.getString("dni"));
                    usuario.setNombre(rs.getString("nombre"));
                    usuario.setApellido(rs.getString("apellido"));
                    usuario.setEmail(rs.getString("email"));
                    usuario.setRol(rs.getString("rol"));
                    usuario.setEstado(rs.getString("estado"));

                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return usuario;
    }

    public boolean registrarUsuario(Usuario u) {
        String validarSQL = "SELECT id FROM usuario WHERE dni = ? OR email = ?";
        String insertarSQL = "INSERT INTO usuario (dni, nombre, apellido, email, password, rol, estado) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = ConexionBD.getConexion();
                PreparedStatement validarStmt = con.prepareStatement(validarSQL)) {

            validarStmt.setString(1, u.getDni());
            validarStmt.setString(2, u.getEmail());
            ResultSet rs = validarStmt.executeQuery();

            if (rs.next()) {
                return false; // Usuario ya existe
            }

            PreparedStatement insertarStmt = con.prepareStatement(insertarSQL);
            insertarStmt.setString(1, u.getDni());
            insertarStmt.setString(2, u.getNombre());
            insertarStmt.setString(3, u.getApellido());
            insertarStmt.setString(4, u.getEmail());

            // Encriptar contraseña
            String hash = org.mindrot.jbcrypt.BCrypt.hashpw(u.getPassword(), org.mindrot.jbcrypt.BCrypt.gensalt());
            insertarStmt.setString(5, hash);

            insertarStmt.setString(6, u.getRol());
            insertarStmt.setString(7, u.getEstado());

            int rows = insertarStmt.executeUpdate();
            return rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
