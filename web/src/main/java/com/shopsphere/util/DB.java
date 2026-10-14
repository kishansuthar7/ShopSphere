
package com.shopsphere.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public final class DB {

    private DB() {
    }

    public static Connection getConnection() throws SQLException {
        String url = System.getenv().getOrDefault(
                "SHOPSPHERE_DB_URL",
                "jdbc:mysql://localhost:3306/shopsphere?useSSL=false&serverTimezone=Asia/Kolkata"
        );

        String user = System.getenv().getOrDefault(
                "SHOPSPHERE_DB_USER", "root"
        );

        String pass = System.getenv().getOrDefault(
                "SHOPSPHERE_DB_PASSWORD", ""
        );

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException(
                    "MySQL JDBC driver is missing from the application.", e
            );
        }

        return DriverManager.getConnection(url, user, pass);
    }
}
