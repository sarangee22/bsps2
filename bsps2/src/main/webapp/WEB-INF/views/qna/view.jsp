<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>질문답변 상세보기</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
<style>
    body { font-family: 'Noto Sans KR', sans-serif; margin: 0; padding: 0; background-color: #f4f7f9; color: #2c3e50; }
    
    .container { width: 1100px; margin: 50px auto; background-color: #fff; border-radius: 16px; box-shadow: 0 10px 30px rgba(0,0,0,0.05); overflow: hidden; min-height: 700px; }
    
    :root { --main-navy: #1a2a4e; --accent-blue: #3498db; --border-light: #eff2f5; }

    main { padding: 50px; }

    .view-card { border: 1px solid var(--border-light); border-radius: 12px; background-color: #fff; overflow: hidden; margin-bottom: 30px; }
    
    .card-label { background-color: #f8f9fa; padding: 12px 25px; font-size: 13px; font-weight: 700; color: var(--main-navy); border-bottom: 1px solid var(--border-light); display: flex; align-items: center; gap: 8px; }
    .card-label::before { content: '📌'; }

    .card-content { padding: 40px; }
    
    .content-header { margin-bottom: 30px; border-bottom: 1px solid var(--border-light); padding-bottom: 20px; }
    .content-title { font-size: 26px; font-weight: 700; color: var(--main-navy); margin-bottom: 15px; }
    
    .info-bar { display: flex; gap: 20px; font-size: 14px; color: #94a3b8; }
    .info-bar span { display: flex; align-items: center; gap: 5px; }
    .info-bar b { color: #64748b; }

    .content-text { background-color: #fcfdfe; padding: 35px; border-radius: 12px; min-height: 250px; font-size: 16px; line-height: 1.8; white-space: pre-wrap; color: #34495e; border: 1px solid #f0f4f8; }

    .action-row { display: flex; justify-content: space-between; align-items: center; margin-top: 30px; padding-top: 20px; }
    
    .btn-group { display: flex; gap: 10px; }
    .btn { padding: 10px 20px; border-radius: 8px; font-size: 14px; font-weight: 600; cursor: pointer; text-decoration: none; transition: 0.2s; display: inline-flex; align-items: center; gap: 6px; }
    
    .btn-outline { border: 1px solid #e1e4e8; color: #64748b; background-color: #fff; }
    .btn-outline:hover { background-color: #f8f9fa; color: #2c3e50; border-color: #cbd5e1; }
    
    .btn-navy { background-color: var(--main-navy); color: white; border: none; }
    .btn-navy:hover { background-color: #233966; transform: translateY(-1px); }
    
    .btn-list { background-color: #fff; color: var(--main-navy); border: 2px solid var(--main-navy); padding: 10px 30px; border-radius: 10px; font-weight: 700; }
    .btn-list:hover { background-color: var(--main-navy); color: #fff; }

    .btn-danger { color: #e74c3c; border: 1px solid #fadbd8; }
    .btn-danger:hover { background-color: #fdf2f2; border-color: #e74c3c; }

    .badge-q { color: #e74c3c; background: #fdf2f2; padding: 2px 8px; border-radius: 4px; margin-right: 5px; }
    .badge-a { color: #3498db; background: #eaf2f8; padding: 2px 8px; border-radius: 4px; margin-right: 5px; }
</style>
</head>
<body>

<div class="container">
    <main>
        <div class="view-card">
            <div class="card-label">
                <c:choose>
                    <c:when test="${vo.levNo == 0}"><span class="badge-q">Q</span> 질문 상세 정보</c:when>
                    <c:otherwise><span class="badge-a">A</span> 답변 상세 정보</c:otherwise>
                </c:choose>
            </div>
            
            <div class="card-content">
                <div class="content-header">
                    <div class="content-title">${vo.title}</div>
                    <div class="info-bar">
                        <span>작성자 <b>${vo.id}</b></span>
                        <span>작성일 <b>${vo.writeDate}</b></span>
                        <span>조회수 <b>${vo.hit}</b></span>
                    </div>
                </div>

                <div class="content-text">${vo.content}</div>
                
                <div class="action-row">
                    <div class="btn-group">
                        <c:if test="${login.id == vo.id}">
                            <a href="updateForm.do?no=${vo.no}" class="btn btn-outline">수정하기</a>
                            <a href="#" class="btn btn-outline btn-danger" onclick="deleteConfirm(${vo.no})">삭제</a>
                        </c:if>
                        <c:if test="${login.id == 'admin'}">
                            <a href="answerForm.do?no=${vo.no}" class="btn btn-navy">답변하기</a>
                        </c:if>
                    </div>

                    <a href="list.do" class="btn btn-list">목록으로</a>
                </div>
            </div>
        </div>
    </main>
</div>
	<script>
function deleteConfirm(no) {
    var pw = prompt("비밀번호를 입력하세요:");
    if(pw == null) return;
    if(pw == "") {
        alert("삭제에 실패하였습니다. 비밀번호를 입력해주세요.");
        return;
    }
    location.href = "delete.do?no=" + no + "&pw=" + pw;
}
</script>


</body>
</html>