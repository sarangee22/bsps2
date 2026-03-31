<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>실시간 재난 현황 지도</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <style>
        .map-container { width: 100%; height: 500px; border-radius: 15px; overflow: hidden; border: 1px solid #ddd; box-shadow: 0 4px 15px rgba(0,0,0,0.1); }
        .table-container { margin-top: 30px; }
        .badge-fire { background-color: #ff4d4d; color: white; }
        .badge-flood { background-color: #007bff; color: white; }
    </style>
</head>
<body>

<div class="container mt-5">
    <h2 class="text-center mb-4">🚨 실시간 재난 현황 지도</h2>

    <div class="map-container">
        <iframe
          id="googleMap"
          width="100%"
          height="100%"
          style="border:0"
          loading="lazy"
          allowfullscreen
          src="https://maps.google.com/maps?q=${list[0].address}&t=&z=7&ie=UTF8&iwloc=&output=embed">
        </iframe>
    </div>

    <div class="table-container">
        <table class="table table-hover text-center">
            <thead class="thead-dark">
                <tr>
                    <th>유형</th>
                    <th>재난명칭</th>
                    <th>지역(주소)</th>
                    <th>발생일</th>
                    <th>지도보기</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${list}" var="vo">
                    <tr>
                        <td>
                            <span class="badge ${vo.disasterType == '화재' ? 'badge-fire' : 'badge-flood'}">
                                ${vo.disasterType}
                            </span>
                        </td>
                        <td><strong>${vo.disasterName}</strong></td>
                        <td>${vo.address}</td>
                        <td>${vo.createdAt}</td>
                        <td>
                            <button class="btn btn-sm btn-outline-secondary" 
                                    onclick="changeMap('${vo.address}')">위치확인</button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<script>
// ✅ 버튼 클릭 시 iframe의 주소를 변경해서 해당 위치를 보여주는 함수
function changeMap(address) {
    var mapIframe = document.getElementById('googleMap');
    // 주소를 구글 맵 검색 URL 형식으로 변환
    var newSrc = "https://maps.google.com/maps?q=$" + encodeURIComponent(address) + "&t=&z=14&ie=UTF8&iwloc=&output=embed";
    mapIframe.src = newSrc;
    
    // 클릭 시 지도 위치로 스크롤 이동 (선택 사항)
    window.scrollTo({top: 0, behavior: 'smooth'});
}
</script>

</body>
</html>