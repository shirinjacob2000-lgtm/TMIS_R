package com.tmis.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tmis.dao.TopicDAO;
import com.tmis.model.Topic;

@WebServlet("/user/topics")
public class TopicServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // UTF-8 safety (EncodingFilter already exists, but keeping safe)
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        TopicDAO topicDAO = new TopicDAO();
        List<Topic> topicList = topicDAO.getAllTopics();

        // Set data for JSP
        request.setAttribute("topicList", topicList);

        // Optional message handling
        String msg = request.getParameter("msg");
        if (msg != null) {
            request.setAttribute("msg", msg);
        }

        // Forward to JSP (NOT redirect)
        request.getRequestDispatcher("/user/manage-topics.jsp")
               .forward(request, response);
    }
}