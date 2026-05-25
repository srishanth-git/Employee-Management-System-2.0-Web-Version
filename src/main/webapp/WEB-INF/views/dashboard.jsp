<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/header.jsp" %>

<div class="page-header">
    <div>
        <h1 class="page-title">Dashboard</h1>
        <p class="page-sub">Welcome back, <strong>${loggedInUser.fullName}</strong> 👋</p>
    </div>
</div>

<div style="display: flex; gap: 24px; flex-wrap: wrap; margin-bottom: 36px;">

    <!-- Employees Card -->
    <div style="flex:1; min-width:200px; background: linear-gradient(135deg,#1F4E79,#2E75B6);
                color:white; border-radius:16px; padding:32px 28px; box-shadow:0 8px 24px rgba(31,78,121,0.3);">
        <div style="font-size:40px; margin-bottom:8px;">👥</div>
        <div style="font-size:48px; font-weight:800; font-family:'Syne',sans-serif;">${totalEmployees}</div>
        <div style="font-size:15px; opacity:0.85; margin:6px 0 20px;">Total Employees</div>
        <a href="${pageContext.request.contextPath}/employees"
           style="display:inline-block; background:rgba(255,255,255,0.2); color:white;
                  padding:8px 20px; border-radius:20px; text-decoration:none;
                  font-size:13px; font-weight:600; border:1px solid rgba(255,255,255,0.4);">
            View All →
        </a>
    </div>

    <!-- Departments Card -->
    <div style="flex:1; min-width:200px; background: linear-gradient(135deg,#1a7a4a,#27ae60);
                color:white; border-radius:16px; padding:32px 28px; box-shadow:0 8px 24px rgba(26,122,74,0.3);">
        <div style="font-size:40px; margin-bottom:8px;">🏢</div>
        <div style="font-size:48px; font-weight:800; font-family:'Syne',sans-serif;">${totalDepartments}</div>
        <div style="font-size:15px; opacity:0.85; margin:6px 0 20px;">Total Departments</div>
        <a href="${pageContext.request.contextPath}/departments"
           style="display:inline-block; background:rgba(255,255,255,0.2); color:white;
                  padding:8px 20px; border-radius:20px; text-decoration:none;
                  font-size:13px; font-weight:600; border:1px solid rgba(255,255,255,0.4);">
            View All →
        </a>
    </div>

    <!-- Reports Card -->
    <div style="flex:1; min-width:200px; background: linear-gradient(135deg,#7d3c98,#a569bd);
                color:white; border-radius:16px; padding:32px 28px; box-shadow:0 8px 24px rgba(125,60,152,0.3);">
        <div style="font-size:40px; margin-bottom:8px;">📊</div>
        <div style="font-size:48px; font-weight:800; font-family:'Syne',sans-serif;">—</div>
        <div style="font-size:15px; opacity:0.85; margin:6px 0 20px;">Salary Reports</div>
        <a href="${pageContext.request.contextPath}/reports"
           style="display:inline-block; background:rgba(255,255,255,0.2); color:white;
                  padding:8px 20px; border-radius:20px; text-decoration:none;
                  font-size:13px; font-weight:600; border:1px solid rgba(255,255,255,0.4);">
            View Reports →
        </a>
    </div>

</div>

<!-- Quick Actions -->
<div style="background:#1a1f2e; border-radius:16px; padding:28px; box-shadow:0 2px 12px rgba(0,0,0,0.06);">
    <h3 style="font-family:'Syne',sans-serif; color:#ffffff; margin-bottom:18px; font-size:18px;">Quick Actions</h3>
    <div style="display:flex; gap:14px; flex-wrap:wrap;">
        <a href="${pageContext.request.contextPath}/employees/add"
           style="padding:10px 22px; background:#1F4E79; color:white; border-radius:8px;
                  text-decoration:none; font-size:14px; font-weight:500;">
            ➕ Add Employee
        </a>
        <a href="${pageContext.request.contextPath}/departments/add"
           style="padding:10px 22px; background:#1a7a4a; color:white; border-radius:8px;
                  text-decoration:none; font-size:14px; font-weight:500;">
            ➕ Add Department
        </a>
        <a href="${pageContext.request.contextPath}/reports"
           style="padding:10px 22px; background:#7d3c98; color:white; border-radius:8px;
                  text-decoration:none; font-size:14px; font-weight:500;">
            📊 View Reports
        </a>
    </div>
</div>

<%@ include file="/WEB-INF/views/footer.jsp" %>
