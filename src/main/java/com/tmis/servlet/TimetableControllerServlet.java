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

@WebServlet("/viewTimetable")
public class TimetableControllerServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String postId = request.getParameter("post_id");
        String batch  = request.getParameter("batch");
        String year   = request.getParameter("year");
        String success = request.getParameter("success");
        if (success != null) {
            request.setAttribute("success", "Timetable saved successfully");
        }

        if(postId == null || batch == null || year == null){
            response.sendRedirect("user/select_timetable.jsp");
            return;
        }
        
        int postIdstr;
        try {
            postIdstr = Integer.parseInt(postId);
        } catch (NumberFormatException e) {
            response.sendRedirect(
                request.getContextPath() + "/user/select_timetable.jsp"
            );
            return;
        }

        boolean exists = false;
        String postName = "";

        try(Connection con = DBUtil.getConnection()){

            // 1️⃣ Check timetable existence
            PreparedStatement ps = con.prepareStatement(
                "SELECT COUNT(*) FROM tmis.timetable_master " +
                "WHERE post_id=? AND batch=? AND training_year=?"
            );
            ps.setInt(1, Integer.parseInt(postId));
            ps.setString(2, batch);
            ps.setString(3, year);

            ResultSet rs = ps.executeQuery();
            if(rs.next() && rs.getInt(1) > 0){
                exists = true;
            }

            // 2️⃣ Fetch post name
            PreparedStatement ps2 = con.prepareStatement(
                "SELECT post_name FROM tmis.post_master WHERE post_id=?"
            );
            ps2.setInt(1, Integer.parseInt(postId));
            ResultSet rs2 = ps2.executeQuery();
            if(rs2.next()){
                postName = rs2.getString("post_name");
            }

        } catch (Exception e) {
            throw new ServletException(e);
        }

        if(!exists){
            request.setAttribute("error", "Timetable does not exist");
            request.getRequestDispatcher("user/select_timetable.jsp")
                   .forward(request, response);
            return;
        }

        // 3️⃣ Pass data to view
        request.setAttribute("post_id", postId);
        request.setAttribute("post", postName);
        request.setAttribute("batch", batch);
        request.setAttribute("year", year);

        request.getRequestDispatcher("user/timetable_view.jsp")
               .forward(request, response);
    }
}
