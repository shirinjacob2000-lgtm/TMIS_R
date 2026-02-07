<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Select Batch | TMIS</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">

<style>
body{background:#f5f7fa;}
.card-form{border-left:5px solid #0b3c5d;}
</style>
</head>

<body>

<div class="container mt-5">

<a href="select_post_for_fb.jsp" class="btn btn-primary mb-4">
    <i class="fa fa-arrow-left"></i> Back
</a>

<div class="row justify-content-center">
<div class="col-md-6">

<div class="card card-form shadow-sm p-4">

<h5 class="text-center fw-bold mb-4">
    बैच विवरण दर्ज करें
</h5>

<% if(request.getAttribute("error") != null){ %>
<div class="alert alert-danger text-center">
    <%= request.getAttribute("error") %>
</div>
<% } %>

<form action="<%=request.getContextPath()%>/public/checkBatch" method="post">

<input type="hidden" name="post_code" value="<%=request.getParameter("post")%>">

<div class="mb-3">
    <label class="form-label fw-semibold">बैच नाम / नंबर</label>
    <input type="text" name="batch" class="form-control" required>
</div>

<div class="mb-4">
    <label class="form-label fw-semibold">प्रशिक्षण वर्ष</label>
    <input type="text" name="training_year" class="form-control" placeholder="2025-2026" required>
</div>

<div class="d-grid">
    <button type="submit" class="btn btn-success">
        आगे बढ़ें <i class="fa fa-arrow-right"></i>
    </button>
</div>

</form>

</div>
</div>
</div>

</div>
</body>
</html>



<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*, com.tmis.util.DBUtil, com.tmis.servlet.* " %>

<%
String postCode = request.getParameter("post");
if(postCode == null){
	response.sendRedirect("select_post_for_fb.jsp");
    //out.println("Invalid Access");
    return;
}

int postId = 0;
String postName = "";

try(Connection con = DBUtil.getConnection()){
    PreparedStatement ps = con.prepareStatement(
        "SELECT post_id, post_name FROM tmis.post_master WHERE post_code=?"
    );
    ps.setString(1, postCode);
    ResultSet rs = ps.executeQuery();
    if(rs.next()){
        postId = rs.getInt("post_id");
        postName = rs.getString("post_name");
    } else{
    	response.sendRedirect("select_post_for_fb.jsp");
        //out.println("Invalid Post");
        return;
    }
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title><%= postName %> Enter Batch Details | TMIS</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
	rel="stylesheet">

<!-- Custom CSS -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/style.css">

<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>

<style>
body{ background:#f5f7fa; font-family:Segoe UI, Arial, sans-serif; }
.card-box{ max-width:450px; margin:auto; }
.card{ border-left:5px solid #0b3c5d; }
#msg{ display:none; margin-top:10px; font-weight:bold; color:red; }
</style>
</head>
<body>

<div class="container mt-5">
    <h4 class="text-center fw-bold mb-4">Batch Select करें</h4>

    <div class="card card-box shadow p-4">
        <form action="feedback_form.jsp" method="get" id="batchForm">
            
            <input type="hidden" name="post_id" value="<%=postId%>">
            
            <input type="hidden" name="post_name" value="<%=postName%>">
            
            <div class="mb-3">
                <label class="form-label fw-bold">Batch Name / Number</label>
                <input type="text" name="batch" id="batch" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label fw-bold">Training Year</label>
                <input type="text" name="year" id="year" class="form-control" required>
            </div>
            <button class="btn btn-success w-100" type="submit">Proceed to Feedback</button>
            <div id="msg"></div>
        </form>
    </div>
</div>

<script>
$(document).ready(function(){
    function checkTimetable() {
        var batch = $("#batch").val();
        var year = $("#year").val();
        if(batch && year){
            $.ajax({
                url: '<%=request.getContextPath()%>/CheckTimetableServlet',
                type: 'GET',
                data: { post_id: '<%=postId%>', batch: batch, year: year },
                success: function(response){
                    if(response.trim() === "not_available"){
                        $("#msg").text("No timetable data available for Batch " + batch + " and Year " + year).show();
                    } else {
                        $("#msg").hide();
                    }
                },
                error: function(){ $("#msg").text("Error checking timetable.").show(); }
            });
        }
    }
    $("#batch, #year").on('keyup change', checkTimetable);
});
</script>

</body>
</html> --%>

