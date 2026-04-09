<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA 질문 수정</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
<style>
    body { font-family: 'Noto Sans KR', sans-serif; margin: 0; padding: 0; background-color: #f0f2f5; color: #333; }
    
    :root { --main-navy: #1a2a4e; --accent-blue: #3498db; --border-color: #e1e4e8; --bg-light: #f8f9fa; }

    .main-container {
        width: 900px;
        margin: 60px auto;
        background-color: #ffffff;
        border-radius: 16px;
        box-shadow: 0 10px 30px rgba(0,0,0,0.08);
        overflow: hidden;
    }

    main {
        padding: 60px;
    }

    .form-title {
        margin-bottom: 45px;
        border-bottom: 2px solid #f1f5f9;
        padding-bottom: 25px;
    }

    .form-title h2 {
        font-size: 28px;
        font-weight: 700;
        color: #1e293b;
        margin: 0;
    }

    .form-title p {
        color: #64748b;
        font-size: 15px;
        margin: 10px 0 0 0;
    }

    .input-group {
        margin-bottom: 25px;
    }

    .input-group label {
        display: block;
        font-size: 14px;
        font-weight: 600;
        margin-bottom: 10px;
        color: #475569;
    }

    .input-group input[type="text"], 
    .input-group input[type="password"],
    .input-group textarea {
        width: 100%;
        padding: 15px 18px;
        border: 1.5px solid var(--border-color);
        border-radius: 12px;
        box-sizing: border-box;
        background-color: #fff;
        font-size: 15px;
        transition: all 0.2s ease-in-out;
        outline: none;
    }

    .input-group input:focus, .input-group textarea:focus {
        border-color: var(--accent-blue);
        box-shadow: 0 0 0 4px rgba(52, 152, 219, 0.1);
    }

    .input-group input[readonly] {
        background-color: var(--bg-light);
        color: #94a3b8;
        cursor: not-allowed;
        border-color: #eee;
    }

    .input-group textarea {
        height: 300px;
        resize: none;
        line-height: 1.7;
    }

    .flex-row {
        display: flex;
        gap: 20px;
        margin-top: 10px;
    }

    .flex-row .input-group {
        flex: 1;
    }

    .btn-area {
        display: flex;
        justify-content: center;
        gap: 12px;
        margin-top: 50px;
        padding-top: 30px;
        border-top: 1px solid #f1f5f9;
    }

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
        text-align: center;
    }

    .btn-submit {
        background-color: var(--main-navy);
        color: white;
        box-shadow: 0 4px 12px rgba(26, 42, 78, 0.2);
    }

    .btn-submit:hover {
        background-color: #233966;
        transform: translateY(-2px);
    }

    .btn-cancel {
        background-color: #f1f5f9;
        color: #64748b;
    }

    .btn-cancel:hover {
        background-color: #e2e8f0;
    }
</style>
</head>
<body>

<div class="main-container">
    <main>
        <div class="form-title">
            <h2>질문 내용 수정</h2>
            <p>기존에 작성하신 내용을 확인하고 필요한 부분을 수정해 주세요.</p>
        </div>

        <form action="update.do" method="post" id="editForm">
            <input type="hidden" name="no" value="${vo.no}">
            
            <div class="flex-row">
                <div class="input-group">
                    <label>글번호</label>
                    <input type="text" value="${vo.no}" readonly>
                </div>
                <div class="input-group">
                    <label>작성자</label>
                    <input type="text" name="name" value="${vo.name}" readonly>
                </div>
            </div>

            <div class="input-group">
                <label>제목</label>
                <input type="text" name="title" value="${vo.title}" placeholder="수정할 제목을 입력하세요" required>
            </div>

            <div class="input-group">
                <label>내용</label>
                <textarea name="content" placeholder="수정할 내용을 상세히 입력해 주세요" required>${vo.content}</textarea>
            </div>

            <div class="input-group" style="width: 50%;">
                <label>비밀번호 확인</label>
                <input type="password" name="pw" placeholder="비밀번호를 입력해 주세요" required>
            </div>

            <div class="btn-area">
                <button type="button" class="btn btn-cancel" onclick="location.href='view.do?no=${vo.no}&inc=0'">취소하고 돌아가기</button>
                <button type="submit" class="btn btn-submit">수정 완료</button>
            </div>
        </form>
    </main>
</div>

<script>
    document.getElementById('editForm').onsubmit = function(e) {
        const title = this.title.value.trim();
        const content = this.content.value.trim();

        if(title.length < 4 || title.length > 100) {
            alert("제목은 4자에서 100자 사이로 입력해 주세요.");
            return false;
        }

        if(content.length < 4 || content.length > 1500) {
            alert("내용은 4자에서 1500자 사이로 입력해 주세요.");
            return false;
        }

        return confirm("수정된 내용을 저장하시겠습니까?");
    };
</script>

</body>
</html>