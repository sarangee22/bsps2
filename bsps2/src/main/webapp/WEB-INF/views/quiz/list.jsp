<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>퀴즈 목록</title>

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
    $(".dataRow").click(function(){
        // 1. 공백 제거를 위해 trim() 추가
        let no = $(this).find(".no").text().trim();
        // 2. inc 파라미터 추가 (조회수 1 증가를 위해 보통 1을 보냅니다)
        location = "view.do?no=" + no + "&inc=1";
    });
});
</script>

</head>
<body>
<div class="container">
	<h1 class="my-4">퀴즈 리스트</h1>
	
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
	
	<a href="writeForm.do" class="btn btn-primary">퀴즈 등록</a>
	
</div>

<c:if test="${not empty msg}">
    <script>alert("${msg}");</script>
    <c:remove var="msg" scope="session" />
</c:if>

</body>
</html>