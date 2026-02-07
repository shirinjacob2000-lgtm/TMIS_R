<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
<title>Feedback Link Generated</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

<div class="container mt-5">
<div class="card shadow p-4">

<h4 class="text-success text-center">Feedback Link Generated</h4>

<hr>

<p><strong>Share this link with trainees:</strong></p>

<div class="input-group mb-3">
<input type="text" class="form-control"
       value="<%=request.getAttribute("generatedLink")%>"
       readonly>
</div>

<a href="/user/dashboard.jsp" class="btn btn-primary">
Back to Dashboard
</a>

</div>
</div>

</body>
</html>
