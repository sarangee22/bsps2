<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>질문답변 리스트</title>
<style>
    /* 기본 레이아웃 - 가로 확장 */
    body { font-family: 'Malgun Gothic', sans-serif; margin: 0; padding: 0; background-color: #f4f4f4; }
    
    /* 컨테이너 너비를 1100px로 확장 */
    .container { width: 1100px; margin: 30px auto; border: 1px solid #ccc; background-color: #fff; box-shadow: 0 0 15px rgba(0,0,0,0.1); border-radius: 8px; overflow: hidden; }
    
    :root { --navy-color: #001f3f; }

    /* 헤더 영역 - 로고 제거, 사용자 정보만 우측 유지 */
    header { background-color: var(--navy-color); color: white; padding: 15px 30px; display: flex; justify-content: flex-end; align-items: center; }
    .user-area { font-size: 14px; display: flex; align-items: center; gap: 15px; }
    .logout-btn { background-color: #fff; color: #333; padding: 5px 12px; border-radius: 4px; text-decoration: none; font-size: 12px; font-weight: bold; border: 1px solid #ccc; }

    /* 메인 컨텐츠 영역 */
    main { padding: 40px; min-height: 600px; }
    
    .list-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px; border-bottom: 2px solid var(--navy-color); padding-bottom: 15px; }
    .list-title { font-size: 22px; font-weight: bold; color: #333; }

    /* 검색 영역 */
    .search-area { display: flex; align-items: center; }
    .search-input { padding: 10px; border: 1px solid #ccc; border-radius: 4px 0 0 4px; width: 250px; font-size: 14px; }
    .search-btn { padding: 10px 20px; background-color: #666; color: white; border: none; border-radius: 0 4px 4px 0; cursor: pointer; font-size: 14px; font-weight: bold; }

    /* 테이블 디자인 - 가로 확장 대응 */
    table { width: 100%; border-collapse: collapse; margin-bottom: 30px; table-layout: fixed; }
    th { background-color: #f8f9fa; color: #333; padding: 15px; font-size: 15px; border-top: 2px solid var(--navy-color); border-bottom: 1px solid #ddd; }
    td { padding: 15px; border-bottom: 1px solid #eee; text-align: center; font-size: 14px; color: #555; }
    
    /* 제목 열 스타일 */
    .td-title { text-align: left; padding-left: 20px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; cursor: pointer; color: #333; font-weight: 500; }
    .td-title:hover { text-decoration: underline; color: var(--navy-color); }

    /* 하단 컨트롤 영역 */
    .list-footer { display: flex; justify-content: space-between; align-items: center; margin-top: 30px; }

    /* 표시 개수 선택 (D1) - 버튼 스타일 개선 */
    .page-size-select { display: flex; align-items: center; gap: 8px; font-size: 14px; font-weight: bold; color: #666; }
    .size-btn { padding: 6px 12px; border: 1px solid #ddd; background-color: #fff; cursor: pointer; border-radius: 4px; font-size: 13px; color: #777; transition: 0.2s; }
    .size-btn:hover { background-color: #f0f0f0; }
    .size-btn.active { background-color: var(--navy-color); color: white; border-color: var(--navy-color); }

    /* 페이징 (L4) - 번호 가독성 향상 */
    .pagination { display: flex; gap: 15px; font-size: 15px; align-items: center; }
    .pagination a { text-decoration: none; color: #888; font-weight: bold; padding: 5px; }
    .pagination a.active { color: #ff5252; text-decoration: underline; font-size: 17px; }
    .pagination a:hover:not(.active) { color: var(--navy-color); }

    /* 질문 작성 버튼 (L5) */
    .btn-write { background-color: #eee; color: #333; padding: 12px 25px; border: 1px solid #bbb; border-radius: 4px; font-weight: bold; text-decoration: none; font-size: 14px; transition: 0.2s; }
    .btn-write:hover { background-color: #ddd; border-color: #999; }

    /* 푸터 제거 요청으로 삭제됨 */
</style>
</head>
<body>

<div class="container">
    <header>
        <div class="user-area">
            <span><strong>홍길동</strong>님 환영합니다</span>
            <a href="logout.do" class="logout-btn">로그아웃</a>
        </div>
    </header>

    <main>
        <div class="list-header">
            <div class="list-title">질문답변 리스트</div>
            
            <form action="qnaList.do" method="get" class="search-area">
                <input type="text" name="searchKeyword" class="search-input" placeholder="제목/내용/아이디 검색">
                <button type="submit" class="search-btn">검색</button>
            </form>
        </div>

        <table>
            <colgroup>
                <col style="width: 80px;">
                <col style="width: auto;">
                <col style="width: 150px;">
                <col style="width: 150px;">
                <col style="width: 100px;">
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

        <div class="list-footer">
            <div class="page-size-select">
                <span>표시 개수:</span>
                <button class="size-btn active">10</button>
                <button class="size-btn">15</button>
                <button class="size-btn">20</button>
                <button class="size-btn">25</button>
            </div>

            <div class="pagination">
                <a href="#" class="active">1</a>
                <a href="#">2</a>
                <a href="#">3</a>
                <a href="#">4</a>
                <a href="#">5</a>
                <a href="#">&gt;</a>
            </div>

            <a href="qnaWrite.do" class="btn-write">+ 질문 작성</a>
        </div>
    </main>
</div>

</body>
</html>