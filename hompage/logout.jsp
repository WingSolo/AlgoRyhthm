<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그아웃</title>
    <script>
        window.onload = function() {
            if (confirm("정말 로그아웃 하시겠습니까?")) {
                // 확인을 누르면 LogoutController 서블릿으로 이동하여 로그아웃 처리
                window.location.href = 'Logout';  // Logout 서블릿 호출
            } else {
                // 취소를 누르면 메인 페이지로 이동
                window.location.href = 'main.jsp';  // 메인 페이지로 이동
            }
        };
    </script>
</head>
<body>
</body>
</html>
