package common;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/WriteNoticeServlet")
public class WriteNoticeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private NoticeDao noticeDao = new NoticeDao(); // NoticeDao 객체 생성
    private static final Logger logger = Logger.getLogger(WriteNoticeServlet.class.getName());

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 로그인 체크
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        HttpSession session = request.getSession();
        EmpUser loginUser = (EmpUser) session.getAttribute("loginUser");
        if (loginUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            // 로그인된 사용자 정보 가져오기
            String emp_id = loginUser.getEmp_id();
            String emp_name = loginUser.getEmp_name();

            // 공지사항 정보 가져오기
            String title = request.getParameter("title");
            String content = request.getParameter("content");

            // 입력값 유효성 검사
            if (title == null || title.trim().isEmpty() || content == null || content.trim().isEmpty()) {
                response.sendRedirect("CA03.jsp?error=emptyFields");
                return;
            }

            // 공지사항 작성일 설정
            Timestamp date = new Timestamp(System.currentTimeMillis());

            // 공지사항 객체 생성
            Notice notice = new Notice(0, title, content, emp_id, emp_name, date);

            // 공지사항 추가 (데이터베이스에 저장)
            noticeDao.insertNotice(notice);

            // 공지사항 리스트로 리다이렉트
            response.sendRedirect("CA01.jsp");
        } catch (Exception e) {
            logger.log(Level.SEVERE, "An error occurred while writing the notice", e);
            response.sendRedirect("CA03.jsp?error=writeFailed");
        }
    }
}

