package com.tmis.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;

import com.tmis.dao.UserDAO;
import com.tmis.model.User;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	//System.out.println(">>> LoginServlet HIT <<<");

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
     // Basic validation
        if (username == null || password == null ||
            username.trim().isEmpty() || password.trim().isEmpty()) {

            response.sendRedirect(request.getContextPath() + "/public/home.jsp?error=1");
            return;
        }

        UserDAO userDAO = new UserDAO();
        User user = userDAO.validateUser(username);

        // User exists and password matches
        if (user != null && BCrypt.checkpw(password, user.getPassword())) {

            HttpSession session = request.getSession(true);
            session.setAttribute("username", user.getUsername());
            session.setAttribute("role", user.getRole());
            session.setMaxInactiveInterval(60 * 60); // 60 minutes

            // Role-based redirect
            String role = user.getRole();

            if ("ADMIN".equalsIgnoreCase(role)) {
                response.sendRedirect(request.getContextPath() + "/admin/dashboard_admin.jsp");
            } else if ("USER".equalsIgnoreCase(role)) {
                response.sendRedirect(request.getContextPath() + "/user/dashboard_user.jsp");
            } else if ("TRAINER".equalsIgnoreCase(role)) {
                response.sendRedirect(request.getContextPath() + "/trainer/dashboard_trainer.jsp");
            } else {
                // Fallback
                response.sendRedirect(request.getContextPath() + "/public/home.jsp");
            }

        } else {
            // Invalid login
            response.sendRedirect(request.getContextPath() +"/public/home.jsp?error=1");
        }
    }
}
        
        
//        Connection conn = null;
//        PreparedStatement pst = null;
//        ResultSet rs = null;
//
//        try {
//            // DB connection
//        	conn = DBUtil.getConnection();
//
//            String sql = "SELECT * FROM users WHERE username=?";
//            pst = conn.prepareStatement(sql);
//            pst.setString(1, username);
//            rs = pst.executeQuery();
//
//            if(rs.next()) {
//                String hashedPassword = rs.getString("password");
//                String role = rs.getString("role");
//
//                if(BCrypt.checkpw(password, hashedPassword)) {
//                    // Successful login → create session
//                    HttpSession session = request.getSession();
//                    session.setAttribute("username", username);
//                    session.setAttribute("role", role);
//                    session.setMaxInactiveInterval(30*60); // 30 minutes
//
//                    // Redirect based on role
//                    switch(role.toUpperCase()) {
//                        case "ADMIN":
//                            response.sendRedirect("admin/dashboard.jsp");
//                            break;
//                        case "USER":
//                            response.sendRedirect("user/dashboard.jsp");
//                            break;
//                        case "TRAINER":
//                            response.sendRedirect("trainer/home.jsp");
//                            break;
//                        default:
//                            response.sendRedirect("home.jsp");
//                    }
//                } else {
//                    response.sendRedirect("login.jsp?error=1");
//                }
//
//            } else {
//                response.sendRedirect("login.jsp?error=1");
//            }
//
//        } catch(Exception e) {
//            e.printStackTrace();
//            response.sendRedirect("login.jsp?error=1");
//        } finally {
//            try { if(rs!=null) rs.close(); } catch(Exception e) {}
//            try { if(pst!=null) pst.close(); } catch(Exception e) {}
//            try { if(conn!=null) conn.close(); } catch(Exception e) {}
//        }
//    }
//}
