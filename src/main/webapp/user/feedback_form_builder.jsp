<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, com.tmis.util.DBUtil" %>

<%
/* ==============================
   1️⃣ SESSION CHECK
============================== */

String username = (String) session.getAttribute("username");
String role = (String) session.getAttribute("role");
if (username == null || role == null) {
    response.sendRedirect(request.getContextPath() + "/public/home.jsp");
    return;
}

/* Integer userId = (Integer) session.getAttribute("user_id");
if (userId == null) {
    response.sendRedirect(request.getContextPath() + "/login.jsp");
    return;
} */


/* ==============================
   2️⃣ GET PARAMETERS
============================== */
int postId = Integer.parseInt(request.getParameter("post_id"));
String batch = request.getParameter("batch");
String trainingYear = request.getParameter("training_year");

if (batch == null || trainingYear == null) {
    out.println("<h3 style='color:red;text-align:center'>Invalid Access</h3>");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Feedback Form Builder | TMIS</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">

<style>
body {
    background: #f5f7fa;
}
.card-builder {
    border-left: 5px solid #0b3c5d;
}
</style>
</head>

<body>

<div class="container mt-5">

    <a href="<%=request.getContextPath()%>/user/create_feedback.jsp" class="btn btn-primary mb-4">
        <i class="fa fa-arrow-left"></i> Back to Dashboard
    </a>

    <div class="card card-builder shadow-sm p-4">

        <h4 class="text-center fw-bold mb-4">
            Feedback Form Builder
        </h4>

        <p><b>Batch:</b> <%= batch %> | <b>Year:</b> <%= trainingYear %></p>

        <form action="<%=request.getContextPath()%>/GenerateFeedbackLinkServlet" method="post">

            <input type="hidden" name="post_id" value="<%=postId%>">
            <input type="hidden" name="batch" value="<%=batch%>">
            <input type="hidden" name="training_year" value="<%=trainingYear%>">

            <div class="table-responsive">
                <table class="table table-bordered align-middle text-center">
                    <thead class="table-light">
                        <tr>
                            <th>Select</th>
                            <th>Trainer Name</th>
                            <th>Topic</th>
                            <th>Remove</th>
                        </tr>
                    </thead>
                    <tbody>

<%
try(Connection con = DBUtil.getConnection()){

    PreparedStatement ps = con.prepareStatement(
        "SELECT t.timetable_id, tr.trainer_name, tm.topic_name " +
        "FROM tmis.timetable_master t " +
        "JOIN tmis.trainer_master tr ON tr.trainer_id = t.trainer_id " +
        "JOIN tmis.topic_master tm ON tm.topic_id = t.topic_id " +
        "WHERE t.post_id=? AND t.batch=? AND t.training_year=? " +
        "ORDER BY tr.trainer_name"
    );

    ps.setInt(1, postId);
    ps.setString(2, batch);
    ps.setString(3, trainingYear);

    ResultSet rs = ps.executeQuery();

    boolean hasData = false;

    while(rs.next()){
        hasData = true;
%>
        <tr>
            <td>
                <input type="checkbox"
                       name="timetable_ids"
                       value="<%=rs.getInt("timetable_id")%>"
                       checked>
            </td>
            <td><%=rs.getString("trainer_name")%></td>
            <td><%=rs.getString("topic_name")%></td>
            <td>
                <button type="button"
                        class="btn btn-danger btn-sm"
                        onclick="removeRow(this)">
                    <i class="fa fa-times"></i>
                </button>
            </td>
        </tr>
<%
    }

    if(!hasData){
%>
        <tr>
            <td colspan="4" class="text-danger fw-bold">
                No timetable found for this batch.
            </td>
        </tr>
<%
    }

}catch(Exception e){
    out.println("<tr><td colspan='4'>Error: "+e.getMessage()+"</td></tr>");
}
%>

                    </tbody>
                </table>
            </div>

            <div class="text-center mt-4">
                <button type="submit" class="btn btn-success px-4">
                    Generate 48 Hour Feedback Link
                </button>
            </div>

        </form>

    </div>

</div>

<script>
function removeRow(btn) {
    let row = btn.closest("tr");
    let checkbox = row.querySelector("input[type='checkbox']");
    checkbox.checked = false;
    row.style.display = "none";
}
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
