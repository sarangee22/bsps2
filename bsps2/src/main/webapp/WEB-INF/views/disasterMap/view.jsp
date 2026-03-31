<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재난 상세 정보</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">

<style>
    body { background-color: #f8f9fa; font-family: 'Noto Sans KR', sans-serif; color: #333; }
    .container { max-width: 900px; margin-top: 50px; margin-bottom: 80px; }

    /* 헤더 영역 */
    .view-header { margin-bottom: 30px; display: flex; justify-content: space-between; align-items: flex-end; }
    .view-header h2 { font-weight: 700; color: #1a1a1a; margin-bottom: 0; }
    .badge-main { padding: 8px 16px; border-radius: 20px; font-weight: 600; font-size: 14px; }

    /* 카드 공통 스타일 */
    .view-card { 
        background: white; border-radius: 25px; padding: 40px; 
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05); border: none; margin-bottom: 30px;
    }

    /* 지도 영역 */
    .map-wrapper { 
        width: 100%; height: 400px; border-radius: 20px; 
        overflow: hidden; border: 1px solid #eee; margin-bottom: 20px;
    }

    /* 정보 그리드 */
    .info-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }
    .info-item { background: #fcfcfc; padding: 20px; border-radius: 15px; border: 1px solid #f1f3f5; }
    .info-item label { display: block; color: #888; font-size: 13px; margin-bottom: 5px; font-weight: 500; }
    .info-item span { font-size: 16px; font-weight: 600; color: #333; }
    .info-item.full { grid-column: span 2; }

    /* 버튼 스타일 */
    .btn-custom { 
        padding: 12px 25px; border-radius: 12px; font-weight: 600; 
        transition: 0.3s; font-size: 15px; text-decoration: none !important;
    }
    .btn-list { background-color: #333; color: white; }
    .btn-list:hover { background-color: #000; color: white; }
    .btn-edit { background-color: #eef2ff; color: #4361ee; border: 1px solid #dbe4ff; }
    .btn-edit:hover { background-color: #4361ee; color: white; }
</style>
</head>
<body>

<div class="container">
    <div class="view-header">
        <div>
            <p class="text-muted mb-1" style="font-size: 14px;">재난 상세 정보 확인</p>
            <h2>🚨 ${vo.disasterName}</h2>
        </div>
        <span class="badge-main ${vo.disasterType == '화재' ? 'badge-danger' : 'badge-primary'}">
            ${vo.disasterType}
        </span>
    </div>

    <div class="view-card">
        <h5 class="font-weight-bold mb-3">📍 발생 위치</h5>
        <div class="map-wrapper">
            <iframe
              width="100%"
              height="100%"
              style="border:0"
              loading="lazy"
              allowfullscreen
              src="https://maps.google.com/maps?q=$${vo.address}&t=&z=15&ie=UTF8&iwloc=&output=embed">
            </iframe>
        </div>
        <p class="text-muted mb-0" style="font-size: 14px;">
            <i class="fa fa-map-marker"></i> 주소: <strong>${vo.address}</strong> (${vo.region})
        </p>
    </div>

    <div class="view-card">
        <h5 class="font-weight-bold mb-4">📝 상세 내역</h5>
        <div class="info-grid">
            <div class="info-item">
                <label>재난 번호</label>
                <span>No. ${vo.disasterId}</span>
            </div>
            <div class="info-item">
                <label>발생 일시</label>
                <span>${vo.createdAt}</span>
            </div>
            <div class="info-item">
                <label>위도 (Lat)</label>
                <span>${vo.latitude}</span>
            </div>
            <div class="info-item">
                <label>경도 (Lng)</label>
                <span>${vo.longitude}</span>
            </div>
            <div class="info-item full">
                <label>상세 내용</label>
                <div style="line-height: 1.6; white-space: pre-wrap;">${vo.content}</div>
            </div>
        </div>
    </div>

    <div class="d-flex justify-content-between">
        <a href="list.do" class="btn-custom btn-list">← 목록으로</a>
        <div>
            <a href="updateForm.do?disasterId=${vo.disasterId}" class="btn-custom btn-edit">정보 수정</a>
        </div>
    </div>
</div>

</body>
</html>