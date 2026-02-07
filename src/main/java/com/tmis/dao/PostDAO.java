package com.tmis.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.tmis.model.Post;
import com.tmis.util.DBUtil;

public class PostDAO {

    public List<Post> getAllPosts() {
        List<Post> list = new ArrayList<>();

        String sql = "SELECT post_id, post_name FROM tmis.post_master ORDER BY post_name";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Post p = new Post();
                p.setPostId(rs.getInt("post_id"));
                p.setPostName(rs.getString("post_name"));
                list.add(p);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
