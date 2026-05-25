# 🌐 Employee Management System — Web Version

Converted from console app → full web application.

**Tech Stack:** HTML · CSS · Java Servlets · JSP · JSTL · JDBC · MySQL · Maven · Tomcat

---

## 📁 Project Structure

```
EMS-Web/
├── pom.xml
└── src/main/
    ├── java/
    │   ├── model/        Employee.java, Department.java
    │   ├── dao/          EmployeeDAO.java, DepartmentDAO.java
    │   ├── servlet/      EmployeeServlet.java, DepartmentServlet.java, ReportsServlet.java
    │   └── util/         DBConnection.java, DBInitializer.java, AppStartupListener.java
    └── webapp/
        ├── index.jsp     (redirects to /employees)
        ├── css/style.css
        ├── js/app.js
        └── WEB-INF/
            ├── web.xml
            └── views/
                ├── header.jsp, footer.jsp
                ├── employees/  list.jsp, form.jsp
                ├── departments/ list.jsp, form.jsp
                └── reports.jsp
```

---

## ⚙️ Setup Instructions

### Step 1 — MySQL

Make sure your `employeedb` database exists:
```sql
CREATE DATABASE IF NOT EXISTS employeedb;
```

Update your credentials in `src/main/java/util/DBConnection.java`:
```java
private static final String USER     = "root";
private static final String PASSWORD = "your_password";   // ← change this
```

Tables and sample data are **auto-created on first startup** via `DBInitializer`.

---

### Step 2 — Import in IDE

**IntelliJ IDEA:**
1. File → Open → select the `EMS-Web` folder
2. It auto-detects as a Maven project
3. Right-click `pom.xml` → Maven → Reload Project

**Eclipse (Enterprise Edition):**
1. File → Import → Maven → Existing Maven Projects
2. Browse to `EMS-Web` folder → Finish

---

### Step 3 — Add Tomcat

You need **Apache Tomcat 10.x** (for Jakarta EE / Servlet 5.0).

**IntelliJ:**
1. Run → Edit Configurations → + → Tomcat Server → Local
2. Application server → Configure → Tomcat home folder
3. Deployment tab → + → Artifact → `EMS-Web:war (exploded)`
4. Application context: `/ems`
5. Click Run ▶

**Eclipse:**
1. Servers view → New Server → Tomcat 10.x
2. Add EMS-Web project to server
3. Start server

---

### Step 4 — Open in Browser

```
http://localhost:8080/ems
```

---

## 🌐 URL Routes

| URL | Description |
|-----|-------------|
| `/ems/employees` | List all employees (+ search/filter) |
| `/ems/employees/add` | Add new employee form |
| `/ems/employees/edit?id=1` | Edit employee |
| `/ems/employees/delete?id=1` | Delete employee |
| `/ems/departments` | List all departments |
| `/ems/departments/add` | Add department |
| `/ems/departments/edit?id=1` | Edit department |
| `/ems/reports` | Salary report by department |

---

## ✅ Features

- ✅ Full CRUD — Employees & Departments
- ✅ Search by name
- ✅ Filter by department
- ✅ Salary report with visual bars
- ✅ Toast notifications (success/error)
- ✅ Auto DB initialization on startup
- ✅ PreparedStatement — SQL injection safe
- ✅ Dark theme responsive UI
