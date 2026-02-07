package com.tmis.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tmis.util.DBUtil;

@WebServlet("/ViewFeedbackServlet")
public class ViewFeedbackServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int postId = Integer.parseInt(request.getParameter("post_id"));
        String batch = request.getParameter("batch");
        String year = request.getParameter("year");

        try (Connection con = DBUtil.getConnection()) {

            /* ================================
               1️⃣ CHECK HOW MANY FEEDBACKS
               ================================ */
            String countSql =
                "SELECT COUNT(*) FROM tmis.feedback_master " +
                "WHERE post_id=? AND batch=? AND training_year=?";

            PreparedStatement countPs = con.prepareStatement(countSql);
            countPs.setInt(1, postId);
            countPs.setString(2, batch);
            countPs.setString(3, year);

            ResultSet crs = countPs.executeQuery();
            crs.next();

            int totalFeedback = crs.getInt(1);

            if (totalFeedback == 0) {
                request.setAttribute("msg",
                        "No feedback form found for selected Post, Batch and Year");
                request.getRequestDispatcher("/user/select_feedback.jsp")
                       .forward(request, response);
                return;
            }

            /* ================================
               2️⃣ FETCH POST NAME
               ================================ */
            String postName = "";

            PreparedStatement postPs = con.prepareStatement(
                "SELECT post_name FROM tmis.post_master WHERE post_id=?");
            postPs.setInt(1, postId);

            ResultSet prs = postPs.executeQuery();
            if (prs.next()) {
                postName = prs.getString("post_name");
            }
            
            
            
            
            
            /* ================================
            2️⃣ A. FETCH TRAINERS (SAME LOGIC AS feedback_form.jsp)
            ================================ */

         Map<Integer, List<String>> trainerSubjects = new LinkedHashMap<>();
         Map<Integer, String> trainerNames = new LinkedHashMap<>();

         String trainerSql =
             "SELECT t.trainer_id, tr.trainer_name, tm.topic_name " +
             "FROM tmis.timetable_master t " +
             "JOIN tmis.trainer_master tr ON tr.trainer_id = t.trainer_id " +
             "JOIN tmis.topic_master tm ON tm.topic_id = t.topic_id " +
             "WHERE t.post_id=? AND t.batch=? AND t.training_year=? " +
             "ORDER BY tr.trainer_name, tm.topic_name";

         PreparedStatement thPs = con.prepareStatement(trainerSql);
         thPs.setInt(1, postId);
         thPs.setString(2, batch);
         thPs.setString(3, year);

         ResultSet thRs = thPs.executeQuery();

         while (thRs.next()) {
             int tid = thRs.getInt("trainer_id");
             trainerNames.put(tid, thRs.getString("trainer_name"));

             trainerSubjects
                 .computeIfAbsent(tid, k -> new ArrayList<>())
                 .add(thRs.getString("topic_name"));
         }

         /* Build headers EXACTLY like feedback_form.jsp */
         List<String> trainerHeaders = new ArrayList<>();

         for (Integer tid : trainerSubjects.keySet()) {
        	 String header =
                     trainerNames.get(tid);
//             String header =
//                 trainerNames.get(tid) +
//                 " (" + String.join(" & ", trainerSubjects.get(tid)) + ")";
             trainerHeaders.add(header);
         }

            
            
            

            /* ================================
               3️⃣ FETCH ALL FEEDBACK DATA
               ================================ */
            String dataSql =
                "SELECT * FROM tmis.feedback_master " +
                "WHERE post_id=? AND batch=? AND training_year=? " +
                "ORDER BY trainee_roll_no";
            
//            String dataSql =
//                    "SELECT * FROM tmis.feedback_master " +
//                    "WHERE post_id=? AND batch=? AND training_year=? " +
//                    "ORDER BY trainee_name";

            PreparedStatement dataPs = con.prepareStatement(dataSql);
            dataPs.setInt(1, postId);
            dataPs.setString(2, batch);
            dataPs.setString(3, year);

            ResultSet rs = dataPs.executeQuery();

            List<Map<String, String>> feedbackList = new ArrayList<>();
            ResultSetMetaData md = rs.getMetaData();
            int colCount = md.getColumnCount();

            while (rs.next()) {
                Map<String, String> row = new HashMap<>();
                for (int i = 1; i <= colCount; i++) {
                    row.put(md.getColumnName(i), rs.getString(i));
                }
                feedbackList.add(row);
            }

            /* ================================
               4️⃣ SEND DATA TO JSP
               ================================ */
            request.setAttribute("postName", postName);
            request.setAttribute("batch", batch);
            request.setAttribute("year", year);
            request.setAttribute("totalFeedback", totalFeedback);
            request.setAttribute("feedbackList", feedbackList);
            
            request.setAttribute("trainerHeaders", trainerHeaders);

            request.getRequestDispatcher("/user/view_feedback_table.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException(e);
        }
    }
}