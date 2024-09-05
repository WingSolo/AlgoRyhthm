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

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("login.jsp");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String empId = request.getParameter("empId");
        String password = request.getParameter("password");

        // 데이터베이스에서 사용자 확인
        EmpUser user = empUserDao.getEmpUserById(empId);

        if (user != null && user.getPassword().equals(password)) {
            // 로그인 성공 시 세션 생성
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            response.sendRedirect("main.jsp"); // 메인 페이지로 리디렉션
        } else {
            // 로그인 실패 시 login.jsp로 리디렉션
            response.sendRedirect("login.jsp?error=Invalid credentials");
        }
    }
}
