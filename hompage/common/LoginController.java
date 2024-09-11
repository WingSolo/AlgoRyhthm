package common;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/Login")
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private EmpUserDao empUserDao;

    public LoginController() {
        super();
        empUserDao = new EmpUserDao(); // DAO 객체 초기화
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("login.jsp"); // 로그인 페이지로 리디렉션
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String empId = request.getParameter("empId");
        String password = request.getParameter("password");

        // 데이터베이스에서 사용자 정보 조회
        EmpUser user = empUserDao.getEmpUserById(empId);

        // 사용자 정보가 존재하고 비밀번호가 일치하는지 확인
        if (user != null && user.getHashedPassword().equals(hashPassword(password))) {
            // 로그인 성공 시 세션 생성
            HttpSession session = request.getSession();
            session.setAttribute("loginUser", user); // "loginUser"로 키 이름 수정
            response.sendRedirect("main.jsp"); // 메인 페이지로 리디렉션
        } else {
            // 로그인 실패 시 login.jsp로 리디렉션
            response.sendRedirect("login.jsp?error=Invalid credentials");
        }
    }

    // 비밀번호 해시 메서드
    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256"); // SHA-256 알고리즘 사용
            byte[] hash = md.digest(password.getBytes()); // 비밀번호 해싱
            StringBuilder hexString = new StringBuilder();
            for (byte b : hash) {
                hexString.append(String.format("%02x", b));
            }
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("SHA-256 algorithm not found. Please check your JDK installation.", e);
        }
    }
}
