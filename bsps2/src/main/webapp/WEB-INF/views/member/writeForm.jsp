<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<style>
    /* 전체 레이아웃 1100px 통일 */
    body { font-family: 'Malgun Gothic', sans-serif; background-color: #f4f4f4; margin: 0; padding: 0; }
    .container { width: 1100px; margin: 30px auto; border: 1px solid #ccc; background-color: #fff; box-shadow: 0 0 15px rgba(0,0,0,0.1); border-radius: 8px; overflow: hidden; }
    
    header { background-color: #001f3f; color: white; padding: 20px 30px; text-align: center; }
    header h1 { font-size: 20px; margin: 0; }

    main { padding: 50px; }
    .content-title { font-size: 24px; font-weight: bold; text-align: center; margin-bottom: 40px; color: #333; }
    
    #writeForm { max-width: 600px; margin: 0 auto; }
    .form-group label { font-size: 14px; font-weight: bold; color: #333; margin-bottom: 10px; }
    .form-control { font-size: 14px; padding: 10px; }
    
    .gender-box { padding: 10px; border: 1px solid #ced4da; border-radius: 4px; background-color: #fff; font-size: 14px; }

    .button-group { display: flex; gap: 15px; justify-content: center; margin-top: 40px; }
    .btn-submit { background-color: #001f3f; color: white; border: none; padding: 12px 40px; border-radius: 4px; font-weight: bold; font-size: 14px; }
    .btn-cancel { background-color: #6c757d; color: white; border: none; padding: 12px 40px; border-radius: 4px; font-size: 14px; }
</style>
</head>
<body>

<div class="container">
    <header>
        <h1>재난/안전 정보 사이트</h1>
    </header>

    <main>
        <div class="content-title">회원가입</div>
        
        <form action="write.do" method="post" id="writeForm">
            <div class="form-group">
                <label for="id">아이디</label>
                <input type="text" id="id" name="id" class="form-control" placeholder="아이디를 입력하세요" required>
            </div>
            <div class="form-group">
                <label for="pw">비밀번호</label>
                <input type="password" id="pw" name="pw" class="form-control" placeholder="비밀번호를 입력하세요" required>
            </div>
            <div class="form-group">
                <label for="name">이름</label>
                <input type="text" id="name" name="name" class="form-control" placeholder="이름을 입력하세요" required>
            </div>
            <div class="form-group">
                <label>성별</label>
                <div class="gender-box">
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
            <div class="form-group">
                <label for="birth">생년월일</label>
                <input type="date" id="birth" name="birth" class="form-control" required>
            </div>
            <div class="form-group">
                <label for="tel">연락처</label>
                <input type="tel" id="tel" name="tel" class="form-control" placeholder="010-0000-0000">
            </div>
            <div class="form-group">
                <label for="email">이메일</label>
                <input type="email" id="email" name="email" class="form-control" placeholder="example@naver.com" required>
            </div>

            <div class="button-group">
                <button type="submit" class="btn btn-submit">가입하기</button>
                <button type="button" class="btn btn-cancel" onclick="history.back()">취소</button>
            </div>
        </form>
    </main>
</div>

</body>
</html>