<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>재난/안전 정보 사이트 - 회원가입</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<style>
    /* 전체 배경 및 중앙 정렬 */
    body {
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
        margin: 0;
        background-color: #f4f4f4;
        padding: 60px 0; /* 위아래 여백 */
    }

    /* 회원가입 박스: 로그인보다 넓게 설정 (700px) */
    .page-container {
        width: 700px;
        border: 1px solid #ddd;
        background-color: #fff;
        border-radius: 12px;
        box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        overflow: hidden;
    }

    /* 상단바: 네이비 테마 및 제목 중앙 */
    .gnb {
        background-color: #001f3f;
        padding: 20px;
        text-align: center;
    }
    .site-title {
        color: #fff;
        font-size: 18px;
        margin: 0;
        letter-spacing: 1px;
    }

    /* 메인 컨텐츠 영역 */
    .write-content {
        padding: 50px 60px;
    }

    .write-title {
        text-align: center;
        font-size: 28px;
        font-weight: bold;
        margin-bottom: 40px;
        color: #222;
    }

    /* 입력 폼 라벨 스타일 */
    .form-group label {
        font-weight: bold;
        font-size: 15px;
        color: #555;
        margin-bottom: 10px;
    }

    /* 입력창 높이 및 폰트 크기 통일 */
    .form-control {
        height: 50px;
        font-size: 15px;
        border-radius: 6px;
    }

    /* 아이디 중복확인 영역: 버튼 높이를 입력창과 동일하게 */
    .id-check-group {
        display: flex;
        gap: 10px;
    }
    .btn-id-check {
        width: 120px;
        background-color: #666;
        color: white;
        border: none;
        border-radius: 6px;
        font-weight: bold;
        font-size: 14px;
        transition: 0.3s;
    }
    .btn-id-check:hover { background-color: #444; }

    /* 성별 라디오 버튼 배치 */
    .gender-wrap {
        display: flex;
        gap: 40px;
        padding: 10px 0;
    }
    .gender-wrap input { margin-right: 8px; transform: scale(1.2); }

    /* 하단 버튼 영역: 균일한 배치 (Flex 활용) */
    .btn-area {
        display: flex;
        justify-content: center;
        gap: 15px;
        margin-top: 50px;
    }
    .btn-area .btn {
        flex: 1; /* 버튼들이 동일한 너비를 가짐 */
        padding: 15px;
        font-size: 17px;
        font-weight: bold;
        border-radius: 6px;
        border: none;
        transition: 0.3s;
    }

    /* 버튼 색상 */
    .btn-submit { background-color: #001f3f; color: white; } /* 가입하기 */
    .btn-cancel { background-color: #888; color: white; }    /* 취소 */
    .btn-reset  { background-color: #eee; color: #333; border: 1px solid #ccc !important; } /* 다시입력 */

    .btn-submit:hover { opacity: 0.9; }
    .btn-cancel:hover { background-color: #666; }
    .btn-reset:hover { background-color: #ddd; }

    /* 푸터 */
    .footer {
        background-color: #fafafa;
        padding: 20px;
        text-align: center;
        font-size: 12px;
        color: #aaa;
        border-top: 1px solid #eee;
    }
</style>
</head>
<body>

<div class="page-container">
    <header class="gnb">
        <h1 class="site-title">재난/안전 정보 사이트</h1>
    </header>

    <main class="write-content">
        <h2 class="write-title">회원가입</h2>

        <form action="/member/write.do" method="post">
            <!-- 아이디 + 중복확인 -->
            <div class="form-group">
                <label>아이디</label>
                <div class="id-check-group">
                    <input type="text" name="id" class="form-control" placeholder="영숫자 3~20자" required>
                    <button type="button" class="btn-id-check">중복확인</button>
                </div>
            </div>

            <!-- 비밀번호 가로 배치 -->
            <div class="row">
                <div class="col-md-6 form-group">
                    <label>비밀번호</label>
                    <input type="password" name="pw" class="form-control" placeholder="4~20자" required>
                </div>
                <div class="col-md-6 form-group">
                    <label>비밀번호 확인</label>
                    <input type="password" name="pwConfirm" class="form-control" placeholder="동일하게 입력" required>
                </div>
            </div>

            <!-- 이름 + 성별 가로 배치 -->
            <div class="row align-items-end">
                <div class="col-md-6 form-group">
                    <label>이름</label>
                    <input type="text" name="name" class="form-control" placeholder="한글 2~10자" required>
                </div>
                <div class="col-md-6 form-group">
                    <label>성별</label>
                    <div class="gender-wrap">
                        <label style="font-weight: normal;"><input type="radio" name="gender" value="남자" checked> 남자</label>
                        <label style="font-weight: normal;"><input type="radio" name="gender" value="여자"> 여자</label>
                    </div>
                </div>
            </div>

            <div class="form-group">
                <label>생년월일</label>
                <input type="date" name="birth" class="form-control" required>
            </div>

            <div class="form-group">
                <label>연락처</label>
                <input type="tel" name="tel" class="form-control" placeholder="010-XXXX-XXXX" required>
            </div>

            <div class="form-group">
                <label>이메일</label>
                <input type="email" name="email" class="form-control" placeholder="아이디@도메인 (필수)" required>
            </div>

            <!-- 하단 버튼: Flex로 너비 균일화 -->
            <div class="btn-area">
                <button type="submit" class="btn btn-submit">가입하기</button>
                <button type="button" class="btn btn-cancel" onclick="history.back()">취소</button>
                <button type="reset" class="btn btn-reset">다시 입력</button>
            </div>
        </form>
    </main>

    <footer class="footer">
        © Disaster/Safety Info All Rights Reserved.
    </footer>
</div>

</body>
</html>