<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>스크랩한 재난 정보</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>

<style>
    body { font-family: 'Pretendard', -apple-system, BlinkMacSystemFont, system-ui, Roboto, sans-serif; }
    .scrap-item { transition: 0.3s; cursor: pointer; border-radius: 12px; margin-bottom: 15px; border: 1px solid #f0f0f0; }
    .scrap-item:hover { background-color: #fff; transform: translateY(-5px); box-shadow: 0 8px 20px rgba(0,0,0,0.08); border-color: #007bff; }
    .info-label { font-size: 0.88rem; color: #777; margin-right: 20px; display: flex; align-items: center; }
    .info-label i { margin-right: 6px; color: #adb5bd; }
    
    /* 위험 등급별 색상 가이드 */
    .risk-1 { color: #28a745; font-weight: 600; } /* 낮음 */
    .risk-2 { color: #ffa500; font-weight: 600; } /* 보통 */
    .risk-3 { color: #ff4d4d; font-weight: 600; } /* 높음 */
    
    .delete-btn { color: #dee2e6; transition: 0.3s; padding: 10px; border-radius: 50%; }
    .delete-btn:hover { color: #ff4d4d; background-color: #fff1f1; }
    
    .search-bar { border-radius: 30px; border: 1px solid #e0e0e0; transition: 0.3s; }
    .search-bar:focus-within { border-color: #007bff; box-shadow: 0 0 0 0.2rem rgba(0,123,255,.1) !important; }
    
        /* 검색창 카드 디자인 */
    .search-card {
        border: none;
        border-radius: 20px;
        box-shadow: 0 10px 30px rgba(0,0,0,0.05);
        background: white;
    }
    .form-select, .form-control {
        border-radius: 10px;
        border: 1px solid #eee;
        padding: 12px;
    }
    .btn-search {
        border-radius: 10px;
        font-weight: 600;
        padding: 12px;
        background-color: #1a237e;
        border: none;
    }
</style>
</head>
<body class="bg-light">

<div class="container py-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3 class="font-weight-bold text-dark"><i class="fas fa-bookmark text-primary mr-2"></i>스크랩한 재난 정보</h3>
        <span class="text-muted">전체 <strong>${pageObject.totalRow}</strong>건</span>
    </div>

     <div class="card search-card mb-5">
        <div class="card-body p-4">
            <form action="list.do" method="get" id="searchForm">
                <input type="hidden" name="catID" value="${param.catID}">
                <div class="row g-3">
                    <div class="col-md-2">
                        <select name="key" class="form-select">
                            <option value="t" ${ (pageObject.key == 't') ? "selected" : "" }>재난 내용</option>
                            <option value="l" ${ (pageObject.key == 'l') ? "selected" : "" }>발생 지역</option>
                            <option value="tl" ${ (pageObject.key == 'tl') ? "selected" : "" }>내용+지역</option>
                        </select>
                    </div>
                    <div class="col-md-8">
                        <div class="input-group">
                            <span class="input-group-text bg-white border-end-0"><i class="bi bi-search text-muted"></i></span>
                            <input type="text" name="word" class="form-control border-start-0" placeholder="찾으시는 지역이나 키워드를 입력하세요" value="${pageObject.word}">
                        </div>
                    </div>
                    <div class="col-md-2">
                        <button class="btn btn-search btn-primary w-100 shadow-sm">검색하기</button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <c:if test="${empty list}">
        <div class="text-center py-5 bg-white shadow-sm rounded-lg">
            <i class="fas fa-folder-open fa-3x text-light mb-3"></i>
            <p class="text-muted">스크랩한 내역이 아직 없습니다.</p>
            <a href="/disasterList/list.do" class="btn btn-outline-primary btn-sm mt-2">재난 목록 보러가기</a>
        </div>
    </c:if>

    <c:forEach items="${list}" var="vo">
        <div class="scrap-item bg-white p-4 shadow-sm d-flex align-items-center justify-content-between" 
             onclick="location='/disasterList/view.do?no=${vo.no}&inc=0'">
            
            <div class="flex-grow-1">
                <div class="mb-2">
                    <span class="badge badge-pill badge-light text-primary px-3 py-2 mb-2">${vo.locationName}</span>
                </div>
                <h5 class="font-weight-bold mb-3 text-dark">${vo.content}</h5>
                
                <div class="d-flex align-items-center flex-wrap">
                    <span class="info-label" title="스크랩 일시">
                        <i class="far fa-calendar-alt"></i> ${vo.scrapDate}
                    </span>
                    
                    <span class="info-label">
                        <i class="fas fa-exclamation-circle"></i>
                        <c:choose>
                            <c:when test="${vo.dangerLevel == 1}"><span class="risk-1">낮음</span></c:when>
                            <c:when test="${vo.dangerLevel == 3}"><span class="risk-3">매우 높음</span></c:when>
                            <c:otherwise><span class="risk-2">보통</span></c:otherwise>
                        </c:choose>
                    </span>
                </div>
            </div>

            <div class="ml-3" onclick="event.stopPropagation();">
                <a href="delete.do?scrapNo=${vo.scrapNo}" class="delete-btn" 
                   onclick="return confirm('이 스크랩을 삭제하시겠습니까?');" title="스크랩 취소">
                    <i class="far fa-trash-alt fa-lg"></i>
                </a>
            </div>
        </div>
    </c:forEach>

	<c:if test="${not empty list}">
	    <nav class="mt-5">
	        <ul class="pagination justify-content-center">
	            <li class="page-item ${ (pageObject.startPage == 1) ? 'disabled' : '' }">
	                <a class="page-link border-0 mx-1 rounded" 
	                   href="list.do?page=${pageObject.startPage - 1}&perPageNum=${pageObject.perPageNum}&key=${pageObject.key}&word=${pageObject.word}">
	                   &laquo;
	                </a>
	            </li>
	
	            <c:forEach begin="${pageObject.startPage}" end="${pageObject.endPage}" var="cnt">
	                <li class="page-item ${ (pageObject.page == cnt) ? 'active' : '' }">
	                    <a class="page-link border-0 mx-1 rounded" 
	                       href="list.do?page=${cnt}&perPageNum=${pageObject.perPageNum}&key=${pageObject.key}&word=${pageObject.word}">
	                       ${cnt}
	                    </a>
	                </li>
	            </c:forEach>
	
	            <li class="page-item ${ (pageObject.endPage == pageObject.totalPage) ? 'disabled' : '' }">
	                <a class="page-link border-0 mx-1 rounded" 
	                   href="list.do?page=${pageObject.endPage + 1}&perPageNum=${pageObject.perPageNum}&key=${pageObject.key}&word=${pageObject.word}">
	                   &raquo;
	                </a>
	            </li>
	        </ul>
	    </nav>
	</c:if>
</div>

</body>
</html>