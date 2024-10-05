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
  
	  /* 툴팁 컨테이너 */
	  .tooltip-container {
	    position: relative;
	    display: inline-block;
	    cursor: pointer;
	  }
	
	  /* 툴팁 텍스트 스타일 */
	  .tooltip-text {
	    visibility: hidden;
	    background-color: #555;
	    color: #fff;
	    text-align: center;
	    border-radius: 5px;
	    padding: 10px;
	    position: absolute;
	    z-index: 1;
	    bottom: 125%;
	    left: 50%;
	    transform: translateX(-50%);
	    opacity: 0;
	    transition: opacity 0.3s;
	    white-space: nowrap;  /* 한 줄로 표시 */
	  }
	
	  /* 마우스를 올렸을 때 툴팁 보이게 */
	  .tooltip-container:hover .tooltip-text {
	    visibility: visible;
	    opacity: 1;
	  }
	
	  /* 삼각형 모양 화살표 추가 */
	  .tooltip-text::after {
	    content: "";
	    position: absolute;
	    top: 100%;
	    left: 50%;
	    margin-left: -5px;
	    border-width: 5px;
	    border-style: solid;
	    border-color: #555 transparent transparent transparent;
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
							<h2>열처리 : 예지보전</h2>
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
				<div class="content_cat_2">
				  <p class="p1">
				    주제
				  </p>
				  <p class="p2">
				    <a href="#" onclick="openPopup01()">열처리 : 예지보전</a> 
				  </p>
				</div>
            <div class = "content_cat_3">
              <p class="p1">데이터 종류</p>
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
            <p class="p2">- 제조분야 : 자동차 부품(에어백, 안전벨트)</p>
            <p class="p2">- 제조 공정명 : 열처리 공정</p>
			<p class="p2">
			- 수집 장비 : Manufacturing Execution System(<span class="tooltip-container">MES
			    <span class="tooltip-text">통합생산관리시스템</span>
			  </span>)
			</p>
            <p class="p2">- 수집 주기 : 배치별 사이클 타임 약 1초</p>
          </div>
          <div class="content_detail">	
            <p class="p1">구축 목적</p>
            <p class="p2">
            열처리 설비에서 발생하는 다양한 설비 데이터 분석을 통해 설비 상태를 기반으로  
            </p>
            <p class="p2">
            개별 Component나 설비의 고장이 발생할 시점을 예측하여 정비
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
 				열처리 공정 데이터
 			  </p>
            </div>
            <div class="sel1">
              <p class="p1">데이터 유형</p>
            </div>
            <div class="sel2">
              <p class="p2">텍스트(.csv)</p>
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
              <p class="p2">KAIST</p>
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
  				<a href="./images/Heat01.png" target="_blank" onclick="window.open(this.href,  'newwindow', 'width=1000,height=720'); return false;">
    				<img src="./images/Heat01.png" alt="분석 이미지" width=400 height=300 />
  				</a>
  				<a href="./images/Heat02.png" target="_blank" onclick="window.open(this.href,  'newwindow', 'width=600,height=450'); return false;">
    				<img src="./images/Heat02.png" alt="분석 이미지" width=200 height=150  />
  				</a>
  				<span><a href="./images/Heat03.png" target="_blank" onclick="window.open(this.href,  'newwindow', 'width=600,height=450'); return false;">
    				<img src="./images/Heat03.png" alt="분석 이미지" width=260 height=180  />
  				</a></span>
			</div>

            <div style="display: inline-block; width: 450px; margin-right: 30px;">
            <div class="sel3">
              <p class="p1">데이터 구조</p>
              <p class="p2">열처리 공정 데이터 7,598,580개</p>
            </div>
            <div class="sel3">
              <p class="p1">분석 모델</p>
				<p class="p2">
				  <a href="#" onclick="openPopup02()">
				    오토인코더
				  </a>,
				  <a href="#" onclick="openPopupReLU()">
    			    활성화함수(ReLU)
  				  </a>
				</p>
            </div>
            <div class="sel3" style="height: 100%;">
              <p class="p1">모델 성능</p>
              <p class="p2" style="line-height: 10px;">  
            	 <a href="#" onclick="openPopup03()">
    				accuracy_score(정확도)
  			  	 </a> : 1.00</p>
              <p class="p2" style="line-height: 10px;">
              	<a href="#" onclick="openPopup03()">
              		precision_score(정밀도)
              	</a> : 0.94</p>
              <p class="p2" style="line-height: 10px;">
              	<a href="#" onclick="openPopup03()">
              		recall_score(재현율)
              	</a> : 0.99</p>
              <p class="p2" style="line-height: 10px;">
              	<a href="#" onclick="openPopup03()">
              		F1 score
              	</a> : 0.96</p>
              
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


	<script>
	  function openPopup01() {
	    const newWindow = window.open("", "newwindow", "width=800,height=600");
	    newWindow.document.write(`
	      <!DOCTYPE html>
	      <html>
	      <head>
	        <title>열처리 : 예지보전</title>
	        <style>
	          body {
	            font-family: 'Poppins', sans-serif;
	            padding: 20px;
	            text-align: center;
	          }
	          img {
	            max-width: 100%;
	            height: auto;
	          }
	          p {
	            font-size: 16px;
	            margin-top: 20px;
	          }
	        </style>
	      </head>
	      <body>
	        <img src='./images/Heat01.png' alt='예지보전 이미지'>
	        <p>열처리 설비가 고장이 나면 장기간 설비를 가동할 수 없어 생산에 차질이 발생하여 정기적인 점검과 예지보전이 필요하다.</p>
	      </body>
	      </html>
	    `);
	  }
	  
	  function openPopup02() {
		    const newWindow02 = window.open("", "newwindow", "width=400,height=100");
		    newWindow02.document.write(`
		      <!DOCTYPE html>
		      <html>
		      <head>
		        <title>오토인코더 설명</title>
		        <style>
		          body {
		            font-family: Arial, sans-serif;
		            padding: 20px;
		            text-align: center;
		            font-size: 14px;
		            line-height: 1.5;
		          }
		        </style>
		      </head>
		      <body>
		        <p>오토인코더(Auto-Encoder) 알고리즘은 원래의 데이터보다 작은 차원의 잠재공간으로 압축 후에 다시 복원하고, 복원된 데이터와 원본 데이터의 차이를 비교함으로써 이상 탐지를 수행하는 방법이다.</p>
		      </body>
		      </html>
		    `);
	}
	  
	  function openPopup03() {
		    const newWindow03 = window.open("", "newwindow", "width=600,height=800");
		    newWindow03.document.write(`
		      <!DOCTYPE html>
		      <html>
		      <head>
		        <title>Confusion Matrix 설명</title>
		        <style>
		          body {
		            font-family: Arial, sans-serif;
		            padding: 20px;
		            text-align: center;
		            font-size: 14px;
		            line-height: 1.5;
		          }
		          img {
		            max-width: 100%;
		            height: auto;
		          }
		        </style>
		      </head>
		      <body>
		        <img src='./images/confusion.png' alt='Confusion Matrix'>
		        <p>○ 정확도(accuracy) : 입력된 데이터에 대한 예측 정도<br>
		        정확도 = (TP + TN) / (TP + TN + FN + FP)</p>
		        <p>○ 정밀도(precision) : 예측 값의 정확한 예측을 나타내는 지표<br>
		        정밀도 = TP / (TP + FP)</p>
		        <p>○ 재현율(recall) : 실제 값 중에서 모델이 검출한 실제 값의 비율<br>
		        재현율 = TP / (TP + FN)</p>
		        <p>○ F1 점수 (F1-score) : 정밀도와 재현율의 조화 평균<br>
		        F1 점수 = 2 × 재현율 × 정밀도 / (재현율 + 정밀도)</p>
		      </body>
		      </html>
		    `);
		  }
	  function openPopupReLU() {
		    const newWindowReLU = window.open("", "newwindow", "width=800,height=470");
		    newWindowReLU.document.write(`
		      <!DOCTYPE html>
		      <html>
		      <head>
		        <title>활성화 함수 설명</title>
		        <style>
		          body {
		            font-family: Arial, sans-serif;
		            padding: 20px;
		            text-align: center;
		            font-size: 14px;
		            line-height: 1.5;
		          }
		          img {
			        max-width: 100%;
			        height: auto;
			      }
		        </style>
		      </head>
		      <body>
		      	<img src='./images/ReLU.png' alt='ReLU'>
		        <h2>활성화 함수 (ReLU)</h2>
		        <p>
		          활성화 함수란 입력된 데이터의 가중 합을 출력 신호로 변환하는 함수이다. Rectified Linear Unit (ReLU)는 0보다 작은 입력은 0으로 만들고, 0 이상의 입력은 그대로 출력함으로써 빠른 학습을 가능하게 한다.
		        </p>
		        <p>
		          ReLU는 시그모이드나 하이퍼볼릭탄젠트(tanh)와 같은 다른 활성화 함수보다 간단한 연산을 사용하므로 빠른 학습이 가능하며, 기울기 소실 등의 문제를 해결하는 장점이 있어 최근 가장 많이 사용되는 활성화 함수이다.
		        </p>
		      </body>
		      </html>
		    `);
		  }

	</script>

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