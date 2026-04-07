<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
<style>
    body { font-family: 'Noto Sans KR', sans-serif; margin: 0; padding: 0; background-color: #f4f7f9; color: #2c3e50; }
    
    .container { width: 1100px; margin: 50px auto; background-color: #fff; border-radius: 16px; box-shadow: 0 10px 30px rgba(0,0,0,0.05); overflow: hidden; min-height: 800px; }
    
    :root { --main-navy: #1a2a4e; --accent-blue: #3498db; --border-light: #eff2f5; }

    main { padding: 60px 50px; }
    
    .form-header { text-align: center; margin-bottom: 50px; }
    .form-header .icon { font-size: 32px; margin-bottom: 10px; display: block; }
    .form-header .list-title { font-size: 28px; font-weight: 700; color: var(--main-navy); margin: 0; }
    .form-header .sub-text { font-size: 14px; color: #7f8c8d; margin-top: 10px; }

    #writeForm { max-width: 550px; margin: 0 auto; }

    .form-group { margin-bottom: 25px; }
    .form-group label { display: block; font-size: 13px; font-weight: 700; color: #94a3b8; margin-bottom: 10px; text-transform: uppercase; letter-spacing: 0.5px; }
    
    .form-control { width: 100%; padding: 14px 16px; border: 1px solid #e1e4e8; border-radius: 10px; font-size: 15px; outline: none; transition: 0.3s; box-sizing: border-box; background-color: #f8f9fa; }
    .form-control:focus { border-color: var(--accent-blue); background-color: #fff; box-shadow: 0 0 8px rgba(52, 152, 219, 0.1); }
    
    .gender-box { display: flex; gap: 20px; padding: 12px 16px; background-color: #f8f9fa; border: 1px solid #e1e4e8; border-radius: 10px; }
    .gender-item { display: flex; align-items: center; cursor: pointer; font-size: 15px; color: #555; }
    .gender-item input { margin-right: 8px; cursor: pointer; }

    .button-group { display: flex; gap: 15px; justify-content: center; margin-top: 50px; }
    .btn-submit { flex: 2; background-color: var(--main-navy); color: white; padding: 16px; border: none; border-radius: 10px; font-weight: 700; font-size: 16px; cursor: pointer; box-shadow: 0 4px 12px rgba(26, 42, 78, 0.15); transition: 0.3s; }
    .btn-submit:hover { transform: translateY(-2px); box-shadow: 0 6px 15px rgba(26, 42, 78, 0.25); background-color: #233966; }
    
    .btn-cancel { flex: 1; background-color: #fff; color: #94a3b8; padding: 16px; border: 1px solid #e1e4e8; border-radius: 10px; font-weight: 600; font-size: 16px; cursor: pointer; transition: 0.2s; }
    .btn-cancel:hover { background-color: #f8f9fa; color: #64748b; }
</style>
</head>
<body>

<div class="container">
    <main>
        <div class="form-header">
            <span class="icon">📝</span>
            <h1 class="list-title">회원가입</h1>
            <p class="sub-text">안전한 서비스 이용을 위해 정보를 입력해주세요</p>
        </div>
        
        <form action="write.do" method="post" id="writeForm">
            <div class="form-group">
                <label for="id">ID</label>
                <input type="text" id="id" name="id" class="form-control" placeholder="사용할 아이디를 입력하세요" required>
            </div>
            <div class="form-group">
                <label for="pw">Password</label>
                <input type="password" id="pw" name="pw" class="form-control" placeholder="비밀번호를 입력하세요" required>
            </div>
            <div class="form-group">
                <label for="name">Name</label>
                <input type="text" id="name" name="name" class="form-control" placeholder="실명을 입력하세요" required>
            </div>
            <div class="form-group">
                <label>Gender</label>
                <div class="gender-box">
                    <label class="gender-item">
                        <input type="radio" name="gender" value="남자" checked> 남자
                    </label>
                    <label class="gender-item">
                        <input type="radio" name="gender" value="여자"> 여자
                    </label>
                </div>
            </div>
            <div class="form-group">
                <label for="birth">Birth Date</label>
                <input type="date" id="birth" name="birth" class="form-control" required>
            </div>
            <div class="form-group">
                <label for="tel">Phone</label>
                <input type="tel" id="tel" name="tel" class="form-control" placeholder="010-0000-0000">
            </div>
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" class="form-control" placeholder="example@domain.com" required>
            </div>

            <div class="button-group">
                <button type="submit" class="btn-submit">가입하기</button>
                <button type="button" class="btn-cancel" onclick="history.back()">취소</button>
            </div>
        </form>
    </main>
</div>

</body>
</html>