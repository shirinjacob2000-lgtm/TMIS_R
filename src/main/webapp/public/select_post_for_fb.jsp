<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, com.tmis.util.DBUtil" %>
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
body{
    background:#f5f7fa;
    font-family:Segoe UI, Arial, sans-serif;
}
.card-post{
    border-left:5px solid #0b3c5d;
    cursor:pointer;
    transition:.3s;
}
.card-post:hover{
    background:#eef3f7;
    transform:scale(1.03);
}
.card-icon{
    font-size:2rem;
    margin-bottom:10px;
    color:#0055aa;
}
</style>
</head>

<body>

<div class="container mt-5">

<a href="home.jsp" class="btn btn-primary mb-5"> <i
			class="fa fa-arrow-left"></i> Back
		</a>

    <h4 class="mb-4 text-center fw-bold">
        प्रशिक्षण फीडबैक हेतु पद चुनें
    </h4>

    <div class="row g-4 justify-content-center">

<%
try(Connection con = DBUtil.getConnection()){
    PreparedStatement ps = con.prepareStatement(
        "SELECT post_code, post_name FROM tmis.post_master ORDER BY post_id"
    );
    ResultSet rs = ps.executeQuery();

    while(rs.next()){
%>
        <div class="col-md-3">
            <a href="select_batch.jsp?post=<%=rs.getString("post_code")%>"
               class="text-decoration-none text-dark">
                <div class="card card-post p-4 text-center shadow-sm">
                    <i class="fas fa-user-tie card-icon"></i>
                    <h5><%=rs.getString("post_name")%></h5>
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
