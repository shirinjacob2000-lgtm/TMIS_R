    <!-- Footer -->
    <footer>
        © 2026 Training Management Information System (TMIS) | CTI Jabalpur
    </footer>

</div> <!-- End Content -->

<script>
function toggleSidebar(){
    const sidebar = document.getElementById("sidebar");
    const content = document.getElementById("content");

    if(window.innerWidth <= 768){
        sidebar.classList.toggle("show");
    } else {
        sidebar.classList.toggle("collapsed");
        content.classList.toggle("full");
    }
}
</script>
