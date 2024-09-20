package common;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class IntroDao {
    private static final String DRIVER = "org.mariadb.jdbc.Driver";
    private static final String DB_URL = "jdbc:mariadb://localhost:3306/Algo";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "1234";

    // 생성자
    public IntroDao() {
        try {
            Class.forName(DRIVER);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    // 데이터베이스 연결 메서드
    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }

    // Intro 데이터 삽입 메서드
    public int insertIntro(Intro intro) throws SQLException {
        String sql = "INSERT INTO intro_inq (cust_name, email, phone, comp_name, data_type, coun_type, visit_path, content, time) "
                     + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        int result = 0;

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, intro.getCust_name());
            pstmt.setString(2, intro.getEmail());
            pstmt.setString(3, intro.getPhone());
            pstmt.setString(4, intro.getComp_name());
            pstmt.setString(5, intro.getData_type());
            pstmt.setString(6, intro.getCoun_type());
            pstmt.setString(7, intro.getVisit_path());
            pstmt.setString(8, intro.getContent());
            pstmt.setTimestamp(9, intro.getTime());

            result = pstmt.executeUpdate();

        } catch (SQLException e) {
            System.out.println("SQLState: " + e.getSQLState());
            System.out.println("Error Code: " + e.getErrorCode());
            System.out.println("Message: " + e.getMessage());
            e.printStackTrace();
            throw new SQLException("DB 오류: 데이터를 삽입하는 중 문제가 발생했습니다.", e);
        }
        return result;
    }

    // 페이지별로 Intro 데이터 가져오는 메서드 (페이징 처리)
    public List<Intro> getIntroByPage(int currentPage, int pageSize) throws SQLException {
        List<Intro> introList = new ArrayList<>();
        String sql = "SELECT * FROM intro_inq LIMIT ?, ?";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            int offset = (currentPage - 1) * pageSize;
            pstmt.setInt(1, offset);
            pstmt.setInt(2, pageSize);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Intro intro = new Intro(
                        rs.getInt("num"),
                        rs.getString("cust_name"),
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getString("comp_name"),
                        rs.getString("data_type"),
                        rs.getString("coun_type"),
                        rs.getString("visit_path"),
                        rs.getTimestamp("time"),
                        rs.getString("content")
                    );
                    introList.add(intro);
                }
            }
        }
        return introList;
    }

    // 전체 Intro 개수를 가져오는 메서드 (총 데이터 수 확인)
    public int getTotalIntroCount() throws SQLException {
        String sql = "SELECT COUNT(*) FROM intro_inq";
        int totalCount = 0;

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            if (rs.next()) {
                totalCount = rs.getInt(1);
            }
        }
        return totalCount;
    }
  
    public Intro getIntroByNum(int num) throws SQLException {
        String sql = "SELECT * FROM intro_inq WHERE num = ?";
        Intro intro = null;

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, num);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    intro = new Intro(
                        rs.getInt("num"),
                        rs.getString("cust_name"),
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getString("comp_name"),
                        rs.getString("data_type"),
                        rs.getString("coun_type"),
                        rs.getString("visit_path"),
                        rs.getTimestamp("time"),
                        rs.getString("content")
                    );
                }
            }
        }
        return intro;
    }

    
}
