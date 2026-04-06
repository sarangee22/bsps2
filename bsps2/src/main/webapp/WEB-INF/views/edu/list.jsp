<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>

<decorator:head>
    <style>
        /* 1. 배경 및 폰트 설정 */
        body { background-color: #f4f7f9; font-family: 'Noto Sans KR', sans-serif; }
        
        /* 2. 컨테이너 여백 (상단바 고정 고려 130px~150px) */
        .edu-list-wrapper { 
            margin-top: 140px; 
            padding-bottom: 80px; 
            max-width: 1200px; 
            margin-left: auto; 
            margin-right: auto; 
        }

        /* 3. 상단 헤더 섹션 */
        .header-section { display: flex; align-items: center; gap: 25px; margin-bottom: 50px; }
        .header-icon { 
            background-color: #1A237E; color: white; padding: 25px; 
            border-radius: 20px; box-shadow: 0 10px 20px rgba(26, 35, 126, 0.2); 
        }
        .header-text h1 { font-weight: 700; color: #1A237E; font-size: 34px; margin-bottom: 8px; }
        .header-text p { color: #6c7a89; font-size: 16px; line-height: 1.6; }

        /* 4. 통계 카드 (메인 페이지 스타일 계승) */
        .stat-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 20px; margin-bottom: 40px; }
        .stat-card { background: white; padding: 25px; border-radius: 20px; box-shadow: 0 4px 12px rgba(0,0,0,0.04); text-align: center; }
        .stat-label { color: #888; font-size: 12px; font-weight: 700; text-transform: uppercase; margin-bottom: 8px; display: block; }
        .stat-value { font-size: 32px; font-weight: 800; color: #1A237E; }

        /* 5. 검색 및 카테고리 필터 */
        .filter-section { display: flex; justify-content: space-between; align-items: center; margin-bottom: 40px; gap: 20px; }
        .search-box { flex: 1; position: relative; }
        .search-input { 
            width: 100%; padding: 15px 20px 15px 50px; border-radius: 15px; border: 1px solid #ddd;
            font-size: 15px; transition: 0.3s;
        }
        .search-input:focus { outline: none; border-color: #1A237E; box-shadow: 0 0 10px rgba(26, 35, 126, 0.1); }
        .search-icon { position: absolute; left: 20px; top: 18px; color: #aaa; }

        .cat-btns { display: flex; gap: 10px; }
        .cat-btn { 
            padding: 10px 20px; border-radius: 12px; background: white; border: 1px solid #ddd;
            font-weight: 600; font-size: 14px; color: #666; transition: 0.3s; text-decoration: none !important;
        }
        .cat-btn.active { background: #1A237E; color: white; border-color: #1A237E; }
        .cat-btn:hover:not(.active) { background: #f8f9fa; }

        /* 6. 교육 가이드 카드 리스트 */
        .guide-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 30px; margin-bottom: 50px; }
        .guide-card { 
            background: white; border-radius: 25px; padding: 35px; border: 1px solid #edf2f7;
            transition: 0.3s; cursor: pointer; display: flex; flex-direction: column;
        }
        .guide-card:hover { transform: translateY(-10px); box-shadow: 0 20px 40px rgba(0,0,0,0.08); }
        
        .card-top { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
        .cat-badge { padding: 5px 12px; border-radius: 8px; font-size: 11px; font-weight: 700; background: #eef2ff; color: #4361ee; }
        
        .guide-card h3 { font-size: 22px; font-weight: 700; color: #1A237E; margin-bottom: 15px; line-height: 1.4; }
        .guide-card p { color: #777; font-size: 14px; line-height: 1.6; margin-bottom: 20px; flex-grow: 1; }

        /* 7. 태그 및 푸터 */
        .tag-list { display: flex; flex-wrap: wrap; gap: 8px; margin-bottom: 25px; }
        .tag { font-size: 11px; color: #1A237E; background: #e8eaf6; padding: 4px 10px; border-radius: 6px; font-weight: 600; }
        
        .card-footer { display: flex; justify-content: space-between; align-items: center; padding-top: 20px; border-top: 1px solid #f1f4f8; font-size: 12px; color: #999; }
    </style>
</decorator:head>

<div class="edu-list-wrapper">

    <div class="header-section">
        <div class="header-icon"><i class="fa fa-book fa-3x"></i></div>
        <div class="header-text">
            <h1>교육 가이드</h1>
            <p>실제 상황에서 바로 활용 가능한 단계별 재난 안전 대처 가이드를 확인하세요.</p>
        </div>
    </div>

    <div class="filter-section">
        <form action="list.do" class="search-box">
            <input type="hidden" name="perPageNum" value="${pageObject.perPageNum}">
            <input type="hidden" name="category" value="${pageObject.key}">
            <i class="fa fa-search search-icon"></i>
            <input type="text" name="word" value="${pageObject.word}" placeholder="가이드 제목, 태그로 검색..." class="search-input">
        </form>
        
        <div class="cat-btns">
            <c:forEach var="cat" items="${['전체', '재난 대비', '안전 점검', '응급 처치']}">
                <a href="list.do?category=${cat}&word=${pageObject.word}&perPageNum=${pageObject.perPageNum}" 
                   class="cat-btn ${(pageObject.key == cat || (empty pageObject.key && cat == '전체')) ? 'active' : ''}">
                    ${cat}
                </a>
            </c:forEach>
        </div>
    </div>

    <div class="guide-grid">
        <c:forEach var="vo" items="${list}">
            <div class="guide-card" onclick="location='view.do?no=${vo.no}&page=${pageObject.page}&perPageNum=${pageObject.perPageNum}'">
                <div class="card-top">
                    <span class="cat-badge">${vo.category}</span>
                    <span style="font-size: 12px; color: #bbb;"><i class="fa fa-eye"></i> ${vo.hit}</span>
                </div>

                <h3>${vo.title}</h3>
                <p>${vo.summary}</p>

                <div class="tag-list">
                    <c:forEach var="tag" items="${vo.tagList}">
                        <span class="tag">#${tag}</span>
                    </c:forEach>
                </div>

                <div class="card-footer">
                    <span><i class="fa fa-user mr-1"></i> ${vo.writer}</span>
                    <span><i class="fa fa-calendar-o mr-1"></i> ${vo.regDate}</span>
                </div>
            </div>
        </c:forEach>
    </div>

    <div style="display: flex; justify-content: center; padding: 40px;">
        <div style="background: white; padding: 15px 30px; border-radius: 30px; shadow: 0 4px 10px rgba(0,0,0,0.05);">
            <pageNav:pageNav listURI="list.do" pageObject="${pageObject}" />
        </div>
    </div>
</div>