<%--
  Created by IntelliJ IDEA.
  User: Ivan
  Date: 23.06.2014
  Time: 11:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Human Resources</title>
    <style type="text/css">
        <%@include file="styles.css"%>
    </style>
    <%--
    ----Script for clearing input fields.
    --%>
    <script type="text/javascript">
        function clearFields() {
            document.getElementById('addPassportId').value = '';
            document.getElementById('addFirstName').value = '';
            document.getElementById('addSurName').value = '';
            document.getElementById('addBirthday').value = '';
            document.getElementById('addSalary').value = '';
            document.getElementById('addDeptName').value = '1';
            document.getElementById('addPosName').value = 'PR Manager';
        }
    </script>
</head>

<body>
<div id="common_content">
    <div id="cap">
        <h1>Human Resources <br/>Department</h1>
    </div>
<%--
----Information about departments.
--%>
    <div id="departments">
        <table border="0" width="200">
            <tr class="fix_cell" style="padding-top: 10px">
                <td><h2>Departments</h2></td>
            </tr>
            <tr>
                <td style="height: 60px"></td>
            </tr>
            <c:forEach var="dept" items="${requestScope.departments}">
                <tr>
                    <td><a href='/main?dept=<c:out value="${dept.deptName}"/>'><h5><c:out
                            value="${dept.deptName}"/></h5></a></td>
                </tr>
            </c:forEach>
        </table>
    </div>
<%--
----Information about employees.
----"Welcome"
--%>
    <div id="names_surnames">
        <c:if test="${requestScope.employees != null}">
            <table border="0" width="640">
                <tr class="fix_cell" style="padding-top: 10px">
                    <td><h2>Name</h2></td>
                    <td><h2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Surname</h2></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td style="height: 70px"></td>
                </tr>
                <c:forEach var="employee" items="${requestScope.employees}">
                    <tr>
                        <td>${employee.firstName}</td>
                        <td><c:out value="${employee.surName}"/></td>
                        <form action="/main" method="post">
                            <td>
                                <input type="submit" value="Edit" name="editEmployee" class="edit_button"/>
                                <input type="hidden" value="${employee.passportId}" name="employeeForChange"/>
                            </td>
                        </form>
                        <form action="/main" method="post">
                            <td>
                                <input type="submit" value="Delete" name="delete" class="delete_button"/>
                                <input type="hidden" value="${employee.passportId}" name="deleteId"/>
                                <input type="hidden" value="${employee.deptName}" name="dept"/>
                            </td>
                        </form>
                    </tr>
                </c:forEach>
            </table>
        </c:if>
        <c:if test="${requestScope.employees == null}">
            <br/><br/><br/><br/><span style="font-size: 40px; text-align: center;"><h2>Welcome!</h2></span>
        </c:if>
    </div>
    <%--
    ----Form for adding new department.
    --%>
    <div id="dept_add_bg">
        <div id="dept_add">
            <form action="/main" method="post">
                <span style="font-size: 25px;">Adding new department</span><br/><br/><br/>
                <span style="font-size: 18px;">Enter department name: </span>
                <input type="text" name="deptName" class="dept_text" maxlength="50" required="required"/> <br/><br/>
                <input type="submit" value="Save Department" class="win_button" name="addDept"/> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="button" value="Cancel" class="win_button"
                       onclick="document.getElementById('dept_add_bg').style.display='none';"/>
            </form>
        </div>
    </div>
    <%--
    ----Form for adding new employee.
    --%>
    <div id="employee_add_bg">
        <div class="employee_form">
            <form action="/main" method="post">
                <span class="win_title">Enter employee information:</span>
                <br/><br/>

                <span class="addText">Passport ID: </span>
                <input type="text" name="passportId" id="addPassportId" pattern="[A-Za-z]{2}[0-9]{6}"
                       required title="AA123456" maxlength="8" class="employee_input"/> <br/>

                <span class="addText">Name: </span>
                <input type="text" name="firstName" id="addFirstName" maxlength="20" pattern=".{2,20}"
                       required="required" class="employee_input"/> <br/>

                <span class="addText">surName: </span>
                <input type="text" name="surName" id="addSurName" maxlength="50" pattern=".{2,50}"
                       required="required" class="employee_input"/> <br/>

                <span class="addText">Birthday: </span>
                <input type="text" name="birthday" id="addBirthday" required title="yyyy-MM-dd" class="employee_input"
                       pattern="[0-9]{4}-[0-9]{2}-[0-9]{2}" maxlength="10"/> <br/>

                <span class="addText">Salary: </span>
                <input type="text" name="salary" id="addSalary" pattern="^[0-9]+$" maxlength="4" required="required"
                       class="employee_input"/><br/>

                <span class="addText">Select department: </span>
                <select name="selectedDept" id="addDeptName" class="employee_input">
                    <c:forEach var="dept" items="${requestScope.departments}">
                        <c:choose>
                            <c:when test="${param.dept == dept.deptName}">
                                <option value="${dept.deptId}" selected><c:out value="${dept.deptName}"/></option>
                            </c:when>
                            <c:otherwise>
                                <option value="${dept.deptId}"><c:out value="${dept.deptName}"/></option>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </select><br/>

                <span class="addText">Select position: </span>
                <select name="posName" id="addPosName" class="employee_input">
                    <c:forEach var="position" items="${requestScope.positions}">
                        <option value="${position.posName}"><c:out value="${position.posName}"/></option>
                    </c:forEach>
                </select>

                <div align="center">
                    <input type="hidden" value=>
                    <input type="submit" value="Add" name="addEmployee" class="win_button" id="addEmployee"/>
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="button" value="Cancel" class="win_button"
                           onclick="document.getElementById('employee_add_bg').style.display='none'"/>
                </div>
            </form>
        </div>
    </div>
<%--
----Buttons in the bottom of the screen.
--%>
    <div id="footer">
        <input type="button" value="Add Department" class="big_button"
               onclick="document.getElementById('dept_add_bg').style.display='block'"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="button" value="Add Employee" class="big_button"
               onclick="clearFields(); document.getElementById('employee_add_bg').style.display='block';"/>
    </div>
    <div id="footer_message">
        <span style="font-size: 20px; text-align: center;">${requestScope.message}</span>
    </div>
</div>
</body>
</html>