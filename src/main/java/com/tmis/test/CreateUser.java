package com.tmis.test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import org.mindrot.jbcrypt.BCrypt;

public class CreateUser {

    public static void main(String[] args) {

        String username = "ctiuser";
        String plainPassword = "cti@123";
        String role = "USER";

        String hashedPassword = BCrypt.hashpw(plainPassword, BCrypt.gensalt());

        String sql = "INSERT INTO tmis.users (username, password, role) VALUES (?, ?, ?)";

        try {
            Class.forName("org.postgresql.Driver");

            Connection conn = DriverManager.getConnection(
                "jdbc:postgresql://192.168.68.50:5432/postgres",
                "postgres",
                "postgres"
            );

            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, username);
            pst.setString(2, hashedPassword);
            pst.setString(3, role);

            pst.executeUpdate();

            System.out.println("User created successfully!");
            System.out.println("Username: " + username);
            System.out.println("Password: " + plainPassword);
            System.out.println("Role: " + role);

            pst.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

