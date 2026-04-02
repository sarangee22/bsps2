<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<style>
    /* view.jsp와 100% 동일한 기본 레이아웃 */
    body { font-family: 'Malgun Gothic', sans-serif; margin: 0; padding: 0; background-color: #f4f4f4; }
    .container { width: 1100px; margin: 30px auto; border: 1px solid #ccc; background-color: #fff; box-shadow: 0 0 15px rgba(0,0,0,0.1); border-radius: 8px; overflow: hidden; }
    
    :root { --navy-color: #001f3f; }

    /* 상단바 */
    header { background-color: var(--navy-color); color: white; padding: 15px 30px; display: flex; justify-content: flex-end; align-items: center; }
    .user-area { font-size: 14px; }

    /* 메인 레이아웃 (사이드바 + 컨텐츠) */
    .wrapper { display: flex; min-height: 600px; }
    
    /* 사이드 메뉴 (view.jsp와 동일) */
    aside { width: 250px; background-color: #fff; border-right: 1px solid #eee; padding: 40px 0; }
    aside h2 { padding: 0 30px; font-size: 18px; margin-bottom: 30px; color: #333; }
    .menu-list { list-style: none; padding: 0; margin: 0; }
    .menu-item { padding: 15px 30px; border-bottom: 1px solid #f9f9f9; }
    .menu-item a { text-decoration: none; color: #666; font-size: 14px; display: block; }
    .menu-item.active { background-color: var(--navy-color); }
    .menu-item.active a { color: #fff; font-weight: bold; }
    .menu-item:hover:not(.active) { background-color: #fcfcfc; }
    .menu-item.danger a { color: #d32f2f; }

    /* 컨텐츠 영역 */
    main { flex: 1; padding: 50px; }
    .content-title { font-size: 24px; font-weight: bold; text-align: center; margin-bottom: 40px; color: #333; }
    
    /* 폼 스타일 - 텍스트 크기 14px 유지 */
    #updateForm { max-width: 700px; margin: 0 auto; }
    .form-group label { font-size: 14px; font-weight: bold; color: #333; margin-bottom: 10px; }
    .form-control { font-size: 14px; padding: 10px; border-radius: 4px; }
    .form-control[readonly] { background-color: #f8f9fa; }

    /* 성별 라디오 버튼 영역 */
    .gender-box { padding: 10px; border: 1px solid #ced4da; border-radius: 4px; background-color: #fff; font-size: 14px; }

    /* 하단 버튼 영역 */
    .button-group { display: flex; gap: 15px; justify-content: center; margin-top: 40px; }
    .btn-save { background-color: var(--navy-color); color: white; border: none; padding: 12px 40px; border-radius: 4px; font-weight: bold; font-size: 14px; }
    .btn-cancel { background-color: #6c757d; color: white; border: none; padding: 12px 40px; border-radius: 4px; font-size: 14px; }
    .btn-save:hover { opacity: 0.9; }
</style>
</head>
<body>

<div class="container">
    <header>
        <div class="user-area">
            <span><strong>${login.name}</strong>님</span>
        </div>
    </header>

    <div class="wrapper">
        <aside>
            <h2>마이페이지</h2>
            <ul class="menu-list">
                <li class="menu-item"><a href="view.do">내 정보</a></li>
                <li class="menu-item active"><a href="#">회원정보 수정</a></li>
                <li class="menu-item"><a href="changePw.do">비밀번호 변경</a></li>
                <li class="menu-item danger"><a href="delete.do">회원 탈퇴</a></li>
            </ul>
        </aside>

        <main>
            <div class="content-title">회원정보 수정</div>
            
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
                    <div class="gender-box">
                        <div class="custom-control custom-radio custom-control-inline">
                            <input type="radio" id="male" name="gender" class="custom-control-input" value="남자" ${vo.gender == '남자' ? 'checked' : ''}>
                            <label class="custom-control-label" for="male">남자</label>
                        </div>
                        <div class="custom-control custom-radio custom-control-inline">
                            <input type="radio" id="female" name="gender" class="custom-control-input" value="여자" ${vo.gender == '여자' ? 'checked' : ''}>
                            <label class="custom-control-label" for="female">여자</label>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label for="birth">생년월일</label>
                    <input type="date" id="birth" name="birth" class="form-control" value="${vo.birth}" required>
                </div>

                <div class="form-group">
                    <label for="tel">연락처</label>
                    <input type="tel" id="tel" name="tel" class="form-control" value="${vo.tel}">
                </div>

                <div class="form-group">
                    <label for="email">이메일</label>
                    <input type="email" id="email" name="email" class="form-control" value="${vo.email}" required>
                </div>

                <div class="button-group">
                    <button type="submit" class="btn btn-save">수정하기</button>
                    <button type="button" class="btn btn-cancel" onclick="location.href='view.do'">취소</button>
                </div>
            </form>
        </main>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.min.js"></script>
<script>
$(function() {
    $("#updateForm").submit(function() {
        if(confirm("회원정보를 수정하시겠습니까?")) {
            return true;
        }
        return false;
    });
});
</script>
</body>
</html>