<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="common.IntroDao, common.Intro" %>
<%@ page session="true" %> <!-- 세션 활성화 -->

<%
    // 공지사항 번호 파라미터 가져오기
    String numStr = request.getParameter("num");
    Intro intro = null;

    if (numStr != null && !numStr.isEmpty()) {
        try {
            int num = Integer.parseInt(numStr); // 문자열을 정수로 변환
            IntroDao introDao = new IntroDao();
            intro = introDao.getIntroByNum(num);  // 공지사항 번호로 조회

            if (intro == null) {
                out.println("<p>해당 번호의 공지사항이 존재하지 않습니다.</p>");
                out.println("<a href='EA01.jsp'>목록으로 돌아가기</a>");
                return; // 이후 코드 실행 방지
            }
        } catch (NumberFormatException e) {
            out.println("<p>잘못된 번호입니다.</p>");
            out.println("<a href='EA01.jsp'>목록으로 돌아가기</a>");
            return; // 이후 코드 실행 방지
        } catch (Exception e) {
            out.println("<p>공지사항을 조회하는 중 오류가 발생했습니다.</p>");
            out.println("<a href='EA01.jsp'>목록으로 돌아가기</a>");
            return; // 이후 코드 실행 방지
        }
    } else {
        out.println("<p>공지사항 번호가 지정되지 않았습니다.</p>");
        out.println("<a href='EA01.jsp'>목록으로 돌아가기</a>");
        return; // 이후 코드 실행 방지
    }

    // 세션에서 로그인 사용자 정보 가져오기
    Object loginUser = session.getAttribute("loginUser");
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>공지사항 확인</title>
    
    <!-- Styles -->
    <link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/css/nice-select.min.css" />
    <link href="css/font-awesome.min.css" rel="stylesheet" />
    <link href="css/style.css" rel="stylesheet" />
    <link href="css/responsive.css" rel="stylesheet" />

    <style>
        /* 공지사항 컨테이너 */
        .notice-container {
            width: 80%;
            margin: 0px auto;
            padding: 20px;
        }
        .notice-header {
            text-align: center;
            font-size: 24px;
            font-weight: bold;
            margin-top: 20px;
        }
        .notice-content {
            margin: 20px 0;
        }
        .button-group {
            text-align: center;
            margin-top: 20px;
        }
        .button-group a {
            margin: 0 10px;
            text-decoration: none;
            padding: 8px 16px;
            border: 1px solid #ddd;
        }
        /* 전체 컨테이너 */
        .container01 {
            max-width: 1600px;
            margin: 30px auto;
            padding: 20px;
            display: flex;
            justify-content: space-between;
            gap: 100px;
        }
        /* 사이드바 */
        .sidebar {
            width: 15%;
            background: linear-gradient(135deg, #f9f9f9, #d0e1ff);
            padding: 20px;
            border-radius: 10px;
        }
        .content {
            width: 70%;
            text-align: center;
            padding: 20px;
            background-color: #fff;
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
        /* 하단 고정 푸터 */
        .footer_section {
            position: fixed;
            bottom: 0;
            left: 0;
            width: 100%;
            color: blue;
            text-align: center;
            padding: 5px 0;
            background-color: transparent;
            z-index: 1000;
        }
    </style>
</head>

<body class="sub_page">
    <div class="hero_area">
        <!-- 헤더 영역 -->
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
    </div>

    <div class="container01">
        <!-- 왼쪽 메뉴 섹션 -->
        <div class="sidebar">
            <div class="menu-title">마이 메뉴</div>
            <div class="menu-item"><a href="DA01.jsp">✏️ 정보 수정</a></div>
            <div class="menu-item"><a href="EA01.jsp"><i class="fa fa-envelope"></i> 문의 내역</a></div>
        </div>

        <!-- 공지사항 내용 섹션 -->
    <div class="notice-container">
        <h2>공지사항 상세 내용</h2>
        <table class="table table-bordered">
            <tr>
                <th>작성자:</th>
                <td><%= intro.getCust_name() %></td>
            </tr>
            <tr>
                <th>작성 일자:</th>
                <td><%= intro.getTime() %></td>
            </tr>
            <tr>
                <th>Email:</th>
                <td><%= intro.getEmail() %></td>
            </tr>
            <tr>
                <th>연락처:</th>
                <td><%= intro.getPhone() %></td>
            </tr>
            <tr>
                <th>기관명:</th>
                <td><%= intro.getComp_name() %></td>
            </tr>
            <tr>
                <th>데이터 유형:</th>
                <td><%= intro.getData_type() %></td>
            </tr>
            <tr>
                <th>상담 유형:</th>
                <td><%= intro.getCoun_type() %></td>
            </tr>
            <tr>
                <th>상담 내용:</th>
                <td><%= intro.getContent() %></td>
            </tr>
        </table>
        <a href="EA01.jsp">뒤로 가기</a>
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
</body>
</html>
