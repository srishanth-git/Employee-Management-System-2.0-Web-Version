<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% request.setAttribute("pageTitle", "Departments"); %>
<jsp:include page="/WEB-INF/views/header.jsp"/>

<div class="page-header">
    <div>
        <h1 class="page-title">Departments</h1>
        <p class="page-sub">Manage your organization structure</p>
    </div>
    <a href="${pageContext.request.contextPath}/departments/add" class="btn btn-primary">+ Add Department</a>
</div>

<div class="dept-grid">
    <c:choose>
        <c:when test="${empty departments}">
            <div class="empty-state">
                <div class="empty-icon">🏢</div>
                <p>No departments yet.</p>
                <a href="${pageContext.request.contextPath}/departments/add" class="btn btn-primary">Add First Department</a>
            </div>
        </c:when>
        <c:otherwise>
            <c:forEach var="d" items="${departments}">
                <div class="dept-card">
                    <div class="dept-header">
                        <div class="dept-icon">🏢</div>
                        <div class="dept-actions">
                            <a href="${pageContext.request.contextPath}/departments/edit?id=${d.deptId}"
                               class="btn-icon btn-edit" title="Edit">✏️</a>
                            <a href="${pageContext.request.contextPath}/departments/delete?id=${d.deptId}"
                               class="btn-icon btn-delete" title="Delete"
                               onclick="return confirm('Delete department ${d.deptName}? This will fail if employees exist.')">🗑️</a>
                        </div>
                    </div>
                    <h3 class="dept-name">${d.deptName}</h3>
                    <p class="dept-location">📍 ${d.location}</p>
                    <div class="dept-footer">
                        <span class="emp-count">${d.employeeCount} employee${d.employeeCount != 1 ? 's' : ''}</span>
                        <a href="${pageContext.request.contextPath}/employees?dept=${d.deptId}"
                           class="view-link">View →</a>
                    </div>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="/WEB-INF/views/footer.jsp"/>
