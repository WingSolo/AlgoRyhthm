<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="common.EmpUser,common.EmpUserDao" %>

<%
    // 세션에서 user 객체 가져오기
    EmpUser loginUser = (EmpUser) session.getAttribute("loginUser");
    String errorMessage = (String) request.getAttribute("errorMessage"); // request에서 오류 메시지 가져오기
%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
  <title>로그인</title>
  <link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/css/nice-select.min.css" />
  <link href="css/font-awesome.min.css" rel="stylesheet" />
  <link href="css/style.css" rel="stylesheet" />
  <link href="css/responsive.css" rel="stylesheet" />

  <!-- Custom CSS for more modern design -->
  <style>
    body {
      font-family: 'Poppins', sans-serif;
      background: #ffffff;
      color: #003366;
    }

    .login_form {
      background: #ffffff;
      padding: 30px;
      border-radius: 10px;
      box-shadow: none;
      text-align: center;
    }

    .form-control {
      border-radius: 10px;
      border: 2px solid #ced4da;
      padding: 12px 20px;
      font-size: 16px;
    }

    .form-group {
      margin-bottom: 20px;
    }

    .btn {
      background-color: #ff6600;
      color: white;
      padding: 12px 25px;
      border-radius: 30px;
      border: none;
      font-size: 16px;
      width: 100%;
      transition: background-color 0.3s ease, transform 0.3s ease, color 0.3s ease, border 0.3s ease;
      box-shadow: none;
    }

    .btn:hover {
      background-color: transparent;
      color: #ff6600;
      transform: scale(1.05);
      border: 2px solid #ff6600;
    }

    .heading_container h2 {
      font-size: 36px;
      font-weight: 700;
      color: #003366;
    }

    .heading_container span {
      color: #003366;
    }

    .login_form a {
      color: #003366;
      text-decoration: none;
      font-weight: 600;
    }

    .login_form a:hover {
      text-decoration: underline;
    }

    .form-group input::placeholder {
      color: #adb5bd;
    }

    .form-control:focus {
      border-color: #003366;
      box-shadow: 0 0 5px rgba(0, 51, 102, 0.5);
    }

    .footer_section {
      position: fixed;
      bottom: 0;
      left: 0;
      width: 100%;
      color: blue;
      text-align: center;
      padding: 5px 0;
      box-shadow: none;
      background-color: transparent;
      z-index: 0;
    }
  </style>
  
  <!-- 경고창 띄우는 스크립트 추가 -->
  <script>
    window.onload = function() {
      <% if (errorMessage != null) { %>
        alert("<%= errorMessage %>");
      <% } %>
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
                  <a class="nav-link" href="main.jsp"><span><img src="images/logo.png" alt="logo" width="77px" height="37px"></span></a>
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
   
 <body class="sub_page">
  <!-- 로그인 섹션 시작 -->
  <section class="contact_section layout_padding">
      <div class="container">
        <div class="heading_container heading_center">
          <h2>&nbsp;&nbsp; 관리자 <span> 로그인</span></h2>
        </div>

        <div class="row">
          <div class="col-md-6 offset-md-3">
            <div class="login_form">

              <form action="Login" method="post">
                <div class="form-group">
                  <input type="text" class="form-control" name="empId" placeholder="아이디" required>
                </div>
                <div class="form-group">
                  <input type="password" class="form-control" name="password" placeholder="비밀번호" required>
                </div>
                <div class="form-group">
                  <button type="submit" class="btn">로그인</button>
                </div>
                <div class="form-group">
                  <a href="findPassword.jsp">비밀번호 찾기</a>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
  </section>
  <!-- 로그인 섹션 끝 -->


  <!-- footer section -->
  <footer class="footer_section">
    <div class="container">
      <p>
        &copy; <span id="displayYear"></span> All Rights Reserved By
        <a href="main.html">AlgoRhythm</a>
      </p>
    </div>
  </footer>
  <!-- footer section -->

  <script src="js/jquery-3.4.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
  <script src="js/bootstrap.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>
  <script src="https://huynhhuynh.github.io/owlcarousel2-filter/dist/owlcarousel2-filter.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/js/jquery.nice-select.min.js"></script>
  <script src="js/custom.js"></script>
</body>
</html>
