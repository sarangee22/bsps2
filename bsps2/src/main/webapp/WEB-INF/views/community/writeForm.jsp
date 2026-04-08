<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제보하기</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
body {
    background-color: #f4f7f9;
    font-family: 'Noto Sans KR', sans-serif;
}

/* 카드 박스 스타일 + 깊은 그림자 (통일감 유지) */
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
    background: white;
}

/* readonly 필드 (작성자) */
.form-control[readonly] {
    background-color: #f8f9fa;
    color: #888;
}

/* 파일 업로드 폼 특화 */
input[type="file"].form-control {
    padding: 8px 12px;
    height: auto;
}

/* textarea */
textarea.form-control {
    min-height: 120px;
    resize: vertical;
}

/* 버튼 공통 스타일 */
.btn {
    padding: 12px 22px !important;
    border-radius: 12px !important;
    font-weight: 700 !important;
    font-size: 1rem !important;
    border: none !important;
    transition: 0.2s;
    cursor: pointer;
}

/* 제보 등록 (Primary) */
.btn-primary { 
    background-color: #1A237E !important; 
    color: white !important; 
}
.btn-primary:hover { 
    background-color: #0d145c !important; 
}

/* 새로입력 (Warning) */
.btn-warning {
    background-color: #FFA000 !important; 
    color: white !important; 
}
.btn-warning:hover { 
    background-color: #FFB300 !important; 
}

/* 취소 (Secondary) */
.btn-secondary {
    background-color: #6c757d !important;
    color: white !important;
}
.btn-secondary:hover { 
    background-color: #5a6268 !important; 
}

/* 간격 정리 */
.form-group {
    margin-bottom: 20px;
}
</style>

<script type="text/javascript">
$(function(){
    // 비밀번호 확인 유효성 검사
    $("#writeForm").submit(function(){
        if($("#pw").val() != $("#pw2").val()){
            alert("비밀번호와 비밀번호 확인은 같아야 합니다.");
            $("#pw, #pw2").val("");
            $("#pw").focus();
            return false;
        }
    });
    
    // 취소 버튼 클릭 시 이전 페이지로 이동
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
            <h4>제보하기</h4>
        </div>
        <div class="card-body p-4">
            <form action="write.do" method="post" id="writeForm" enctype="multipart/form-data">
                <input type="hidden" name="perPageNum" value="${param.perPageNum}">
                
                <%-- 1. 제목 --%>
                <div class="form-group">
                    <label for="title" class="form-label">제목</label>
                    <input name="title" id="title" required class="form-control"
                        placeholder="상세 제보 제목을 입력하세요.">
                </div>
                
                <%-- 2. 제보사진 --%>
                <div class="form-group">
                    <label for="imageFile" class="form-label">제보사진</label>
                    <input type="file" name="imageFile" id="imageFile" class="form-control"
                        accept="image/*" required>
                </div>
                
                <%-- 3. 내용 --%>
                <div class="form-group">
                    <label for="content" class="form-label">내용</label>
                    <textarea name="content" id="content" required class="form-control"
                        placeholder="상세 제보 내용을 입력하세요."></textarea>
                </div>
                
                <%-- 4. 작성자 (readonly) --%>
                <div class="form-group">
                    <label for="writer" class="form-label">작성자</label>
                    <input name="writer" id="writer" required class="form-control"
                        value="${login.name}" readonly>
                </div>
                
                <%-- 5. 비밀번호 --%>
                <div class="form-group">
                    <label for="pw" class="form-label">비밀번호</label>
                    <input type="password" name="pw" id="pw" required class="form-control"
                        placeholder="본인 확인용 비밀번호를 입력하세요.">
                </div>
                
                <%-- 6. 비밀번호 확인 --%>
                <div class="form-group">
                    <label for="pw2" class="form-label">비밀번호 확인</label>
                    <input type="password" name="password" id="pw2" required class="form-control"
                        placeholder="비밀번호를 한 번 더 입력하세요.">
                </div>
                
                <%-- 하단 버튼 영역 --%>
                <div class="text-left mt-4">
                    <button type="submit" class="btn btn-primary">제보 등록</button>
                    <button type="reset" class="btn btn-warning">새로입력</button>
                    <button type="button" class="btn btn-secondary cancelBtn">취소</button>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>