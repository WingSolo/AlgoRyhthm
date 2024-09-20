<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>로그아웃 확인</title>
    <script type="text/javascript">
        // 페이지가 로드되자마자 로그아웃 확인을 진행
        window.onload = function() {
            var result = confirm("정말 로그아웃 하시겠습니까?");
            if (result) {
                // 로그아웃 확인 시, Logout 서블릿으로 이동
                window.location.href = 'Logout';
            } else {
                // 취소 시, 메인 페이지 또는 이전 페이지로 이동
                window.location.href = 'main.jsp'; // 메인 페이지로 이동 (필요시 경로 수정)
            }
        }
    </script>
</head>
<body>
    <!-- 내용 없음: 페이지 로드 시 경고창이 바로 뜨도록 처리 -->
</body>
</html>
