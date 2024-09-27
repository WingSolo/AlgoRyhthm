<%@ page contentType="text/html; charset=UTF-8" language="java" %>
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
   		background: #ffffff; /* 바탕화면을 흰색으로 변경 */
    	color: #003366; /* 글자 색상 군청색 */
  	}

  	.login_form {
    	background: #ffffff; /* 로그인 창 바탕 흰색 */
    	padding: 30px;
    	border-radius: 10px;
    	box-shadow: none; /* 그림자 제거 */
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
    	background-color: #003366; /* 버튼 색깔 군청색 */
    	color: white;
    	padding: 12px 25px;
    	border-radius: 30px;
    	border: none;
    	font-size: 16px;
    	width: 100%;
    	transition: background-color 0.3s ease;
    	box-shadow: none; /* 그림자 제거 */
  	}

  	.btn:hover {
    	background-color: #002244; /* 버튼 호버 시 더 진한 군청색 */
  	}

    .heading_container h2 {
      font-size: 36px;
      font-weight: 700;
      color: #003366; /* 제목 글자 색상 군청색 */
      position: relative;
      display: inline-block;
    }

    .heading_container h2::before {
      content: "🔑";
      position: absolute;
      left: -40px;
      top: 50%;
      transform: translateY(-50%);
      font-size: 36px;
    }

    .heading_container span {
      color: #003366; /* 강조된 텍스트 군청색 */
    }

    .login_form a {
      color: #003366; /* 링크 글자색 군청색 */
      text-decoration: none;
      font-weight: 600;
    }

    .login_form a:hover {
      text-decoration: underline;
    }

    .contact_nav a i {
      margin-right: 8px;
      font-size: 18px;
      color: #fff;
    }

    /* header style improvement */
    .header_section {
      background: linear-gradient(135deg, #003366, #0056b3); /* 헤더 그라데이션 */
      padding: 10px 0;
    }

    .navbar-nav .nav-link {
      color: #fff;
      font-weight: 500;
      padding: 10px 15px;
    }

    .navbar-nav .nav-link:hover {
      color: #ffefba;
    }

    .nav-item.active .nav-link {
      color: #ffefba;
    }

    .form-group input::placeholder {
      color: #adb5bd;
    }

    .form-control:focus {
      border-color: #003366; /* 포커스 시 테두리 군청색 */
      box-shadow: 0 0 5px rgba(0, 51, 102, 0.5);
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
  
  <!-- Login Section -->
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
                <button type="submit" class="btn">🔐 로그인</button>
              </div>
              <div class="form-group">
                <a href="findPassword.jsp">🔑 비밀번호 찾기</a>
              </div>

            </form>
          </div>
        </div>
      </div>
    </div>
  </section>

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
