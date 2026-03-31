<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 설계안 내용: 출력데이터 - session.invalidate() 세션 삭제
    // 보통 이 처리는 Controller(Servlet)에서 수행하지만, 
    // JSP에서 직접 처리할 경우 아래 코드를 사용합니다.
    // session.invalidate(); 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그아웃 알림</title>
<style>
    /* 기본 레이아웃 유지 */
    body { font-family: 'Malgun Gothic', sans-serif; margin: 0; padding: 0; background-color: #f4f4f4; }
    .container { width: 900px; margin: 50px auto; border: 1px solid #ccc; background-color: #fff; position: relative; }
    
    :root { --navy-color: #001f3f; }

    /* 헤더 */
    header { background-color: var(--navy-color); color: white; padding: 15px 20px; display: flex; justify-content: space-between; align-items: center; }
    .user-info { font-size: 14px; }
    .logout-btn { background-color: #eee; color: #333; padding: 5px 15px; border-radius: 4px; text-decoration: none; font-size: 12px; border: 1px solid #ccc; }

    /* 메인 영역 및 오버레이 */
    main { min-height: 500px; display: flex; justify-content: center; align-items: center; background-color: #fff; }

    /* 로그아웃 알림 팝업 (모달) 스타일 */
    .logout-modal {
        width: 350px;
        border: 1px solid #999;
        border-radius: 8px;
        overflow: hidden;
        box-shadow: 0 4px 15px rgba(0,0,0,0.2);
        background-color: #f9f9f9;
    }
    .modal-header {
        background-color: #ddd;
        padding: 10px;
        text-align: center;
        font-weight: bold;
        font-size: 15px;
        border-bottom: 1px solid #ccc;
    }
    .modal-body {
        padding: 30px 20px;
        text-align: center;
        font-size: 14px;
        line-height: 1.6;
        color: #333;
    }
    .modal-footer {
        padding: 15px;
        text-align: center;
        background-color: #f9f9f9;
    }

    /* 확인 버튼 (L2: index.do 이동) */
    .btn-confirm {
        background-color: #bbb;
        color: #000;
        border: 1px solid #999;
        padding: 8px 40px;
        font-weight: bold;
        cursor: pointer;
        border-radius: 4px;
        text-decoration: none;
        display: inline-block;
    }
    .btn-confirm:hover { background-color: #aaa; }

    /* 푸터 */
    footer { background-color: #ddd; color: #666; text-align: center; padding: 15px; font-size: 12px; border-top: 1px solid #ccc; }
</style>
</head>
<body>

<div class="container">
    <!-- 상단 헤더 (GNB 로그아웃 버튼 영역) -->
    <header>
        <div class="logo">재난/안전 정보 사이트</div>
        <div class="user-area">
            <span class="user-info">홍길동님 &nbsp;</span>
            <a href="#" class="logout-btn">로그아웃</a>
        </div>
    </header>

    <main>
        <!-- ※ GNB 로그아웃 버튼 클릭 시 팝업 표시 재현 -->
        <div class="logout-modal">
            <div class="modal-header">알림</div>
            <div class="modal-body">
                로그아웃 되었습니다.<br>
                재난/안전 정보 사이트를<br>
                이용해 주셔서 감사합니다.
            </div>
            <div class="modal-footer">
                <!-- L2: 확인 버튼 클릭 시 index.do로 이동 -->
                <a href="index.do" class="btn-confirm">확인</a>
            </div>
        </div>
    </main>

    <footer>푸터</footer>
</div>

</body>
</html>