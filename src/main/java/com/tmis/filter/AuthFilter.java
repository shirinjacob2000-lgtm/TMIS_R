package com.tmis.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        
        /* Prevent browser caching */
        res.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
        res.setHeader("Pragma", "no-cache"); // HTTP 1.0
        res.setDateHeader("Expires", 0); // Proxies

        String uri = req.getRequestURI();
        String contextPath = req.getContextPath();

        // Public resources (no login required)
        if (uri.startsWith(contextPath + "/public/") ||
        		uri.equals(contextPath + "/login") ||
                uri.startsWith(contextPath + "/css/") ||
                uri.startsWith(contextPath + "/js/") ||
                uri.startsWith(contextPath + "/images/")||
                uri.startsWith("/fonts/")||
                uri.startsWith(".ico")) {
//        if (uri.endsWith("login.jsp")
//                || uri.endsWith("/login")
//                || uri.endsWith("logout")
//                || uri.contains("/css/")
//                || uri.contains("/js/")
//                || uri.contains("/images/")
//                || uri.contains("/fonts/")
//                || uri.endsWith(".ico")) {

            chain.doFilter(request, response);
            return;
        }

        HttpSession session = req.getSession(false);

        // Session not present → redirect to login
        if (session == null || session.getAttribute("username") == null) {
            res.sendRedirect(contextPath + "/public/login.jsp");
            return;
        }

        // Role-based protection
        String role = (String) session.getAttribute("role");

        // ADMIN pages
        if (uri.contains("/admin/") && !"ADMIN".equalsIgnoreCase(role)) {
            res.sendRedirect(contextPath + "/unauthorized.jsp");
            return;
        }

        // USER pages
        if (uri.contains("/user/") && !"USER".equalsIgnoreCase(role)) {
            res.sendRedirect(contextPath + "/unauthorized.jsp");
            return;
        }

        // TRAINER pages
        if (uri.contains("/trainer/") && !"TRAINER".equalsIgnoreCase(role)) {
            res.sendRedirect(contextPath + "/unauthorized.jsp");
            return;
        }

        // Allowed
        chain.doFilter(request, response);
    }
}
