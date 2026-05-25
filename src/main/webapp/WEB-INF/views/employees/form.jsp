<%@ page contentType="text/html;charset=UTF-8" import="model.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    Employee emp = (Employee) request.getAttribute("employee");
    boolean isEdit = (emp != null);
    request.setAttribute("pageTitle", isEdit ? "Edit Employee" : "Add Employee");
%>
<jsp:include page="/WEB-INF/views/header.jsp"/>

<div class="page-header">
    <div>
        <h1 class="page-title"><%= isEdit ? "Edit Employee" : "Add New Employee" %></h1>
        <p class="page-sub"><%= isEdit ? "Update employee information" : "Fill in the details below" %></p>
    </div>
    <a href="${pageContext.request.contextPath}/employees" class="btn btn-ghost">← Back</a>
</div>

<div class="card form-card">
    <form method="post"
          action="${pageContext.request.contextPath}/employees/<%= isEdit ? "edit" : "add" %>"
          class="emp-form">

        <% if (isEdit) { %>
        <input type="hidden" name="empId" value="<%= emp.getEmpId() %>">
        <% } %>

        <div class="form-grid">
            <div class="form-group">
                <label>First Name <span class="req">*</span></label>
                <input type="text" name="firstName" required
                       value="<%= isEdit ? emp.getFirstName() : "" %>"
                       placeholder="Aarav">
            </div>
            <div class="form-group">
                <label>Last Name <span class="req">*</span></label>
                <input type="text" name="lastName" required
                       value="<%= isEdit ? emp.getLastName() : "" %>"
                       placeholder="Sharma">
            </div>
            <div class="form-group">
                <label>Email <span class="req">*</span></label>
                <input type="email" name="email" required
                       value="<%= isEdit ? emp.getEmail() : "" %>"
                       placeholder="aarav@company.com">
            </div>
            <div class="form-group">
                <label>Phone</label>
                <input type="text" name="phone"
                       value="<%= isEdit ? emp.getPhone() : "" %>"
                       placeholder="9876543210">
            </div>
            <div class="form-group">
                <label>Job Title <span class="req">*</span></label>
                <input type="text" name="jobTitle" required
                       value="<%= isEdit ? emp.getJobTitle() : "" %>"
                       placeholder="Software Engineer">
            </div>
            <div class="form-group">
                <label>Hire Date <span class="req">*</span></label>
                <input type="date" name="hireDate" required
                       value="<%= isEdit ? emp.getHireDate() : "" %>">
            </div>
            <div class="form-group">
                <label>Salary (₹) <span class="req">*</span></label>
                <input type="number" name="salary" required min="0" step="1000"
                       value="<%= isEdit ? (int)emp.getSalary() : "" %>"
                       placeholder="60000">
            </div>
            <div class="form-group">
                <label>Department <span class="req">*</span></label>
                <select name="deptId" required>
                    <option value="">-- Select Department --</option>
                    <c:forEach var="d" items="${departments}">
                        <option value="${d.deptId}"
                            <%= isEdit && emp.getDeptId() == 0 ? "" : "" %>>
                            ${d.deptName} — ${d.location}
                        </option>
                    </c:forEach>
                </select>
            </div>
        </div>

        <div class="form-actions">
            <a href="${pageContext.request.contextPath}/employees" class="btn btn-ghost">Cancel</a>
            <button type="submit" class="btn btn-primary">
                <%= isEdit ? "💾 Save Changes" : "➕ Add Employee" %>
            </button>
        </div>
    </form>
</div>

<jsp:include page="/WEB-INF/views/footer.jsp"/>
