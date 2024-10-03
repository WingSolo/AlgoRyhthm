package common;

import java.io.IOException;
import java.net.URLEncoder;
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
        String searchKeyword = request.getParameter("searchKeyword");  // searchKeyword 값 가져오기

        if (numStr != null && !numStr.isEmpty()) {
            try {
                int num = Integer.parseInt(numStr);  // 문자열을 정수로 변환

                // NoticeDao 객체 생성
                NoticeDao noticeDao = new NoticeDao();
                Notice notice = noticeDao.getNoticeByNum(num);

                if (notice != null && notice.getEmpId().equals(currentUser.getEmp_id())) {  // 삭제 권한 확인
                    if (noticeDao.deleteNotice(num)) {
                        // 검색 키워드가 null이거나 빈 문자열인 경우 searchKeyword를 URL에 포함하지 않음
                        if (searchKeyword == null || searchKeyword.trim().isEmpty() || "null".equals(searchKeyword)) {
                            response.sendRedirect("CA01.jsp?message=deleted");  // 검색어 없으면 검색 키워드 없이 리디렉션
                        } else {
                            String encodedKeyword = URLEncoder.encode(searchKeyword, "UTF-8");
                            response.sendRedirect("CA01.jsp?message=deleted&searchKeyword=" + encodedKeyword);  // 검색어 있을 때
                        }
                    } else {
                        if (searchKeyword == null || searchKeyword.trim().isEmpty() || "null".equals(searchKeyword)) {
                            response.sendRedirect("CA01.jsp?error=deleteFailed");
                        } else {
                            String encodedKeyword = URLEncoder.encode(searchKeyword, "UTF-8");
                            response.sendRedirect("CA01.jsp?error=deleteFailed&searchKeyword=" + encodedKeyword);
                        }
                    }
                } else {
                    if (searchKeyword == null || searchKeyword.trim().isEmpty() || "null".equals(searchKeyword)) {
                        response.sendRedirect("CA01.jsp?error=noPermission");
                    } else {
                        String encodedKeyword = URLEncoder.encode(searchKeyword, "UTF-8");
                        response.sendRedirect("CA01.jsp?error=noPermission&searchKeyword=" + encodedKeyword);
                    }
                }

            } catch (NumberFormatException e) {
                if (searchKeyword == null || searchKeyword.trim().isEmpty() || "null".equals(searchKeyword)) {
                    response.sendRedirect("CA01.jsp?error=invalidNumber");
                } else {
                    String encodedKeyword = URLEncoder.encode(searchKeyword, "UTF-8");
                    response.sendRedirect("CA01.jsp?error=invalidNumber&searchKeyword=" + encodedKeyword);
                }
            } catch (Exception e) {
                e.printStackTrace();
                if (searchKeyword == null || searchKeyword.trim().isEmpty() || "null".equals(searchKeyword)) {
                    response.sendRedirect("CA01.jsp?error=exception");
                } else {
                    String encodedKeyword = URLEncoder.encode(searchKeyword, "UTF-8");
                    response.sendRedirect("CA01.jsp?error=exception&searchKeyword=" + encodedKeyword);
                }
            }
        } else {
            if (searchKeyword == null || searchKeyword.trim().isEmpty() || "null".equals(searchKeyword)) {
                response.sendRedirect("CA01.jsp?error=missingNumber");
            } else {
                String encodedKeyword = URLEncoder.encode(searchKeyword, "UTF-8");
                response.sendRedirect("CA01.jsp?error=missingNumber&searchKeyword=" + encodedKeyword);
            }
        }
    }
}
