<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %> <%-- 페이지네이션 태그 --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재난/안전 정보 사이트 카테고리</title>
	<style>
	    .disaster-container { background-color: #e9ecef; padding: 2rem; border-radius: 15px; }
	    .search-box { margin-bottom: 2rem; display: flex; gap: 10px; }
	    .search-input { flex-grow: 1; border-radius: 20px; border: 1px solid #ddd; padding: 10px 20px; }
	    .search-btn { border-radius: 20px; padding: 10px 30px; background-color: #5c67f2; color: white; border: none; }
	    
	    .disaster-grid { 
	        display: grid; 
	        grid-template-columns: repeat(4, 1fr); 
	        gap: 20px; 
	    }
	    .disaster-card {
	        background: white;
	        padding: 40px 20px;
	        border-radius: 10px;
	        text-decoration: none;
	        color: black;
	        transition: transform 0.2s, shadow 0.2s;
	        text-align: center;
	        display: block;
	    }
	    .disaster-card:hover { transform: translateY(-5px); box-shadow: 0 10px 20px rgba(0,0,0,0.1); color: black; }
	    .disaster-card h3 { font-size: 1.5rem; font-weight: bold; margin-bottom: 30px; }
	    .disaster-card p { color: #666; font-size: 0.9rem; }
	    
	    /* 스토리보드의 D1 강조용 (첫 번째 카드만 테두리) */
	    .disaster-card.featured { border: 4px solid #a855f7; }
	</style>
</head>
<body>
	<div class="container mt-5">
	    <h2 class="display-5 fw-bold mb-4">재난 데이터 목록</h2>
	
	    <form action="list.do" method="get" class="search-box">
	        <input type="text" name="word" class="search-input" placeholder="검색어를 입력하세요 (100자 이내)" value="${pageObject.word}">
	        <button type="submit" class="search-btn">검색하기</button>
	    </form>
	
	    <div class="disaster-container">
	        <div class="disaster-grid">
	            <%-- Controller에서 넘겨준 list를 반복 --%>
	            <c:forEach items="${list}" var="vo" varStatus="vs">
	                <a href="/disasterList/list.do?catID=${vo.catID}" 
	                   class="disaster-card ${vs.first ? 'featured' : ''}">
	                    <h3>${vo.categoryName}</h3> <%-- D3: 제목 --%>
	                    <p>${vo.createDate}</p>      <%-- D5: 작성일(날짜) --%>
	                    <%-- 조회수가 필요하다면: <p>조회수: ${vo.no}</p> --%>
	                </a>
	            </c:forEach>
	            
	            <%-- 데이터가 없을 경우 처리 --%>
	            <c:if test="${empty list}">
	                <div style="grid-column: span 4; text-align: center; padding: 50px;">
	                    검색 결과가 없습니다.
	                </div>
	            </c:if>
	        </div>
	    </div>
	
	<div>
		<pageNav:pageNav listURI="list.do" pageObject="${pageObject }" />
	</div>
	</div>
</body>
</html>