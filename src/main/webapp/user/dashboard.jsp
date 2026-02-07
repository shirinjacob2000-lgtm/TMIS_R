<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="header.jsp" %>

<div class="container-fluid">
    <h5>Welcome to Dashboard</h5>
    <p class="text-muted">Use the sidebar to navigate through the system.</p>

    <div class="row g-4 mt-3">
        <div class="col-sm-6 col-md-4 col-lg-3">
            <div class="card card-box text-center p-4">
                <i class="fa fa-user"></i>
                <h6 class="mt-3">Trainers</h6>
                <small>Manage Trainers</small>
            </div>
        </div>

        <div class="col-sm-6 col-md-4 col-lg-3">
            <div class="card card-box text-center p-4">
                <i class="fa fa-book"></i>
                <h6 class="mt-3">Subjects</h6>
                <small>Manage Subjects</small>
            </div>
        </div>

        <div class="col-sm-6 col-md-4 col-lg-3">
            <div class="card card-box text-center p-4">
                <i class="fa fa-calendar"></i>
                <h6 class="mt-3">Timetable</h6>
                <small>View Timetable</small>
            </div>
        </div>

        <div class="col-sm-6 col-md-4 col-lg-3">
            <div class="card card-box text-center p-4">
                <i class="fa fa-comments"></i>
                <h6 class="mt-3">Feedback</h6>
                <small>Give Feedback</small>
            </div>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>
