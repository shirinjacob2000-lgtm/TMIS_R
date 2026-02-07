package com.tmis.servlet;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tmis.util.DBUtil;

/**
 * Servlet implementation class SaveTimetableServlet
 */
@WebServlet("/user/SaveTimetableServlet")
public class SaveTimetableServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String[] subjectIds = request.getParameterValues("subject_id[]");
        String[] trainerIds = request.getParameterValues("trainer_id[]");
        String[] dates = request.getParameterValues("training_date[]");
        String[] startTimes = request.getParameterValues("start_time[]");
        String[] endTimes = request.getParameterValues("end_time[]");
        //String[] times = request.getParameterValues("training_time[]");

        int postId = Integer.parseInt(request.getParameter("post_id"));
        String postName = request.getParameter("post_name");

        String batch = request.getParameter("batch");
        String year = request.getParameter("training_year");

        try (Connection con = DBUtil.getConnection()) {

            /* DELETE OLD TIMETABLE */
//            String deleteSql =
//                "DELETE FROM timetable WHERE post_id=? AND batch=? AND training_year=?";
//            PreparedStatement dps = con.prepareStatement(deleteSql);
//            dps.setInt(1, postId);
//            dps.setString(2, batch);
//            dps.setString(3, year);
//            dps.executeUpdate();

            /* INSERT NEW TIMETABLE */
        	String insertSql =
        		    "INSERT INTO tmis.timetable_master(post_id, topic_id, trainer_id, training_date, start_time, end_time, batch, training_year) " +
        		    "VALUES (?,?,?,?,?,?,?,?)";
//            String insertSql =
//                "INSERT INTO tmis.timetable_master(post_id, topic_id, trainer_id, training_date, training_time, batch, training_year) " +
//                "VALUES (?,?,?,?,?,?,?)";

            PreparedStatement ps = con.prepareStatement(insertSql);

            for (int i = 0; i < subjectIds.length; i++) {
                ps.setInt(1, postId);
                ps.setInt(2, Integer.parseInt(subjectIds[i]));
                ps.setInt(3, Integer.parseInt(trainerIds[i]));
                ps.setDate(4, Date.valueOf(dates[i]));
                ps.setTime(5, java.sql.Time.valueOf(startTimes[i] + ":00"));  // start_time
                ps.setTime(6, java.sql.Time.valueOf(endTimes[i] + ":00"));    // end_time
                //ps.setString(5, times[i]);
                ps.setString(7, batch);
                ps.setString(8, year);
                ps.addBatch();
            }

            ps.executeBatch();
            
//            String encodedPost = URLEncoder.encode(postName, StandardCharsets.UTF_8);
//
//            response.sendRedirect(
//                request.getContextPath() + "/user/timetable_view.jsp?success=1"
//              + "&post_id=" + postId
//              + "&post=" + encodedPost
//              + "&batch=" + URLEncoder.encode(batch, StandardCharsets.UTF_8)
//              + "&year=" + URLEncoder.encode(year, StandardCharsets.UTF_8)
//            );
            
         // ✅ PRG Pattern: Redirect to controller
            response.sendRedirect(
                request.getContextPath()
                + "/viewTimetable"
                + "?post_id=" + postId
                + "&batch=" + URLEncoder.encode(batch, "UTF-8")
                + "&year=" + URLEncoder.encode(year, "UTF-8")
                + "&success=1"
            );


//            response.sendRedirect(
//                "timetable_view.jsp?success=1"
//              + "&post_id=" + postId
//              + "&post=" + postName.replace(" ", "%20")
//              + "&batch=" + batch
//              + "&year=" + year
//            );

        } catch (Exception e) {   // ✅ ERROR FIX HERE
            e.printStackTrace();
            response.sendRedirect("/user/timetable_view.jsp?error=1");
        }
    }

}
