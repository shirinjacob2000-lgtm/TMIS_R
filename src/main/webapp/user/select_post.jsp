<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.sql.*, com.tmis.util.DBUtil"%>

<%
    if(session.getAttribute("username") == null){
        response.sendRedirect("home.jsp");
        return;
    }

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Select Designation | TMIS</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
	rel="stylesheet">

<!-- Custom CSS -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/style.css">

<style>
body {
	background: #f5f7fa;
}

.card-post {
	border-left: 5px solid #0b3c5d;
	transition: .3s;
	cursor: pointer;
}

.card-post:hover {
	background: #eef3f7;
	transform: scale(1.03);
}

.card-icon {
	font-size: 2rem;
	color: #0055aa;
	margin-bottom: 10px;
}
</style>
</head>

<body>

<%@ include file="/common/header.jsp"%>

	<div class="container mt-5">

		<a href="manage_timetable.jsp" class="btn btn-primary mb-5"> <i
			class="fa fa-arrow-left"></i> Back
		</a>

		<h4 class="text-center fw-bold mb-4">समय सारणी प्रबंधित करने के
			लिए पद चुनें</h4>
<br>
		<div class="row justify-content-center">

			<%
            try{
                con = DBUtil.getConnection();
                ps = con.prepareStatement("SELECT * FROM tmis.post_master ORDER BY post_id");
                rs = ps.executeQuery();

                while(rs.next()){
                    String code = rs.getString("post_code");
                    String name = rs.getString("post_name");
        %>

			<div class="col-md-3 mb-3">
				<a href="timetable.jsp?post=<%=rs.getString("post_code")%>"
					class="text-decoration-none text-dark">
					<div class="card card-post p-4 text-center shadow-sm">

						<i class="fas fa-user-tie card-icon"></i>
						<h5><%=rs.getString("post_name")%></h5>

						<%-- <% if(code.equals("LINE_MAN")){ %>
                        <i class="fas fa-user-tie card-icon"></i>
                    <% } else if(code.equals("AE")){ %>
                        <i class="fas fa-hard-hat card-icon"></i>
                    <% } else if(code.equals("JE")){ %>
                        <i class="fas fa-cogs card-icon"></i>
                    <% } %>

                    <h5><%= name %></h5> --%>

					</div>
				</a>
			</div>

			<%
                }
            }catch(Exception e){
                out.println(e);
            }
        %>

		</div>
	</div>
	
	<br><br><br><br>

<%@ include file="/common/footer.jsp"%>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>

<%
    if(rs!=null) rs.close();
    if(ps!=null) ps.close();
    if(con!=null) con.close();
%>
