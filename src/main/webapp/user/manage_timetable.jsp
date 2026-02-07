<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Manage Timetable | TMIS</title>


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

<style>
body{
    font-family: Arial, sans-serif;
    background:#f4f6f9;
    margin:0;
    padding:0;
}

.container{
    width:400px;
    margin:120px auto;
    background:#fff;
    padding:30px;
    border-radius:8px;
    box-shadow:0 0 15px rgba(0,0,0,0.15);
    text-align:center;
}

h2{
    margin-bottom:25px;
    color:#003366;
}

.button{
    display:block;
    width:100%;
    padding:12px;
    margin:12px 0;
    font-size:16px;
    font-weight:bold;
    color:#fff;
    background:#003366;
    border:none;
    border-radius:6px;
    cursor:pointer;
    text-decoration:none;
}

.button:hover{
    background:#0055aa;
}

.note{
    margin-top:15px;
    font-size:13px;
    color:#555;
}
</style>
</head>

<body>

	<!-- Logo Section -->
	<div class="logo-bar">
		<div class="d-flex align-items-center" style="margin-left:380px;">
			<a href="https://www.mpez.co.in/"><img
				src="https://www.mpez.co.in/static/assets/img/MPPKVVCL%20Logo.png"
				alt="Gov Logo"></a>
			<div class="ms-3">
				<div class="system-title">Madhya Pradesh Poorv Kshetra Vidyut
					Vitaran Company Limited, Jabalpur</div>
				<div class="system-subtitle">Training Management Information
					System (TMIS)</div>
			</div>
		</div>
	</div>
	
	<div class="container">
    <h2>Manage Timetable</h2>

    <!-- CREATE TIMETABLE -->
    <a class="button"
       href="<%= request.getContextPath() %>/user/select_post.jsp">
        Create Timetable
    </a>

    <!-- VIEW TIMETABLE -->
    <a class="button"
       href="<%= request.getContextPath() %>/user/select_timetable.jsp">
        View Timetable
    </a>
    
    <!-- BACK BUTTON -->
    <a class="button"
       style="background:#6c757d;"
       href="<%= request.getContextPath() %>/user/dashboard_user.jsp">
        <i class="fa fa-arrow-left"></i> Back
    </a>

    <div class="note">
        Please select an option to continue
    </div>
</div>

<%@ include file="/common/footer.jsp"%>

</body>
</html>
