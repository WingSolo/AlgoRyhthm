<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="common.Notice, common.NoticeDao" %>
<%@ page import="java.util.List" %>
<%@ page import="common.EmpUser,common.EmpUserDao" %>

<%
    // 세션에서 user 객체 가져오기
    EmpUser loginUser = (EmpUser) session.getAttribute("loginUser");
%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
  <title>공지사항</title>
  <link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/css/nice-select.min.css" />
  <link href="css/font-awesome.min.css" rel="stylesheet" />
  <link href="css/style.css" rel="stylesheet" />
  <link href="css/responsive.css" rel="stylesheet" />

<style>
  body {
      font-family: 'Poppins', sans-serif;
      background-color: #f8f9fa; /* 페이지 배경을 밝은 회색으로 설정 */
      color: #333;
      font-size: 14px; /* 폰트 크기 축소 */
  }

  /* 공지사항 컨테이너 */
  .notice-container {
      width: 80%;
      margin: 50px auto;
      padding: 30px;
      background-color: #ffffff; /* 본문 전체 흰색 배경 */
      border-radius: 10px; /* 테두리 둥글게 */
      color: #333; /* 본문 텍스트 색상 */
      border: 1px solid #ddd; /* 테두리 추가 */
  }

  /* 공지사항 제목 라인 */
  .notice-header {
      display: flex;
      justify-content: center; /* 중앙 정렬 */
      align-items: center; /* 세로 중앙 정렬 */
      font-size: 28px; /* 제목 폰트 크기 축소 */
      font-weight: 700;
      margin-bottom: 30px;
      padding: 20px;
      color: #003366; /* 제목 텍스트 색상 */
      background-color: #ffffff; /* 제목 부분 흰색 배경 */
      border-radius: 5px; /* 제목 배경에 둥근 모서리 */
  }

  /* 이모티콘 스타일 */
  .notice-header .emoji {
      margin-right: 10px; /* 이모티콘과 텍스트 간격 */
      font-size: 36px; /* 이모티콘 크기 */
  }

  .notice-item {
      border-bottom: 1px solid #ddd;
      padding: 20px 0;
  }

  .notice-title {
      font-size: 16px; /* 공지 제목 폰트 크기 축소 */
      font-weight: bold;
      color: #003366; /* 제목 글씨는 군청색 */
      cursor: pointer;
      text-decoration: none;
  }

  .notice-title:hover {
      background-color: #f0f2f5;
      border-radius: 5px;
      color: #003366; /* 호버 시 배경을 회색, 글씨는 군청색 유지 */
  }

  .notice-date {
      font-size: 12px; /* 날짜 폰트 크기 축소 */
      color: #666; /* 날짜 색상 */
      float: right;
  }

  .pagination {
      text-align: center;
      margin-top: 30px;
  }

  .pagination a, .pagination span {
      margin: 0 5px;
      padding: 8px 16px;
      text-decoration: none;
      border: 1px solid #ddd;
      border-radius: 5px;
      font-size: 12px; /* 페이지네이션 폰트 크기 축소 */
      color: #333; /* 페이지네이션 기본 글씨 색상 */
  }

  .pagination a:hover {
      background-color: #007bff;
      color: white; /* 페이지네이션 호버 시 배경 파란색, 글씨 흰색 */
  }

  .pagination span {
      font-weight: bold;
      color: #007bff; /* 현재 페이지 강조 색상 */
  }

  /* 중앙에 배치할 스타일 */
  .center-button {
      display: flex;
      justify-content: center;
      align-items: center;
      margin-top: 20px;
  }

  /* 공지 작성 버튼 스타일 */
  .edit-button {
      background-color: #003366; /* 버튼은 군청색 */
      color: #ffffff; /* 버튼 텍스트는 흰색 */
      padding: 12px 25px;
      font-size: 16px;
      font-weight: bold;
      border: none;
      border-radius: 50px; /* 버튼 둥글게 */
      transition: background-color 0.3s ease, transform 0.3s ease;
      text-decoration: none;
      display: inline-block;
  }

  .edit-button:hover {
      background-color: #002244; /* 호버 시 버튼 색상 더 진하게 변경 */
      transform: scale(1.05);
  }
</style>

</head>

<body class="sub_page">
  <div class="hero_area">
    <!-- header section starts -->
    <header class="header_section">
      <div class="header_top">
        <div class="container-fluid header_top_container">
          <div class="contact_nav">
            <a href="A01.jsp"><i class="fa fa-map-marker" aria-hidden="true"></i><span>Location</span></a>
            <a href="BA02.jsp"><i class="fa fa-phone" aria-hidden="true"></i><span>전화번호 : 031-224-3636</span></a>
            <a href="BA02.jsp"><i class="fa fa-envelope" aria-hidden="true"></i><span>Algo@gmail.com</span></a>
            <% if (loginUser != null) { %>
              <a href="logout.jsp"><i class="fa fa-sign-out" aria-hidden="true"></i><span>로그아웃</span></a>
            <% } else { %>
              <a href="login.jsp"><i class="fa fa-user" aria-hidden="true"></i><span>관리자</span></a>
            <% } %>
          </div> 
        </div>
      </div>
  
      <div class="header_bottom">
        <div class="container-fluid">
          <nav class="navbar navbar-expand-lg custom_nav-container">
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
              <ul class="navbar-nav">
                <li class="nav-item active">
                  <a class="nav-link" href="main.jsp"><span><img src="images/logo.png" alt="logo" height="27px"></span></a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="A01.jsp">회사소개</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="CA01.jsp">공지사항</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="AB_main.jsp">분석사례</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="BA01.jsp">분석</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="BA02.jsp">문의하기</a>
                </li>                
                <% if (loginUser != null) { %>
                <li class="nav-item">
                  <a class="nav-link" href="DA01.jsp">마이페이지</a>
                </li>
                <% } %>
              </ul>
            </div>
          </nav>
        </div>
      </div>
    </header>
    <!-- end header section -->
  </div>
  
  <div class="notice-container">
	<div class="notice-header">
    	<span class="emoji">📋</span> <!-- 이모티콘을 클립보드 모양으로 변경 -->
    	<span>공지사항</span>
	</div>

    <% 
        NoticeDao noticeDao = new NoticeDao();
        int pageSize = 10;  // 페이지당 표시할 공지사항 개수 10으로 증가
        int currentPage = 1;

        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                currentPage = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                currentPage = 1;
            }
        }

        List<Notice> noticeList = noticeDao.getNoticesByPage(currentPage, pageSize);
        int totalNotices = noticeDao.getTotalNoticeCount();
        int totalPages = (int) Math.ceil((double) totalNotices / pageSize);
        int startIndex = (currentPage - 1) * pageSize + 1;  // 공지사항 번호 매기기
    %>

    <% if (noticeList != null && !noticeList.isEmpty()) { %>
        <% for (int i = 0; i < noticeList.size(); i++) { 
            Notice notice = noticeList.get(i); 
        %>
            <div class="notice-item">
                <!-- 제목을 클릭하면 CA02.jsp로 이동하도록 설정 -->
                <a href="CA02.jsp?num=<%= notice.getNum() %>" class="notice-title">
                    <%= startIndex + i %>. <%= notice.getTitle() %>
                </a>
                <span class="notice-date"><%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(notice.getCreatedAt()) %></span>
            </div>
        <% } %>
    <% } else { %>
        <p>공지사항이 없습니다.</p>
    <% } %>

    <!-- 로그인된 경우 작성 버튼을 페이지네이션 위에 추가 -->
    <% if (loginUser != null) { %>
        <div class="center-button">
            <a href="CA03.jsp" class="edit-button">📋 공지 작성</a>
        </div>
    <% } %>

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
  
  <!-- footer section -->
  <footer class="footer_section">
    <div class="container">
      <p>&copy; <span id="displayYear"></span> All Rights Reserved By <a href="main.jsp">AlgoRhythm</a></p>
    </div>
  </footer>
  
  <script src="js/jquery-3.4.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
  <script src="js/bootstrap.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>
  <script src="https://huynhhuynh.github.io/owlcarousel2-filter/dist/owlcarousel2-filter.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/js/jquery.nice-select.min.js"></script>
  <script src="js/custom.js"></script>
</body>
</html>
