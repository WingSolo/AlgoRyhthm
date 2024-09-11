<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="common.Notice, common.NoticeDao, common.EmpUser" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page session="true" %> <!-- 세션 활성화 -->


<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>공지사항 확인</title>
    <style>
        .notice-container { width: 80%; margin: 0 auto; }
        .notice-header { text-align: center; font-size: 24px; font-weight: bold; margin-top: 20px; }
        .notice-subtitle { text-align: center; margin-bottom: 20px; }
        .notice-content { margin: 20px 0; }
        .button-group { text-align: center; margin-top: 20px; }
        .button-group a { margin: 0 10px; text-decoration: none; padding: 8px 16px; border: 1px solid #ddd; }
    </style>
</head>
<body>

<%
    // 로그인된 사용자 정보 가져오기
    EmpUser currentUser = (EmpUser) session.getAttribute("loginUser"); // 세션에서 로그인된 사용자 객체 가져오기
    if (currentUser == null) { // 로그인이 안 된 상태일 경우
        response.sendRedirect("CA01.jsp"); // 로그인되지 않은 경우 CA01.jsp로 리디렉션
        return; // 이후 코드 실행 방지
    }

    // 공지사항 번호 가져오기
    String numStr = request.getParameter("num");
    Notice notice = null;

    if (numStr != null && !numStr.isEmpty()) {
        try {
            int num = Integer.parseInt(numStr); // 문자열을 정수로 변환

            // NoticeDao 객체를 사용하여 데이터베이스에서 공지사항 조회
            NoticeDao noticeDao = new NoticeDao();
            notice = noticeDao.getNoticeByNum(num);  // 공지사항 번호로 조회

            if (notice == null) {
                out.println("<p>해당 번호의 공지사항이 존재하지 않습니다.</p>");
                out.println("<a href='CA01.jsp'>목록으로 돌아가기</a>");
                return; // 이후 코드 실행 방지
            }
        } catch (NumberFormatException e) {
            out.println("<p>잘못된 공지사항 번호입니다.</p>");
            out.println("<a href='CA01.jsp'>목록으로 돌아가기</a>");
            return; // 이후 코드 실행 방지
        } catch (Exception e) {
            out.println("<p>공지사항을 조회하는 중 오류가 발생했습니다.</p>");
            out.println("<a href='CA01.jsp'>목록으로 돌아가기</a>");
            return; // 이후 코드 실행 방지
        }
    } else {
        out.println("<p>공지사항 번호가 지정되지 않았습니다.</p>");
        out.println("<a href='CA01.jsp'>목록으로 돌아가기</a>");
        return; // 이후 코드 실행 방지
    }
%>

<div class="notice-container">
    <!-- 공지사항 제목 -->
    <div class="notice-header">공지사항</div>
    <div class="notice-subtitle">알고리듬의 소식을 확인해보세요.</div>

    <% if (notice != null) { %> <!-- 공지사항이 존재할 경우 출력 -->
        <!-- 공지사항 제목 -->
        <div class="notice-title"><h2><%= notice.getTitle() %></h2></div>

        <!-- 공지사항 작성자 및 작성일자 -->
        <div class="notice-meta">
            작성자: <%= notice.getEmpId() %> | 작성일: <%= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(notice.getCreatedAt()) %>
        </div>

        <!-- 공지사항 내용 -->
        <div class="notice-content"><%= notice.getContent() %></div>
    <% } else { %>
        <!-- 공지사항이 없는 경우 -->
        <p>공지사항을 찾을 수 없습니다.</p>
        <a href="CA01.jsp">목록으로 돌아가기</a>
    <% } %>

    <!-- 목록, 수정, 삭제, 작성 버튼 -->
    <div class="button-group">
        <a href="CA01.jsp">목록</a>
        <% if (notice != null) { %>
            <a href="CA04.jsp?num=<%= notice.getNum() %>">수정</a>
            <a href="CA05.jsp?num=<%= notice.getNum() %>" onclick="return confirm('삭제하시겠습니까?');">삭제</a>
        <% } %>
        <a href="CA03.jsp">작성</a> <!-- 작성 버튼 추가 -->
    </div>
</div>

</body>
</html>
