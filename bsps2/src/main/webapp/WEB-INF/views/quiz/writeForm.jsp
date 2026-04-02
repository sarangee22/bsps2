<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>퀴즈 등록</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script type="text/javascript">
$(function(){
    // 취소 버튼 클릭 시 리스트로 이동 
    $("#btnCancel").click(function(){
        history.back();
    });
});
</script>
</head>
<body>
<div class="container mt-5">
    <div class="card shadow">
        <div class="card-header bg-primary text-white">
            <h4>새로운 퀴즈 등록</h4>
        </div>
        <div class="card-body">
            <form action="write.do" method="post">
                <div class="form-group">
                    <label for="title"><strong>퀴즈 제목</strong></label>
                    <input type="text" name="title" id="title" class="form-control" 
                           placeholder="퀴즈의 제목을 입력하세요" required> <%-- 필수 항목 체크 [cite: 1, 5-4] --%>
                </div>
                
                <div class="form-group">
                    <label for="content"><strong>문제 내용 (지문)</strong></label>
                    <textarea name="content" id="content" rows="6" class="form-control" 
                              placeholder="문제를 상세히 입력하세요" required></textarea> <%-- 필수 항목 체크 [cite: 1, 5-4] --%>
                </div>
                
                <div class="form-group">
                    <label for="ans"><strong>퀴즈 정답</strong></label>
                    <input type="text" name="ans" id="ans" class="form-control" 
                           placeholder="정답을 입력하세요 (예: O, X 또는 텍스트)" required> <%-- 필수 항목 체크 [cite: 1, 5-4] --%>
                </div>

                <%-- 작성자는 로그인 정보에서 가져오거나 관리자로 고정 (요구사항 반영) [cite: 1, 5-4] --%>
                <input type="hidden" name="writer" value="admin"> 

                <div class="text-right">
                    <button type="submit" class="btn btn-success btn-lg">등록 완료</button>
                    <button type="reset" class="btn btn-outline-secondary btn-lg">다시 입력</button>
                    <button type="button" id="btnCancel" class="btn btn-danger btn-lg">취소</button>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>