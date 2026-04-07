<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재난 정보 상세보기</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
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
	width: 130px; /* 조금 넓혔습니다 */
	display: inline-block;
}

.badge-step {
	padding: 8px 15px;
	font-size: 0.9em;
	border-radius: 20px;
}

/* 실시간 데이터 박스 스타일 */
.api-box {
	background-color: #f0f7ff;
	border: 1px solid #cfe2ff;
	border-left: 5px solid #0d6efd;
}
</style>
</head>
<body>
	<div class="container">
		<div class="card view-card">
			<div class="view-header">
				<h3 class="mb-0">
				    <span class="badge badge-step shadow-sm"
				        style="
				            color: white !important; 
				            background-color: ${vo.dangerLevel == 3 ? '#dc3545' : (vo.dangerLevel == 2 ? '#ffc107' : '#17a2b8')} !important;
				            padding: 8px 15px; 
				            border-radius: 5px;
				        ">
				        ${vo.dangerLevel == 3 ? '위험' : (vo.dangerLevel == 2 ? '주의' : '보통')}
				    </span> 
				    <span class="ml-2" style="font-weight: bold; color: #333;">${vo.locationName} 재난 상황</span>
				</h3>
			</div>

			<div class="view-body">
				<div class="row mb-4">
					<div class="col-md-6">
						<div class="mb-2">
							<span class="label-title"><i class="bi bi-hash"></i> 발생 번호 :</span> <span>${vo.no}</span>
						</div>
						<div class="mb-2">
							<span class="label-title"><i class="bi bi-geo-alt"></i> 발생 지역 :</span> <span>${vo.locationName}</span>
						</div>
					</div>
					<div class="col-md-6">
						<div class="mb-2">
							<span class="label-title"><i class="bi bi-clock"></i> 발생 일시 :</span> <span>${vo.createDate}</span>
						</div>
					</div>
				</div>
				
				<hr>

<div class="mt-4">
    <h5 class="font-weight-bold mb-3 text-secondary">
        <i class="bi bi-envelope-paper"></i> 수신된 재난 문자
    </h5>
    <div class="p-4 bg-light rounded border" style="min-height: 100px; font-size: 1.1em; border-left: 5px solid #ffc107 !important;">
        ${vo.content}
    </div>
</div>

<c:if test="${not empty extra}">
    <div class="mt-5 p-4 rounded shadow-sm api-box" style="background-color: #f0f7ff; border: 1px solid #cfe2ff; border-left: 5px solid #0d6efd !important;">
        <h5 class="font-weight-bold mb-4 text-primary">
            <i class="bi bi-broadcast-pin"></i> ${extra.title}
        </h5>
        
        <div class="row">
            <c:choose>
                <%-- 🔥 1. 화재/폭발(산불 포함) --%>
                <c:when test="${vo.catID == 1}">
                    <div class="col-md-6 border-right">
                        <p><span class="label-title">진화 상태 :</span> <span class="badge badge-danger">${not empty extra.status ? extra.status : '분석 중'}</span></p>
                        <p><span class="label-title">발생 원인 :</span> ${not empty extra.cause ? extra.cause : '확인 중'}</p>
                    </div>
                    <div class="col-md-6 pl-4">
                        <p><span class="label-title">피해 면적 :</span> ${not empty extra.area ? extra.area : '산출 중'}</p>
                        <p><span class="label-title">상세 위치 :</span> ${not empty extra.loc ? extra.loc : vo.locationName}</p>
                    </div>
                </c:when>

                <%-- 🏠 2. 지진/해일 --%>
                <c:when test="${vo.catID == 2}">
                    <div class="col-md-6 border-right">
                        <p><span class="label-title">지진 규모 :</span> <strong class="text-danger">${not empty extra.magnitude ? extra.magnitude : '분석 중'}</strong></p>
                        <p><span class="label-title">발생 깊이 :</span> ${not empty extra.depth ? extra.depth : '측정 중'}</p>
                    </div>
                    <div class="col-md-6 pl-4">
                        <p><span class="label-title">진앙 위치 :</span> ${not empty extra.locationDetail ? extra.locationDetail : '분석 중'}</p>
                        <p><span class="label-title">현재 상태 :</span> <span class="badge badge-warning">${not empty extra.status ? extra.status : '감시 중'}</span></p>
                    </div>
                </c:when>

                <%-- ❄️ 3, 4. 태풍/호우/폭염/한파 (기상 API 결합) --%>
                <c:when test="${vo.catID == 3 || vo.catID == 4}">
                    <div class="col-md-6 border-right">
                        <p><span class="label-title">현재 기온 :</span> ${not empty extra.temp ? extra.temp : '측정 중'} ℃</p>
                        <p><span class="label-title">강수 확률 :</span> ${not empty extra.pop ? extra.pop : '0'} %</p>
                    </div>
                    <div class="col-md-6 pl-4">
                        <p><span class="label-title">풍속/습도 :</span> ${extra.wsd} m/s / ${extra.reh} %</p>
                        <p><span class="label-title">기상 특보 :</span> 분석 중</p>
                    </div>
                </c:when>

                <%-- 🚧 6. 교통/산업사고 (CCTV 연동 구역) --%>
                <c:when test="${vo.catID == 6}">
                    <div class="col-md-12 text-center py-3">
                        <p class="mb-2"><i class="bi bi-camera-video"></i> <strong>사고 인근 실시간 CCTV 분석</strong></p>
                        <div class="bg-dark rounded text-white d-flex align-items-center justify-content-center" style="height: 150px;">
                            CCTV 영상을 불러오는 중입니다...
                        </div>
                    </div>
                </c:when>

                <%-- 💡 5, 7, 8, 9. 기타 카테고리 (공통 분석 양식) --%>
                <c:otherwise>
                    <div class="col-md-12">
                        <p class="mb-0 text-center text-muted py-3">
                            <i class="bi bi-gear-wide-connected spin"></i> 해당 재난 유형에 대한 실시간 외부 데이터를 매칭 중입니다.
                        </p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
        <div class="mt-3 text-right">
            <small class="text-muted" style="font-size: 0.8em;">
                * 본 리포트는 ${vo.locationName} 지역의 공공데이터 API를 실시간으로 조인(Join)하여 생성되었습니다.
            </small>
        </div>
    </div>
</c:if>

<div class="mt-5">
    <h5 class="font-weight-bold mb-3 text-success">
        <i class="bi bi-shield-check"></i> 유형별 대처 방법
    </h5>
    <div class="p-3 border rounded bg-white">
        ${vo.detailContent}
    </div>
</div>
				<div class="card-footer text-right mt-5 bg-white border-0 p-0">
					<a href="list.do?catID=${vo.catID}&page=${pageObject.page}&perPageNum=${pageObject.perPageNum}"
						class="btn btn-primary"> <i class="bi bi-list-ul"></i> 목록으로
					</a> <a href="/scrap/scrap.do?no=${vo.no}" class="btn btn-warning text-white">
						<i class="bi bi-star-fill"></i> 스크랩하기
					</a> <a href="/scrap/list.do" class="btn btn-info">내 스크랩 목록</a> <a
						href="/disasterCategory/list.do" class="btn btn-secondary"> <i
						class="bi bi-grid-fill"></i> 카테고리 목록
					</a>
				</div>
			</div>
		</div>
	</div>
</body>
</html>