<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String username = (String) session.getAttribute("username");
String role = (String) session.getAttribute("role");

if(username == null){
    response.sendRedirect(request.getContextPath()+"/login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>User Dashboard | TMIS</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Font Awesome -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">

<style>
/* ===== GOVT STYLE THEME ===== */
body{
    background:#f4f6f9;
    font-family: "Segoe UI", Arial, sans-serif;
}

/* Sidebar */
#sidebar{
    width:240px;
    height:100vh;
    position:fixed;
    background:#0b3c5d;
    color:#fff;
    padding-top:20px;
}

#sidebar h5{
    text-align:center;
    font-weight:600;
    border-bottom:1px solid rgba(255,255,255,0.2);
    padding-bottom:15px;
}

#sidebar a{
    display:block;
    padding:12px 20px;
    color:#fff;
    text-decoration:none;
    font-size:15px;
}

#sidebar a:hover{
    background:#092f49;
}

/* Main Content */
#mainContent{
    margin-left:240px;
    padding:20px;
}

/* Top Header */
.top-bar{
    background:#ffffff;
    border-bottom:3px solid #0b3c5d;
    padding:12px 20px;
    display:flex;
    justify-content:space-between;
    align-items:center;
}

.top-bar h4{
    margin:0;
    font-weight:600;
    color:#0b3c5d;
}

/* Dashboard Cards */
.dashboard-card{
    background:#ffffff;
    border:1px solid #dcdcdc;
    border-left:5px solid #0b3c5d;
    padding:20px;
    height:100%;
    text-align:center;
    transition:0.3s;
}

.dashboard-card i{
    font-size:36px;
    color:#0b3c5d;
    margin-bottom:10px;
}

.dashboard-card h5{
    font-weight:600;
    margin-top:10px;
}

.dashboard-card p{
    font-size:14px;
    color:#555;
}

.dashboard-card:hover{
    box-shadow:0 4px 10px rgba(0,0,0,0.15);
    transform:translateY(-3px);
}

/* Footer */
.footer{
    background:#0b3c5d;
    color:#fff;
    text-align:center;
    padding:8px;
    margin-top:40px;
    font-size:13px;
}
</style>
</head>

<body>

<!-- ===== SIDEBAR ===== -->
<div id="sidebar">
    <h5>TMIS PORTAL</h5>
    <a href="#"><i class="fa fa-home me-2"></i> Dashboard</a>
    <a href="<%=request.getContextPath()%>/user/trainers"><i class="fa fa-chalkboard-teacher me-2"></i> Trainers</a>
    <a href="<%=request.getContextPath()%>/user/topics"><i class="fa fa-book me-2"></i> Subjects</a>
    <a href="<%=request.getContextPath()%>/user/manage_timetable.jsp"><i class="fa fa-calendar-alt me-2"></i> Timetable</a>
    <a href="<%=request.getContextPath()%>/user/create_feedback.jsp"><i class="fa fa-comments me-2"></i> Create Feedback</a>
    <a href="<%=request.getContextPath()%>/user/select_feedback.jsp"><i class="fa fa-eye me-2"></i> View Feedback</a>
</div>

<!-- ===== MAIN CONTENT ===== -->
<div id="mainContent">

    <!-- Top Header -->
    <div class="top-bar">
        <h4>Training Management Information System</h4>
        <div>
            <span class="me-3 fw-semibold">Welcome, <%=username%></span>
            <a href="<%=request.getContextPath()%>/LogoutServlet" class="btn btn-sm btn-danger">
                Logout
            </a>
        </div>
    </div>

    <!-- Info -->
    <div class="mt-3 text-muted">
        Role: <strong><%=role%></strong>
    </div>

    <hr>

    <!-- Dashboard Cards -->
    <div class="row g-4 mt-2">

        <div class="col-md-3">
            <div class="dashboard-card">
                <i class="fa fa-chalkboard-teacher"></i>
                <h5>Trainers</h5>
                <p>Manage Trainers Information</p>
                <a href="<%=request.getContextPath()%>/user/trainers" class="btn btn-outline-primary btn-sm mt-2">Open</a>
            </div>
        </div>

        <div class="col-md-3">
            <div class="dashboard-card">
                <i class="fa fa-book"></i>
                <h5>Subjects</h5>
                <p>Manage Subjects & Topics</p>
                <a href="<%=request.getContextPath()%>/user/topics" class="btn btn-outline-primary btn-sm mt-2">Open</a>
            </div>
        </div>

        <div class="col-md-3">
            <div class="dashboard-card">
                <i class="fa fa-calendar-alt"></i>
                <h5>Timetable</h5>
                <p>Training Schedule Management</p>
                <a href="<%=request.getContextPath()%>/user/manage_timetable.jsp" class="btn btn-outline-primary btn-sm mt-2">Open</a>
            </div>
        </div>

        <div class="col-md-3">
            <div class="dashboard-card">
                <i class="fa fa-comments"></i>
                <h5>Feedback</h5>
                <p>Create & Monitor Feedback</p>
                <a href="<%=request.getContextPath()%>/user/create_feedback.jsp" class="btn btn-outline-primary btn-sm mt-2">Create</a>
            </div>
        </div>

        <div class="col-md-3">
            <div class="dashboard-card">
                <i class="fa fa-eye"></i>
                <h5>View Feedback</h5>
                <p>Submitted Feedback Reports</p>
                <a href="<%=request.getContextPath()%>/user/select_feedback.jsp" class="btn btn-outline-primary btn-sm mt-2">View</a>
            </div>
        </div>

    </div>

    <!-- Footer -->
    <div class="footer">
        © 2026 Training Management Information System | Government of India
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
