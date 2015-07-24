package com.dataart.ks.javaschool.servlet;

import com.dataart.ks.javaschool.database.DBManager;
import com.dataart.ks.javaschool.model.Department;
import com.dataart.ks.javaschool.model.Employee;
import com.dataart.ks.javaschool.model.Position;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.sql.Date;
import java.util.Enumeration;
import java.util.List;

/**
 * Created by Ivan on 22.06.2014.
 */
public class MainServlet extends HttpServlet {

    public List<Department> departments;
    public List<Position> positions;

    protected void processQuery(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String message = null;

        try {
            if (departments == null) {
                departments = DBManager.getInstance().getAllDepts();
            }
            if (positions == null) {
                positions = DBManager.getInstance().getPositions();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        Enumeration queryParameters = req.getParameterNames();

        while (queryParameters.hasMoreElements()) {

            Object parameter = queryParameters.nextElement();

            if (parameter.equals("addDept")) {
                try {
                    DBManager.getInstance().addDepartment(req.getParameter("deptName"));
                    departments = DBManager.getInstance().getAllDepts();
                    message = "Department has been successfully added.";
                } catch (SQLException ex) {
                    message = "Fail. Department has not been added!";
                    ex.printStackTrace();
                }
            }
            if (parameter.equals("dept") || parameter.equals("addEmployee") || parameter.equals("changeEmployee")) {
                try {
                    String deptName = req.getParameter("dept");
                    if (parameter.equals("addEmployee") || parameter.equals("changeEmployee")) {
                        int deptId = Integer.parseInt(req.getParameter("selectedDept"));
                        for (Department dept : departments) {
                            if (dept.getDeptId() == deptId) {
                                deptName = dept.getDeptName();
                            }
                        }
                    }
                    List employeesInDept = DBManager.getInstance().getEmployeesInDept(deptName);
                    req.setAttribute("employees", employeesInDept);
                } catch (SQLException e) {
                    message = "Employees list has not been loaded!";
                    e.printStackTrace();
                }
            }
            if (parameter.equals("delete")) {
                try {
                    DBManager.getInstance().deleteEmployee(req.getParameter("deleteId"));
                    message = "Employee has been successfully deleted.";
                } catch (SQLException e) {
                    message = "Database error!";
                    e.printStackTrace();
                }
            }
            if (parameter.equals("editEmployee")) {
                try {
                    String passportId = req.getParameter("employeeForChange");
                    Employee employeeForChange = DBManager.getInstance().getEmployee(passportId);
                    req.setAttribute("employee", employeeForChange);
                    req.setAttribute("departments", departments);
                    getServletContext().getRequestDispatcher("/editForm.jsp").forward(req, resp);
                    return;
                } catch (SQLException e) {
                    message = "Database error!";
                    e.printStackTrace();
                }
            }
            if (parameter.equals("changeEmployee") || parameter.equals("addEmployee")) {
                Employee newEmployee = getEmployeeFromRequest(req);
                if (salaryIsValid(newEmployee)) {
                    try {
                        if (parameter.equals("changeEmployee")) {
                            DBManager.getInstance().updateEmployee(newEmployee);
                            message = "Employee data has been successfully updated.";
                        }
                        if (parameter.equals("addEmployee")) {
                            DBManager.getInstance().addEmployee(newEmployee);
                            message = "New employee has been successfully added.";
                        }
                    } catch (SQLException e) {
                        message = "Database error!";
                        e.printStackTrace();
                    }
                } else {
                    message = "Error! Entered salary is not valid!";
                }
            }
        }
        req.setAttribute("message", message);
        req.setAttribute("departments", departments);
        req.setAttribute("positions", positions);

        getServletContext().getRequestDispatcher("/index.jsp").forward(req, resp);
        try {
            DBManager.closeConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Employee getEmployeeFromRequest(HttpServletRequest req) {
        Employee newEmployee = new Employee();
        newEmployee.setPassportId(req.getParameter("passportId"));
        newEmployee.setFirstName(req.getParameter("firstName"));
        newEmployee.setSurName(req.getParameter("surName"));
        newEmployee.setBirthday(Date.valueOf(req.getParameter("birthday")));
        newEmployee.setSalary(Integer.parseInt(req.getParameter("salary")));
        newEmployee.setDeptName(req.getParameter("selectedDept"));
        newEmployee.setPosName(req.getParameter("posName"));
        return newEmployee;
    }

    public boolean salaryIsValid(Employee employee) {
        boolean validation = true;
        for (Position position : positions) {
            if (employee.getPosName().equals(position.getPosName())) {
                if ((employee.getSalary() > position.getMaxSalary()) ||
                        (employee.getSalary() < position.getMinSalary())) {
                    validation = false;
                }
            }
        }
        return validation;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        processQuery(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        processQuery(req, resp);
    }
}
