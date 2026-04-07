<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>퀴즈</title>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<style type="text/css">
body {
    background-color: #f0f3f7 !important; 
    font-family: 'Noto Sans KR', sans-serif;
}

.container {
    max-width: 1200px; 
    margin: 80px auto;
}

h1 {
    font-size: 30px; 
    font-weight: 800; 
    color: #1A237E;
    margin-bottom: 30px;
}

/* [1] list.jsp와 동일한 카드 레이아웃 */
.table-card {
    background: white !important;
    border-radius: 25px !important;
    box-shadow: 0 15px 45px rgba(0, 0, 0, 0.15) !important;
    overflow: hidden;
    margin-bottom: 25px;
    border: 1px solid rgba(0, 0, 0, 0.05) !important;
}

.custom-table { width: 100%; border-collapse: collapse; }

/* [2] list.jsp 성공 코드: thead 영역 강제 보정 */
.custom-table thead {
    background-color: #e2e6ea !important;
    display: table-header-group; 
}

/* [3] list.jsp 성공 코드: th 진한 회색 및 필터 적용 */
.custom-table th {
    padding: 20px 16px;
    font-size: 14px;
    color: #333 !important;
    text-align: center;
    font-weight: 800;
    background: linear-gradient(#e2e6ea, #e2e6ea) !important;
    background-color: #e2e6ea !important;
    filter: brightness(0.95); /* 이게 핵심이었네요! */
    border-bottom: 1.5px solid #dee2e6 !important;
}

/* [4] td 스타일 유지 */
.custom-table td {
    padding: 20px;
    text-align: center;
    color: #444;
    border-bottom: 1.5px solid #dee2e6 !important; 
    vertical-align: middle;
}

.dataRow:hover {
    background: #fcfdff !important;
    cursor: pointer;
}

.custom-table tbody tr:last-child td {
    border-bottom: none !important;
}

.text-left-title {
    text-align: left !important;
    padding-left: 40px !important;
    font-weight: 700;
}

.btn-area { margin-top: 15px; text-align: left; }
.btn-primary { 
    background: #1A237E !important; 
    border: none !important;
    padding: 12px 22px;
    border-radius: 12px;
    font-weight: 700;
}
</style>

<script type="text/javascript">
$(function(){
    $(".dataRow").on("click", function(){
        let no = $(this).find(".no").text().trim();
        if(no) {
            location = "view.do?no=" + no + "&inc=1"; 
        }
    });
});
</script>

</head>
<body>
<div class="container">
    <h1>📝 퀴즈 게시판</h1>
    
    <div class="table-card">
        <table class="custom-table">
            <thead>
                <tr>
                    <th style="width: 100px;">번호</th>
                    <th class="text-left-title">문제</th>
                    <th style="width: 150px;">작성자</th>
                    <th style="width: 180px;">등록일</th>
                </tr>
            </thead>
            <tbody>
                <c:if test="${empty list}">
                    <tr>
                        <td colspan="4" style="padding: 80px;">등록된 퀴즈가 없습니다.</td>
                    </tr>
                </c:if>
                
                <c:forEach items="${list}" var="vo">
                    <tr class="dataRow">
                        <td class="no">${vo.no}</td>
                        <td class="text-left-title">${vo.title}</td>
                        <td>${vo.writer}</td>
                        <td>${vo.writeDate}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    
    <div class="btn-area">
        <c:if test="${!empty login && login.gradeNo == 9}">
            <a href="writeForm.do" class="btn btn-primary">퀴즈 등록</a>
        </c:if>
    </div>
</div>

<c:if test="${not empty msg}">
    <script>alert("${msg}");</script>
    <c:remove var="msg" scope="session" />
</c:if>

</body>
</html>