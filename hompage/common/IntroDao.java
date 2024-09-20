package common;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class IntroDao {
    // Database connection details
    private static final String DRIVER = "org.mariadb.jdbc.Driver"; // JDBC 드라이버 클래스 이름
    private static final String DB_URL = "jdbc:mariadb://localhost:3306/Algo";  // 실제 DB URL로 변경 필요
    private static final String DB_USER = "root";  // 실제 DB 사용자 이름으로 변경 필요
    private static final String DB_PASSWORD = "1234";  // 실제 DB 비밀번호로 변경 필요
    private static final Logger logger = Logger.getLogger(NoticeDao.class.getName());

    public IntroDao() {
        try {
            Class.forName(DRIVER);  // JDBC 드라이버 로드
            logger.info("MariaDB JDBC Driver loaded successfully.");
        } catch (ClassNotFoundException e) {
            logger.log(Level.SEVERE, "Failed to load MariaDB driver", e);
        }
    }

    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);  // 데이터베이스 연결
    }

      
    // 문의내역 번호로 목록 가져오는 메서드 (Read)
    public Intro getIntroByNum(int num) {
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
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Failed to retrieve notice by num", e);
        }
        return intro;
    }

    //문의사항내역 목록을 페이지 단위로 가져오는 메서드
    public List<Intro> getIntroByPage(int page, int pageSize) {
        List<Intro> introList = new ArrayList<>();
        String sql = "SELECT * FROM intro_inq ORDER BY num DESC LIMIT ?, ?";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, (page - 1) * pageSize);
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
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Failed to retrieve notices by page", e);
        }
        return introList;
    }

    // 분석내역 목록 총 개수를 가져오는 메서드
    public int getTotalIntroCount() {
        String sql = "SELECT COUNT(*) FROM intro_inq";
        int count = 0;

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Failed to retrieve total notice count", e);
        }
        return count;
    }
 // 분석내역 추가 메서드
    public int insertIntro(Intro intro) throws SQLException {
    	String sql = "INSERT INTO intro_inq (cust_name, email, phone, comp_name, data_type, coun_type, visit_path, time, content) "
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
            pstmt.setTimestamp(8, intro.getTime());
            pstmt.setString(9, intro.getContent());

            result = pstmt.executeUpdate();  // 변경된 부분: 실행 결과 반환
            logger.info("Notice inserted successfully.");
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Failed to insert notice", e);
            throw new SQLException("Failed to insert notice", e);
        }
        	return result;  // 변경된 부분: 삽입 결과 반환
    	}


 
}
