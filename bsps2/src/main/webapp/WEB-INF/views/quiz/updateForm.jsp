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
            <h4>퀴즈 수정</h4>
        </div>
        <div class="card-body">
            <form action="update.do" method="post">
                <%-- 글번호는 수정 불가능하지만 전송은 해야 하므로 readonly 처리 --%>
                <div class="form-group">
                    <label for="no">번호</label>
                    <input type="text" name="no" id="no" class="form-control" value="${vo.vo.no}" readonly>
                </div>
                
                <div class="form-group">
                    <label for="title">퀴즈 제목</label>
                    <input type="text" name="title" id="title" class="form-control" 
                           value="${vo.vo.title}" required>
                </div>
                
                <div class="form-group">
                    <label for="content">문제 내용 (지문)</label>
                    <textarea name="content" id="content" rows="6" class="form-control" 
                              required>${vo.vo.content}</textarea>
                </div>
                
                <div class="form-group">
                    <label for="ans">퀴즈 정답</label>
                    <input type="text" name="ans" id="ans" class="form-control" 
                           value="${vo.vo.ans}" required>
                </div>

                <div class="text-right">
                    <button type="submit" class="btn btn-primary btn-lg">수정 완료</button>
                    <button type="button" class="btn btn-outline-secondary btn-lg" onclick="history.back();">취소</button>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>