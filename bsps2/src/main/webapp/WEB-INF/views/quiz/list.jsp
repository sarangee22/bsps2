<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>퀴즈</title>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<style type="text/css">
	.dataRow:hover {
		background: #e0e0e0;
		cursor: pointer;
	}
</style>

<script type="text/javascript">
$(function(){
    console.log("JQuery Loaded"); // 브라우저 콘솔(F12)에서 확인용

    // 1. 행 클릭 이벤트
    $(".dataRow").on("click", function(){
        // 2. 글번호 추출
        let no = $(this).find(".no").text().trim();
        console.log("클릭한 번호: " + no);
        
        if(no) {
            // 3. inc=1을 붙여서 이동 (조회수 증가 포함)
            location = "view.do?no=" + no + "&inc=1"; 
        } else {
            alert("번호를 가져올 수 없습니다.");
        }
    });
});
</script>

</head>
<body>
<div class="container">
	<h1 class="my-4">퀴즈</h1>
	
	<table class="table">
		<thead class="thead-dark">
			<tr>
				<th>번호</th>
				<th>문제</th>
				<th>작성자</th>
				<th>등록일</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${empty list}">
				<tr>
					<td colspan="4" class="text-center">등록된 퀴즈가 없습니다.</td>
				</tr>
			</c:if>
			
			<c:forEach items="${list}" var="vo">
				<tr class="dataRow">
					<td class="no">${vo.no}</td>
					<td>${vo.title}</td>
					<td>${vo.writer}</td>
					<td>${vo.writeDate}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
    <c:if test="${!empty login && login.gradeNo == 9}">
	    <a href="writeForm.do" class="btn btn-primary">퀴즈 등록</a>
    </c:if>
	
</div>

<c:if test="${not empty msg}">
    <script>alert("${msg}");</script>
    <c:remove var="msg" scope="session" />
</c:if>

</body>
</html>