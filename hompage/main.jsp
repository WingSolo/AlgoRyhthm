<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="common.Notice, common.NoticeDao" %>
<%@ page import="java.util.List" %>
<%
    // 세션에서 user 객체 가져오기
    Object loginUser = session.getAttribute("loginUser");
%>
<%
    // 공지사항 데이터를 가져오기 위한 NoticeDao 인스턴스 생성
    NoticeDao noticeDao = new NoticeDao();
    // 최근 5개의 공지사항만 표시
    List<Notice> recentNotices = noticeDao.getRecentNotices(5);
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

  <title>홈</title>

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
  	<style>
     .hero_area {
        display: flex;
        flex-direction: column;
        min-height: 100vh;
        position: relative;
    }

    .notice-section {
        position: absolute;
        bottom: 23%; /* 아래쪽에 배치 */
        left:42%; /* 오른쪽에 배치 */
        background-color: rgba(255, 255, 255, 0.9);
        padding: 15px;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        width: 400px;
        z-index: 1000;
    }

    .notice-section h3 {
        text-align: center;
        font-size: 18px;
        margin-bottom: 10px;
        color: #003366;
    }

    .notice-section ul {
        list-style-type: decimal;
        padding-left: 20px;
        margin: 0;
    }

    .notice-section ul li {
        margin-bottom: 10px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .notice-section ul li a {
        font-size: 14px;
        color: #007bff;
        text-decoration: none;
        flex-grow: 1;
    }

    .notice-section ul li a:hover {
        text-decoration: underline;
    }

    .notice-section .notice-date {
        font-size: 12px;
        color: #666;
        white-space: nowrap;
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
  			z-index: 0; /* 다른 요소 하위에 표시되도록 설정 */
			}
  </style>
</head>

<body>
  <div class="hero_area">
    <!-- header section strats -->
    <header class="header_section">
      <div class="header_top">
        <div class="container-fluid header_top_container">
          
          <div class="contact_nav">
            <a href="A01.jsp">
              <i class="fa fa-map-marker" aria-hidden="true"></i>
              <span>
                Location
              </span>
            </a>
            <a href="BA02.jsp">
              <i class="fa fa-phone" aria-hidden="true"></i>
              <span>
                전화번호 : 031-224-3636
              </span>
            </a>
            <a href="BA02.jsp">
              <i class="fa fa-envelope" aria-hidden="true"></i>
              <span>
                Algo@gmail.com
              </span>
            </a>
            <!-- Display "로그아웃" if the user is logged in, otherwise "관리자" -->
            <% if (loginUser != null) { %>
              <a href="logout.jsp">
                <i class="fa fa-sign-out" aria-hidden="true"></i>
                <span>로그아웃</span>
              </a>
            <% } else { %>
              <a href="login.jsp">
                <i class="fa fa-user" aria-hidden="true"></i>
                <span>관리자</span>
              </a>
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
                
                <!-- 공지사항 링크-->
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
                <!-- Show "마이페이지" next to "공지사항" if the user is logged in -->
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
    <!-- slider section -->
    <section class="slider_section ">
      <div id="customCarousel1" class="carousel slide" data-ride="carousel">
        <div class="carousel-inner">
          <div class="carousel-item active">
            <div class="container ">
              <div class="detail-box">
                <h1 style = "line-height : 60px">
                  Data Analysis <br />
                  ALGORHYTHNM<br/>
                </h1>
                <h4 style = "margin-top : 20px; color : white; font-weight : bold;">데이터 분석 기업</h4>
                
                <div class="btn-box">
                  <a href="A01.jsp" class="btn1">
                    회사소개
                  </a>
                  <a href="BA02.jsp" class="btn2">
                    문의하기
                  </a>
                </div>
              </div>

              
            </div>
          </div>

          </div>
        </div>
    </section>
    <!-- end slider section -->
        <!-- 공지사항 섹션 -->
	<span class="notice-section" style="opacity: 1.0; margin-right: 25%; margin-bottom: 1%">
    	<h3 style="margin-bottom: 10px; font-weight: bold;">최근 공지사항</h3>
    	<table style="width: 100%; border-collapse: collapse; background-color: transparent;">
       		<thead>
            	<tr style="background-color: transparent; color: #003366; text-align: center;">
                	<th style="padding: 10px; text-align: center;">No.</th>
                	<th style="padding: 10px; text-align: center;">Title</th>
                	<th style="padding: 10px; text-align: center;">Date</th>
            	</tr>
        	</thead>
        		<tbody>
            	<% if (recentNotices != null && !recentNotices.isEmpty()) { %>
                	<% int count = 1; %>
                	<% for (Notice notice : recentNotices) { %>
                    	<tr style="color: <%= (count == 1) ? "black" : "gray" %>; font-size: 14px ; ">
                        	<td style="padding: 10px; text-align: center;
                        	font-weight : <%= (count == 1) ? "bold" : "normal"%>"><%= count %></td>
							
							<td style="padding: 10px; color: inherit;">
							    <a href="CA02.jsp?num=<%= notice.getNum() %>" style="color: inherit; text-decoration: none;
							    font-weight : <%= (count == 1) ? "bold" : "normal"%>">
							        <%= (notice.getTitle().length() > 10) ? notice.getTitle().substring(0, 10) + "..." : notice.getTitle() %>
							    </a>
							</td>

                        	<td style="padding: 10px; text-align: center; color: inherit;
                        	font-weight : <%= (count == 1) ? "bold" : "normal"%>">
                            	<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(notice.getCreatedAt()) %>
                        	</td>
                    	</tr>
                    	<% count++; %>
                	<% } %>
            	<% } else { %>
                	<tr>
                    	<td colspan="3" style="padding: 10px; text-align: center; color: #003366;">공지사항이 없습니다.</td>
                	</tr>
            	<% } %>
        	</tbody>
    	</table>
	</span>

  </div>




  <!-- footer section -->
  <footer class="footer_section">
    <div class="container">
      <p>
        &copy; <span id="displayYear"></span> All Rights Reserved By
        <a href="main.jsp">AlgoRhythm</a>
      </p>
    </div>
  </footer>
  <!-- footer section -->

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
  <!-- End Google Map -->

</body>

</html>
