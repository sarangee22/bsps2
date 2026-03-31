<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>재난/안전 정보 사이트 - 로그인</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<%-- <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login.css"> --%>
<style>
/* 기획안의 레이아웃을 최대한 유지하면서 색상만 네이비로 변경했습니다.
*/

/* 전체 페이지 레이아웃 - 기획안처럼 화면 중앙에 로그인 박스를 배치합니다. */
body {
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 100vh;
    margin: 0;
    background-color: #f4f4f4; /* 배경색은 밝은 회색으로 */
}

/* 기획안의 "페이지 레이아웃" 회색 박스 */
.page-container {
    width: 350px; /* 기획안 비율 참고 */
    border: 1px solid #ddd;
    background-color: #fff;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 4px 6px rgba(0,0,0,0.1);
}

/* GNB 영역 - 배경색을 네이비로 변경 */
.gnb {
    background-color: #001f3f; /* 네이비 색상 */
    padding: 10px;
    display: flex;
    justify-content: space-between; /* 양 끝 정렬 */
    align-items: center;
}

/* GNB 로고 텍스트 */
.site-title {
    color: #fff;
    font-size: 14px;
    margin: 0;
}

/* GNB 버튼 그룹 (로그인, 회원가입) */
.gnb-buttons .btn {
    font-size: 12px;
    padding: 3px 8px;
}

/* GNB 버튼 색상 - 네이비 배경에 맞게 조정 */
.btn-gnb {
    background-color: transparent;
    border: 1px solid #fff;
    color: #fff;
}
.btn-gnb:hover {
    background-color: rgba(255, 255, 255, 0.1);
    color: #fff;
}

/* 로그인 메인 컨텐츠 영역 */
.login-content {
    padding: 30px;
}

/* "로그인" 제목 - 기획안 위치 */
.login-title {
    text-align: center;
    font-size: 18px;
    font-weight: bold;
    margin-bottom: 25px;
}

/* 입력 필드 (아이디, 비밀번호) 스타일 */
.input-box {
    margin-bottom: 15px;
}
.input-label {
    display: block;
    font-size: 12px;
    color: #666;
    margin-bottom: 5px;
}
.form-control {
    font-size: 14px;
    border-color: #ccc;
}
.form-control:focus {
    border-color: #001f3f; /* 포커스 시 네이비색 테두리 */
    box-shadow: 0 0 0 0.2rem rgba(0, 31, 63, 0.25);
}

/* 로그인 버튼 - 네이비 테마 */
.btn-login {
    background-color: #001f3f; /* 네이비 색상 */
    color: #fff;
    width: 100%;
    margin-top: 20px;
    padding: 10px;
    font-size: 16px;
    font-weight: bold;
}
.btn-login:hover {
    background-color: #003366; /* 약간 더 밝은 네이비 */
    color: #fff;
}

/* 회원가입 바로가기 링크 */
.join-link {
    text-align: center;
    margin-top: 15px;
    font-size: 13px;
}
.join-link a {
    color: #001f3f; /* 네이비 색상 */
    text-decoration: underline; /* 기획안처럼 밑줄 유지 */
}

/* 푸터 영역 */
.footer {
    background-color: #f1f1f1;
    padding: 10px;
    text-align: center;
    font-size: 11px;
    color: #999;
}
</style>
</head>
<body>

<div class="page-container">
    <header class="gnb">
        <h1 class="site-title">재난/안전 정보 사이트</h1>
        <div class="gnb-buttons">
            <a href="${pageContext.request.contextPath}/member/loginForm.do" class="btn btn-gnb btn-sm">로그인</a>
            <a href="${pageContext.request.contextPath}/member/writeForm.do" class="btn btn-gnb btn-sm">회원가입</a>
        </div>
    </header>

    <main class="login-content">
        <h2 class="login-title">로그인</h2>
        
        <form action="${pageContext.request.contextPath}/member/login.do" method="post">
            <div class="input-box">
                <label for="id" class="input-label">아이디</label>
                <input type="text" id="id" name="id" class="form-control" placeholder="영숫자 3~20자" maxlength="20" required>
            </div>
            
            <div class="input-box">
                <label for="pw" class="input-label">비밀번호</label>
                <input type="password" id="pw" name="pw" class="form-control" placeholder="모든 문자 4~20자" maxlength="20" required>
            </div>
            
            <button type="submit" class="btn btn-login">로그인</button>
        </form>
        
        <div class="join-link">
            <a href="${pageContext.request.contextPath}/member/writeForm.do">회원가입 바로가기</a>
        </div>
    </main>

    <footer class="footer">
        © Disaster/Safety Info
    </footer>
</div>

<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>