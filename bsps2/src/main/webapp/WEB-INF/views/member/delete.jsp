<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
<style>
    body { font-family: 'Noto Sans KR', sans-serif; margin: 0; padding: 0; background-color: #f4f7f9; color: #2c3e50; }
    
    .container { width: 1100px; margin: 50px auto; background-color: #fff; border-radius: 20px; box-shadow: 0 10px 40px rgba(0,0,0,0.08); overflow: hidden; display: flex; min-height: 800px; }
    
    :root { --main-navy: #1a2a4e; --accent-blue: #3498db; --danger-red: #ef4444; --bg-light: #f8fafc; --border-color: #f1f5f9; }

    aside { width: 280px; background-color: #fff; border-right: 1px solid var(--border-color); padding: 50px 0; }
    aside h2 { padding: 0 35px; font-size: 22px; font-weight: 700; margin-bottom: 40px; color: var(--main-navy); display: flex; align-items: center; gap: 10px; }
    aside h2::before { content: ''; display: block; width: 4px; height: 20px; background-color: var(--accent-blue); border-radius: 2px; }
    
    .menu-list { list-style: none; padding: 0; margin: 0; }
    .menu-item { margin: 8px 20px; border-radius: 12px; overflow: hidden; transition: 0.2s; }
    .menu-item a { text-decoration: none; color: #64748b; font-size: 15px; font-weight: 500; padding: 16px 20px; display: block; }
    
    .menu-item.active { background-color: #fef2f2; }
    .menu-item.active a { color: var(--danger-red); font-weight: 700; }
    
    .menu-item:hover:not(.active) { background-color: #f8fafc; }
    .menu-item:hover:not(.active) a { color: #334155; }
    .menu-item.danger a { color: #ef4444; }

    main { flex: 1; padding: 60px 80px; background-color: #fff; }
    
    .header-user { display: flex; justify-content: flex-end; align-items: center; margin-bottom: 40px; }
    .user-badge { background-color: var(--bg-light); padding: 8px 16px; border-radius: 30px; font-size: 14px; color: #64748b; border: 1px solid var(--border-color); }

    .content-title { font-size: 28px; font-weight: 700; color: var(--danger-red); margin-bottom: 15px; }
    
    .warning-section { background-color: #fff1f2; border-radius: 16px; padding: 25px; margin-bottom: 40px; border: 1px dashed #fecaca; }
    .warning-section p { margin: 0; font-size: 15px; color: #be123c; line-height: 1.6; font-weight: 500; }
    .warning-section strong { color: #9f1239; text-decoration: underline; }

    #deleteForm { max-width: 450px; }
    
    .form-group { margin-bottom: 25px; }
    .form-group label { display: block; font-size: 14px; font-weight: 600; color: #475569; margin-bottom: 12px; }
    
    .form-control { width: 100%; padding: 16px 20px; border: 1.5px solid var(--border-color); border-radius: 12px; font-size: 15px; outline: none; transition: 0.2s; box-sizing: border-box; background-color: var(--bg-light); }
    .form-control:focus { border-color: var(--danger-red); background-color: #fff; box-shadow: 0 0 0 4px rgba(239, 68, 68, 0.1); }

    .btn-delete { width: 100%; background-color: var(--danger-red); color: white; padding: 18px; border: none; border-radius: 14px; font-weight: 700; font-size: 17px; cursor: pointer; transition: 0.3s; margin-top: 10px; box-shadow: 0 4px 12px rgba(239, 68, 68, 0.2); }
    .btn-delete:hover { background-color: #dc2626; transform: translateY(-2px); box-shadow: 0 6px 20px rgba(239, 68, 68, 0.3); }

    .back-link { display: block; text-align: center; margin-top: 25px; color: #94a3b8; text-decoration: none; font-size: 14px; transition: 0.2s; }
    .back-link:hover { color: #64748b; text-decoration: underline; }
</style>
</head>
<body>

<div class="container">
    <aside>
        <h2>마이페이지</h2>
        <ul class="menu-list">
            <li class="menu-item"><a href="view.do">내 정보 보기</a></li>
            <li class="menu-item"><a href="editForm.do">회원정보 수정</a></li>
            <li class="menu-item"><a href="changePwForm.do">비밀번호 변경</a></li>
            <li class="menu-item active"><a href="deleteForm.do">회원 탈퇴</a></li>
        </ul>
    </aside>

    <main>
        <div class="header-user">
            <div class="user-badge">
                <strong>${login.name}</strong>님 접속 중
            </div>
        </div>

        <div class="content-title">회원 탈퇴 안내</div>
        
        <div class="warning-section">
            <p>
                탈퇴 시 고객님의 모든 <strong>활동 데이터와 개인 정보가 즉시 삭제</strong>되며,<br>
                삭제된 데이터는 <strong>어떠한 경우에도 복구가 불가능</strong>합니다.<br>
                신중하게 결정해 주시기 바랍니다.
            </p>
        </div>

        <form action="delete.do" method="post" id="deleteForm">
            <div class="form-group">
                <label>본인 확인을 위해 비밀번호를 입력해주세요</label>
                <input type="password" name="pw" class="form-control" placeholder="현재 비밀번호를 입력하세요" required>
            </div>
            
            <button type="submit" class="btn-delete" onclick="return confirm('정말로 탈퇴하시겠습니까?\n모든 데이터가 영구히 삭제됩니다.');">
                회원 탈퇴 확정
            </button>
            
            <a href="view.do" class="back-link">탈퇴 취소하고 돌아가기</a>
        </form>
    </main>
</div>

</body>
</html>```