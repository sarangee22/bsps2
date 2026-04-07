<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재난/안전 정보 사이트 카테고리</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
	<style>
        body { background-color: #f4f7f6; }

        /* 컨테이너 및 제목 섹션 */
        .header-section { padding: 40px 0; text-align: left; }
        .header-section h2 { font-weight: 800; color: #1a237e; letter-spacing: -1px; }

        /* 💡 3열 3행 그리드 설정 */
        .disaster-grid { 
            display: grid; 
            grid-template-columns: repeat(3, 1fr); 
            gap: 30px; 
            margin-top: 20px;
        }

        /* 개별 카테고리 카드 디자인 (가이드 스타일 반영) */
        .disaster-card {
            background: white;
            padding: 40px 30px;
            border-radius: 25px; /* 더 둥근 모서리 */
            text-decoration: none !important;
            color: #333;
            transition: all 0.4s cubic-bezier(0.165, 0.84, 0.44, 1);
            display: flex;
            flex-direction: column;
            align-items: flex-start; /* 왼쪽 정렬 */
            border: 1px solid rgba(0,0,0,0.03);
            box-shadow: 0 10px 20px rgba(0,0,0,0.02);
            position: relative;
            min-height: 220px;
        }

        /* 마우스 호버 효과 */
        .disaster-card:hover { 
            transform: translateY(-12px); 
            box-shadow: 0 25px 50px rgba(0,0,0,0.1); 
            border-color: #5c67f2;
        }

        /* 아이콘 박스 스타일 */
        .icon-box {
            width: 55px; height: 55px;
            background-color: #f0f2ff;
            border-radius: 15px;
            display: flex; align-items: center; justify-content: center;
            margin-bottom: 25px;
            font-size: 24px; color: #5c67f2;
            transition: 0.3s;
        }
        .disaster-card:hover .icon-box {
            background-color: #5c67f2; color: white;
        }

        /* 카테고리 이름 스타일 */
        .disaster-card h3 { 
            font-size: 1.5rem; 
            font-weight: 700; 
            margin-bottom: 12px; 
            color: #2d3436;
        }

        /* 카드 하단 태그 스타일 (가이드의 포인트) */
        .card-tag {
            font-size: 0.8rem;
            color: #5c67f2;
            background: rgba(92, 103, 242, 0.1);
            padding: 4px 12px;
            border-radius: 50px;
            font-weight: 600;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <div class="header-section">
            <h2 class="display-5 fw-bold">재난 정보 카테고리</h2>
            <p class="text-muted">원하는 카테고리를 선택하여 실시간 분석 데이터를 확인하세요.</p>
        </div>
    
        <div class="disaster-grid">
            <c:forEach items="${list}" var="vo">
                <a href="/disasterList/list.do?catID=${vo.catID}" class="disaster-card">
                    <div class="icon-box">
                        <i class="bi 
                            <c:choose>
                                <c:when test='${vo.catID == 1}'>bi-fire</c:when>
                                <c:when test='${vo.catID == 2}'>bi-house-slash</c:when>
                                <c:when test='${vo.catID == 3}'>bi-cloud-lightning-rain</c:when>
                                <c:when test='${vo.catID == 4}'>bi-thermometer-sun</c:when>
                                <c:when test='${vo.catID == 5}'>bi-tree</c:when>
                                <c:when test='${vo.catID == 6}'>bi-car-front-fill</c:when>
                                <c:when test='${vo.catID == 7}'>bi-virus</c:when>
                                <c:when test='${vo.catID == 8}'>bi-hospital</c:when>
                                <c:otherwise>bi-grid-fill</c:otherwise>
                            </c:choose>">
                        </i>
                    </div>
                    <h3>${vo.categoryName}</h3> 
                    <span class="card-tag">#실시간_매시업</span>
                </a>
            </c:forEach>
            
            <c:if test="${empty list}">
                <div style="grid-column: span 3; text-align: center; padding: 100px; color: #999;">
                    현재 표시할 카테고리 정보가 없습니다.
                </div>
            </c:if>
        </div>
    </div>
</body>
</html>