<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 세션에서 user 객체 가져오기
    Object user = session.getAttribute("loginUser");
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

  <title>회사소개</title>

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
            <% if (user != null) { %>
              <a href="Logout">
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

  <!-- about section -->

  <section class="about_section layout_padding">
    <div class="container  ">
      <div class="row">
        <div class="col-md-6 ">
          <div class="img-box">
            <img src="./images/about-img.png" alt="회사소개" />
          </div>

        </div> 
        <div class="col-md-6">
          <div class="map_container">
            <div class="map">
              <div id="googleMap"><iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d2245.8285395758935!2d127.05558188916838!3d37.245781361841814!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357b4577c52730e5%3A0xc81558c592577761!2z66ed7Y-s7Jet7IS87YOA7ZSE65287J6Q!5e0!3m2!1sko!2skr!4v1724628930044!5m2!1sko!2skr" width="600" height="370" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe></div>
            </div>
          </div>
        </div>

        <div class="col-md-6">
          <div class="detail-box">
            <div class="heading_container">
              <br>
              <h2>환영합니다 <span> 알고리듬에 오신것을</span></h2>
            </div>
            <p>
              다양한 데이터를 받아서 정성들여 결과값을 예측해 드립니다
            </p>
            <a href="A01.jsp">
              회사 소개
            </a>
          </div>
        </div>
        </div>
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