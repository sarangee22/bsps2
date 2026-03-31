<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제보 수정</title>
<script type="text/javascript">
$(function(){
	// 취소 버튼: 이전 페이지(상세보기)로 이동
	$(".cancelBtn").click(function(){
		history.back();
	});
});
</script>
</head>
<body>
<div class="container">
	<h3 class="mt-4 mb-4">제보 내용 수정</h3>
	
	<form action="update.do" method="post" id="updateForm">
		<input type="hidden" name="page" value="${param.page }">
		<input type="hidden" name="perPageNum" value="${param.perPageNum }">
		<input type="hidden" name="key" value="${param.key }">
		<input type="hidden" name="word" value="${param.word }">
		
		<input type="hidden" name="fileName" value="${vo.fileName }">

		<div class="mb-3 mt-3">
			<label for="no" class="form-label">번호</label>
			<input type="text" class="form-control" id="no" name="no" 
				readonly value="${vo.no }">
		</div>

		<div class="mb-3 mt-3">
			<label for="title" class="form-label">제목</label>
			<input type="text" class="form-control" id="title" name="title" 
				required value="${vo.title }" placeholder="제목을 입력하세요.">
		</div>

		<div class="mb-3 mt-3">
			<label for="content" class="form-label">내용</label>
			<textarea class="form-control" rows="7" id="content" name="content" 
				required placeholder="내용을 입력하세요.">${vo.content }</textarea>
		</div>

		<div class="mb-3 mt-3">
			<label for="writer" class="form-label">작성자</label>
			<input type="text" class="form-control" id="writer" name="writer" 
				required value="${vo.writer }">
		</div>

		<div class="mb-3 mt-3">
			<label class="form-label">현재 제보 사진</label>
			<div>
				<img src="${vo.fileName }" class="img-thumbnail" 
					style="max-width: 300px; height: auto;">
				<button type="button" class="btn btn-success btn-sm ms-2"
					data-bs-toggle="modal" data-bs-target="#changeImageModal">
					이미지 변경하기
				</button>
				
			</div>
		</div>

		<div class="mb-3 mt-3">
			<label for="pw" class="form-label text-danger">비밀번호 확인</label>
			<input type="password" class="form-control" id="pw" name="pw" 
				required placeholder="수정을 위해 본인 확인 비밀번호를 입력하세요.">
		</div>

		<div class="mt-4 mb-5 text-center">
			<button type="submit" class="btn btn-primary">수정 완료</button>
			<button type="reset" class="btn btn-warning">새로입력</button>
			<button type="button" class="btn btn-secondary cancelBtn">취소</button>
		</div>
	</form>
</div>


<div class="modal fade" id="changeImageModal">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			
			<div class="modal-header">
				<h4 class="modal-title">변경할 이미지를 선택하세요.</h4>
				<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
			</div>
			
			<form action="changeImage.do" method="post" enctype="multipart/form-data">
				<input type="hidden" name="no" value="${vo.no }">
				<input type="hidden" name="page" value="${param.page }">
				<input type="hidden" name="perPageNum" value="${param.perPageNum }">
				<input type="hidden" name="key" value="${param.key }">
				<input type="hidden" name="word" value="${param.word }">
				<input type="hidden" name="delFileName" value="${vo.fileName }">
								
				<div class="modal-body">
					<input type="file" class="form-control" name="imageFile" required accept="image/*">
				</div>
				
				<div class="modal-footer">
					<button class="btn btn-primary">이미지 변경 하기</button>
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
					
				</div>
				
			</form>
		</div>
	</div>
</div>


</body>
</html>