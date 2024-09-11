package common;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class EmpUser {
    private String emp_id;
    private String hashedPassword; // 비밀번호는 해시된 형태로 저장
    private String emp_name;
    private String email;
    private String phone;
    private String user_dept;
    private String user_pos;

    public EmpUser(String emp_id, String password, String emp_name, String email, String phone, String user_dept, String user_pos) {
        this.emp_id = emp_id;
        this.hashedPassword = hashPassword(password); // 해시된 비밀번호 저장
        this.emp_name = emp_name;
        this.email = email;
        this.phone = phone;
        this.user_dept = user_dept;
        this.user_pos = user_pos;
    }

    // 비밀번호 해시 메서드
    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(password.getBytes());
            StringBuilder hexString = new StringBuilder();
            for (byte b : hash) {
                hexString.append(String.format("%02x", b));
            }
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }

    public String getEmp_id() {
        return emp_id;
    }

    public void setEmp_id(String emp_id) {
        this.emp_id = emp_id;
    }

    public String getHashedPassword() {
        return hashedPassword;
    }

    public void setHashedPassword(String password) {
        this.hashedPassword = hashPassword(password);
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
