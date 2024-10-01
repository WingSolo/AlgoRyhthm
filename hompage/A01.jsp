<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 세션에서 user 객체 가져오기
    Object loginUser = session.getAttribute("loginUser");
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

  <title>분석사례</title>

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
    
<style >
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
  		z-index: 1000; /* 다른 요소 위에 표시되도록 설정 */
		}

</style>  
  
</head>

<body class="sub_page">
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
                    <a class="nav-link" href="CA01.jsp">공지사항</a> <!-- 비로그인 시 CA01.jsp로 이동 -->
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
  </div>


<!-- about section -->

	<section class="about_section layout_padding">
            
            <!-- header -->
						<div class="heading_container">
							<br>
							<h2>A L G O R H Y T H N M</h2>
						</div>
            
            <!-- symbol -->
						<div class="content_image">
              <img src="./images/logo_about.png" />
            </div>
            
            <!-- content -->
            <div class="content_text">
              <h5>ALGORHYTHNM은</h5>
              <h5>알고리즘과 리듬을 합친 단어입니다</h5>
            </div>
            <div class="content_text">
              <h5>즐긴다는 마음으로 분석에 임하여</h5>
              <h5>최상의 결과를 전달드리겠습니다</h5>
            </div>
            <div class="work">
              <div class="empty_box">
                The Data Analysis Company
              </div>
            </div>
            <div class="work">
              <div class="work_box">
                <div class="work_header">
                  AI Solution
                </div>
                <div class="work_detail_box">
                  <p class="work_detail">데이터를 제공받아 분석</p>
                  <p class="work_detail">AI 모델을 통한 예측</p>
                  <a href="BA02.jsp" class="contact">
                    문의하기
                  </a>
                </div>
                <div class="work_header">
                  분석 모델
                </div>
                <div class="work_detail_box">
                  <p class="work_detail">기존 분석모델 제공</p>
                  <a href="BA01.jsp" class="contact">
                    분석하기
                  </a>
                </div>
              </div>
              <div class = "work_image">
                <img src="./images/about_work.png" />
              </div>
            </div>
            <div class="work">
              <div class="empty_box">
                찾아오시는 길
              </div>
            </div>        
            <div class="work" style="text-align: left; align-items: left; justify-content: left; width: 1000px;">
              <div class='object-box'>
                <div class="map_container">
                  <div class="map">
                    <div id="googleMap"><iframe
                        src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d2245.8285395758935!2d127.05558188916838!3d37.245781361841814!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357b4577c52730e5%3A0xc81558c592577761!2z66ed7Y-s7Jet7IS87YOA7ZSE65287J6Q!5e0!3m2!1sko!2skr!4v1724628930044!5m2!1sko!2skr"
                        width="600" height="370" style="border:0;" allowfullscreen="" loading="lazy"
                        referrerpolicy="no-referrer-when-downgrade"></iframe>
                    </div>
                  </div>
                </div>
              </div>
              <div class="work_detail_box2">
                <p class="work_detail2">업체명 &nbsp;: &nbsp;ALGORHYTHNM</p>
                <p class="work_detail2">주소 &nbsp;: &nbsp;경기도 &nbsp;수원시 &nbsp;영통구 &nbsp;영통동 &nbsp;977-4 </p>
              </div>
            </div>
            </section>
	<!-- end about section -->


  <!-- footer section -->
  <footer class="footer_section">
    <div class="container">
      <p>
        &copy; <span id="displayYear"></span> All Rights Reserved By
        <a href="main.html">AlgoRhythm</a>
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

</body>

</html>