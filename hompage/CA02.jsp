<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="common.Notice, common.NoticeDao, common.EmpUser" %>
<%@ page session="true" %>

<%
    // 세션에서 user 객체 가져오기
    EmpUser loginUser = (EmpUser) session.getAttribute("loginUser");

    // 공지사항 번호와 검색어 가져오기
    String numStr = request.getParameter("num");
    String searchKeyword = request.getParameter("searchKeyword"); // 검색어 가져오기

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
<html>
<head>
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
  <title>공지사항 확인</title>
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
        color: #003366;
    }
    
    .form-container {
        width: 70%;
        margin: 50px auto;
        padding: 30px;
        background-color: #ffffff;
        border-radius: 10px;
        border: 1px solid #ced4da;
    }

    h2 {
        font-size: 28px;
        font-weight: bold;
        color: #003366;
        text-align: center;
        margin-bottom: 10px;
    }

    .info-text {
        text-align: center;
        font-size: 18px;
        margin-bottom: 20px;
        color: #666;
    }

    .form-group {
        margin-bottom: 20px;
    }

    label {
        font-weight: bold;
        margin-bottom: 5px;
        display: block;
        color: #003366;
    }

    input[type="text"], textarea {
        width: 100%;
        padding: 15px;
        border: 1px solid #ced4da;
        border-radius: 5px;
        font-size: 16px;
    }

    textarea {
        height: 300px;
    }

    .additional-info {
        display: flex;
        justify-content: right;
        margin-top: 10px;
        font-size: 14px;
        color: #666;
    }

    .button-group {
        display: flex;
        justify-content: flex-end;
        gap: 10px;
        margin-top: 20px;
    }

    .button-group a {
        background-color: #FF6600;
        color: white;
        padding: 8px 15px;
        border: none;
        border-radius: 5px;
        font-size: 14px;
        text-decoration: none;
        transition: background-color 0.3s ease, color 0.3s ease, transform 0.3s ease;
    }

    .button-group a:hover {
        background-color: transparent;
        color: #FF6600;
        transform: scale(1.05);
        border: 2px solid #FF6600;
    }

    .header_section {
        background: linear-gradient(135deg, #003366, #0056b3);
        padding: 10px 0;
    }

    .contact_nav a {
        color: #fff;
    }

    .contact_nav a:hover {
        color: #ffefba;
    }

    .footer_section {
        position: bottom;
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
          <nav class="navbar navbar-expand-lg custom_nav-container ">
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
              <ul class="navbar-nav">
                <li class="nav-item active">
                  <a class="nav-link" href="main.jsp"><span><img src="images/logo.png" alt="logo" width = "77px"height="37px"></span></a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="A01.jsp">회사소개</a>
                </li>
                <!-- 공지사항 링크 -->
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
  
    <div class="form-container">
        <h2>공지사항 확인</h2>
        <br>
        <p class="info-text">알고리듬의 소식을 확인해보세요</p>
        
        <div class="form-group">
            <label for="title">제목:</label>
            <input type="text" id="title" name="title" value="<%= notice.getTitle() %>" readonly>
        </div>

        <div class="additional-info">
            <span>작성자: <%= notice.getEmpId() %></span>&nbsp;&nbsp;&nbsp;
            <span>작성일자: <%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(notice.getCreatedAt()) %></span>
        </div>

        <div class="form-group">
            <label for="content">내용:</label>
            <textarea id="content" name="content" rows="5" readonly><%= notice.getContent() %></textarea>
        </div>

        <div class="button-group">
            <% if (loginUser != null && notice.getEmpId().equals(loginUser.getEmp_id())) { %> <!-- 로그인한 사용자에게만 편집 버튼 보이기 -->
				<a href="CA04.jsp?num=<%= notice.getNum() %>&searchKeyword=<%= searchKeyword %>" class="btn btn-primary">편집</a> <!-- 검색어 값 추가 -->
            <% } %>
            
            <% if (searchKeyword != null && !searchKeyword.trim().isEmpty() && !"null".equals(searchKeyword)) { %> <!-- 검색어가 있을 경우에만 '검색목록으로' 버튼 표시 -->
                <a href="CA01.jsp?searchKeyword=<%= searchKeyword %>" class="btn btn-secondary">검색한 목록으로</a>
            <% } %>

            <a href="CA01.jsp" class="btn btn-secondary">목록으로</a> <!-- 목록으로 버튼 -->
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
