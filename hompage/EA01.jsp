<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 세션에서 user 객체 가져오기
    Object user = session.getAttribute("user");
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

  <title>ë¬¸ìë´ì­</title>

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
            <a href="A01.html">
              <i class="fa fa-map-marker" aria-hidden="true"></i>
              <span>
                Location
              </span>
            </a>
            <a href="BA02.html">
              <i class="fa fa-phone" aria-hidden="true"></i>
              <span>
               전화번호 : 031-224-3636
              </span>
            </a>
            <a href="BA02.html">
              <i class="fa fa-envelope" aria-hidden="true"></i>
              <span>
                Algo@gmail.com
              </span>
            </a>
            <a href="login.html">
              <i class="fa fa-user" aria-hidden="true"></i>
              <span>
                  관리자
              </span>
              </a>
          </div> 
        </div>
      </div>
      
      <div class="header_bottom">
        <div class="container-fluid">
          <nav class="navbar navbar-expand-lg custom_nav-container ">
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
              <ul class="navbar-nav">
                <li class="nav-item active">
                  <a class="nav-link" href="main.html"><span><img src="/images/logo.png" alt="logo" height="27px"></span></a>
                </li>
                <li class="nav-item active">
                  <a class="nav-link" href="main.html">홈<span class="sr-only">(current)</span></a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="A01.html">회사소개</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="AB_main.html">분석사례</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="BA01.html">분석</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="BA02.html">문의하기</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="CA01.html">공지사항</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="EA01.html">마이페이지</a>
                </li>
              </ul>
            </div>
          </nav>
        </div>
      </div>
    </header>
    <!-- end header section -->
  </div>

  <!-- service section -->

  <section class="service_section layout_padding">
    <div class="container ">
      <div class="heading_container heading_center">
        <h2>문의내역</h2>
        <br>
        <br>
      
        
      <title>게시판 리스트</title>
        <link rel ="stylesheet" href="/test/css/bootstrap.css">
    </head>
    <body>
        <div class = "container">
            <table class = "table table-hover">
                <thead>
                    <tr>
                        <!--게시판 속성-->
                        <th>No.</th>
                        <th>성함</th>
                        <th>이메일</th>
                        <th>핸드폰</th>
                        <th>기관명</th>
                        <th>데이터 종류</th>
                        <th>상담유형</th>
                        <th>방문경로</th>
                        <th>일시</th>
                    </tr>
                </thead>
                <!-- <?php       // DB에 저장된 글 목록을 idx의 내림차순으로 가져와 페이지에 집어넣기
                $sql = "SELECT * FROM board ORDER BY idx DESC limit $begin,$page_size";
                $result = $db->query($sql);
                while($board=$result->fetch_array(MYSQLI_ASSOC)){
                    $title = $board['title'];
                    // 만약 title의 길이가 길면 중간을 '....'으로 표시
                    if(strlen($title)>15){ 
                        $title=str_replace($board["title"],mb_substr($board["title"],0,15,"UTF8")."...",$board["title"]); //titleì´ 15ì ëì´ìë©´ ...íì
                    }
                ?> -->
                <tbody>
                    <tr>
                        <td><?php echo $board['idx'];?></td>
                        <!--제목클릭시 게시글 읽기-->
                        <td><a href ="/test/notice_board/read?idx=<?php echo $board['idx']; ?>"><?php echo $title;?></td>
                        <td><?php echo $board['author'];?></td>
                        <td><?php echo $board['date'];?></td>
                        <td><?php echo $board['views'];?></td>
                    </tr>
                </tbody>
        <?php   } ?>    <!--while문 종료-->
            </table>
            <hr/>
        
        <!--페이지 번호-->
        <?php
            $page_sql = "SELECT COUNT(idx) FROM board";     // 글 목록 수 구하는 쿼리문
            $page_result = mysqli_query($db, $page_sql);    // 쿼리문 실행
            $row = mysqli_fetch_row($page_result);          // 실행 값 열로 가져오기(데이터 접근하기위해)
            $total_records = $row[0];                       // [0]번째에 저장되어 있음
            $total_pages = ceil($total_records / $page_size);   // 페이지 수 구하기
        ?>
            <div class = "pagination justify-content-center">
            <ul class = 'pagination'>
                <?php
                    // 페이지 수 만큼 페이지 버튼 만들고 해당 페이지 번호에 게시글 배정
                    for ($i=1; $i<=$total_pages; $i++) {
                        ?><li class='page-item'><a class='page-link' href='/test/main?current_page=<?php echo $i;?>'><?php echo $i;?></a></li>
                <?php } ?>
            </div>
        </div>
      
      
    </div>
  </section>

  <!-- end service section -->

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