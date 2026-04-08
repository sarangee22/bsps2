<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>퀴즈 등록</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
body {
    background-color: #f4f7f9;
    font-family: 'Noto Sans KR', sans-serif;
}

/* 카드 박스 스타일 + 깊은 그림자 추가 */
.card {
    border: none;
    border-radius: 20px;
    overflow: hidden;
    /* 이미지와 동일한 느낌의 부드럽고 깊은 그림자 */
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

/* 라벨 및 폼 스타일 */
.form-label {
    font-weight: 700;
    color: #333;
    display: block;
    margin-bottom: 8px;
}

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

/* 버튼 공통 스타일 */
.btn {
    padding: 12px 22px !important;
    border-radius: 12px !important;
    font-weight: 700 !important;
    font-size: 1rem !important;
    border: none !important;
    transition: 0.2s;
}

/* 등록 (Primary) */
.btn-primary { 
    background-color: #1A237E !important; 
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

/* 간격 조정 */
.form-group {
    margin-bottom: 20px;
}
</style>

<script type="text/javascript">
$(function(){
    // 취소 버튼 클릭 시 이전 페이지로 이동 
    $("#btnCancel").click(function(){
        history.back();
    });
});
</script>
</head>
<body>
<div class="container mt-5 mb-5">
    <div class="card">
        <div class="card-header text-center">
            <h4>새로운 퀴즈 및 해설 등록</h4>
        </div>
        <div class="card-body p-4">
            <form action="write.do" method="post">
                <%-- 1. 퀴즈 제목 --%>
                <div class="form-group">
                    <label for="title" class="form-label">퀴즈 제목</label>
                    <input type="text" name="title" id="title" class="form-control" 
                           placeholder="퀴즈의 제목을 입력하세요" required>
                </div>
                
                <%-- 2. 문제 지문 --%>
                <div class="form-group">
                    <label for="content" class="form-label">문제 내용 (지문)</label>
                    <textarea name="content" id="content" rows="5" class="form-control" 
                              placeholder="문제를 상세히 입력하세요" required></textarea>
                </div>
                
                <%-- 3. 정답 입력 --%>
                <div class="form-group">
                    <label for="ans" class="form-label">퀴즈 정답</label>
                    <input type="text" name="ans" id="ans" class="form-control" 
                           placeholder="정답을 입력하세요 (예: O, X 또는 정답 텍스트)" required>
                </div>

                <%-- 4. 상세 해설 --%>
                <div class="form-group">
                    <label for="explain" class="form-label">상세 해설 등록</label>
                    <textarea name="explain" id="explain" rows="4" class="form-control" 
                              placeholder="사용자가 정답을 맞혔을 때 보여줄 상세한 설명을 입력하세요" required></textarea>
                </div>

                <%-- 작성자 정보 (히든) --%>
                <input type="hidden" name="writer" value="admin"> 

                <%-- 하단 버튼 영역 (오른쪽 정렬) --%>
                <div class="text-right mt-4">
                    <button type="submit" class="btn btn-primary">퀴즈 등록</button>
                    <button type="reset" class="btn btn-warning">새로입력</button>
                    <button type="button" id="btnCancel" class="btn btn-secondary">취소</button>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>