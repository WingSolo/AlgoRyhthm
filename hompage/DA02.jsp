<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="common.EmpUser, common.EmpUserDao" %>
<%@ page session="true" %> <!-- 세션 활성화 -->

<%
    // 로그인된 사용자 정보 가져오기
    EmpUser loginUser = (EmpUser) session.getAttribute("loginUser");
    if (loginUser == null) { // 로그인이 안 된 상태일 경우
        response.sendRedirect("login.jsp"); // 로그인 페이지로 리디렉션
        return;
    }

    // 사용자 정보를 DB에서 불러오기
    EmpUserDao userDao = new EmpUserDao();
    EmpUser userInfo = userDao.getEmpUserById(loginUser.getEmp_id());
%>

<!DOCTYPE html>
<html>
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
    /* 전체 컨테이너 */
    .container01 {
        max-width: 900px;
        margin: 40px auto;
        padding: 20px;
        display: flex;
        justify-content: space-between;
        gap: 40px;
    }

    /* 사이드바 */
    .sidebar {
        width: 25%;
        background: linear-gradient(135deg, #f9f9f9, #d0e1ff); /* 그라데이션 추가 */
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

    /* 콘텐츠 섹션 */
    .content {
        width: 70%;
        background: linear-gradient(135deg, #007bff, #00c6ff); /* 그라데이션 추가 */
        padding: 40px;
        border-radius: 10px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        color: white;
    }

    .content h2 {
        font-size: 24px;
        font-weight: bold;
        margin-bottom: 20px;
        color: #ffffff;
    }

    .form-group {
        margin-bottom: 15px;
        text-align: left;
    }

    .form-group label {
        display: block;
        margin-bottom: 5px;
        font-weight: bold;
        color: white;
    }

    .form-group input {
        width: 100%;
        padding: 10px;
        border-radius: 5px;
        border: 1px solid #ccc;
    }

    .button-container01 {
        text-align: center;
        margin-top: 20px;
    }

    button {
        padding: 10px 20px;
        border: none;
        border-radius: 5px;
        background-color: #ffffff;
        color: #007bff;
        cursor: pointer;
        margin-right: 10px;
    }

    button:hover {
        background-color: #e0e0e0;
    }

    button[type="button"] {
        background-color: #ffffff;
    }

    button[type="button"]:hover {
        background-color: #e0e0e0;
    }
    
                    /* footer 고정 및 상하 여백을 줄이는 스타일 */
 		 .footer_section {
     		 position: fixed;
    		  bottom: 0;
    		  left: 0;
    		  width: 100%;
    		  background-color: #ffffff; /* 배경색 */
    		  color: blue; /* 텍스트 색상 */
    		  text-align: center;
    		  padding: 5px 0; /* 상하 패딩을 작게 설정 */
    		  box-shadow: 0 -2px 5px rgba(0, 0, 0, 0.1); /* 살짝 그림자 효과 */
    		  z-index: 1000; /* 푸터가 다른 요소 위에 표시되도록 설정 */
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
            <% if (loginUser != null) { %>
              <a href="logout.jsp"><i class="fa fa-sign-out" aria-hidden="true"></i><span> 로그아웃</span></a>
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
      <div class="menu-title">마이페이지</div>
      <div class="menu-item">
        <a href="DA02.jsp"><i class="fa fa-user-edit"></i> 정보 수정</a>
      </div>
      <div class="menu-item">
        <a href="EA01.jsp"><i class="fa fa-envelope"></i> 문의 내역</a>
      </div>
    </div>

    <!-- Content -->
    <div class="content">
      <h2>회원 정보 수정</h2>
      <form action="UpdatePasswordServlet" method="post">
        <div class="form-group">
          <label for="newPassword">새 비밀번호</label>
          <input type="password" id="newPassword" name="newPassword" placeholder="영문 대소문자, 숫자, 특수문자 조합 8글자 이상" required>
        </div>
        <div class="form-group">
          <label for="confirmPassword">비밀번호 확인</label>
          <input type="password" id="confirmPassword" name="confirmPassword" placeholder="비밀번호 확인" required>
        </div>
        
        <!-- 읽기 전용 사용자 정보 -->
        <div class="form-group">
          <label for="name">이름</label>
          <input type="text" id="name" value="<%= userInfo.getEmp_name() %>" readonly>
        </div>
        <div class="form-group">
          <label for="email">이메일</label>
          <input type="text" id="email" value="<%= userInfo.getEmail() %>" readonly>
        </div>
        <div class="form-group">
          <label for="phone">전화번호</label>
          <input type="text" id="phone" value="<%= userInfo.getPhone() %>" readonly>
        </div>
        <div class="form-group">
          <label for="department">소속기관명</label>
          <input type="text" id="department" value="<%= userInfo.getUser_dept() %>" readonly>
        </div>
        <div class="form-group">
          <label for="position">부서</label>
          <input type="text" id="position" value="<%= userInfo.getUser_pos() %>" readonly>
        </div>

        <div class="button-container01">
          <button type="submit">회원정보 수정</button>
          <button type="button" onclick="location.href='Main.jsp'">취소</button>
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
