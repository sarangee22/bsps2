<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA 리스트</title>
<style>
    /* 기본 스타일 유지 */
    body { font-family: 'Malgun Gothic', sans-serif; margin: 0; padding: 0; background-color: #f4f4f4; }
    .container { width: 1000px; margin: 50px auto; border: 1px solid #ccc; background-color: #fff; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
    
    :root { --navy-color: #001f3f; }

    /* 헤더 */
    header { background-color: var(--navy-color); color: white; padding: 15px 20px; display: flex; justify-content: space-between; align-items: center; }
    .logout-btn { background-color: #eee; color: #333; padding: 5px 15px; border-radius: 4px; text-decoration: none; font-size: 12px; border: 1px solid #ccc; }

    /* 메인 영역 */
    main { padding: 30px; min-height: 600px; }
    
    .list-header { display: flex; justify-content: space-between; align-items: flex-end; margin-bottom: 20px; border-bottom: 2px solid var(--navy-color); padding-bottom: 10px; }
    .list-title { font-size: 20px; font-weight: bold; color: #333; }

    /* 검색 영역 (D1, L2) */
    .search-area { display: flex; align-items: center; }
    .search-input { padding: 8px; border: 1px solid #ccc; border-radius: 4px 0 0 4px; width: 200px; font-size: 13px; }
    .search-btn { padding: 8px 15px; background-color: #888; color: white; border: none; border-radius: 0 4px 4px 0; cursor: pointer; font-size: 13px; }

    /* 테이블 스타일 (D2 ~ D6) */
    table { width: 100%; border-collapse: collapse; margin-bottom: 20px; table-layout: fixed; }
    th { background-color: #444; color: white; padding: 12px; font-size: 14px; border: 1px solid #ddd; }
    td { padding: 12px; border: 1px solid #ddd; text-align: center; font-size: 14px; }
    
    /* 제목 열 스타일 (말줄임표 처리 D3) */
    .td-title { text-align: left; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; cursor: pointer; color: #333; }
    .td-title:hover { text-decoration: underline; color: var(--navy-color); }

    /* 하단 컨트롤 영역 */
    .list-footer { display: flex; justify-content: space-between; align-items: center; margin-top: 20px; }

    /* 표시 개수 선택 (D1) */
    .page-size-select { display: flex; align-items: center; gap: 5px; font-size: 13px; }
    .size-btn { padding: 5px 10px; border: 1px solid #ccc; background-color: #eee; cursor: pointer; border-radius: 3px; font-size: 12px; }
    .size-btn.active { background-color: var(--navy-color); color: white; border-color: var(--navy-color); }

    /* 페이징 (L4) */
    .pagination { display: flex; gap: 10px; font-size: 14px; align-items: center; }
    .pagination a { text-decoration: none; color: #666; font-weight: bold; }
    .pagination a.active { color: #ff5252; text-decoration: underline; }

    /* 질문 작성 버튼 (L5) */
    .btn-write { background-color: #ccc; color: #333; padding: 10px 20px; border: 1px solid #999; border-radius: 4px; font-weight: bold; text-decoration: none; font-size: 13px; }
    .btn-write:hover { background-color: #bbb; }

    /* 푸터 */
    footer { background-color: #eee; text-align: center; padding: 20px; font-size: 12px; border-top: 1px solid #ccc; color: #888; }
</style>
</head>
<body>

<div class="container">
    <header>
        <div class="logo">재난/안전 정보 사이트</div>
        <div class="user-area">
            <span>홍길동님 &nbsp;</span>
            <a href="logout.do" class="logout-btn">로그아웃</a>
        </div>
    </header>

    <main>
        <div class="list-header">
            <div class="list-title">질문답변 리스트</div>
            
            <!-- 검색 창 (L2) -->
            <form action="qnaList.do" method="get" class="search-area">
                <input type="text" name="searchKeyword" class="search-input" placeholder="제목/내용/아이디 검색">
                <button type="submit" class="search-btn">검색</button>
            </form>
        </div>

        <!-- 게시판 테이블 -->
        <table>
            <colgroup>
                <col style="width: 10%;">
                <col style="width: 50%;">
                <col style="width: 15%;">
                <col style="width: 15%;">
                <col style="width: 10%;">
            </colgroup>
            <thead>
                <tr>
                    <th>번호</th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>작성일</th>
                    <th>답변</th>
                </tr>
            </thead>
            <tbody>
                <!-- 데이터 행 예시 (D2~D6) -->
                <tr>
                    <td>3</td>
                    <td class="td-title" onclick="location.href='qnaView.do?no=3'">지진 발생 시 행동요령이 궁금합니다</td>
                    <td>hong123</td>
                    <td>2025-03-10</td>
                    <td>1</td>
                </tr>
                <tr>
                    <td>2</td>
                    <td class="td-title" onclick="location.href='qnaView.do?no=2'">비상식량 보관 기간이 얼마나 되나요?</td>
                    <td>kim456</td>
                    <td>2025-03-08</td>
                    <td>0</td>
                </tr>
                <tr>
                    <td>1</td>
                    <td class="td-title" onclick="location.href='qnaView.do?no=1'">화재 대피 시 주의사항 알려주세요</td>
                    <td>lee789</td>
                    <td>2025-03-05</td>
                    <td>0</td>
                </tr>
            </tbody>
        </table>

        <!-- 하단 컨트롤 영역 -->
        <div class="list-footer">
            <!-- 표시 개수 (D1) -->
            <div class="page-size-select">
                <span>표시 개수:</span>
                <button class="size-btn active">10</button>
                <button class="size-btn">15</button>
                <button class="size-btn">20</button>
                <button class="size-btn">25</button>
            </div>

            <!-- 페이징 (L3, L4) -->
            <div class="pagination">
                <a href="#" class="active">1</a>
                <a href="#">2</a>
                <a href="#">3</a>
                <a href="#">4</a>
                <a href="#">5</a>
                <a href="#">&gt;</a>
            </div>

            <!-- 질문 작성 (L5) -->
            <a href="qnaWrite.do" class="btn-write">+ 질문 작성</a>
        </div>
    </main>

    <footer>푸터</footer>
</div>

</body>
</html>