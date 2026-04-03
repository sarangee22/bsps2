<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>

<div class="container mt-5">
    <div class="mb-4">
        <h2 class="fw-bold"><i class="bi bi-exclamation-triangle-fill text-danger"></i> ${(empty headTitle) ? "재난" : headTitle} 상세 정보 목록</h2>
        <p class="text-muted">선택하신 카테고리의 실시간 재난 문자 현황입니다.</p>
    </div>

    <div class="card mb-4 shadow-sm">
        <div class="card-body bg-light">
            <form action="list.do" method="get" id="searchForm">
                <input type="hidden" name="catID" value="${param.catID}">
                <div class="row g-2">
                    <div class="col-md-3">
                        <select name="key" class="form-select">
                            <option value="t" ${ (pageObject.key == 't') ? "selected" : "" }>내용</option>
                            <option value="l" ${ (pageObject.key == 'l') ? "selected" : "" }>지역</option>
                            <option value="tl" ${ (pageObject.key == 'tl') ? "selected" : "" }>내용+지역</option>
                        </select>
                    </div>
                    <div class="col-md-7">
                        <input type="text" name="word" class="form-control" placeholder="검색어를 입력하세요" value="${pageObject.word}">
                    </div>
                    <div class="col-md-2">
                        <button class="btn btn-dark w-100">검색</button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <div class="table-responsive">
        <table class="table table-hover align-middle border-top">
            <thead class="table-light">
                <tr class="text-center">
                    <th style="width: 8%">번호</th>
                    <th style="width: 12%">지역</th>
                    <th>재난 내용</th>
                    <th style="width: 18%">발송일시</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${list}" var="vo">
                    <tr class="text-center">
                        <td class="text-muted">${vo.no}</td>
                        <td>
                            <span class="badge rounded-pill bg-info text-dark">${vo.locationName}</span>
                        </td>
                        <td class="text-start">
                            <a href="view.do?no=${vo.no}&inc=1" class="text-decoration-none text-dark fw-semibold">
                                ${vo.content}
                            </a>
                        </td>
                        <td class="text-muted">${vo.createDate}</td>
                    </tr>
                </c:forEach>
                
                <c:if test="${empty list}">
                    <tr>
                        <td colspan="4" class="text-center py-5">
                            <i class="bi bi-search d-block fs-1 text-secondary mb-3"></i>
                            <span class="text-muted">검색 결과가 없거나 등록된 정보가 없습니다.</span>
                        </td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>

    <div class="d-flex justify-content-between align-items-center mt-4">
        <a href="/disasterCategory/list.do" class="btn btn-outline-dark">
            <i class="bi bi-arrow-left"></i> 카테고리 목록
        </a>
	 	<div>
			<pageNav:pageNav listURI="list.do" pageObject="${pageObject }" query="&catID=${param.catID}"/>
		</div>
	   </div>
</div>