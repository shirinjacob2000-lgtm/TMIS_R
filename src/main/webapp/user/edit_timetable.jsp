<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>

<%
List<Map<String,String>> timetableList =
(List<Map<String,String>>)request.getAttribute("timetableList");
%>

<!DOCTYPE html>
<html>
<head>
<title>Edit Timetable</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>
<%@ include file="/common/header.jsp"%>

<div class="container mt-4">
<h4>Edit Timetable</h4>

<form action="<%=request.getContextPath()%>/UpdateTimetableServlet" method="post">

<table class="table table-bordered">
<tr>
<th>Date</th>
<th>Time</th>
<th>Subject</th>
<th>Trainer</th>
</tr>

<%
for(Map<String,String> row : timetableList){
%>
<tr>
<input type="hidden" name="id" value="<%=row.get("id")%>">
<td><input type="date" name="date" value="<%=row.get("date")%>" class="form-control"></td>
<td><input type="text" name="time" value="<%=row.get("time")%>" class="form-control"></td>
<td><input type="text" name="subject" value="<%=row.get("subject")%>" class="form-control"></td>
<td><input type="text" name="trainer" value="<%=row.get("trainer")%>" class="form-control"></td>
</tr>
<% } %>

</table>

<button class="btn btn-success">Update Timetable</button>
<a href="javascript:history.back()" class="btn btn-secondary">Cancel</a>

</form>
</div>

<%@ include file="/common/footer.jsp"%>
</body>
</html>
