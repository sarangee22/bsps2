<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>재난/안전 정보 사이트 - 회원정보 수정</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<style>
/* 전체 레이아웃 유지 */
body { background-color: #f4f4f4; padding: 50px 0; }
.page-container {
    max-width: 800px;
    margin: 0 auto;
    border: 1px solid #ddd;
    background-color: #fff;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 4px 6px rgba(0,0,0,0.1);
}

/* GNB & 사이드바 (기존 테마 유지) */
.gnb { background-color: #001f3f; padding: 12px 20px; color: #fff; display: flex; justify-content: space-between; align-items: center; }
.main-layout { display: flex; min-height: 500px; }
.sidebar { width: 200px; background-color: #f8f9fa; border-right: 1px solid #ddd; padding: 20px 0; }
.sidebar-menu { list-style: none; padding: 0; }
.sidebar-menu li a { display: block; padding: 12px 20px; color: #333; text-decoration: none; font-size: 14px; }
.sidebar-menu li a.active { background-color: #001f3f; color: #fff; }

/* 회원정보 수정 컨텐츠 영역 */
.content-edit { flex: 1; padding: 30px; }
.edit-title { text-align: center; font-size: 20px; font-weight: bold; margin-bottom: 30px; }

/* 폼 스타일 */
.form-group label { font-size: 13px; font-weight: bold; color: #444; margin-bottom: 5px; }
.form-control { font-size: 14px; border-radius: 4px; background-color: #fdfdfd; }
.form-control:focus { border-color: #001f3f; box-shadow: 0 0 0 0.2rem rgba(0, 31, 63, 0.15); }

/* 버튼 그룹 */
.button-group { display: flex; gap: 10px; justify-content: center; margin-top: 30px; }
.btn-save { background-color: #001f3f; color: white; border: none; padding: 10px 30px; border-radius: 4px; font-weight: bold; }
.btn-cancel { background-color: #6c757d; color: white; border: none; padding: 10px 30px; border-radius: 4px; }
.btn-save:hover { background-color: #003366; }

.footer { background-color: #eee; padding: 10px; text-align: center; font-size: 11px; color: #888; }
</style>
</head>
<body>

<div class="page-container">
    <header class="gnb">
        <h1 class="site-title" style="font-size:16px; margin:0;">재난/안전 정보 사이트</h1>
        <div class="user-info" style="font-size:14px;">
            <strong>${login.name}</strong>님 <a href="/member/logout.do" style="color:#fff; margin-left:10px; font-size:12px;">로그아웃</a>
        </div>
    </header>

    <div class="main-layout">
        <aside class="sidebar">
            <div style="font-weight:bold; padding:10px 20px; border-bottom:1px solid #ddd; margin-bottom:10px;">마이페이지</div>
            <ul class="sidebar-menu">
                <li><a href="/member/view.do">내 정보</a></li>
                <li><a href="#" class="active">회원정보 수정</a></li>
                <li><a href="/member/changePwForm.do">비밀번호 변경</a></li>
                <li><a href="/member/deleteForm.do" style="color:#dc3545;">회원 탈퇴</a></li>
            </ul>
        </aside>

        <main class="content-edit">
            <h2 class="edit-title">회원정보 수정</h2>
            
            <form action="update.do" method="post" id="updateForm">
                <div class="form-group">
                    <label>아이디</label>
                    <input type="text" class="form-control" value="${vo.id}" readonly style="background-color: #e9ecef;">
                </div>

                <div class="form-group">
                    <label for="name">이름</label>
                    <input type="text" id="name" name="name" class="form-control" value="${vo.name}" placeholder="한글 2~10자" required>
                </div>

                <div class="form-group">
                    <label>성별</label>
                    <div class="mt-1 p-2 border rounded" style="background-color: #fff;">
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
                    <input type="tel" id="tel" name="tel" class="form-control" value="${vo.tel}" placeholder="010-XXXX-XXXX">
                </div>

                <div class="form-group">
                    <label for="email">이메일</label>
                    <input type="email" id="email" name="email" class="form-control" value="${vo.email}" placeholder="아이디@도메인" required>
                </div>

                <div class="button-group">
                    <button type="submit" class="btn btn-save">수정하기</button>
                    <button type="button" class="btn btn-cancel" onclick="location.href='view.do'">취소</button>
                </div>
            </form>
        </main>
    </div>

    <footer class="footer">
        © Disaster/Safety Info
    </footer>
</div>

<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.min.js"></script>
<script>
$(function() {
    $("#updateForm").submit(function() {
        // 기획안 성공 메시지 구현
        if(confirm("회원의 정보가 수정되었습니다. 정보를 확인하시겠습니까?")) {
            return true; // 서블릿 전송
        }
        return false;
    });
});
</script>
</body>
</html>