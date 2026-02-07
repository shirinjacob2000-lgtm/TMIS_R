<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String username = (String) session.getAttribute("username");
String role = (String) session.getAttribute("role");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Edit Trainer</title>

<!-- Bootstrap -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Font Awesome -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
	rel="stylesheet">

<!-- Custom CSS -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/style.css">

</head>

<body>
	<%@ include file="/common/header.jsp"%>
	<%--<%@ include file="/common/sidebar.jsp"%> --%>
	
	<%
	if (username != null) {
	%>
	<nav class="navbar navbar-light bg-light">
		<div class="container-fluid container mt-4">
			<span class="navbar-brand"><h4>
					Welcome, <strong><%=username%></strong>
				</h4></span>

			<div class="ms-auto">
				<a href="<%=request.getContextPath()%>/LogoutServlet"
					class="btn btn-sm btn-danger"> Logout </a>
			</div>
		</div>
	</nav>

	<%
	}
	%>

	<div class="container mt-4">
		<h4>Edit Trainer</h4>

		<%-- <form action="<%=request.getContextPath()%>/user/trainer-update"
			method="post"> --%>
			
			<form action="<%=request.getContextPath()%>/user/trainers?action=update"
			method="post">

			<input type="hidden" name="trainerId" value="${trainer.trainerId}" />

			<div class="mb-3">
				<label>Trainer Name</label> <input type="text" name="trainerName"
					value="${trainer.trainerName}" class="form-control" required>
			</div>

			<div class="mb-3">
				<label>Designation</label> <input type="text"
					name="trainerDesignation" value="${trainer.trainerDesignation}"
					class="form-control">
			</div>

			<div class="mb-3">
				<label>Employee ID</label> <input type="text" name="employeeId"
					value="${trainer.employeeId}" class="form-control">
			</div>

			<div class="mb-3">
				<label>Type</label> <input type="text" name="type"
					value="${trainer.type}" class="form-control">
			</div>

			<div class="mb-3">
				<label>Office</label> <input type="text" name="office"
					value="${trainer.office}" class="form-control">
			</div>

			<button type="submit" class="btn btn-primary">Update Trainer
			</button>

			<a href="<%=request.getContextPath()%>/user/trainers"
				class="btn btn-secondary"> Cancel </a>
		</form>
	</div>

	<%@ include file="/common/footer.jsp"%>
	<script>
		function toggleSidebar() {
			document.getElementById("sidebar").classList.toggle("collapsed");
			document.getElementById("mainContent").classList.toggle("expanded");
		}
	</script>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js">
		
	</script>
	
</body>
</html>