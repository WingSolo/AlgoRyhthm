package common;

import java.sql.*;

public class AnalysisDao {
    // Database connection details
	final String driver = "org.mariadb.jdbc.Driver";
	final String DB_IP = "localhost";
	final String DB_PORT = "3306";
	final String DB_NAME = "algo";
	final String DB_URL1 = "jdbc:mariadb://" + DB_IP + ":" + DB_PORT + "/" + DB_NAME;
	private static final String DB_USER = "root";
	private static final String DB_PASSWORD = "1234";
    
    
    // 데이터 db 업로드 메소드
	// 데이터 db 다운로드 메소드 
	
	// 분석 메소드
    public void db_upload(AnaDo AnaDo) throws SQLException {
		Connection connection = null;
//		String result = null;
//		ResultSet rs = null;
		try {
			Class.forName(driver);
			connection = DriverManager.getConnection(DB_URL1, DB_USER, DB_PASSWORD);
			if (connection != null) {
				System.out.println("DB접속 성공");
			}
		} catch(ClassNotFoundException e) {
			System.out.println("드라이버 로드 실패");
			e.printStackTrace();
		} catch(SQLException e) {
			System.out.println("DB 접속 실패");
			e.printStackTrace();
		}
		
		PreparedStatement stmt = connection.prepareStatement
				("INSERT INTO analysis (email, type, file_path) VALUES (?, ?, ?)");
		stmt.setString(1, AnaDo.getAna_email());
		stmt.setString(2, AnaDo.getAna_type());
		stmt.setString(3, AnaDo.getAna_path());
		System.out.println("db 업로드 성공");	
		stmt.execute();
//		if(rs.next()) {
//			String Ana_data = rs.getString("ana_data");
//			String Ana_path = rs.getString("ana_path");
//		}
//		return result;
	}		
}
