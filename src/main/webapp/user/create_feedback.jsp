<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, com.tmis.util.DBUtil" %>

<%
/* ==============================
   SESSION CHECK
============================== */
String username = (String) session.getAttribute("username");
String role = (String) session.getAttribute("role");
if (username == null || role == null) {
    response.sendRedirect(request.getContextPath() + "/public/home.jsp");
    return;
}

/* Integer userId = (Integer) session.getAttribute("user_id");
if (userId == null) {
    response.sendRedirect(request.getContextPath() + "/public/home.jsp");
    return;
} */

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Create Feedback Form | TMIS</title>

<!-- Custom CSS -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/style.css">
	
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
	rel="stylesheet">

<style>
body{
    background:#f5f7fa;
}
.card-box{
    border-left:5px solid #0b3c5d;
}
</style>
</head>

<body>

<%@ include file="/common/header.jsp"%>

<div class="container mt-5">

<%-- <a href="dashboard_user.jsp" class="btn btn-primary mb-4">
Back to Dashboard
</a> --%>

<div class="row justify-content-center">
<div class="col-md-6">

<div class="card card-box shadow-sm p-4">

<h4 class="text-center mb-4">Create Feedback Form</h4>

<% if(request.getAttribute("error") != null){ %>
<div class="alert alert-danger text-center">
    <%= request.getAttribute("error") %>
</div>
<% } %>

<form action="<%=request.getContextPath()%>/ValidateFeedbackSetupServlet" method="post">

<!-- POST DROPDOWN -->
<div class="mb-3">
<label class="form-label fw-semibold">Select Post</label>
<select name="post_id" class="form-select" required>
<option value="">-- Select Post --</option>

<%
try(Connection con = DBUtil.getConnection()){

    PreparedStatement ps = con.prepareStatement(
        "SELECT post_id, post_name FROM tmis.post_master ORDER BY post_name"
    );

    ResultSet rs = ps.executeQuery();

    while(rs.next()){
    	String postName = request.getParameter("post_name");
%>
<option value="<%=rs.getInt("post_id")%>">
    <%=rs.getString("post_name")%>
</option>
<%
    }
}catch(Exception e){
    out.println("<option>Error loading posts</option>");
}
%>

</select>
</div>

<!-- BATCH -->
<div class="mb-3">
<label class="form-label fw-semibold">Batch Name / Number</label>
<input type="text" name="batch" class="form-control" required>
</div>

<!-- TRAINING YEAR -->
<div class="mb-4">
<label class="form-label fw-semibold">Training Year</label>
<input type="text"
       name="training_year"
       class="form-control"
       placeholder="2025-2026"
       required>
</div>

<div class="d-grid">
<button type="submit" class="btn btn-success">
Proceed to Form Builder
</button>

<a href="dashboard_user.jsp" class="btn btn-primary mb-3 mt-3">
Back to Dashboard
</a>

</div>

</form>

</div>
</div>
</div>

</div>

<%@ include file="/common/footer.jsp"%>

</body>
</html>