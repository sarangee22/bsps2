<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 변경</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<style>
    body { font-family: 'Malgun Gothic', sans-serif; margin: 0; padding: 0; background-color: #f4f4f4; }
    .container { width: 1100px; margin: 30px auto; border: 1px solid #ccc; background-color: #fff; box-shadow: 0 0 15px rgba(0,0,0,0.1); border-radius: 8px; overflow: hidden; }
    header { background-color: #001f3f; color: white; padding: 15px 30px; display: flex; justify-content: flex-end; align-items: center; }
    .wrapper { display: flex; min-height: 600px; }
    aside { width: 250px; background-color: #fff; border-right: 1px solid #eee; padding: 40px 0; }
    aside h2 { padding: 0 30px; font-size: 18px; margin-bottom: 30px; color: #333; }
    .menu-list { list-style: none; padding: 0; margin: 0; }
    .menu-item { padding: 15px 30px; border-bottom: 1px solid #f9f9f9; }
    .menu-item a { text-decoration: none; color: #666; font-size: 14px; display: block; }
    .menu-item.active { background-color: #001f3f; }
    .menu-item.active a { color: #fff; font-weight: bold; }
    .menu-item.danger a { color: #d32f2f; }

    main { flex: 1; padding: 50px; }
    .content-title { font-size: 24px; font-weight: bold; text-align: center; margin-bottom: 40px; color: #333; }
    #pwForm { max-width: 500px; margin: 0 auto; }
    .form-group label { font-size: 14px; font-weight: bold; color: #333; }
    .form-control { font-size: 14px; padding: 10px; }
    .btn-group { display: flex; gap: 15px; justify-content: center; margin-top: 40px; }
    .btn-save { background-color: #001f3f; color: white; border: none; padding: 12px 40px; border-radius: 4px; font-weight: bold; font-size: 14px; }
    .btn-cancel { background-color: #6c757d; color: white; border: none; padding: 12px 40px; border-radius: 4px; font-size: 14px; }
</style>
</head>
<body>
<div class="container">
    <header><div class="user-area"><span><strong>${login.name}</strong>님</span></div></header>
    <div class="wrapper">
        <aside>
            <h2>마이페이지</h2>
            <ul class="menu-list">
                <li class="menu-item"><a href="view.do">내 정보</a></li>
                <li class="menu-item"><a href="editForm.do">회원정보 수정</a></li>
                <li class="menu-item active"><a href="#">비밀번호 변경</a></li>
                <li class="menu-item danger"><a href="delete.do">회원 탈퇴</a></li>
            </ul>
        </aside>
        <main>
            <div class="content-title">비밀번호 변경</div>
            <form action="changePw.do" method="post" id="pwForm">
                <div class="form-group">
                    <label>현재 비밀번호</label>
                    <input type="password" name="pw" class="form-control" placeholder="기존 비밀번호 입력" required>
                </div>
                <div class="form-group">
                    <label>새 비밀번호</label>
                    <input type="password" name="newPw" id="newPw" class="form-control" placeholder="새 비밀번호 입력" required>
                </div>
                <div class="form-group">
                    <label>새 비밀번호 확인</label>
                    <input type="password" id="newPwCheck" class="form-control" placeholder="새 비밀번호 다시 입력" required>
                </div>
                <div class="btn-group">
                    <button type="submit" class="btn btn-save">변경하기</button>
                    <button type="button" class="btn btn-cancel" onclick="history.back()">취소</button>
                </div>
            </form>
        </main>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.min.js"></script>
<script>
$("#pwForm").submit(function() {
    if($("#newPw").val() !== $("#newPwCheck").val()) {
        alert("새 비밀번호와 확인이 일치하지 않습니다.");
        return false;
    }
    return confirm("비밀번호를 변경하시겠습니까? 변경 후 다시 로그인해야 합니다.");
});
</script>
</body>
</html>