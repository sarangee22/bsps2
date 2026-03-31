<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>재난/안전 정보 사이트 - 회원가입</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<style>
/* 전체 페이지 레이아웃 */
body {
    background-color: #f4f4f4;
    padding: 50px 0;
}

/* 기획안의 "페이지 레이아웃" 박스 */
.page-container {
    max-width: 500px;
    margin: 0 auto;
    border: 1px solid #ddd;
    background-color: #fff;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 4px 6px rgba(0,0,0,0.1);
}

/* GNB 영역 - 네이비 테마 */
.gnb {
    background-color: #001f3f;
    padding: 12px 20px;
}
.site-title {
    color: #fff;
    font-size: 16px;
    margin: 0;
    font-weight: bold;
}

/* 메인 컨텐츠 영역 */
.content {
    padding: 30px;
}
.page-title {
    text-align: center;
    font-size: 20px;
    font-weight: bold;
    margin-bottom: 30px;
    border-bottom: 2px solid #001f3f;
    padding-bottom: 10px;
}

/* 폼 스타일 */
.form-group label {
    font-size: 13px;
    font-weight: bold;
    color: #333;
}
.form-control {
    font-size: 14px;
}
.form-control:focus {
    border-color: #001f3f;
    box-shadow: 0 0 0 0.2rem rgba(0, 31, 63, 0.25);
}

/* 중복확인 버튼 */
.btn-overlap {
    background-color: #6c757d;
    color: white;
    font-size: 12px;
}

/* 하단 버튼 그룹 - 네이비 강조 */
.button-group {
    display: flex;
    gap: 10px;
    justify-content: center;
    margin-top: 30px;
}
.btn-submit {
    background-color: #001f3f;
    color: white;
    flex: 2;
}
.btn-cancel, .btn-reset {
    background-color: #6c757d;
    color: white;
    flex: 1;
}
.btn-submit:hover { background-color: #003366; color: white; }

/* 푸터 */
.footer {
    background-color: #f1f1f1;
    padding: 10px;
    text-align: center;
    font-size: 11px;
    color: #999;
    border-top: 1px solid #ddd;
}
</style>
</head>
<body>

<div class="page-container">
    <!-- GNB -->
    <header class="gnb">
        <h1 class="site-title">재난/안전 정보 사이트</h1>
    </header>

    <main class="content">
        <h2 class="page-title">회원가입</h2>
        
        <form action="write.do" method="post" id="writeForm">
            <!-- 아이디 (D1) -->
            <div class="form-group">
                <label for="id">아이디</label>
                <div class="input-group">
                    <input type="text" id="id" name="id" class="form-control" placeholder="영숫자 3~20자" required>
                    <div class="input-group-append">
                        <button class="btn btn-overlap" type="button" id="checkIdBtn">중복확인</button>
                    </div>
                </div>
            </div>

            <div class="row">
                <!-- 비밀번호 (D2) -->
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="pw">비밀번호</label>
                        <input type="password" id="pw" name="pw" class="form-control" placeholder="4~20자" required>
                    </div>
                </div>
                <!-- 비밀번호 확인 (D3) -->
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="pw2">비밀번호 확인</label>
                        <input type="password" id="pw2" class="form-control" placeholder="동일하게 입력" required>
                    </div>
                </div>
            </div>

            <div class="row">
                <!-- 이름 (D4) -->
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="name">이름</label>
                        <input type="text" id="name" name="name" class="form-control" placeholder="한글 2~10자" required>
                    </div>
                </div>
                <!-- 성별 (D5) -->
                <div class="col-md-6">
                    <div class="form-group">
                        <label>성별</label>
                        <div class="mt-2">
                            <div class="custom-control custom-radio custom-control-inline">
                                <input type="radio" id="male" name="gender" class="custom-control-input" value="남자" checked>
                                <label class="custom-control-label" for="male">남자</label>
                            </div>
                            <div class="custom-control custom-radio custom-control-inline">
                                <input type="radio" id="female" name="gender" class="custom-control-input" value="여자">
                                <label class="custom-control-label" for="female">여자</label>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 생년월일 (D6) -->
            <div class="form-group">
                <label for="birth">생년월일</label>
                <input type="date" id="birth" name="birth" class="form-control" required>
            </div>

            <!-- 연락처 (D7) -->
            <div class="form-group">
                <label for="tel">연락처</label>
                <input type="tel" id="tel" name="tel" class="form-control" placeholder="010-XXXX-XXXX">
            </div>

            <!-- 이메일 (D8) -->
            <div class="form-group">
                <label for="email">이메일</label>
                <input type="email" id="email" name="email" class="form-control" placeholder="아이디@도메인 (필수)" required>
            </div>

            <!-- 하단 버튼 그룹 (L1, L2) -->
            <div class="button-group">
                <button type="submit" class="btn btn-submit">가입하기</button>
                <button type="button" class="btn btn-cancel" onclick="history.back();">취소</button>
                <button type="reset" class="btn btn-reset">다시 입력</button>
            </div>
        </form>
    </main>

    <footer class="footer">
        © Disaster/Safety Info
    </footer>
</div>

<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.min.js"></script>
<script>
$(function() {
    // 기획안 기반 로직 구현
    $("#writeForm").submit(function() {
        // 비밀번호 확인 체크
        if($("#pw").val() !== $("#pw2").val()) {
            alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
            $("#pw2").focus();
            return false;
        }
        
        // 성공 시 팝업 문구 (기획안 내용)
        if(confirm("축하드립니다. 로그인 페이지로 이동하시겠습니까?")) {
            return true; // 서블릿으로 전송
        } else {
            return false;
        }
    });

    // 아이디 중복 확인 버튼 클릭 이벤트
    $("#checkIdBtn").click(function() {
        let id = $("#id").val();
        if(!id) {
            alert("아이디를 입력하세요.");
            return;
        }
        // 실제 구현 시 window.open이나 Ajax 연동
        alert("중복 확인을 진행합니다.");
    });
});
</script>
</body>
</html>