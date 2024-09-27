package common;

import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.sql.DataSource;
import org.mariadb.jdbc.MariaDbPoolDataSource;

public class EmpUserDao {
    private static final String DB_URL = "jdbc:mariadb://localhost:3306/Algo";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "1234";
    private static final Logger logger = Logger.getLogger(EmpUserDao.class.getName());
    private DataSource dataSource;

    // Constructor to initialize the connection pool
    public EmpUserDao() {
        try {
            MariaDbPoolDataSource pool = new MariaDbPoolDataSource(DB_URL);
            pool.setUser(DB_USER);
            pool.setPassword(DB_PASSWORD);
            this.dataSource = pool;
            logger.info("MariaDB JDBC Connection Pool initialized successfully.");
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Failed to initialize MariaDB connection pool", e);
        }
    }

    // Update password method with empId and password parameters
    public boolean updatePassword(String empId, String newPassword) {
        String sql = "UPDATE emp_user SET password = ? WHERE emp_id = ?";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, newPassword);  // 평문 비밀번호 사용
            pstmt.setString(2, empId);

            int rowsUpdated = pstmt.executeUpdate();
            return rowsUpdated > 0;  // 업데이트된 행이 있으면 true 반환

        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Failed to update password for user ID: " + empId, e);
        }

        return false;  // 오류가 발생하면 false 반환
    }

    // Method to establish a connection to the database
    private Connection getConnection() throws SQLException {
        return dataSource.getConnection();
    }

    // Read: Get an EmpUser by emp_id
    public EmpUser getEmpUserById(String emp_id) {
        String sql = "SELECT * FROM emp_user WHERE emp_id = ?";
        EmpUser user = null;
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, emp_id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    user = new EmpUser(
                            rs.getString("emp_id"),
                            rs.getString("password"),  // password 필드 사용
                            rs.getString("emp_name"),
                            rs.getString("email"),
                            rs.getString("phone"),
                            rs.getString("user_dept"),
                            rs.getString("user_pos")
                    );
                    logger.info("User retrieved successfully: " + emp_id);
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Failed to retrieve user by ID", e);
        }
        return user;
    }
    // Find user by empId and email
    public EmpUser findUserByEmpIdAndEmail(String empId, String email) {
        String sql = "SELECT * FROM emp_user WHERE emp_id = ? AND email = ?";
        EmpUser user = null;
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, empId);
            pstmt.setString(2, email);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    user = new EmpUser(
                            rs.getString("emp_id"),
                            rs.getString("password"),  // 비밀번호 포함
                            rs.getString("emp_name"),
                            rs.getString("email"),
                            rs.getString("phone"),
                            rs.getString("user_dept"),
                            rs.getString("user_pos")
                    );
                    logger.info("User found by empId and email: " + empId);
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Failed to find user by empId and email", e);
        }
        return user;
    }

    // Another update password method (possibly for alternative usage)
    public boolean updatePassword02(String empId, String newPassword) {
        String sql = "UPDATE emp_user SET password = ? WHERE emp_id = ?";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, newPassword);  // 평문 비밀번호 사용
            pstmt.setString(2, empId);

            int rowsUpdated = pstmt.executeUpdate();
            return rowsUpdated > 0;

        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Failed to update password (02) for user ID: " + empId, e);
        }

        return false;
    }
    
}
