<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>퀴즈 수정</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
body {
    background-color: #f4f7f9;
    font-family: 'Noto Sans KR', sans-serif;
}

/* [디자인 핵심] 카드 박스 스타일 + 이미지 같은 깊은 그림자 추가 */
.card {
    border: none;
    border-radius: 20px;
    overflow: hidden;
    /* [추가된 포인트] 이미지와 유사한 부드럽고 깊은 그림자 효과 */
    box-shadow: 0 10px 30px rgba(0,0,0,0.15) !important; 
}

/* 카드 헤더 (네이비 톤 유지) */
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

.form-control[readonly] {
    background-color: #f8f9fa;
    color: #888;
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

/* 수정 완료 (Primary - 네이비) */
.btn-primary { 
    background-color: #1A237E !important; 
}
.btn-primary:hover { 
    background-color: #0d145c !important; 
}

/* 취소 (Secondary - 그레이) */
.btn-secondary {
    background-color: #6c757d !important;
}
.btn-secondary:hover { 
    background-color: #5a6268 !important; 
}

/* 간격 조정 */
.form-group {
    margin-bottom: 20px;
}
</style>
</head>
<body>
<div class="container mt-5 mb-5">
    <div class="card">
        <div class="card-header text-center">
            <h4>퀴즈 및 해설 수정</h4>
        </div>
        <div class="card-body p-4">
            <form action="update.do" method="post">
                <%-- 1. 글번호 --%>
                <div class="form-group">
                    <label for="no" class="form-label">번호</label>
                    <input type="text" name="no" id="no" class="form-control" value="${vo.vo.no}" readonly>
                </div>
                
                <%-- 2. 퀴즈 제목 --%>
                <div class="form-group">
                    <label for="title" class="form-label">퀴즈 제목</label>
                    <input type="text" name="title" id="title" class="form-control" 
                           value="${vo.vo.title}" required>
                </div>
                
                <%-- 3. 문제 지문 --%>
                <div class="form-group">
                    <label for="content" class="form-label">문제 내용 (지문)</label>
                    <textarea name="content" id="content" rows="5" class="form-control" 
                              required>${vo.vo.content}</textarea>
                </div>
                
                <%-- 4. 퀴즈 정답 --%>
                <div class="form-group">
                    <label for="ans" class="form-label">퀴즈 정답</label>
                    <input type="text" name="ans" id="ans" class="form-control" 
                           value="${vo.vo.ans}" required>
                </div>

                <%-- 5. 상세 해설 수정 --%>
                <div class="form-group">
                    <label for="explain" class="form-label">상세 해설 수정</label>
                    <textarea name="explain" id="explain" rows="4" class="form-control" 
                              required>${vo.explain}</textarea>
                </div>

                <%-- 버튼 영역 (오른쪽 정렬) --%>
                <div class="text-right mt-4">
                    <button type="submit" class="btn btn-primary">수정 완료</button>
                    <button type="button" class="btn btn-secondary" onclick="history.back();">취소</button>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>