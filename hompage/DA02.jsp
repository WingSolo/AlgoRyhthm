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
  <title>회원 정보 수정</title>
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
        max-width: 1600px;
        margin: 25px auto;
        padding: 20px;
        display: flex;
        justify-content: center; /* 우측 창을 가운데 정렬 */
        gap: 0; /* 좌측 창과 우측 창 사이의 간격 제거 */
    }

    /* 사이드바 */
    .sidebar {
        width: 15%;
        background: #ffffff; /* 창 배경 흰색 */
        padding: 20px;
        border-radius: 10px;
        color: #003366; /* 글자 색 군청색 */
    }

    .menu-title {
        font-size: 20px;
        font-weight: bold;
        margin-bottom: 20px;
        color: #003366; /* 메뉴 제목 글자 색 군청색 */
    }

    .menu-item {
        margin-bottom: 10px;
        font-size: 16px;
    }

    .menu-item a {
        text-decoration: none;
        color: #003366; /* 메뉴 링크 글자색 군청색 */
        display: flex;
        align-items: center;
    }

    .menu-item a:hover {
        color: #002244; /* 링크 호버 시 더 어두운 군청색 */
    }

    .menu-item i {
        margin-right: 10px;
    }

    /* 콘텐츠 섹션 */
    .content {
        width: 50%;
        background: #ffffff; /* 창 배경 흰색 */
        padding: 30px;
        border-radius: 10px;
        color: #003366; /* 글자 색 군청색 */
        margin-left: 0;
    }

    .content h2 {
        font-size: 24px;
        font-weight: bold;
        margin-bottom: 18px;
        color: #003366; /* 제목 글자 색 군청색 */
    }

    .form-group {
        margin-bottom: 15px;
        text-align: left;
    }

    .form-group label {
        display: block;
        margin-bottom: 5px;
        font-weight: bold;
        color: #003366; /* 라벨 글자 색 군청색 */
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
        background-color: #ff8000; /* 버튼 배경 주황색 */
        color: white;
        cursor: pointer;
        margin-right: 10px;
        transition: all 0.3s ease; /* 호버 시 부드럽게 변화 */
    }

    button:hover {
        background-color: transparent; /* 버튼 배경을 투명하게 변경 */
        color: #ff8000; /* 글자색을 주황색으로 변경 */
        border: 2px solid #ff8000; /* 테두리 주황색 */
        transform: scale(1.05); /* 버튼 크기 살짝 증가 */
    }

    button[type="button"] {
        background-color: #ff8000; /* 취소 버튼 배경 주황색 */
        color: white;
    }

    button[type="button"]:hover {
        background-color: transparent;
        color: #ff8000;
        border: 2px solid #ff8000;
        transform: scale(1.05);
    }

    .footer_section {
        position: bottom; /* 화면 하단에 고정 */
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
        <a href="EA01.jsp">문의 내역</a>
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
