package com.tmis.servlet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.tmis.dao.PostDAO;
import com.tmis.dao.TopicDAO;
import com.tmis.model.Post;
import com.tmis.model.Topic;

@WebServlet("/user/add-topic")
public class AddTopicServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        PostDAO postDAO = new PostDAO();
        List<Post> postList = postDAO.getAllPosts();

        req.setAttribute("postList", postList);
        req.getRequestDispatcher("/user/add-topic.jsp").forward(req, res);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        res.setCharacterEncoding("UTF-8");

        String topicName = req.getParameter("topicName");
        String postIdStr = req.getParameter("postId");

        if (topicName == null || topicName.trim().isEmpty() ||
            postIdStr == null || postIdStr.isEmpty()) {

            res.sendRedirect(req.getContextPath() + "/user/add-topic?error=1");
            return;
        }

        Topic t = new Topic();
        t.setTopicName(topicName.trim());
        t.setPostId(Integer.parseInt(postIdStr));

        TopicDAO dao = new TopicDAO();
        boolean success = dao.addTopic(t);

        if (success) {
            res.sendRedirect(req.getContextPath() + "/user/topics?msg=added");
        } else {
            res.sendRedirect(req.getContextPath() + "/user/add-topic?error=1");
        }
    }
}
