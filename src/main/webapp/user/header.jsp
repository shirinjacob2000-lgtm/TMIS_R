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

<!-- Sidebar -->
<div id="sidebar">
    <div class="logo">
        <i class="fa fa-graduation-cap me-2"></i> TMIS
    </div>

    <a href="dashboard.jsp" class="<%= uri.contains("dashboard") ? "active" : "" %>">
        <i class="fa fa-home me-2"></i>Dashboard
    </a>
    <a href="trainers.jsp" class="<%= uri.contains("trainers") ? "active" : "" %>">
        <i class="fa fa-user me-2"></i>Trainers
    </a>
    <a href="subjects.jsp" class="<%= uri.contains("subjects") ? "active" : "" %>">
        <i class="fa fa-book me-2"></i>Subjects
    </a>
    <a href="timetable.jsp" class="<%= uri.contains("timetable") ? "active" : "" %>">
        <i class="fa fa-calendar me-2"></i>Timetable
    </a>
    <a href="feedback.jsp" class="<%= uri.contains("feedback") ? "active" : "" %>">
        <i class="fa fa-comments me-2"></i>Feedback
    </a>
</div>

<!-- Content Wrapper -->
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
        <nav aria-label="breadcrumb">
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

    <!-- Page Content -->
