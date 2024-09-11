package common;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/DeleteNoticeServlet")
public class DeleteNoticeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 요청 및 응답의 인코딩 설정
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        // 세션에서 로그인된 사용자 정보 가져오기
        HttpSession session = request.getSession();
        EmpUser currentUser = (EmpUser) session.getAttribute("loginUser");
        
        if (currentUser == null) {  // 로그인이 되어 있지 않은 경우
            response.sendRedirect("login.jsp");
            return;
        }

        // 공지사항 번호 가져오기
        String numStr = request.getParameter("num");

        if (numStr != null && !numStr.isEmpty()) {
            try {
                int num = Integer.parseInt(numStr);  // 문자열을 정수로 변환

                // NoticeDao 객체 생성
                NoticeDao noticeDao = new NoticeDao();
                Notice notice = noticeDao.getNoticeByNum(num);

                if (notice != null && notice.getEmpId().equals(currentUser.getEmp_id())) {  // 삭제 권한 확인
                    if (noticeDao.deleteNotice(num)) {
                        response.sendRedirect("CA01.jsp?message=deleted");  // 삭제 성공 시 목록 페이지로 리디렉션
                    } else {
                        response.sendRedirect("CA01.jsp?error=deleteFailed");  // 삭제 실패 시 오류 메시지와 함께 목록 페이지로 리디렉션
                    }
                } else {
                    response.sendRedirect("CA01.jsp?error=noPermission");  // 권한이 없는 경우 목록 페이지로 리디렉션
                }

            } catch (NumberFormatException e) {
                response.sendRedirect("CA01.jsp?error=invalidNumber");  // 잘못된 번호 형식인 경우
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("CA01.jsp?error=exception");  // 기타 예외 발생 시
            }
        } else {
            response.sendRedirect("CA01.jsp?error=missingNumber");  // 번호가 지정되지 않은 경우
        }
    }
}

