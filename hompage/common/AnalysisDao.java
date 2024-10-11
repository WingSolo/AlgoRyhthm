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
	
	// db 업로드 메서드
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
    }
    // db accuracy score 다운로드 메서드
		public String db_accuracy(AnaDo AnaDo) throws SQLException {
			Connection connection = null;
			String result = null;
			ResultSet rs = null;
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
					("select accuracy_score from analysis_result order by num DESC LIMIT 1;");
			
			System.out.println("db 다운로드 성공");	
			rs = stmt.executeQuery();

			if(rs.next()) {
				result = rs.getString("accuracy_score");
			}	
		//		AnaDo.setAna_result(result);
			return result;
		}
		
		public String db_f1(AnaDo AnaDo) throws SQLException {
			Connection connection = null;
			String result = null;
			ResultSet rs = null;
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
					("select f1_score from analysis_result order by num DESC LIMIT 1;");
			
			System.out.println("db 다운로드 성공");	
			rs = stmt.executeQuery();

			if(rs.next()) {
				result = rs.getString("f1_score");
			}	
		//		AnaDo.setAna_result(result);
			return result;
		}
		
		public String db_precision(AnaDo AnaDo) throws SQLException {
			Connection connection = null;
			String result = null;
			ResultSet rs = null;
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
					("select precision_score from analysis_result order by num DESC LIMIT 1;");
			
			System.out.println("db 다운로드 성공");	
			rs = stmt.executeQuery();

			if(rs.next()) {
				result = rs.getString("precision_score");
			}	
		//		AnaDo.setAna_result(result);
			return result;
		}
		
		public String db_recall(AnaDo AnaDo) throws SQLException {
			Connection connection = null;
			String result = null;
			ResultSet rs = null;
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
					("select recall_score from analysis_result order by num DESC LIMIT 1;");
			
			System.out.println("db 다운로드 성공");	
			rs = stmt.executeQuery();

			if(rs.next()) {
				result = rs.getString("recall_score");
			}	
		//		AnaDo.setAna_result(result);
			return result;
		}
		
		public String db_date(AnaDo AnaDo) throws SQLException {
			Connection connection = null;
			String result = null;
			ResultSet rs = null;
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
					("select time from analysis_result order by num DESC LIMIT 1;");
			
			System.out.println("db 다운로드 성공");	
			rs = stmt.executeQuery();

			if(rs.next()) {
				result = rs.getString("time");
			}	
		//		AnaDo.setAna_result(result);
			return result;
		}
		public String db_model(AnaDo AnaDo) throws SQLException {
			Connection connection = null;
			String result = null;
			ResultSet rs = null;
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
					("select ana_model from analysis_result order by num DESC LIMIT 1;");
			
			System.out.println("db 다운로드 성공");	
			rs = stmt.executeQuery();

			if(rs.next()) {
				result = rs.getString("ana_model");
			}	
		//		AnaDo.setAna_result(result);
			return result;
		}
		
		// image path 불러오기
		public String db_image(AnaDo AnaDo) throws SQLException {
			Connection connection = null;
			String result = null;
			ResultSet rs = null;
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
					("select result_path from analysis_result order by num DESC LIMIT 1;");
			
			System.out.println("db 다운로드 성공");	
			rs = stmt.executeQuery();

			if(rs.next()) {
				result = rs.getString("result_path");
			}	
		//		AnaDo.setAna_result(result);
			return result;
		}
		
		// ======================================================= 이메일 메서드
		// 수신 이메일 불러오기 메서드
		public String send_email() throws SQLException {
			Connection connection = null;
			String result = null;
			ResultSet rs = null;
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
					("select email from analysis order by num DESC LIMIT 1;");
			
			System.out.println("db 다운로드 성공");	
			rs = stmt.executeQuery();
			
		if(rs.next()) {
			result = rs.getString("email");
		}
		return result;
		}
		
		// 메일 전송용 결과 불러오기 메서드
		public String send_date() throws SQLException {
			Connection connection = null;
			String result = null;
			ResultSet rs = null;
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
					("select time from analysis_result order by num DESC LIMIT 1;");
			
			System.out.println("db 다운로드 성공");	
			rs = stmt.executeQuery();
			
			
		if(rs.next()) {
			result = rs.getString("time");
		}
		return result;
		}
		
		public String send_accuracy() throws SQLException {
			Connection connection = null;
			String result = null;
			ResultSet rs = null;
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
					("select accuracy_score from analysis_result order by num DESC LIMIT 1;");
			
			System.out.println("db 다운로드 성공");	
			rs = stmt.executeQuery();
			
			
		if(rs.next()) {
			result = rs.getString("accuracy_score");
		}
		return result;
		}
		
		public String send_f1() throws SQLException {
			Connection connection = null;
			String result = null;
			ResultSet rs = null;
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
					("select f1_score from analysis_result order by num DESC LIMIT 1;");
			
			System.out.println("db 다운로드 성공");	
			rs = stmt.executeQuery();
			
			
		if(rs.next()) {
			result = rs.getString("f1_score");
		}
		return result;
		}
		
		public String send_precision() throws SQLException {
			Connection connection = null;
			String result = null;
			ResultSet rs = null;
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
					("select precision_score from analysis_result order by num DESC LIMIT 1;");
			
			System.out.println("db 다운로드 성공");	
			rs = stmt.executeQuery();
			
			
		if(rs.next()) {
			result = rs.getString("precision_score");
		}
		return result;
		}
		
		public String send_recall() throws SQLException {
			Connection connection = null;
			String result = null;
			ResultSet rs = null;
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
					("select recall_score from analysis_result order by num DESC LIMIT 1;");
			
			System.out.println("db 다운로드 성공");	
			rs = stmt.executeQuery();
			
			
		if(rs.next()) {
			result = rs.getString("recall_score");
		}
		return result;
		}
		
		public String send_model() throws SQLException {
			Connection connection = null;
			String result = null;
			ResultSet rs = null;
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
					("select ana_model from analysis_result order by num DESC LIMIT 1;");
			
			System.out.println("db 다운로드 성공");	
			rs = stmt.executeQuery();
			
			
		if(rs.next()) {
			result = rs.getString("ana_model");
		}
		return result;
		}
}
