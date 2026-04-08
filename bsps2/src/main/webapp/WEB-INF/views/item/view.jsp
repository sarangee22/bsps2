<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>물품 상세</title>

<style>
body {
	background-color: #f4f7f9;
	font-family: 'Noto Sans KR', sans-serif;
}

/* 전체 */
.detail-wrapper {
	max-width: 1000px;
	margin: 130px auto 80px auto;
}

/* 상단 */
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

.btn-outline {
	border: 1px solid #ddd;
	background: white;
	color: #555;
}

.btn-outline:hover {
	background: #f1f4f8;
}

.btn-primary {
	background: #1A237E;
	color: white;
}

.btn-primary:hover {
	background: #0d145c;
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
	padding: 40px;
	border-radius: 25px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
}

/* 제목 */
.title {
	font-size: 32px;
	font-weight: 800;
	color: #1A237E;
	margin-bottom: 10px;
}

.category {
	color: #777;
	margin-bottom: 30px;
}

/* 상태 */
.status-box {
	background: #f8f9ff;
	padding: 25px;
	border-radius: 20px;
	margin-bottom: 30px;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.status-text {
	font-size: 22px;
	font-weight: 800;
}

.ready {
	color: #2ecc71;
}

.not-ready {
	color: #e67e22;
}

/* 정보 그리드 */
.info-grid {
	display: grid;
	grid-template-columns: repeat(2, 1fr);
	gap: 20px;
	margin-bottom: 30px;
}

.info-box {
	background: #f8f9fa;
	padding: 20px;
	border-radius: 15px;
}

.label {
	font-size: 12px;
	color: #888;
	font-weight: 700;
	margin-bottom: 5px;
}

.value {
	font-size: 20px;
	font-weight: 800;
	color: #333;
}

/* 우선순위 */
.badge {
	padding: 6px 12px;
	border-radius: 8px;
	font-size: 12px;
	font-weight: 700;
}

.high {
	background: #fff0f0;
	color: #ff4d4f;
}

.mid {
	background: #fff9e6;
	color: #f39c12;
}

.low {
	background: #eef2ff;
	color: #4361ee;
}

/* 메모 */
.memo {
	background: #f8f9fa;
	padding: 20px;
	border-radius: 15px;
	line-height: 1.7;
	color: #555;
}

/* 기록 */
.meta {
	margin-top: 30px;
	font-size: 13px;
	color: #999;
}
</style>
</head>

<body>

	<div class="detail-wrapper">

		<div class="top-bar">
			<a href="list.do?page=${param.page}&perPageNum=${param.perPageNum}"
				class="btn btn-outline"> ← 목록으로 </a>

			<div style="display: flex; gap: 10px;">
				<a
					href="updateForm.do?no=${vo.no}&page=${param.page}&perPageNum=${param.perPageNum}"
					class="btn btn-outline">수정</a> <a
					href="delete.do?no=${vo.no}&perPageNum=${param.perPageNum}"
					class="btn btn-danger" onclick="return confirm('삭제하시겠습니까?')">삭제</a>
			</div>
		</div>

		<div class="detail-card">

			<div class="title">${vo.name}</div>
			<div class="category">${vo.category}</div>

			<!-- 상태 -->
			<div class="status-box">
				<div
					class="status-text ${vo.isReady == 'Y' ? 'ready' : 'not-ready'}">
					${vo.isReady == 'Y' ? '✅ 준비 완료' : '⚠ 준비 필요'}</div>

				<!-- ✅ 수정된 부분 -->
				<c:if test="${vo.isReady == 'N' or empty vo.isReady}">
					<a
						href="changeReady.do?no=${vo.no}&isReady=Y&page=${param.page}&perPageNum=${param.perPageNum}"
						class="btn btn-primary"> 완료로 변경 </a>
				</c:if>

				<c:if test="${vo.isReady == 'Y'}">
					<a
						href="changeReady.do?no=${vo.no}&isReady=N&page=${param.page}&perPageNum=${param.perPageNum}"
						class="btn btn-outline"> 미완료로 변경 </a>
				</c:if>
			</div>

			<!-- 정보 -->
			<div class="info-grid">
				<div class="info-box">
					<div class="label">수량</div>
					<div class="value">${vo.quantity}${vo.unit}</div>
				</div>

				<div class="info-box">
					<div class="label">우선순위</div>
					<div>
						<c:set var="pClass"
							value="${vo.priority == '높음' ? 'high' : (vo.priority == '낮음' ? 'low' : 'mid')}" />
						<span class="badge ${pClass}">${vo.priority}</span>
					</div>
				</div>
			</div>

			<div class="info-box" style="margin-bottom: 20px;">
				<div class="label">유효기한</div>
				<div class="value">${empty vo.expiryDate ? '기한 없음' : vo.expiryDate}</div>
			</div>

			<div>
				<div class="label">메모</div>
				<div class="memo">${empty vo.memo ? '입력된 메모가 없습니다.' : vo.memo}
				</div>
			</div>

			<div class="meta">생성일: ${vo.regDate} | 수정일: ${empty vo.updateDate ? '-' : vo.updateDate}
			</div>

		</div>

	</div>

</body>
</html>
