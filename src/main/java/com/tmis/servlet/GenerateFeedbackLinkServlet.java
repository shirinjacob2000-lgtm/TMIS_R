package com.tmis.servlet;

import java.io.IOException;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.tmis.util.DBUtil;

@WebServlet("/user/GenerateFeedbackLinkServlet")
public class GenerateFeedbackLinkServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user_id") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        int userId = (int) session.getAttribute("user_id");
        int postId = Integer.parseInt(request.getParameter("post_id"));
        String batch = request.getParameter("batch");
        String trainingYear = request.getParameter("training_year");

        try (Connection con = DBUtil.getConnection()) {

            // 1️⃣ Check existing active link
            String checkSql =
                "SELECT token FROM tmis.feedback_form_links " +
                "WHERE post_id=? AND batch=? AND training_year=? " +
                "AND expiry_time > NOW()";

            PreparedStatement checkPs = con.prepareStatement(checkSql);
            checkPs.setInt(1, postId);
            checkPs.setString(2, batch);
            checkPs.setString(3, trainingYear);

            ResultSet rs = checkPs.executeQuery();

            if (rs.next()) {

                request.setAttribute("error",
                    "Active link already exists for this Post & Batch.");

                request.getRequestDispatcher("/user/feedback_form_builder.jsp")
                       .forward(request, response);
                return;
            }

            // 2️⃣ Generate token
            String token = UUID.randomUUID().toString();

            LocalDateTime now = LocalDateTime.now();
            LocalDateTime expiry = now.plusHours(48);

            // 3️⃣ Insert new link
            String insertSql =
                "INSERT INTO tmis.feedback_form_links " +
                "(user_id, post_id, batch, training_year, token, created_time, expiry_time) " +
                "VALUES (?,?,?,?,?,?,?)";

            PreparedStatement ps = con.prepareStatement(insertSql);
            ps.setInt(1, userId);
            ps.setInt(2, postId);
            ps.setString(3, batch);
            ps.setString(4, trainingYear);
            ps.setString(5, token);
            ps.setTimestamp(6, Timestamp.valueOf(now));
            ps.setTimestamp(7, Timestamp.valueOf(expiry));

            ps.executeUpdate();

            // 4️⃣ Build public link
            String feedbackLink =
                request.getScheme() + "://" +
                request.getServerName() + ":" +
                request.getServerPort() +
                request.getContextPath() +
                "/public/feedback_form.jsp?token=" + token;

            request.setAttribute("generatedLink", feedbackLink);

            request.getRequestDispatcher("/user/link_generated.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
