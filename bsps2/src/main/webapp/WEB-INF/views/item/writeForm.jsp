<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>비상물품 등록</title>

<style>
body {
    background-color: #f4f7f9;
    font-family: 'Noto Sans KR', sans-serif;
}

.wrapper {
    max-width: 1000px;
    margin: 130px auto 80px auto;
}

.card {
    background: white;
    padding: 40px;
    border-radius: 25px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.05);
}

.title {
    font-size: 30px;
    font-weight: 800;
    color: #1A237E;
    margin-bottom: 30px;
}

.form-group { margin-bottom: 20px; }

label {
    font-weight: 700;
    margin-bottom: 6px;
    display: block;
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
}

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

        <div class="title">새 비상물품 등록</div>

        <form action="write.do" method="post">

            <div class="form-group">
                <label>물품명 *</label>
                <input type="text" name="name" required class="input">
            </div>

            <div class="form-group">
                <label>카테고리</label>
                <select name="category" class="input">
                    <option>식수 및 식량</option>
                    <option>의료용품</option>
                    <option>조명</option>
                    <option>통신</option>
                </select>
            </div>

            <div class="form-group">
                <label>수량 *</label>
                <input type="number" name="quantity" value="1" class="input">
            </div>

            <div class="form-group">
                <label>단위</label>
                <input type="text" name="unit" class="input">
            </div>

            <div class="form-group">
                <label>우선순위</label>
                <select name="priority" class="input">
                    <option>높음</option>
                    <option selected>중간</option>
                    <option>낮음</option>
                </select>
            </div>

            <div class="form-group">
                <label>유효기한</label>
                <input type="date" name="expiryDate" class="input">
            </div>

            <div class="form-group">
                <label>메모</label>
                <textarea name="memo" rows="4" class="input"></textarea>
            </div>

            <div class="btn-area">
                <button type="submit" class="btn btn-primary">등록하기</button>
                <a href="list.do" class="btn btn-outline">취소</a>
            </div>

        </form>

    </div>

</div>

</body>
</html>
