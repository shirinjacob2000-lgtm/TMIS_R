package com.tmis.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.tmis.util.DBUtil;

@WebServlet("/ValidateFeedbackSetupServlet")
public class ValidateFeedbackSetupServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// Session Check
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("username") == null) {
			response.sendRedirect(request.getContextPath() + "/public/login.jsp");
			return;
		}

		int postId = Integer.parseInt(request.getParameter("post_id"));
		String batch = request.getParameter("batch");
		String trainingYear = request.getParameter("training_year");

		try (Connection con = DBUtil.getConnection()) {

			String sql = "SELECT 1 FROM tmis.timetable_master " + "WHERE post_id=? AND batch=? AND training_year=?";

			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, postId);
			ps.setString(2, batch);
			ps.setString(3, trainingYear);

			ResultSet rs = ps.executeQuery();

			if (rs.next()) {

				// Timetable exists → forward to builder
				request.setAttribute("post_id", postId);
				request.setAttribute("batch", batch);
				request.setAttribute("training_year", trainingYear);

				request.getRequestDispatcher("/user/feedback_form_builder.jsp").forward(request, response);

			} else {

				request.setAttribute("error", "No timetable found for selected Post and Batch.");

				request.getRequestDispatcher("/user/create_feedback.jsp").forward(request, response);
			}

		} catch (Exception e) {
			throw new ServletException(e);
		}
	}
}
