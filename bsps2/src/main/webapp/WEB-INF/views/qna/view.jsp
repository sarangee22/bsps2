<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA 상세보기</title>
<style>
    /* 기본 레이아웃 유지 */
    body { font-family: 'Malgun Gothic', sans-serif; margin: 0; padding: 0; background-color: #f4f4f4; }
    .container { width: 900px; margin: 50px auto; border: 1px solid #ccc; background-color: #fff; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
    
    :root { --navy-color: #001f3f; }

    header { background-color: var(--navy-color); color: white; padding: 15px 20px; display: flex; justify-content: space-between; align-items: center; }
    .logout-btn { background-color: #eee; color: #333; padding: 5px 15px; border-radius: 4px; text-decoration: none; font-size: 12px; border: 1px solid #ccc; }

    main { padding: 30px; min-height: 600px; }

    /* 질문/답변 카드 스타일 */
    .view-card { border: 1px solid #ddd; border-radius: 8px; margin-bottom: 30px; background-color: #fff; overflow: hidden; }
    .card-label { background-color: #f8f9fa; padding: 10px 20px; font-size: 13px; font-weight: bold; border-bottom: 1px solid #eee; color: #666; }
    
    .card-content { padding: 20px; }
    .content-title { font-size: 18px; font-weight: bold; margin-bottom: 15px; color: #333; }
    
    /* 본문 영역 (D2, D5: 줄바꿈/공백처리) */
    .content-text { 
        background-color: #f1f1f1; 
        padding: 20px; 
        border-radius: 5px; 
        min-height: 100px; 
        font-size: 14px; 
        line-height: 1.6; 
        white-space: pre-wrap; /* 줄바꿈 및 공백 유지 */
        margin-bottom: 15px;
    }

    /* 정보 영역 (D3, D6) */
    .info-bar { display: flex; justify-content: space-between; align-items: center; font-size: 13px; color: #777; padding-top: 10px; }
    .info-text span { margin-right: 15px; }

    /* 버튼 스타일 */
    .btn-group { display: flex; gap: 5px; }
    .btn { padding: 6px 15px; border-radius: 4px; font-size: 12px; cursor: pointer; border: 1px solid #ccc; text-decoration: none; color: #333; background-color: #eee; }
    .btn:hover { background-color: #ddd; }
    
    /* 목록 버튼 (L5) */
    .list-btn-area { margin-top: 20px; }
    .btn-list { background-color: #bbb; color: #000; padding: 10px 25px; font-weight: bold; }

    /* 답변하기 버튼 (L4) */
    .btn-reply { background-color: var(--navy-color); color: white; border: none; }

    footer { background-color: #eee; text-align: center; padding: 20px; font-size: 12px; border-top: 1px solid #ccc; }
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
        <!-- [질문] 카드 영역 (D1~D3) -->
        <div class="view-card">
            <div class="card-label">[질문]</div>
            <div class="card-content">
                <div class="content-title">지진 발생 시 행동요령이 궁금합니다</div>
                <div class="content-text">질물 내용이 여기에 표시됩니다. (줄바꿈과 공백이 그대로 유지됩니다.)</div>
                
                <div class="info-bar">
                    <div class="info-text">
                        <span>작성자: hong123 | 홍길동</span>
                        <span>작성일: 2025-03-10</span>
                        <span>조회수: 12</span>
                    </div>
                    <!-- L2, L3: 본인일 때만 노출되는 버튼군 -->
                    <div class="btn-group">
                        <a href="qnaEdit.do?no=3" class="btn">수정</a>
                        <a href="javascript:void(0);" onclick="if(confirm('삭제하시겠습니까?')) location.href='delete.do?no=3';" class="btn">삭제</a>
                    </div>
                </div>
            </div>
        </div>

        <!-- [답변] 카드 영역 (D4~D6) -->
        <div class="view-card">
            <div class="card-label">[답변]</div>
            <div class="card-content">
                <div class="content-title">Re: 지진 발생 시 행동요령이 궁금합니다</div>
                <div class="content-text">답변 내용이 여기에 표시됩니다. 관리자가 작성한 답변입니다.</div>
                
                <div class="info-bar">
                    <div class="info-text">
                        <span>작성자: admin | 관리자</span>
                        <span>작성일: 2025-03-11</span>
                    </div>
                    <!-- L4: 타인 글일 때 답변하기 버튼 노출 -->
                    <div class="btn-group">
                        <a href="qnaReply.do?no=3" class="btn btn-reply">답변하기</a>
                    </div>
                </div>
            </div>
        </div>

        <!-- 목록 버튼 (L5) -->
        <div class="list-btn-area">
            <a href="qnaList.do" class="btn btn-list">← 목록</a>
        </div>
    </main>

    <footer>푸터</footer>
</div>

</body>
</html>