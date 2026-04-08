<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 변경</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
<style>
    body { font-family: 'Noto Sans KR', sans-serif; margin: 0; padding: 0; background-color: #f4f7f9; color: #2c3e50; }
    
    .container { width: 1100px; margin: 50px auto; background-color: #fff; border-radius: 20px; box-shadow: 0 10px 40px rgba(0,0,0,0.08); overflow: hidden; display: flex; min-height: 800px; }
    
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
    .menu-item.danger a { color: #ef4444; }
    .menu-item.danger:hover { background-color: #fef2f2; }

    main { flex: 1; padding: 60px 80px; background-color: #fff; }
    
    .header-user { display: flex; justify-content: flex-end; align-items: center; margin-bottom: 40px; }
    .user-badge { background-color: var(--bg-light); padding: 8px 16px; border-radius: 30px; font-size: 14px; color: #64748b; border: 1px solid var(--border-color); }

    .content-title { font-size: 28px; font-weight: 700; color: var(--main-navy); margin-bottom: 10px; }
    .content-sub { font-size: 15px; color: #94a3b8; margin-bottom: 40px; }
    
    #pwForm { max-width: 500px; }
    
    .form-group { margin-bottom: 25px; }
    .form-group label { display: block; font-size: 14px; font-weight: 600; color: #475569; margin-bottom: 10px; }
    
    .form-control { width: 100%; padding: 14px 18px; border: 1.5px solid var(--border-color); border-radius: 12px; font-size: 15px; outline: none; transition: 0.2s; box-sizing: border-box; background-color: var(--bg-light); color: #1e293b; }
    .form-control:focus { border-color: var(--accent-blue); background-color: #fff; box-shadow: 0 0 0 4px rgba(52, 152, 219, 0.1); }
    .form-control::placeholder { color: #cbd5e1; }

    .pw-tip { background-color: #f0f9ff; padding: 15px 20px; border-radius: 12px; margin-bottom: 30px; border-left: 4px solid var(--accent-blue); }
    .pw-tip p { margin: 0; font-size: 13px; color: #0369a1; line-height: 1.5; }

    .button-group { display: flex; gap: 12px; margin-top: 50px; }
    .btn { padding: 16px 40px; border-radius: 12px; font-weight: 700; font-size: 16px; cursor: pointer; transition: 0.3s; border: none; }
    .btn-save { flex: 2; background-color: var(--main-navy); color: white; box-shadow: 0 4px 12px rgba(26, 42, 78, 0.15); }
    .btn-save:hover { background-color: #233966; transform: translateY(-2px); }
    .btn-cancel { flex: 1; background-color: #f1f5f9; color: #64748b; }
    .btn-cancel:hover { background-color: #e2e8f0; }
</style>
</head>
<body>

<div class="container">
    <aside>
        <h2>마이페이지</h2>
        <ul class="menu-list">
            <li class="menu-item"><a href="view.do">내 정보 보기</a></li>
            <li class="menu-item"><a href="editForm.do">회원정보 수정</a></li>
            <li class="menu-item active"><a href="changePwForm.do">비밀번호 변경</a></li>
            <li class="menu-item danger">
                <a href="deleteForm.do" onclick="return confirm('정말로 탈퇴하시겠습니까?');">회원 탈퇴</a>
            </li>
        </ul>
    </aside>

    <main>
        <div class="header-user">
            <div class="user-badge">
                <strong>${login.name}</strong>님 계정 보호 중
            </div>
        </div>

        <div class="content-title">비밀번호 변경</div>
        <p class="content-sub">주기적인 비밀번호 변경으로 소중한 개인정보를 보호하세요.</p>
        
        <div class="pw-tip">
            <p>• 새로운 비밀번호는 기존 비밀번호와 다르게 설정해주세요.<br>
               • 변경 완료 시 보안을 위해 자동으로 로그아웃됩니다.</p>
        </div>

        <form action="changePw.do" method="post" id="pwForm">
            <div class="form-group">
                <label>현재 비밀번호</label>
                <input type="password" name="pw" class="form-control" placeholder="기존 비밀번호를 입력하세요" required>
            </div>

            <div class="form-group">
                <label>새 비밀번호</label>
                <input type="password" name="newPw" id="newPw" class="form-control" placeholder="새 비밀번호를 입력하세요" required>
            </div>

            <div class="form-group">
                <label>새 비밀번호 확인</label>
                <input type="password" id="newPwCheck" class="form-control" placeholder="새 비밀번호를 한 번 더 입력하세요" required>
            </div>

            <div class="button-group">
                <button type="button" class="btn btn-cancel" onclick="history.back()">취소</button>
                <button type="submit" class="btn btn-save">비밀번호 변경</button>
            </div>
        </form>
    </main>
</div>

<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.min.js"></script>
<script>
$(function() {
    $("#pwForm").submit(function() {
        if($("#newPw").val() !== $("#newPwCheck").val()) {
            alert("새 비밀번호와 확인용 비밀번호가 일치하지 않습니다.");
            $("#newPwCheck").focus();
            return false;
        }
        return confirm("비밀번호를 변경하시겠습니까? 변경 후 다시 로그인해야 합니다.");
    });
});
</script>
</body>
</html>