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
    #answerArea, #explainArea { display: none; } 
    .quiz-content { white-space: pre-wrap; background: #f8f9fa; padding: 25px; border-radius: 10px; border: 1px solid #dee2e6; min-height: 100px; }
    #explainContent { white-space: pre-wrap; font-size: 1.1em; color: #2c3e50; }
    .card { border: none; box-shadow: 0 4px 8px rgba(0,0,0,0.1); }
</style>

<script type="text/javascript">
$(function(){
    // 1. 퀴즈 풀기 버튼 클릭
    $("#btnSolve").click(function(){
        $("#answerArea").slideDown();
        $(this).hide();
    });

    // 2. 정답 제출 및 해설 노출 로직
    $("#btnSubmit").click(function(){
        let userAns = $("#userAns").val().trim();
        let dbAns = "${vo.vo.ans}"; 

        if(userAns.toUpperCase() == dbAns.toUpperCase()) {
            alert("정답입니다! 🎉\n확인을 누르시면 상세 해설이 나타납니다."); 
            
            // 🔥 [수정 포인트] 따옴표("") 대신 백틱(``)을 사용하여 DB의 줄바꿈 에러를 방지합니다.
            let explainData = `${vo.explain}`;
            
            $("#explainContent").text(explainData); 
            $("#explainArea").fadeIn(); 
            $("#btnSubmit, #userAns, #btnReset").attr("disabled", true);
        } else {
            alert("오답입니다. 다시 한번 생각해보세요! 🤔");
            $("#userAns").val("").focus();
        }
    });

    // 3. 다시 입력 버튼
    $("#btnReset").click(function(){
        $("#userAns").val("").focus();
        $("#explainArea").hide();
    });

    // 4. 삭제 확인
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

            <%-- 정답 입력 영역 --%>
            <div id="answerArea" class="p-4 border rounded bg-light">
                <div class="form-group">
                    <label for="userAns"><strong>정답을 입력하세요:</strong></label>
                    <input type="text" id="userAns" class="form-control form-control-lg" placeholder="예: O 또는 X">
                </div>
                <button type="button" id="btnSubmit" class="btn btn-success btn-lg">정답 제출</button>
                <button type="button" id="btnReset" class="btn btn-outline-secondary btn-lg">다시 입력</button>
            </div>

            <%-- 상세 해설 영역 --%>
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
            
            <%-- ✨ 관리자(gradeNo == 9)인 경우만 수정, 삭제 버튼 노출 --%>
            <c:if test="${!empty login && login.gradeNo == 9}">
                <a href="updateForm.do?no=${vo.vo.no}&inc=0" class="btn btn-warning btn-lg">수정</a>
                <button type="button" id="btnDelete" class="btn btn-danger btn-lg">삭제</button>
            </c:if>
            
            <a href="list.do" class="btn btn-secondary btn-lg">돌아가기</a>
        </div>
    </div>
</div>
</body>
</html>