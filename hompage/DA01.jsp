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
    <style>
        .container01 {
            width: 70%;
            margin: 0 auto;
            padding: 20px;
            display: flex; /* 왼쪽 메뉴와 오른쪽 콘텐츠를 나란히 배치 */
            gap: 40px; /* 왼쪽 메뉴와 오른쪽 콘텐츠 간의 간격 */
        }
        .sidebar {
            width: 30%; /* 왼쪽 메뉴의 넓이 */
            padding: 20px;
            background-color: #f9f9f9; /* 사이드바 섹션의 배경색을 약간 회색으로 설정 */
        }
        .content {
            width: 70%; /* 오른쪽 콘텐츠의 넓이 */
            text-align: center;
            padding: 20px; /* 콘텐츠에 패딩 추가 */
            background-color: #fff; /* 콘텐츠 섹션의 배경색을 흰색으로 설정 */
        }
        .button-container {
            margin-top: 20px;
        }
        input[type="password"] {
            width: 60%;
            padding: 10px;
            margin: 10px 0;
        }
        button {
            padding: 10px 20px;
            margin: 5px;
        }
        .menu-title {
            font-size: 20px; /* 마이 메뉴 제목의 글자 크기 */
            font-weight: bold;
            margin-bottom: 15px;
        }
        .menu-item {
            margin-bottom: 10px;
        }
        .menu-item a {
            text-decoration: none; /* 링크 밑줄 제거 */
            color: #000; /* 링크 색상 */
        }
        .error-message {
            color: red; /* 오류 메시지 색상 */
            margin-bottom: 15px;
        }
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
  
  
  
    <div class="container01">
        <!-- 왼쪽 메뉴 섹션 -->
        <div class="sidebar">
            <div class="menu-title">마이 메뉴</div>
            <div class="menu-item"><a href="DA01.jsp">정보 수정</a></div>
            <div class="menu-item"><a href="InquiryList.jsp">문의 내역</a></div>
        </div>

        <!-- 오른쪽 콘텐츠 섹션 -->
        <div class="content">
            <h2>회원 정보 수정 전 비밀번호 확인</h2>

            <% 
                String errorMessage = request.getParameter("error");
                if ("invalidPassword".equals(errorMessage)) {
            %>
                <div class="error-message">비밀번호가 일치하지 않습니다. 다시 입력해 주세요.</div>
            <% 
                }
            %>

            <form action="CheckPasswordServlet" method="post"> <!-- 비밀번호 확인 서블릿 호출 -->
                <label for="password">기존 비밀번호를 입력하세요.</label><br>
                <input type="password" id="password" name="password" placeholder="기존 비밀번호 입력" required><br>
                <div class="button-container">
                    <button type="submit">확인</button>
                    <button type="button" onclick="location.href='main.jsp'">취소</button>
                </div>
            </form>
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
