package common;

public class EmpUser {
    private String emp_id;
    private String password; // 비밀번호는 평문으로 저장
    private String emp_name;
    private String email;
    private String phone;
    private String user_dept;
    private String user_pos;

    public EmpUser(String emp_id, String password, String emp_name, String email, String phone, String user_dept, String user_pos) {
        this.emp_id = emp_id;
        this.password = password; // 평문 비밀번호 저장
        this.emp_name = emp_name;
        this.email = email;
        this.phone = phone;
        this.user_dept = user_dept;
        this.user_pos = user_pos;
    }

    // Getter 및 Setter 메소드들
    public String getEmp_id() {
        return emp_id;
    }

    public void setEmp_id(String emp_id) {
        this.emp_id = emp_id;
    }

    public String getPassword() {
        return password; // 해시화된 비밀번호가 아닌 평문 반환
    }

    public void setPassword(String password) {
        this.password = password; // 평문 비밀번호 설정
    }

    public String getEmp_name() {
        return emp_name;
    }

    public void setEmp_name(String emp_name) {
        this.emp_name = emp_name;
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
