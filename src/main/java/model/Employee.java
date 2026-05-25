package model;

public class Employee {
    private int    empId;
    private String firstName;
    private String lastName;
    private String email;
    private String phone;
    private String hireDate;
    private String jobTitle;
    private double salary;
    private int    deptId;
    private String deptName;

    public Employee() {}

    public Employee(String firstName, String lastName, String email,
                    String phone, String hireDate, String jobTitle,
                    double salary, int deptId) {
        this.firstName = firstName;
        this.lastName  = lastName;
        this.email     = email;
        this.phone     = phone;
        this.hireDate  = hireDate;
        this.jobTitle  = jobTitle;
        this.salary    = salary;
        this.deptId    = deptId;
    }

    public int    getEmpId()              { return empId; }
    public void   setEmpId(int v)         { this.empId = v; }
    public String getFirstName()          { return firstName; }
    public void   setFirstName(String v)  { this.firstName = v; }
    public String getLastName()           { return lastName; }
    public void   setLastName(String v)   { this.lastName = v; }
    public String getEmail()              { return email; }
    public void   setEmail(String v)      { this.email = v; }
    public String getPhone()              { return phone; }
    public void   setPhone(String v)      { this.phone = v; }
    public String getHireDate()           { return hireDate; }
    public void   setHireDate(String v)   { this.hireDate = v; }
    public String getJobTitle()           { return jobTitle; }
    public void   setJobTitle(String v)   { this.jobTitle = v; }
    public double getSalary()             { return salary; }
    public void   setSalary(double v)     { this.salary = v; }
    public int    getDeptId()             { return deptId; }
    public void   setDeptId(int v)        { this.deptId = v; }
    public String getDeptName()           { return deptName; }
    public void   setDeptName(String v)   { this.deptName = v; }

    public String getFullName() { return firstName + " " + lastName; }
}
