<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
body {
    background-color: #f4f7f9;
    font-family: 'Noto Sans KR', sans-serif;
}

 

/* 제목 */
h3 {
    font-size: 28px;
    font-weight: 800;
    color: #1A237E;
}

/* 라벨 */
.form-label {
    font-weight: 700;
    color: #333;
}

/* input */
.form-control {
    width: 100%;
    padding: 12px 14px;
    border-radius: 10px;
    border: 1px solid #ddd;
    font-size: 14px;
    transition: 0.3s;
}

.form-control:focus {
    outline: none;
    border-color: #1A237E;
    box-shadow: 0 0 8px rgba(26,35,126,0.1);
}

/* textarea */
textarea.form-control {
    resize: vertical;
}

/* 이미지 */
.img-thumbnail {
    border-radius: 12px;
    box-shadow: 0 8px 18px rgba(0,0,0,0.08);
    border: none;
}

/* 버튼 */
.btn {
    padding: 10px 18px;
    border-radius: 10px;
    font-weight: 700;
    border: none;
    transition: 0.3s;
}

/* 등록/수정 완료 버튼 (메인) */
.btn-primary {
    background: #1A237E ;
    color: white ;
}

.btn-primary:hover {
    background: #0d145c;
}

/* 새로입력 버튼 (강조된 노란색) */
.btn-warning {
    background: #FFB300 ; /* 명확한 노란색 */
    color: white !important ;  /* 글자색 흰색 */
    border: none ;
}

.btn-warning:hover {
    background: #FFA000;
}

/* 취소 버튼 (강조된 회색) */
.btn-secondary {
    background: #757575 ; /* 진한 회색 */
    border: 1px solid #616161;
    color: white ;        /* 글자색 흰색 */
}

.btn-secondary:hover {
    background: #616161 ;
}

/* 이미지 변경 버튼 (중요도가 높으므로 남색 테마 유지) */
.btn-success {
    background: #1A237E ;
    color: white ;
    border: none ;
}

.btn-success:hover {
    background: #0d145c;
}

/* 간격 */
.mb-3, .mt-3 {
    margin-bottom: 18px ;
}

/* modal 커스터마이징 */
.modal-content {
    border-radius: 20px;
    border: none;
    box-shadow: 0 10px 30px rgba(0,0,0,0.1);
}

.modal-header {
    border-bottom: 1px solid #eee;
}

.modal-title {
    font-weight: 800;
    color: #1A237E;
}

.modal-footer {
    border-top: 1px solid #eee;
}
</style>

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