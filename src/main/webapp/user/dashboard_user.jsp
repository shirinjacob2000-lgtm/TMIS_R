<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String username = (String) session.getAttribute("username");
String role = (String) session.getAttribute("role");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>User Dashboard - TMIS</title>
<!-- Bootstrap -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">

<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
	rel="stylesheet">

<!-- Custom CSS -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/style.css">

</head>
<body>

	

	<div class="container">
	<%@ include file="/common/sidebar.jsp"%>
		<!-- <h4>
			Welcome, <strong><%=username%></strong>
		</h4> -->


		<div class="main-content" id="mainContent">

			<%@ include file="/common/header.jsp"%>

			<%
			if (username != null) {
			%>
			<nav class="navbar navbar-light bg-light">
				<div class="container-fluid container mt-4">
					<span class="navbar-brand">
						<h4>
							Welcome, <strong><%=username%></strong>
						</h4>
					</span>

					<div class="ms-auto">
						<a href="<%=request.getContextPath()%>/LogoutServlet"
							class="btn btn-sm btn-danger"> Logout </a>
					</div>
				</div>
			</nav>

			<%
			}
			%>

			<p class="text-muted mt-4">
				Role:
				<%=role%></p>

			<hr>

			<div class="container-fluid">
				<%--<h4 class="mb-4">
				Welcome, <b><%= session.getAttribute("username") %></b>
			</h4> --%>

				<div class="row g-3">

					<div class="col-md-3">
						<div class="dashboard-card">
							<a href="<%=request.getContextPath()%>/user/trainers"><i
								class="fa fa-chalkboard-teacher"></i></a>
							<h5>Trainers</h5>
							<p>Manage Trainers</p>
						</div>
					</div>

					<div class="col-md-3">
						<div class="dashboard-card">
							<a href="<%=request.getContextPath()%>/user/topics"><i
								class="fa fa-book"></i></a>
							<h5>Subjects</h5>
							<p>Manage Subjects</p>
						</div>
					</div>

					<div class="col-md-3">
						<div class="dashboard-card">
							<a href="<%=request.getContextPath()%>/user/manage_timetable.jsp"><i
								class="fa fa-calendar-alt"></i></a>
							<h5>Timetable</h5>
							<p>Manage Timetable</p>
						</div>
					</div>

					<div class="col-md-3">
						<div class="dashboard-card">
							<a href="<%=request.getContextPath()%>/user/create_feedback.jsp"><i
								class="fa fa-comments"></i></a>
							<h5>Feedback Form</h5>
							<p>Create Link for FeedBack Form</p>
						</div>
					</div>

					<div class="col-md-3">
						<div class="dashboard-card">
							<a href="<%=request.getContextPath()%>/user/select_feedback.jsp"><i
								class="fa fa-comments"></i></a>
							<h5>View Feedback</h5>
							<p>View Submitted Feedback Data</p>
						</div>
					</div>

				</div>
			</div>

			<p class="mt-4">This is USER dashboard.</p>

		</div>
	<%@ include file="/common/footer.jsp"%>
	
	</div>

	
	<script>
		function toggleSidebar() {
			document.getElementById("sidebar").classList.toggle("collapsed");
			document.getElementById("mainContent").classList.toggle("expanded");
		}
	</script>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js">
	</script>

	<!-- <a href="<%=request.getContextPath()%>/LogoutServlet">Logout</a>  -->
</body>
</html>