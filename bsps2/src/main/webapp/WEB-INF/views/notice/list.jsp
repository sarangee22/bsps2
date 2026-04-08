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
    .custom-table { border-collapse: separate; border-spacing: 0 10px; }
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
    }
    /* 행 양 끝 둥글게 */
    .dataRow td:first-child { border-left: 1px solid #f1f1f1; border-top-left-radius: 15px; border-bottom-left-radius: 15px; }
    .dataRow td:last-child { border-right: 1px solid #f1f1f1; border-top-right-radius: 15px; border-bottom-right-radius: 15px; }

    .dataRow:hover {
        transform: translateY(-3px);
        box-shadow: 0 10px 20px rgba(92, 103, 242, 0.1);
        background-color: #f8faff;
    }

    /* 제목 강조 */
    .notice-title { font-weight: 700; color: #333; font-size: 1.1rem; }
    
    /* 기간 배지 스타일 */
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
                    <th style="width: 50%;">제목</th>
                    <th style="width: 30%;">공지 기간</th>
                    <th style="width: 20%;">최종 수정일</th>
                </tr>
            </thead>
            <tbody>
            <c:if test="${empty list }">
                <tr>
                    <td colspan="3" class="text-center py-5 text-muted">데이터가 존재하지 않습니다.</td>
                </tr>
            </c:if>
            <c:if test="${!empty list }">
                <c:forEach items="${list }" var="vo" >
                    <tr class="dataRow" data-no="${vo.no }">
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
             query="&period=${pageObject.period }" />
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