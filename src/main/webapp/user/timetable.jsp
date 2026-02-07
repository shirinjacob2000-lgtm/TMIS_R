<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*, com.tmis.util.DBUtil" %>

<%
    if(session.getAttribute("username") == null){
        response.sendRedirect("home.jsp");
        return;
    }

    String postCode = request.getParameter("post");
    if(postCode == null){
        response.sendRedirect("select_post.jsp");
        return;
    }

    int postId = 0;
    String postName = "";

    Connection con = DBUtil.getConnection();
    PreparedStatement ps = con.prepareStatement(
        "SELECT post_id, post_name FROM tmis.post_master WHERE post_code=?");
    ps.setString(1, postCode);
    ResultSet rs = ps.executeQuery();
    if(rs.next()){
        postId = rs.getInt("post_id");
        postName = rs.getString("post_name");
    } else {
        response.sendRedirect("select_post.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title><%= postName %> Time Table | TMIS</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
	rel="stylesheet">

<!-- Custom CSS -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/style.css">

<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>

<style>
/* Optional styling for button spacing */
.back-btn-container {
    margin-left: 20px;  /* Slightly right from left edge */
    margin-bottom: 20px;
}
</style>

</head>

<body class="bg-light">

<%@ include file="/common/header.jsp"%>

<div class="container mt-5">

    <!-- 🔹 UPDATED BACK BUTTON -->
   
        <a href="select_post.jsp" class="btn btn-primary mb-5">
            <i class="fas fa-arrow-left me-1"></i> Back
        </a>

    <h4 class="mb-4"><%= postName %> – Time Table</h4>

    <form action="<%=request.getContextPath()%>/user/SaveTimetableServlet" method="post">

    <input type="hidden" name="post_id" value="<%= postId %>">
    <input type="hidden" name="post_name" value="<%= postName %>">

    <!-- 🔽 BATCH & YEAR (MANUAL INPUT) -->
    <div class="row mb-4">
        <div class="col-md-4">
            <label class="fw-bold">सत्र क्रमांक (Batch)</label>
            <input type="text" name="batch" class="form-control" placeholder="Ex: 03/2025" required>
        </div>

        <div class="col-md-4">
            <label class="fw-bold">प्रशिक्षण अवधि (Year)</label>
            <input type="text" name="training_year" class="form-control" placeholder="Ex: 2025-2026" required>
        </div>
    </div>

    <!-- ✅ GAP GIVEN HERE -->
    <div class="mt-4"></div>

    <table class="table table-bordered">
    <thead class="table-dark">
    <tr>
    <th>Subject</th>
    <th>Trainer</th>
    <th>Date</th>
    <th>Start Time</th>
    <th>End Time</th>
    <%-- <th>Time</th> --%>
    <th>Action</th>
    </tr>
    </thead>

    <tbody id="rows">
    <tr>
    <td>
    <select name="subject_id[]" class="form-select" required>
    <option value="">Select Subject</option>
    <%
    PreparedStatement ps2 = con.prepareStatement(
    "SELECT topic_id, topic_name FROM tmis.topic_master WHERE post_id=? AND valid = 0 ORDER BY topic_id ASC");
    ps2.setInt(1, postId);
    ResultSet rs2 = ps2.executeQuery();
    while(rs2.next()){
    %>
    <option value="<%= rs2.getInt("topic_id") %>">
    <%= rs2.getString("topic_name") %>
    </option>
    <% } %>
    </select>
    </td>

    <td>
    <select name="trainer_id[]" class="form-select" required>
    <option value="">Select Trainer</option>
    <%
    PreparedStatement ps3 = con.prepareStatement(
    "SELECT trainer_id, trainer_name FROM tmis.trainer_master WHERE valid = 0 ORDER BY trainer_id ASC");
    ResultSet rs3 = ps3.executeQuery();
    while(rs3.next()){
    %>
    <option value="<%= rs3.getInt("trainer_id") %>">
    <%= rs3.getString("trainer_name") %>
    </option>
    <% } %>
    </select>
    </td>

    <td>
    <input type="date" name="training_date[]" class="form-control" required>
    </td>
    
    <!-- New Timing Part -->
    <td>
    <input type="time" name="start_time[]" class="form-control" required>
</td>
<td>
    <input type="time" name="end_time[]" class="form-control" required>
</td>

    <%-- <td>
    <input type="text" name="training_time[]" class="form-control" placeholder="10:00 AM - 01:00 PM" required>
    </td> --%>

    <td>
    <button type="button" class="btn btn-danger remove">Remove</button>
    </td>
    </tr>
    </tbody>
    </table>

    <button type="button" id="addRow" class="btn btn-secondary mt-2">+ Add Row</button>

    <hr>

    <button type="submit" class="btn btn-primary w-100 mt-5">
    Save Time Table
    </button>

    </form>
</div>

<br>
<%@ include file="/common/footer.jsp"%>

<script>
$("#addRow").click(function(){
    $("#rows tr:first")
        .clone()
        .find("input,select").val("").end()
        .appendTo("#rows");
});

$(document).on("click",".remove",function(){
    if($("#rows tr").length > 1){
        $(this).closest("tr").remove();
    }
});
</script>

</body>
</html>

<% con.close(); %>
