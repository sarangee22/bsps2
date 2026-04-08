<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>작성 페이지</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
<style>
    body { font-family: 'Noto Sans KR', sans-serif; margin: 0; padding: 0; background-color: #f4f7f9; color: #2c3e50; }
    .container { width: 1100px; margin: 50px auto; background-color: #fff; border-radius: 16px; box-shadow: 0 10px 30px rgba(0,0,0,0.05); overflow: hidden; }
    :root { --main-navy: #1a2a4e; --accent-blue: #3498db; --border-light: #eff2f5; }

    main { padding: 60px 100px; }

    .form-header { text-align: center; margin-bottom: 50px; }
    .form-header .icon { font-size: 32px; margin-bottom: 10px; display: block; }
    .form-header .list-title { font-size: 28px; font-weight: 700; color: var(--main-navy); margin: 0; }
    .form-header .sub-text { font-size: 14px; color: #7f8c8d; margin-top: 10px; }

    .input-row { display: flex; align-items: center; margin-bottom: 20px; }
    .input-row label { width: 100px; font-size: 15px; font-weight: 700; color: #64748b; }
    .input-row .field-wrap { flex: 1; }

    .input-row-top { align-items: flex-start; }
    .input-row-top label { margin-top: 15px; }

    .form-control { width: 100%; padding: 14px 18px; border: 1px solid #e1e4e8; border-radius: 12px; font-size: 15px; outline: none; transition: 0.3s; box-sizing: border-box; background-color: #f8f9fa; }
    .form-control:focus { border-color: var(--accent-blue); background-color: #fff; box-shadow: 0 0 8px rgba(52, 152, 219, 0.1); }
    textarea.form-control { height: 380px; resize: none; line-height: 1.6; }

    .bottom-info-area { display: flex; gap: 20px; margin-top: 30px; padding-left: 100px; }
    .info-column { flex: 1; }
    .info-column label { display: block; font-size: 13px; font-weight: 700; color: #94a3b8; margin-bottom: 8px; }

    .btn-area { display: flex; justify-content: center; gap: 12px; margin-top: 60px; padding-top: 30px; border-top: 1px solid var(--border-light); }
    .btn { padding: 15px 40px; border-radius: 12px; font-weight: 700; font-size: 15px; cursor: pointer; text-decoration: none; transition: 0.3s; border: none; }
    .btn-submit { background-color: var(--main-navy); color: white; box-shadow: 0 4px 12px rgba(26, 42, 78, 0.15); }
    .btn-submit:hover { transform: translateY(-2px); box-shadow: 0 6px 15px rgba(26, 42, 78, 0.25); background-color: #233966; }
    .btn-cancel { background-color: #fff; color: #94a3b8; border: 1px solid #e1e4e8; }
    .btn-cancel:hover { background-color: #f8f9fa; color: #64748b; }
    .btn-reset { background-color: #f1f5f9; color: #64748b; }
</style>
</head>
<body>

<div class="container">
    <main>
        <div class="form-header">
            <span class="icon">✍️</span>
            <h1 class="list-title">
                <c:choose>
                    <c:when test="${login.id == 'admin'}">공지사항 작성</c:when>
                    <c:otherwise>새로운 질문하기</c:otherwise>
                </c:choose>
            </h1>
            <p class="sub-text">내용을 정확하게 입력해주시면 더 빠른 답변이 가능합니다.</p>
        </div>

        <form action="question.do" method="post" id="qnaForm">
            <div class="input-row">
                <label>제목</label>
                <div class="field-wrap">
                    <input type="text" name="title" class="form-control" placeholder="제목을 입력하세요 (4~100자)" required>
                </div>
            </div>

            <div class="input-row input-row-top">
                <label>내용</label>
                <div class="field-wrap">
                    <textarea name="content" class="form-control" placeholder="문의하실 내용을 상세히 적어주세요 (4~1500자)" required></textarea>
                </div>
            </div>

            <div class="bottom-info-area">
                <div class="info-column">
                    <label>작성자 이름</label>
                    <input type="text" name="name" class="form-control" placeholder="한글 2~10자" required>
                </div>
                <div class="info-column">
                    <label>비밀번호</label>
                    <input type="password" name="pw" class="form-control" placeholder="4~20자" required>
                </div>
                <div class="info-column">
                    <label>비밀번호 확인</label>
                    <input type="password" name="pwConfirm" class="form-control" placeholder="동일하게 입력" required>
                </div>
            </div>

            <div class="btn-area">
                <button type="submit" class="btn btn-submit">등록하기</button>
                <button type="button" class="btn btn-cancel" onclick="location.href='list.do'">취소</button>
                <button type="reset" class="btn btn-reset">초기화</button>
            </div>
        </form>
    </main>
</div>

<script>
    document.getElementById('qnaForm').onsubmit = function() {
        const title = this.title.value.trim();
        const content = this.content.value;
        const name = this.name.value;
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
        if(!/^[가-힣]{2,10}$/.test(name)) {
            alert("작성자는 한글 2~10자 이내로 입력해주세요.");
            return false;
        }
        if(pw !== pwConfirm) {
            alert("비밀번호가 일치하지 않습니다.");
            return false;
        }
        return confirm("등록하시겠습니까?");
    };
</script>

</body>
</html>