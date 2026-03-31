<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>재난/안전 정보 사이트 - 로그인</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<style>
/* 전체 페이지 레이아웃 - 화면 중앙 배치 */
body {
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 100vh;
    margin: 0;
    background-color: #f4f4f4;
}

/* 로그인 박스 크기 대폭 상향 (350px -> 500px) */
.page-container {
    width: 500px; 
    border: 1px solid #ddd;
    background-color: #fff;
    border-radius: 12px; /* 모서리 부드럽게 */
    overflow: hidden;
    box-shadow: 0 10px 25px rgba(0,0,0,0.1);
}

/* GNB 영역 - 상단바 버튼 제거 및 디자인 조정 */
.gnb {
    background-color: #001f3f; 
    padding: 20px; /* 높이 증가 */
    text-align: center; /* 제중앙 정렬 */
}

.site-title {
    color: #fff;
    font-size: 18px; /* 폰트 크기 증가 */
    margin: 0;
    letter-spacing: 1px;
}

/* 로그인 메인 컨텐츠 영역 */
.login-content {
    padding: 50px 40px; /* 여백 넉넉하게 */
}

/* "로그인" 제목 */
.login-title {
    text-align: center;
    font-size: 30px; /* 폰트 크기 대폭 증가 */
    font-weight: bold;
    margin-bottom: 40px;
    color: #222;
}

/* 입력 필드 스타일 */
.input-box {
    margin-bottom: 25px;
}
.input-label {
    display: block;
    font-size: 15px; /* 라벨 크기 증가 */
    font-weight: bold;
    color: #555;
    margin-bottom: 10px;
}
.form-control {
    height: 55px; /* 입력창 높이 증가 */
    font-size: 16px;
    border-radius: 6px;
    border-color: #ccc;
    padding: 10px 15px;
}
.form-control:focus {
    border-color: #001f3f;
    box-shadow: 0 0 0 0.2rem rgba(0, 31, 63, 0.15);
}

/* 로그인 버튼 - 크게 */
.btn-login {
    background-color: #001f3f;
    color: #fff;
    width: 100%;
    margin-top: 15px;
    padding: 15px;
    font-size: 18px;
    font-weight: bold;
    border-radius: 6px;
    border: none;
    transition: 0.3s;
}
.btn-login:hover {
    background-color: #003366;
    color: #fff;
    opacity: 0.9;
}

/* 회원가입 바로가기 링크 */
.join-link {
    text-align: center;
    margin-top: 25px;
    font-size: 15px;
}
.join-link a {
    color: #666;
    text-decoration: none;
}
.join-link a:hover {
    color: #001f3f;
    text-decoration: underline;
}

/* 푸터 영역 */
.footer {
    background-color: #fafafa;
    padding: 20px;
    text-align: center;
    font-size: 12px;
    color: #aaa;
    border-top: 1px solid #eee;
}
</style>
</head>
<body>

<div class="page-container">
    <!-- 상단바: 버튼 제거 및 중앙 정렬 -->
    <header class="gnb">
        <h1 class="site-title">재난/안전 정보 사이트</h1>
    </header>

    <main class="login-content">
        <h2 class="login-title">로그인</h2>
        
        <form action="${pageContext.request.contextPath}/member/login.do" method="post">
            <div class="input-box">
                <label for="id" class="input-label">아이디</label>
                <input type="text" id="id" name="id" class="form-control" placeholder="아이디를 입력하세요" maxlength="20" required>
            </div>
            
            <div class="input-box">
                <label for="pw" class="input-label">비밀번호</label>
                <input type="password" id="pw" name="pw" class="form-control" placeholder="비밀번호를 입력하세요" maxlength="20" required>
            </div>
            
            <button type="submit" class="btn btn-login">로그인</button>
        </form>
        
        <div class="join-link">
            <a href="${pageContext.request.contextPath}/member/writeForm.do">회원가입 바로가기</a>
        </div>
    </main>

    <footer class="footer">
        © Disaster/Safety Info All Rights Reserved.
    </footer>
</div>

<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>