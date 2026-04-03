<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재난안전 정보 사이트 - QnA 리스트</title>
<style>
    body { font-family: 'Malgun Gothic', sans-serif; margin: 0; padding: 0; background-color: #f4f4f4; }
    .container { width: 1100px; margin: 30px auto; border: 1px solid #ccc; background-color: #fff; box-shadow: 0 0 15px rgba(0,0,0,0.1); border-radius: 8px; overflow: hidden; }
    :root { --navy-color: #001f3f; }
    header { background-color: var(--navy-color); color: white; padding: 15px 30px; min-height: 20px; }
    main { padding: 40px; min-height: 600px; }
    .list-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px; border-bottom: 2px solid var(--navy-color); padding-bottom: 15px; }
    .list-title { font-size: 22px; font-weight: bold; color: #333; }
    .search-area { display: flex; align-items: center; }
    .search-input { padding: 10px; border: 1px solid #ccc; border-radius: 4px 0 0 4px; width: 250px; font-size: 14px; }
    .search-btn { padding: 10px 20px; background-color: #444; color: white; border: none; border-radius: 0 4px 4px 0; cursor: pointer; font-size: 14px; font-weight: bold; }
    .search-btn:hover { background-color: #000; }
    
    table { width: 100%; border-collapse: collapse; margin-bottom: 30px; table-layout: fixed; }
    th { background-color: #f8f9fa; color: #333; padding: 15px; font-size: 15px; border-top: 2px solid var(--navy-color); border-bottom: 1px solid #ddd; }
    td { padding: 15px; border-bottom: 1px solid #eee; text-align: center; font-size: 14px; color: #555; }
    
    /* 제목 열 스타일 */
    .td-title { text-align: left; padding-left: 20px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; cursor: pointer; color: #333; }
    .td-title:hover { text-decoration: underline; color: var(--navy-color); background-color: #fcfcfc; }
    .reply-icon { color: #999; margin-right: 5px; font-weight: bold; }

    .list-footer { display: flex; justify-content: space-between; align-items: center; margin-top: 30px; }
    .pagination { display: flex; gap: 8px; font-size: 15px; align-items: center; }
    .pagination a { text-decoration: none; color: #666; padding: 6px 12px; border: 1px solid #ddd; border-radius: 4px; background-color: #fff; }
    .pagination a:hover { background-color: #f0f0f0; border-color: #bbb; }
    .pagination .active { background-color: #001f3f; color: white; border-color: #001f3f; font-weight: bold; pointer-events: none; }

    .btn-write { background-color: #fff; color: #333; padding: 10px 25px; border: 1px solid #333; border-radius: 4px; font-weight: bold; text-decoration: none; font-size: 14px; transition: 0.2s; }
    .btn-write:hover { background-color: #333; color: #fff; }
</style>
</head>
<body>

<div class="container">
    <header>
        <div class="user-area"></div>
    </header>

    <main>
        <div class="list-header">
            <div class="list-title">질문답변 리스트</div>

            <form action="${pageContext.request.contextPath}/qna/list.do" method="get" class="search-area">
                <input type="hidden" name="page" value="1"> 
                <input type="text" name="searchKeyword" class="search-input" value="${param.searchKeyword}" placeholder="제목/내용/아이디 검색">
                <button type="submit" class="search-btn">검색</button>
            </form>
        </div>

        <table>
            <thead>
                <tr>
                    <th style="width: 80px;">번호</th>
                    <th>제목</th>
                    <th style="width: 150px;">작성자</th>
                    <th style="width: 150px;">작성일</th>
                    <th style="width: 100px;">조회수</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${list}" var="vo">
                    <tr>
                        <td>${vo.no}</td>
                        <td class="td-title" onclick="location.href='${pageContext.request.contextPath}/qna/view.do?no=${vo.no}&inc=1'">
                            <c:forEach begin="1" end="${vo.levNo}">
                                &nbsp;&nbsp;&nbsp;&nbsp;
                            </c:forEach>
                            
                            <c:if test="${vo.levNo > 0}">
                                <span class="reply-icon">ㄴ</span>
                            </c:if>
                            
                            ${vo.title}
                        </td>
                        <td>${vo.id}</td>
                        <td>${vo.writeDate}</td>
                        <td>${vo.hit}</td>
                    </tr>
                </c:forEach>
                <c:if test="${empty list}">
                    <tr>
                        <td colspan="5" style="padding: 100px;">등록된 질문이 없습니다.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>

        <div class="list-footer">
            <div></div> <div class="pagination">
                <c:forEach var="i" begin="1" end="5">
                    <a href="${pageContext.request.contextPath}/qna/list.do?page=${i}&searchKeyword=${param.searchKeyword}"
                        class="${(param.page == i || (empty param.page && i == 1)) ? 'active' : ''}">${i}</a>
                </c:forEach>
                <c:set var="curPage" value="${empty param.page ? 1 : param.page}" />
                <a href="${pageContext.request.contextPath}/qna/list.do?page=${curPage + 1}&searchKeyword=${param.searchKeyword}">&gt;</a>
            </div>

            <a href="${pageContext.request.contextPath}/qna/questionForm.do" class="btn-write">질문 작성</a>
        </div>
    </main>
</div>

</body>
</html>