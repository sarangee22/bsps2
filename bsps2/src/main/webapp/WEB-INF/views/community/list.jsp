<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제보게시판리스트</title>
<style type="text/css">
.dataRow:hover{cursor: pointer; background: #f9f9f9; }
.list-img{ width: 40px; height: 40px; object-fit: cover;}
</style>

<script type="text/javascript">
$(function(){
	$(".dataRow").click(function(){
		let no = $(this).find(".no").text();
		location = "view.do?no=" + no + "&inc=1&${pageObject.pageQuery}"
	});
});
</script>
</head>
<body>
<div class="container">
	<h3>제보 게시판 리스트</h3>
	<table class="table">
		<thead>
			<tr>
				<th>번호</th>
				<th>이미지</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>조회수</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${empty list }">
			<tr> <td colspan="6">데이터가 존재하지 않습니다.</td> </tr>
			</c:if>
			<c:if test="${!empty list }">
				<c:forEach items="${list }" var="vo">
					<tr class="dataRow">
						<td  class="no">${vo.no }</td>
						<td>
							<c:if test="${!empty vo.fileName }">
								<img src="${vo.fileName }" class="list-img">
							</c:if>
						</td>
						<td>${vo.title }</td>
						<td>${vo.writer }</td>
						<td>${vo.writeDate }</td>
						<td>${vo.hit }</td>
					</tr>
				</c:forEach>
			</c:if>
			
		</tbody>
	</table>
	
	<div>
		<pageNav:pageNav listURI="list.do" pageObject="${pageObject }"/>
	</div>
	<div class="text-right">
		<a href="writeForm.do?perPageNum=${pageObject.perPageNum}" class="btn btn-primary">제보하기</a>
	</div>
	
</div>
</body>
</html>