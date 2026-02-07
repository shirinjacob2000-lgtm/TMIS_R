<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Add Topic | TMIS</title>

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
<!-- <%@ include file="/common/sidebar.jsp" %> -->

<div class="main-content">

		<!-- Top Back Button -->
		<div class="d-flex justify-content-between align-items-center mb-3 ">

			<a href="<%=request.getContextPath()%>/user/topics"
				class="btn btn-primary"> <i class="fas fa-arrow-left me-1"></i>
				Back
			</a>

		</div> <br>

		<div class="container-fluid">

    <h4 class="mb-3">
        <i class="fa fa-plus me-2"></i> Add Topic
    </h4>

    <c:if test="${param.error == 1}">
        <div class="alert alert-danger">Please fill all required fields.</div>
    </c:if>

    <div class="card">
        <div class="card-body">

            <form method="post" action="<%=request.getContextPath()%>/user/add-topic">

                <div class="mb-3">
                    <label class="form-label">Topic Name</label>
                    <input type="text"
                           name="topicName"
                           class="form-control"
                           required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Post</label>
                    <select name="postId" class="form-select" required>
                        <option value="">-- Select Post --</option>
                        <c:forEach items="${postList}" var="p">
                            <option value="${p.postId}">
                                ${p.postName}
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <button class="btn btn-primary">
                    <i class="fa fa-save"></i> Save Topic
                </button>

                <a href="<%=request.getContextPath()%>/user/topics"
                   class="btn btn-secondary">
                    Cancel
                </a>

            </form>

        </div>
    </div>

</div>
</div>

<%@ include file="/common/footer.jsp"%>

</body>
</html>