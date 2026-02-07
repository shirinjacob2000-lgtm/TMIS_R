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
<title>Manage Trainers | TMIS</title>

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
	href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css"
	rel="stylesheet">

<!-- Custom CSS -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/style.css">
</head>

<body>

	<%@ include file="/common/header.jsp"%>
	<%-- <%@ include file="/common/sidebar.jsp"%> --%>
	
	<%-- <%
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
	
	<hr>

	<%
	}
	%> --%>

	<div class="container mt-4">


		<!-- Top Back Button -->
		<div class="d-flex justify-content-between align-items-center mb-3 ">

			<a href="<%=request.getContextPath()%>/user/dashboard_user.jsp"
				class="btn btn-primary"> <i class="fas fa-arrow-left me-1"></i>
				Back to Dashboard
			</a>

		</div>

		<c:if test="${param.msg == 'updated'}">
			<div class="alert alert-success">Trainer details updated
				successfully</div>
		</c:if>

		<c:if test="${param.msg == 'disabled'}">
			<div class="alert alert-warning">Trainer disabled successfully.
			</div>
		</c:if>

		<c:if test="${param.msg == 'enabled'}">
			<div class="alert alert-success">Trainer enabled successfully.
			</div>
		</c:if>

		<!-- <p>This is USER dashboard.</p> <div class="main-content" id="mainContent"> -->

		<!-- Main Content -->

		<div
			class="d-flex justify-content-between align-items-center main-content"
			id="mainContent">
			<h4>
				<i class="fa-solid fa-chalkboard-user"></i> Manage Trainers
			</h4>
			<a href="<%=request.getContextPath()%>/user/add-trainer.jsp"
				class="btn btn-primary btn-sm"> <i class="fa-solid fa-plus"></i>
				Add Trainer
			</a>
		</div>

		<table id="trainerTable" class="table table-bordered table-striped">
			<thead class="table-dark">
				<tr>
					<th>ID</th>
					<th>Name</th>
					<th>Designation</th>
					<th>Employee ID</th>
					<th>Type</th>
					<th>Office</th>
					<th>Status</th>
					<th>Actions</th>
				</tr>
			</thead>

			<%--<c:out value="${trainerList}" /> --%>

			<tbody>
				<c:forEach var="t" items="${trainerList}">
					<tr>
						<td>${t.trainerId}</td>
						<td>${t.trainerName}</td>
						<td>${t.trainerDesignation}</td>
						<td>${t.employeeId}</td>
						<td>${t.type}</td>
						<td>${t.office}</td>

						<!-- Status -->
						<td><c:choose>
								<c:when test="${t.valid == 0}">
									<span class="badge bg-success">ACTIVE</span>
								</c:when>
								<c:otherwise>
									<span class="badge bg-danger">DISABLED</span>
								</c:otherwise>
							</c:choose></td>

						<!-- Actions -->
						<td><c:if test="${t.valid == 0}">
								<a
									href="<%=request.getContextPath()%>/user/trainers?action=edit&id=${t.trainerId}"
									class="btn btn-warning btn-sm"> <i class="fa-solid fa-pen">
										Edit</i>
								</a>
								<a
									href="<%=request.getContextPath()%>/user/trainers?action=disable&id=${t.trainerId}"
									class="btn btn-danger btn-sm"
									onclick="return confirm('Disable this trainer?');"> <i
									class="fa-solid fa-ban"> Disable</i>
								</a>
							</c:if> <c:if test="${t.valid == 1}">
								<a
									href="<%=request.getContextPath()%>/user/trainers?action=enable&id=${t.trainerId}"
									class="btn btn-success btn-sm"
									onclick="return confirm('Enable this trainer again?');"> <i
									class="fa-solid fa-ban"> Enable</i>
								</a>
							</c:if></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>

	</div>

	<%@ include file="/common/footer.jsp"%>

	<!-- Scripts -->
	<script>
		function toggleSidebar() {
			document.getElementById("sidebar").classList.toggle("collapsed");
			document.getElementById("mainContent").classList.toggle("expanded");
		}
	</script>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
	<script
		src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
	<script
		src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>

	<script>
		$(document).ready(function() {
			$('#trainerTable').DataTable();
		});
	</script>

</body>
</html>


<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Manage Trainers</title>

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

<%@ include file="/common/header.jsp" %>

<div class="container-fluid">
    <div class="row">

        <%@ include file="/common/sidebar.jsp"%>

        <!-- MAIN CONTENT -->
        <main class="col-md-10 ms-sm-auto px-4 mt-4">

            <div class="d-flex justify-content-between align-items-center mb-3">
                <h4>Manage Trainers</h4>
                <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addTrainerModal">
                    + Add Trainer
                </button>
            </div>

            <table class="table table-bordered table-hover">
                <thead class="table-light">
                    <tr>
                        <th>#</th>
                        <th>Name</th>
                        <th>Designation</th>
                        <th>Employee ID</th>
                        <th>Type</th>
                        <th>Office</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>

                <tbody>
                    <c:forEach items="${trainerList}" var="t" varStatus="i">
                        <tr>
                            <td>${i.index + 1}</td>
                            <td>${t.trainerName}</td>
                            <td>${t.trainerDesignation}</td>
                            <td>${t.employeeId}</td>
                            <td>${t.type}</td>
                            <td>${t.office}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${t.valid == 0}">
                                        <span class="badge bg-success">ACTIVE</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-danger">DISABLED</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <a href="${pageContext.request.contextPath}/user/trainers?action=edit&id=${t.trainerId}"
                                   class="btn btn-sm btn-warning">Edit</a>

                                <c:if test="${t.valid == 0}">
                                    <a href="${pageContext.request.contextPath}/user/trainers?action=disable&id=${t.trainerId}"
                                       class="btn btn-sm btn-danger"
                                       onclick="return confirm('Disable this trainer?')">
                                       Disable
                                    </a>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

        </main>
    </div>
</div>

<!-- ADD TRAINER MODAL -->
<div class="modal fade" id="addTrainerModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <form method="post" action="${pageContext.request.contextPath}/user/trainers">
            <input type="hidden" name="action" value="add">

            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Add Trainer</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>

                <div class="modal-body row g-3">
                    <div class="col-md-6">
                        <label>Name</label>
                        <input type="text" name="trainerName" class="form-control" required>
                    </div>

                    <div class="col-md-6">
                        <label>Designation</label>
                        <input type="text" name="trainerDesignation" class="form-control" required>
                    </div>

                    <div class="col-md-6">
                        <label>Employee ID</label>
                        <input type="number" name="employeeId" class="form-control" required>
                    </div>

                    <div class="col-md-6">
                        <label>Type</label>
                        <input type="text" name="type" class="form-control">
                    </div>

                    <div class="col-md-6">
                        <label>Office</label>
                        <input type="text" name="office" class="form-control">
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="submit" class="btn btn-success">Save</button>
                </div>
            </div>
        </form>
    </div>
</div>

<%@ include file="/common/footer.jsp"%>

<script>
function toggleSidebar() {
    document.getElementById("sidebar").classList.toggle("collapsed");
    document.getElementById("mainContent").classList.toggle("expanded");
}
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
--%>
