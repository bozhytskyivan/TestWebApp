<%--
  Created by IntelliJ IDEA.
  User: Ivan
  Date: 25.06.2014
  Time: 12:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Employee editing</title>
    <style>
        <%@include file="styles.css"%>
    </style>
</head>
<body>
<%--
----Form for editing employee information.
--%>
<div id="employee_edit_bg">
    <div id="employee_edit" class="employee_form">
        <form action="/main" method="post">
            <span class="win_title">Edit employee information:</span>
            <br/><br/>

            <span class="addText">Passport ID: </span>
            <input type="text" value="${employee.passportId}" name="passportId" class="employee_input" readonly/><br/>

            <span class="addText">Name: </span>
            <input type="text" value="${employee.firstName}" name="firstName" class="employee_input" readonly/><br/>

            <span class="addText">surName: </span>
            <input type="text" value="${employee.surName}" name="surName" class="employee_input" readonly/><br/>

            <span class="addText">Birthday: </span>
            <input type="text" value="${employee.birthday}" name="birthday" class="employee_input" readonly/><br/>

            <span class="addText">Salary: </span>
            <input type="text" value="${employee.salary}" name="salary" pattern="^[0-9]+$" maxlength="4"
                   class="employee_input" required="required"/><br/>

            <span class="addText">Select department: </span>
            <select name="selectedDept" class="employee_input" required="required">
                <c:forEach var="dept" items="${requestScope.departments}">
                    <c:choose>
                        <c:when test="${employee.deptName == dept.deptName}">
                            <option value="${dept.deptId}" selected><c:out value="${dept.deptName}"/></option>
                        </c:when>
                        <c:otherwise>
                            <option value="${dept.deptId}"><c:out value="${dept.deptName}"/></option>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </select><br/>

            <span class="addText">Position: </span>
            <input type="text" value="${employee.posName}" name="posName" class="employee_input" readonly/><br/>

            <div align="center">
                <input type="submit" value="Save" class="win_button" name="changeEmployee" id="changeEmployee"/>
                &nbsp;&nbsp;&nbsp;&nbsp;
                <form action="/main" method="post">
                    <input type="hidden" value="${requestScope.employee.deptName}" name="dept"/>
                    <input type="submit" value="Cancel" class="win_button" name="cancel"/>
                </form>
            </div>
        </form>
    </div>
</div>
</body>
</html>
