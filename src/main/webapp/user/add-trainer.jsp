<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String username = (String) session.getAttribute("username");
String role = (String) session.getAttribute("role");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Add Trainer | TMIS</title>

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

	<div class="container-fluid main-content" id="mainContent">
		<div class="row">


				<h4 class="mb-4">
					<i class="fa-solid fa-plus"></i> Add Trainer
				</h4>

				<form
					action="<%=request.getContextPath()%>/user/trainers?action=add"
					method="post" class="card p-4 shadow-sm">

					<div class="row mb-3">
						<div class="col-md-6">
							<label class="form-label">Trainer Name *</label> <input
								type="text" name="trainerName" class="form-control" required>
						</div>

						<div class="col-md-6">
							<label class="form-label">Designation *</label> <input
								type="text" name="trainerDesignation" class="form-control" required>
						</div>
					</div>

					<div class="row mb-3">
						<div class="col-md-6">
							<label class="form-label">Employee ID *</label> <input
								type="text" name="employeeId" class="form-control" required>
						</div>

						<div class="col-md-6">
							<label class="form-label">Trainer Type *</label> <input
								type="text" name="type" class="form-control" required>
						</div>
					</div>

					<div class="mb-3">
						<label class="form-label">Office *</label> <input type="text"
							name="office" class="form-control" required>
					</div>

					<div class="mt-4">
						<button type="submit" class="btn btn-success">
							<i class="fa-solid fa-save"></i> Save Trainer
						</button>

						<a href="<%=request.getContextPath()%>/user/trainers"
							class="btn btn-secondary"> Cancel </a>
					</div>

				</form>

		</div>
	</div>
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
