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

@WebServlet("/public/SubmitFeedbackServlet")
public class SubmitFeedbackServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        // ---- BASIC FIELDS ----
        int postId = Integer.parseInt(request.getParameter("post_id"));
        String batch = request.getParameter("batch");
        String year = request.getParameter("year");

        String rollNo = request.getParameter("trainee_roll_no");
        String traineeName = request.getParameter("trainee_name");
        String officeName = request.getParameter("trainee_office_name");
        String empId = request.getParameter("trainee_emp_id");

        String canteenRating = request.getParameter("canteen_rating");
        String hostelCleanliness = request.getParameter("hostel_cleanliness");
        String hostelWater = request.getParameter("hostel_water");
        String hostelElectricity = request.getParameter("hostel_electricity");
        String hostelFoodQuality = request.getParameter("hostel_food_quality");
        String remarks = request.getParameter("remarks");

        try (Connection con = DBUtil.getConnection()) {

            /* ================================
               1️⃣ DUPLICATE SUBMISSION CHECK
               ================================ */
            String duplicateSql =
                "SELECT 1 FROM tmis.feedback_master " +
                "WHERE post_id=? AND batch=? AND training_year=? AND trainee_roll_no=?";

            try (PreparedStatement dupPs = con.prepareStatement(duplicateSql)) {
                dupPs.setInt(1, postId);
                dupPs.setString(2, batch);
                dupPs.setString(3, year);
                dupPs.setString(4, rollNo);

                ResultSet rs = dupPs.executeQuery();
                if (rs.next()) {
                    response.getWriter().println(
                        "<h3 style='color:red;text-align:center'>" +
                        "Feedback already submitted for this trainee." +
                        "</h3>");
                    return;
                }
            }

            /* ================================
               2️⃣ INSERT QUERY
               ================================ */
            String insertSql =
                "INSERT INTO tmis.feedback_master (" +
                "post_id, batch, training_year, trainee_roll_no, trainee_name, " +
                "trainee_office_name, trainee_employee_id, " +
                "q1,q2,q3,q4,q5,q6,q7,q8,q9,q10," +
                "q11,q12,q13,q14,q15,q16,q17,q18,q19,q20," +
                "q21,q22,q23,q24,q25,q26,q27,q28,q29,q30," +
                "q31,q32,q33,q34,q35,q36,q37,q38,q39,q40," +
                "canteen_rating, hostel_cleanliness, hostel_water, " +
                "hostel_electricity, hostel_food_quality, remarks, submitted_at" +
                ") VALUES (" +
                "?,?,?,?,?,?,?, " +
                "?,?,?,?,?,?,?,?,?,?," +
                "?,?,?,?,?,?,?,?,?,?," +
                "?,?,?,?,?,?,?,?,?,?," +
                "?,?,?,?,?,?,?,?,?,?," +
                "?,?,?,?,?,?,now()" +
                ")";

            try (PreparedStatement ps = con.prepareStatement(insertSql)) {

                int idx = 1;

                ps.setInt(idx++, postId);
                ps.setString(idx++, batch);
                ps.setString(idx++, year);
                ps.setString(idx++, rollNo);
                ps.setString(idx++, traineeName);
                ps.setString(idx++, officeName);
                ps.setString(idx++, empId);

                // q1 to q40
                for (int i = 1; i <= 40; i++) {
                    ps.setString(idx++, request.getParameter("q" + i));
                }

                ps.setString(idx++, canteenRating);
                ps.setString(idx++, hostelCleanliness);
                ps.setString(idx++, hostelWater);
                ps.setString(idx++, hostelElectricity);
                ps.setString(idx++, hostelFoodQuality);
                ps.setString(idx++, remarks);

                ps.executeUpdate();
            }

            response.getWriter().println(
                "<h3 style='color:green;text-align:center'>" +
                "Feedback submitted successfully. Thank you!" +
                "</h3>");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println(
                "<h3 style='color:red'>Error: " + e.getMessage() + "</h3>");
        }
    }
}

