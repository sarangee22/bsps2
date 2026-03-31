<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제보하기</title>
<script type="text/javascript">
$(function(){
	$("#writeForm").submit(function(){
        if($("#pw").val() != $("#pw2").val()){
            alert("비밀번호와 비밀번호 확인은 같아야 합니다.");
            $("#pw, #pw2").val("");
            $("#pw").focus();
            return false;
	}
	
});
	$(".cancelBtn").click(function(){
			history.back();
	
		});
});
</script>
</head>
<body>
<div class="container">
	<h2 class="mt-4 mb-4">제보하기</h2>
	
	<form action="write.do" method="post" id="writeForm" enctype="multipart/form-data">
		<input type="hidden" name="perPageNum" value="${param.perPageNum }">
		
		<div class="mb-3 mt-3">
			<label for="title" class="form-label">제목</label>
			<input name="title" id="title" required class="form-control"
				placeholder="상세 제보 제목을 입력하세요.">
		</div>
		
		<div class="mb-3 mt-3">
			<label for="imageFile" class="form-label">제보사진</label>
			<input type="file" name="imageFile" id="imageFile" class="form-control"
				accept="image/*" required>
		</div>
		
		<div class="mb-3 mt-3">
			<label for="content" class="form-label">내용</label>
			<textarea name="content" id="content" required class="form-control"
				placeholder="상세 제보 내용을 입력하세요."></textarea>
		</div>
		
		<div class="mb-3 mt-3">
			<label for="writer" class="form-label">작성자</label>
			<input name="writer" id="writer" required class="form-control"
				placeholder="작성자 성함을 입력하세요.">
		</div>
		
		<div class="mb-3 mt-3">
			<label for="pw" class="form-label">비밀번호</label>
			<input type="password" name="pw" id="pw" required class="form-control"
				placeholder="본인 확인용 비밀번호를 입력하세요.">
		</div>
		
		<div class="mb-3 mt-3">
			<label for="pw2" class="form-label">비밀번호 확인</label>
			<input name="password" id="pw2" required class="form-control"
				placeholder="비밀번호를 한 번 더 입력하세요.">
		</div>
		
		<div class="mt-4 mb-5">
			<button type="submit" class="btn btn-primary">제보 등록</button>
			<button type="reset" class="btn btn-warning">새로입력</button>
			<button type="button" class="btn btn-secondary cancelBtn">취소</button>
		</div>
		
	</form>
	
</div>
</body>
</html>