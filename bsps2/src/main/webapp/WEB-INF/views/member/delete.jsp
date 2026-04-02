<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<style>
    /* 위와 동일한 스타일 적용 (생략 가능하나 가독성을 위해 유지) */
    body { font-family: 'Malgun Gothic', sans-serif; margin: 0; padding: 0; background-color: #f4f4f4; }
    .container { width: 1100px; margin: 30px auto; border: 1px solid #ccc; background-color: #fff; box-shadow: 0 0 15px rgba(0,0,0,0.1); border-radius: 8px; overflow: hidden; }
    header { background-color: #001f3f; color: white; padding: 15px 30px; display: flex; justify-content: flex-end; align-items: center; }
    .wrapper { display: flex; min-height: 600px; }
    aside { width: 250px; background-color: #fff; border-right: 1px solid #eee; padding: 40px 0; }
    aside h2 { padding: 0 30px; font-size: 18px; margin-bottom: 30px; color: #333; }
    .menu-list { list-style: none; padding: 0; margin: 0; }
    .menu-item { padding: 15px 30px; border-bottom: 1px solid #f9f9f9; }
    .menu-item a { text-decoration: none; color: #666; font-size: 14px; display: block; }
    .menu-item.active.danger { background-color: #d32f2f; }
    .menu-item.active.danger a { color: #fff; font-weight: bold; }
    
    main { flex: 1; padding: 50px; }
    .content-title { font-size: 24px; font-weight: bold; text-align: center; margin-bottom: 20px; color: #d32f2f; }
    .warning-box { text-align: center; margin-bottom: 40px; padding: 20px; background-color: #fff5f5; border: 1px solid #ffc1c1; border-radius: 4px; color: #d32f2f; font-size: 14px; }
    #deleteForm { max-width: 400px; margin: 0 auto; }
    .form-group label { font-size: 14px; font-weight: bold; }
    .btn-delete { background-color: #d32f2f; color: white; border: none; padding: 12px 40px; border-radius: 4px; font-weight: bold; width: 100%; }
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
                <li class="menu-item"><a href="pwChange.jsp">비밀번호 변경</a></li>
                <li class="menu-item active danger"><a href="#">회원 탈퇴</a></li>
            </ul>
        </aside>
        <main>
            <div class="content-title">회원 탈퇴</div>
            <div class="warning-box">탈퇴 시 모든 정보가 삭제되며 복구가 불가능합니다.<br>본인 확인을 위해 비밀번호를 입력해주세요.</div>
            <form action="delete.do" method="post" id="deleteForm">
                <div class="form-group">
                    <label>비밀번호</label>
                    <input type="password" name="pw" class="form-control" placeholder="현재 비밀번호 입력" required>
                </div>
                <button type="submit" class="btn btn-delete" onclick="return confirm('정말로 탈퇴하시겠습니까?');">탈퇴하기</button>
            </form>
        </main>
    </div>
</div>
</body>
</html>