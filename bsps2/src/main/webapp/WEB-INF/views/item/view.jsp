<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<title>물품 상세 정보</title>
</head>
<body class="w3-light-grey">
<div class="w3-container w3-padding-64 w3-content" style="max-width:600px">
    <div class="w3-card-4 w3-white">
        <div class="w3-container w3-blue-grey"><h2>📦 물품 상세 정보</h2></div>
        <div class="w3-container w3-padding-24">
            <p><b>번호:</b> ${vo.no}</p>
            <p><b>물품명:</b> ${vo.name}</p>
            <p><b>유형:</b> ${vo.category}</p>
            <p><b>상태:</b> ${vo.isReady == 'Y' ? '준비완료' : '준비필요'}</p>
            <p><b>메모:</b></p>
            <div class="w3-border w3-padding" style="min-height:100px">${vo.memo}</div>
            <p class="w3-text-grey w3-small">등록일: ${vo.regDate}</p>
        </div>
        <div class="w3-container w3-light-grey w3-padding-16">
            <a href="updateForm.do?no=${vo.no}&page=${param.page}&perPageNum=${param.perPageNum}" class="w3-button w3-teal">수정</a>
            <a href="delete.do?no=${vo.no}&perPageNum=${param.perPageNum}" class="w3-button w3-red" onclick="return confirm('정말 삭제할까요?')">삭제</a>
            <a href="list.do?page=${param.page}&perPageNum=${param.perPageNum}" class="w3-button w3-white w3-border w3-right">목록</a>
        </div>
    </div>
</div>
</body>
</html>