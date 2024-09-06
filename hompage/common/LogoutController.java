package common;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/Logout")
public class LogoutController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public LogoutController() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);  // 기존 세션을 가져옴, 없으면 null 반환

        if (session != null) {
            session.invalidate();  // 세션 무효화 (로그아웃 처리)
        }

        response.sendRedirect("login.jsp"); // 로그아웃 후 로그인 페이지로 리디렉션
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
