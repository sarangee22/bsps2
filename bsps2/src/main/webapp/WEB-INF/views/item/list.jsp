<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700&display=swap" rel="stylesheet">
<style>
    body { font-family: 'Nanum Gothic', sans-serif; background-color: #f4f7f6; }
    .container { max-width: 1000px; margin: 50px auto; }
    .item-card { transition: 0.3s; cursor: pointer; border-radius: 8px; overflow: hidden; }
    .item-card:hover { transform: translateY(-5px); box-shadow: 0 8px 16px 0 rgba(0,0,0,0.2); }
    .status-ready { color: #2ecc71; font-weight: bold; }
    .status-need { color: #e74c3c; font-weight: bold; }
    .category-tag { padding: 2px 8px; border-radius: 4px; font-size: 0.8em; }
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
    $(function(){
        <c:if test="${!empty msg}">
            alert("${msg}");
            <% session.removeAttribute("msg"); %>
        </c:if>
    });
</script>
</head>
<body>

<div class="w3-container container">
    <div class="w3-panel w3-leftbar w3-border-red w3-pale-red w3-padding-16 w3-margin-bottom">
        <h2 class="w3-opacity"><b>🚨 나의 비상물품 체크리스트</b></h2>
        <p>재난 발생 시 생존을 돕는 필수 물품들을 관리하세요.</p>
    </div>

    <div class="w3-card-4 w3-white w3-round-large">
        <header class="w3-container w3-light-grey w3-padding">
            <div class="w3-right">
                <a href="writeForm.do?perPageNum=${pageObject.perPageNum}" class="w3-button w3-red w3-round-large w3-small">+ 새 물품 추가</a>
            </div>
            <h4 style="margin:5px 0">현재 등록된 물품</h4>
        </header>

        <div class="w3-container w3-padding-16">
            <table class="w3-table w3-bordered w3-hoverable">
                <thead>
                    <tr class="w3-text-grey">
                        <th width="10%">번호</th>
                        <th width="15%">유형</th>
                        <th width="45%">물품명</th>
                        <th width="30%">준비 상태</th>
                    </tr>
                </thead>
                <tbody>
                    <c:if test="${empty list}">
                        <tr><td colspan="4" class="w3-center w3-padding-64">등록된 물품이 없습니다. 첫 물품을 등록해 보세요!</td></tr>
                    </c:if>
                    <c:forEach var="vo" items="${list}">
                        <tr onclick="location='view.do?no=${vo.no}&page=${pageObject.page}&perPageNum=${pageObject.perPageNum}'" style="cursor:pointer">
                            <td>${vo.no}</td>
                            <td>
                                <span class="w3-tag w3-round w3-blue-grey category-tag">${vo.category}</span>
                            </td>
                            <td><b>${vo.name}</b></td>
                            <td>
                                <c:choose>
                                    <c:when test="${vo.isReady == 'Y'}">
                                        <span class="status-ready">● 준비완료</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status-need">○ 준비필요</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <footer class="w3-container w3-white w3-padding-24 w3-center">
            <pageNav:pageNav listURI="list.do" pageObject="${pageObject}" />
        </footer>
    </div>
</div>

</body>
</html>