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


	<!-- ana_detail section -->

	<section class="portfolio_section layout_padding">
		<div class="container">
			<div class="row">
				<div class="col-md-10 ">
					<div class="detail-box">
						<div class="heading_container heading_center">
							<br>
							<h2>열처리 : 공정최적화</h2>
						</div>
            <div class = "content_cat">
            <div class = "content_cat_1">
              <p class="p1">
							  주요 키워드
						</p>
              <p class = "p2">
                AI 학습데이터, 열처리, 데이터 분석
              </p>
            </div>
            <div class = "content_cat_2">
              <p class="p1">
							  주제
						  </p>
              <p class = "p2">
                열처리 : 공정최적화 
              </p>
            </div>
            <div class = "content_cat_3">
              <p class="p1">
							  데이터 종류
						  </p>
              <p class="p2">
				  <span class="tooltip-container">텍스트(.csv)
				    <span class="tooltip-text">쉼표(,)로 구분한 텍스트 데이터 및 텍스트 파일이다.</span>
				  </span>
				</p>
            </div>
          </div>
          
          <div class="empty_box">
            <p>데이터 개요</p>
          </div>
          <div class="content_detail">	
            <p class="p1">소개</p>
            <p class="p2">- 제조분야 : 뿌리(열처리)</p>
            <p class="p2">- 제조 공정명 : 열처리 공정최적화</p>
            <p class="p2">- 수집 장비 : 열처리의 소입로, 건조로 등 주요 존의 데이터 확보</p>
          </div>
          <div class="content_detail">	
            <p class="p1">구축 목적</p>
            <p class="p2">
            열처리 공정에서 발생하는 품질문제와 공정 데이터들을 분석하여  
            </p>
            <p class="p2">
            데이터 간의 상관관계를 찾고 주요 문제별 원인 인자를 분석하여 공정 최적화 모델을 활용하여 해결하고자 한다
            </p>
          </div>
          <div class="empty_box">
            <p>메타데이터 구조표</p>
          </div>
          <div class="content_detail">	
            <div class="sel1">
              <p class="p1">데이터 영역</p>
            </div>
            <div class="sel2">
              <p class="p2">
 				열처리 공정최적화
 			  </p>
            </div>
            <div class="sel1">
              <p class="p1">데이터 유형</p>
            </div>
            <div class="sel2">
              <p class="p2">텍스트(.csv, xlsx)</p>
            </div>
            <div class="sel1">
              <p class="p1">데이터 형식</p>
            </div>
            <div class="sel2">
              <p class="p2">DataFrame</p>
            </div>
            <div class="sel1">
              <p class="p1">데이터 출처</p>
            </div>
            <div class="sel2">
              <p class="p2">스마트제조혁신추진단</p>
            </div>
            <div class="sel1">
              <p class="p1">라벨링 유형</p>
            </div>
            <div class="sel2">
              <p class="p2"> - </p>
            </div>
            <div class="sel1">
              <p class="p1">라벨링 형식</p>
            </div>
            <div class="sel2">
              <p class="p2"> - </p>
            </div>
          </div>
          
          <div class="empty_box">
            <p>데이터 분석</p>
          </div>
          <div class="content_detail2">	
			<div class='object-box'>
  				<!-- 이미지에 클릭 이벤트 추가 -->
  				<a href="./images/heat_po01.png" target="_blank" onclick="window.open(this.href,  'newwindow', 'width=1000,height=720'); return false;">
    				<img src="./images/heat_po01.png" alt="분석 이미지" right=10 width=400 height=300 />
  				</a>
  				<a href="./images/heat_po02.png" target="_blank" onclick="window.open(this.href,  'newwindow', 'width=600,height=450'); return false;">
    				<img src="./images/heat_po02.png" alt="분석 이미지" width=200 height=150  />
  				</a>
  				<span><a href="./images/heat_po03.png" target="_blank" onclick="window.open(this.href,  'newwindow', 'width=600,height=450'); return false;">
    				<img src="./images/heat_po03.png" alt="분석 이미지" width=260 height=180  />
  				</a></span>
			</div>

            <div style="display: inline-block; width: 450px; margin-right: 30px;">
            <div class="sel3">
              <p class="p1">데이터 구조</p>
              <p class="p2"> raw_total_data:총 58,794,440개 , label: 총 2,992개</p>

            </div>
            <div class="sel3">
              <p class="p1">분석 모델</p>
              <p class="p2">선형회귀(Linear Regression)</p>
            </div>
            <div class="sel3" style="height: 100%;">
              <p class="p1">모델 성능</p>
              <p class="p2" style="line-height: 10px;">선형 회귀 결정계수</p>
              <p class="p2" style="line-height: 10px;">Train R2 Score:0.295</p>
              <p class="p2" style="line-height: 10px;">Test R2 Score : 0.261</p>
              <p class="p2" style="line-height: 10px;">의사결정나무 결정 계수</p>
               <p class="p2" style="line-height: 10px;">Train R2 Score:1.0</p>
                <p class="p2" style="line-height: 10px;">Train R2 Score:-0.229</p>
              
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