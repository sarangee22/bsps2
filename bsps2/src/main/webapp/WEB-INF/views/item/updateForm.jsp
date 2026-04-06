<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>비상물품 수정</title>

<style>
body {
    background-color: #f4f7f9;
    font-family: 'Noto Sans KR', sans-serif;
}

.wrapper {
    max-width: 1000px;
    margin: 130px auto 80px auto;
}

/* 카드 */
.card {
    background: white;
    padding: 40px;
    border-radius: 25px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.05);
}

/* 제목 */
.title {
    font-size: 30px;
    font-weight: 800;
    color: #1A237E;
    margin-bottom: 30px;
}

/* input */
.form-group { margin-bottom: 20px; }

label {
    font-weight: 700;
    display: block;
    margin-bottom: 6px;
    color: #333;
}

.input {
    width: 100%;
    padding: 12px 14px;
    border-radius: 10px;
    border: 1px solid #ddd;
}

.input:focus {
    outline: none;
    border-color: #1A237E;
    box-shadow: 0 0 6px rgba(26,35,126,0.1);
}

/* 버튼 */
.btn-area {
    margin-top: 30px;
    display: flex;
    gap: 10px;
}

.btn {
    padding: 12px 20px;
    border-radius: 10px;
    font-weight: 700;
    text-decoration: none;
}

.btn-primary {
    background: #1A237E;
    color: white;
}

.btn-outline {
    border: 1px solid #ddd;
    background: white;
    color: #555;
}
</style>
</head>

<body>

<div class="wrapper">

    <div class="card">

        <div class="title">비상물품 수정</div>

        <form action="update.do" method="post">

            <input type="hidden" name="no" value="${vo.no}">
            <input type="hidden" name="page" value="${param.page}">
            <input type="hidden" name="perPageNum" value="${param.perPageNum}">

            <div class="form-group">
                <label>물품명 *</label>
                <input type="text" name="name" value="${vo.name}" required class="input">
            </div>

            <div class="form-group">
                <label>카테고리</label>
                <select name="category" class="input">
                    <option ${vo.category == '식수 및 식량' ? 'selected' : ''}>식수 및 식량</option>
                    <option ${vo.category == '의료용품' ? 'selected' : ''}>의료용품</option>
                    <option ${vo.category == '조명' ? 'selected' : ''}>조명</option>
                    <option ${vo.category == '통신' ? 'selected' : ''}>통신</option>
                </select>
            </div>

            <div class="form-group">
                <label>수량 *</label>
                <input type="number" name="quantity" value="${vo.quantity}" class="input">
            </div>

            <div class="form-group">
                <label>단위</label>
                <input type="text" name="unit" value="${vo.unit}" class="input">
            </div>

            <div class="form-group">
                <label>우선순위</label>
                <select name="priority" class="input">
                    <option ${vo.priority == '높음' ? 'selected' : ''}>높음</option>
                    <option ${vo.priority == '중간' ? 'selected' : ''}>중간</option>
                    <option ${vo.priority == '낮음' ? 'selected' : ''}>낮음</option>
                </select>
            </div>

            <div class="form-group">
                <label>유효기한</label>
                <input type="date" name="expiryDate" value="${vo.expiryDate}" class="input">
            </div>

            <div class="form-group">
                <label>메모</label>
                <textarea name="memo" rows="4" class="input">${vo.memo}</textarea>
            </div>

            <div class="btn-area">
                <button type="submit" class="btn btn-primary">수정 완료</button>
                <a href="view.do?no=${vo.no}" class="btn btn-outline">취소</a>
            </div>

        </form>

    </div>

</div>

</body>
</html>
