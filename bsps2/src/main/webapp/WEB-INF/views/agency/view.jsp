<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${vo.agencyName} - 상세 정보</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">

<style>
    body { background-color: #f8f9fa; font-family: 'Noto Sans KR', sans-serif; color: #333; }
    
    .container { max-width: 900px; margin-top: 50px; margin-bottom: 80px; }

    /* 상단 타이틀 영역 */
    .view-header { display: flex; justify-content: space-between; align-items: flex-end; margin-bottom: 25px; padding: 0 10px; }
    .view-header h2 { font-weight: 700; margin-bottom: 0; color: #2c3e50; }
    .view-header .badge-type { padding: 8px 16px; border-radius: 20px; font-weight: 600; font-size: 14px; background-color: #4361ee; color: white; }

    /* 정보 카드 박스 */
    .info-card { background: white; border-radius: 20px; padding: 40px; box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05); border: none; }

    /* 주요 정보 그리드 */
    .info-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-bottom: 30px; }
    .info-item { background: #fcfcfc; padding: 20px; border-radius: 15px; border: 1px solid #f1f3f5; }
    .info-item label { display: block; color: #888; font-size: 13px; margin-bottom: 5px; font-weight: 500; }
    .info-item span { font-size: 17px; font-weight: 600; color: #333; }
    .info-item.full { grid-column: span 2; }

    /* 지도 영역 */
    .map-section { margin-top: 30px; }
    .map-section h5 { font-weight: 700; font-size: 18px; margin-bottom: 15px; color: #2c3e50; }
    .map-box { border-radius: 15px; width: 100%; height: 400px; border: 1px solid #e9ecef; overflow: hidden; box-shadow: inset 0 2px 10px rgba(0,0,0,0.05); }

    /* 하단 버튼 영역 */
    .action-bar { display: flex; justify-content: space-between; margin-top: 30px; padding: 0 10px; }
    .btn-custom { padding: 12px 25px; border-radius: 12px; font-weight: 600; transition: 0.3s; font-size: 15px; }
    
    .btn-list { background-color: #333; color: white; }
    .btn-list:hover { background-color: #000; color: white; }
    
    .btn-edit { background-color: #eef2ff; color: #4361ee; border: 1px solid #dbe4ff; }
    .btn-edit:hover { background-color: #4361ee; color: white; }
    
    .btn-delete { background-color: #fff0f0; color: #ff4d4d; border: 1px solid #ffe5e5; }
    .btn-delete:hover { background-color: #ff4d4d; color: white; }

    /* 상태 표시 점 */
    .status-dot { display: inline-block; width: 10px; height: 10px; background-color: #2ecc71; border-radius: 50%; margin-right: 5px; }
</style>
</head>
<body>

<div class="container">
    <div class="view-header">
        <div>
            <p class="text-muted mb-1" style="font-size: 14px;">기관 상세 정보</p>
            <h2>🏢 ${vo.agencyName}</h2>
        </div>
        <span class="badge-type">${vo.agencyType}</span>
    </div>

    <div class="info-card">
        <div class="info-grid">
            <div class="info-item">
                <label>📞 비상 연락처</label>
                <span class="text-primary">${vo.phone}</span>
            </div>
            <div class="info-item">
                <label>🟢 운영 상태</label>
                <span><span class="status-dot"></span>정상 운영 중</span>
            </div>
            <div class="info-item">
                <label>⏰ 운영 시간</label>
                <span>${empty vo.operatingHours ? '정보 없음' : vo.operatingHours}</span>
            </div>
            <div class="info-item">
                <label>🔢 기관 고유 번호</label>
                <span>No. ${vo.agencyId}</span>
            </div>
            <div class="info-item full">
                <label>📍 위치 주소</label>
                <span>${vo.address}</span>
            </div>
        </div>

        <div class="map-section">
            <h5>📍 찾아오시는 길</h5>
            <div class="map-box">
                <iframe
                  width="100%"
                  height="100%"
                  style="border:0"
                  loading="lazy"
                  allowfullscreen
                  src="https://maps.google.com/maps?q=${vo.address}&t=&z=16&ie=UTF8&iwloc=&output=embed">
                </iframe>
            </div>
        </div>
    </div>

    <div class="action-bar">
        <a href="list.do" class="btn-custom btn-list">← 목록으로 돌아가기</a>
        <div>
            <a href="updateForm.do?agencyId=${vo.agencyId}" class="btn-custom btn-edit mr-2">정보 수정</a>
            <button type="button" class="btn-custom btn-delete" onclick="deleteAgency()">기관 삭제</button>
        </div>
    </div>
</div>

<script>
function deleteAgency() {
    if(confirm("정말 이 기관 정보를 삭제하시겠습니까?\n삭제된 데이터는 복구할 수 없습니다.")) {
        location.href = "delete.do?agencyId=${vo.agencyId}";
    }
}
</script>

</body>
</html>