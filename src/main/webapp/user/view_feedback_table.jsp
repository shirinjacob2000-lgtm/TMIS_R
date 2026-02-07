<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>View Feedback | TMIS</title>

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Font Awesome -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
      rel="stylesheet">

<!-- DataTables CSS -->
<link href="https://cdn.datatables.net/1.13.7/css/jquery.dataTables.min.css" rel="stylesheet">
<link href="https://cdn.datatables.net/buttons/2.4.2/css/buttons.dataTables.min.css" rel="stylesheet">

<!-- Custom CSS -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">

<style>
body{
    background:#f4f6f9;
    font-family:"Segoe UI", Arial, sans-serif;
}
.card{
    margin:40px auto;
    max-width:95%;
    border-radius:10px;
    box-shadow:0 4px 15px rgba(0,0,0,0.12);
}
.summary-box{
    background:linear-gradient(135deg,#003366,#00509e);
    color:#fff;
    padding:25px;
    border-radius:8px;
    text-align:center;
    margin-bottom:25px;
}
.summary-grid{
    display:flex;
    justify-content:center;
    gap:45px;
    flex-wrap:wrap;
}
.summary-item span{
    display:block;
    font-size:13px;
    opacity:0.9;
}
.summary-item strong{
    font-size:16px;
}
.table th{
    background:#003366;
    color:#fff;
    text-align:center;
    font-size:14px;
}
.table td{
    text-align:center;
    font-size:13px;
}
</style>
</head>

<body>

<%@ include file="/common/header.jsp"%>

<%
String postName = (String) request.getAttribute("postName");
String batch = (String) request.getAttribute("batch");
String year = (String) request.getAttribute("year");
int totalFeedback = (Integer) request.getAttribute("totalFeedback");

List<Map<String,String>> feedbackList =
    (List<Map<String,String>>) request.getAttribute("feedbackList");

/* New Code Line*/
List<String> trainerHeaders =
(List<String>) request.getAttribute("trainerHeaders");


/* detect visible Q columns */
Set<Integer> visibleQs = new LinkedHashSet<>();
for(int q=1;q<=40;q++){
    for(Map<String,String> row:feedbackList){
        String v=row.get("q"+q);
        if(v!=null && !v.trim().isEmpty()){
            visibleQs.add(q);
            break;
        }
    }
}

/* ===== AVERAGE LOGIC ===== */
Map<Integer,Double> qSum=new HashMap<>();
Map<Integer,Integer> qCnt=new HashMap<>();

double canteenSum=0, hClean=0, hWater=0, hElec=0, hFood=0;
int canteenCnt=0, hostelCnt=0;

for(Integer q:visibleQs){ qSum.put(q,0.0); qCnt.put(q,0); }

for(Map<String,String> r:feedbackList){
    for(Integer q:visibleQs){
        if(r.get("q"+q)!=null && !r.get("q"+q).isEmpty()){
            qSum.put(q,qSum.get(q)+Double.parseDouble(r.get("q"+q)));
            qCnt.put(q,qCnt.get(q)+1);
        }
    }

    if(r.get("canteen_rating")!=null){
        canteenSum+=Double.parseDouble(r.get("canteen_rating")); canteenCnt++;
    }

    if(r.get("hostel_cleanliness")!=null){
        hClean+=Double.parseDouble(r.get("hostel_cleanliness"));
        hWater+=Double.parseDouble(r.get("hostel_water"));
        hElec+=Double.parseDouble(r.get("hostel_electricity"));
        hFood+=Double.parseDouble(r.get("hostel_food_quality"));
        hostelCnt++;
    }
}
%>

<div class="card">
<div class="card-body">

<!-- SUMMARY -->
<div class="summary-box">
    <h4>Feedback Summary</h4>
    <div class="summary-grid">
        <div class="summary-item"><span>Post</span><strong><%=postName%></strong></div>
        <div class="summary-item"><span>Batch</span><strong><%=batch%></strong></div>
        <div class="summary-item"><span>Training Year</span><strong><%=year%></strong></div>
        <div class="summary-item"><span>Total Feedback</span><strong><%=totalFeedback%></strong></div>
    </div>
</div>

<!-- TABLE -->
<div class="table-responsive">
<table id="feedbackTable" class="table table-bordered table-striped">

<thead>
<tr>
    <th>Sr</th>
    <th>Name</th>
    <th>Roll</th>
    <th>Office</th>
    <th>Emp ID</th>
    
    
    <%
int qIndex = 1;
for(String header : trainerHeaders){
%>
    <th><%= header %></th>
<%
    qIndex++;
}
%>
    
    <%-- <% for(Integer q:visibleQs){ %>
        <th>Q<%=q%></th>
    <% } %> --%>
    

    <th>Canteen</th>
    <th>Hostel Cleanliness</th>
    <th>Hostel Water</th>
    <th>Hostel Electricity</th>
    <th>Hostel Food</th>
    <th>Remarks</th>
</tr>
</thead>

<tbody>
<%
int i=1;
for(Map<String,String> row:feedbackList){
%>
<tr>
    <td><%=i++%></td>
    <td><%=row.get("trainee_name")%></td>
    <td><%=row.get("trainee_roll_no")%></td>
    <td><%=row.get("trainee_office_name")%></td>
    <td><%=row.get("trainee_employee_id")%></td>

    
    <%
int qNo = 1;
for(String header : trainerHeaders){
    String v = row.get("q" + qNo);
%>
    <td><%= v != null ? v : "" %></td>
<%
    qNo++;
}
%>

<%-- <% for(Integer q:visibleQs){ 
        String v=row.get("q"+q);
    %>
        <td><%= v!=null ? v : "" %></td>
    <% } %> --%>
    

    <td><%=row.get("canteen_rating")%></td>
    <td><%=row.get("hostel_cleanliness")%></td>
    <td><%=row.get("hostel_water")%></td>
    <td><%=row.get("hostel_electricity")%></td>
    <td><%=row.get("hostel_food_quality")%></td>
    <td><%=row.get("remarks")%></td>
</tr>
<% } %>

</tbody>

<tfoot>
<tr>
<td colspan="5">Average</td>

<% for(Integer q:visibleQs){ %>
<td><%=String.format("%.2f", qCnt.get(q)==0?0:qSum.get(q)/qCnt.get(q))%></td>
<% } %>

<td><%=canteenCnt==0?0:String.format("%.2f",canteenSum/canteenCnt)%></td>
<td><%=hostelCnt==0?0:String.format("%.2f",hClean/hostelCnt)%></td>
<td><%=hostelCnt==0?0:String.format("%.2f",hWater/hostelCnt)%></td>
<td><%=hostelCnt==0?0:String.format("%.2f",hElec/hostelCnt)%></td>
<td><%=hostelCnt==0?0:String.format("%.2f",hFood/hostelCnt)%></td>
<td>-</td>
</tr>
</tfoot>

</table>
</div>

<!-- Top Back Button -->
		<div class="d-flex justify-content-between align-items-center mb-3 ">

			<a href="<%=request.getContextPath()%>/user/select_feedback.jsp"
				class="btn btn-primary"> <i class="fas fa-arrow-left me-1"></i>
				Back
			</a>

		</div>

</div>
</div>

<%@ include file="/common/footer.jsp"%>

<!-- ================= JS (ORDER MAT BADLNA) ================= -->

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.datatables.net/1.13.7/js/jquery.dataTables.min.js"></script>

<!-- Excel dependency -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.10.1/jszip.min.js"></script>

<!-- Buttons -->
<script src="https://cdn.datatables.net/buttons/2.4.2/js/dataTables.buttons.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.4.2/js/buttons.html5.min.js"></script>

<script>
$(document).ready(function () {
    $('#feedbackTable').DataTable({
        dom: 'Bfrtip',
        buttons: [
            {
                extend: 'excelHtml5',
                text: 'Export to Excel',
                title: 'Feedback_<%=postName%>_<%=batch%>_<%=year%>',
                footer: true,
                exportOptions: { columns: ':visible' }
            }
        ],
        pageLength: 10
    });
});
</script>

</body>
</html>