package com.tmis.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tmis.util.DBUtil;

@WebServlet("/DownloadTimetableWordServlet")
public class DownloadTimetableWordServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String postId = request.getParameter("post_id");
        String post = request.getParameter("post");
        String batch = request.getParameter("batch");
        String year = request.getParameter("year");
        
        String fileName = "Timetable_" + post + ".doc";
        
     // Encode filename for HTTP header (UTF-8)
        String encodedFileName = URLEncoder
                .encode(fileName, StandardCharsets.UTF_8)
                .replace("+", "%20");

        response.setContentType("application/msword");
		response.setHeader(
            "Content-Disposition",
            "attachment; filename=\"Timetable.doc\"; filename*=UTF-8''" + encodedFileName
        );

        PrintWriter out = response.getWriter();

        /* ================= HTML START ================= */
        out.println("<html><head>");
        out.println("<meta charset='UTF-8'>");
        out.println("<style>");
        out.println("body{font-family:Mangal,Arial;} ");
        out.println("table{width:100%;border-collapse:collapse;} ");
        out.println("th,td{border:1px solid #000;padding:6px;text-align:center;} ");
        out.println("th{background:#e6e6e6;} ");
        out.println("h2,h3{text-align:center;} ");
        out.println("</style>");
        out.println("</head><body>");

        /* ===== LOGO ===== */
        out.println("<div style='text-align:center;'>");
        out.println("<img src='https://www.mpez.co.in/static/assets/img/MPPKVVCL%20Logo.png' width='120'/>");
        out.println("</div>");

        /* ===== HEADER ===== */
        out.println("<h2>केन्द्रीय प्रशिक्षण संस्थान</h2>");
        out.println("<h3>मध्यप्रदेश पूर्व क्षेत्र विद्युत वितरण कंपनी लिमिटेड, जबलपुर</h3>");
        out.println("<p align='center'><b>" + post +
                " | सत्र क्रमांक: " + batch +
                " | प्रशिक्षण अवधि: " + year + "</b></p>");

        /* ===== TIME TABLE ===== */
        out.println("<table>");
        out.println("<tr>");
        out.println("<th>Date</th><th>Time</th><th>Subject</th><th>Trainer</th>");
        out.println("</tr>");

        try (Connection con = DBUtil.getConnection()) {

            String sql =
              "SELECT t.training_date, t.training_time, s.topic_name, tr.trainer_name " +
              "FROM tmis.timetable_master t " +
              "JOIN tmis.topic_master s ON t.topic_id=s.topic_id " +
              "JOIN tmis.trainer_master tr ON t.trainer_id=tr.trainer_id " +
              "WHERE t.post_id=? AND t.batch=? AND t.training_year=? " +
              "ORDER BY t.training_date, t.training_time";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(postId));
            ps.setString(2, batch);
            ps.setString(3, year);

            ResultSet rs = ps.executeQuery();

            List<Map<String,String>> rows = new ArrayList<>();
            while(rs.next()){
                Map<String,String> r = new HashMap<>();
                r.put("date", rs.getDate("training_date").toString());
                r.put("time", rs.getString("training_time"));
                r.put("subject", rs.getString("topic_name"));
                r.put("trainer", rs.getString("trainer_name"));
                rows.add(r);
            }

            Map<String,Integer> rowspanMap = new LinkedHashMap<>();
            for(Map<String,String> r : rows){
                String d = r.get("date");
                rowspanMap.put(d, rowspanMap.getOrDefault(d, 0) + 1);
            }

            Set<String> printedDate = new HashSet<>();
            for(Map<String,String> r : rows){
                String d = r.get("date");
                out.println("<tr>");
                if(!printedDate.contains(d)){
                    out.println("<td rowspan='" + rowspanMap.get(d) + "'>" + d + "</td>");
                    printedDate.add(d);
                }
                out.println("<td>" + r.get("time") + "</td>");
                out.println("<td>" + r.get("subject") + "</td>");
                out.println("<td>" + r.get("trainer") + "</td>");
                out.println("</tr>");
            }

        } catch (Exception e) {
            out.println("<tr><td colspan='4'>" + e.getMessage() + "</td></tr>");
        }

        out.println("</table>");

        out.println("<p><b>नोट:</b> दोपहर 01:30 से 02:30 तक भोजनावकाश रहेगा।</p>");

        /* ===== COPY LIST ===== */
        out.println("<h3>प्रतिलिपि :</h3>");
        out.println("<ol>");

        /* ---- FIXED MAIN OFFICERS ---- */
        out.println("<li>मुख्य महाप्रबंधक (मा. संसा. एवं प्रसा.), म.प्र.पू.क्षे.वि.वि.कं.लि., जबलपुर</li>");
        out.println("<li>मुख्य वित्तीय अधिकारी, म.प्र.पू.क्षे.वि.वि.कं.लि., जबलपुर</li>");
        out.println("<li>मुख्य अभियंता, म.प्र.पू.क्षे.वि.वि.कं.लि.</li>");
        out.println("<li>अधीक्षण अभियंता (शहर), म.प्र.पू.क्षे.वि.वि.कं.लि.</li>");
        out.println("<li>वरिष्ठ लेखाधिकारी, म.प्र.पू.क्षे.वि.वि.कं.लि.</li>");
        out.println("<li>कार्यपालन अभियंता / सहायक अभियंता, जबलपुर</li>");

        /* ---- DYNAMIC TRAINERS ---- */
        try(Connection con = DBUtil.getConnection()){
            String sql =
              "SELECT DISTINCT trainer_name, trainer_designation, office " +
              "FROM tmis.trainer_master " +
              "WHERE trainer_id IN (" +
              " SELECT trainer_id FROM tmis.timetable_master " +
              " WHERE post_id=? AND batch=? AND training_year=? )";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(postId));
            ps.setString(2, batch);
            ps.setString(3, year);

            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                out.println("<li>" + rs.getString("trainer_name") + ", " +
                        rs.getString("trainer_designation") + ", " +
                        rs.getString("office") +
                        "</li>");
            }
        } catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

        out.println("</ol>");

        out.println("</body></html>");
        out.close();
    }
}

