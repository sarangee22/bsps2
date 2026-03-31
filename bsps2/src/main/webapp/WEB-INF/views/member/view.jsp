<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>재난/안전 정보 사이트 - 내 정보 보기</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<style>
/* 전체 레이아웃 */
body {
    background-color: #f4f4f4;
    padding: 50px 0;
}

.page-container {
    max-width: 800px;
    margin: 0 auto;
    border: 1px solid #ddd;
    background-color: #fff;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 4px 6px rgba(0,0,0,0.1);
}

/* GNB 영역 - 네이비 테마 */
.gnb {
    background-color: #001f3f;
    padding: 12px 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    color: #fff;
}
.site-title { font-size: 16px; margin: 0; font-weight: bold; }
.user-info { font-size: 14px; }
.btn-logout { 
    background-color: #fff; 
    color: #001f3f; 
    font-size: 12px; 
    padding: 2px 8px; 
    border-radius: 4px;
    text-decoration: none;
    margin-left: 10px;
}

/* 메인 컨텐츠 영역 (2단 구성) */
.main-layout {
    display: flex;
    min-height: 400px;
}

/* 사이드바 메뉴 */
.sidebar {
    width: 200px;
    background-color: #f8f9fa;
    border-right: 1px solid #ddd;
    padding: 20px 0;
}
.menu-title {
    font-weight: bold;
    padding: 10px 20px;
    border-bottom: 1px solid #ddd;
    margin-bottom: 10px;
}
.sidebar-menu { list-style: none; padding: 0; }
.sidebar-menu li a {
    display: block;
    padding: 12px 20px;
    color: #333;
    text-decoration: none;
    font-size: 14px;
}
.sidebar-menu li a:hover { background-color: #e9ecef; }
.sidebar-menu li a.active {
    background-color: #001f3f;
    color: #fff;
}
.sidebar-menu li a.text-danger { color: #dc3545; }

/* 데이터 표시 영역 */
.content-view {
    flex: 1;
    padding: 30px;
}
.view-title {
    text-align: center;
    font-size: 20px;
    font-weight: bold;
    margin-bottom: 30px;
}

/* 테이블 스타일 */
.info-table {
    width: 100%;
    border-collapse: collapse;
}
.info-table th {
    width: 30%;
    padding: 15px;
    background-color: #f8f9fa;
    border-bottom: 1px solid #dee2e6;
    font-size: 14px;
    text-align: left;
}
.info-table td {
    padding: 15px;
    border-bottom: 1px solid #dee2e6;
    font-size: 14px;
    color: #555;
}

/* 버튼 그룹 */
.btn-footer {
    text-align: right;
    margin-top: 20px;
}
.btn-edit {
    background-color: #001f3f;
    color: white;
    padding: 8px 20px;
    border: none;
    border-radius: 4px;
    font-size: 14px;
}
.btn-edit:hover { background-color: #003366; color: white; }

/* 푸터 */
.footer {
    background-color: #eee;
    padding: 10px;
    text-align: center;
    font-size: 11px;
    color: #888;
}
</style>
</head>
<body>

<div class="page-container">
    <!-- GNB (L1) -->
    <header class="gnb">
        <h1 class="site-title">재난/안전 정보 사이트</h1>
        <div class="user-info">
            <strong>${login.name}</strong>님 
            <a href="/member/logout.do" class="btn-logout" onclick="return confirm('로그아웃 하시겠습니까?')">로그아웃</a>
        </div>
    </header>

    <div class="main-layout">
        <!-- 사이드바 (L2, L3, L4) -->
        <aside class="sidebar">
            <div class="menu-title">마이페이지</div>
            <ul class="sidebar-menu">
                <li><a href="#" class="active">내 정보</a></li>
                <li><a href="/member/updateForm.do">회원정보 수정</a></li>
                <li><a href="/member/changePwForm.do">비밀번호 변경</a></li>
                <li><a href="/member/deleteForm.do" class="text-danger">회원 탈퇴</a></li>
            </ul>
        </aside>

        <!-- 정보 출력 영역 (D1~D7) -->
        <main class="content-view">
            <h2 class="view-title">내 정보 보기</h2>
            
            <table class="info-table">
                <tr>
                    <th>아이디</th>
                    <td>${vo.id}</td>
                </tr>
                <tr>
                    <th>이름</th>
                    <td>${vo.name}</td>
                </tr>
                <tr>
                    <th>성별</th>
                    <td>${vo.gender}</td>
                </tr>
                <tr>
                    <th>생년월일</th>
                    <td>${vo.birth}</td>
                </tr>
                <tr>
                    <th>연락처</th>
                    <td>${vo.tel}</td>
                </tr>
                <tr>
                    <th>이메일</th>
                    <td>${vo.email}</td>
                </tr>
                <tr>
                    <th>가입일</th>
                    <td>${vo.regDate}</td>
                </tr>
            </table>

            <!-- 정보 수정 버튼 (L2) -->
            <div class="btn-footer">
                <button type="button" class="btn-edit" onclick="location.href='/member/updateForm.do'">정보 수정</button>
            </div>
        </main>
    </div>

    <footer class="footer">
        푸터
    </footer>
</div>

<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.min.js"></script>
</body>
</html>