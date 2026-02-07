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

import com.tmis.util.DBUtil;

@WebServlet("/public/checkBatch")
public class CheckBatchServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String postCode = request.getParameter("post_code");
        String batch = request.getParameter("batch");
        String trainingYear = request.getParameter("training_year");

        int postId = 0;
        String postName = "";

        try (Connection con = DBUtil.getConnection()) {

            /* 1. Get post_id and post_name */
            PreparedStatement ps1 = con.prepareStatement(
                "SELECT post_id, post_name FROM tmis.post_master WHERE post_code=?"
            );
            ps1.setString(1, postCode);
            ResultSet rs1 = ps1.executeQuery();

            if (rs1.next()) {
                postId = rs1.getInt("post_id");
                postName = rs1.getString("post_name");
            } else {
                request.setAttribute("error", "Invalid Post Selected");
                request.getRequestDispatcher("select_batch.jsp?post=" + postCode)
                       .forward(request, response);
                return;
            }

            /* 2. Check timetable_master */
            PreparedStatement ps2 = con.prepareStatement(
                "SELECT 1 FROM tmis.timetable_master " +
                "WHERE post_id=? AND batch=? AND training_year=?"
            );
            ps2.setInt(1, postId);
            ps2.setString(2, batch);
            ps2.setString(3, trainingYear);

            ResultSet rs2 = ps2.executeQuery();

            if (rs2.next()) {
                /* Batch exists → Forward to feedback */
                request.setAttribute("post_id", postId);
                request.setAttribute("post_name", postName); // <-- NEW
                request.setAttribute("batch", batch);
                request.setAttribute("training_year", trainingYear);

                request.getRequestDispatcher("feedback_form.jsp")
                       .forward(request, response);
            } else {
                request.setAttribute("error", "No Batch Exists");
                request.getRequestDispatcher("select_batch.jsp?post=" + postCode)
                       .forward(request, response);
            }

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {    	
    	doPost(request, response);
    }
}

