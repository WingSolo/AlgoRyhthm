<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>로그아웃 확인</title>
    <style>
        /* 전체 화면을 덮는 모달 배경 */
        .modal-background {
            display: none; /* 처음에는 숨김 처리 */
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(255, 255, 255, 1); /* 전체 배경을 흰색으로 변경 */
            z-index: 1000; /* 화면 최상단에 표시 */
        }

        /* 모달 창 스타일 */
        .modal {
            position: absolute;
            top: 40%; /* 상단으로 조금 이동 */
            left: 50%;
            transform: translate(-50%, -50%);
            width: 300px;
            padding: 20px;
            background: linear-gradient(to right, #66ccff, #99ccff); /* 푸르스름한 그라데이션 */
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
            z-index: 1001;
        }

        /* 버튼 스타일 */
        .modal button {
            margin-top: 15px;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .confirm-btn {
            background-color: #007BFF;
            color: white;
        }

        .cancel-btn {
            background-color: #f44336;
            color: white;
        }

        .confirm-btn:hover, .cancel-btn:hover {
            opacity: 0.8;
        }
    </style>
    <script type="text/javascript">
        window.onload = function() {
            // 모달 배경과 모달 창을 보여줌
            document.querySelector('.modal-background').style.display = 'block';

            // 확인 버튼 클릭 시 로그아웃 서블릿으로 이동
            document.querySelector('.confirm-btn').onclick = function() {
                window.location.href = 'Logout';
            };

            // 취소 버튼 클릭 시 메인 페이지로 이동
            document.querySelector('.cancel-btn').onclick = function() {
                window.location.href = 'main.jsp'; // 메인 페이지로 이동 (필요시 경로 수정)
            };
        }
    </script>
</head>
<body>
    <!-- 모달 배경 -->
    <div class="modal-background">
        <!-- 모달 창 -->
        <div class="modal">
            <h3>정말 로그아웃 하시겠습니까?</h3>
            <button class="confirm-btn">확인</button>
            <button class="cancel-btn">취소</button>
        </div>
    </div>
</body>
</html>
