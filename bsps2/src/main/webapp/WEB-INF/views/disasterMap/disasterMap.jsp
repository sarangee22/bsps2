<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>

<title>재난 지도</title>

<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=15c49a51dd741e79c687b702c23d9247"></script>

<style>
#map{
width:100%;
height:600px;
}
</style>

</head>

<body>

<h2>재난 지도</h2>

<div id="map"></div>

<script>

// 지도 생성
var container = document.getElementById('map');

var options = {
center: new kakao.maps.LatLng(37.5665,126.9780),
level:7
};

var map = new kakao.maps.Map(container, options);


// DB 데이터 → 마커 생성
<c:forEach items="${list}" var="vo">

var markerPosition = new kakao.maps.LatLng(${vo.latitude}, ${vo.longitude});

var marker = new kakao.maps.Marker({
position: markerPosition
});

marker.setMap(map);


// 마커 클릭 이벤트
kakao.maps.event.addListener(marker, 'click', function() {

location.href = "view.do?disasterId=${vo.disasterId}";

});

</c:forEach>

</script>

</body>
</html>