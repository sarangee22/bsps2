<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<title>물품 수정</title>
</head>
<body class="w3-light-grey">
<div class="w3-container w3-padding-64 w3-content" style="max-width:600px">
    <form action="update.do" method="post" class="w3-card-4 w3-white">
        <input type="hidden" name="no" value="${vo.no}">
        <input type="hidden" name="page" value="${param.page}">
        <input type="hidden" name="perPageNum" value="${param.perPageNum}">
        
        <div class="w3-container w3-teal"><h2>✏️ 물품 정보 수정</h2></div>
        <div class="w3-container w3-padding-24">
            <label>물품명</label>
            <input class="w3-input w3-border" name="name" type="text" value="${vo.name}" required>
            
            <label class="w3-margin-top" style="display:block">재난 유형</label>
            <select class="w3-select w3-border" name="category">
                <option value="공통" ${vo.category == '공통' ? 'selected' : ''}>공통</option>
                <option value="지진" ${vo.category == '지진' ? 'selected' : ''}>지진</option>
                <option value="화재" ${vo.category == '화재' ? 'selected' : ''}>화재</option>
            </select>

            <label class="w3-margin-top" style="display:block">구비 상태</label>
            <input class="w3-radio" type="radio" name="isReady" value="Y" ${vo.isReady == 'Y' ? 'checked' : ''}> 준비완료
            <input class="w3-radio w3-margin-left" type="radio" name="isReady" value="N" ${vo.isReady == 'N' ? 'checked' : ''}> 미흡

            <label class="w3-margin-top" style="display:block">메모</label>
            <textarea class="w3-input w3-border" name="memo" rows="4">${vo.memo}</textarea>
        </div>
        <div class="w3-container w3-padding-16 w3-light-grey">
            <button class="w3-button w3-teal">수정완료</button>
            <button type="button" class="w3-button w3-red" onclick="history.back()">취소</button>
        </div>
    </form>
</div>
</body>
</html>