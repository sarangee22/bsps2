<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<title>물품 등록</title>
</head>
<body class="w3-light-grey">
<div class="w3-container w3-padding-64 w3-content" style="max-width:600px">
    <form action="write.do" method="post" class="w3-card-4 w3-white">
        <input type="hidden" name="perPageNum" value="${param.perPageNum}">
        <div class="w3-container w3-black"><h2>📝 신규 물품 등록</h2></div>
        <div class="w3-container w3-padding-24">
            <label>물품명</label>
            <input class="w3-input w3-border" name="name" type="text" required>
            <label class="w3-margin-top" style="display:block">재난 유형</label>
            <select class="w3-select w3-border" name="category">
                <option value="공통">공통</option>
                <option value="지진">지진</option>
                <option value="화재">화재</option>
            </select>
            <label class="w3-margin-top" style="display:block">메모</label>
            <textarea class="w3-input w3-border" name="memo" rows="4"></textarea>
        </div>
        <div class="w3-container w3-padding-16 w3-light-grey">
            <button class="w3-button w3-black">등록하기</button>
            <button type="button" class="w3-button w3-red" onclick="history.back()">취소</button>
        </div>
    </form>
</div>
</body>
</html>