<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="common.Notice, common.NoticeDao, common.EmpUser" %>
<%@ page session="true" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>공지사항 수정</title>
    <style>
        .form-container { width: 50%; margin: 0 auto; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; }
        input[type="text"], textarea { width: 100%; padding: 8px; }
        .submit-btn { text-align: right; margin-top: 10px; }
    </style>
</head>
<body>

<%
    // 로그인된 사용자 정보 가져오기
    EmpUser currentUser = (EmpUser) session.getAttribute("loginUser");
    if (currentUser == null) { // 로그인이 안 된 상태일 경우
        response.sendRedirect("login.jsp"); // 로그인 페이지로 리디렉션
        return;
    }

    // 공지사항 번호 가져오기
    String numStr = request.getParameter("num");
    Notice notice = null;

    if (numStr != null && !numStr.isEmpty()) {
        try {
            int num = Integer.parseInt(numStr);

            // NoticeDao 객체를 사용하여 데이터베이스에서 공지사항 조회
            NoticeDao noticeDao = new NoticeDao();
            notice = noticeDao.getNoticeByNum(num);

            if (notice == null) {
                out.println("<p>해당 번호의 공지사항이 존재하지 않습니다.</p>");
                out.println("<a href='CA01.jsp'>목록으로 돌아가기</a>");
                return;
            }

            // 수정 권한 확인 (예시: 공지사항 작성자만 수정 가능)
            if (!notice.getEmpId().equals(currentUser.getEmp_id())) {
                out.println("<p>수정 권한이 없습니다.</p>");
                out.println("<a href='CA01.jsp'>목록으로 돌아가기</a>");
                return;
            }
        } catch (NumberFormatException e) {
            out.println("<p>잘못된 공지사항 번호입니다.</p>");
            out.println("<a href='CA01.jsp'>목록으로 돌아가기</a>");
            return;
        } catch (Exception e) {
            out.println("<p>공지사항을 조회하는 중 오류가 발생했습니다.</p>");
            out.println("<a href='CA01.jsp'>목록으로 돌아가기</a>");
            return;
        }
    } else {
        out.println("<p>공지사항 번호가 지정되지 않았습니다.</p>");
        out.println("<a href='CA01.jsp'>목록으로 돌아가기</a>");
        return;
    }
%>

<div class="form-container">
    <h2>공지사항 수정</h2>
    <form action="UpdateNoticeServlet" method="post">
        <input type="hidden" name="num" value="<%= notice.getNum() %>">
        <div class="form-group">
            <label for="title">제목:</label>
            <input type="text" id="title" name="title" value="<%= notice.getTitle() %>" required>
        </div>
        <div class="form-group">
            <label for="content">내용:</label>
            <textarea id="content" name="content" rows="5" required><%= notice.getContent() %></textarea>
        </div>
        <div class="submit-btn">
            <button type="submit">수정 완료</button>
            <a href="CA01.jsp">목록으로</a>
        </div>
    </form>
</div>

</body>
</html>
