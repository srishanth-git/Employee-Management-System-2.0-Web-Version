package servlet;

import dao.EmployeeDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/reports")
public class ReportsServlet extends HttpServlet {

    private final EmployeeDAO empDAO = new EmployeeDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.setAttribute("salaryReport", empDAO.getSalaryReport());
        req.getRequestDispatcher("/WEB-INF/views/reports.jsp").forward(req, res);
    }
}
