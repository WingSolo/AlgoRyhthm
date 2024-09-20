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
      background-color: #ffffff; /* 전체 배경을 완전 흰색으로 설정 */
      color: #333;
  }
  
  .notice-container {
      width: 80%;
      margin: 50px auto;
      padding: 30px;
      background: linear-gradient(135deg, #ffffff 0%, #f0f2f5 100%); /* 공지사항 창에 그라데이션 적용 */
      box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
      border-radius: 10px;
  }

  .notice-header {
      text-align: center;
      font-size: 32px;
      font-weight: 700;
      margin-bottom: 30px;
      color: #007bff;
  }

  .notice-item {
      border-bottom: 1px solid #ddd;
      padding: 20px 0;
  }

  .notice-title {
      font-size: 18px;
      font-weight: bold;
      color: #007bff;
  }

  .notice-date {
      font-size: 14px;
      color: #666;
      float: right;
  }

  .notice-content {
      display: none;
      margin-top: 15px;
      font-size: 16px;
      color: #555;
  }

  .notice-title:hover {
      background-color: #f0f2f5; /* 로그인 시 제목에 하이라이트 효과 */
      border-radius: 5px;
  }

  .edit-button {
      background-color: #007bff;
      color: white;
      text-decoration: none;
      border-radius: 5px;
      padding: 10px 20px;
      font-size: 16px;
      transition: background-color 0.3s ease;
  }

  .edit-button:hover {
      background-color: #0056b3;
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
      font-size: 14px;
  }

  .pagination a:hover {
      background-color: #007bff;
      color: white;
  }

  .pagination span {
      font-weight: bold;
      color: #007bff;
  }

  /* 중앙에 배치할 스타일 */
  .center-button {
      display: flex;
      justify-content: center;
      align-items: center;
      margin-top: 20px;
  }
  
	.footer_section {
  		position: fixed; /* 화면 하단에 고정 */
  		bottom: 0;
  		left: 0;
  		width: 100%;
  		color: blue; /* 텍스트 색상 */
  		text-align: center;
  		padding: 5px 0; /* 상하 패딩을 작게 설정 */
 		box-shadow: none; /* 그림자 효과 제거 */
  		background-color: transparent; /* 배경색을 없앰 */
  		z-index: 1000; /* 다른 요소 위에 표시되도록 설정 */
		}

</style>

  <script>
      // JavaScript to toggle notice content
      function toggleContent(id) {
          var content = document.getElementById("content-" + id);
          if (content.style.display === "none") {
              content.style.display = "block";
          } else {
              content.style.display = "none";
          }
      }
  </script>
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
    <div class="notice-header">공지사항 📢</div>

    <% 
        NoticeDao noticeDao = new NoticeDao();
        int pageSize = 5;
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
            <div class="notice-item" onclick="toggleContent('<%= notice.getNum() %>')">
                <div class="notice-title">
                    <%= startIndex + i %>. <%= notice.getTitle() %>
                    <span class="notice-date"><%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(notice.getCreatedAt()) %></span>
                </div>
                <div class="notice-content" id="content-<%= notice.getNum() %>">
                    <%= notice.getContent() %>&nbsp;&nbsp;&nbsp;

                    <% if (loginUser != null) { %>
                        <!-- 로그인한 사용자만 편집 버튼이 보이도록 처리 -->
                        <a href="CA02.jsp?num=<%= notice.getNum() %>" class="edit-button">🖊️ 편집</a>
                    <% } %>

                </div>
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
