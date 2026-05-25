package dao;

import model.Employee;
import util.DBConnection;

import java.sql.*;
import java.util.*;

public class EmployeeDAO {

    // ── CREATE ────────────────────────────────────────────────────────────────
    public boolean addEmployee(Employee emp) {
        String sql = "INSERT INTO employees (first_name,last_name,email,phone,hire_date,job_title,salary,dept_id) VALUES (?,?,?,?,?,?,?,?)";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, emp.getFirstName());
            ps.setString(2, emp.getLastName());
            ps.setString(3, emp.getEmail());
            ps.setString(4, emp.getPhone());
            ps.setString(5, emp.getHireDate());
            ps.setString(6, emp.getJobTitle());
            ps.setDouble(7, emp.getSalary());
            ps.setInt   (8, emp.getDeptId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[DAO] addEmployee: " + e.getMessage());
            return false;
        }
    }

    // ── READ ALL ─────────────────────────────────────────────────────────────
    public List<Employee> getAllEmployees() {
        String sql = "SELECT e.*, d.dept_name FROM employees e LEFT JOIN departments d ON e.dept_id=d.dept_id ORDER BY e.emp_id";
        List<Employee> list = new ArrayList<>();
        try (Connection c = DBConnection.getConnection();
             Statement s = c.createStatement();
             ResultSet rs = s.executeQuery(sql)) {
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) {
            System.err.println("[DAO] getAllEmployees: " + e.getMessage());
        }
        return list;
    }

    // ── READ BY ID ────────────────────────────────────────────────────────────
    public Employee getEmployeeById(int id) {
        String sql = "SELECT e.*, d.dept_name FROM employees e LEFT JOIN departments d ON e.dept_id=d.dept_id WHERE e.emp_id=?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);
        } catch (SQLException e) {
            System.err.println("[DAO] getById: " + e.getMessage());
        }
        return null;
    }

    // ── SEARCH BY NAME ────────────────────────────────────────────────────────
    public List<Employee> searchByName(String kw) {
        String sql = "SELECT e.*, d.dept_name FROM employees e LEFT JOIN departments d ON e.dept_id=d.dept_id WHERE e.first_name LIKE ? OR e.last_name LIKE ? ORDER BY e.first_name";
        List<Employee> list = new ArrayList<>();
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            String like = "%" + kw + "%";
            ps.setString(1, like);
            ps.setString(2, like);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) {
            System.err.println("[DAO] searchByName: " + e.getMessage());
        }
        return list;
    }

    // ── BY DEPARTMENT ─────────────────────────────────────────────────────────
    public List<Employee> getByDept(int deptId) {
        String sql = "SELECT e.*, d.dept_name FROM employees e LEFT JOIN departments d ON e.dept_id=d.dept_id WHERE e.dept_id=? ORDER BY e.first_name";
        List<Employee> list = new ArrayList<>();
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, deptId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) {
            System.err.println("[DAO] getByDept: " + e.getMessage());
        }
        return list;
    }

    // ── UPDATE ────────────────────────────────────────────────────────────────
    public boolean updateEmployee(Employee emp) {
        String sql = "UPDATE employees SET first_name=?,last_name=?,email=?,phone=?,hire_date=?,job_title=?,salary=?,dept_id=? WHERE emp_id=?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, emp.getFirstName());
            ps.setString(2, emp.getLastName());
            ps.setString(3, emp.getEmail());
            ps.setString(4, emp.getPhone());
            ps.setString(5, emp.getHireDate());
            ps.setString(6, emp.getJobTitle());
            ps.setDouble(7, emp.getSalary());
            ps.setInt   (8, emp.getDeptId());
            ps.setInt   (9, emp.getEmpId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[DAO] updateEmployee: " + e.getMessage());
            return false;
        }
    }

    // ── DELETE ────────────────────────────────────────────────────────────────
    public boolean deleteEmployee(int id) {
        String sql = "DELETE FROM employees WHERE emp_id=?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[DAO] deleteEmployee: " + e.getMessage());
            return false;
        }
    }

    // ── SALARY REPORT ─────────────────────────────────────────────────────────
    public List<Map<String, Object>> getSalaryReport() {
        String sql = """
            SELECT d.dept_name,
                   COUNT(e.emp_id) AS total,
                   AVG(e.salary)   AS avg_salary,
                   MAX(e.salary)   AS max_salary,
                   MIN(e.salary)   AS min_salary
            FROM employees e
            JOIN departments d ON e.dept_id=d.dept_id
            GROUP BY d.dept_name
            ORDER BY avg_salary DESC
        """;
        List<Map<String, Object>> rows = new ArrayList<>();
        try (Connection c = DBConnection.getConnection();
             Statement s = c.createStatement();
             ResultSet rs = s.executeQuery(sql)) {
            while (rs.next()) {
                Map<String, Object> row = new LinkedHashMap<>();
                row.put("dept_name",  rs.getString("dept_name"));
                row.put("total",      rs.getInt("total"));
                row.put("avg_salary", rs.getDouble("avg_salary"));
                row.put("max_salary", rs.getDouble("max_salary"));
                row.put("min_salary", rs.getDouble("min_salary"));
                rows.add(row);
            }
        } catch (SQLException e) {
            System.err.println("[DAO] salaryReport: " + e.getMessage());
        }
        return rows;
    }

    // ── HELPER ────────────────────────────────────────────────────────────────
    private Employee mapRow(ResultSet rs) throws SQLException {
        Employee e = new Employee();
        e.setEmpId    (rs.getInt   ("emp_id"));
        e.setFirstName(rs.getString("first_name"));
        e.setLastName (rs.getString("last_name"));
        e.setEmail    (rs.getString("email"));
        e.setPhone    (rs.getString("phone"));
        e.setHireDate (rs.getString("hire_date"));
        e.setJobTitle (rs.getString("job_title"));
        e.setSalary   (rs.getDouble("salary"));
        e.setDeptId   (rs.getInt   ("dept_id"));
        try { e.setDeptName(rs.getString("dept_name")); } catch (SQLException ignored) {}
        return e;
    }
}
