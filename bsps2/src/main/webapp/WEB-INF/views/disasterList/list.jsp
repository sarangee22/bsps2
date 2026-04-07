<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>

<style>
    /* 전체 배경 및 폰트 설정 */
    body { background-color: #f4f7f6; font-family: 'Pretendard', sans-serif; }
    
    /* 헤더 섹션 */
    .header-section { padding: 40px 0 20px; }
    .header-section h2 { font-weight: 800; color: #1a237e; letter-spacing: -1px; }

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

    /* 테이블 컨테이너 디자인 (카드 느낌) */
    .list-wrapper {
        background: white;
        border-radius: 25px;
        padding: 30px;
        box-shadow: 0 15px 35px rgba(0,0,0,0.05);
        border: 1px solid rgba(0,0,0,0.03);
    }
    
    /* 테이블 스타일 커스텀 */
    .custom-table thead th {
        background-color: #f8f9fa;
        color: #666;
        font-weight: 700;
        border-top: none;
        padding: 20px;
        text-transform: uppercase;
        font-size: 0.85rem;
    }
    .custom-table tbody tr {
        transition: all 0.3s ease;
        border-bottom: 1px solid #f8f9fa;
    }
    .custom-table tbody tr:hover {
        background-color: #f0f4ff !important;
        transform: translateY(-2px);
    }
    .custom-table td {
        padding: 25px 20px;
        color: #444;
    }

    /* 등급 배지 스타일 */
    .risk-badge {
        display: inline-block;
        width: 60px;
        color: white !important;
        padding: 6px 0;
        font-weight: 800;
        font-size: 0.8rem;
        border-radius: 8px;
        text-align: center;
        box-shadow: 0 4px 10px rgba(0,0,0,0.1);
    }

    /* 지역 태그 스타일 */
    .location-tag {
    display: inline-block;
    background-color: rgba(92, 103, 242, 0.08) !important;
    color: #5c67f2 !important;
    border: 1px solid rgba(92, 103, 242, 0.2) !important;
    padding: 6px 16px;       
    border-radius: 10px;     
    font-weight: 700;
    font-size: 0.9rem;       
    line-height: 1.2;        
    white-space: nowrap;     
}

    /* 재난 내용 텍스트 */
    .content-summary {
        font-weight: 500;
        color: #333;
        line-height: 1.5;
    }
    .date-text { color: #888; font-size: 0.85rem; font-weight: 500; }
</style>

<div class="container mt-4">
    <div class="header-section">
        <h2 class="display-6"><i class="bi bi-broadcast text-primary me-2"></i> ${(empty headTitle) ? "재난" : headTitle} 상황판</h2>
        <p class="text-muted">실시간으로 수집된 재난 문자 및 분석 데이터를 확인하세요.</p>
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

    <div class="list-wrapper">
        <div class="table-responsive">
            <table class="table custom-table align-middle">
                <thead>
                    <tr class="text-center">
                        <th style="width: 8%">No.</th>
                        <th style="width: 12%">위험 등급</th> 
                        <th style="width: 15%">지역</th>
                        <th>상세 내용</th>
                        <th style="width: 18%">발송 일시</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${list}" var="vo">
                        <tr onclick="location='view.do?no=${vo.no}&inc=1&catID=${param.catID}&page=${pageObject.page}&perPageNum=${pageObject.perPageNum}'" style="cursor:pointer;">
                            <td class="text-center date-text">${vo.no}</td>
                            <td class="text-center">
                                <span class="risk-badge" 
                                      style="background-color: ${vo.dangerLevel == 3 ? '#ff4d4d' : (vo.dangerLevel == 2 ? '#ffcc00' : (vo.dangerLevel == 1 ? '#28a745' : '#17a2b8'))} !important;">
                                    ${vo.dangerLevel == 3 ? '위험' : (vo.dangerLevel == 2 ? '주의' : (vo.dangerLevel == 1 ? '보통' : '정보'))}
                                </span>
                            </td>
                            <td class="text-center">
                                <span class="location-tag">${vo.locationName}</span>
                            </td>
                            <td class="text-start">
                                <div class="content-summary text-truncate" style="max-width: 450px;">
                                    ${vo.content}
                                </div>
                            </td>
                            <td class="text-center date-text">${vo.createDate}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <div class="d-flex justify-content-between align-items-center mt-5">
            <a href="/disasterCategory/list.do" class="btn btn-light rounded-pill px-4 border shadow-sm">
                <i class="bi bi-grid-fill me-2"></i> 카테고리 이동
            </a>
            <div class="pagination-wrapper">
                <pageNav:pageNav listURI="list.do" pageObject="${pageObject }" query="&catID=${param.catID}"/>
            </div>
            <div style="width: 140px;"></div> </div>
    </div>
</div>