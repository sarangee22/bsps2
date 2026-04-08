<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>퀴즈 상세 보기</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<style type="text/css">
    body {
        background-color: #f4f7f9;
        font-family: 'Noto Sans KR', sans-serif;
    }
    
    #answerArea, #explainArea { display: none; } 
    .quiz-content { white-space: pre-wrap; background: #f8f9fa; padding: 25px; border-radius: 10px; border: 1px solid #dee2e6; min-height: 100px; }
    #explainContent { white-space: pre-wrap; font-size: 1.1em; color: #2c3e50; }
    
    .card { border: none; box-shadow: 0 4px 12px rgba(0,0,0,0.1); border-radius: 10px; overflow: hidden; }

    /* 헤더 및 제목 색상: 커뮤니티 네이비 */
    .card-header.bg-primary {
        background-color: #1A237E !important;
    }
    .text-info { color: #1A237E !important; }

    /* [커뮤니티 스타일 규격 적용] */
    .btn {
        display: inline-block;
        padding: 12px 22px !important; /* 커뮤니티와 동일한 패딩 */
        border-radius: 12px !important; /* 커뮤니티와 동일한 둥글기 */
        font-weight: 700 !important;    /* 커뮤니티와 동일한 글자 두께 */
        font-size: 1rem !important;     /* 글자 크기 일치 */
        text-decoration: none;
        border: none !important;
        transition: 0.2s;
        cursor: pointer;
    }
    
    /* 1. 퀴즈 풀기: 요청하신 민트색 (#17a2b8) */
    .btn-info { background-color: #17a2b8 !important; color: white !important; }
    .btn-info:hover { background-color: #138496 !important; }

.btn-warning {
        background-color: #FFA000 !important; 
        color: white !important; 
        border: none !important;
    }
    .btn-warning:hover { 
        background-color: #FFB300 !important; 
    }

    /* 돌아가기 버튼용 (기존 유지) */
    .btn-secondary { 
        background-color: #6c757d !important; 
        color: white !important; 
    }
    .btn-secondary:hover { 
        background-color: #5a6268 !important; 
    }

    /* 3. 정답 제출: 초록색 */
    .btn-success { background-color: #28a745 !important; color: white !important; }
    .btn-success:hover { background-color: #218838 !important; }

    /* 4. 수정: 네이비 */
    .btn-primary { background-color: #1A237E !important; color: white !important; }
    .btn-primary:hover { background-color: #0d145c !important; }
    
    /* 5. 삭제: 레드 */
    .btn-danger { background-color: #ff4d4f !important; color: white !important; }
    .btn-danger:hover { background-color: #d9363e !important; }
</style>

<script type="text/javascript">
$(function(){
    $("#btnSolve").click(function(){
        $("#answerArea").slideDown();
        $(this).hide();
    });

    $("#btnSubmit").click(function(){
        let userAns = $("#userAns").val().trim();
        let dbAns = "${vo.vo.ans}"; 

        if(userAns.toUpperCase() == dbAns.toUpperCase()) {
            alert("정답입니다! 🎉\n확인을 누르시면 상세 해설이 나타납니다."); 
            let explainData = `${vo.explain}`;
            $("#explainContent").text(explainData); 
            $("#explainArea").fadeIn(); 
            $("#btnSubmit, #userAns, #btnReset").attr("disabled", true);
        } else {
            alert("오답입니다. 다시 한번 생각해보세요! 🤔");
            $("#userAns").val("").focus();
        }
    });

    $("#btnReset").click(function(){
        $("#userAns").val("").focus();
        $("#explainArea").hide();
    });

    $("#btnDelete").click(function(){
        if(confirm("정말로 이 퀴즈를 삭제하시겠습니까?")) {
            location = "delete.do?no=${vo.vo.no}";
        }
    });
});
</script>
</head>
<body>
<div class="container mt-5">
    <div class="card">
        <div class="card-header bg-primary text-white">
            <h4 class="mb-0">[${vo.vo.no}] ${vo.vo.title}</h4> 
        </div>
        
        <div class="card-body">
            <div class="text-right text-muted mb-3">
                작성자: <strong>${vo.vo.writer}</strong> | 
                조회수: ${vo.vo.hit} | 
                작성일: ${vo.vo.writeDate}
            </div>
            <hr>
            
            <h5 class="text-info"><strong>문제 내용</strong></h5>
            <div class="quiz-content mb-4">${vo.vo.content}</div>

            <div id="answerArea" class="p-4 border rounded bg-light">
                <div class="form-group">
                    <label for="userAns"><strong>정답을 입력하세요:</strong></label>
                    <input type="text" id="userAns" class="form-control form-control-lg" placeholder="">
                </div>
                <button type="button" id="btnSubmit" class="btn btn-success btn-lg">정답 제출</button>
                <button type="button" id="btnReset" class="btn btn-warning btn-lg">새로입력</button>
            </div>

            <div id="explainArea" class="mt-4">
                <div class="alert alert-warning border-warning">
                    <h5 class="alert-heading"><strong>💡 상세 해설</strong></h5>
                    <hr>
                    <p class="mb-1"><strong>공식 정답:</strong> <span class="badge badge-success">${vo.vo.ans}</span></p>
                    <p id="explainContent" class="mt-3"></p>
                </div>
            </div>
        </div>
        
        <div class="card-footer bg-white text-right">
            <button type="button" id="btnSolve" class="btn btn-info btn-lg">퀴즈 풀기</button>
            
            <c:if test="${!empty login && login.gradeNo == 9}">
                <a href="updateForm.do?no=${vo.vo.no}&inc=0" class="btn btn-primary btn-lg">수정</a>
                <button type="button" id="btnDelete" class="btn btn-danger btn-lg">삭제</button>
            </c:if>
            
            <a href="list.do" class="btn btn-secondary btn-lg">돌아가기</a>
        </div>
    </div>
</div>
</body>
</html>