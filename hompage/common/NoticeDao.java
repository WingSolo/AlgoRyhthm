package common;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class NoticeDao {
    private static final String DRIVER = "org.mariadb.jdbc.Driver";
    private static final String DB_URL = "jdbc:mariadb://localhost:3306/Algo";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "1234";
    private static final Logger logger = Logger.getLogger(NoticeDao.class.getName());

    public NoticeDao() {
        try {
            Class.forName(DRIVER);  // JDBC 드라이버 로드
            logger.info("MariaDB JDBC Driver loaded successfully.");
        } catch (ClassNotFoundException e) {
            logger.log(Level.SEVERE, "Failed to load MariaDB driver", e);
        }
    }

    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }

    // 공지사항 삭제 메서드
    public boolean deleteNotice(int num) {
        String sql = "DELETE FROM notice WHERE num = ?";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, num);

            int rowsDeleted = pstmt.executeUpdate();
            return rowsDeleted > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    // 공지사항 수정 메서드
    public boolean updateNotice(Notice notice) {
        String sql = "UPDATE notice SET title = ?, content = ? WHERE num = ?";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, notice.getTitle());
            pstmt.setString(2, notice.getContent());
            pstmt.setInt(3, notice.getNum());

            int rowsUpdated = pstmt.executeUpdate();
            return rowsUpdated > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    // 공지사항 번호로 공지사항 가져오는 메서드 (Read)
    public Notice getNoticeByNum(int num) {
        String sql = "SELECT * FROM notice WHERE num = ?";
        Notice notice = null;

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, num);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    notice = new Notice(
                            rs.getInt("num"),
                            rs.getString("title"),
                            rs.getString("content"),
                            rs.getString("emp_id"),
                            rs.getString("emp_name"),
                            rs.getTimestamp("created_at")
                    );
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Failed to retrieve notice by num", e);
        }
        return notice;
    }

    // 공지사항 목록을 페이지 단위로 가져오는 메서드
    public List<Notice> getNoticesByPage(int page, int pageSize) {
        List<Notice> noticeList = new ArrayList<>();
        String sql = "SELECT * FROM notice ORDER BY num DESC LIMIT ?, ?";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, (page - 1) * pageSize);
            pstmt.setInt(2, pageSize);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Notice notice = new Notice(
                            rs.getInt("num"),
                            rs.getString("title"),
                            rs.getString("content"),
                            rs.getString("emp_id"),
                            rs.getString("emp_name"),
                            rs.getTimestamp("created_at")
                    );
                    noticeList.add(notice);
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Failed to retrieve notices by page", e);
        }
        return noticeList;
    }

    // 공지사항 총 개수를 가져오는 메서드
    public int getTotalNoticeCount() {
        String sql = "SELECT COUNT(*) FROM notice";
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

    // 공지사항 추가 메서드
    public void insertNotice(Notice notice) throws SQLException {
        String sql = "INSERT INTO notice (title, content, emp_id, emp_name, created_at) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, notice.getTitle());
            pstmt.setString(2, notice.getContent());
            pstmt.setString(3, notice.getEmpId());
            pstmt.setString(4, notice.getEmpName());
            pstmt.setTimestamp(5, notice.getCreatedAt());

            pstmt.executeUpdate();
            logger.info("Notice inserted successfully.");
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Failed to insert notice", e);
            throw new SQLException("Failed to insert notice", e);
        }
    }

    // 최근 공지사항 가져오기 메서드
    public List<Notice> getRecentNotices(int limit) {
        List<Notice> noticeList = new ArrayList<>();
        String sql = "SELECT num, title, created_at FROM notice ORDER BY created_at DESC LIMIT ?";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, limit);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Notice notice = new Notice(
                            rs.getInt("num"),
                            rs.getString("title"),
                            null,
                            null,
                            null,
                            rs.getTimestamp("created_at")
                    );
                    noticeList.add(notice);
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Failed to retrieve recent notices", e);
        }
        return noticeList;
    }

 // 공지사항 검색 메서드 (날짜 역순으로 정렬)
    public List<Notice> searchNoticesByKeyword(String keyword, int page, int pageSize) {
        List<Notice> noticeList = new ArrayList<>();
        String sql = "SELECT * FROM notice WHERE title LIKE ? OR content LIKE ? ORDER BY created_at DESC LIMIT ?, ?";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            String searchKeyword = "%" + keyword + "%";
            pstmt.setString(1, searchKeyword);
            pstmt.setString(2, searchKeyword);
            pstmt.setInt(3, (page - 1) * pageSize);
            pstmt.setInt(4, pageSize);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Notice notice = new Notice(
                            rs.getInt("num"),
                            rs.getString("title"),
                            rs.getString("content"),
                            rs.getString("emp_id"),
                            rs.getString("emp_name"),
                            rs.getTimestamp("created_at")
                    );
                    noticeList.add(notice);
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Failed to search notices by keyword", e);
        }
        return noticeList;
    }


    // 검색된 공지사항의 총 개수 가져오는 메서드
    public int getSearchNoticeCount(String keyword) {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM notice WHERE title LIKE ? OR content LIKE ?";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            String searchKeyword = "%" + keyword + "%";
            pstmt.setString(1, searchKeyword);
            pstmt.setString(2, searchKeyword);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    count = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Failed to count search notices", e);
        }
        return count;
    }
}
