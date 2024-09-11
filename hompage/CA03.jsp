<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="common.EmpUser" %>
<%@ page session="true" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>공지사항 작성</title>
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
    // 로그인 체크
    EmpUser loginUser = (EmpUser) session.getAttribute("loginUser"); // 세션에서 loginUser 객체 가져오기
    if (loginUser == null) { // 로그인 정보가 없을 경우
        response.sendRedirect("login.jsp"); // 로그인 페이지로 리다이렉트
        return; // 이후 코드 실행 방지
    }
%>

<div class="form-container">
    <h2>공지사항 작성</h2>
    <form action="WriteNoticeServlet" method="post">
        <div class="form-group">
            <label for="emp_id">작성자 ID:</label>
            <input type="text" id="emp_id" name="emp_id" value="<%= loginUser.getEmp_id() %>" readonly>
        </div>
        <div class="form-group">
            <label for="emp_name">작성자 이름:</label>
            <input type="text" id="emp_name" name="emp_name" value="<%= loginUser.getEmp_name() %>" readonly>
        </div>
        <div class="form-group">
            <label for="title">제목:</label>
            <input type="text" id="title" name="title" required>
        </div>
        <div class="form-group">
            <label for="content">내용:</label>
            <textarea id="content" name="content" rows="5" required></textarea>
        </div>
        <div class="submit-btn">
            <button type="submit">작성 완료</button>
            <a href="CA01.jsp">목록으로</a>
        </div>
    </form>
</div>

</body>
</html>
