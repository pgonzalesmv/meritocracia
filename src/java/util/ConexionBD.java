package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class ConexionBD {
    private static final String URL = "jdbc:mysql://localhost:3306/meritocracia";
    private static final String USER = "root";
    private static final String PASSWORD = ""; // cambia según tu config

    public static Connection getConexion() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}

