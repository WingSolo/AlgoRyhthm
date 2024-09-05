package common;

public class EmpUser {
    private String emp_id;
    private String password;
    private String name;
    private String email;
    private String phone;
    private String user_dept;
    private String user_pos;

    // Constructor
    public EmpUser(String emp_id, String password, String name, String email, String phone, String user_dept, String user_pos) {
        this.emp_id = emp_id;
        this.password = password;
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.user_dept = user_dept;
        this.user_pos = user_pos;
    }

    // Getters and Setters
    public String getEmp_id() {
        return emp_id;
    }

    public void setEmp_id(String emp_id) {
        this.emp_id = emp_id;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getUser_dept() {
        return user_dept;
    }

    public void setUser_dept(String user_dept) {
        this.user_dept = user_dept;
    }

    public String getUser_pos() {
        return user_pos;
    }

    public void setUser_pos(String user_pos) {
        this.user_pos = user_pos;
    }
}
