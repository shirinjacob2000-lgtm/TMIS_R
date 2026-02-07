<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Edit Topic | TMIS</title>

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

<div class="container mt-4" id="mainContent">

<!-- Top Back Button -->
		<div class="d-flex justify-content-between align-items-center mb-3 ">

			<a href="<%=request.getContextPath()%>/user/topics"
				class="btn btn-primary"> <i class="fas fa-arrow-left me-1"></i>
				Back
			</a>

		</div> <br>
		
    <h4>Edit Topic</h4> <br>

    <form method="post" action="${pageContext.request.contextPath}/user/topic/edit">

        <input type="hidden" name="topicId" value="${topic.topicId}" />

        <div class="mb-3">
            <label class="form-label">Topic Name</label>
            <input type="text" name="topicName"
                   class="form-control"
                   value="${topic.topicName}" required />
        </div>

        <div class="mb-3">
            <label class="form-label">Post</label>
            <select name="postId" class="form-select" required>
                <c:forEach items="${postList}" var="p">
                    <option value="${p.postId}"
                        <c:if test="${p.postId == topic.postId}">selected</c:if>>
                        ${p.postName}
                    </option>
                </c:forEach>
            </select>
        </div>

        <button type="submit" class="btn btn-primary">
            Update Topic
        </button>

        <a href="${pageContext.request.contextPath}/user/topics"
           class="btn btn-secondary">
            Cancel
        </a>
    </form>
</div>

<%@ include file="/common/footer.jsp"%>

</body>
</html>