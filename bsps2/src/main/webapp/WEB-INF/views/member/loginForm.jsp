<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
<style>
    body { font-family: 'Noto Sans KR', sans-serif; margin: 0; padding: 0; background-color: #f4f7f9; color: #2c3e50; display: flex; justify-content: center; align-items: center; min-height: 100vh; }
    
    .container { width: 1100px; margin: 50px auto; background-color: #fff; border-radius: 16px; box-shadow: 0 10px 30px rgba(0,0,0,0.05); overflow: hidden; min-height: 700px; display: flex; flex-direction: column; }
    
    :root { --main-navy: #1a2a4e; --accent-blue: #3498db; --border-light: #eff2f5; }

    main { flex: 1; display: flex; justify-content: center; align-items: center; padding: 50px; }
    
    .login-box { width: 400px; padding: 20px; }
    
    .login-header { text-align: center; margin-bottom: 40px; }
    .login-header .icon { font-size: 40px; margin-bottom: 15px; display: block; }
    .login-header .list-title { font-size: 28px; font-weight: 700; color: var(--main-navy); margin: 0; }
    .login-header .sub-text { font-size: 14px; color: #7f8c8d; margin-top: 10px; }

    .form-group { margin-bottom: 20px; }
    .form-group label { display: block; font-size: 13px; font-weight: 700; color: #94a3b8; margin-bottom: 8px; text-transform: uppercase; letter-spacing: 0.5px; }
    
    .form-control { width: 100%; padding: 14px 16px; border: 1px solid #e1e4e8; border-radius: 10px; font-size: 15px; outline: none; transition: 0.3s; box-sizing: border-box; background-color: #f8f9fa; }
    .form-control:focus { border-color: var(--accent-blue); background-color: #fff; box-shadow: 0 0 8px rgba(52, 152, 219, 0.1); }

    .btn-login { width: 100%; background-color: var(--main-navy); color: white; padding: 15px; border: none; border-radius: 10px; font-weight: 700; font-size: 16px; cursor: pointer; margin-top: 10px; box-shadow: 0 4px 12px rgba(26, 42, 78, 0.15); transition: 0.3s; }
    .btn-login:hover { transform: translateY(-2px); box-shadow: 0 6px 15px rgba(26, 42, 78, 0.25); background-color: #233966; }
    
    .login-footer { text-align: center; margin-top: 30px; font-size: 14px; color: #64748b; }
    .login-footer a { color: var(--accent-blue); text-decoration: none; font-weight: 600; margin-left: 5px; border-bottom: 1px solid transparent; transition: 0.2s; }
    .login-footer a:hover { border-bottom: 1px solid var(--accent-blue); }

    .home-link { text-align: center; margin-top: 20px; }
    .home-link a { font-size: 13px; color: #94a3b8; text-decoration: none; }
</style>
</head>
<body>

<div class="container">
    <main>
        <div class="login-box">
            <div class="login-header">
                <span class="icon">🔒</span>
                <h1 class="list-title">로그인</h1>
                <p class="sub-text">재난안전 정보 사이트에 오신 것을 환영합니다</p>
            </div>

            <form action="login.do" method="post">
                <div class="form-group">
                    <label for="id">ID</label>
                    <input type="text" id="id" name="id" class="form-control" placeholder="아이디를 입력하세요" required>
                </div>
                <div class="form-group">
                    <label for="pw">Password</label>
                    <input type="password" id="pw" name="pw" class="form-control" placeholder="비밀번호를 입력하세요" required>
                </div>
                <button type="submit" class="btn-login">로그인하기</button>
            </form>

            <div class="login-footer">
                아직 회원이 아니신가요? <a href="writeForm.do">회원가입 하기</a>
            </div>
            
            <div class="home-link">
                <a href="${pageContext.request.contextPath}/main.do">메인으로 돌아가기</a>
            </div>
        </div>
    </main>
</div>

</body>
</html>