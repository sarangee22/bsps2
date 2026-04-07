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
                    <th style="width: 100px;">등급</th> <th>지역</th>
                    <th>재난 내용</th>
                    <th style="width: 18%">발송일시</th>
                </tr>
            </thead>
            <tbody>
			    <c:forEach items="${list}" var="vo">
			        <tr onclick="location='view.do?no=${vo.no}&inc=1&catID=${param.catID}&page=${pageObject.page}&perPageNum=${pageObject.perPageNum}'" style="cursor:pointer;">
			            <td>${vo.no}</td>
			            
			            <td>
			                <span class="badge" 
			                      style="
			                        display: inline-block;
			                        width: 60px;
			                        color: white !important; 
			                        padding: 5px 0;
			                        font-weight: bold;
			                        border-radius: 4px;
			                        background-color: ${vo.dangerLevel == 3 ? '#dc3545' : (vo.dangerLevel == 2 ? '#ffc107' : (vo.dangerLevel == 1 ? '#28a745' : '#17a2b8'))} !important;
			                      ">
			                    ${vo.dangerLevel == 3 ? '위험' : (vo.dangerLevel == 2 ? '주의' : (vo.dangerLevel == 1 ? '보통' : '정보'))}
			                </span>
			                
			                
			            </td>
			
			            <td class="text-left">
			                <span class="badge badge-info mr-2"
			                		style="
					            background-color: rgba(23, 162, 184, 0.1) !important; /* 연한 하늘색 배경 */
					            color: #222 !important;                              /* 진한 검정색 글자 */
					            border: 1px solid #17a2b8 !important;                /* 하늘색 테두리 */
					            padding: 5px 10px;
					            font-weight: 600;
					            font-size: 0.9em;
					          ">${vo.locationName}</span>
			            </td>
			            <td class="text-left text-truncate" style="max-width: 400px;">
			                ${vo.content}
			            </td>
			            <td>${vo.createDate}</td>
			        </tr>
			    </c:forEach>
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