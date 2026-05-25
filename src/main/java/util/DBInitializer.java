package util;

import java.sql.Connection;
import java.sql.Statement;
import java.sql.SQLException;

public class DBInitializer {

    public static void initialize() {
        String createDepts = """
            CREATE TABLE IF NOT EXISTS departments (
                dept_id   INT PRIMARY KEY AUTO_INCREMENT,
                dept_name VARCHAR(100) NOT NULL UNIQUE,
                location  VARCHAR(100) NOT NULL
            );
        """;

        String createEmps = """
            CREATE TABLE IF NOT EXISTS employees (
                emp_id      INT PRIMARY KEY AUTO_INCREMENT,
                first_name  VARCHAR(50)  NOT NULL,
                last_name   VARCHAR(50)  NOT NULL,
                email       VARCHAR(100) NOT NULL UNIQUE,
                phone       VARCHAR(20),
                hire_date   DATE         NOT NULL,
                job_title   VARCHAR(100) NOT NULL,
                salary      DOUBLE       NOT NULL,
                dept_id     INT,
                FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
            );
        """;

        String insertDepts = """
            INSERT IGNORE INTO departments (dept_name, location) VALUES
                ('Engineering',     'Floor 3'),
                ('Human Resources', 'Floor 1'),
                ('Finance',         'Floor 2'),
                ('Marketing',       'Floor 4'),
                ('Operations',      'Floor 5');
        """;

        String insertEmps = """
            INSERT IGNORE INTO employees
                (first_name, last_name, email, phone, hire_date, job_title, salary, dept_id)
            VALUES
                ('Aarav',  'Sharma', 'aarav.sharma@company.com',  '9876543210', '2022-01-15', 'Software Engineer', 72000, 1),
                ('Priya',  'Reddy',  'priya.reddy@company.com',   '9876543211', '2021-06-01', 'HR Manager',        65000, 2),
                ('Rahul',  'Verma',  'rahul.verma@company.com',   '9876543212', '2023-03-10', 'Financial Analyst', 68000, 3),
                ('Sneha',  'Iyer',   'sneha.iyer@company.com',    '9876543213', '2022-09-20', 'Marketing Lead',    70000, 4),
                ('Vikram', 'Nair',   'vikram.nair@company.com',   '9876543214', '2020-11-05', 'Senior Engineer',   90000, 1);
        """;

        String createUsers = """
            CREATE TABLE IF NOT EXISTS users (
                user_id   INT PRIMARY KEY AUTO_INCREMENT,
                username  VARCHAR(50)  NOT NULL UNIQUE,
                password  VARCHAR(255) NOT NULL,
                full_name VARCHAR(100)
            );
        """;

        String insertUsers = """
            INSERT IGNORE INTO users (username, password, full_name) VALUES
                ('admin',      'admin123', 'Administrator'),
                ('srishanth',  'sri2006',  'Srishanth');
        """;

        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement()) {
            stmt.execute(createDepts);
            stmt.execute(createEmps);
            stmt.execute(insertDepts);
            stmt.execute(insertEmps);
            stmt.execute(createUsers);
            stmt.execute(insertUsers);
            System.out.println("[DB] Tables initialized.");
        } catch (SQLException e) {
            System.err.println("[DB] Init error: " + e.getMessage());
        }
    }
}
