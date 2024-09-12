package common;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/UpdatePasswordServlet")
public class UpdatePasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private EmpUserDao userDao;

    public UpdatePasswordServlet() {
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

        // 새 비밀번호 가져오기
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // 비밀번호 일치 여부 확인
        if (newPassword == null || !newPassword.equals(confirmPassword)) {
            response.getWriter().println("<script>alert('비밀번호가 일치하지 않습니다. 다시 입력해 주세요.'); history.back();</script>");
            return;
        }

        // 비밀번호를 그대로 데이터베이스에 저장
        boolean updateSuccess = userDao.updatePassword(currentUser.getEmp_id(), newPassword);

        if (updateSuccess) {
            // 비밀번호 변경 성공 시 경고창 띄우고 메인 페이지로 이동
            response.getWriter().println("<script>alert('비밀번호 변경이 완료되었습니다.'); location.href='main.jsp';</script>");
        } else {
            // 비밀번호 변경 실패 시 오류 메시지
            response.getWriter().println("<script>alert('비밀번호 변경에 실패했습니다. 다시 시도해 주세요.'); history.back();</script>");
        }
    }
}
