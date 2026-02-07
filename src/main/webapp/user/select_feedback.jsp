<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*, com.tmis.util.DBUtil"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Select Feedback | TMIS</title>

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
      rel="stylesheet">

<!-- Font Awesome -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
      rel="stylesheet">

<!-- Custom CSS -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">

<style>
body {
    font-family: Arial;
    background: #f4f6f9;
}

.form-box {
    width: 400px;
    margin: 80px auto;
    background: #fff;
    padding: 25px;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, .1);
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
    text-align:center;
}

.button:hover{
    background:#0055aa;
}

select, input{
    width: 100%;
    padding: 8px;
    margin-top: 10px;
}

.error {
    color: red;
    text-align: center;
    margin-top: 10px;
}
</style>
</head>

<body>

<%@ include file="/common/header.jsp"%>

<div class="form-box">

    <h3 class="text-center">View Feedback</h3>

    <!-- Back Button -->
    <%-- <a href="user/dashboard_user.jsp" class="btn btn-primary mb-4">
        <i class="fa fa-arrow-left"></i> Back
    </a> --%>

    <!-- FORM -->
    <form action="<%=request.getContextPath()%>/ViewFeedbackServlet" method="post">

        <!-- POST -->
        <label>Post</label>
        <select name="post_id" required>
            <option value="">-- Select Post --</option>

            <%
            try (Connection con = DBUtil.getConnection()) {

                PreparedStatement ps = con.prepareStatement(
                    "SELECT post_id, post_name FROM tmis.post_master ORDER BY post_name");
                ResultSet rs = ps.executeQuery();

                while (rs.next()) {
            %>
                <option value="<%=rs.getInt("post_id")%>">
                    <%=rs.getString("post_name")%>
                </option>
            <%
                }
            } catch(Exception e){
                out.println("<option>Error loading posts</option>");
            }
            %>

        </select>

        <!-- BATCH -->
        <label>Batch</label>
        <input type="text" name="batch" placeholder="001" required>

        <!-- YEAR -->
        <label>Training Year</label>
        <input type="text" name="year" placeholder="2026-2027" required>

        <!-- BUTTON -->
        <button class="button" type="submit" class="mt-3">View Feedback</button>
        
        <!-- BACK BUTTON -->
			<a class="button" style="background: #6c757d;"
				href="<%=request.getContextPath()%>/user/dashboard_user.jsp">
				<i class="fa fa-arrow-left"></i> Back
			</a>

        <!-- ERROR MESSAGE -->
        <%
        if (request.getAttribute("msg") != null) {
        %>
            <div class="error">
                <%= request.getAttribute("msg") %>
            </div>
        <%
        }
        %>

    </form>
</div>

<%@ include file="/common/footer.jsp"%>

</body>
</html>