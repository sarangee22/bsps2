<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<style>
    /* 전체 레이아웃 1100px 통일 */
    body { font-family: 'Malgun Gothic', sans-serif; background-color: #f4f4f4; margin: 0; padding: 0; }
    .container { width: 1100px; margin: 50px auto; border: 1px solid #ccc; background-color: #fff; box-shadow: 0 0 15px rgba(0,0,0,0.1); border-radius: 8px; overflow: hidden; min-height: 600px; }
    
    header { background-color: #001f3f; color: white; padding: 20px 30px; text-align: center; }
    header h1 { font-size: 20px; margin: 0; }

    main { padding: 100px 50px; display: flex; justify-content: center; align-items: center; }
    .login-box { width: 400px; } /* 로그인 상자는 중앙에 적절한 크기로 배치 */
    .content-title { font-size: 24px; font-weight: bold; text-align: center; margin-bottom: 40px; color: #333; }
    
    .form-group label { font-size: 14px; font-weight: bold; color: #333; }
    .form-control { font-size: 14px; padding: 10px; }

    .btn-login { background-color: #001f3f; color: white; border: none; width: 100%; padding: 12px; border-radius: 4px; font-weight: bold; font-size: 14px; margin-top: 20px; }
    .btn-login:hover { opacity: 0.9; }
    
    .login-footer { text-align: center; margin-top: 20px; font-size: 13px; color: #666; }
    .login-footer a { color: #001f3f; text-decoration: none; font-weight: bold; }
</style>
</head>
<body>

<div class="container">
    <header>
        <h1>재난/안전 정보 사이트</h1>
    </header>

    <main>
        <div class="login-box">
            <div class="content-title">로그인</div>
            <form action="login.do" method="post">
                <div class="form-group">
                    <label for="id">아이디</label>
                    <input type="text" id="id" name="id" class="form-control" placeholder="아이디를 입력하세요" required>
                </div>
                <div class="form-group">
                    <label for="pw">비밀번호</label>
                    <input type="password" id="pw" name="pw" class="form-control" placeholder="비밀번호를 입력하세요" required>
                </div>
                <button type="submit" class="btn btn-login">로그인</button>
            </form>
            <div class="login-footer">
                아직 회원이 아니신가요? <a href="writeForm.do">회원가입</a>
            </div>
        </div>
    </main>
</div>

</body>
</html>