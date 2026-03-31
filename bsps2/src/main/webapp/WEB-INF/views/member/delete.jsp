<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 실제 구현 시 세션에서 로그인한 아이디를 가져옵니다.
    // String loginId = (String) session.getAttribute("loginId"); 
    String loginId = "hong123"; // 스토리보드 예시용 데이터
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴</title>
<style>
    /* 기본 레이아웃 (비밀번호 변경 페이지와 동일 유지) */
    body { font-family: 'Malgun Gothic', sans-serif; margin: 0; padding: 0; background-color: #f4f4f4; }
    .container { width: 900px; margin: 50px auto; border: 1px solid #ccc; background-color: #fff; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
    
    :root { --navy-color: #001f3f; }

    header { background-color: var(--navy-color); color: white; padding: 15px 20px; display: flex; justify-content: space-between; align-items: center; }
    .logout-btn { background-color: #fff; color: #333; padding: 5px 15px; border-radius: 20px; text-decoration: none; font-size: 12px; font-weight: bold; }

    .content-wrapper { display: flex; min-height: 550px; }

    aside { width: 200px; border-right: 1px solid #ddd; padding: 20px 0; }
    aside h3 { text-align: center; font-size: 16px; margin-bottom: 20px; }
    aside ul { list-style: none; padding: 0; }
    aside ul li { padding: 12px 20px; border-bottom: 1px solid #eee; font-size: 14px; color: #666; }
    aside ul li.active { background-color: #fce4ec; color: #e91e63; font-weight: bold; } /* 탈퇴 탭 강조 */

    main { flex: 1; padding: 40px; }
    .form-title { text-align: center; margin-bottom: 20px; font-size: 22px; font-weight: bold; }
    
    /* 안내 문구 박스 */
    .info-box { background-color: #eee; padding: 20px; text-align: center; font-size: 14px; line-height: 1.6; margin-bottom: 30px; border-radius: 5px; }

    .input-group { margin-bottom: 20px; }
    .input-group label { display: block; font-size: 13px; font-weight: bold; margin-bottom: 8px; }
    .input-group input { width: 100%; padding: 12px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; background-color: #fff; }
    
    /* 읽기 전용(아이디) 스타일 */
    .input-group input[readonly] { background-color: #e9e9e9; color: #777; cursor: not-allowed; }

    /* 버튼 영역 */
    .btn-area { text-align: center; margin-top: 40px; }
    .btn { padding: 10px 30px; border: none; border-radius: 4px; cursor: pointer; font-weight: bold; font-size: 14px; margin: 0 5px; }
    .btn-delete { background-color: #ff5252; color: white; } /* 탈퇴는 위험 의미로 레드 계열 사용 */
    .btn-cancel { background-color: #aaa; color: white; }

    footer { background-color: var(--navy-color); color: white; text-align: center; padding: 10px; font-size: 12px; }
</style>
</head>
<body>

<div class="container">
    <header>
        <div class="logo">재난/안전 정보 사이트</div>
        <a href="logout.do" class="logout-btn">로그아웃</a>
    </header>

    <div class="content-wrapper">
        <aside>
            <h3>마이페이지</h3>
            <ul>
                <li>내 정보</li>
                <li>회원정보 수정</li>
                <li>비밀번호 변경</li>
                <li class="active">회원 탈퇴</li>
            </ul>
        </aside>

        <main>
            <div class="form-title">회원 탈퇴</div>
            
            <!-- 상단 안내 문구 -->
            <div class="info-box">
                탈퇴 시 정보는 삭제되지 않고<br>
                상태만 '탈퇴'로 변경됩니다.
            </div>

            <form action="memberDelete.do" method="post" id="deleteForm">
                <!-- 아이디 (D1: 세션 자동 세팅, 수정불가) -->
                <div class="input-group">
                    <label>아이디</label>
                    <input type="text" name="id" value="<%= loginId %>" readonly>
                </div>

                <!-- 비밀번호 (D2: 필수 입력) -->
                <div class="input-group">
                    <label>비밀번호</label>
                    <input type="password" name="pw" placeholder="비밀번호 입력" required>
                </div>

                <!-- 이메일 (D3: 이메일 본인확인, 필수 입력) -->
                <div class="input-group">
                    <label>이메일</label>
                    <input type="email" name="email" placeholder="이메일 입력 (본인 확인)" required>
                </div>

                <div class="btn-area">
                    <button type="submit" class="btn btn-delete">탈퇴하기</button>
                    <button type="button" class="btn btn-cancel" onclick="history.back();">취소</button>
                </div>
            </form>
        </main>
    </div>

    <footer>푸터</footer>
</div>

<script>
    document.getElementById('deleteForm').onsubmit = function() {
        return confirm("정말로 탈퇴하시겠습니까?\n탈퇴 후에는 정보 복구가 어려울 수 있습니다.");
    };
</script>

</body>
</html>