<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="common.Notice, common.NoticeDao, common.EmpUser" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page session="true" %> <!-- 세션 활성화 -->
<%
    // 세션에서 user 객체 가져오기
    Object user = session.getAttribute("loginUser");
%>

<!DOCTYPE html>
<html>
<head>   <title>공지사항 확인</title>
    <style>
        .notice-container { width: 80%; margin: 0 auto; }
        .notice-header { text-align: center; font-size: 24px; font-weight: bold; margin-top: 20px; }
        .notice-subtitle { text-align: center; margin-bottom: 20px; }
        .notice-content { margin: 20px 0; }
        .button-group { text-align: center; margin-top: 20px; }
        .button-group a { margin: 0 10px; text-decoration: none; padding: 8px 16px; border: 1px solid #ddd; }
    </style>
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
  <title>관리자 로그인</title>
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
  
  
  
<%
    // 로그인된 사용자 정보 가져오기
    EmpUser currentUser = (EmpUser) session.getAttribute("loginUser"); // 세션에서 로그인된 사용자 객체 가져오기
    if (currentUser == null) { // 로그인이 안 된 상태일 경우
        response.sendRedirect("CA01.jsp"); // 로그인되지 않은 경우 CA01.jsp로 리디렉션
        return; // 이후 코드 실행 방지
    }

    // 공지사항 번호 가져오기
    String numStr = request.getParameter("num");
    Notice notice = null;

    if (numStr != null && !numStr.isEmpty()) {
        try {
            int num = Integer.parseInt(numStr); // 문자열을 정수로 변환

            // NoticeDao 객체를 사용하여 데이터베이스에서 공지사항 조회
            NoticeDao noticeDao = new NoticeDao();
            notice = noticeDao.getNoticeByNum(num);  // 공지사항 번호로 조회

            if (notice == null) {
                out.println("<p>해당 번호의 공지사항이 존재하지 않습니다.</p>");
                out.println("<a href='CA01.jsp'>목록으로 돌아가기</a>");
                return; // 이후 코드 실행 방지
            }
        } catch (NumberFormatException e) {
            out.println("<p>잘못된 공지사항 번호입니다.</p>");
            out.println("<a href='CA01.jsp'>목록으로 돌아가기</a>");
            return; // 이후 코드 실행 방지
        } catch (Exception e) {
            out.println("<p>공지사항을 조회하는 중 오류가 발생했습니다.</p>");
            out.println("<a href='CA01.jsp'>목록으로 돌아가기</a>");
            return; // 이후 코드 실행 방지
        }
    } else {
        out.println("<p>공지사항 번호가 지정되지 않았습니다.</p>");
        out.println("<a href='CA01.jsp'>목록으로 돌아가기</a>");
        return; // 이후 코드 실행 방지
    }
%>

<div class="notice-container">
    <!-- 공지사항 제목 -->
    <div class="notice-header">공지사항</div>
    <div class="notice-subtitle">알고리듬의 소식을 확인해보세요.</div>

    <% if (notice != null) { %> <!-- 공지사항이 존재할 경우 출력 -->
        <!-- 공지사항 제목 -->
        <div class="notice-title"><h2><%= notice.getTitle() %></h2></div>

        <!-- 공지사항 작성자 및 작성일자 -->
        <div class="notice-meta">
            작성자: <%= notice.getEmpId() %> | 작성일: <%= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(notice.getCreatedAt()) %>
        </div>

        <!-- 공지사항 내용 -->
        <div class="notice-content"><%= notice.getContent() %></div>
    <% } else { %>
        <!-- 공지사항이 없는 경우 -->
        <p>공지사항을 찾을 수 없습니다.</p>
        <a href="CA01.jsp">목록으로 돌아가기</a>
    <% } %>

    <!-- 목록, 수정, 삭제, 작성 버튼 -->
    <div class="button-group">
        <a href="CA01.jsp">목록</a>
        <% if (notice != null) { %>
            <a href="CA04.jsp?num=<%= notice.getNum() %>">수정</a>
            <a href="CA05.jsp?num=<%= notice.getNum() %>" onclick="return confirm('삭제하시겠습니까?');">삭제</a>
        <% } %>
        <a href="CA03.jsp">작성</a> <!-- 작성 버튼 추가 -->
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
