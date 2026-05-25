<%@ page contentType="text/html;charset=UTF-8" import="java.util.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% request.setAttribute("pageTitle", "Reports"); %>
<jsp:include page="/WEB-INF/views/header.jsp"/>

<div class="page-header">
    <div>
        <h1 class="page-title">Reports & Analytics</h1>
        <p class="page-sub">Salary breakdown by department</p>
    </div>
</div>

<div class="card">
    <c:choose>
        <c:when test="${empty salaryReport}">
            <div class="empty-state">
                <div class="empty-icon">📊</div>
                <p>No data available. Add employees first.</p>
            </div>
        </c:when>
        <c:otherwise>
            <div class="table-wrap">
                <table class="data-table report-table">
                    <thead>
                        <tr>
                            <th>Department</th>
                            <th>Headcount</th>
                            <th>Avg Salary</th>
                            <th>Max Salary</th>
                            <th>Min Salary</th>
                            <th>Avg Bar</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<Map<String, Object>> report = (List<Map<String, Object>>) request.getAttribute("salaryReport");
                            double maxAvg = report.stream()
                                .mapToDouble(r -> (Double) r.get("avg_salary"))
                                .max().orElse(1);
                        %>
                        <c:forEach var="row" items="${salaryReport}">
                            <tr>
                                <td><strong>${row.dept_name}</strong></td>
                                <td><span class="count-badge">${row.total}</span></td>
                                <td class="salary">₹<fmt:formatNumber value="${row.avg_salary}" pattern="#,##0"/></td>
                                <td class="salary text-green">₹<fmt:formatNumber value="${row.max_salary}" pattern="#,##0"/></td>
                                <td class="salary text-muted">₹<fmt:formatNumber value="${row.min_salary}" pattern="#,##0"/></td>
                                <td class="bar-cell">
                                    <div class="bar-track">
                                        <div class="bar-fill"
                                             style="width: <fmt:formatNumber value="${row.avg_salary / maxAvg * 100}" maxFractionDigits="1"/>%">
                                        </div>
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
