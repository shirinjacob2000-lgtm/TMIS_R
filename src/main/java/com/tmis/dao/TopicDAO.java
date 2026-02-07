package com.tmis.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.tmis.model.Topic;
import com.tmis.util.DBUtil;

public class TopicDAO {

    // List all topics with post name
    public List<Topic> getAllTopics() {

        List<Topic> list = new ArrayList<>();

        String sql =
                "SELECT t.topic_id, t.topic_name, t.post_id, t.valid, t.created_at, " +
                "       p.post_name " +
                "FROM tmis.topic_master t " +
                "JOIN tmis.post_master p ON t.post_id = p.post_id " +
                "ORDER BY t.topic_id ASC";
        
//        String sql =
//            "SELECT t.topic_id, t.topic_name, t.post_id, t.valid, t.created_at, " +
//            "       p.post_name " +
//            "FROM tmis.topic_master t " +
//            "JOIN tmis.post_master p ON t.post_id = p.post_id " +
//            "ORDER BY t.topic_id DESC";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {

            while (rs.next()) {

                Topic topic = new Topic();

                topic.setTopicId(rs.getInt("topic_id"));
                topic.setTopicName(rs.getString("topic_name"));
                topic.setPostId(rs.getInt("post_id"));
                topic.setPostName(rs.getString("post_name"));
                topic.setValid(rs.getInt("valid"));
                topic.setCreatedAt(rs.getTimestamp("created_at"));

                list.add(topic);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
    //Add topic
    public boolean addTopic(Topic t) {

        String sql = """
            INSERT INTO tmis.topic_master
            (topic_name, post_id, valid, created_at)
            VALUES (?, ?, 0, now())
        """;

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, t.getTopicName());
            ps.setInt(2, t.getPostId());

            return ps.executeUpdate() == 1;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    //Get topic by ID
    public Topic getTopicById(int topicId) throws Exception {
        Topic topic = null;

        String sql = "SELECT topic_id, topic_name, post_id, valid, created_at " +
                     "FROM tmis.topic_master " +
                     "WHERE topic_id = ?";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, topicId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                topic = new Topic();
                topic.setTopicId(rs.getInt("topic_id"));
                topic.setTopicName(rs.getString("topic_name"));
                topic.setPostId(rs.getInt("post_id"));
                topic.setValid(rs.getInt("valid"));
                topic.setCreatedAt(rs.getTimestamp("created_at"));
            }
        }
        return topic;
    }
    
    //Update topic
    public boolean updateTopic(Topic topic) throws Exception {

        String sql = "UPDATE tmis.topic_master " +
                     "SET topic_name = ?, post_id = ? " +
                     "WHERE topic_id = ? AND valid = 0";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, topic.getTopicName());
            ps.setInt(2, topic.getPostId());
            ps.setInt(3, topic.getTopicId());

            return ps.executeUpdate() > 0;
        }
    }
    
    //Disable/Enable Topic
    public boolean updateTopicStatus(int topicId, int valid) throws Exception {

        String sql = "UPDATE tmis.topic_master SET valid = ? WHERE topic_id = ?";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, valid);
            ps.setInt(2, topicId);

            return ps.executeUpdate() > 0;
        }
    }

	public Object getActiveTopicsByPost(int postId) {
		 List<Topic> list = new ArrayList<>();

		    String sql = "SELECT t.topic_id, t.topic_name " +
		                 "FROM tmis.topic_master t " +
		                 "WHERE t.post_id = ? AND t.valid = 0 " +
		                 "ORDER BY t.topic_name";

		    try (Connection con = DBUtil.getConnection();
		         PreparedStatement ps = con.prepareStatement(sql)) {

		        ps.setInt(1, postId);
		        ResultSet rs = ps.executeQuery();

		        while (rs.next()) {
		            Topic t = new Topic();
		            t.setTopicId(rs.getInt("topic_id"));
		            t.setTopicName(rs.getString("topic_name"));
		            list.add(t);
		        }

		    } catch (Exception e) {
		        e.printStackTrace();
		    }
		    return list;
	}

}