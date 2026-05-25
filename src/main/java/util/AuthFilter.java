package util;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain chain) throws IOException, ServletException {

        HttpServletRequest req  = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String uri         = req.getRequestURI();
        String contextPath = req.getContextPath();

        // Allow login page and static resources without auth
        boolean isPublic = uri.contains("/auth/login")
                        || uri.contains("/css/")
                        || uri.contains("/js/")
                        || uri.contains("/images/")
                        || uri.contains("/favicon");

        if (isPublic) {
            chain.doFilter(request, response);
            return;
        }

        // Check session
        HttpSession session  = req.getSession(false);
        boolean isLoggedIn   = (session != null && session.getAttribute("loggedInUser") != null);

        if (isLoggedIn) {
            chain.doFilter(request, response);
        } else {
            res.sendRedirect(contextPath + "/auth/login");
        }
    }
}
