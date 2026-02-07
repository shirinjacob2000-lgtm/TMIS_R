package com.tmis.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tmis.dao.TopicDAO;

@WebServlet("/user/topic/status")
public class TopicStatusServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int topicId = Integer.parseInt(request.getParameter("id"));
            String action = request.getParameter("action");

            TopicDAO dao = new TopicDAO();

            if ("disable".equals(action)) {
                dao.updateTopicStatus(topicId, 1);
                response.sendRedirect(
                    request.getContextPath() + "/user/topics?msg=disabled"
                );
                return;
            }

            if ("enable".equals(action)) {
                dao.updateTopicStatus(topicId, 0);
                response.sendRedirect(
                    request.getContextPath() + "/user/topics?msg=enabled"
                );
                return;
            }

            response.sendRedirect(request.getContextPath() + "/user/topics");

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}

