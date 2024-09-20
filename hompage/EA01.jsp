<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="common.IntroDao, common.Intro, java.util.List" %>

<%
    // 세션에서 user 객체 가져오기
    Object loginUser = session.getAttribute("loginUser");

    // IntroDao 객체 생성
    IntroDao introDao = new IntroDao();

    // 페이지 번호 및 페이지 크기 설정 (기본값 1페이지, 10개 항목)
    int currentPage = 1;
    int pageSize = 10;

    // 페이지 파라미터 가져오기 (URL 쿼리에서 "page" 값이 있으면 가져오고 없으면 1로 설정)
    String pageParam = request.getParameter("page");
    if (pageParam != null && !pageParam.isEmpty()) {
        try {
            currentPage = Integer.parseInt(pageParam);  // 페이지 번호를 정수로 변환
        } catch (NumberFormatException e) {
            currentPage = 1;  // 페이지 번호가 잘못된 경우 기본값으로 설정
        }
    }

    // 공지사항 목록 및 페이지 정보 가져오기
    List<Intro> introList = introDao.getIntroByPage(currentPage, pageSize);
    int totalIntroCount = introDao.getTotalIntroCount();
    int totalPages = (int) Math.ceil((double) totalIntroCount / pageSize);
%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
  <title>문의 내역</title>

  <!-- CSS Files -->
  <link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
  <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/css/nice-select.min.css" />
  <link href="css/font-awesome.min.css" rel="stylesheet" />
  <link href="css/style.css" rel="stylesheet" />
  <link href="css/responsive.css" rel="stylesheet" />

  <style>
    /* 전체 컨테이너 */
    .container01 {
        max-width: 1600px;
        margin: 30px auto;
        padding: 20px;
        display: flex;
        justify-content: space-between;
        gap: 200px;
    }

    /* 사이드바 */
    .sidebar {
        width: 15%;
        background: linear-gradient(135deg, #f9f9f9, #d0e1ff);
        padding: 20px;
        border-radius: 10px;
    }
    
    .menu-title {
        font-size: 20px;
        font-weight: bold;
        margin-bottom: 20px;
        color: #007bff;
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
    
    /* 오른쪽 콘텐츠 영역 */
    .content {
        width: 70%;
        text-align: center;
        padding: 20px;
        background-color: #fff;
    }
    
    /* 테이블 스타일 */
    .table-hover th, .table-hover td {
        text-align: center;
    }

    .button-container {
        margin-top: 20px;
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
  		z-index: 1000;
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
      <div class="menu-item"><a href="DA01.jsp">✏️ 정보 수정</a></div>
      <div class="menu-item"> <a href="EA01.jsp"><i class="fa fa-envelope"></i> 문의 내역</a></div>
    </div>

    <!-- Content Section -->
    <div class="content">
      <h2>문의내역</h2>
      <br><br>

      <div class="container">
        <table class="table table-hover">
          <thead>
            <tr>
              <th>No.</th>
              <th>성함</th>
              <th>이메일</th>
              <th>핸드폰</th>
              <th>기관명</th>
              <th>데이터 종류</th>
              <th>상담유형</th>
              <th>방문경로</th>
              <th>일시</th>
            </tr>
          </thead>
          <tbody>
            <% if (introList != null && !introList.isEmpty()) {
                for (Intro intro : introList) { %>
                <tr onclick="goToDetailPage(<%= intro.getNum() %>)" style="cursor: pointer;">
                  <td><%= intro.getNum() %></td>
                  <td><%= intro.getCust_name() %></td>
                  <td><%= intro.getEmail() %></td>
                  <td><%= intro.getPhone() %></td>
                  <td><%= intro.getComp_name() %></td>
                  <td><%= intro.getData_type() %></td>
                  <td><%= intro.getCoun_type() %></td>
                  <td><%= intro.getVisit_path() %></td>
                  <td><%= intro.getTime() %></td>
                </tr>
            <% } } else { %>
                <tr>
                  <td colspan="9">No data found.</td>
                </tr>
            <% } %>
          </tbody>
        </table>
      </div>
    </div>
  </div>

  <!-- Footer -->
  <footer class="footer_section">
    <div class="container">
      <p>&copy; <span id="displayYear"></span> All Rights Reserved By <a href="main.jsp">AlgoRhythm</a></p>
    </div>
  </footer>

  <!-- JS Scripts -->
  <script src="js/jquery-3.4.1.min.js"></script>
  <script src="js/bootstrap.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/js/jquery.nice-select.min.js"></script>
  <script src="js/custom.js"></script>

    <!-- goToDetailPage 자바스크립트 함수 -->
    <script>
        // 특정 번호의 공지사항 상세 페이지로 이동하는 함수
        function goToDetailPage(num) {
            window.location.href = "EA02.jsp?num=" + num;
        }
    </script>
</body>
</html>
