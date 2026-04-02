<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>질문답변 리스트..</title>
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
    .search-btn { padding: 10px 20px; background-color: #666; color: white; border: none; border-radius: 0 4px 4px 0; cursor: pointer; font-size: 14px; font-weight: bold; }
    table { width: 100%; border-collapse: collapse; margin-bottom: 30px; table-layout: fixed; }
    th { background-color: #f8f9fa; color: #333; padding: 15px; font-size: 15px; border-top: 2px solid var(--navy-color); border-bottom: 1px solid #ddd; }
    td { padding: 15px; border-bottom: 1px solid #eee; text-align: center; font-size: 14px; color: #555; }
    .td-title { text-align: left; padding-left: 20px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; cursor: pointer; color: #333; font-weight: 500; }
    .td-title:hover { text-decoration: underline; color: var(--navy-color); }

    .list-footer { display: flex; justify-content: space-between; align-items: center; margin-top: 30px; }
    .pagination { display: flex; gap: 8px; font-size: 15px; align-items: center; }
    .pagination a { 
        text-decoration: none; color: #666; padding: 6px 12px; border: 1px solid #ddd; border-radius: 4px; background-color: #fff;
    }
    .pagination a:hover { background-color: #f0f0f0; border-color: #bbb; }
    .pagination .active { 
        background-color: #ff5252; color: white; border-color: #ff5252; font-weight: bold; pointer-events: none;
    }

    .btn-write { background-color: #eee; color: #333; padding: 12px 25px; border: 1px solid #bbb; border-radius: 4px; font-weight: bold; text-decoration: none; font-size: 14px; }
</style>
</head>
<body>

<div class="container">
    <header><div class="user-area"></div></header>

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
                    <th style="width: 100px;">답변</th>
                </tr>
            </thead>
            <tbody>
                <tr><td>1</td><td class="td-title" onclick="location.href='${pageContext.request.contextPath}/qna/view.do?no=3&inc=1'">지진 발생 시 행동요령이 궁금합니다</td><td>hong123</td><td>2025-03-10</td><td>1</td></tr>
                <tr><td>2</td><td class="td-title" onclick="location.href='${pageContext.request.contextPath}/qna/view.do?no=10&inc=1'">재난 대피 가방 꼭 싸야 하나요?</td><td>yang77</td><td>2026-04-02</td><td>1</td></tr>
                <tr><td>3</td><td class="td-title" onclick="location.href='${pageContext.request.contextPath}/qna/view.do?no=9&inc=1'">민방위 훈련 일정 확인하는 법</td><td>army88</td><td>2026-04-01</td><td>0</td></tr>
                <tr><td>4</td><td class="td-title" onclick="location.href='${pageContext.request.contextPath}/qna/view.do?no=8&inc=1'">아파트 화재 시 엘리베이터 타면 안 되는 이유</td><td>fire_stop</td><td>2026-03-30</td><td>2</td></tr>
                <tr><td>5</td><td class="td-title" onclick="location.href='${pageContext.request.contextPath}/qna/view.do?no=7&inc=1'">우리 동네 대피소 위치는 어디서 보나요?</td><td>map_lover</td><td>2025-03-25</td><td>1</td></tr>
                <tr><td>6</td><td class="td-title" onclick="location.href='${pageContext.request.contextPath}/qna/view.do?no=6&inc=1'">심폐소생술(CPR) 교육 신청하고 싶습니다</td><td>health_1</td><td>2025-03-20</td><td>0</td></tr>
                <tr><td>7</td><td class="td-title" onclick="location.href='${pageContext.request.contextPath}/qna/view.do?no=5&inc=1'">소화기 유통기한 확인 방법 알려주세요</td><td>safety_first</td><td>2025-03-15</td><td>1</td></tr>
                <tr><td>8</td><td class="td-title" onclick="location.href='${pageContext.request.contextPath}/qna/view.do?no=4&inc=1'">홍수 발생 시 차량 관리 요령</td><td>car_master</td><td>2025-03-12</td><td>0</td></tr>
                <tr><td>9</td><td class="td-title" onclick="location.href='${pageContext.request.contextPath}/qna/view.do?no=3&inc=1'">지진 발생 시 행동요령이 궁금합니다</td><td>hong123</td><td>2025-03-10</td><td>1</td></tr>
                <tr><td>10</td><td class="td-title" onclick="location.href='${pageContext.request.contextPath}/qna/view.do?no=2&inc=1'">비상식량 보관 기간이 얼마나 되나요?</td><td>kim456</td><td>2025-03-08</td><td>0</td></tr>
                <tr><td>11</td><td class="td-title" onclick="location.href='${pageContext.request.contextPath}/qna/view.do?no=1&inc=1'">화재 대피 시 주의사항 알려주세요</td><td>lee789</td><td>2025-03-05</td><td>0</td></tr>
            </tbody>
        </table>

        <div class="list-footer">
            <div></div>
            
            <div class="pagination">
                <c:forEach var="i" begin="1" end="5">
                    <a href="${pageContext.request.contextPath}/qna/list.do?page=${i}&searchKeyword=${param.searchKeyword}" 
                       class="${(param.page == i || (empty param.page && i == 1)) ? 'active' : ''}">${i}</a>
                </c:forEach>
                
                <c:set var="curPage" value="${empty param.page ? 1 : param.page}" />
                <a href="${pageContext.request.contextPath}/qna/list.do?page=${curPage + 1}&searchKeyword=${param.searchKeyword}">&gt;</a>
            </div>

            <a href="${pageContext.request.contextPath}/qna/writeForm.do" class="btn-write">질문 작성</a>
        </div>
    </main>
</div>

</body>
</html>