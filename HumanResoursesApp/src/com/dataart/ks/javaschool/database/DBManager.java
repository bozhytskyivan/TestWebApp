package com.dataart.ks.javaschool.database;

import com.dataart.ks.javaschool.model.Department;
import com.dataart.ks.javaschool.model.Employee;
import com.dataart.ks.javaschool.model.Position;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Ivan on 22.06.2014.
 */
public class DBManager {
    private static Connection connection;
    private static DBManager instance;
    private static DataSource dataSource;

    private DBManager() {
    }

    public static synchronized DBManager getInstance() {
        if (instance == null) {
            try {
                instance = new DBManager();
                Context ctx = new InitialContext();
                instance.dataSource = (DataSource) ctx.lookup("java:comp/env/jdbc/HumanRes");
                connection = dataSource.getConnection();
            } catch (NamingException e) {
                e.printStackTrace();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return instance;
    }

    public void addDepartment(String deptName) throws SQLException {
        PreparedStatement preparedStatement = connection.prepareStatement(
                "INSERT INTO departments (deptName)" +
                        "VALUES (?)");
        preparedStatement.setString(1, deptName);
        preparedStatement.execute();
        preparedStatement.close();
    }

    public static void closeConnection() throws SQLException {
        if (instance != null) {
            connection.close();
            instance = null;
        }
    }

    public List<Department> getAllDepts() throws SQLException {
        List<Department> departments = new ArrayList<>();
        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery(
                "SELECT deptId, deptName FROM departments");
        while (resultSet.next()) {
            Department anotherDepartment = new Department();
            anotherDepartment.setDeptId(resultSet.getInt(1));
            anotherDepartment.setDeptName(resultSet.getString(2));
            departments.add(anotherDepartment);
        }
        resultSet.close();
        statement.close();

        return departments;
    }

    public List<Position> getPositions() throws SQLException {
        List<Position> positions = new ArrayList<>();
        Statement statement = connection.createStatement();

        ResultSet resultSet = statement.executeQuery(
                "SELECT posId, posName, minSalary, maxSalary " +
                        "FROM positions");

        while (resultSet.next()) {
            Position currentPosition = new Position();
            currentPosition.setPosId(resultSet.getInt(1));
            currentPosition.setPosName(resultSet.getString(2));
            currentPosition.setMinSalary(resultSet.getInt(3));
            currentPosition.setMaxSalary(resultSet.getInt(4));
            positions.add(currentPosition);
        }
        resultSet.close();
        statement.close();

        return positions;
    }

    public List<Employee> getEmployeesInDept(String deptName) throws SQLException {
        PreparedStatement preparedStatement = connection.prepareStatement(
                "SELECT Employees.passportId, Employees.firstName, Employees.surName, Employees.birthday, " +
                        "Employees.salary, departments.deptName, Employees.posName " +
                        "FROM employees, departments " +
                        "WHERE departments.deptName=? AND employees.deptId=departments.deptId");
        preparedStatement.setString(1, deptName);
        ResultSet resultSet = preparedStatement.executeQuery();
        List<Employee> employeesInDept = new ArrayList<>();

        while (resultSet.next()) {
            Employee currentEmployee = new Employee();

            currentEmployee.setPassportId(resultSet.getString(1));
            currentEmployee.setFirstName(resultSet.getString(2));
            currentEmployee.setSurName(resultSet.getString(3));
            currentEmployee.setBirthday(resultSet.getDate(4));
            currentEmployee.setSalary(resultSet.getInt(5));
            currentEmployee.setDeptName(resultSet.getString(6));
            currentEmployee.setPosName(resultSet.getString(7));

            employeesInDept.add(currentEmployee);
        }
        resultSet.close();
        preparedStatement.close();

        return employeesInDept;
    }

    public Employee getEmployee(String passportId) throws SQLException {
        PreparedStatement preparedStatement = connection.prepareStatement(
                "SELECT employees.passportId, employees.firstName, employees.surName, employees.birthday, " +
                        "employees.salary, departments.deptName, employees.posName " +
                        "FROM employees, departments " +
                        "WHERE employees.passportId=? AND departments.deptId=employees.deptId");

        preparedStatement.setString(1, passportId);
        ResultSet resultSet = preparedStatement.executeQuery();
        Employee employee = new Employee();

        while (resultSet.next()) {
            employee.setPassportId(resultSet.getString(1));
            employee.setFirstName(resultSet.getString(2));
            employee.setSurName(resultSet.getString(3));
            employee.setBirthday(resultSet.getDate(4));
            employee.setSalary(resultSet.getInt(5));
            employee.setDeptName(resultSet.getString(6));
            employee.setPosName(resultSet.getString(7));
        }
        resultSet.close();
        preparedStatement.close();

        return employee;
    }

    public void deleteEmployee(String passportId) throws SQLException {
        PreparedStatement preparedStatement = connection.prepareStatement(
                "DELETE FROM employees " +
                        "WHERE passportId=?");

        preparedStatement.setString(1, passportId);
        preparedStatement.execute();
        preparedStatement.close();
    }

    public void updateEmployee(Employee employee) throws SQLException {
        PreparedStatement preparedStatement = connection.prepareStatement(
                "UPDATE employees " +
                        "SET salary=?, deptId=? " +
                        "WHERE passportId=?");

        preparedStatement.setInt(1, employee.getSalary());
        preparedStatement.setInt(2, Integer.parseInt(employee.getDeptName()));
        preparedStatement.setString(3, employee.getPassportId());
        preparedStatement.execute();
        preparedStatement.close();
    }

    public void addEmployee(Employee employee) throws SQLException {
        PreparedStatement preparedStatement = connection.prepareStatement(
                "INSERT INTO employees " +
                        "(passportId, firstName, surName, birthday, salary, deptId, posName)" +
                        "VALUES (?, ?, ?, ?, ?, ?, ?)");

        preparedStatement.setString(1, employee.getPassportId());
        preparedStatement.setString(2, employee.getFirstName());
        preparedStatement.setString(3, employee.getSurName());
        preparedStatement.setDate(4, (Date) employee.getBirthday());
        preparedStatement.setInt(5, employee.getSalary());
        preparedStatement.setInt(6, Integer.parseInt(employee.getDeptName()));
        preparedStatement.setString(7, employee.getPosName());

        preparedStatement.execute();
    }
}
