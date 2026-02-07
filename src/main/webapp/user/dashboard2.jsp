<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String username = (String) session.getAttribute("username");
    if(username == null){
        username = "User";
    }

    String uri = request.getRequestURI();
    String currentPage = "Dashboard";

    if(uri != null){
        currentPage = uri.substring(uri.lastIndexOf("/") + 1);
        if(currentPage.contains(".")){
            currentPage = currentPage.substring(0, currentPage.indexOf("."));
        }
    }

    if(currentPage.length() > 0){
        currentPage = currentPage.substring(0,1).toUpperCase() + currentPage.substring(1);
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title><%= currentPage %> | TMIS</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Font Awesome -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">

<style>
body{
    margin:0;
    background:#f5f6fa;
}

/* Sidebar */
#sidebar{
    width:240px;
    height:100vh;
    position:fixed;
    background:#1e1e2f;
    color:#fff;
    transition:0.3s;
}
#sidebar.collapsed{
    width:70px;
}
#sidebar .logo{
    padding:15px;
    font-size:18px;
    font-weight:bold;
    text-align:center;
    background:#151521;
}
#sidebar a{
    display:block;
    padding:12px 20px;
    color:#ccc;
    text-decoration:none;
}
#sidebar a.active,
#sidebar a:hover{
    background:#0d6efd;
    color:#fff;
}

/* Content */
#content{
    margin-left:240px;
    transition:0.3s;
}
#content.full{
    margin-left:70px;
}

/* Topbar */
.topbar{
    background:#fff;
    padding:10px 20px;
    display:flex;
    justify-content:space-between;
    align-items:center;
    box-shadow:0 2px 5px rgba(0,0,0,0.1);
}

/* Cards */
.card-box{
    border:none;
    border-radius:12px;
    box-shadow:0 4px 10px rgba(0,0,0,0.08);
}
.card-box i{
    font-size:30px;
    color:#0d6efd;
}

/* Footer */
footer{
    padding:15px;
    background:#fff;
    margin-top:40px;
    font-size:14px;
}
</style>
</head>

<body>

<!-- Sidebar -->
<div id="sidebar">
    <div class="logo">
        <i class="fa fa-graduation-cap me-2"></i> TMIS
    </div>

    <a href="dashboard.jsp" class="<%= uri.contains("dashboard") ? "active" : "" %>">
        <i class="fa fa-home me-2"></i> Dashboard
    </a>
    <a href="trainers.jsp" class="<%= uri.contains("trainers") ? "active" : "" %>">
        <i class="fa fa-user me-2"></i> Trainers
    </a>
    <a href="subjects.jsp" class="<%= uri.contains("subjects") ? "active" : "" %>">
        <i class="fa fa-book me-2"></i> Subjects
    </a>
    <a href="timetable.jsp" class="<%= uri.contains("timetable") ? "active" : "" %>">
        <i class="fa fa-calendar me-2"></i> Timetable
    </a>
    <a href="feedback.jsp" class="<%= uri.contains("feedback") ? "active" : "" %>">
        <i class="fa fa-comments me-2"></i> Feedback
    </a>
</div>

<!-- Content -->
<div id="content">

    <!-- Topbar -->
    <div class="topbar">
        <div class="d-flex align-items-center">
            <button class="btn btn-primary btn-sm me-3" onclick="toggleSidebar()">
                <i class="fa fa-bars"></i>
            </button>
            <div>
                <strong>Training Management Information System</strong><br>
                <small class="text-muted">CTI Jabalpur</small>
            </div>
        </div>
        <a href="logout.jsp" class="btn btn-danger btn-sm">Logout</a>
    </div>

    <!-- Breadcrumb -->
    <div class="container-fluid mt-3">
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item">
                    <a href="dashboard.jsp">Dashboard</a>
                </li>
                <li class="breadcrumb-item active">
                    <%= currentPage %>
                </li>
            </ol>
        </nav>
    </div>

    <!-- Dashboard Content -->
    <div class="container-fluid">
        <h5>Welcome, <%= username %></h5>
        <p class="text-muted">Use the sidebar to navigate through the system.</p>

        <div class="row g-4 mt-3">
            <div class="col-sm-6 col-md-4 col-lg-3">
                <div class="card card-box text-center p-4">
                    <i class="fa fa-user"></i>
                    <h6 class="mt-3">Trainers</h6>
                    <small>Manage Trainers</small>
                </div>
            </div>

            <div class="col-sm-6 col-md-4 col-lg-3">
                <div class="card card-box text-center p-4">
                    <i class="fa fa-book"></i>
                    <h6 class="mt-3">Subjects</h6>
                    <small>Manage Subjects</small>
                </div>
            </div>

            <div class="col-sm-6 col-md-4 col-lg-3">
                <div class="card card-box text-center p-4">
                    <i class="fa fa-calendar"></i>
                    <h6 class="mt-3">Timetable</h6>
                    <small>View Timetable</small>
                </div>
            </div>

            <div class="col-sm-6 col-md-4 col-lg-3">
                <div class="card card-box text-center p-4">
                    <i class="fa fa-comments"></i>
                    <h6 class="mt-3">Feedback</h6>
                    <small>Give Feedback</small>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="text-center">
        © 2026 Training Management Information System (TMIS) | CTI Jabalpur
    </footer>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
function toggleSidebar(){
    const sidebar = document.getElementById("sidebar");
    const content = document.getElementById("content");

    sidebar.classList.toggle("collapsed");
    content.classList.toggle("full");
}
</script>

</body>
</html>
