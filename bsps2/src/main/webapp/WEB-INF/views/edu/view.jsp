<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>${vo.title} - 가이드 상세</title>

<style>
body {
    background-color: #f4f7f9;
    font-family: 'Noto Sans KR', sans-serif;
    margin: 0;
}

/* 전체 컨테이너 */
.detail-wrapper {
    max-width: 1000px;
    margin: 140px auto 80px auto;
}

/* 상단 버튼 영역 */
.top-bar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 30px;
}

.btn {
    padding: 10px 18px;
    border-radius: 10px;
    font-size: 14px;
    font-weight: 600;
    text-decoration: none;
    transition: 0.3s;
}

.btn-primary {
    background: #1A237E;
    color: white;
}

.btn-primary:hover {
    background: #0d145c;
}

.btn-outline {
    border: 1px solid #ddd;
    color: #555;
    background: white;
}

.btn-outline:hover {
    background: #f1f4f8;
}

.btn-danger {
    border: 1px solid #ff4d4f;
    color: #ff4d4f;
    background: white;
}

.btn-danger:hover {
    background: #fff1f0;
}

/* 카드 */
.detail-card {
    background: white;
    padding: 50px;
    border-radius: 25px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.05);
}

/* 카테고리 */
.category {
    display: inline-block;
    background: #e8eaf6;
    color: #1A237E;
    padding: 6px 14px;
    border-radius: 8px;
    font-size: 12px;
    font-weight: 700;
    margin-bottom: 20px;
}

/* 제목 */
.title {
    font-size: 34px;
    font-weight: 800;
    color: #1A237E;
    margin-bottom: 25px;
    line-height: 1.4;
}

/* 메타 정보 */
.meta {
    display: flex;
    gap: 20px;
    font-size: 13px;
    color: #888;
    margin-bottom: 30px;
}

/* 구분선 */
.divider {
    border-top: 1px solid #eee;
    margin: 30px 0;
}

/* 내용 */
.content {
    font-size: 16px;
    color: #444;
    line-height: 1.9;
    white-space: pre-wrap;
}

/* 하단 */
.bottom-bar {
    margin-top: 40px;
    display: flex;
    justify-content: space-between;
}
</style>
</head>

<body>

<div class="detail-wrapper">

    <!-- 상단 -->
    <div class="top-bar">
        <a href="list.do?page=${pageObject.page}&perPageNum=${pageObject.perPageNum}" class="btn btn-outline">
            ← 목록으로
        </a>

        <div style="display:flex; gap:10px;">
            <a href="writeForm.do" class="btn btn-primary">글 작성</a>
            <a href="updateForm.do?no=${vo.no}" class="btn btn-outline">수정</a>
            <a href="delete.do?no=${vo.no}" onclick="return confirm('삭제하시겠습니까?')" class="btn btn-danger">삭제</a>
        </div>
    </div>

    <!-- 카드 -->
    <div class="detail-card">

        <div class="category">${vo.category}</div>

        <div class="title">${vo.title}</div>

        <div class="meta">
            <span>작성자: ${vo.writer}</span>
            <span>작성일: ${vo.regDate}</span>
            <span>조회수: ${vo.hit}</span>
        </div>

        <div class="divider"></div>

        <div class="content">
            ${vo.content}
        </div>

    </div>

    <!-- 하단 버튼 -->
    <div class="bottom-bar">
        <a href="list.do?page=${pageObject.page}&perPageNum=${pageObject.perPageNum}" class="btn btn-outline">
            ← 목록으로
        </a>
    </div>

</div>

</body>
</html>
