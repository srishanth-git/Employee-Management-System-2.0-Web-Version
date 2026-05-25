package servlet;

import dao.DepartmentDAO;
import model.Department;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/departments/*")
public class DepartmentServlet extends HttpServlet {

    private final DepartmentDAO deptDAO = new DepartmentDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String path = req.getPathInfo();

        if (path == null || path.equals("/")) {
            req.setAttribute("departments", deptDAO.getAllDepartments());
            req.getRequestDispatcher("/WEB-INF/views/departments/list.jsp").forward(req, res);

        } else if (path.equals("/add")) {
            req.getRequestDispatcher("/WEB-INF/views/departments/form.jsp").forward(req, res);

        } else if (path.equals("/edit")) {
            int id = Integer.parseInt(req.getParameter("id"));
            Department d = deptDAO.getDepartmentById(id);
            if (d == null) { res.sendRedirect(req.getContextPath() + "/departments"); return; }
            req.setAttribute("department", d);
            req.getRequestDispatcher("/WEB-INF/views/departments/form.jsp").forward(req, res);

        } else if (path.equals("/delete")) {
            int id = Integer.parseInt(req.getParameter("id"));
            boolean ok = deptDAO.deleteDepartment(id);
            req.getSession().setAttribute("toast", ok ? "Department deleted." : "Cannot delete — employees exist in this department.");
            res.sendRedirect(req.getContextPath() + "/departments");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        String path = req.getPathInfo();

        if (path.equals("/add")) {
            Department d = new Department(req.getParameter("deptName"), req.getParameter("location"));
            boolean ok = deptDAO.addDepartment(d);
            req.getSession().setAttribute("toast", ok ? "Department added!" : "Failed to add department.");
            res.sendRedirect(req.getContextPath() + "/departments");

        } else if (path.equals("/edit")) {
            Department d = new Department();
            d.setDeptId  (Integer.parseInt(req.getParameter("deptId")));
            d.setDeptName(req.getParameter("deptName"));
            d.setLocation(req.getParameter("location"));
            boolean ok = deptDAO.updateDepartment(d);
            req.getSession().setAttribute("toast", ok ? "Department updated!" : "Update failed.");
            res.sendRedirect(req.getContextPath() + "/departments");
        }
    }
}
