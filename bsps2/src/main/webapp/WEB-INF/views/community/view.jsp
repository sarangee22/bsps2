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

/* 제목 */
h3 {
    font-size: 28px;
    font-weight: 800;
    color: #1A237E;
}

/* 테이블 */
.table {
    border-collapse: collapse;
    width: 100%;
}

.table th {
    width: 140px;
    background: #f8f9fa;
    color: #555;
    font-weight: 300;
    text-align: center;
    padding: 15px;
    border-bottom: 1px solid #eee;
}

.table td {
    padding: 18px;
    border-bottom: 1px solid #f1f4f8;
    color: #333;
}

/* 이미지 */
.community-img {
    max-width: 100%;
    border-radius: 15px;
    box-shadow: 0 10px 20px rgba(0,0,0,0.08);
}

/* 버튼 */
.btn {
    padding: 10px 18px;
    border-radius: 10px;
    font-weight: 700;
    text-decoration: none;
    border: none;
}

.btn-primary {
    background: #1A237E;
    color: white;
}

.btn-danger {
    background: white;
    border: 1px solid #ff4d4f;
    color: #ff4d4f;
}

.btn-info {
    background: blue;
    border: 1px solid #ddd;
    color: #555;
}

/* 삭제 영역 */
#deleteDiv {
    display: none;
    margin-top: 20px;
    border: 1px solid #ff4d4f;
    border-radius: 15px;
    overflow: hidden;
}

#deleteDiv .card-header {
    background: #ff4d4f;
    color: white;
    padding: 12px;
    font-weight: 700;
}

#deleteDiv .card-body {
    padding: 15px;
}

#deleteDiv input {
    width: 100%;
    padding: 10px;
    border-radius: 8px;
    border: 1px solid #ddd;
}

#deleteDiv .card-footer {
    padding: 15px;
    display: flex;
    gap: 10px;
}
</style>


<script type="text/javascript">
$(function(){
	// 삭제 버튼 및 취소 버튼 클릭 시 동작
	$("#deleteBtn, #cancelBtn").click(function(){
		$("#pw").val("");
		$("#deleteDiv").toggle();
		if($("#deleteDiv").is(":visible"))$("#pw").focus();
	})
})
</script>
</head>
<body>
<div class = "container">
	<h3 class="m-4 mb-4">제보 상세 내용</h3>
	
	<table class="table table-boardered">
		<tbody>
			<tr>
				<th>번호</th>
				<td>${vo.no }</td>
			</tr>
			<tr>
				<th>제목</th>
				<td>${vo.title }</td>
			</tr>
			<tr>
				<th>
				제보이미지 <br><br>
				<td class="text-center">
    					<c:if test="${!empty vo.fileName}">
        					<img src="${vo.fileName}" alt="제보 이미지" class="community-img">
    					</c:if>
				</td>
				
			</tr>
			<tr>
				<th>내용</th>
				<td><pre style="white-space: pre-wrap; border: none; padding: 0;">${vo.content}</pre></td>
			</tr>
			<tr>
				<th>작성자</th>
				<td>${vo.writer }</td>
			</tr>
			<tr>
				<th>작성일</th>
				<td>${vo.writeDate }</td>
			</tr>
			<tr>
				<th>조회수</th>
				<td>${vo.hit }</td>
			</tr>
		</tbody>
	</table>
	
	<div class="mb-4">
        <%-- ✨ 권한 체크: 로그인 중이고 (작성자 본인이거나 관리자인 경우) --%>
        <c:if test="${!empty login && (login.id == vo.writer || login.gradeNo == 9)}">
		    <a href="updateForm.do?no=${vo.no }&page=${param.page }&perPageNum=${param.perPageNum}&key=${param.key}&word=${param.word}"
		    class="btn btn-primary">수정</a>
		    <button type="button" class="btn btn-danger" id="deleteBtn">삭제</button>
        </c:if>
        
		<a href="list.do?page=${param.page }&perPageNum=${param.perPageNum}&key=${param.key}&word=${param.word}" 
		   class="btn btn-info text-white">리스트</a>
	</div>
	
    <%-- ✨ 삭제 영역도 권한이 있을 때만 렌더링되도록 감싸줍니다 --%>
    <c:if test="${!empty login && (login.id == vo.writer || login.gradeNo == 9)}">
        <div class="card border-danger mb-5" id="deleteDiv">
            <div class="card-header bg-danger text-white">삭제</div>
            <form action="delete.do"method="post">
                <input type="hidden" name="no" value="${vo.no}">
                <input type="hidden" name="perPageNum" value="${param.perPageNum }">
                <div class="card-body">
                    <input name="pw" type="password" id="pw" class="form-control" placeholder="삭제를 위해 비밀번호를 입력하세요" required>
                </div>
                <div class="card-footer text-end">
                    <button type="submit"class="btn btn-danger">삭제 확정</button>
                    <%-- 취소 버튼에 id="cancelBtn"이 빠져있어서 추가했습니다 --%>
                    <button type="button" class="btn btn-secondary" id="cancelBtn">취소</button>
                </div>
            </form>
        </div>
    </c:if>
</div>	

</body>
</html>