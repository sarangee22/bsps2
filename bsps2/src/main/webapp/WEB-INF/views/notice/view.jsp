<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지 상세 정보</title>

<style type="text/css">
    body { background-color: #f4f7f6; font-family: 'Pretendard', sans-serif; }
    
    /* 상세보기 카드 스타일 */
    .notice-view-card {
        background: white;
        border-radius: 25px;
        padding: 40px;
        box-shadow: 0 15px 35px rgba(0,0,0,0.05);
        margin-top: 50px;
        border: 1px solid rgba(0,0,0,0.03);
    }

    /* 제목 영역 */
    .notice-header {
        border-bottom: 2px solid #f1f3f5;
        padding-bottom: 25px;
        margin-bottom: 30px;
    }
    .notice-header h3 { font-weight: 800; color: #1a237e; }
    
    /* 레이블 스타일 */
    .info-label {
        font-weight: 700;
        color: #888;
        width: 120px;
        display: inline-block;
        font-size: 0.95rem;
    }
    
    /* 내용 박스 스타일 */
    .notice-content {
        background-color: #f8f9fa;
        padding: 30px;
        border-radius: 15px;
        min-height: 200px;
        line-height: 1.8;
        color: #333;
        font-size: 1.05rem;
        border-left: 5px solid #5c67f2;
    }

    /* 하단 메타 정보 (날짜 등) */
    .meta-info {
        background: #fff;
        border-top: 1px solid #f1f3f5;
        padding-top: 20px;
        margin-top: 40px;
    }
    .date-badge {
        background-color: #f0f2ff;
        color: #5c67f2;
        padding: 4px 12px;
        border-radius: 6px;
        font-weight: 600;
        font-size: 0.85rem;
    }

    /* 버튼 스타일 */
    .btn-custom { border-radius: 10px; padding: 10px 25px; font-weight: 600; }
</style>

<script type="text/javascript">
 $(function(){
	 $("#deleteBtn").click(function(){
		if(!confirm("공지사항을 정말 삭제하시겠습니까?")) return false;
	 });
 });
</script>
</head>
<body>

<div class="container">
    <div class="notice-view-card">
        <div class="notice-header">
            <div class="mb-2">
                <span class="badge bg-primary mb-2" style="border-radius: 5px;">공지사항</span>
            </div>
            <h3>${vo.title}</h3>
            <div class="mt-3">
                <span class="info-label"><i class="bi bi-calendar-check"></i> 공지 기간 :</span>
                <span class="date-badge">${vo.startDate} ~ ${vo.endDate}</span>
            </div>
        </div>

        <div class="notice-body">
            <div class="notice-content">
                ${vo.content}
            </div>
        </div>

        <div class="meta-info">
            <div class="row text-muted" style="font-size: 0.9rem;">
                <div class="col-md-6">
                    <span class="info-label"><i class="bi bi-pencil-square"></i> 최종 수정 :</span> ${vo.updateDate}
                </div>
                <div class="col-md-6">
                    <span class="info-label"><i class="bi bi-clock-history"></i> 최초 등록 :</span> ${vo.writeDate}
                </div>
            </div>
        </div>

        <div class="mt-5 d-flex justify-content-between">
            <div>
                <a href="list.do?page=${param.page}&perPageNum=${param.perPageNum}&key=${param.key}&word=${param.word}&period=${param.period}"
                   class="btn btn-outline-dark btn-custom">
                   <i class="bi bi-list-ul"></i> 목록으로
                </a>
            </div>
            
            <c:if test="${!empty login && login.gradeNo == 9}">
                <div>
                    <a href="updateForm.do?no=${param.no}&page=${param.page}&perPageNum=${param.perPageNum}&key=${param.key}&word=${param.word}&period=${param.period}"
                       class="btn btn-primary btn-custom me-2">
                       <i class="bi bi-pencil"></i> 수정
                    </a>
                    <a id="deleteBtn" href="delete.do?no=${param.no}&page=${param.page}&perPageNum=${param.perPageNum}&key=${param.key}&word=${param.word}&period=${param.period}"
                       class="btn btn-danger btn-custom">
                       <i class="bi bi-trash"></i> 삭제 
                    </a>
                </div>
            </c:if>
        </div>
    </div>
</div>

</body>
</html>