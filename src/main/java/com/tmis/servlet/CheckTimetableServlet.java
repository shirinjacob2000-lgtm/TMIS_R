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


/**
 * Servlet implementation class CheckTimetableServlet
 */
@WebServlet("/CheckTimetableServlet")
public class CheckTimetableServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String postId = request.getParameter("post_id");
        String batch = request.getParameter("batch");
        String year = request.getParameter("year");

        try (Connection con = DBUtil.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                "SELECT COUNT(*) FROM tmis.timetable_master WHERE post_id=? AND batch=? AND training_year=?"
            );
            ps.setInt(1, Integer.parseInt(postId));
            ps.setString(2, batch);
            ps.setString(3, year);

            ResultSet rs = ps.executeQuery();
            if(rs.next() && rs.getInt(1) > 0){
                response.getWriter().print("available");
            } else {
                response.getWriter().print("not_available");
            }
        } catch(Exception e){
            response.getWriter().print("not_available");
            e.printStackTrace();
        }
    }

}
