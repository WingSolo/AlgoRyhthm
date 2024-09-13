package common;

import java.io.File;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import java.io.File;

public class AnalysisDao {
    // Database connection details
    private static final String DRIVER = "org.mariadb.jdbc.Driver"; // JDBC 드라이버 클래스 이름
    private static final String DB_URL = "jdbc:mariadb://localhost:3306/algo";  // 실제 DB URL로 변경 필요
    private static final String DB_USER = "root";  // 실제 DB 사용자 이름으로 변경 필요
    private static final String DB_PASSWORD = "1234";  // 실제 DB 비밀번호로 변경 필요
    private static final Logger logger = Logger.getLogger(NoticeDao.class.getName());

    public AnalysisDao() {
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
    
    // 분석 메소드
    public static void Ana() {
        File batFile = new File("C:\\Users\\mit106\\Desktop\\project\\JAVA\\WokrSpace\\PROJECT\\src\\main\\java\\PROJECT_test\\test.bat");
        ProcessBuilder processBuilder = new ProcessBuilder(batFile.getAbsolutePath());
        processBuilder.directory(new File("C:\\Users\\mit106\\Desktop\\project\\JAVA\\WokrSpace\\PROJECT\\src\\main\\java\\PROJECT_test\\"));

        try {
            Process process = processBuilder.start();

            new Thread(() -> {
                try (var reader = new java.io.BufferedReader(new java.io.InputStreamReader(process.getInputStream()))) {
                    String line;
                    while ((line = reader.readLine()) != null) {
                        System.out.println(line);
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }).start();
            
            int exitCode = process.waitFor();
            System.out.println("Process exited with code: " + exitCode);

        } catch (IOException | InterruptedException e) {
            e.printStackTrace();
        }
    }
}
