<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="common.Notice, common.NoticeDao" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    // 세션에서 user 객체 가져오기
    Object user = session.getAttribute("loginuser");
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>공지사항</title>
    <style>
        .notice-container { width: 80%; margin: 0 auto; }
        .notice-header { text-align: center; font-size: 24px; font-weight: bold; margin-top: 20px; }
        .notice-subtitle { text-align: center; margin-bottom: 20px; }
        .notice-item { border: 1px solid #ddd; padding: 15px; margin-bottom: 20px; }
        .notice-title { font-size: 20px; font-weight: bold; margin-bottom: 10px; }
        .notice-content { margin-top: 10px; }
        .pagination { text-align: center; margin-top: 20px; }
        .pagination a, .pagination span { margin: 0 5px; text-decoration: none; border: 1px solid #ddd; padding: 5px 10px; }
        .pagination span { font-weight: bold; }
        .write-btn { text-align: right; margin-top: 20px; margin-bottom: 20px; }
    </style>
</head>
<body>

<div class="notice-container">
    <!-- 공지사항 제목 -->
    <div class="notice-header">공지사항</div>

    <!-- 공지사항 설명 -->
    <div class="notice-subtitle">알고리듬의 소식을 확인해보세요.</div>

    <% 
        NoticeDao noticeDao = new NoticeDao();  // NoticeDao 객체 생성

        int pageSize = 5;  // 페이지당 공지사항 수
        int currentPage = 1;  // 기본 페이지 번호 설정

        // 현재 페이지 번호 가져오기 및 예외 처리
        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                currentPage = Integer.parseInt(pageParam);  // 페이지 번호를 정수로 변환
            } catch (NumberFormatException e) {
                currentPage = 1;  // 페이지 번호가 잘못된 경우 기본값으로 설정
            }
        }

        List<Notice> noticeList = noticeDao.getNoticesByPage(currentPage, pageSize);  // 해당 페이지의 공지사항 목록 가져오기
        int totalNotices = noticeDao.getTotalNoticeCount();  // 전체 공지사항 수
        int totalPages = (int) Math.ceil((double) totalNotices / pageSize);  // 전체 페이지 수 계산
    %>

    <!-- 공지사항 리스트 출력 -->
    <% 
        if (noticeList != null && !noticeList.isEmpty()) {
            for (Notice notice : noticeList) { 
    %>
    <div class="notice-item">
        <!-- 공지사항 제목 -->
        <div class="notice-title"><a href="CA02.jsp?num=<%= notice.getNum() %>"><%= notice.getTitle() %></a></div>

        <!-- 공지사항 내용 -->
        <div class="notice-content"><%= notice.getContent() %></div>
    </div>
    <% 
            }
        } else { 
    %>
    <p>공지사항이 없습니다.</p>
    <% 
        } 
    %>

    <!-- 작성 버튼 -->
    <div class="write-btn">
        <a href="CA03.jsp">작성</a>
    </div>

    <!-- 페이징 처리 -->
    <div class="pagination">
        <% for (int i = 1; i <= totalPages; i++) { %>
            <% if (i == currentPage) { %>
                <span><%= i %></span>
            <% } else { %>
                <a href="CA01.jsp?page=<%= i %>"><%= i %></a>
            <% } %>
        <% } %>
    </div>
</div>

</body>
</html>
