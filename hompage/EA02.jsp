<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="common.IntroDao, common.Intro, common.IntroList" %>
<%@page import="java.util.List" %>
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
        /* 기존 스타일 유지 */
    .container01 {
        max-width: 1000px;
        margin: 40px auto;
        padding: 20px;
        display: flex;
        justify-content: space-between; /* 양쪽에 균형 맞추기 */
        gap: 20px;
    }
    .sidebar {
        width: 30%;
        background-color: #f0f0f0;
        padding: 20px;
        border-radius: 10px; /* 둥근 모서리 */
    }
   
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

    <body>
   
        <div class ="container">
            <table class ="table table-bordered">
                <thead>
                   
                </thead>
        <%

    // 공지사항 번호 가져오기
    String numStr = request.getParameter("num");
    Intro intro = null;

    if (numStr != null && !numStr.isEmpty()) {
        try {
            int num = Integer.parseInt(numStr); // 문자열을 정수로 변환

            // NoticeDao 객체를 사용하여 데이터베이스에서 공지사항 조회
            IntroDao introDao = new IntroDao();
            intro = introDao.getIntroByNum(num);  // 공지사항 번호로 조회

            if (intro == null) {
                out.println("<p>해당 번호의 목록이 존재하지 않습니다.</p>");
                out.println("<a href=' EA01.jsp'>목록으로 돌아가기</a>");
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
%>
                    <tr>
                        <th>작성자 : </th>
                        <td><%= intro.getCust_name() %></td>
                    </tr>
                    <tr>
                        <th>작성 일자 : </th>
                        <td><%= intro.getTime() %></td>
                    </tr>
                    <tr>    
                        <th>email : </th>
                        <td><%= intro.getEmail() %></td>

                    </tr>
                    <tr>
                        <th>연락처 : </th>
                        <td><%= intro.getPhone() %></td>

                    </tr>
                    <tr>
                        <th>기관명 : </th>
                        <td><%= intro.getComp_name() %></td>

                    </tr>
                    <tr>
                        <th>데이터 유형 : </th>
                         <td><%= intro.getData_type() %></td>

                    </tr>
                    <tr>
                        <th>상담 유형 : </th>
                        <td><%= intro.getCoun_type() %></td>
                    </tr>        
                    <tr>
                        <th>상담 내용: </th>
                        <td><%= intro.getContent() %></td> 
                    </tr>        
                </tbody>
                
            </table>
            <a href='EA01.jsp'>뒤로 가기</a>
            
        </div>
    </body>
</html>