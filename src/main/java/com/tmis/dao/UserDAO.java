package com.tmis.dao;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.tmis.util.DBUtil;
import com.tmis.model.User;

public class UserDAO {

    public User validateUser(String username) {

        User user = null;
        String sql = "SELECT username, password, role FROM tmis.users WHERE username=?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {

            pst.setString(1, username);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setRole(rs.getString("role"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }
}
