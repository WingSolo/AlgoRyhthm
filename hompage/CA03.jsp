<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="common.EmpUser" %>
<%@ page session="true" %>

<%
    // 세션에서 user 객체 가져오기
    EmpUser loginUser = (EmpUser) session.getAttribute("loginUser");
    
    // 로그인 체크
    if (loginUser == null) {
        response.sendRedirect("login.jsp"); // 로그인 페이지로 리다이렉트
        return; // 이후 코드 실행 방지
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>공지사항 작성</title>
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
        background-color: #ffffff; /* 전체 배경을 흰색으로 설정 */
    }

    .form-container {
        width: 60%;
        margin: 50px auto;
        padding: 30px;
        background-color: #ffffff; /* 창 바탕을 흰색으로 설정 */
        border-radius: 15px;
        border: 1px solid #ced4da; /* 테두리 추가 */
        box-shadow: none; /* 그림자 제거 */
    }

    .form-container h2 {
        text-align: center;
        font-size: 28px;
        margin-bottom: 30px;
        font-weight: 600;
        color: #003366; /* 글자 색상 군청색 */
        position: relative;
    }

    .form-container h2::before {
        content: "📝";
        position: absolute;
        left: -40px;
        font-size: 32px;
    }

    .form-group {
        margin-bottom: 20px;
    }

    label {
        font-weight: bold;
        margin-bottom: 8px;
        display: block;
        color: #003366; /* 레이블 글자 색상 군청색 */
    }

    input[type="text"],
    textarea {
        width: 100%;
        padding: 15px;
        border: 1px solid #ced4da;
        border-radius: 10px;
        font-size: 16px;
        color: #495057;
        background-color: #f9fafb;
        transition: border-color 0.3s ease;
    }

    input[type="text"]:focus,
    textarea:focus {
        border-color: #003366; /* 포커스 시 군청색 테두리 */
        outline: none;
        box-shadow: 0 0 5px rgba(0, 51, 102, 0.25); /* 포커스 시 그림자 */
    }

    textarea {
        height: 200px;
    }

    .submit-btn {
        text-align: right;
        margin-top: 30px;
    }

    .submit-btn button {
        background-color: #003366; /* 버튼 색깔 군청색 */
        color: white;
        padding: 12px 25px;
        border: none;
        border-radius: 8px;
        font-size: 16px;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }

    .submit-btn button:hover {
        background-color: #002244; /* 호버 시 더 진한 군청색 */
    }

    .submit-btn a {
        background-color: #003366; /* "목록으로" 버튼 색깔 군청색 */
        color: white;
        padding: 12px 20px;
        border-radius: 8px;
        text-decoration: none;
        margin-left: 10px;
        transition: background-color 0.3s ease;
        display: inline-block;
    }

    .submit-btn a:hover {
        background-color: #002244; /* "목록으로" 버튼 호버 시 더 진한 군청색 */
    }

    .container-fluid.header_top_container {
        padding: 10px 0;
    }

    .contact_nav a {
        color: #fff;
        margin-right: 15px;
    }

    .contact_nav a:hover {
        color: #ffefba;
    }

    .header_section {
        background: linear-gradient(135deg, #003366, #0056b3); /* 헤더 그라데이션 */
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
    <!-- header section starts -->
    <div class="hero_area">
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
                                <li class="nav-item active">
                                    <a class="nav-link" href="main.jsp">홈<span class="sr-only">(current)</span></a>
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
    <!-- end header section -->

    <div class="form-container">
        <h2>공지사항 작성</h2>
        <form action="WriteNoticeServlet" method="post">
            <div class="form-group">
                <label for="emp_id">작성자 ID:</label>
                <input type="text" id="emp_id" name="emp_id" value="<%= loginUser.getEmp_id() %>" readonly>
            </div>
            <div class="form-group">
                <label for="emp_name">작성자 이름:</label>
                <input type="text" id="emp_name" name="emp_name" value="<%= loginUser.getEmp_name() %>" readonly>
            </div>
            <div class="form-group">
                <label for="title">제목:</label>
                <input type="text" id="title" name="title" required>
            </div>
            <div class="form-group">
                <label for="content">내용:</label>
                <textarea id="content" name="content" rows="5" required></textarea>
            </div>
            <div class="submit-btn">
                <button type="submit">📌 작성 완료</button>
                <a href="CA01.jsp">📋 목록으로</a>
            </div>
        </form>
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
