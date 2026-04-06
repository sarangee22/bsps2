<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA 상세보기</title>
<style>

    body { font-family: 'Malgun Gothic', sans-serif; margin: 0; padding: 0; background-color: #f4f4f4; }
    .container { width: 900px; margin: 50px auto; border: 1px solid #ccc; background-color: #fff; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
    :root { --navy-color: #001f3f; }
    header { background-color: var(--navy-color); color: white; padding: 15px 20px; display: flex; justify-content: space-between; align-items: center; }
    .logout-btn { background-color: #eee; color: #333; padding: 5px 15px; border-radius: 4px; text-decoration: none; font-size: 12px; border: 1px solid #ccc; }
    main { padding: 30px; min-height: 600px; }
    .view-card { border: 1px solid #ddd; border-radius: 8px; margin-bottom: 30px; background-color: #fff; overflow: hidden; }
    .card-label { background-color: #f8f9fa; padding: 10px 20px; font-size: 13px; font-weight: bold; border-bottom: 1px solid #eee; color: #666; }
    .card-content { padding: 20px; }
    .content-title { font-size: 18px; font-weight: bold; margin-bottom: 15px; color: #333; }
    .content-text { background-color: #f1f1f1; padding: 20px; border-radius: 5px; min-height: 100px; font-size: 14px; line-height: 1.6; white-space: pre-wrap; margin-bottom: 15px; }
    .info-bar { display: flex; justify-content: space-between; align-items: center; font-size: 13px; color: #777; padding-top: 10px; }
    .info-text span { margin-right: 15px; }
    .btn-group { display: flex; gap: 5px; }
    .btn { padding: 6px 15px; border-radius: 4px; font-size: 12px; cursor: pointer; border: 1px solid #ccc; text-decoration: none; color: #333; background-color: #eee; }
    .btn:hover { background-color: #ddd; }
    .list-btn-area { margin-top: 20px; }
    .btn-area-right { display: flex; justify-content: flex-end; /* 오른쪽 정렬 */
    margin-top: 20px; width: 100%; }
    .btn-area-right .btn { padding: 10px 25px; background-color: #888; color: white; border: none;
    border-radius: 4px; cursor: pointer; font-weight: bold; }
    .btn-list { background-color: #bbb; color: #000; padding: 10px 25px; font-weight: bold; }
    .btn-reply { background-color: var(--navy-color); color: white; border: none; }
    footer { background-color: #eee; text-align: center; padding: 20px; font-size: 12px; border-top: 1px solid #ccc; }
</style>
</head>
<body>

<div class="container">
    <header>
        <div class="logo">재난/안전 정보 사이트</div>
        <div class="user-area">
            <%-- 실제 로그인한 사람 이름이 나오게 하려면 세션값 사용 --%>
            <span>${login.name}님 &nbsp;</span>
            <a href="/member/logout.do" class="logout-btn">로그아웃</a>
        </div>
    </header>

    <main>
        <div class="view-card">
            <%-- levNo가 0이면 [질문], 0보다 크면 [답변]으로 라벨 표시 --%>
            <div class="card-label">${vo.levNo == 0 ? '[질문]' : '[답변]'}</div>
            
            <div class="card-content">
                <div class="content-title">${vo.title}</div>
                <div class="content-text">${vo.content}</div>
                
                <div class="info-bar">
                    <div class="info-text">
                        <span>작성자: ${vo.id}</span>
                        <span>작성일: ${vo.writeDate}</span>
                        <span>조회수: ${vo.hit}</span>
                    </div>
                    
                    <div class="btn-group">
                        <%-- 본인 글이거나 관리자일 때만 수정/삭제 버튼 노출 (예시) --%>
							<c:if test="${login.id == vo.id}">
								<a href="updateForm.do?no=${vo.no}" class="btn">수정</a>
								<a href="delete.do?no=${vo.no}" class="btn"
									onclick="return confirm('정말 삭제하시겠습니까?')">삭제</a>
							</c:if>
							<c:if test="${login.id == 'admin'}">
								<a href="answerForm.do?no=${vo.no}" class="btn">답변하기</a>
							</c:if>
						</div>
                </div>
            </div>
        </div>

			<div class="btn-area-right">
				<button type="button" class="btn" onclick="location.href='list.do'">←목록</button>
		</div>
	</main>
</div>

</body>
</html>