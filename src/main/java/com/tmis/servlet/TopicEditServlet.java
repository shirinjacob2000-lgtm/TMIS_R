package com.tmis.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tmis.dao.PostDAO;
import com.tmis.dao.TopicDAO;
import com.tmis.model.Topic;

@WebServlet("/user/topic/edit")
public class TopicEditServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int topicId = Integer.parseInt(request.getParameter("id"));

            TopicDAO topicDAO = new TopicDAO();
            PostDAO postDAO = new PostDAO();

            Topic topic = topicDAO.getTopicById(topicId);

            if (topic == null || topic.getValid() == 1) {
                response.sendRedirect(request.getContextPath() + "/user/topics");
                return;
            }

            request.setAttribute("topic", topic);
            request.setAttribute("postList", postDAO.getAllPosts());

            request.getRequestDispatcher("/user/edit-topic.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        try {
            Topic topic = new Topic();
            topic.setTopicId(Integer.parseInt(request.getParameter("topicId")));
            topic.setTopicName(request.getParameter("topicName"));
            topic.setPostId(Integer.parseInt(request.getParameter("postId")));

            TopicDAO dao = new TopicDAO();
            dao.updateTopic(topic);

            response.sendRedirect(
                request.getContextPath() + "/user/topics?msg=updated"
            );

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}

