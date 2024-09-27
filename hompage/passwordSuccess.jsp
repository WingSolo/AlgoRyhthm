<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="refresh" content="3;url=login.jsp"> <!-- 3초 후 login.jsp로 리다이렉트 -->
    <title>비밀번호 전송 완료</title>
    <link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: #f1f1f1;
            color: #003366; /* 글자 색 군청색 */
            text-align: center;
            padding-top: 50px;
        }
        .message-box {
            background: #ffffff; /* 창 배경색 흰색 */
            padding: 30px;
            border-radius: 10px;
            display: inline-block;
            text-align: center;
        }
        .message-box h2 {
            color: #003366; /* 제목 색 군청색 */
        }
        a {
            color: #003366; /* 링크 색 군청색 */
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="message-box">
        <h2>비밀번호가 이메일로 전송되었습니다!</h2>
        <p>3초 후에 로그인 페이지로 이동합니다...</p>
        <p>지금 바로 <a href="login.jsp">로그인</a>할 수 있습니다.</p>
    </div>
</body>
</html>
