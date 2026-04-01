<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재난/안전 정보 사이트 카테고리</title>
    <style>
        /* 컨테이너 배경 및 패딩 */
        .disaster-container { 
            background-color: #e9ecef; 
            padding: 3rem; 
            border-radius: 20px; 
            margin-top: 20px;
        }
        
        /* 4열 그리드 설정 */
        .disaster-grid { 
            display: grid; 
            grid-template-columns: repeat(4, 1fr); 
            gap: 25px; 
        }

        /* 개별 카테고리 카드 디자인 */
        .disaster-card {
            background: white;
            padding: 50px 20px;
            border-radius: 15px;
            text-decoration: none;
            color: #333;
            transition: all 0.3s ease;
            text-align: center;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            border: 1px solid transparent;
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
        }

        /* 마우스 호버 효과 (보라색 테두리 대신 그림자와 위치 이동) */
        .disaster-card:hover { 
            transform: translateY(-8px); 
            box-shadow: 0 15px 30px rgba(0,0,0,0.1); 
            color: #5c67f2;
            border-color: #5c67f2;
        }

        /* 카테고리 이름 스타일 */
        .disaster-card h3 { 
            font-size: 1.4rem; 
            font-weight: 800; 
            margin-bottom: 15px; 
            word-break: keep-all; /* 단어 끊김 방지 */
        }

        /* 하단 안내 텍스트 */
        .disaster-card p { 
            color: #888; 
            font-size: 0.9rem; 
            margin: 0;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <h2 class="display-5 fw-bold mb-5">재난 카테고리 선택</h2>
    
        <div class="disaster-container">
            <div class="disaster-grid">
                <%-- Controller에서 넘겨준 list(카테고리 8개)를 반복문으로 출력 --%>
                <c:forEach items="${list}" var="vo">
                    <%-- 💡 모든 카드의 클래스를 'disaster-card'로 통일 (특정 강조 제거) --%>
                    <a href="/disasterList/list.do?catID=${vo.catID}" class="disaster-card">
                        <h3>${vo.categoryName}</h3> 
                    </a>
                </c:forEach>
                
                <%-- 데이터가 없을 경우 처리 --%>
                <c:if test="${empty list}">
                    <div style="grid-column: span 4; text-align: center; padding: 100px; color: #999;">
                        현재 표시할 카테고리 정보가 없습니다.
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</body>
</html>