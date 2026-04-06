<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>가이드 수정 - ${vo.title}</title>

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

        <div class="page-title">가이드 수정</div>
        <div class="page-desc">기존 내용을 수정하세요.</div>

        <form action="update.do" method="post">

            <input type="hidden" name="no" value="${vo.no}">
            <input type="hidden" name="page" value="${param.page}">
            <input type="hidden" name="perPageNum" value="${param.perPageNum}">

            <div class="form-group">
                <label>제목 *</label>
                <input type="text" name="title" value="${vo.title}" required class="input">
            </div>

            <div class="form-group">
                <label>카테고리</label>
                <select name="category" class="input">
                    <option ${vo.category == '재난 대비' ? 'selected' : ''}>재난 대비</option>
                    <option ${vo.category == '안전 점검' ? 'selected' : ''}>안전 점검</option>
                    <option ${vo.category == '응급 처치' ? 'selected' : ''}>응급 처치</option>
                </select>
            </div>

            <div class="form-group">
                <label>상태</label>
                <select name="status" class="input">
                    <option value="발행됨" ${vo.status == '발행됨' ? 'selected' : ''}>발행됨</option>
                    <option value="임시저장" ${vo.status == '임시저장' ? 'selected' : ''}>임시저장</option>
                </select>
            </div>

            <div class="form-group">
                <label>작성자 *</label>
                <input type="text" name="writer" value="${vo.writer}" required class="input">
            </div>

            <div class="form-group">
                <label>요약 *</label>
                <textarea name="summary" rows="3" class="input">${vo.summary}</textarea>
            </div>

            <div class="form-group">
                <label>본문 *</label>
                <textarea name="content" rows="12" class="input">${vo.content}</textarea>
            </div>

            <div class="form-group">
                <label>태그</label>
                <input type="text" name="tags" value="${vo.tags}" class="input">
            </div>

            <div class="btn-area">
                <button type="submit" class="btn btn-primary">
                    수정 완료
                </button>

                <a href="view.do?no=${vo.no}&page=${param.page}&perPageNum=${param.perPageNum}" class="btn btn-outline">
                    취소
                </a>
            </div>

        </form>

    </div>

</div>

</body>
</html>
