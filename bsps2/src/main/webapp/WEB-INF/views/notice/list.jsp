<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>

<style type="text/css">
    /* 전체 배경 및 폰트 설정 */
    body { background-color: #f4f7f6; font-family: 'Pretendard', sans-serif; }
    
    /* 헤더 섹션 */
    .header-section { padding: 40px 0 20px; }
    .header-section h2 { font-weight: 800; color: #1a237e; letter-spacing: -1px; }

    /* 검색창 카드 디자인 (요청하신 형식 반영) */
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

    /* 리스트 컨테이너 (카드 스타일) */
    .notice-wrapper {
        background: white;
        border-radius: 25px;
        padding: 35px;
        box-shadow: 0 15px 35px rgba(0,0,0,0.05);
        border: 1px solid rgba(0,0,0,0.03);
    }

    /* 관리자 메뉴 버튼 그룹 */
    .admin-menu { margin-bottom: 25px; }
    .btn-group .btn { border-radius: 10px; font-weight: 600; padding: 10px 20px; margin-right: 5px; }

    /* 테이블 스타일 커스텀 */
    .custom-table { 
        border-collapse: separate; 
        border-spacing: 0 10px; 
        table-layout: fixed; 
        width: 100%;
    }
    .custom-table thead th {
        border: none;
        color: #888;
        font-weight: 600;
        padding: 15px 20px;
        text-align: center;
    }
    .dataRow { 
        transition: all 0.3s ease; 
        cursor: pointer;
        background-color: #fff;
    }
    .dataRow td { 
        padding: 20px; 
        vertical-align: middle; 
        border-top: 1px solid #f1f1f1;
        border-bottom: 1px solid #f1f1f1;
        overflow: hidden;
    }
    .dataRow td:first-child { border-left: 1px solid #f1f1f1; border-top-left-radius: 15px; border-bottom-left-radius: 15px; text-align: center; }
    .dataRow td:last-child { border-right: 1px solid #f1f1f1; border-top-right-radius: 15px; border-bottom-right-radius: 15px; }

    .dataRow:hover {
        transform: translateY(-3px);
        box-shadow: 0 10px 20px rgba(92, 103, 242, 0.1);
        background-color: #f8faff;
    }

    .notice-title { 
        font-weight: 700; 
        color: #333; 
        font-size: 1.1rem;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
        display: block;
    }
    
    .period-badge {
        background-color: #f0f2ff;
        color: #5c67f2;
        padding: 4px 12px;
        border-radius: 6px;
        font-size: 0.85rem;
        font-weight: 600;
    }
    
    .date-text { color: #999; font-size: 0.9rem; }
</style>

<script type="text/javascript">
 $(function(){
     $(".dataRow").click(function(){
        let no = $(this).data("no");
        location = "view.do?no=" + no + "&${pageObject.pageQuery}&period=${pageObject.period}";
     });
 });
</script>
</head>
<body>

<div class="container">
    <div class="header-section">
        <h2><i class="bi bi-megaphone-fill text-primary me-2"></i> 공지사항</h2>
        <p class="text-muted">서비스의 주요 안내 및 긴급 공지를 확인하실 수 있습니다.</p>
    </div>

    <div class="card search-card mb-4">
        <div class="card-body p-4">
            <form action="list.do" method="get" id="searchForm">
                <input type="hidden" name="period" value="${pageObject.period}">
                <div class="row g-3">
                    <div class="col-md-2">
                        <select name="key" class="form-select border-0 bg-light">
                            <option value="t" ${ (pageObject.key == 't') ? "selected" : "" }>제목</option>
                            <option value="c" ${ (pageObject.key == 'c') ? "selected" : "" }>내용</option>
                            <option value="tc" ${ (pageObject.key == 'tc') ? "selected" : "" }>제목+내용</option>
                        </select>
                    </div>
                    <div class="col-md-8">
                        <div class="input-group">
                            <span class="input-group-text bg-light border-0"><i class="bi bi-search text-muted"></i></span>
                            <input type="text" name="word" class="form-control bg-light border-0" placeholder="공지사항 키워드를 입력하세요" value="${pageObject.word}">
                        </div>
                    </div>
                    <div class="col-md-2">
                        <button class="btn btn-search btn-primary w-100 shadow-sm">검색하기</button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <c:if test="${!empty login && login.gradeNo == 9 }">
        <div class="admin-menu">
          <div class="btn-group shadow-sm">
            <a href="list.do?period=pre" class="btn ${pageObject.period == 'pre' ? 'btn-primary' : 'btn-outline-primary'}">현재공지</a>
            <a href="list.do?period=old" class="btn ${pageObject.period == 'old' ? 'btn-secondary' : 'btn-outline-secondary'}">지난공지</a>
            <a href="list.do?period=res" class="btn ${pageObject.period == 'res' ? 'btn-success' : 'btn-outline-success'}">예약공지</a>
            <a href="list.do?period=all" class="btn ${pageObject.period == 'all' ? 'btn-info' : 'btn-outline-info'}">전체</a>
          </div>
        </div>
    </c:if>

    <div class="notice-wrapper">
        <table class="table custom-table">
            <thead>
                <tr>
                    <th style="width: 10%;">번호</th> <th style="width: 45%;">제목</th> <th style="width: 25%;">공지 기간</th>
                    <th style="width: 20%;">최종 수정일</th>
                </tr>
            </thead>
            <tbody>
            <c:if test="${empty list }">
                <tr>
                    <td colspan="4" class="text-center py-5 text-muted">데이터가 존재하지 않습니다.</td>
                </tr>
            </c:if>
            <c:if test="${!empty list }">
                <c:forEach items="${list }" var="vo" varStatus="vs">
                    <tr class="dataRow" data-no="${vo.no }">
                        <td>
                            ${pageObject.totalRow - ((pageObject.page - 1) * pageObject.perPageNum) - vs.index}
                        </td>
                        <td>
                            <div class="notice-title">
                                <i class="bi bi-dot text-primary"></i> ${vo.title }
                            </div>
                        </td>
                        <td class="text-center">
                            <span class="period-badge">${vo.startDate } ~ ${vo.endDate }</span>
                        </td>
                        <td class="text-center date-text">${vo.updateDate }</td>
                    </tr>
                </c:forEach>
            </c:if>
            </tbody> 
        </table>

        <div class="d-flex justify-content-center mt-4">
            <pageNav:pageNav listURI="list.do" pageObject="${pageObject }"
             query="&period=${pageObject.period}&key=${pageObject.key}&word=${pageObject.word}" />
        </div>
    </div>

    <div class="d-flex justify-content-between mt-4">
        <a href="list.do" class="btn btn-outline-primary rounded-pill px-4">
            <i class="bi bi-arrow-clockwise"></i> 새로고침
        </a>
        <c:if test="${!empty login && login.gradeNo == 9 }">
            <a href="writeForm.do?perPageNum=${pageObject.perPageNum }" class="btn btn-primary rounded-pill px-4">
                <i class="bi bi-pencil-square"></i> 공지 등록
            </a>
        </c:if>
    </div>
</div>

</body>
</html>