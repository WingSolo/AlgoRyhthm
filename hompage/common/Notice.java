package common;

import java.sql.Timestamp;

public class Notice {
    private int num;
    private String title;
    private String content;
    private String empId;
    private String empName;
    private Timestamp createdAt;

    public Notice(int num, String title, String content, String empId, String empName, Timestamp createdAt) {
        this.num = num;
        this.title = title;
        this.content = content;
        this.empId = empId;
        this.empName = empName;
        this.createdAt = createdAt;
    }

    // Getters and Setters
    public int getNum() {
        return num;
    }

    public String getTitle() {
        return title;
    }

    public String getContent() {
        return content;
    }

    public String getEmpId() {
        return empId;
    }

    public String getEmpName() {
        return empName;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }
}
