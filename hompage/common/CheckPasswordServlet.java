package common;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/CheckPasswordServlet")
public class CheckPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private EmpUserDao userDao;

    public CheckPasswordServlet() {
        super();
        userDao = new EmpUserDao(); // DAO 객체 초기화
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 인코딩 설정
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        // 로그인된 사용자 정보 가져오기
        HttpSession session = request.getSession();
        EmpUser currentUser = (EmpUser) session.getAttribute("loginUser");

        if (currentUser == null) {
            response.sendRedirect("login.jsp"); // 로그인 페이지로 리디렉션
            return;
        }

        // 입력된 비밀번호 가져오기
        String inputPassword = request.getParameter("password");

        // 입력된 비밀번호를 데이터베이스의 기존 비밀번호와 비교
        if (inputPassword.equals(currentUser.getPassword())) {  // 평문으로 비교
            // 비밀번호가 일치할 경우 DA02.jsp로 이동
            response.sendRedirect("DA02.jsp"); // 비밀번호가 맞으면 DA02.jsp로 이동
        } else {
            // 비밀번호가 일치하지 않을 경우 현재 페이지로 리디렉션하고 오류 메시지를 전달
            response.sendRedirect("DA01.jsp?error=invalidPassword");
        }
    }
}
