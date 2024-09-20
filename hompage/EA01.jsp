<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 세션에서 user 객체 가져오기
    Object user = session.getAttribute("user");
%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.*"%>
<%@page import="common.IntroDao, common.Intro, common.IntroList" %>
<%@page import="java.util.List" %>

<%
	IntroDao introDao = new IntroDao();  // NoticeDao 객체 생성


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


    List<Intro> introList = introDao.getIntroByPage(currentPage, pageSize);
    int totalIntroCount = introDao.getTotalIntroCount();
    int totalPages = (int) Math.ceil((double) totalIntroCount / pageSize);
%>

<!DOCTYPE html>
<html>

<head>
  <!-- Basic -->
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <!-- Mobile Metas -->
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
  <!-- Site Metas -->
  <meta name="keywords" content="" />
  <meta name="description" content="" />
  <meta name="author" content="" />

  <title>문의 내역</title>
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

  <!-- bootstrap core css -->
  <link rel="stylesheet" type="text/css" href="css/bootstrap.css" />

  <!-- fonts style -->
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
  <!--owl slider stylesheet -->
  <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css" />
  <!-- nice select -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/css/nice-select.min.css" integrity="sha256-mLBIhmBvigTFWPSCtvdu6a76T+3Xyt+K571hupeFLg4=" crossorigin="anonymous" />
  <!-- font awesome style -->
  <link href="css/font-awesome.min.css" rel="stylesheet" />

  <!-- Custom styles for this template -->
  <link href="css/style.css" rel="stylesheet" />
  <!-- responsive style -->
  <link href="css/responsive.css" rel="stylesheet" />
</head>

<body class="sub_page">
  <div class="hero_area">
    <!-- header section strats -->
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
    <!-- Sidebar -->
    <div class="sidebar">
      <div class="menu-title">마이 메뉴</div>
      <div class="menu-item">
        <a href="DA01.jsp"><i class="fa fa-user-edit"></i> 정보 수정</a>
      </div>
      <div class="menu-item">
        <a href="DA01.jsp"><i class="fa fa-envelope"></i> 문의 내역</a>
      </div>
    </div>
    
  <!-- service section -->

  <section class="service_section layout_padding">
    <div class="content ">
      <div class="heading_container heading_center">
        <h2>문의내역</h2>
        <br>
        <br>

      
        
      <title>게시판 리스트</title>
        <link rel ="stylesheet" href="/test/css/bootstrap.css">
    </head>

        <div class = "container">
            <table class = "table table-hover">
                <thead>
                    <tr>
                        <!--게시판 속성-->
                        <th>No.</th>
                        <th>성함</th>
                        <th>이메일</th>
                        <th>핸드폰</th>
                        <th>기관명</th>
                        <th>데이터 종류</th>
                        <th>상담유형</th>
                        <th>방문경로</th>
                        <th>일시</th>
                    </tr>
                </thead>
                <script>
				    // 행을 클릭하면 해당 href 링크로 이동하는 함수
				    function goToDetailPage(num) {
				        window.location.href = "EA02.jsp?num=" + num;
				    }
				</script>
				               
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
            <hr/>
           
        

        	</div>
      
      
    	</div>
    </div>
  </section>
  
  <!-- end service section -->



  <!-- jQery -->
  <script src="js/jquery-3.4.1.min.js"></script>
  <!-- popper js -->
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
  <!-- bootstrap js -->
  <script src="js/bootstrap.js"></script>
  <!-- owl slider -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>
  <!--  OwlCarousel 2 - Filter -->
  <script src="https://huynhhuynh.github.io/owlcarousel2-filter/dist/owlcarousel2-filter.min.js"></script>
  <!-- nice select -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/js/jquery.nice-select.min.js" integrity="sha256-Zr3vByTlMGQhvMfgkQ5BtWRSKBGa2QlspKYJnkjZTmo=" crossorigin="anonymous"></script>
  <!-- custom js -->
  <script src="js/custom.js"></script>
  <!-- Google Map -->
  <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCh39n5U-4IoWpsVGUHWdqB6puEkhRLdmI&callback=myMap"></script>
  <!-- End Google Map -->

</body>

</html>