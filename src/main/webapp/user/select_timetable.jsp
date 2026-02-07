<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.tmis.util.DBUtil"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Select Timetable | TMIS</title>

<!-- Bootstrap -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Font Awesome -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
	rel="stylesheet">

<!-- DataTables -->
<link
	href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css"
	rel="stylesheet">

<!-- Custom CSS -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/style.css">

<style>
body {
	font-family: Arial;
	background: #f4f6f9;
}

.form-box {
	width: 400px;
	margin: 80px auto;
	background: #fff;
	padding: 25px;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, .1);
}

.button{
    display:block;
    width:100%;
    padding:12px;
    margin:12px 0;
    font-size:16px;
    font-weight:bold;
    color:#fff;
    background:#003366;
    border:none;
    border-radius:6px;
    cursor:pointer;
    text-decoration:none;
    text-align:center;
}

.button:hover{
    background:#0055aa;
}

select, input{
	width: 100%;
	padding: 8px;
	margin-top: 10px;
}

.error {
	color: red;
	text-align: center;
	margin-top: 10px;
}
</style>
</head>

<body>

	<%@ include file="/common/header.jsp"%>
	
	<div class="form-box">
		<h3 style="text-align: center;">View Timetable</h3>

		<%-- <a href="manage_timetable.jsp" class="btn btn-primary mb-5"> <i
			class="fa fa-arrow-left"></i> Back
		</a> --%>

		<form action="<%=request.getContextPath()%>/viewTimetable"
			method="get">

			<label>Post</label> <select name="post_id" required>
				<option value="">-- Select Post --</option>
				<%
				try (Connection con = DBUtil.getConnection()) {
					PreparedStatement ps = con.prepareStatement("SELECT post_id, post_name FROM tmis.post_master ORDER BY post_name");
					ResultSet rs = ps.executeQuery();
					while (rs.next()) {
				%>
				<option value="<%=rs.getInt("post_id")%>">
					<%=rs.getString("post_name")%>
				</option>
				<%
				}
				}
				%>
			</select> 
			
			<label>Batch</label> <input type="text" name="batch" required>

			<label>Training Year</label> <input type="text" name="year"
				placeholder="2024-25" required>

			<button class="button" type="submit">View Timetable</button>

			<!-- BACK BUTTON -->
			<a class="button" style="background: #6c757d;"
				href="<%=request.getContextPath()%>/user/manage_timetable.jsp">
				<i class="fa fa-arrow-left"></i> Back
			</a>

			<%
			if (request.getAttribute("error") != null) {
			%>
			<div class="error"><%=request.getAttribute("error")%></div>
			<%
			}
			%>

		</form>
	</div>
	
	<%@ include file="/common/footer.jsp"%>

</body>
</html>
