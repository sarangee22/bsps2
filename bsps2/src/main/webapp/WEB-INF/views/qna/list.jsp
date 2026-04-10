<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>질문답변 리스트</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
<style>
    body { font-family: 'Noto Sans KR', sans-serif; margin: 0; padding: 0; background-color: #f4f7f9; color: #2c3e50; }
    .container { width: 1100px; margin: 50px auto; background-color: #fff; border-radius: 16px; box-shadow: 0 10px 30px rgba(0,0,0,0.05); overflow: hidden; }
    :root { --main-navy: #1a2a4e; --accent-blue: #3498db; --border-light: #eff2f5; }
    main { padding: 50px; min-height: 600px; }
    .list-header { display: flex; justify-content: space-between; align-items: flex-end; margin-bottom: 35px; }
    .title-group .list-title { font-size: 28px; font-weight: 700; color: var(--main-navy); margin: 0; display: flex; align-items: center; gap: 12px; }
    .title-group .list-title::before { content: '📋'; font-size: 24px; }
    .title-group .sub-text { font-size: 14px; color: #7f8c8d; margin-top: 8px; margin-left: 36px; }
    .search-area { display: flex; align-items: center; background-color: #f8f9fa; border: 1px solid #e1e4e8; border-radius: 10px; padding: 4px 12px; transition: 0.3s; }
    .search-area:focus-within { border-color: var(--accent-blue); background-color: #fff; box-shadow: 0 0 8px rgba(52, 152, 219, 0.1); }
    .search-input { padding: 10px; border: none; background: none; width: 200px; font-size: 14px; outline: none; }
    .search-btn { background: none; border: none; cursor: pointer; font-size: 16px; color: #95a5a6; padding: 5px; }
    table { width: 100%; border-collapse: collapse; margin-bottom: 40px; }
    th { color: #94a3b8; padding: 20px 15px; font-size: 13px; font-weight: 500; text-transform: uppercase; letter-spacing: 1px; border-bottom: 2px solid var(--border-light); text-align: center; }
    td { padding: 20px 15px; border-bottom: 1px solid var(--border-light); text-align: center; font-size: 15px; }
    .td-title { text-align: left; padding-left: 30px; font-weight: 600; cursor: pointer; color: var(--main-navy); transition: 0.2s; }
    .td-title:hover { color: var(--accent-blue); background-color: #fcfdfe; }
    .reply-icon { color: #cbd5e1; margin-right: 8px; }
    .badge { padding: 5px 12px; border-radius: 6px; font-size: 12px; font-weight: 700; display: inline-block; }
    .bg-high { background-color: #fff1f2; color: #f43f5e; }
    .bg-mid { background-color: #fefce8; color: #ca8a04; }
    .bg-low { background-color: #f0f9ff; color: #0ea5e9; }
    .list-footer { display: flex; justify-content: center; align-items: center; margin-top: 40px; position: relative; }
    .pagination { display: flex; gap: 10px; }
    .pagination a { text-decoration: none; color: #64748b; padding: 8px 16px; border: 1px solid #e2e8f0; border-radius: 8px; background-color: #fff; transition: 0.2s; font-weight: 500; }
    .pagination a:hover { background-color: #f8fafc; border-color: #cbd5e1; }
    .pagination .active { background-color: var(--main-navy); color: white; border-color: var(--main-navy); box-shadow: 0 4px 10px rgba(26, 42, 78, 0.2); }
    .btn-write { position: absolute; right: 0; background-color: var(--main-navy); color: white; padding: 12px 24px; border: none; border-radius: 10px; font-weight: 700; text-decoration: none; font-size: 14px; box-shadow: 0 4px 12px rgba(26, 42, 78, 0.15); transition: 0.3s; }
    .btn-write:hover { transform: translateY(-2px); box-shadow: 0 6px 15px rgba(26, 42, 78, 0.25); background-color: #233966; }
</style>
</head>
<body>

<div class="container">
    <main>
        <div class="list-header">
            <div class="title-group">
                <h1 class="list-title">질문답변 리스트</h1>
                <p class="sub-text">재난 대비 및 사이트 이용에 관한 궁금한 점을 남겨주세요.</p>
            </div>
            <form action="${pageContext.request.contextPath}/qna/list.do" method="get" class="search-area">
                <input type="hidden" name="page" value="1"> 
                <input type="text" name="searchKeyword" class="search-input" value="${param.searchKeyword}" placeholder="검색어를 입력하세요">
                <button type="submit" class="search-btn">🔍</button>
            </form>
        </div>

        <table>
            <thead>
                <tr>
                    <th style="width: 80px;">번호</th>
                    <th>제목</th>
                    <th style="width: 140px;">작성자</th>
                    <th style="width: 140px;">작성일</th>
                    <th style="width: 100px;">조회수</th>
                    <th style="width: 120px;">구분</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${list}" var="vo">
                    <tr>
                        <td style="color: #94a3b8; font-size: 13px;">${vo.no}</td>
                        <td class="td-title" onclick="location.href='${pageContext.request.contextPath}/qna/view.do?no=${vo.no}&inc=1'">
                            <c:forEach begin="1" end="${vo.levNo}">
                                &nbsp;&nbsp;&nbsp;
                            </c:forEach>
                            <c:if test="${vo.levNo > 0}">
                                <span class="reply-icon">↳</span>
                            </c:if>
                            ${vo.title}
                        </td>
                        <td style="font-weight: 500;">${vo.id}</td>
                        <td style="color: #64748b; font-size: 14px;">${vo.writeDate}</td>
                        <td>${vo.hit}</td>
                        <td>
                            <c:choose>
                                <c:when test="${vo.id == 'admin'}">
                                    <span class="badge bg-high">공지사항</span>
                                </c:when>
                                <c:when test="${vo.hit > 50}">
                                    <span class="badge bg-mid">인기글</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-low">일반문의</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty list}">
                    <tr>
                        <td colspan="6" style="padding: 120px 0; color: #cbd5e1; font-size: 16px;">등록된 질문이 없습니다.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>

        <div class="list-footer">
            <div class="pagination">
						<c:set var="curPage" value="${empty curPage ? 1 : curPage}" />
						<c:forEach var="i" begin="1" end="${totalPage}">
							<a href="${pageContext.request.contextPath}/qna/list.do?page=${i}&searchKeyword=${param.searchKeyword}"
								class="${curPage == i ? 'active' : ''}">${i}</a>
						</c:forEach>
						<c:if test="${curPage < totalPage}">
							<a
								href="${pageContext.request.contextPath}/qna/list.do?page=${curPage + 1}&searchKeyword=${param.searchKeyword}">&gt;</a>
						</c:if></div>
            <c:if test="${!empty login}">
                <a href="${pageContext.request.contextPath}/qna/questionForm.do" class="btn-write">
                    <c:choose>
                        <c:when test="${login.id == 'admin'}">공지사항 등록</c:when>
                        <c:otherwise>새 질문 등록</c:otherwise>
                    </c:choose>
                </a>
            </c:if>
        </div>
    </main>
</div>

</body>
</html>