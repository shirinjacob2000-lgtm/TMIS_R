<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<%@ page import="java.sql.*, com.tmis.util.DBUtil" %>
	
	<%
String postName   = (String) request.getAttribute("post");
String batch  = (String) request.getAttribute("batch");
String year   = (String) request.getAttribute("year");
int postId = Integer.parseInt(
	    request.getAttribute("post_id").toString()
	);
%>
	
	
		<!DOCTYPE html>
		<html>

		<head>
			<meta charset="UTF-8">
			<meta name="viewport" content="width=device-width, initial-scale=1">
			
			<title>Time Table Sheet | TMIS</title>

			<style>
				@page {
					size: A4;
					margin: 10mm;
				}

				body {
					font-family: Arial, sans-serif;
					background: #f4f6f9;
					margin: 0;
					padding: 0;
				}

				.sheet {
					width: 950px;
					margin: 40px auto;
					background: #fff;
					padding: 25px;
					border-radius: 8px;
					box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
				}

				.header {
					text-align: center;
					margin-bottom: 20px;
				}

				.header img {
					height: 100px;
					margin-bottom: 10px;
				}

				.header h2 {
					margin: 5px 0;
					font-size: 22px;
					font-weight: bold;
					color: #003366;
				}

				.header p {
					margin: 2px 0;
					font-size: 14px;
				}

				.header b {
					color: #003366;
				}

				.extra-info {
					display: flex;
					justify-content: space-between;
					/* left & right */
					align-items: center;
					margin-top: 10px;
					font-size: 14px;
					font-weight: bold;
				}

				.extra-info .left {
					text-align: left;
				}

				.extra-info .right {
					text-align: right;
				}

				table {
					width: 100%;
					border-collapse: collapse;
					margin-top: 15px;
				}

				th,
				td {
					border: 1px solid #000;
					padding: 8px;
					text-align: center;
				}

				th {
					background: #e6e6e6;
				}

				.button-group {
					text-align: center;
					margin-top: 25px;
				}

				button {
					padding: 8px 15px;
					margin: 5px;
					border: none;
					background: #003366;
					color: white;
					cursor: pointer;
					border-radius: 5px;
					font-weight: bold;
				}

				button:hover {
					background: #0055aa;
				}

				.note {
					margin-top: 10px;
					font-size: 14px;
					font-weight: bold;
					text-align: center;
				}

				/* Print styling */
				@media print {
					body {
						background: white;
						margin: 0;
						padding: 0;
					}

					.sheet {
						width: 90% !important;
						margin: 0 auto !important;
						padding: 10mm !important;
						box-shadow: none;
					}

					table {
						width: 100% !important;
					}

					.button-group {
						display: none;
					}
				}

				.signature {
					margin-top: 40px;
					text-align: right;
					font-size: 14px;
					line-height: 1.4;
				}

				.signature p {
					margin: 0;
					/* GAP REMOVE */
					padding: 0;
				}

				.signature .sign-name {
					font-weight: bold;
					/* NAME BOLD */
				}

				.copy-list {
					margin-top: 25px;
					font-size: 14px;
					line-height: 1.6;
				}

				.copy-list h4 {
					margin-bottom: 8px;
					font-size: 15px;
					text-decoration: underline;
				}

				.copy-list ol {
					padding-left: 22px;
					margin: 0;
				}

				.copy-list li {
					margin-bottom: 4px;
				}
			</style>

		</head>

		<body>

			<div class="sheet">
			
			<!-- SUCCESS MESSAGE -->
			<%-- <% if(request.getAttribute("success") != null){ %>
        <div style="color:green; font-weight:bold; text-align:center;">
            <%= request.getAttribute("success") %>
        </div>
    <% } %> --%>

				<!-- HEADER WITH LOGO -->
				<div class="header">
					<img src="https://www.mpez.co.in/static/assets/img/MPPKVVCL%20Logo.png" alt="MPPKVVCL Logo">
					<h2>केन्‍द्रीय प्रशिक्षण संस्‍थान</h2>
					<p>मध्‍यप्रदेश पूर्व क्षेत्र विद्युत वितरण कम्‍पनी लिमिटेड, जबलपुर</p>
					<p>एस.पी.बी.-2 नयागांव, जबलपुर (म.प्र.) 482008 | Email: mpez.training@gmail.com</p>
					<p>
						<%= postName %> नियमित का एक माह का क्लास रूम प्रशिक्षण
					</p>

					<p>
						<b>Post :</b>
						<%= postName %> |
							<b>सत्र क्रमांक :</b>
							<%= batch %> |
								<b>प्रशिक्षण अवधि:</b>
								<%= year %>
									<p><b>पाठ्यक्रमानुसार – समय सारिणी</b></p>
					</p>
				</div>

				<!-- EXTRA INFO ABOVE TABLE -->
				<div class="extra-info">
					<div>क्र./ अति. मु.महा.प्र./ केप्रसं / <%= postName %>
					</div>
					<b>
						<div style="margin-right:90px;">जबलपुर दिनांक -</div>
					</b>
				</div>

				<!-- TIME TABLE -->
				<table>
					<tr>
						<th>Date</th>
						<th>Start Time</th>
						<th>End Time</th>
						<!-- <th>Time</th> -->
						<th>Subject</th>
						<th>Trainer</th>
					</tr>

					<% String postIdStr=request.getParameter("post_id");
					try(Connection con=DBUtil.getConnection()){
						
						String sql = "SELECT t.training_date, t.start_time, t.end_time, s.topic_name, tr.trainer_name "
						           + "FROM tmis.timetable_master t "
						           + "JOIN tmis.topic_master s ON t.topic_id = s.topic_id "
						           + "JOIN tmis.trainer_master tr ON t.trainer_id = tr.trainer_id "
						           + "WHERE t.post_id = ? AND t.batch = ? AND t.training_year = ? "
						           + "ORDER BY t.training_date, t.start_time";
						
						/* String sql="SELECT t.training_date, t.training_time, s.topic_name, tr.trainer_name "
						+ "FROM tmis.timetable_master t " + "JOIN tmis.topic_master s ON t.topic_id=s.topic_id "
						+ "JOIN tmis.trainer_master tr ON t.trainer_id=tr.trainer_id "
						+ "WHERE t.post_id = ? AND t.batch = ? AND t.training_year = ? "
						+ "ORDER BY t.training_date, t.training_time" ; */
						 
						PreparedStatement ps=con.prepareStatement(sql);
						ps.setInt(1, postId);
						ps.setString(2, batch);
						ps.setString(3, year);
						ResultSet rs=ps.executeQuery(); // Step 1: Store all rows in a List to calculate rowspan
						java.util.List<java.util.Map<String,String>> rows = new java.util.ArrayList<>();
							while(rs.next()){
							java.util.Map<String,String> row = new java.util.HashMap<>();
									row.put("date", rs.getDate("training_date").toString());
									/* row.put("time", rs.getString("training_time"));
									   row.put("time", rs.getTime("start_time").toString() + " - " + rs.getTime("end_time").toString());*/
									row.put("start_time", rs.getTime("start_time").toString());
									row.put("end_time", rs.getTime("end_time").toString());
									row.put("subject", rs.getString("topic_name"));
									row.put("trainer", rs.getString("trainer_name"));
									rows.add(row);
									}

									// Step 2: Calculate rowspan for each date
									java.util.Map<String,Integer> rowspanMap = new java.util.LinkedHashMap<>();
											for(java.util.Map<String,String> row : rows){
												String date = row.get("date");
												rowspanMap.put(date, rowspanMap.getOrDefault(date,0)+1);
												}

												// Step 3: Render table with rowspan
												java.util.Map<String,Boolean> printedDate = new java.util.HashMap<>();
														for(java.util.Map<String,String> row : rows){
															String date = row.get("date");
															%>
															<tr>
																<% if(!printedDate.containsKey(date)){ int
																	span=rowspanMap.get(date); %>
																	<td rowspan="<%=span%>">
																		<%= date %>
																	</td>
																	<% printedDate.put(date,true); } %>
																		
																		<td>
																		<%= row.get("start_time") %>
																		</td>
																		
																		<td>
																		<%= row.get("end_time") %>
																		</td>
																		
																		<%-- <td>
																			<%= row.get("time") %>
																		</td> --%>
																		
																		<td>
																			<%= row.get("subject") %>
																		</td>
																		<td>
																			<%= row.get("trainer") %>
																		</td>
															</tr>
															<% } }catch(Exception e){ %>
																<tr>
																	<td colspan="4">
																		<%= e.getMessage() %>
																	</td>
																</tr>
																<% } %>
				</table>

				<!-- NOTE BELOW TABLE -->
				<div class="note">
					नोट- प्रत्येक दिन दोपहर 01-30 p.m. बजे से 02-30 p.m. बजे तक का समय भोजनावकाश के लिए निर्धारित किया गया है।
				</div>

				<div class="signature">
					<p class="sign-name">एस. के. गिरिया</p>
					<p>मुख्य महाप्रबंधक (प्रशिक्षण)</p>
				</div>

				<div class="extra-info">
					<div>क्र./ अति. मु.महा.प्र./ केप्रसं / <%= postName %>
					</div>
					<b>
						<div style="margin-right:90px;">जबलपुर दिनांक -</div>
					</b>
				</div>

				<!-- COPY LIST BELOW TABLE -->
				<div class="copy-list">
					<h4>प्रतिलिपि :</h4>
					<ol>
						<li>मुख्य महाप्रबंधक (मा. संसा. एवं प्रसा.) म.प्र.पू.क्षे.वि.वि.कं.लि., जबलपुर</li>
						<li>मुख्य वित्तीय अधिकारी, म.प्र.पू.क्षे.वि.वि.कं.लि., जबलपुर</li>
						<li>मुख्य अभियंता,(ज.क्षे./री.क्षे./सा.क्षे./श.क्षे.) म.प्र.पू.क्षे.वि.वि.कं.लि., जबलपुर / रीवा
							/ सागर / शहडोल</li>
						<li>अधीक्षण अभियंता (शहर/संचा./संधा.) म.प्र.पू.क्षे.वि.वि.कं.लि., जबलपुर / (उत्पादन)
							म.प्र.पा.जन.कं.लि., बरगी</li>
						<li>वरिष्ठ लेखाधिकारी / क्षेत्रीय लेखाधिकारी, म.प्र.पू.क्षे.वि.वि.कं.लि., जबलपुर</li>
						<li>कार्यपालन अभियंता / सहायक अभियंता वर्कशॉप / क्षेत्रीय भंडार / एम.टी.आर.यू. / ईईक्यूए लैब,
							म.प्र.पू.क्षे.वि.वि.कं.लि., जबलपुर</li>
						<%
/* 1️⃣ MAIN OFFICERS – exclude list */
/*java.util.Set<String> mainOfficers = new java.util.HashSet<>();
mainOfficers.add("मोहन कुमार सिंह");
mainOfficers.add("प्रशांत चौबे");
mainOfficers.add("अवनीश गुप्ता");
mainOfficers.add("मयंक सिंह");
mainOfficers.add("घनेश्वर झरबडे");
mainOfficers.add("अभय पटेल");*/
/* agar koi aur main officer ho to yahan add kar dena */

/* 2️⃣ DB Logic */
try(Connection con = DBUtil.getConnection()){

    String sql =
    "SELECT DISTINCT tr.trainer_name, tr.trainer_designation, tr.office " +
    "FROM tmis.timetable_master t " +
    "JOIN tmis.trainer_master tr ON t.trainer_id = tr.trainer_id " +
    "WHERE t.post_id = ? AND t.batch = ? AND t.training_year = ?";

    PreparedStatement ps = con.prepareStatement(sql);
    ps.setInt(1, Integer.parseInt(request.getParameter("post_id")));
    ps.setString(2, request.getParameter("batch"));
    ps.setString(3, request.getParameter("year"));

    ResultSet rs = ps.executeQuery();

    while(rs.next()){
        String name = rs.getString("trainer_name");

        /* 3️⃣ Skip MAIN OFFICERS */
        /*if(mainOfficers.contains(name)){
            continue;
        }*/

        String designation = rs.getString("trainer_designation");
        String office = rs.getString("office");
%>
        <li>
             <%= name %>, <%= designation %>, <%= office %>

        </li>
<%
    }
}catch(Exception e){
%>
    <li style="color:red;"><%= e.getMessage() %></li>
<%
}
%>
</ol>
				</div>

				<div class="signature">
					<p class="sign-name">संजय कुमार देवलिया</p>
					<p>प्रबंधक (प्रशिक्षण)</p>
				</div>

				<div class="button-group">
    <button onclick="window.print()">Download / Print PDF</button>

   <button onclick="downloadWord()">Download Word</button>

    <button onclick="location.href='<%=request.getContextPath()%>/user/manage_timetable.jsp'">Back</button>
</div>

<script>
function downloadWord(){
    const params = new URLSearchParams({
        post_id: "<%= postId %>",
        post: "<%= postName %>",
        batch: "<%= batch %>",
        year: "<%= year %>"
    });

    <%--window.location.href = "<%= request.getContextPath() %>/DownloadTimetableWordServlet?" + params.toString();--%>
    window.location.href = "<%= request.getContextPath() %>/user/timetable_word.jsp?" + params;

}
</script>


			</div>
		</body>

		</html>