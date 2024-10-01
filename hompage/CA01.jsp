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
      background-color: #ffffff;
      color: #333;
      font-size: 14px;
  }

  .notice-container {
      width: 80%;
      margin: 50px auto;
      padding: 30px;
      background-color: #ffffff;
      border-radius: 10px;
      color: #333;
      border: 1px solid #ddd;
  }

  .notice-header {
      display: flex;
      justify-content: center;
      align-items: center;
      font-size: 28px;
      font-weight: 700;
      margin-bottom: 30px;
      padding: 20px;
      color: #003366;
      background-color: #ffffff;
      border-radius: 5px;
  }

  .notice-table {
      width: 100%;
      border-collapse: collapse;
  }

  .notice-table th, .notice-table td {
     border: 1px solid #ddd;
     padding: 12px;
     text-align: left;
  }

  .notice-table th {
     background-color: #f2f2f2;
     font-size: 16px;
     color: #003366;
  }
  
  /* No 열의 너비를 축소 */
  .notice-table th:nth-child(1), .notice-table td:nth-child(1) {
     width: 80px; /* No 칼럼의 너비 */
  } 

 /* 작성자와 작성날짜 칼럼의 가로 길이를 줄이기 위해 width 설정 */
  .notice-table th:nth-child(3), .notice-table td:nth-child(3) {
     width: 120px; /* 작성자 칼럼의 너비 */
  }

  .notice-table th:nth-child(4), .notice-table td:nth-child(4) {
     width: 120px; /* 작성날짜 칼럼의 너비 */
  }

  .notice-table td {
     font-size: 14px;
     color: #333;
  }

  .notice-title a {
     text-decoration: none;
     color: #003366;
  }

  .notice-title a:hover {
     background-color: #f0f2f5;
     color: #003366;
  }


  /* 페이지 네이션 테이블과 가깝게 배치 */
  .pagination {
      display: flex; /* Flexbox 사용 */
      justify-content: center; /* 중앙 정렬 */
      margin-top: 0px; /* 테이블과 가깝게 */
  }

  .pagination a, .pagination span {
      margin: 0 5px;
      padding: 8px 16px;
      text-decoration: none;
      border: 1px solid #ddd;
      border-radius: 5px;
      font-size: 12px;
      color: #333;
  }

  .pagination a:hover {
      background-color: #007bff;
      color: white;
  }

  .pagination span {
  	
      font-weight: bold;
      color: #007bff;
  }

  .center-button {
      display: flex;
      justify-content: flex-end;
      margin-top: 20px;
  }

  .edit-button {
      background-color: #FF6600;
      color: #ffffff;
      padding: 12px 25px;
      font-size: 16px;
      font-weight: bold;
      border: none;
      border-radius: 50px;
      transition: background-color 0.3s ease, transform 0.3s ease, color 0.3s ease;
      text-decoration: none;
      display: inline-block;
  }

  .edit-button:hover {
      background-color: transparent;
      color: #FF6600;
      transform: scale(1.05);
      border: 2px solid #FF6600;
  }
  
  .footer_section {
      position: bottom;
      bottom: 0;
      left: 0;
      width: 100%;
      color: blue;
      text-align: center;
      padding: 5px 0;
      background-color: transparent;
      z-index: 0;
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
                  <a class="nav-link" href="main.jsp"><span><img src="images/logo.png" alt="logo" width = "77px"height="37px"></span></a>
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
  					<% if (loginUser == null) { %>
    					<a class="nav-link" href="BA02.jsp">문의하기</a>
  					<% } %>
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
        <span>공지사항</span>
    </div>
    <div><h5><center>알고리듬의 소식을 확인해보세요</center></h5></div>
	<br>
    <% 
        NoticeDao noticeDao = new NoticeDao();
        int pageSize = 10;  
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
        int startIndex = (currentPage - 1) * pageSize + 1;  
    %>

    <table class="notice-table">
      <thead>
        <tr>
          <th>No</th>
          <th>제목</th>
          <th>작성자</th>
          <th>작성일자</th>
        </tr>
      </thead>
      <tbody>
        <% if (noticeList != null && !noticeList.isEmpty()) { %>
            <% for (int i = 0; i < noticeList.size(); i++) { 
                Notice notice = noticeList.get(i); 
            %>
            <tr>
              <td><%= startIndex + i %></td>
              <td class="notice-title">
                <a href="CA02.jsp?num=<%= notice.getNum() %>"><%= notice.getTitle() %></a>
              </td>
              <td><%= notice.getEmpId() %></td> <!-- emp_id 추가 -->
              <td><%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(notice.getCreatedAt()) %></td>
            </tr>
            <% } %>
        <% } else { %>
            <tr>
              <td colspan="4">공지사항이 없습니다.</td>
            </tr>
        <% } %>
      </tbody>
    </table>

    <% if (loginUser != null) { %>
        <div class="center-button">
            <a href="CA03.jsp" class="edit-button">공지 작성</a>
        </div>
    <% } %>

    <div class="pagination" style="text-align: center;">
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
