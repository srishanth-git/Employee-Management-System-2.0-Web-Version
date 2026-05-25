<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String ctx = request.getContextPath();
    String currentUri = request.getRequestURI();
    String toast = (String) session.getAttribute("toast");
    if (toast != null) session.removeAttribute("toast");
    model.User loggedInUser = (model.User) session.getAttribute("loggedInUser");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= request.getAttribute("pageTitle") != null ? request.getAttribute("pageTitle") : "EMS" %> — Employee Management System</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<%= ctx %>/css/style.css">
</head>
<body>

<nav class="sidebar">
    <div class="sidebar-brand">
        <div class="brand-icon">⚡</div>
        <div class="brand-text">
            <span class="brand-name">EMS</span>
            <span class="brand-sub">Management</span>
        </div>
    </div>

    <ul class="nav-links">
        <li>
            <a href="<%= ctx %>/dashboard" class="<%= currentUri.contains("/dashboard") ? "active" : "" %>">
                <span class="nav-icon">🏠</span>
                <span>Dashboard</span>
            </a>
        </li>
        <li>
            <a href="<%= ctx %>/employees" class="<%= currentUri.contains("/employees") ? "active" : "" %>">
                <span class="nav-icon">👥</span>
                <span>Employees</span>
            </a>
        </li>
        <li>
            <a href="<%= ctx %>/departments" class="<%= currentUri.contains("/departments") ? "active" : "" %>">
                <span class="nav-icon">🏢</span>
                <span>Departments</span>
            </a>
        </li>
        <li>
            <a href="<%= ctx %>/reports" class="<%= currentUri.contains("/reports") ? "active" : "" %>">
                <span class="nav-icon">📊</span>
                <span>Reports</span>
            </a>
        </li>
    </ul>

    <div class="sidebar-footer">
        <% if (loggedInUser != null) { %>
        <div style="font-size:12px; color:#aaa; margin-bottom:8px;">
            👤 <%= loggedInUser.getFullName() %>
        </div>
        <% } %>
        <a href="<%= ctx %>/auth/logout"
           style="display:block; text-align:center; background:#e74c3c; color:white;
                  padding:8px 14px; border-radius:8px; text-decoration:none;
                  font-size:13px; font-weight:600; margin-bottom:10px;">
            🚪 Logout
        </a>

    </div>
</nav>

<main class="main-content">
    <% if (toast != null) { %>
    <div class="toast" id="toast"><%= toast %></div>
    <script>setTimeout(() => document.getElementById('toast').classList.add('hide'), 3500);</script>
    <% } %>
