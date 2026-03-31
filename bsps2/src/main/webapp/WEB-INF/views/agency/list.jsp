<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재난 안전 기관 목록</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container">
    <h2 class="mt-4 mb-4">🏢 재난 안전 기관 연락처</h2>

    <div style="margin-bottom: 20px;">
        <form action="list.do" method="get" class="form-inline">
            <div class="input-group">
                <select name="key" class="form-control custom-select" style="width: 140px;">
                    <option value="">전체 유형</option>
                    <%-- value값과 pageObject.key 비교 대상을 일치시켰습니다 --%>
                    <option value="소방" ${pageObject.key == '소방' ? 'selected' : ''}>소방</option>
                    <option value="경찰" ${pageObject.key == '경찰' ? 'selected' : ''}>경찰</option>
                    <option value="병원" ${pageObject.key == '병원' ? 'selected' : ''}>병원/보건소</option>
                    <option value="재난" ${pageObject.key == '재난' ? 'selected' : ''}>재난센터</option>
                    <option value="기타" ${pageObject.key == '기타' ? 'selected' : ''}>기타</option>
                </select>
                
                <input type="text" name="word" class="form-control" placeholder="기관명 검색" 
                       value="${pageObject.word}" style="width: 250px;">
                
                <div class="input-group-append">
                    <button class="btn btn-primary" type="submit">검색</button>
                </div>
            </div>
            <a href="list.do" class="btn btn-light border ml-2 text-secondary" style="font-size: 0.9rem;">초기화</a>
        </form>
    </div>

    <table class="table table-hover text-center">
        <thead class="thead-light">
            <tr>
                <th style="width: 10%">번호</th>
                <th style="width: 50%" class="text-left">기관명</th>
                <th style="width: 15%">유형</th>
                <th style="width: 25%">연락처</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${list}" var="vo">
                <tr onclick="location='view.do?agencyId=${vo.agencyId}'" style="cursor:pointer;">
                    <td>${vo.rnum}</td> 
                    <td class="text-left">${vo.agencyName}</td>
                    
                    <td>
                        <c:choose>
                            <c:when test="${vo.agencyType == '소방' || vo.agencyType == '소방서'}">
                                <span class="badge badge-danger text-white p-2" style="width: 70px;">소방</span>
                            </c:when>
                            <c:when test="${vo.agencyType == '경찰' || vo.agencyType == '경찰서'}">
                                <span class="badge badge-primary text-white p-2" style="width: 70px;">경찰</span>
                            </c:when>
                            <c:when test="${vo.agencyType == '병원' || vo.agencyType == '보건소'}">
                                <span class="badge badge-success text-white p-2" style="width: 70px;">병원</span>
                            </c:when>
                            <c:when test="${vo.agencyType == '재난' || vo.agencyType == '재난센터'}">
                                <span class="badge badge-warning text-dark p-2" style="width: 70px;">재난</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge badge-secondary text-white p-2" style="width: 70px;">${vo.agencyType}</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    
                    <td>${vo.phone}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <div class="d-flex justify-content-between mt-3">
        <div>
            <pageNav:pageNav listURI="list.do" pageObject="${pageObject}" />
        </div>
        <a href="writeForm.do" class="btn btn-primary">새 기관 등록</a>
    </div>
</div>
</body>
</html>