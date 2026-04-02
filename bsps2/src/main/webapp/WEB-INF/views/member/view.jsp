<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 정보 보기</title>
<style>
    /* 기본 레이아웃 - 가로 확장 (1100px) */
    body { font-family: 'Malgun Gothic', sans-serif; margin: 0; padding: 0; background-color: #f4f4f4; }
    .container { width: 1100px; margin: 30px auto; border: 1px solid #ccc; background-color: #fff; box-shadow: 0 0 15px rgba(0,0,0,0.1); border-radius: 8px; overflow: hidden; }
    
    :root { --navy-color: #001f3f; }

    /* 상단바 - 로그아웃 버튼 제거하고 사용자 이름만 유지 */
    header { background-color: var(--navy-color); color: white; padding: 15px 30px; display: flex; justify-content: flex-end; align-items: center; }
    .user-area { font-size: 14px; }

    /* 메인 레이아웃 (사이드바 + 컨텐츠) */
    .wrapper { display: flex; min-height: 600px; }
    
    /* 사이드 메뉴 */
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
    
    /* 정보 테이블 스타일 */
    .info-table { width: 100%; border-top: 2px solid var(--navy-color); border-collapse: collapse; }
    .info-table th { width: 180px; background-color: #f8f9fa; padding: 20px; text-align: left; border-bottom: 1px solid #eee; font-size: 14px; color: #333; }
    .info-table td { padding: 20px; border-bottom: 1px solid #eee; font-size: 14px; color: #666; }

    /* 하단 버튼 영역 숨김 */
    .btn-group { display: none; }
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
                <li class="menu-item active"><a href="view.do">내 정보</a></li>
                <li class="menu-item">
                    <a href="${pageContext.request.contextPath}/member/editForm.do">회원정보 수정</a>
                </li>
                <li class="menu-item">
                     <a href="${pageContext.request.contextPath}/member/changePw.do">비밀번호 변경</a>
                <li class="menu-item danger">
                     <a href="${pageContext.request.contextPath}/member/delete.do" 
                         onclick="return confirm('정말로 탈퇴하시겠습니까? 모든 정보가 사라집니다.');">회원 탈퇴</a>
                 </li>
            </ul>
        </aside>

        <main>
            <div class="content-title">내 정보 보기</div>
            
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

            <div class="btn-group"></div>
        </main>
    </div>
</div>

</body>
</html>