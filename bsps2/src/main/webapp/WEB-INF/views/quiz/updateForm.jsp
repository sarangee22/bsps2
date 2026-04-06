<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>퀴즈 수정</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<div class="container mt-5">
    <div class="card shadow">
        <div class="card-header bg-warning text-dark">
            <h4>퀴즈 및 해설 수정</h4>
        </div>
        <div class="card-body">
            <form action="update.do" method="post">
                <%-- 1. 글번호 (수정 불가, 전송용) --%>
                <div class="form-group">
                    <label for="no"><strong>번호</strong></label>
                    <input type="text" name="no" id="no" class="form-control" value="${vo.vo.no}" readonly>
                </div>
                
                <%-- 2. 퀴즈 제목 --%>
                <div class="form-group">
                    <label for="title"><strong>퀴즈 제목</strong></label>
                    <input type="text" name="title" id="title" class="form-control" 
                           value="${vo.vo.title}" required>
                </div>
                
                <%-- 3. 문제 지문 --%>
                <div class="form-group">
                    <label for="content"><strong>문제 내용 (지문)</strong></label>
                    <textarea name="content" id="content" rows="5" class="form-control" 
                              required>${vo.vo.content}</textarea>
                </div>
                
                <%-- 4. 퀴즈 정답 --%>
                <div class="form-group">
                    <label for="ans"><strong>퀴즈 정답</strong></label>
                    <input type="text" name="ans" id="ans" class="form-control" 
                           value="${vo.vo.ans}" required>
                </div>

                <%-- 5. 추가된 상세 해설 수정란 --%>
                <div class="form-group">
                    <label for="explain"><strong class="text-danger"> 상세 해설 수정</strong></label>
                    <%-- 해설 데이터는 Map의 explain 키에 들어있습니다. --%>
                    <textarea name="explain" id="explain" rows="4" class="form-control" 
                              placeholder="수정할 해설 내용을 입력하세요" required>${vo.explain}</textarea>
                </div>

                <div class="text-right mt-4">
                    <button type="submit" class="btn btn-primary btn-lg">수정 완료</button>
                    <button type="button" class="btn btn-outline-secondary btn-lg" onclick="history.back();">취소</button>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>