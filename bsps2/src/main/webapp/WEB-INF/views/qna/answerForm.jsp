<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA 답변하기</title>
<style>
    /* 기존 스타일 유지 */
    body { font-family: 'Malgun Gothic', sans-serif; margin: 0; padding: 0; background-color: #f4f4f4; }
    .container { width: 800px; margin: 50px auto; border: 1px solid #ccc; background-color: #fff; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
    :root { --navy-color: #001f3f; }
    header { background-color: var(--navy-color); color: white; padding: 15px 20px; text-align: center; font-weight: bold; }
    main { padding: 40px; }
    .form-title { text-align: center; margin-bottom: 30px; font-size: 22px; font-weight: bold; border-bottom: 2px solid var(--navy-color); padding-bottom: 10px; }
    .input-group { margin-bottom: 20px; }
    .input-group label { display: block; font-size: 14px; font-weight: bold; margin-bottom: 8px; color: #333; }
    .input-group input[type="text"], 
    .input-group input[type="password"],
    .input-group textarea { width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 4px; box-sizing: border-box; background-color: #fdfdfd; font-size: 14px; }
    .input-group textarea { height: 200px; resize: none; }
    .flex-row { display: flex; gap: 15px; margin-bottom: 20px; }
    .flex-row .input-group { flex: 1; margin-bottom: 0; }
    .btn-area { text-align: center; margin-top: 40px; border-top: 1px solid #eee; padding-top: 30px; }
    .btn { padding: 12px 35px; border-radius: 4px; cursor: pointer; font-weight: bold; font-size: 14px; margin: 0 5px; border: 1px solid #ccc; text-decoration: none; display: inline-block; }
    .btn-submit { background-color: var(--navy-color); color: white; border: none; }
    .btn-cancel { background-color: #888; color: white; border: none; }
    .btn-reset { background-color: #eee; color: #333; }
</style>
</head>
<body>

<div class="container">
    <header>재난/안전 정보 사이트</header>

    <main>
        <div class="form-title">답변하기</div>

        <form action="answer.do" method="post" id="qnaForm">
            
            <input type="hidden" name="no" value="${vo.no}">
            <input type="hidden" name="refNo" value="${vo.refNo}">
            <input type="hidden" name="ordNo" value="${vo.ordNo}">
            <input type="hidden" name="levNo" value="${vo.levNo}">

            <div class="input-group">
                <label>제목</label>
                <input type="text" name="title" value="${vo.title}" required>
            </div>

            <div class="input-group">
                <label>내용</label>
                <textarea name="content" placeholder="답변 내용을 입력해주세요 (4~1500자)" required></textarea>
            </div>

            <div class="flex-row">
                <div class="input-group">
                    <label>작성자</label>
                    <input type="text" name="name" value="${login.name}" readonly>
                </div>
                <div class="input-group">
                    <label>비밀번호</label>
                    <input type="password" name="pw" placeholder="4~20자" required>
                </div>
                <div class="input-group">
                    <label>비밀번호 확인</label>
                    <input type="password" name="pwConfirm" placeholder="동일입력" required>
                </div>
            </div>

            <div class="btn-area">
                <button type="submit" class="btn btn-submit">답변등록</button>
                <button type="button" class="btn btn-cancel" onclick="history.back()">취소</button>
                <button type="reset" class="btn btn-reset">다시 입력</button>
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