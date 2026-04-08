<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제보 수정</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<style>
body {
    background-color: #f4f7f9;
    font-family: 'Noto Sans KR', sans-serif;
}

/* 카드 박스 스타일 + 깊은 그림자 */
.card {
    border: none;
    border-radius: 20px;
    overflow: hidden;
    box-shadow: 0 10px 30px rgba(0,0,0,0.15) !important;
}

/* 카드 헤더 (네이비 톤) */
.card-header {
    background-color: #1A237E !important;
    color: white !important;
    padding: 20px;
    border-bottom: none;
}

.card-header h4 {
    margin-bottom: 0;
    font-weight: 800;
    font-size: 22px;
}

/* 라벨 스타일 */
.form-label {
    font-weight: 700;
    color: #333;
    display: block;
    margin-bottom: 8px;
}

/* 입력폼 스타일 */
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

.form-control[readonly] {
    background-color: #f8f9fa;
    color: #888;
}

/* 현재 이미지 썸네일 */
.img-thumbnail {
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    border: 1px solid #eee;
}

/* 버튼 공통 스타일 */
.btn {
    padding: 10px 20px !important;
    border-radius: 8px !important;
    font-weight: 700 !important;
    font-size: 0.95rem !important;
    border: none !important;
    transition: 0.2s;
    cursor: pointer;
    margin-right: 5px;
}

/* 수정 완료 (네이비) */
.btn-primary { 
    background-color: #1A237E !important; 
    color: white !important; 
}
.btn-primary:hover { 
    background-color: #0d145c !important; 
}

/* 새로입력 (기존 옐로우/오렌지 색상) */
.btn-warning {
    background-color: #FFA000 !important; 
    color: white !important; 
}
.btn-warning:hover { 
    background-color: #FFB300 !important; 
}

/* 취소/돌아가기 (그레이) */
.btn-secondary {
    background-color: #6c757d !important;
    color: white !important;
}
.btn-secondary:hover { 
    background-color: #5a6268 !important; 
}

/* 이미지 변경 버튼 (초록색 유지) */
.btn-success {
    background-color: #28a745 !important;
    color: white !important;
}
.btn-success:hover {
    background-color: #218838 !important;
}

/* 간격 정리 */
.form-group {
    margin-bottom: 22px;
}

/* 모달 커스터마이징 */
.modal-content {
    border-radius: 20px;
    border: none;
}
.modal-header {
    background-color: #f8f9fa;
    border-bottom: 1px solid #eee;
    border-radius: 20px 20px 0 0;
}
</style>

<script type="text/javascript">
$(function(){
	$(".cancelBtn").click(function(){
		history.back();
	});
});
</script>
</head>
<body>
<div class="container mt-5 mb-5">
    <div class="card">
        <div class="card-header text-center">
            <h4>제보 내용 수정</h4>
        </div>
        <div class="card-body p-4">
            <form action="update.do" method="post" id="updateForm">
                <input type="hidden" name="page" value="${param.page}">
                <input type="hidden" name="perPageNum" value="${param.perPageNum}">
                <input type="hidden" name="key" value="${param.key}">
                <input type="hidden" name="word" value="${param.word}">
                <input type="hidden" name="fileName" value="${vo.fileName}">

                <div class="form-group">
                    <label for="no" class="form-label">번호</label>
                    <input type="text" class="form-control" id="no" name="no" readonly value="${vo.no}">
                </div>

                <div class="form-group">
                    <label for="title" class="form-label">제목</label>
                    <input type="text" class="form-control" id="title" name="title" 
                        required value="${vo.title}" placeholder="제목을 입력하세요.">
                </div>

                <div class="form-group">
                    <label for="content" class="form-label">내용</label>
                    <textarea class="form-control" rows="7" id="content" name="content" 
                        required placeholder="내용을 입력하세요.">${vo.content}</textarea>
                </div>

                <div class="form-group">
                    <label for="writer" class="form-label">작성자</label>
                    <input type="text" class="form-control" id="writer" name="writer" required value="${vo.writer}">
                </div>

                <div class="form-group">
                    <label class="form-label">현재 제보 사진</label>
                    <div class="d-flex align-items-end flex-wrap">
                        <img src="${vo.fileName}" class="img-thumbnail" style="max-width: 250px; height: auto;">
                        <button type="button" class="btn btn-success btn-sm ml-3 mt-2"
                            data-toggle="modal" data-target="#changeImageModal">
                            이미지 변경하기
                        </button>
                    </div>
                </div>

                <div class="form-group">
                    <label for="pw" class="form-label text-danger">비밀번호 확인</label>
                    <input type="password" class="form-control" id="pw" name="pw" 
                        required placeholder="수정을 위해 본인 확인 비밀번호를 입력하세요.">
                </div>

                <%-- 버튼 영역: 왼쪽 정렬 --%>
                <div class="text-left mt-4">
                    <button type="submit" class="btn btn-primary">수정 완료</button>
                    <button type="reset" class="btn btn-warning">새로입력</button>
                    <button type="button" class="btn btn-secondary cancelBtn">취소</button>
                </div>
            </form>
        </div>
    </div>
</div>

<%-- 이미지 변경 모달 --%>
<div class="modal fade" id="changeImageModal" tabindex="-1" role="dialog">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content shadow-lg">
			<div class="modal-header">
				<h5 class="modal-title" style="font-weight: 800; color: #1A237E;">변경할 이미지 선택</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<form action="changeImage.do" method="post" enctype="multipart/form-data">
				<input type="hidden" name="no" value="${vo.no}">
				<input type="hidden" name="page" value="${param.page}">
				<input type="hidden" name="perPageNum" value="${param.perPageNum}">
				<input type="hidden" name="key" value="${param.key}">
				<input type="hidden" name="word" value="${param.word}">
				<input type="hidden" name="delFileName" value="${vo.fileName}">
								
				<div class="modal-body p-4">
                    <label class="form-label">새 이미지 파일</label>
					<input type="file" class="form-control" name="imageFile" required accept="image/*" style="height: auto;">
				</div>
				<div class="modal-footer">
					<button class="btn btn-primary">이미지 변경 하기</button>
					<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
				</div>
			</form>
		</div>
	</div>
</div>

</body>
</html>