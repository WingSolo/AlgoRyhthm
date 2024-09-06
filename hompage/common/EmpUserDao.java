package common;

import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class EmpUserDao {
    private static final String DRIVER = "org.mariadb.jdbc.Driver";
    private static final String DB_URL = "jdbc:mariadb://localhost:3306/Algo";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "1234";
    private static final Logger logger = Logger.getLogger(EmpUserDao.class.getName());

    // Constructor to load the JDBC driver
    public EmpUserDao() {
        try {
            Class.forName(DRIVER);
            logger.info("MariaDB JDBC Driver loaded successfully.");
        } catch (ClassNotFoundException e) {
            logger.log(Level.SEVERE, "Failed to load MariaDB driver", e);
        }
    }

    // Method to establish a connection to the database
    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
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
                            rs.getString("password"),
                            rs.getString("name"),
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
}
