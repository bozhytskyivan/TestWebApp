package com.dataart.ks.javaschool.model;

import java.sql.Date;

/**
 * Created by Ivan on 22.06.2014.
 */
public class Employee {

    private String passportId;
    private String firstName;
    private String surName;
    private Date birthday;
    private int salary;
    private String DeptName;
    private String posName;

    public String getPassportId() {
        return passportId;
    }

    public void setPassportId(String passportId) {
        this.passportId = passportId;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getSurName() {
        return surName;
    }

    public void setSurName(String surName) {
        this.surName = surName;
    }

    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

    public int getSalary() {
        return salary;
    }

    public void setSalary(int salary) {
        this.salary = salary;
    }

    public String getDeptName() {
        return DeptName;
    }

    public void setDeptName(String deptName) {
        this.DeptName = deptName;
    }

    public String getPosName() {
        return posName;
    }

    public void setPosName(String posName) {
        this.posName = posName;
    }
}
