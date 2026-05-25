package dao;

import model.Department;
import util.DBConnection;

import java.sql.*;
import java.util.*;

public class DepartmentDAO {

    public boolean addDepartment(Department d) {
        String sql = "INSERT INTO departments (dept_name, location) VALUES (?,?)";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, d.getDeptName());
            ps.setString(2, d.getLocation());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[DAO] addDept: " + e.getMessage());
            return false;
        }
    }

    public List<Department> getAllDepartments() {
        String sql = "SELECT d.*, COUNT(e.emp_id) AS emp_count FROM departments d LEFT JOIN employees e ON d.dept_id=e.dept_id GROUP BY d.dept_id ORDER BY d.dept_id";
        List<Department> list = new ArrayList<>();
        try (Connection c = DBConnection.getConnection();
             Statement s = c.createStatement();
             ResultSet rs = s.executeQuery(sql)) {
            while (rs.next()) {
                Department d = new Department();
                d.setDeptId       (rs.getInt   ("dept_id"));
                d.setDeptName     (rs.getString("dept_name"));
                d.setLocation     (rs.getString("location"));
                d.setEmployeeCount(rs.getInt   ("emp_count"));
                list.add(d);
            }
        } catch (SQLException e) {
            System.err.println("[DAO] getAllDepts: " + e.getMessage());
        }
        return list;
    }

    public Department getDepartmentById(int id) {
        String sql = "SELECT * FROM departments WHERE dept_id=?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Department d = new Department();
                d.setDeptId  (rs.getInt   ("dept_id"));
                d.setDeptName(rs.getString("dept_name"));
                d.setLocation(rs.getString("location"));
                return d;
            }
        } catch (SQLException e) {
            System.err.println("[DAO] getDeptById: " + e.getMessage());
        }
        return null;
    }

    public boolean updateDepartment(Department d) {
        String sql = "UPDATE departments SET dept_name=?, location=? WHERE dept_id=?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, d.getDeptName());
            ps.setString(2, d.getLocation());
            ps.setInt   (3, d.getDeptId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[DAO] updateDept: " + e.getMessage());
            return false;
        }
    }

    public boolean deleteDepartment(int id) {
        String sql = "DELETE FROM departments WHERE dept_id=?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[DAO] deleteDept: " + e.getMessage());
            return false;
        }
    }
}
