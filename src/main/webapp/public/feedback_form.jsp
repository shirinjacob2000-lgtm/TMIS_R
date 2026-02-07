<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*, java.util.*, com.tmis.util.DBUtil" %>

<%@ page import="java.time.LocalDate"%>

<%
int postId = (int) request.getAttribute("post_id");
String postName = (String) request.getAttribute("post_name"); // <-- NEW
String batch = (String) request.getAttribute("batch");
String year = (String) request.getAttribute("training_year");

if (postId == 0 || batch == null || year == null){
	out.println("<h3 style='color:red;text-align:center'>Invalid Access</h3>");
	return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Training Feedback Form</title>

<!-- ✅ BOOTSTRAP 5 CDN ADDED -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/style.css">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<style>
.headings {
	display: flex;
	gap: 20%; /* space between headings */
}

body {
	font-family: Arial, sans-serif;
	padding: 20px;
	background-color: #f7f7f7;
}

h2 {
	color: #333;
}

table {
	border-collapse: collapse;
	width: 100%;
	margin-bottom: 20px;
	background-color: #fff;
	border-radius: 8px;
	padding: 10px;
}

th, td {
	padding: 8px;
	border: 1px solid #ddd;
	vertical-align: top;
}

th {
	background-color: #f0f0f0;
	text-align: left;
}

input[type="text"], textarea {
	width: 95%;
	padding: 6px;
	border-radius: 4px;
	border: 1px solid #ccc;
	font-size: 14px;
	box-sizing: border-box;
}

textarea {
	resize: vertical;
}

.rating input {
	margin-right: 4px;
	vertical-align: middle;
}

.rating label {
	margin-right: 12px;
}

button {
	background-color: #4CAF50;
	color: white;
	padding: 10px 20px;
	border: none;
	border-radius: 6px;
	font-size: 16px;
	cursor: pointer;
	transition: background-color 0.3s ease, transform 0.2s ease;
	margin-right: 10px;
}

button:hover {
	background-color: #45a049;
	transform: scale(1.05);
}

button:active {
	transform: scale(0.98);
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
	font-size: 30px;
	font-weight: bold;
	color: #003366;
}

.header p {
	margin: 2px 0;
	font-size: 20px;
}

.header b {
	color: #003366;
}
</style>

</head>
<body>

<%-- <h3>Feedback Form for: <%= postName %></h3>
<p>Batch: <%= batch %> | Year: <%= year %></p> --%>

<div class="container text-center">

		<div class="header">
			<img
				src="https://www.mpez.co.in/static/assets/img/MPPKVVCL%20Logo.png"
				alt="MPPKVVCL Logo">
			<h2>केन्‍द्रीय प्रशिक्षण संस्‍थान</h2>
			<br>
			<p>मध्‍यप्रदेश पूर्व क्षेत्र विद्युत वितरण कम्‍पनी लिमिटेड,
				जबलपुर</p>
			<p>एस.पी.बी.-2 नयागांव, जबलपुर (म.प्र.) 482008 | Email:
				mpez.training@gmail.com</p>
			<p>
				<%= postName %> नियमित का एक माह का क्लास रूम प्रशिक्षण
			</p>

			<p>
				<b>Post: <%= postName %></b>
				| <b>बैच / Batch : <%= batch %></b>
				| <b>प्रशिक्षण अवधि / Training Period: <%= year %></b>
			</p>
			
			<h3 class="mt-5">प्रशिक्षण फीडबैक फ़ॉर्म</h3>
			
		</div>
	</div>
	
	<p>कृपया अपनी जानकारी सावधानीपूर्वक दर्ज करें और प्रत्येक प्रश्न के लिए एक विकल्प चुनें।</p>
	<p>Please mention your details carefully and select one option for each question.</p>
	
	<%--<p class="text-danger fw-bold">"नोट: कृपया इस पेज का अनुवाद
		(Translate) न करें।"</p> --%>
	
	<form action="<%=request.getContextPath()%>/public/SubmitFeedbackServlet" method="post"
		accept-charset="UTF-8">
	
	<input type="hidden" name="post_id" value="<%=postId%>">
	<input type="hidden" name="post_name" value="<%=postName%>">
	<input type="hidden" name="batch" value="<%=batch%>">
	<input type="hidden" name="year" value="<%=year%>">
	
	<table class="mt-5">
			
			<%-- प्रशिक्षु की जानकारी / Trainer Details --%>
			
			<tr>
				<th>रोल नंबर / Roll No. : </th>
				<td><input type="text" name="trainee_roll_no" required
					maxlength="30" placeholder="" required></td>
			</tr>
			<tr>
				<th>नाम / Name: </th>
				<td><input type="text" name="trainee_name" required
					maxlength="30" placeholder="पूरा नाम लिखें" required></td>
			</tr>
			<tr>
				<th>कार्यालय का नाम / Office Name: </th>
				<td><input type="text" name="trainee_office_name" required maxlength="50"
					placeholder="" required></td>
			</tr>
			<tr>
				<th>प्रशिक्षु की कर्मचारी आईडी (वैकल्पिक) / Trainee Employee ID (optional): </th>
				<td><input type="text" name="trainee_emp_id" maxlength="15"
					placeholder=""></td>
			</tr>
		</table>
		
<!-- Trainer + Subjects -->
<table>
<tr>
<th>क्रमांक</th>
<th>प्रशिक्षकों का नाम</th>
<th>विषय</th>
<th>बहुत अच्छा</th>
<th>अच्छा</th>
<th>सामान्य</th>
<th>खराब</th>
<th>बहुत खराब</th>
</tr>

<%
int i = 1;
try(Connection con = DBUtil.getConnection()){

PreparedStatement ps = con.prepareStatement(
    "SELECT DISTINCT t.trainer_id, tr.trainer_name, tm.topic_name " +
    "FROM tmis.timetable_master t " +
    "JOIN tmis.trainer_master tr ON tr.trainer_id = t.trainer_id " +
    "JOIN tmis.topic_master tm ON tm.topic_id = t.topic_id " +
    "WHERE t.post_id=? AND t.batch=? AND t.training_year=? " +
    "ORDER BY tr.trainer_name, tm.topic_name"
);

ps.setInt(1, postId);
ps.setString(2, batch);
ps.setString(3, year);

ResultSet rs = ps.executeQuery();

Map<Integer, List<String>> trainerSubjects = new LinkedHashMap<>();
Map<Integer, String> trainerNames = new HashMap<>();

while(rs.next()){
    int tid = rs.getInt("trainer_id");
    trainerNames.put(tid, rs.getString("trainer_name"));
    trainerSubjects.computeIfAbsent(tid, k -> new ArrayList<>())
                   .add(rs.getString("topic_name"));   // ✅ FIX
}

for(Integer tid : trainerSubjects.keySet()){
%>
<tr>
<td><%=i%></td>
<td><%=trainerNames.get(tid)%></td>
<td><%=String.join(" & ", trainerSubjects.get(tid))%></td>
<td class="rating"><input type="radio" name="q<%=i%>" value="5" required></td>
<td class="rating"><input type="radio" name="q<%=i%>" value="4"></td>
<td class="rating"><input type="radio" name="q<%=i%>" value="3"></td>
<td class="rating"><input type="radio" name="q<%=i%>" value="2"></td>
<td class="rating"><input type="radio" name="q<%=i%>" value="1"></td>

</tr>
<%
i++;
}

} catch(Exception e){
    out.println("<tr><td colspan='8'>Error : "+e.getMessage()+"</td></tr>");
}
%>
</table>
		
		
		<table>
			<tr>
				<th>भोजन सुविधा (कैंटीन) / Food Facility (Canteen) </th>
				<th>बहुत अच्छा</th>
				<th>अच्छा</th>
				<th>सामान्य</th>
				<th>खराब</th>
				<th>बहुत खराब</th>
			</tr>
			<tr>
				<td>श्यामा ट्रेडर्स (कैंटीन) का अनुभव</td>
				<td class="rating"><input type="radio" name="canteen_rating"
					value="5" required></td>
				<td class="rating"><input type="radio" name="canteen_rating"
					value="4"></td>
				<td class="rating"><input type="radio" name="canteen_rating"
					value="3"></td>
				<td class="rating"><input type="radio" name="canteen_rating"
					value="2"></td>
				<td class="rating"><input type="radio" name="canteen_rating"
					value="1"></td>
			</tr>
		</table>
		
		<table>
			<tr>
				<th>छात्रावास सुविधाएँ / Hostel facilities</th>
				<th>बहुत अच्छा</th>
				<th>अच्छा</th>
				<th>सामान्य</th>
				<th>खराब</th>
				<th>बहुत खराब</th>
			</tr>

			<tr>
				<td>सफाई</td>
				<td class="rating"><input type="radio"
					name="hostel_cleanliness" value="5" required></td>
				<td class="rating"><input type="radio"
					name="hostel_cleanliness" value="4"></td>
				<td class="rating"><input type="radio"
					name="hostel_cleanliness" value="3"></td>
				<td class="rating"><input type="radio"
					name="hostel_cleanliness" value="2"></td>
				<td class="rating"><input type="radio"
					name="hostel_cleanliness" value="1"></td>
			</tr>
			<tr>
				<td>पानी की सुविधा</td>
				<td class="rating"><input type="radio" name="hostel_water"
					value="5" required></td>
				<td class="rating"><input type="radio" name="hostel_water"
					value="4"></td>
				<td class="rating"><input type="radio" name="hostel_water"
					value="3"></td>
				<td class="rating"><input type="radio" name="hostel_water"
					value="2"></td>
				<td class="rating"><input type="radio" name="hostel_water"
					value="1"></td>
			</tr>
			<tr>
				<td>बिजली</td>
				<td class="rating"><input type="radio"
					name="hostel_electricity" value="5" required></td>
				<td class="rating"><input type="radio"
					name="hostel_electricity" value="4"></td>
				<td class="rating"><input type="radio"
					name="hostel_electricity" value="3"></td>
				<td class="rating"><input type="radio"
					name="hostel_electricity" value="2"></td>
				<td class="rating"><input type="radio"
					name="hostel_electricity" value="1"></td>
			</tr>
			<tr>
				<td>खाद्य गुणवत्ता</td>
				<td class="rating"><input type="radio"
					name="hostel_food_quality" value="5" required></td>
				<td class="rating"><input type="radio"
					name="hostel_food_quality" value="4"></td>
				<td class="rating"><input type="radio"
					name="hostel_food_quality" value="3"></td>
				<td class="rating"><input type="radio"
					name="hostel_food_quality" value="2"></td>
				<td class="rating"><input type="radio"
					name="hostel_food_quality" value="1"></td>
			</tr>
			
		</table>
		
		
		
		<table>
			<tr>
				<th>टिप्पणियाँ (यदि कोई हो) / Remarks (if any)</th>
			</tr>
			<tr>
				<td><textarea name="remarks" rows="4"></textarea></td>
			</tr>
		</table>

		<div style="margin-top: 12px;">
			<button type="submit">फीडबैक सबमिट करें / Submit FeedBack</button>
			<button type="reset">रीसेट / Reset</button>
		</div>
		
	</form>

</body>
</html>