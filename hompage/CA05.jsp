<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="common.Notice, common.NoticeDao, common.EmpUser" %>
<%@ page session="true" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>공지사항 삭제</title>
    <style>
        .message-container { width: 50%; margin: 0 auto; text-align: center; margin-top: 50px; }
        .button-group { margin-top: 20px; }
        .button-group a { margin: 0 10px; text-decoration: none; padding: 8px 16px; border: 1px solid #ddd; }
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

            // 삭제 권한 확인 (예시: 공지사항 작성자만 삭제 가능)
            if (!notice.getEmpId().equals(currentUser.getEmp_id())) {
                out.println("<p>삭제 권한이 없습니다.</p>");
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

<div class="message-container">
    <h2>공지사항 삭제</h2>
    <p>공지사항을 삭제하시겠습니까?</p>
    <div class="button-group">
        <a href="DeleteNoticeServlet?num=<%= notice.getNum() %>">삭제</a>
        <a href="CA01.jsp">취소</a>
    </div>
</div>

</body>
</html>
