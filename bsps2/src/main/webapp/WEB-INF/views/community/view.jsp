<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제보 상세 보기</title>
<style type="text/css">
body {
    background-color: #f4f7f9;
    font-family: 'Noto Sans KR', sans-serif;
}

/* 전체 컨테이너 */
.container {
    max-width: 1000px;
    margin: 80px auto;
}

/* 제목 */
h3 {
    font-size: 28px;
    font-weight: 800;
    color: #1A237E;
    margin-bottom: 30px;
}

/* [1] 리스트와 동일한 입체감 카드 레이아웃 */
.table-card {
    background: white !important;
    border-radius: 25px !important;
    box-shadow: 0 15px 45px rgba(0, 0, 0, 0.15) !important;
    overflow: hidden;
    margin-bottom: 30px;
    border: 1px solid #dee2e6 !important;
}

/* [2] 테이블 구조 설정 */
.view-table {
    width: 100%;
    border-collapse: collapse;
    table-layout: fixed;
}

/* [3] 왼쪽 항목명(th): list.jsp와 동일한 회색 적용 */
.view-table tbody tr th {
    width: 160px;
    
    /* list.jsp 스타일 그대로 가져옴: 배경색과 그라디언트 병행 */
    background-color: #e2e6ea !important;
    background: linear-gradient(#e2e6ea, #e2e6ea) !important; 
    
    /* 약간 더 어둡게 하고 싶다면 brightness 조절 (선택사항) */
    filter: brightness(0.97); 
    
    color: #333 !important;
    font-weight: 800;
    text-align: center;
    padding: 20px;
    
    /* 선명한 구분선 */
    border-bottom: 1.5px solid #dee2e6 !important;
    border-right: 1.5px solid #dee2e6 !important;
    
    vertical-align: middle;
    -webkit-print-color-adjust: exact;
}
/* [4] 오른쪽 데이터 칸(td) */
.view-table tbody tr td {
    padding: 20px;
    background-color: #ffffff !important;
    border-bottom: 1.5px solid #dee2e6 !important;
    color: #333;
    vertical-align: middle;
}

/* 마지막 줄 바닥 선 제거 */
.view-table tr:last-child th,
.view-table tr:last-child td {
    border-bottom: none !important;
}

/* 이미지 스타일 */
.community-img {
    max-width: 100%;
    height: auto;
    border-radius: 15px;
    box-shadow: 0 5px 15px rgba(0,0,0,0.1);
}

/* 버튼 디자인 */
.btn {
    display: inline-block;
    padding: 12px 22px;
    border-radius: 12px;
    font-weight: 700;
    text-decoration: none;
    border: none;
    transition: 0.2s;
    cursor: pointer;
}

.btn-primary { background: #1A237E; color: white; }
.btn-primary:hover { background: #0d145c; }

.btn-danger { background: #ff4d4f; color: white; }
.btn-danger:hover { background: #d9363e; }

.btn-info { background: #007bff; color: white !important; }
.btn-info:hover { background: #0069d9; }

.btn-secondary { background: #6c757d; color: white; }

/* 삭제 영역 */
#deleteDiv {
    display: none;
    margin-top: 20px;
    border-radius: 20px;
    overflow: hidden;
    box-shadow: 0 10px 25px rgba(255, 77, 79, 0.2);
    border: 1px solid #ff4d4f;
}

.card-header { background: #ff4d4f; color: white; padding: 15px; font-weight: 800; }
.card-body { padding: 25px; background: white; }
.card-body input { 
    width: 100%; padding: 12px; border-radius: 10px; border: 1px solid #ddd; 
}
.card-footer { padding: 15px; background: #f8f9fa; text-align: right; }

.button-group { display: flex; gap: 10px; margin-bottom: 40px; margin-left: 15px; }
</style>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(function(){
	// 삭제 버튼 및 취소 버튼 클릭 시 동작
	$("#deleteBtn, #cancelBtn").click(function(){
		$("#pw").val("");
		$("#deleteDiv").toggle();
		if($("#deleteDiv").is(":visible")) {
            $('html, body').animate({scrollTop: $("#deleteDiv").offset().top}, 500);
            $("#pw").focus();
        }
	})
})
</script>
</head>
<body>
<div class="container">
	<h3 class="mt-4 mb-4">제보 상세 내용</h3>
	
    <div class="table-card">
        <table class="view-table">
            <tbody>
                <tr>
                    <th>번호</th>
                    <td>${vo.no}</td>
                </tr>
                <tr>
                    <th>제목</th>
                    <td>${vo.title}</td>
                </tr>
                <tr>
                    <th>제보 이미지</th>
                    <td>
                        <c:if test="${!empty vo.fileName}">
                            <div class="text-center">
                                <img src="${vo.fileName}" alt="제보 이미지" class="community-img">
                            </div>
                        </c:if>
                        <c:if test="${empty vo.fileName}">이미지가 없습니다.</c:if>
                    </td>
                </tr>
                <tr>
                    <th>내용</th>
                    <td>
                        <pre style="white-space: pre-wrap; border: none; padding: 0; font-family: inherit; background: transparent;">${vo.content}</pre>
                    </td>
                </tr>
                <tr>
                    <th>작성자</th>
                    <td>${vo.writer}</td>
                </tr>
                <tr>
                    <th>작성일</th>
                    <td>${vo.writeDate}</td>
                </tr>
                <tr>
                    <th>조회수</th>
                    <td>${vo.hit}</td>
                </tr>
            </tbody>
        </table>
    </div>
	
	<div class="button-group">
        <c:if test="${!empty login && (login.id == vo.writer || login.gradeNo == 9)}">
		    <a href="updateForm.do?no=${vo.no}&page=${param.page}&perPageNum=${param.perPageNum}&key=${param.key}&word=${param.word}"
		    class="btn btn-primary">수정</a>
		    <button type="button" class="btn btn-danger" id="deleteBtn">삭제</button>
        </c:if>
		<a href="list.do?page=${param.page}&perPageNum=${param.perPageNum}&key=${param.key}&word=${param.word}" 
		   class="btn btn-info">리스트</a>
	</div>
	
    <c:if test="${!empty login && (login.id == vo.writer || login.gradeNo == 9)}">
        <div id="deleteDiv">
            <div class="card-header">제보 삭제</div>
            <form action="delete.do" method="post">
                <input type="hidden" name="no" value="${vo.no}">
                <input type="hidden" name="perPageNum" value="${param.perPageNum}">
                <div class="card-body">
                    <p style="color: #666; margin-bottom: 10px;">삭제를 위해 비밀번호를 입력해 주세요.</p>
                    <input name="pw" type="password" id="pw" required placeholder="비밀번호 입력">
                </div>
                <div class="card-footer">
                    <button type="submit" class="btn btn-danger">삭제 확정</button>
                    <button type="button" class="btn btn-secondary" id="cancelBtn">취소</button>
                </div>
            </form>
        </div>
    </c:if>
</div>	
</body>
</html>