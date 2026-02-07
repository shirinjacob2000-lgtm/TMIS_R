package com.tmis.servlet;
import java.io.IOException;
import java.sql.*;
import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.tmis.util.DBUtil;

@WebServlet("/EditTimetableServlet")
public class EditTimetableServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String postId = request.getParameter("post_id");
        String batch = request.getParameter("batch");
        String year = request.getParameter("year");

        List<Map<String,String>> timetableList = new ArrayList<>();

        try(Connection con = DBUtil.getConnection()){

            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM tmis.timetable_master WHERE post_id=? AND batch=? AND training_year=?"
            );
            ps.setInt(1, Integer.parseInt(postId));
            ps.setString(2, batch);
            ps.setString(3, year);

            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                Map<String,String> row = new HashMap<>();
                row.put("id", rs.getString("id"));
                row.put("date", rs.getString("training_date"));
                row.put("time", rs.getString("training_time"));
                row.put("subject", rs.getString("subject"));
                row.put("trainer", rs.getString("trainer"));
                timetableList.add(row);
            }

        } catch(Exception e){
            e.printStackTrace();
        }

        request.setAttribute("timetableList", timetableList);
        request.setAttribute("postId", postId);
        request.setAttribute("batch", batch);
        request.setAttribute("year", year);

        request.getRequestDispatcher("/user/edit_timetable.jsp")
               .forward(request, response);
    }
}
