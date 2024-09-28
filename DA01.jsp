<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="common.Notice, common.NoticeDao" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    // 세션에서 user 객체 가져오기
    Object loginUser = session.getAttribute("loginUser");
%>

<!DOCTYPE html>

<html>
<head>
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
  <link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/css/nice-select.min.css" />
  <link href="css/font-awesome.min.css" rel="stylesheet" />
  <link href="css/style.css" rel="stylesheet" />
  <link href="css/responsive.css" rel="stylesheet" />
  <title>회원 정보 수정 전 비밀번호 확인</title>
  
<!DOCTYPE html>

<html>
<head>
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
  <link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/css/nice-select.min.css" />
  <link href="css/font-awesome.min.css" rel="stylesheet" />
  <link href="css/style.css" rel="stylesheet" />
  <link href="css/responsive.css" rel="stylesheet" />
  <title>회원 정보 수정 전 비밀번호 확인</title>
  
<style>
    .container01 {
        max-width: 1200px;
        margin: 30px auto;
        padding: 20px;
        display: flex;
        justify-content: center; /* 우측 창을 중앙에 정렬 */
        gap: 0; /* 좌측 창과 우측 창 사이의 간격을 제거 */
    }
    /* 사이드바 */
    .sidebar {
        width: 15%;
        background: #ffffff; /* 창 배경 흰색 */
        padding: 20px;
        border-radius: 10px;
        color: #003366; /* 글자 색 군청색 */
        margin-right: 0; /* 우측 창과 밀착시키기 위해 여백 제거 */
    }
    /* 메인 콘텐츠 창 */
    .content {
        width: 50%;
        background: #ffffff; /* 창 배경 흰색 */
        padding: 40px;
        text-align: center;
        border-radius: 10px;
        color: #003366; /* 텍스트 색상 군청색 */
        margin-left: 0; /* 좌측 여백 최소화 */
    }
    h2 {
        font-size: 24px;
        font-weight: bold;
        margin-bottom: 20px;
        color: #003366; /* 제목 색상 군청색 */
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
        background-color: #ff8000; /* 기본 배경색 주황색 */
        color: white;
        cursor: pointer;
        transition: all 0.3s ease; /* 호버 효과를 부드럽게 적용 */
    }
    button:hover {
        background-color: transparent; /* 호버 시 배경색 투명 */
        color: #ff8000; /* 호버 시 글자색 주황색 */
        border: 2px solid #ff8000; /* 테두리 주황색 */
        transform: scale(1.05); /* 버튼 크기 살짝 증가 */
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
        color: #003366; /* 메뉴 링크 색상 군청색 */
        display: flex;
        align-items: center;
    }
    .menu-item a:hover {
        color: #002244; /* 호버 시 더 어두운 색 */
    }
    .menu-item i {
        margin-right: 10px;
    }
    .error-message {
        color: red;
        margin-bottom: 15px;
        font-size: 14px;
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
                <li class="nav-item">
                  <a class="nav-link" href="main.jsp"><img src="images/logo.png" alt="logo" width = "77px"height="37px"></a>
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
  </div>
  
  <div class="container01">
    <!-- Sidebar -->
    <div class="sidebar">
      <div class="menu-title">마이 메뉴</div>
      <div class="menu-item">
        <a href="DA01.jsp">정보 수정</a>
      </div>
      <div class="menu-item">
        <a href="EA01.jsp"> 문의 내역</a>
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
