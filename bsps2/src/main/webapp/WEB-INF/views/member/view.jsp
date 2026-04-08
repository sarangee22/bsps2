<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 정보</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
<style>
    body { font-family: 'Noto Sans KR', sans-serif; margin: 0; padding: 0; background-color: #f4f7f9; color: #2c3e50; }
    
    .container { width: 1100px; margin: 50px auto; background-color: #fff; border-radius: 20px; box-shadow: 0 10px 40px rgba(0,0,0,0.08); overflow: hidden; display: flex; min-height: 750px; }
    
    :root { --main-navy: #1a2a4e; --accent-blue: #3498db; --bg-light: #f8fafc; --border-color: #f1f5f9; }

    aside { width: 280px; background-color: #fff; border-right: 1px solid var(--border-color); padding: 50px 0; }
    aside h2 { padding: 0 35px; font-size: 22px; font-weight: 700; margin-bottom: 40px; color: var(--main-navy); display: flex; align-items: center; gap: 10px; }
    aside h2::before { content: ''; display: block; width: 4px; height: 20px; background-color: var(--accent-blue); border-radius: 2px; }
    
    .menu-list { list-style: none; padding: 0; margin: 0; }
    .menu-item { margin: 8px 20px; border-radius: 12px; overflow: hidden; transition: 0.2s; }
    .menu-item a { text-decoration: none; color: #64748b; font-size: 15px; font-weight: 500; padding: 16px 20px; display: block; }
    
    .menu-item.active { background-color: #eff6ff; }
    .menu-item.active a { color: var(--accent-blue); font-weight: 700; }
    
    .menu-item:hover:not(.active) { background-color: #f8fafc; }
    .menu-item:hover:not(.active) a { color: #334155; }
    
    .menu-item.danger a { color: #ef4444; }
    .menu-item.danger:hover { background-color: #fef2f2; }

    main { flex: 1; padding: 60px 80px; background-color: #fff; }
    
    .header-user { display: flex; justify-content: flex-end; align-items: center; margin-bottom: 40px; }
    .user-badge { background-color: var(--bg-light); padding: 8px 16px; border-radius: 30px; font-size: 14px; color: #64748b; border: 1px solid var(--border-color); }
    .user-badge strong { color: var(--main-navy); }

    .content-title { font-size: 28px; font-weight: 700; color: var(--main-navy); margin-bottom: 10px; }
    .content-sub { font-size: 15px; color: #94a3b8; margin-bottom: 50px; }
    
    .info-card { background-color: #fff; border: 1px solid var(--border-color); border-radius: 16px; overflow: hidden; }
    .info-table { width: 100%; border-collapse: collapse; }
    .info-table tr { border-bottom: 1px solid var(--border-color); }
    .info-table tr:last-child { border-bottom: none; }
    
    .info-table th { width: 200px; background-color: #fcfdfe; padding: 25px 30px; text-align: left; font-size: 14px; color: #64748b; font-weight: 600; }
    .info-table td { padding: 25px 30px; font-size: 15px; color: #1e293b; font-weight: 500; }

    .btn-group { display: none; }
</style>
</head>
<body>

<div class="container">
    <aside>
        <h2>마이페이지</h2>
        <ul class="menu-list">
            <li class="menu-item active">
                <a href="view.do">내 정보 보기</a>
            </li>
            <li class="menu-item">
                <a href="${pageContext.request.contextPath}/member/editForm.do">회원정보 수정</a>
            </li>
            <li class="menu-item">
                <a href="${pageContext.request.contextPath}/member/changePwForm.do">비밀번호 변경</a>
            </li>
            <li class="menu-item danger">
                <a href="${pageContext.request.contextPath}/member/deleteForm.do" 
                   onclick="return confirm('정말로 탈퇴하시겠습니까? 모든 정보가 사라집니다.');">회원 탈퇴</a>
            </li>
        </ul>
    </aside>

    <main>
        <div class="header-user">
            <div class="user-badge">
                현재 접속 계정: <strong>${login.name}</strong>님
            </div>
        </div>

        <div class="content-title">내 정보 보기</div>
        <p class="content-sub">회원님의 기본 가입 정보를 확인하실 수 있습니다.</p>
        
        <div class="info-card">
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
        </div>
    </main>
</div>

</body>
</html>