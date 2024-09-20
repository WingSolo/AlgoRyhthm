package common;

import java.sql.Timestamp;

public class Intro {
    private int num;
    private String cust_name;
    private String email;
    private String phone;
    private String comp_name;
    private String data_type;
    private String coun_type;
    private String visit_path;
    private Timestamp time;
    private String content;

    public Intro(int num, String cust_name, String email, String phone, String comp_name, String data_type, String coun_type, String visit_path, Timestamp time, String content) {
        this.num = num;
        this.cust_name = cust_name;
        this.email = email;
        this.phone = phone;
        this.comp_name = comp_name;
        this.data_type = data_type;
        this.coun_type = coun_type;
        this.visit_path = visit_path;
        this.time = time;
        this.content = content;
    }

    public int getNum() {
        return num;
    }

    public String getCust_name() {
        return cust_name;
    }

    public String getEmail() {
        return email;
    }

    public String getPhone() {
        return phone;
    }

    public String getComp_name() {
        return comp_name;
    }

    public String getData_type() {
        return data_type;
    }

    public String getCoun_type() {
        return coun_type;
    }

    public String getVisit_path() {
        return visit_path;
    }

    public Timestamp getTime() {
        return time;
    }

    public String getContent() {
        return content;
    }
}
