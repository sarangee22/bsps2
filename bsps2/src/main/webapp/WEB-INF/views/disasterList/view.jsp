<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재난 정보 상세보기</title>
<style type="text/css">
.view-card {
	margin-top: 30px;
	border-radius: 15px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.view-header {
	background-color: #f8f9fa;
	border-bottom: 2px solid #dee2e6;
	padding: 20px;
	border-top-left-radius: 15px;
	border-top-right-radius: 15px;
}

.view-body {
	padding: 30px;
	line-height: 1.8;
}

.label-title {
	font-weight: bold;
	color: #495057;
	width: 120px;
	display: inline-block;
}

.badge-step {
	padding: 8px 15px;
	font-size: 0.9em;
	border-radius: 20px;
}
</style>
</head>
<body>
	<div class="container">
		<div class="card view-card">
			<div class="view-header">
				<h3 class="mb-0">
					<span
						class="badge badge-step ${vo.dangerLevel == 3 ? 'badge-danger' : (vo.dangerLevel == 2 ? 'badge-warning' : 'badge-info')}">
						${vo.dangerLevel == 3 ? '위험' : (vo.dangerLevel == 2 ? '주의' : '보통')}
					</span> <span class="ml-2">${vo.locationName} 재난 상황</span>
				</h3>
			</div>

			<div class="view-body">
				<div class="mb-3">
					<span class="label-title">발생 번호 :</span> <span>${vo.no}</span>
				</div>
				<div class="mb-3">
					<span class="label-title">발생 지역 :</span> <span>${vo.locationName}</span>
				</div>
				<div class="mb-3">
					<span class="label-title">발생 일시 :</span> <span>${vo.createDate}</span>
				</div>
				<hr>
				<div class="mt-4">
					<h5 class="font-weight-bold mb-3">상세 내용</h5>
					<div class="p-3 bg-light rounded" style="min-height: 150px;">
						${vo.content}</div>
				</div>
				<div class="card-footer text-right">
					<a href="list.do?catID=${param.catID}&page=${pageObject.page}&perPageNum=${pageObject.perPageNum}"
						class="btn btn-primary"> <i class="bi bi-list-ul"></i> 목록으로
					</a> <a href="/scrap/scrap.do?no=${vo.no}" class="btn btn-warning">
						<i class="bi bi-star-fill"></i> 스크랩하기
					</a> <a href="/scrap/list.do" class="btn btn-info">내 스크랩 목록</a> <a
						href="/disasterCategory/list.do" class="btn btn-secondary"> <i
						class="bi bi-grid-fill"></i> 카테고리 목록
					</a>
				</div>
			</div>

			<div class="card-footer text-right bg-white border-0 pb-4"></div>
		</div>
	</div>
</body>
</html>