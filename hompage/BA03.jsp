<%@page import="java.nio.file.Files"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.nio.file.Files" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.*" %>
<%@ page import="java.nio.file.Paths" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.sql.*" %>
<%
    // 세션에서 user 객체 가져오기
    Object loginUser = session.getAttribute("loginUser");
%>

<%
response.setHeader("Pragma","no-cache"); 
response.setDateHeader("Expires",0); 
response.setHeader("Cache-Control", "no-cache");
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


  <title>분석하기</title>

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
  <link href="css/style.css?after" rel="stylesheet"/>
  <!-- responsive style -->
  <link href="css/responsive.css" rel="stylesheet" />
  
  <!-- java script -->
  <script type="text/javascript" src="/js/custom.js"></script>
  
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
    <%
        String url = "jdbc:mariadb://localhost:3306/algo"; // DB URL
        String user = "root"; // DB 사용자 이름
        String password = "1234"; // DB 비밀번호
        
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        String base64String = null;

        try {
            // DB 연결
            Class.forName("org.mariadb.jdbc.Driver");
            connection = DriverManager.getConnection(url, user, password);
            
            String sql = "SELECT result_path FROM analysis_result ORDER BY num DESC LIMIT 1"; // SQL 쿼리
            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();
            
            if (resultSet.next()) {
                String resultPath = resultSet.getString("result_path");
                String path = "C:\\Users\\jungf\\OneDrive\\바탕 화면\\Study\\workspace\\Algo\\result_image\\" + resultPath;

                try {
                    // 이미지 파일의 바이트 읽기
                    byte[] imageBytes = Files.readAllBytes(Paths.get(path));
                    // 이미지 바이트를 Base64 문자열로 인코딩
                    base64String = Base64.getEncoder().encodeToString(imageBytes);
                } catch (java.nio.file.NoSuchFileException e) {
                    System.out.println("파일을 찾을 수 없습니다: " + path);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // 자원 해제
            try {
                if (resultSet != null) resultSet.close();
                if (preparedStatement != null) preparedStatement.close();
                if (connection != null) connection.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
       
    %>
  <!-- ana section -->
  <section class="ana_section layout_padding">
    <div class="container">
      <div class="heading_container heading_center">
        <h2 style="color: white; font-weight: bold;">분석 결과</h2>
      </div>
      <div class="row justify-content-center"> 
        <div class="col-md-13 px-0">
          <div class="form_container" style="background-color: rgb(255, 255, 255, 0.3); border-radius: 3px;">
            <form method = 'post' enctype="multipart/form-data" id = "analysis">             
                  <div class="form-row">
                    <div class="col-md-14">
                      <input type="text" class="ana-email" value="email   :   <%=request.getAttribute("email")%>" name = "ana_email" disabled/>
                      <div style = "text-align : center; ">
                      <img src="data:image/png;base64,<%=base64String %>"  width = "600" height = "500" style = "margin-bottom : 15px; margin-top : -40px"/>
                      </div>
                      <input type="text" class="ana-result" value="Date   :   <%=request.getAttribute("date")%>" name = "ana_result" disabled/>
                      <input type="text" class="ana-result" value="Analysis model   :   <%=request.getAttribute("ana_model")%>" name = "ana_result" disabled/>
                      <input type="text" class="ana-result" value="Accuracy score   :   <%=request.getAttribute("accuracy")%>" name = "ana_result" disabled/>
                      <input type="text" class="ana-result" value="F1 score   :   <%=request.getAttribute("f1")%>" name = "ana_result" disabled/>
                      <input type="text" class="ana-result" value="Precision score   :   <%=request.getAttribute("precision")%>" name = "ana_result" disabled/>
                      <input type="text" class="ana-result" value="Recall score   :   <%=request.getAttribute("recall")%>" name = "ana_result" disabled/>
                    </div>
                  </div>
                  <div class="btn_box">
                    <button class = 'email_btn' style = "margin-top : 35px; margin-right : 20px" onclick = "javascript : form.action='Email_send';">
                      메일 전송
                    </button>
                    <!-- <button class = 'email_btn' style = "margin-top : 35px" onclick = "location.href = 'BA02.jsp'"> -->
                    <button class = 'contact_btn' style = "margin-top : 35px">
                      <a href = "BA02.jsp">문의하기</a>
                    </button>
                  </div>
            </form>
            <!-- 성공 또는 실패 여부에 따른 메시지 표시 -->
          </div>
        </div>
      </div>
    </div>
  </section>
  <!-- end ana section -->

 
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
  <script type = text/javascript>
  $(document).ready(function(){
      var fileTarget = $('.data-upload .upload-hidden');

      fileTarget.on('change', function(){
          if(window.FileReader){
              var filename = $(this)[0].files[0].name;
          }
          else{
              var filename = $(this).val().split('/').pop().split('\\').pop();
          }

          $(this).siblings('.upload-name').val(filename);
      });
  });
  </script>
   <!-- fileupload js -->
</body>

</html>