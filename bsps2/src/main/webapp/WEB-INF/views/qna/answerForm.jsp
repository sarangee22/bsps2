<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA 답변하기</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
<style>
    body { font-family: 'Noto Sans KR', sans-serif; margin: 0; padding: 0; background-color: #f0f2f5; color: #333; }
    
    :root { --main-navy: #1a2a4e; --accent-blue: #3498db; --border-color: #e1e4e8; --bg-light: #f8f9fa; }

    .container { width: 900px; margin: 60px auto; background-color: #fff; border-radius: 16px; box-shadow: 0 10px 30px rgba(0,0,0,0.08); overflow: hidden; }

    header { display: none; }

    main { padding: 80px 60px 50px 60px; }

    .form-title { text-align: left; margin-bottom: 40px; border-bottom: 2px solid #f1f5f9; padding-bottom: 20px; }
    .form-title h2 { font-size: 32px; font-weight: 700; color: #1e293b; margin: 0 0 10px 0; display: flex; align-items: center; gap: 10px; }
    .form-title h2::before { content: 'RE:'; color: var(--accent-blue); font-size: 20px; font-weight: 900; background-color: #eff6ff; padding: 4px 10px; border-radius: 8px; }
    .form-title p { color: #64748b; font-size: 15px; margin: 0; }

    .input-group { margin-bottom: 25px; }
    .input-group label { display: block; font-size: 14px; font-weight: 600; margin-bottom: 10px; color: #475569; }
    
    .input-group input[type="text"], 
    .input-group input[type="password"],
    .input-group textarea { 
        width: 100%; 
        padding: 16px 18px; 
        border: 1.5px solid var(--border-color); 
        border-radius: 12px; 
        box-sizing: border-box; 
        background-color: #fff; 
        font-size: 15px; 
        transition: all 0.3sease-in-out; 
        outline: none;
    }

    .input-group input:focus, .input-group textarea:focus { 
        border-color: var(--accent-blue); 
        box-shadow: 0 0 0 4px rgba(52, 152, 219, 0.1); 
    }

    .input-group input[readonly] { background-color: var(--bg-light); color: #94a3b8; cursor: not-allowed; border-color: #eee; }

    .input-group textarea { height: 300px; resize: none; line-height: 1.6; }

    .flex-row { display: flex; gap: 20px; margin-top: 10px; }
    .flex-row .input-group { flex: 1; }

    .btn-area { display: flex; justify-content: center; gap: 12px; margin-top: 50px; padding-top: 30px; border-top: 1px solid #f1f5f9; }
    
    .btn { 
        padding: 18px 45px; 
        border-radius: 12px; 
        cursor: pointer; 
        font-weight: 700; 
        font-size: 16px; 
        transition: 0.3s; 
        border: none; 
        text-decoration: none; 
        display: inline-block; 
    }

    .btn-submit { background-color: var(--main-navy); color: white; box-shadow: 0 4px 12px rgba(26, 42, 78, 0.2); }
    .btn-submit:hover { background-color: #233966; transform: translateY(-2px); }

    .btn-cancel { background-color: #f1f5f9; color: #64748b; }
    .btn-cancel:hover { background-color: #e2e8f0; }

    .btn-reset { background-color: transparent; color: #94a3b8; border: 1px solid #e2e8f0; }
    .btn-reset:hover { background-color: #f8fafc; color: #64748b; }
</style>
</head>
<body>

<div class="container">
    <header>재난/안전 정보 시스템</header>

    <main>
        <div class="form-title">
            <h2>답변하기</h2>
            <p>질문에 대한 정확하고 상세한 답변을 남겨주세요.</p>
        </div>

        <form action="answer.do" method="post" id="qnaForm">
            
            <input type="hidden" name="no" value="${vo.no}">
            <input type="hidden" name="refNo" value="${vo.refNo}">
            <input type="hidden" name="ordNo" value="${vo.ordNo}">
            <input type="hidden" name="levNo" value="${vo.levNo}">

            <div class="input-group">
                <label>답변 제목</label>
                <input type="text" name="title" value="RE: ${vo.title}" required placeholder="제목을 입력해주세요">
            </div>

            <div class="input-group">
                <label>답변 내용</label>
                <textarea name="content" placeholder="답변 내용을 상세히 입력해주세요 (4~1500자)" required></textarea>
            </div>

            <div class="flex-row">
                <div class="input-group">
                    <label>작성자</label>
                    <input type="text" name="name" value="${login.name}" readonly>
                </div>
                <div class="input-group">
                    <label>비밀번호</label>
                    <input type="password" name="pw" placeholder="4~20자 입력" required>
                </div>
                <div class="input-group">
                    <label>비밀번호 확인</label>
                    <input type="password" name="pwConfirm" placeholder="비밀번호 재입력" required>
                </div>
            </div>

            <div class="btn-area">
                <button type="reset" class="btn btn-reset">다시 작성</button>
                <button type="button" class="btn btn-cancel" onclick="history.back()">취소</button>
                <button type="submit" class="btn btn-submit">답변 등록</button>
            </div>
        </form>
    </main>
</div>

<script>
    document.getElementById('qnaForm').onsubmit = function(e) {
        const title = this.title.value.trim();
        const content = this.content.value;
        const pw = this.pw.value;
        const pwConfirm = this.pwConfirm.value;

        if(title.length < 4 || title.length > 100) {
            alert("제목은 4자에서 100자 사이로 입력해주세요.");
            return false;
        }

        if(content.length < 4 || content.length > 1500) {
            alert("내용은 4자에서 1500자 사이로 입력해주세요.");
            return false;
        }

        if(pw !== pwConfirm) {
            alert("비밀번호가 일치하지 않습니다.");
            return false;
        }

        return confirm("답변을 등록하시겠습니까?");
    };
</script>

</body>
</html>