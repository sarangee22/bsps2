<%-- 퀴즈 상세보기 및 풀기 화면 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>퀴즈 보기</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<style type="text/css">
    #answerArea, #explainArea { display: none; } /* 초기에는 정답창과 해설을 숨김  */
    .quiz-content { white-space: pre-wrap; background: #f9f9f9; padding: 20px; border-radius: 5px; }
</style>

<script type="text/javascript">
$(function(){
    // 1. 퀴즈 풀기 버튼 클릭 시 입력창 활성화 
    $("#btnSolve").click(function(){
        $("#answerArea").slideDown();
        $(this).hide();
    });

    // 2. 정답 제출 및 비교 로직 
    $("#btnSubmit").click(function(){
        let userAns = $("#userAns").val().trim(); // 사용자가 입력한 값
        let dbAns = "${vo.ans}"; // DB에 저장된 정답 

        if(userAns == dbAns) {
            alert("정답입니다!"); // 
            $("#explainArea").fadeIn(); // 숨겨진 해설 영역 노출 
            $("#btnSubmit, #userAns").attr("disabled", true);
        } else {
            alert("다시 생각해보세요."); // 
            $("#userAns").val("").focus(); // 입력란 초기화 
        }
    });

    // 3. 다시 풀기 
    $("#btnReset").click(function(){
        $("#userAns").val("").attr("disabled", false);
        $("#btnSubmit").attr("disabled", false);
        $("#explainArea").hide();
    });

    // 4. 삭제 버튼 클릭 시 확인 팝업 
    $("#btnDelete").click(function(){
        if(confirm("정말로 이 퀴즈를 삭제 하시겠습니까?")) {
            location = "delete.do?no=${vo.no}";
        }
    });
});
</script>
</head>
<body>
<div class="container mt-5">
    <div class="card">
        <div class="card-header bg-dark text-white">
            <h3>[${vo.no}] ${vo.title}</h3> <%-- 번호 및 제목 출력 [cite: 1] --%>
        </div>
        <div class="card-body">
            <div class="text-right text-muted mb-2">
                작성자: ${vo.writer} | 작성일: ${vo.writeDate} | 조회수: ${vo.hit}
            </div>
            <hr>
            <h5><strong>[문제 내용]</strong></h5>
            <div class="quiz-content mb-4">${vo.content}</div> <%-- 문제 내용(지문) [cite: 1, 4] --%>

            <%-- 퀴즈 풀기 영역 (초기 숨김) [cite: 1] --%>
            <div id="answerArea" class="alert alert-info">
                <div class="form-group">
                    <label for="userAns"><strong>정답 입력:</strong></label>
                    <input type="text" id="userAns" class="form-control" placeholder="정답을 입력하세요.">
                </div>
                <button type="button" id="btnSubmit" class="btn btn-success">정답 제출</button>
                <button type="button" id="btnReset" class="btn btn-secondary">다시 풀기</button>
            </div>

            <%-- 해설 영역 (정답 맞을 때만 노출) [cite: 1] --%>
            <div id="explainArea" class="mt-4">
                <div class="alert alert-warning">
                    <h5><strong>🎉 상세 해설</strong></h5>
                    <p>정답은 <strong>${vo.ans}</strong> 입니다.</p>
                    <p>본 퀴즈의 상세한 해설은 위 지문을 참고하시거나 추가 안내를 확인하세요.</p>
                </div>
            </div>
        </div>
        
        <div class="card-footer text-right">
            <button type="button" id="btnSolve" class="btn btn-info">퀴즈 풀기</button>
            
            <%-- 관리자 또는 본인인 경우에만 수정/삭제 버튼 노출 시나리오 [cite: 1] --%>
            <a href="updateForm.do?no=${vo.no}&inc=0" class="btn btn-warning">수정</a>
            <button type="button" id="btnDelete" class="btn btn-danger">삭제</button>
            <a href="list.do" class="btn btn-primary">리스트</a>
        </div>
    </div>
</div>
</body>
</html>