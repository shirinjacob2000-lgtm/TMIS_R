<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
</head>
<body>

<div id="sidebar" class="sidebar">
    <div class="sidebar-header">
        <span class="sidebar-title">USER PANEL</span>
        <button class="btn btn-sm btn-toggle" onclick="toggleSidebar()">
            <i class="fa fa-bars"></i>
        </button>
    </div>

    <ul class="sidebar-menu">
        <li>
            <a href="<%=request.getContextPath()%>/user/dashboard_user.jsp">
                <i class="fa fa-home"></i>
                <span>Dashboard</span>
            </a>
        </li>

        <li>
            <a href="<%=request.getContextPath()%>/user/trainers">
                <i class="fa fa-chalkboard-teacher"></i>
                <span>Manage Trainers</span>
            </a>
        </li>

        <li>
            <a href="<%=request.getContextPath()%>/user/topics">
                <i class="fa fa-book"></i>
                <span>Manage Subjects</span>
            </a>
        </li>

        <li>
            <a href="<%=request.getContextPath()%>/user/manage_timetable.jsp">
                <i class="fa fa-calendar-alt"></i>
                <span>Manage Timetable</span>
            </a>
        </li>

        <li>
            <a href="<%=request.getContextPath()%>/user/select_feedback.jsp">
                <i class="fa fa-comments"></i>
                <span>Feedback Form</span>
            </a>
        </li>

        <li class="logout">
            <a href="<%=request.getContextPath()%>/LogoutServlet">
                <i class="fa fa-sign-out-alt"></i>
                <span>Logout</span>
            </a>
        </li>
    </ul>
</div>

</body>
</html>