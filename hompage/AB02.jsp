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
  
  <style>
  	
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


	<!-- ana_detail section -->

	<section class="portfolio_section layout_padding">
		<div class="container">
			<div class="row">
				<div class="col-md-10 ">
					<div class="detail-box">
						<div class="heading_container heading_center">
							<br>
							<h2>열처리 : 예지보전</h2>
						</div>
            <div class = "content_cat">
            <div class = "content_cat_1">
              <p class="p1">
							  주요 키워드
						</p>
              <p class = "p2">
                AI 학습데이터, 텍스트 데이터 
              </p>
            </div>
            <div class = "content_cat_2">
              <p class="p1">
							  주제
						  </p>
              <p class = "p2">
                열처리 : 품질보증 
              </p>
            </div>
            <div class = "content_cat_3">
              <p class="p1">
							  데이터 종류
						  </p>
              <p class = "p2">
                텍스트
              </p>
            </div>
          </div>
          
          <div class="empty_box">
            <p>데이터 개요</p>
          </div>
          <div class="content_detail">	
            <p class="p1">소개</p>
            <p class="p2">소개 텍스트</p>
          </div>
          <div class="content_detail">	
            <p class="p1">구축 목적</p>
            <p class="p2">구축 목적 텍스트</p>
          </div>
          <div class="empty_box">
            <p>메타데이터 구조표</p>
          </div>
          <div class="content_detail">	
            <div class="sel1">
              <p class="p1">데이터 영역</p>
            </div>
            <div class="sel2">
              <p class="p2">내용</p>
            </div>
            <div class="sel1">
              <p class="p1">데이터 유형</p>
            </div>
            <div class="sel2">
              <p class="p2">내용</p>
            </div>
            <div class="sel1">
              <p class="p1">데이터 형식</p>
            </div>
            <div class="sel2">
              <p class="p2">내용</p>
            </div>
            <div class="sel1">
              <p class="p1">데이터 출처</p>
            </div>
            <div class="sel2">
              <p class="p2">내용</p>
            </div>
            <div class="sel1">
              <p class="p1">라벨링 유형</p>
            </div>
            <div class="sel2">
              <p class="p2">내용</p>
            </div>
            <div class="sel1">
              <p class="p1">라벨링 형식</p>
            </div>
            <div class="sel2">
              <p class="p2">내용</p>
            </div>
          </div>
          
          <div class="empty_box">
            <p>데이터 분석</p>
          </div>
          <div class="content_detail2">	
            <div class='object-box'>
              <!-- <div class="img-box"> -->
                <img src="./images/jj_qc.png" alt="분석 이미지" />
              <!-- </div> -->
            </div>
            <div style="display: inline-block; width: 450px; margin-right: 30px;">
            <div class="sel3">
              <p class="p1">데이터 구조</p>
              <p class="p2">데이터 구조 텍스트</p>
            </div>
            <div class="sel3">
              <p class="p1">분석 모델</p>
              <p class="p2">분석 모델 텍스트</p>
            </div>
            <div class="sel3">
              <p class="p1">모델 성능</p>
              <p class="p2">모델 성능 텍스트</p>
            </div>
          </div>
          </div>

        </div>
				</div>
			</div>
		</div>
		</div>
	</section>
	<!-- end ana_detail section -->





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
  <!-- Google Map -->
  <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCh39n5U-4IoWpsVGUHWdqB6puEkhRLdmI&callback=myMap"></script>
  <!-- End Google Map -->

</body>

</html>