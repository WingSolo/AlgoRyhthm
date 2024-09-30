<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 세션에서 user 객체 가져오기
    Object loginUser = session.getAttribute("loginUser");
%>
<%
    // 서버에서 폼 처리 후 성공 여부를 설정
    boolean success = false; // 이 값을 서버 로직에 맞게 설정
    String message = "";
    
    // 예시: 폼 데이터가 정상적으로 처리되었는지 확인
    if (request.getMethod().equalsIgnoreCase("POST")) {
        // 여기에서 폼 데이터를 처리합니다.
        // 폼 처리 로직 (예: DB 저장 등)
        // 성공 여부에 따라 true 또는 false 설정
        success = true; // 또는 실패시 false
        
        if (success) {
            message = "전송 성공!";
        } else {
            message = "전송 실패. 다시 시도해주세요.";
        }
    }
%>


<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
  <title>문의하기</title>

  <!-- bootstrap core css -->
  <link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/css/nice-select.min.css" />
  <link href="css/font-awesome.min.css" rel="stylesheet" />
  <link href="css/style.css" rel="stylesheet" />
  <link href="css/responsive.css" rel="stylesheet" />
  
  <style>
  
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
  <div class="hero_area">
    <header class="header_section">
      <div class="header_top">
        <div class="container-fluid header_top_container">
          <div class="contact_nav">
            <a href="A01.jsp">
              <i class="fa fa-map-marker" aria-hidden="true"></i>
              <span>Location</span>
            </a>
            <a href="BA02.jsp">
              <i class="fa fa-phone" aria-hidden="true"></i>
              <span>전화번호 : 031-224-3636</span>
            </a>
            <a href="BA02.jsp">
              <i class="fa fa-envelope" aria-hidden="true"></i>
              <span>Algo@gmail.com</span>
            </a>
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
                  <a  class="nav-link" href="main.jsp"><span><img src="images/logo.png" alt="logo" height="27px"></span></a>
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

 <!-- contact section -->
  <section class="contact_section layout_padding">
    <div class="container">
      <div class="heading_container heading_center">
        <h2>문의하기</h2>
      </div>
      <div class="row justify-content-center">
        <div class="col-md-6 px-0">
          <div class="form_container">
            <form action="submitIntro" method="post" align="center">
              <div class="form-row">
                <div class="form-group col-lg-6">
                    <input type="text" class="form-control" name="name" placeholder="성함" required />
                </div>
                <div class="form-group col-lg-6">
                    <input type="email" class="form-control" name="email" placeholder="email" required />
                </div>
              </div>
              <div class="form-row">
                <div class="form-group col-lg-6">
                    <input type="text" class="form-control" name="phone" placeholder="휴대폰 번호" required />
                </div>
                <div class="form-group col-lg-6">
                    <input type="text" class="form-control" name="company" placeholder="가관명(선택)" />
                </div>
                <div class="form-group col-lg-6">
                    <select name="data_type" class="form-control wide">
                        <option value="">데이터 종류</option>
                        <option value="image">이미지</option>
                        <option value="text">텍스트/문서</option>
                        <option value="ect">기타</option>
                    </select>
                </div>
                <div class="form-group col-lg-6">
                    <select name="coun_type" class="form-control wide">
                        <option value="">상담유형</option>
                        <option value="dataset">데이터 셋 구축</option>
                        <option value="ai">AI 기획/컨설팅</option>
                        <option value="visualization">분석 데이터 시각화</option>
                        <option value="ect">기타</option>
                    </select>
                </div>
              </div>
              <div class="form-row">
                <div class="form-group col">
                    <select name="visit_path" class="form-control wide">
                        <option value="">방문경로</option>
                        <option value="recom">지인추천</option>
                        <option value="news">언론 보도</option>
                        <option value="offline">오프라인 행사</option>
                        <option value="sns">SNS 광고</option>
                        <option value="letter">뉴스레터</option>
                        <option value="youtube">유투브</option>
                        <option value="talk">카카오톡 오픈 채팅방</option>
                        <option value="mail">메일</option>
                        <option value="potal">포털사이트(연관검색어)</option>
                        <option value="ect">기타</option>
                    </select>
                </div>
              </div>
              <div class="form-row">
                <div class="form-group col">
                    <textarea name="content" class="message-box form-control" placeholder="문의사항" required></textarea>
                </div>
              </div>
              <div class="btn_box">
                <button type="submit">전송</button>
              </div>
            </form>

            <!-- 성공 또는 실패 여부에 따른 메시지 표시 -->
            <script>
                var success = '<%= success %>';
                var message = '<%= message %>';

                if (success === 'true') {
                    alert(message);
                } else if (success === 'false' && message !== '') {
                    alert(message);
                }
            </script>
          </div>
        </div>
      </div>
    </div>
  </section>

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

  <!-- End Google Map -->

</body>

</html>