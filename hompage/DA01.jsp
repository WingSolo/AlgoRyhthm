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
  <title>회원 정보 수정 전 비밀번호 확인</title>
  
  <!-- Bootstrap Core CSS -->
  <link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
  <!-- Font Awesome for Icons -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
  <!-- Custom styles -->
  <link href="css/style.css" rel="stylesheet" />
  <!-- Responsive styles -->
  <link href="css/responsive.css" rel="stylesheet" />
  
<style>
    /* 기존 스타일 유지 */
    .container01 {
        max-width: 900px;
        margin: 40px auto;
        padding: 20px;
        display: flex;
        justify-content: space-between; /* 양쪽에 균형 맞추기 */
        gap: 40px;
    }
    .sidebar {
        width: 30%;
        background-color: #f0f0f0;
        padding: 20px;
        border-radius: 10px; /* 둥근 모서리 */
    }
    .content {
        width: 65%;
        background: linear-gradient(135deg, #007bff, #00c6ff); /* 그라데이션 추가 */
        padding: 40px;
        text-align: center;
        border-radius: 10px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
        color: white; /* 텍스트 색상 변경 */
    }
    h2 {
        font-size: 24px;
        font-weight: bold;
        margin-bottom: 20px;
        color: #ffffff;
    }
    .button-container {
        margin-top: 20px;
    }
    input[type="password"] {
        width: 80%;
        padding: 10px;
        margin-top: 15px;
        border-radius: 5px;
        border: 1px solid #ccc;
    }
    button {
        padding: 10px 20px;
        border: none;
        border-radius: 5px;
        background-color: #ffffff;
        color: #007bff;
        cursor: pointer;
    }
    button:hover {
        background-color: #e0e0e0;
    }
    .menu-title {
        font-size: 18px;
        font-weight: bold;
        margin-bottom: 20px;
    }
    .menu-item {
        margin-bottom: 10px;
        font-size: 16px;
    }
    .menu-item a {
        text-decoration: none;
        color: #007bff;
        display: flex;
        align-items: center;
    }
    .menu-item a:hover {
        color: #0056b3;
    }
    .menu-item i {
        margin-right: 10px;
    }
    .error-message {
        color: red;
        margin-bottom: 15px;
        font-size: 14px;
    }
</style>

</head>

<body class="sub_page">
  <div class="hero_area">
    <!-- Header Section -->
    <header class="header_section">
      <div class="header_top">
        <div class="container-fluid header_top_container">
          <div class="contact_nav">
            <a href="A01.jsp"><i class="fa fa-map-marker" aria-hidden="true"></i><span> Location</span></a>
            <a href="BA02.jsp"><i class="fa fa-phone" aria-hidden="true"></i><span> 전화번호: 031-224-3636</span></a>
            <a href="BA02.jsp"><i class="fa fa-envelope" aria-hidden="true"></i><span> Algo@gmail.com</span></a>
            <% if (user != null) { %>
              <a href="Logout"><i class="fa fa-sign-out" aria-hidden="true"></i><span> 로그아웃</span></a>
            <% } else { %>
              <a href="login.jsp"><i class="fa fa-user" aria-hidden="true"></i><span> 관리자</span></a>
            <% } %>
          </div> 
        </div>
      </div>
      <div class="header_bottom">
        <div class="container-fluid">
          <nav class="navbar navbar-expand-lg custom_nav-container">
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
              <ul class="navbar-nav">
                <li class="nav-item">
                  <a class="nav-link" href="main.jsp"><img src="images/logo.png" alt="logo" height="27px"></a>
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
  </div>
  
  <div class="container01">
    <!-- Sidebar -->
    <div class="sidebar">
      <div class="menu-title">마이 메뉴</div>
      <div class="menu-item">
        <a href="DA01.jsp"><i class="fa fa-user-edit"></i> 정보 수정</a>
      </div>
      <div class="menu-item">
        <a href="DA01.jsp"><i class="fa fa-envelope"></i> 문의 내역</a>
      </div>
    </div>

    <!-- Content -->
    <div class="content">
      <h2>회원 정보 수정 전 비밀번호 확인</h2>
      <% 
          String errorMessage = request.getParameter("error");
          if ("invalidPassword".equals(errorMessage)) {
      %>
        <div class="error-message">비밀번호가 일치하지 않습니다. 다시 입력해 주세요.</div>
      <% } %>

      <form action="CheckPasswordServlet" method="post">
        <label for="password">기존 비밀번호를 입력하세요.</label><br>
        <input type="password" id="password" name="password" placeholder="기존 비밀번호 입력" required><br>
        <div class="button-container">
          <button type="submit">확인</button>
          <button type="button" onclick="location.href='main.jsp'">취소</button>
        </div>
      </form>
    </div>
  </div>

  <!-- Footer -->
  <footer class="footer_section">
    <div class="container">
      <p>&copy; <span id="displayYear"></span> All Rights Reserved By <a href="main.jsp">AlgoRhythm</a></p>
    </div>
  </footer>

  <script src="js/jquery-3.4.1.min.js"></script>
  <script src="js/bootstrap.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/js/jquery.nice-select.min.js"></script>
  <script src="js/custom.js"></script>
</body>
</html>
