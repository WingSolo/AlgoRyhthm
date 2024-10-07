package common;

import java.io.IOException;
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
        // 세션에 로그인한 사용자가 있으면 메인 페이지로 바로 리디렉션
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("loginUser") != null) {
            response.sendRedirect("main.jsp");
        } else {
            response.sendRedirect("login.jsp"); // 로그인 페이지로 리디렉션
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String empId = request.getParameter("empId");
        String password = request.getParameter("password");

        // 데이터베이스에서 사용자 정보 조회
        EmpUser user = empUserDao.getEmpUserById(empId);

        // 사용자 정보가 존재하고 비밀번호가 일치하는지 확인
        if (user != null && user.getPassword().equals(password)) {  // 평문으로 비교
            // 로그인 성공 시 세션 생성
            HttpSession session = request.getSession();
            session.setAttribute("loginUser", user); // "loginUser"로 세션에 사용자 정보 저장
            session.setMaxInactiveInterval(30 * 60); // 세션 타임아웃 30분 설정
            response.sendRedirect("main.jsp"); // 메인 페이지로 리디렉션
        } else {
            // 로그인 실패 시 에러 메시지를 request에 설정하고 JSP로 포워딩
            request.setAttribute("errorMessage", "등록된 아이디가 없거나 비밀번호가 틀렸습니다.");
            request.getRequestDispatcher("login.jsp").forward(request, response); // JSP로 포워딩
        }
    }
}
