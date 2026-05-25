<%@ page contentType="text/html;charset=UTF-8" import="model.*" %>
<%
    Department dept = (Department) request.getAttribute("department");
    boolean isEdit = (dept != null);
    request.setAttribute("pageTitle", isEdit ? "Edit Department" : "Add Department");
%>
<jsp:include page="/WEB-INF/views/header.jsp"/>

<div class="page-header">
    <div>
        <h1 class="page-title"><%= isEdit ? "Edit Department" : "Add New Department" %></h1>
        <p class="page-sub"><%= isEdit ? "Update department information" : "Create a new department" %></p>
    </div>
    <a href="${pageContext.request.contextPath}/departments" class="btn btn-ghost">← Back</a>
</div>

<div class="card form-card narrow-form">
    <form method="post"
          action="${pageContext.request.contextPath}/departments/<%= isEdit ? "edit" : "add" %>">

        <% if (isEdit) { %>
        <input type="hidden" name="deptId" value="<%= dept.getDeptId() %>">
        <% } %>

        <div class="form-group">
            <label>Department Name <span class="req">*</span></label>
            <input type="text" name="deptName" required
                   value="<%= isEdit ? dept.getDeptName() : "" %>"
                   placeholder="e.g. Engineering">
        </div>
        <div class="form-group">
            <label>Location <span class="req">*</span></label>
            <input type="text" name="location" required
                   value="<%= isEdit ? dept.getLocation() : "" %>"
                   placeholder="e.g. Floor 3">
        </div>

        <div class="form-actions">
            <a href="${pageContext.request.contextPath}/departments" class="btn btn-ghost">Cancel</a>
            <button type="submit" class="btn btn-primary">
                <%= isEdit ? "💾 Save Changes" : "➕ Add Department" %>
            </button>
        </div>
    </form>
</div>

<jsp:include page="/WEB-INF/views/footer.jsp"/>
