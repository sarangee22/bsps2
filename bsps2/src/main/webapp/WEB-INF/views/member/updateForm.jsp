<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정</title>
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
    
    #updateForm { max-width: 600px; }
    
    .form-group { margin-bottom: 25px; }
    .form-group label { display: block; font-size: 14px; font-weight: 600; color: #475569; margin-bottom: 10px; }
    
    .form-control { width: 100%; padding: 14px 18px; border: 1.5px solid var(--border-color); border-radius: 12px; font-size: 15px; outline: none; transition: 0.2s; box-sizing: border-box; background-color: var(--bg-light); color: #1e293b; }
    .form-control:focus { border-color: var(--accent-blue); background-color: #fff; box-shadow: 0 0 0 4px rgba(52, 152, 219, 0.1); }
    .form-control[readonly] { background-color: #f1f5f9; color: #94a3b8; cursor: not-allowed; }

    .gender-wrap { display: flex; gap: 12px; }
    .gender-option { flex: 1; position: relative; }
    .gender-option input[type="radio"] { position: absolute; opacity: 0; }
    .gender-option span { display: block; padding: 14px; text-align: center; background-color: var(--bg-light); border: 1.5px solid var(--border-color); border-radius: 12px; font-size: 15px; color: #64748b; cursor: pointer; transition: 0.2s; }
    .gender-option input[type="radio"]:checked + span { background-color: #eff6ff; border-color: var(--accent-blue); color: var(--accent-blue); font-weight: 700; }

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
            <li class="menu-item active"><a href="editForm.do">회원정보 수정</a></li>
            <li class="menu-item"><a href="changePwForm.do">비밀번호 변경</a></li>
            <li class="menu-item danger">
                <a href="deleteForm.do" onclick="return confirm('정말로 탈퇴하시겠습니까?');">회원 탈퇴</a>
            </li>
        </ul>
    </aside>

    <main>
        <div class="header-user">
            <div class="user-badge">
                <strong>${login.name}</strong>님 정보 수정 중
            </div>
        </div>

        <div class="content-title">회원정보 수정</div>
        <p class="content-sub">변경하실 내용을 입력하신 후 수정하기 버튼을 눌러주세요.</p>
        
        <form action="edit.do" method="post" id="updateForm">
            <div class="form-group">
                <label>아이디</label>
                <input type="text" name="id" class="form-control" value="${vo.id}" readonly>
            </div>

            <div class="form-group">
                <label for="name">이름</label>
                <input type="text" id="name" name="name" class="form-control" value="${vo.name}" required>
            </div>

            <div class="form-group">
                <label>성별</label>
                <div class="gender-wrap">
                    <label class="gender-option">
                        <input type="radio" name="gender" value="남자" ${vo.gender == '남자' ? 'checked' : ''}>
                        <span>남자</span>
                    </label>
                    <label class="gender-option">
                        <input type="radio" name="gender" value="여자" ${vo.gender == '여자' ? 'checked' : ''}>
                        <span>여자</span>
                    </label>
                </div>
            </div>

            <div class="form-group">
                <label for="birth">생년월일</label>
                <input type="date" id="birth" name="birth" class="form-control" value="${vo.birth}" required>
            </div>

            <div class="form-group">
                <label for="tel">연락처</label>
                <input type="tel" id="tel" name="tel" class="form-control" value="${vo.tel}" placeholder="010-0000-0000">
            </div>

            <div class="form-group">
                <label for="email">이메일</label>
                <input type="email" id="email" name="email" class="form-control" value="${vo.email}" required>
            </div>

            <div class="button-group">
                <button type="button" class="btn btn-cancel" onclick="location.href='view.do'">취소</button>
                <button type="submit" class="btn btn-save">수정 완료</button>
            </div>
        </form>
    </main>
</div>

<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.min.js"></script>
<script>
$(function() {
    $("#updateForm").submit(function() {
        return confirm("입력하신 정보로 수정을 진행하시겠습니까?");
    });
});
</script>
</body>
</html>