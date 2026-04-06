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

/* 전체 */
.wrapper {
    max-width: 1100px;
    margin: 130px auto 80px auto;
}

/* 헤더 */
.header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 30px;
}

.title {
    font-size: 30px;
    font-weight: 800;
    color: #1A237E;
}

/* 버튼 */
.btn {
    padding: 10px 18px;
    border-radius: 10px;
    font-weight: 700;
    text-decoration: none;
}

.btn-primary {
    background: #1A237E;
    color: white;
}

.btn-primary:hover {
    background: #0d145c;
}

/* 카드 */
.table-card {
    background: white;
    border-radius: 25px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.05);
    overflow: hidden;
}

/* 테이블 */
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
}

.custom-table td {
    padding: 18px;
    border-bottom: 1px solid #f1f4f8;
    text-align: center;
}

.custom-table tr:hover {
    background: #fcfdff;
    cursor: pointer;
}

/* 제목 강조 */
.title-cell {
    text-align: left;
    font-weight: 700;
    color: #333;
}

/* 이미지 */
.list-img {
    width: 45px;
    height: 45px;
    border-radius: 8px;
    object-fit: cover;
}

/* 페이지 */
.pagination {
    padding: 30px;
    text-align: center;
    background: #fafbfc;
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

    <!-- 헤더 -->
    <div class="header">
        <div class="title">📢 제보 게시판</div>
        <a href="writeForm.do?perPageNum=${pageObject.perPageNum}" class="btn btn-primary">
            + 제보하기
        </a>
    </div>

    <!-- 테이블 카드 -->
    <div class="table-card">

        <table class="custom-table">
            <thead>
                <tr>
                    <th>번호</th>
                    <th>이미지</th>
                    <th style="text-align:left;">제목</th>
                    <th>작성자</th>
                    <th>작성일</th>
                    <th>조회수</th>
                </tr>
            </thead>

            <tbody>
                <c:if test="${empty list}">
                    <tr>
                        <td colspan="6">데이터가 없습니다.</td>
                    </tr>
                </c:if>

                <c:forEach items="${list}" var="vo">
                    <tr class="dataRow">
                        <td class="no">${vo.no}</td>

                        <td>
                            <c:if test="${!empty vo.fileName}">
                                <img src="${vo.fileName}" class="list-img">
                            </c:if>
                        </td>

                        <td class="title-cell">${vo.title}</td>
                        <td>${vo.writer}</td>
                        <td>${vo.writeDate}</td>
                        <td>${vo.hit}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <!-- 페이지 -->
        <div class="pagination">
            <pageNav:pageNav listURI="list.do" pageObject="${pageObject}"/>
        </div>

    </div>

</div>

</body>
</html>
