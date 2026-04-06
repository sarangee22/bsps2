<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>제보 게시판</title>

<style>
body {
    background-color: #f4f7f9;
    font-family: 'Noto Sans KR', sans-serif;
}

/* 전체 컨테이너 */
.wrapper {
    max-width: 1100px;
    margin: 100px auto 80px auto;
}

/* 헤더 */
.header {
    margin-bottom: 30px;
}

.title {
    font-size: 30px;
    font-weight: 800;
    color: #1A237E;
}

/* [두번째 사진 스타일] 카드 레이아웃 (그림자, 둥근 테두리) */
.table-card {
    background: white;
    border-radius: 25px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.05);
    overflow: hidden;
    margin-bottom: 25px; 
}

/* 테이블 디자인 */
.custom-table {
    width: 100%;
    border-collapse: collapse;
}

.custom-table th {
    background: #f8f9fa;
    padding: 16px;
    font-size: 14px;
    color: #666;
    border-bottom: 1px solid #eee;
    text-align: center;
}

.custom-table td {
    padding: 18px;
    border-bottom: 1px solid #f1f4f8;
    text-align: center;
    color: #444;
}

/* [첫번째 사진 스타일] 제목 열 왼쪽 정렬 맞춤 */
.text-left {
    text-align: left !important;
    padding-left: 25px !important;
    font-weight: 700;
    color: #333;
}

.custom-table tr:hover {
    background: #fcfdff;
    cursor: pointer;
}

/* 이미지 스타일 */
.list-img {
    width: 45px;
    height: 45px;
    border-radius: 8px;
    object-fit: cover;
}

/* [첫번째 사진 스타일] 제보하기 버튼 위치 (왼쪽 하단) */
.button-area {
    margin-top: 15px;
    text-align: left;
}

.btn {
    display: inline-block;
    padding: 12px 22px;
    border-radius: 10px;
    font-weight: 700;
    text-decoration: none;
    transition: 0.2s;
}

.btn-primary {
    background: #1A237E;
    color: white;
}

.btn-primary:hover {
    background: #0d145c;
    box-shadow: 0 4px 12px rgba(26, 35, 126, 0.2);
}

/* [요청사항] 페이지네이션 정중앙 배치 */
.pagination-container {
    margin-top: 40px;
    display: flex;
    justify-content: center;
}
</style>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(function(){
    $(".dataRow").click(function(){
        let no = $(this).find(".no").text();
        location = "view.do?no=" + no + "&inc=1&" + "${pageObject.pageQuery}";
    });
});
</script>

</head> 

<body>

<div class="wrapper">

    <div class="header">
        <div class="title">📢 제보 게시판</div>
    </div>

    <div class="table-card">
        <table class="custom-table">
            <thead>
                <tr>
                    <th style="width: 80px;">번호</th>
                    <th style="width: 100px;">이미지</th>
                    <th class="text-left">제목</th> <th style="width: 120px;">작성자</th>
                    <th style="width: 150px;">작성일</th>
                    <th style="width: 100px;">조회수</th>
                </tr>
            </thead>
            <tbody>
                <c:if test="${empty list}">
                    <tr><td colspan="6" style="padding: 50px;">등록된 데이터가 없습니다.</td></tr>
                </c:if>
                <c:forEach items="${list}" var="vo">
                    <tr class="dataRow">
                        <td class="no">${vo.no}</td>
                        <td>
                            <c:if test="${!empty vo.fileName}">
                                <img src="${vo.fileName}" class="list-img">
                            </c:if>
                        </td>
                        <td class="text-left">${vo.title}</td> <td>${vo.writer}</td>
                        <td>${vo.writeDate}</td>
                        <td>${vo.hit}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <div class="button-area">
        <a href="writeForm.do?perPageNum=${pageObject.perPageNum}" class="btn btn-primary">
            제보하기
        </a>
    </div>

    <div class="pagination-container">
        <pageNav:pageNav listURI="list.do" pageObject="${pageObject}"/>
    </div>

</div>

</body>
</html>