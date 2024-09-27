<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>비밀번호 찾기</title>
    <link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: #ffffff;
            color: #003366; /* 글자 색 군청색 */
        }
        .login_form {
            background: #ffffff; /* 창 배경색 흰색 */
            padding: 30px;
            border-radius: 10px;
            text-align: center;
        }
        .form-control {
            border-radius: 10px;
            border: 2px solid #ced4da;
            padding: 12px 20px;
            font-size: 16px;
        }
        .btn {
            background-color: #003366; /* 버튼 색 군청색 */
            color: white;
            padding: 12px 25px;
            border-radius: 30px;
            border: none;
            font-size: 16px;
            width: 100%;
            transition: background-color 0.3s ease;
        }
        .btn:hover {
            background-color: #002244; /* 호버 시 더 어두운 군청색 */
        }
        .error {
            color: red;
            font-weight: bold;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="row">
            <div class="col-md-6 offset-md-3">
                <div class="login_form">
                    <h2>비밀번호 찾기</h2>
                    <form action="SendPassword" method="post">
                        <div class="form-group">
                            <input type="text" class="form-control" name="empId" placeholder="아이디" required>
                        </div>
                        <div class="form-group">
                            <input type="email" class="form-control" name="email" placeholder="이메일 주소" required>
                        </div>
                        <% if (request.getParameter("error") != null) { %>
                            <div class="error"><%= request.getParameter("error") %></div>
                        <% } %>
                        <div class="form-group">
                            <button type="submit" class="btn">비밀번호 찾기</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
