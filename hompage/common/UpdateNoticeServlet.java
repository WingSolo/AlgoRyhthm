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

    // POST 요청 처리
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        int num = Integer.parseInt(request.getParameter("num"));
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String searchKeyword = request.getParameter("searchKeyword");

        NoticeDao noticeDao = new NoticeDao();
        Notice notice = new Notice(num, title, content, null, null, null);

        if (searchKeyword == null) {
            searchKeyword = "";
        }

        String encodedKeyword = java.net.URLEncoder.encode(searchKeyword, "UTF-8");

        if (noticeDao.updateNotice(notice)) {
            response.sendRedirect("CA02.jsp?num=" + notice.getNum() + "&searchKeyword=" + encodedKeyword);
        } else {
            response.sendRedirect("CA04.jsp?num=" + num + "&error=updateFailed&searchKeyword=" + encodedKeyword);
        }
    }

    // GET 요청 처리 (GET 요청 시 POST로 리디렉션)
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);  // GET 요청을 POST 요청처럼 처리
    }
}
