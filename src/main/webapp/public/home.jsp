<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>CTI Jabalpur | TMIS</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- Google Font -->
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap" rel="stylesheet">

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- AOS -->
<link href="https://unpkg.com/aos@2.3.4/dist/aos.css" rel="stylesheet">

<style>
/* GLOBAL */
body {
    font-family: 'Inter', sans-serif;
    background-color: #f5f7fb;
    scroll-behavior: smooth;
}

/* TOP HEADER */
.top-header {
    background: #0d3b66;
    color: #fff;
    padding: 8px 0;
    font-size: 14px;
    text-align: center;
}

/* NAVBAR */
.navbar {
    background: #114b8c;
    box-shadow: 0 4px 12px rgba(0,0,0,0.25);
}
.navbar-brand, .nav-link {
    color: #fff !important;
    font-weight: 600;
}
.nav-link:hover {
    color: #ffdd57 !important;
    position: relative;
}
.nav-link::after {
    content: '';
    position: absolute;
    left: 0;
    bottom: -4px;
    width: 0;
    height: 2px;
    background: #ffdd57;
    transition: width 0.3s ease;
}
.nav-link:hover::after {
    width: 100%;
}

/* HERO */
.hero {
    position: relative;
    height: 520px;
    overflow: hidden;
}

.slider-img {
    height: 520px;
    object-fit: cover;
}

.hero-overlay {
    position: absolute;
    inset: 0;
    background: rgba(0,0,0,0.55);
    z-index: 1;
}

.hero-content-wrapper {
    position: absolute;
    inset: 0;
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 2;
    text-align: center;
}

.hero-content {
    color: #fff;
    padding: 35px 45px;
    border-radius: 16px;
    background: rgba(0,0,0,0.38);
    backdrop-filter: blur(6px);
    max-width: 90%;
    text-shadow: 0 6px 20px rgba(0,0,0,0.6);
    border: 1px solid rgba(255,255,255,0.18);
}
.hero-content h1 {
    font-size: 2.6rem;
    font-weight: 700;
}
.hero-content p {
    font-size: 1.2rem;
    margin-top: 12px;
    text-shadow: 0 4px 14px rgba(0,0,0,0.5);
}
.hero-content .btn {
    padding: 12px 26px;
    border-radius: 30px;
    font-size: 1rem;
    box-shadow: 0 8px 20px rgba(0,0,0,0.35);
    transition: all 0.35s ease;
}
.hero-content .btn:hover {
    transform: translateY(-3px);
    box-shadow: 0 14px 28px rgba(0,0,0,0.45);
}

/* SECTIONS */
.section-title {
    font-weight: 700;
    color: #114b8c;
}

.card {
    border: none;
    border-radius: 14px;
    box-shadow: 0 10px 24px rgba(0,0,0,0.08);
    transition: all 0.35s ease;
}
.card:hover {
    transform: translateY(-8px);
    box-shadow: 0 16px 32px rgba(0,0,0,0.12);
}

/* FOOTER */
.footer {
    background: #0d3b66;
    color: #fff;
    padding: 15px 0;
    font-size: 14px;
}
/* LOGIN MODAL */
.modal .modal-header { border-bottom: none; }
.modal .modal-footer { border-top: none; }
.modal-content { border-radius: 16px; backdrop-filter: blur(10px); background: rgba(255,255,255,0.15); }
.btn-login { background: #ffdd57; color: #114b8c; font-weight: 600; }
.btn-login:hover { background: #e6c84d; }

/* RESPONSIVE */
@media(max-width:768px) {
    .hero-content h1 { font-size: 2rem; }
    .hero-content p { font-size: 1rem; }
}
</style>
</head>

<body>

<!-- TOP HEADER -->
<div class="top-header">
    Madhya Pradesh Poorv Kshetra Vidyut Vitaran Company Limited, Jabalpur
</div>

<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg">
<div class="container">
    <a class="navbar-brand" href="#">CTI Jabalpur – TMIS</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ms-auto">
            <li class="nav-item"><a class="nav-link" href="index.jsp">Home</a></li>
            <li class="nav-item"><a class="nav-link" href="about.jsp">About TMIS</a></li>
            <li class="nav-item"><a class="nav-link"  data-bs-toggle="modal"
           data-bs-target="#loginModal">Login</a></li>
           <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/public/select_post_for_fb.jsp">feedback</a></li>
        </ul>
    </div>
</div>
</nav>

<!-- HERO -->
<section class="hero">
    <!-- CAROUSEL -->
    <div id="tmisCarousel" class="carousel slide carousel-fade h-100" data-bs-ride="carousel">
        <div class="carousel-inner h-100">
            <div class="carousel-item active h-100">
                <img src="<%=request.getContextPath()%>/images/image.png" class="d-block w-100 slider-img">
            </div>
            <div class="carousel-item h-100">
                <img src="<%=request.getContextPath()%>/images/imagee.png" class="d-block w-100 slider-img">
            </div>
            <div class="carousel-item h-100">
                <img src="<%=request.getContextPath()%>/images/imageee.png" class="d-block w-100 slider-img">
            </div>
        </div>
    </div>

    <div class="hero-overlay"></div>

    <div class="hero-content-wrapper">
        <div class="hero-content"
             data-aos="fade-up"
             data-aos-duration="1200">
            <h1>Central Training Institute (CTI), Jabalpur</h1>
            <p>Training Management Information System (TMIS)</p>
            <a class="btn btn-warning fw-semibold mt-3"
            data-bs-toggle="modal"
           data-bs-target="#loginModal">
                Access TMIS Portal
            </a>
        </div>
    </div>
</section>

<!-- FEATURES -->
<section class="py-5">
<div class="container">
    <div class="text-center mb-4" data-aos="fade-up">
        <h2 class="section-title">TMIS Highlights</h2>
        <p class="text-muted">Digitally managing training programs with efficiency & transparency</p>
    </div>

    <div class="row g-4">
        <div class="col-md-4" data-aos="fade-right">
            <div class="card p-4 text-center">
                <h5>Training Programs</h5>
                <p class="text-muted">Centralized management of induction & refresher training programs.</p>
            </div>
        </div>

        <div class="col-md-4" data-aos="fade-up">
            <div class="card p-4 text-center">
                <h5>Trainee Management</h5>
                <p class="text-muted">Complete trainee lifecycle including attendance & evaluation.</p>
            </div>
        </div>

        <div class="col-md-4" data-aos="fade-left">
            <div class="card p-4 text-center">
                <h5>Reports & Analytics</h5>
                <p class="text-muted">Automated reports for administration & statutory compliance.</p>
            </div>
        </div>
    </div>
</div>
</section>


<!-- LOGIN MODAL -->
<div class="modal fade" id="loginModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content p-3">
      <div class="modal-header border-0">
        <h5 class="modal-title"><i class="fa-solid fa-user-lock me-2"></i> TMIS Login</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body">
        <form action="<%=request.getContextPath()%>/login" method="post" autocomplete="off">
          <div class="mb-3">
            <label class="form-label"><i class="fa-solid fa-user"></i> Username</label>
            <input type="text" name="username" class="form-control" placeholder="Enter username" required>
          </div>
          <div class="mb-3">
            <label class="form-label"><i class="fa-solid fa-lock"></i> Password</label>
            <input type="password" name="password" class="form-control" placeholder="Enter password" required>
          </div>
          <% if (request.getParameter("error") != null) { %>
              <div class="alert alert-danger py-2">
                  Invalid username or password
              </div>
          <% } %>
          <div class="d-grid mt-3">
            <button type="submit" class="btn btn-login">hello Login</button>
          </div>
        </form>
      </div>
      <div class="modal-footer border-0 text-center justify-content-center">
        Authorized users only
      </div>
    </div>
  </div>
</div>

<!-- FOOTER -->
<footer class="footer text-center">
© 2025 Training Management Information System (TMIS) | Developed by CTI, Jabalpur
</footer>

<!-- JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/aos@2.3.4/dist/aos.js"></script>
<script>
AOS.init({
    once: true,
    offset: 120,
    easing: 'ease-out-cubic'
});
</script>

</body>
</html>
