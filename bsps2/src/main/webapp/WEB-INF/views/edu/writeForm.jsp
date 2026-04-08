<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>새 가이드 작성</title>

<style>
body {
    background-color: #f4f7f9;
    font-family: 'Noto Sans KR', sans-serif;
}

/* 전체 */
.write-wrapper {
    max-width: 1100px;
    margin: 140px auto 80px auto;
}

/* 카드 */
.write-card {
    background: white;
    padding: 50px;
    border-radius: 25px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.05);
}

/* 제목 */
.page-title {
    font-size: 32px;
    font-weight: 800;
    color: #1A237E;
    margin-bottom: 10px;
}

.page-desc {
    color: #777;
    margin-bottom: 40px;
}

/* input */
.form-group {
    margin-bottom: 25px;
}

label {
    display: block;
    font-weight: 700;
    margin-bottom: 8px;
    color: #333;
}

.input {
    width: 100%;
    padding: 14px 16px;
    border-radius: 12px;
    border: 1px solid #ddd;
    font-size: 14px;
    transition: 0.3s;
}

.input:focus {
    outline: none;
    border-color: #1A237E;
    box-shadow: 0 0 8px rgba(26,35,126,0.1);
}

textarea.input {
    resize: vertical;
    line-height: 1.7;
}

/* 버튼 */
.btn-area {
    margin-top: 40px;
    display: flex;
    gap: 10px;
}

.btn {
    padding: 12px 24px;
    border-radius: 12px;
    font-weight: 700;
    font-size: 14px;
    cursor: pointer;
    text-decoration: none;
    transition: 0.3s;
}

.btn-primary {
    background: #1A237E;
    color: white;
}

.btn-primary:hover {
    background: #0d145c;
}

.btn-outline {
    border: 1px solid #ddd;
    background: white;
    color: #555;
}

.btn-outline:hover {
    background: #f1f4f8;
}
</style>
</head>

<body>

<div class="write-wrapper">

    <div class="write-card">

        <div class="page-title">새 가이드 작성</div>
        <div class="page-desc">교육 가이드를 작성하세요.</div>

        <form action="write.do" method="post" id="writeForm">
            <input type="hidden" name="status" id="status" value="발행됨">

            <div class="form-group">
                <label>제목 *</label>
                <input type="text" name="title" required class="input">
            </div>

            <div class="form-group">
                <label>카테고리</label>
                <select name="category" class="input">
                    <option>재난 대비</option>
                    <option>안전 점검</option>
                    <option>응급 처치</option>
                </select>
            </div>

            <div class="form-group">
                <label>작성자 *</label>
                <input type="text" name="writer" required class="input">
            </div>

            <div class="form-group">
                <label>요약 *</label>
                <textarea name="summary" rows="3" class="input"></textarea>
            </div>

            <div class="form-group">
                <label>본문 *</label>
                <textarea name="content" rows="12" class="input"></textarea>
            </div>

            <div class="form-group">
                <label>태그</label>
                <input type="text" name="tags" class="input">
            </div>

            <div class="btn-area">
                <button type="button" onclick="submitForm('발행됨')" class="btn btn-primary">
                    발행하기
                </button>

                

                <a href="list.do" class="btn btn-outline">
                    취소
                </a>
            </div>

        </form>

    </div>

</div>

<script>
function submitForm(statusValue) {
    document.getElementById('status').value = statusValue;
    document.getElementById('writeForm').submit();
}
</script>

</body>
</html>
