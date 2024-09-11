package common;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UpdateNoticeServlet")
public class UpdateNoticeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        int num = Integer.parseInt(request.getParameter("num"));
        String title = request.getParameter("title");
        String content = request.getParameter("content");

        NoticeDao noticeDao = new NoticeDao();
        Notice notice = new Notice(num, title, content, null, null, null);  // 필요한 정보로 Notice 객체 생성

        if (noticeDao.updateNotice(notice)) {
            response.sendRedirect("CA01.jsp"); // 수정 성공 시 목록 페이지로 리디렉션
        } else {
            response.sendRedirect("CA04.jsp?num=" + num + "&error=updateFailed"); // 수정 실패 시 다시 수정 페이지로
        }
    }  
}