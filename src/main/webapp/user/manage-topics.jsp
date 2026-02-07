<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Manage Topics | TMIS</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
          rel="stylesheet">

    <!-- DataTables -->
    <link href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css"
          rel="stylesheet">

    <!-- Custom CSS -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
</head>

<body>

<%@ include file="/common/header.jsp" %>
<!-- <%@ include file="/common/sidebar.jsp" %> -->

<div class="main-content">

		<!-- Top Back Button -->
		<div class="d-flex justify-content-between align-items-center mb-3 ">

			<a href="<%=request.getContextPath()%>/user/dashboard_user.jsp"
				class="btn btn-primary"> <i class="fas fa-arrow-left me-1"></i>
				Back to Dashboard
			</a>

		</div> <br>

		<div class="container-fluid">

        <!-- Page Header -->
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h4 class="page-title">
                <i class="fa-solid fa-book me-2"></i> Manage Topics
            </h4>

            <a href="<%=request.getContextPath()%>/user/add-topic"
               class="btn btn-primary">
                <i class="fa fa-plus"></i> Add Topic
            </a>
        </div>

        <!-- Messages -->
        <c:if test="${msg == 'added'}">
            <div class="alert alert-success">Topic added successfully.</div>
        </c:if>
        <c:if test="${msg == 'updated'}">
            <div class="alert alert-success">Topic updated successfully.</div>
        </c:if>
        <c:if test="${msg == 'disabled'}">
            <div class="alert alert-warning">Topic disabled.</div>
        </c:if>
        <c:if test="${msg == 'enabled'}">
            <div class="alert alert-success">Topic enabled.</div>
        </c:if>

        <!-- Topics Table -->
        <div class="card">
            <div class="card-body">

                <table id="topicTable" class="table table-bordered table-striped">
                    <thead class="table-dark">
                        <tr>
                            <th>#</th>
                            <th>Topic Name</th>
                            <th>Post</th>
                            <th>Status</th>
                            <th style="width: 160px;">Actions</th>
                        </tr>
                    </thead>

                    <tbody>
                        <c:forEach var="t" items="${topicList}" varStatus="i">
                            <tr>
                                <td>${i.index + 1}</td>
                                <td>${t.topicName}</td>
                                <td>${t.postName}</td>

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
                                    <!-- Edit and Disable only if ACTIVE -->
                                    <c:if test="${t.valid == 0}">
                                        <a href="<%=request.getContextPath()%>/user/topic/edit?id=${t.topicId}"
                                           class="btn btn-sm btn-warning">
                                            <i class="fa fa-edit"> Edit </i>
                                        </a>
                                        
                                        <a href="<%=request.getContextPath()%>/user/topic/status?id=${t.topicId}&action=disable"
                                               class="btn btn-sm btn-danger"
                                               onclick="return confirm('Disable this topic?')">
                                                <i class="fa fa-ban"> Disable </i>
                                            </a>
                                        
                                    </c:if>
                                    
                                    <!-- Enable --> 
                                    <c:if test="${t.valid == 1}">
											<a href="<%=request.getContextPath()%>/user/topic/status?id=${t.topicId}&action=enable"
												class="btn btn-sm btn-success"
												onclick="return confirm('Enable this topic Again?')"> <i
												class="fa fa-check"> Enable </i>
											</a>
										</c:if>

									</td>
                            </tr>
                        </c:forEach>

                        <c:if test="${empty topicList}">
                            <tr>
                                <td colspan="5" class="text-center">
                                    No topics found.
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>

            </div>
        </div>

    </div>
</div>

<%@ include file="/common/footer.jsp"%>

<!-- JS -->
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>

<script>
    $(document).ready(function () {
        $('#topicTable').DataTable({
            pageLength: 10,
            ordering: true
        });
    });
</script>

</body>
</html>