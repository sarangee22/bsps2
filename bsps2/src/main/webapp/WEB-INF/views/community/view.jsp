<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제보 상세 보기</title>
<style type="text/css">
#deleteDiv {display: none; margin-top: 20px;}
.community-img{max-width: 100%; height:auto; border-radius: 5px; box-shadow:0 0 10px rgba(0,0,0,0.1);}
th { width: 150px; background-color: #f8f9fa; vertical-align: middle !important;}
</style>

<script type="text/javascript">
$(function(){
	$("#deleteBtn, #cancelBtn").click(function(){
		$("#pw").val("");
		$("#deleteDiv").toggle();
		if($("#deleteDiv").is(":visible"))$("#pw").focus();
	})
})
</script>
</head>
<body>
<div class = "container">
	<h3 class="m-4 mb-4">제보 상세 내용</h3>
	
	<table class="table table-boardered">
		<tbody>
			<tr>
				<th>번호</th>
				<td>${vo.no }</td>
			</tr>
			<tr>
				<th>제목</th>
				<td>${vo.title }</td>
			</tr>
			<tr>
				<th>
				제보이미지 <br><br>
				<button type="button" class="btn btn-success btn-sm mb-2"
					data-bs-toggle="modal" data-bs-target="#changeImageModal">
					이미지 변경
				</button>
				
				<td class="text-center">
    					<c:if test="${!empty vo.fileName}">
        					<img src="${vo.fileName}" alt="제보 이미지" class="community-img">
    					</c:if>
				</td>
				
			</tr>
			<tr>
				<th>내용</th>
				<td><pre style="white-space: pre-wrap; border: none; padding: 0;">${vo.content}</pre></td>
			</tr>
			<tr>
				<th>작성자</th>
				<td>${vo.writer }</td>
			</tr>
			<tr>
				<th>작성일</th>
				<td>${vo.writeDate }</td>
			</tr>
			<tr>
				<th>조회수</th>
				<td>${vo.hit }</td>
			</tr>
		</tbody>
	</table>
	
	<div class="mb-4">
		<a href="updateForm.do?no=${vo.no }&page=${param.page }&perPageNum=${param.perPageNum}&key=${param.key}&word=${param.word}"
		class="btn btn-primary">수정</a>
		<button type="button" class="btn btn-danger" id="deleteBtn">삭제</button>
		<a href="list.do?page=${param.page }&perPageNum=${param.perPageNum}&key=${param.key}&word=${param.word}" 
		   class="btn btn-info text-white">리스트</a>
	</div>
	
	<div class="card border-danger mb-5" id="deleteDiv">
		<div class="card-header bg-danger text-white">삭제</div>
		<form action="delete.do"method="post">
			<input type="hidden" name="no" value="${vo.no}">
			<input type="hidden" name="perPageNum" value="${param.perPageNum }">
			<div class="card-body">
				<input name="pw" type="password" id="pw" class="form-control" placeholder="삭제를 위해 비밀번호를 입력하세요" required>
			</div>
			<div class="card-footer text-end">
				<button type="submit"class="btn btn-danger">삭제 확정</button>
				<button type="button"class="btn btn-secondary">취소</button>
			</div>
		</form>
	</div>
</div>	
<div class="modal" id="changeImageModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">

      <div class="modal-header">
        <h4 class="modal-title">변경할 이미지를 선택하세요.</h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <form action="changeImage.do" method="post" enctype="multipart/form-data" id="modalForm">
        <input name="no" value="${param.no }" type="hidden">
        <input name="page" value="${param.page }" type="hidden">
        <input name="perPageNum" value="${param.perPageNum }" type="hidden">
        <input name="key" value="${param.key }" type="hidden">
        <input name="word" value="${param.word }" type="hidden">
        <input name="delFileName" value="${vo.fileName }" type="hidden">

        <div class="modal-body">
          <input type="file" class="form-control" name="imageFile" required accept="image/*">
        </div>
  
        <div class="modal-footer">
          <button class="btn btn-primary">이미지 변경</button>
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
        </div>
      </form>
    </div>
  </div>
</div>
</body>
</html>