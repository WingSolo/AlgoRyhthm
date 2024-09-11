<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="common.Notice, common.NoticeDao" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    // 세션에서 user 객체 가져오기
    Object user = session.getAttribute("loginUser");
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
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
  <link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/css/nice-select.min.css" integrity="sha256-mLBIhmBvigTFWPSCtvdu6a76T+3Xyt+K571hupeFLg4=" crossorigin="anonymous" />
  <link href="css/font-awesome.min.css" rel="stylesheet" />
  <link href="css/style.css" rel="stylesheet" />
  <link href="css/responsive.css" rel="stylesheet" />
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
            <% if (user != null) { %>
              <a href="Logout"><i class="fa fa-sign-out" aria-hidden="true"></i><span>로그아웃</span></a>
            <% } else { %>
              <a href="login.jsp"><i class="fa fa-user" aria-hidden="true"></i><span>관리자</span></a>
            <% } %>
          </div> 
        </div>
      </div>
  
        <div class="header_bottom">
        <div class="container-fluid">
          <nav class="navbar navbar-expand-lg custom_nav-container ">
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
              <ul class="navbar-nav">
                <li class="nav-item active">
                  <a class="nav-link" href="main.jsp"><span><img src="images/logo.png" alt="logo" height="27px"></span></a>
                </li>
                <li class="nav-item active">
                  <a class="nav-link" href="main.jsp">홈<span class="sr-only">(current)</span></a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="A01.jsp">회사소개</a>
                </li>
                
                <!-- 공지사항 링크-->
                <li class="nav-item">
                    <a class="nav-link" href="CA01.jsp">공지사항</a> <!-- 비로그인 시 CA01.jsp로 이동 -->
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
                <!-- Show "마이페이지" next to "공지사항" if the user is logged in -->
                <% if (user != null) { %>
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

  <!-- footer section -->
  <footer class="footer_section">
    <div class="container">
      <p>&copy; <span id="displayYear"></span> All Rights Reserved By <a href="main.jsp">AlgoRhythm</a></p>
    </div>
  </footer>
  
  <script src="js/jquery-3.4.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
  <script src="js/bootstrap.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>
  <script src="https://huynhhuynh.github.io/owlcarousel2-filter/dist/owlcarousel2-filter.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/js/jquery.nice-select.min.js" integrity="sha256-Zr3vByTlMGQhvMfgkQ5BtWRSKBGa2QlspKYJnkjZTmo=" crossorigin="anonymous"></script>
  <script src="js/custom.js"></script>
</body>
</html>
