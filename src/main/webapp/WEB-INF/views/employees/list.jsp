<%@ page contentType="text/html;charset=UTF-8" import="java.util.*,model.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% request.setAttribute("pageTitle", "Employees"); %>
<jsp:include page="/WEB-INF/views/header.jsp"/>

<div class="page-header">
    <div>
        <h1 class="page-title">Employees</h1>
        <p class="page-sub">Manage your workforce</p>
    </div>
    <a href="${pageContext.request.contextPath}/employees/add" class="btn btn-primary">+ Add Employee</a>
</div>

<!-- Search & Filter Bar -->
<div class="filter-bar">
    <form method="get" action="${pageContext.request.contextPath}/employees" class="filter-form">
        <div class="search-wrap">
            <span class="search-icon">🔍</span>
            <input type="text" name="search" placeholder="Search by name…"
                   value="${search}" class="search-input">
        </div>
        <select name="dept" class="select-input">
            <option value="">All Departments</option>
            <c:forEach var="d" items="${departments}">
                <option value="${d.deptId}" ${deptFilter == d.deptId.toString() ? 'selected' : ''}>
                    ${d.deptName}
                </option>
            </c:forEach>
        </select>
        <button type="submit" class="btn btn-secondary">Filter</button>
        <a href="${pageContext.request.contextPath}/employees" class="btn btn-ghost">Clear</a>
    </form>
</div>

<!-- Employee Table -->
<div class="card">
    <c:choose>
        <c:when test="${empty employees}">
            <div class="empty-state">
                <div class="empty-icon">🔍</div>
                <p>No employees found.</p>
                <a href="${pageContext.request.contextPath}/employees/add" class="btn btn-primary">Add First Employee</a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="table-meta">
                <span class="count-badge">${employees.size()} records</span>
            </div>
            <div class="table-wrap">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Job Title</th>
                            <th>Department</th>
                            <th>Salary</th>
                            <th>Hire Date</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="emp" items="${employees}">
                            <tr>
                                <td><span class="id-badge">#${emp.empId}</span></td>
                                <td>
                                    <div class="emp-name">
                                        <div class="avatar">${emp.firstName.charAt(0)}${emp.lastName.charAt(0)}</div>
                                        <span>${emp.fullName}</span>
                                    </div>
                                </td>
                                <td class="text-muted">${emp.email}</td>
                                <td class="text-muted">${emp.phone}</td>
                                <td><span class="tag">${emp.jobTitle}</span></td>
                                <td>${emp.deptName}</td>
                                <td class="salary">
                                    ₹<fmt:formatNumber value="${emp.salary}" pattern="#,##0"/>
                                </td>
                                <td class="text-muted">${emp.hireDate}</td>
                                <td>
                                    <div class="action-btns">
                                        <a href="${pageContext.request.contextPath}/employees/edit?id=${emp.empId}"
                                           class="btn-icon btn-edit" title="Edit">✏️</a>
                                        <a href="${pageContext.request.contextPath}/employees/delete?id=${emp.empId}"
                                           class="btn-icon btn-delete" title="Delete"
                                           onclick="return confirm('Delete ${emp.fullName}?')">🗑️</a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="/WEB-INF/views/footer.jsp"/>
