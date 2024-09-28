<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="common.Notice, common.NoticeDao, common.EmpUser" %>
<%@ page session="true" %>

<%
    // 세션에서 user 객체 가져오기
    EmpUser loginUser = (EmpUser) session.getAttribute("loginUser");
    if (loginUser == null) { // 로그인이 안 된 상태일 경우
        response.sendRedirect("login.jsp"); // 로그인 페이지로 리디렉션
        return;
    }

    // 공지사항 번호 가져오기
    String numStr = request.getParameter("num");
    Notice notice = null;

    if (numStr != null && !numStr.isEmpty()) {
        try {
            int num = Integer.parseInt(numStr);

            // NoticeDao 객체를 사용하여 데이터베이스에서 공지사항 조회
            NoticeDao noticeDao = new NoticeDao();
            notice = noticeDao.getNoticeByNum(num);

            if (notice == null) {
                out.println("<p>해당 번호의 공지사항이 존재하지 않습니다.</p>");
                out.println("<a href='CA01.jsp'>목록으로 돌아가기</a>");
                return;
            }

            // 삭제 권한 확인 (공지사항 작성자만 삭제 가능)
            if (!notice.getEmpId().equals(loginUser.getEmp_id())) {
                out.println("<p>삭제 권한이 없습니다.</p>");
                out.println("<a href='CA01.jsp'>목록으로 돌아가기</a>");
                return;
            }
        } catch (NumberFormatException e) {
            out.println("<p>잘못된 공지사항 번호입니다.</p>");
            out.println("<a href='CA01.jsp'>목록으로 돌아가기</a>");
            return;
        } catch (Exception e) {
            out.println("<p>공지사항을 조회하는 중 오류가 발생했습니다.</p>");
            out.println("<a href='CA01.jsp'>목록으로 돌아가기</a>");
            return;
        }
    } else {
        out.println("<p>공지사항 번호가 지정되지 않았습니다.</p>");
        out.println("<a href='CA01.jsp'>목록으로 돌아가기</a>");
        return;
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>공지사항 삭제</title>
    
    <!-- CSS 및 아이콘 파일 추가 -->
    <link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/css/nice-select.min.css" />
    <link href="css/font-awesome.min.css" rel="stylesheet" />
    <link href="css/style.css" rel="stylesheet" />
    
<style>
    body {
        font-family: 'Poppins', sans-serif;
        background-color: #ffffff; /* 전체 배경을 흰색으로 설정 */
        color: #003366; /* 글자 색상 군청색 */
    }

    .message-container {
        width: 60%;
        margin: 80px auto;
        text-align: center;
        padding: 30px;
        background-color: #ffffff; /* 창 바탕을 흰색으로 설정 */
        border-radius: 10px;
        border: 1px solid #ced4da; /* 테두리 추가 */
        box-shadow: none; /* 그림자 제거 */
    }

    .message-container h2 {
        font-size: 28px;
        font-weight: 600;
        color: #003366; /* 제목 색상 군청색 */
        margin-bottom: 20px;
    }

    .message-container p {
        font-size: 18px;
        color: #003366; /* 본문 색상 군청색 */
        margin-bottom: 30px;
    }

    .button-group {
        margin-top: 20px;
        display: flex;
        justify-content: center;
    }

    .button-group a {
        text-decoration: none;
        padding: 10px 30px;
        font-size: 16px;
        border-radius: 8px;
        margin: 0 10px;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        background-color: #ff8000; /* 버튼 배경색 주황색 */
        color: white;
        border: 1px solid #ff8000;
        transition: all 0.3s ease;
    }

    .button-group a:hover {
        background-color: transparent; /* 호버 시 배경 투명 */
        color: #ff8000; /* 호버 시 글자 주황색 */
        border: 2px solid #ff8000; /* 테두리 주황색 */
        transform: scale(1.1); /* 호버 시 크기 살짝 증가 */
    }

    /* 헤더 스타일 */
    .header_section {
        background: linear-gradient(135deg, #003366, #0056b3);
        padding: 10px 0;
    }

    .contact_nav a {
        color: #fff;
        margin-right: 15px;
    }

    .contact_nav a:hover {
        color: #ffefba;
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
        z-index: 0; /* 다른 요소 위에 표시되도록 설정 */
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
  
<div class="message-container">
    <h2>공지사항 삭제</h2>
    <p>공지사항을 삭제하시겠습니까?</p>
    <div class="button-group">
        <a href="DeleteNoticeServlet?num=<%= notice.getNum() %>" class="delete-btn">삭제</a>
        <a href="CA01.jsp" class="cancel-btn">취소</a>
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
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/js/jquery.nice-select.min.js"></script>
  <script src="js/custom.js"></script>
</body>
</html>
