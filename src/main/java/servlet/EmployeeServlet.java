package servlet;

import dao.DepartmentDAO;
import dao.EmployeeDAO;
import model.Department;
import model.Employee;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/employees/*")
public class EmployeeServlet extends HttpServlet {

    private final EmployeeDAO   empDAO  = new EmployeeDAO();
    private final DepartmentDAO deptDAO = new DepartmentDAO();

    // ── GET ───────────────────────────────────────────────────────────────────
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String path = req.getPathInfo(); // e.g. null, "/add", "/edit", "/search"

        if (path == null || path.equals("/")) {
            // LIST — optional search and dept filter
            String search = req.getParameter("search");
            String deptFilter = req.getParameter("dept");

            List<Employee> employees;
            if (search != null && !search.isBlank()) {
                employees = empDAO.searchByName(search.trim());
            } else if (deptFilter != null && !deptFilter.isBlank()) {
                employees = empDAO.getByDept(Integer.parseInt(deptFilter));
            } else {
                employees = empDAO.getAllEmployees();
            }

            req.setAttribute("employees",   employees);
            req.setAttribute("departments", deptDAO.getAllDepartments());
            req.setAttribute("search",      search);
            req.setAttribute("deptFilter",  deptFilter);
            req.getRequestDispatcher("/WEB-INF/views/employees/list.jsp").forward(req, res);

        } else if (path.equals("/add")) {
            req.setAttribute("departments", deptDAO.getAllDepartments());
            req.getRequestDispatcher("/WEB-INF/views/employees/form.jsp").forward(req, res);

        } else if (path.equals("/edit")) {
            int id = Integer.parseInt(req.getParameter("id"));
            Employee emp = empDAO.getEmployeeById(id);
            if (emp == null) { res.sendRedirect(req.getContextPath() + "/employees"); return; }
            req.setAttribute("employee",    emp);
            req.setAttribute("departments", deptDAO.getAllDepartments());
            req.getRequestDispatcher("/WEB-INF/views/employees/form.jsp").forward(req, res);

        } else if (path.equals("/delete")) {
            int id = Integer.parseInt(req.getParameter("id"));
            empDAO.deleteEmployee(id);
            req.getSession().setAttribute("toast", "Employee deleted successfully.");
            res.sendRedirect(req.getContextPath() + "/employees");
        }
    }

    // ── POST ──────────────────────────────────────────────────────────────────
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        String path = req.getPathInfo();

        if (path.equals("/add")) {
            Employee emp = buildFromRequest(req);
            boolean ok = empDAO.addEmployee(emp);
            req.getSession().setAttribute("toast", ok ? "Employee added successfully!" : "Failed to add employee.");
            res.sendRedirect(req.getContextPath() + "/employees");

        } else if (path.equals("/edit")) {
            Employee emp = buildFromRequest(req);
            emp.setEmpId(Integer.parseInt(req.getParameter("empId")));
            boolean ok = empDAO.updateEmployee(emp);
            req.getSession().setAttribute("toast", ok ? "Employee updated successfully!" : "Update failed.");
            res.sendRedirect(req.getContextPath() + "/employees");
        }
    }

    // ── HELPER ────────────────────────────────────────────────────────────────
    private Employee buildFromRequest(HttpServletRequest req) {
        Employee e = new Employee();
        e.setFirstName(req.getParameter("firstName"));
        e.setLastName (req.getParameter("lastName"));
        e.setEmail    (req.getParameter("email"));
        e.setPhone    (req.getParameter("phone"));
        e.setHireDate (req.getParameter("hireDate"));
        e.setJobTitle (req.getParameter("jobTitle"));
        e.setSalary   (Double.parseDouble(req.getParameter("salary")));
        e.setDeptId   (Integer.parseInt(req.getParameter("deptId")));
        return e;
    }
}
