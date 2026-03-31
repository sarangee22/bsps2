<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>재난 안전 지도</title>
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    
    <style>
        body { background-color: #f8f9fa; }
        .map-container {
            margin: 30px auto;
            padding: 20px;
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
        }
        #map { 
            width: 100%; 
            height: 650px; 
            border-radius: 15px;
            z-index: 1;
        }
        .map-header { margin-bottom: 20px; }
    </style>
</head>
<body>

<div class="container-fluid px-5">
    <div class="map-container">
        <div class="map-header d-flex justify-content-between align-items-center">
            <div>
                <h2 class="font-weight-bold">📍 재난 안전 시설 지도</h2>
                <p class="text-muted">등록된 모든 기관의 위치를 한눈에 확인하세요.</p>
            </div>
            <a href="/agency/list.do" class="btn btn-dark btn-lg" style="border-radius: 12px;">목록으로 돌아가기</a>
        </div>

        <div id="map"></div>
    </div>
</div>

<script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>

<script>
    // 1. 지도 초기화 (한국 중심 좌표: 36.5, 127.5 / 줌 레벨: 7)
    var map = L.map('map').setView([36.5, 127.5], 7);

    // 2. 지도 타일 추가 (OpenStreetMap 사용 - 무료)
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        attribution: '&copy; OpenStreetMap contributors'
    }).addTo(map);

    // 3. JSTL을 이용해 자바 리스트 데이터를 자바스크립트 배열로 변환
    var locations = [
        <c:forEach items="${list}" var="vo" varStatus="status">
            {
                name: "${vo.agencyName}",
                type: "${vo.agencyType}",
                lat: ${vo.latitude},
                lng: ${vo.longitude},
                phone: "${vo.phone}",
                id: "${vo.agencyId}"
            }${!status.last ? ',' : ''}
        </c:forEach>
    ];

    // 4. 지도에 마커 찍기
    locations.forEach(function(loc) {
        if(loc.lat && loc.lng) { // 좌표가 있는 경우에만 표시
            var marker = L.marker([loc.lat, loc.lng]).addTo(map);
            
            // 클릭 시 나타날 팝업 내용
            var popupContent = `
                <div style="padding:5px;">
                    <b style="font-size:14px;">${'${loc.name}'}</b><br>
                    <span class="badge badge-info">${'${loc.type}'}</span><br>
                    📞 ${'${loc.phone}'}<br>
                    <a href="/agency/view.do?agencyId=${'${loc.id}'}" style="display:block; margin-top:5px; color:#4361ee; font-weight:bold;">상세보기</a>
                </div>
            `;
            marker.bindPopup(popupContent);
        }
    });

    // 5. 첫 번째 마커로 지도 중심 이동 (데이터가 있을 경우)
    if(locations.length > 0 && locations[0].lat) {
        map.setView([locations[0].lat, locations[0].lng], 10);
    }
</script>

</body>
</html>