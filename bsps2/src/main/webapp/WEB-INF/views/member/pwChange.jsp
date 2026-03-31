<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 변경</title>
<style>
    /* 전체 레이아웃 설정 */
    body { font-family: 'Malgun Gothic', sans-serif; margin: 0; padding: 0; background-color: #f4f4f4; }
    .container { width: 900px; margin: 50px auto; border: 1px solid #ccc; background-color: #fff; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
    
    /* 네이비 포인트 컬러 설정 */
    :root { --navy-color: #001f3f; }

    /* 헤더 영역 */
    header { background-color: var(--navy-color); color: white; padding: 15px 20px; display: flex; justify-content: space-between; align-items: center; }
    .logout-btn { background-color: #fff; color: #333; padding: 5px 15px; border-radius: 20px; text-decoration: none; font-size: 12px; font-weight: bold; }

    /* 메인 컨텐츠 영역 */
    .content-wrapper { display: flex; min-height: 500px; }

    /* 사이드바 */
    aside { width: 200px; border-right: 1px solid #ddd; padding: 20px 0; }
    aside h3 { text-align: center; font-size: 16px; margin-bottom: 20px; }
    aside ul { list-style: none; padding: 0; }
    aside ul li { padding: 12px 20px; border-bottom: 1px solid #eee; font-size: 14px; cursor: pointer; }
    aside ul li.active { background-color: var(--navy-color); color: white; }
    aside ul li:hover { background-color: #f0f0f0; color: #333; }
    .withdraw { color: red; text-align: center; margin-top: 30px; font-size: 13px; text-decoration: underline; cursor: pointer; }

    /* 비밀번호 변경 폼 */
    main { flex: 1; padding: 40px; }
    .form-title { text-align: center; margin-bottom: 40px; font-size: 22px; font-weight: bold; }
    
    .input-group { margin-bottom: 20px; }
    .input-group label { display: block; font-size: 13px; font-weight: bold; margin-bottom: 8px; }
    .input-group input { width: 100%; padding: 12px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; background-color: #f9f9f9; }

    /* 버튼 영역 */
    .btn-area { text-align: center; margin-top: 40px; }
    .btn { padding: 10px 30px; border: none; border-radius: 20px; cursor: pointer; font-weight: bold; font-size: 14px; margin: 0 5px; }
    .btn-submit { background-color: var(--navy-color); color: white; }
    .btn-cancel { background-color: #888; color: white; }

    /* 푸터 */
    footer { background-color: var(--navy-color); color: white; text-align: center; padding: 10px; font-size: 12px; }
</style>
</head>
<body>

<div class="container">
    <!-- 상단 헤더 -->
    <header>
        <div class="logo">재난/안전 정보 사이트</div>
        <a href="logout.do" class="logout-btn">로그아웃</a>
    </header>

    <div class="content-wrapper">
        <!-- 왼쪽 사이드바 -->
        <aside>
            <h3>마이페이지</h3>
            <ul>
                <li>내 정보</li>
                <li>회원정보 수정</li>
                <li class="active">비밀번호 변경</li>
            </ul>
            <div class="withdraw">회원 탈퇴</div>
        </aside>

        <!-- 오른쪽 비밀번호 변경 입력창 -->
        <main>
            <div class="form-title">비밀번호 변경</div>
            
            <form action="pwChange.do" method="post" id="pwForm">
                <div class="input-group">
                    <label>현재 비밀번호</label>
                    <input type="password" name="pw" placeholder="현재 비밀번호 입력" required>
                </div>

                <div class="input-group">
                    <label>새 비밀번호 (4~20자)</label>
                    <input type="password" name="newPw" placeholder="새 비밀번호 4~20자" required>
                </div>

                <div class="input-group">
                    <label>비밀번호 확인</label>
                    <input type="password" name="newPwConfirm" placeholder="동일하게 입력" required>
                </div>

                <div class="btn-area">
                    <button type="submit" class="btn btn-submit">변경하기</button>
                    <button type="button" class="btn btn-cancel" onclick="location.href='memberView.do'">취소</button>
                </div>
            </form>
        </main>
    </div>

    <!-- 하단 푸터 -->
    <footer>푸터</footer>
</div>

<script>
    // 간단한 유효성 검사 로직 (기능 구현 시 참고)
    document.getElementById('pwForm').onsubmit = function(e) {
        const newPw = document.getElementsByName('newPw')[0].value;
        const confirmPw = document.getElementsByName('newPwConfirm')[0].value;

        if (newPw.length < 4 || newPw.length > 20) {
            alert("새 비밀번호는 4~20자 사이여야 합니다.");
            return false;
        }

        if (newPw !== confirmPw) {
            alert("새 비밀번호와 확인 입력이 일치하지 않습니다.");
            return false;
        }
        return true;
    };
</script>

</body>
</html>