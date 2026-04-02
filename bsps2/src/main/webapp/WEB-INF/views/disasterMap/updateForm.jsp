<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재난 정보 수정</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<style>
    .container { max-width: 800px; margin-top: 50px; margin-bottom: 50px; }
    .card { border-radius: 15px; box-shadow: 0 4px 20px rgba(0,0,0,0.1); }
    .card-header { font-weight: bold; font-size: 1.2rem; }
    #map-preview { width: 100%; height: 300px; border-radius: 10px; border: 1px solid #ddd; margin-top: 10px; }
    label { font-weight: 600; color: #444; }
</style>
</head>
<body>

<div class="container">
    <div class="card">
        <div class="card-header bg-primary text-white">
            📝 재난 현황 정보 수정
        </div>
        <div class="card-body">
            <form action="update.do" method="post">
                <input type="hidden" name="disasterId" value="${vo.disasterId}">
                
                <input type="hidden" name="latitude" value="${vo.latitude}">
                <input type="hidden" name="longitude" value="${vo.longitude}">

                <div class="form-row">
                    <div class="form-group col-md-6">
                        <label>🚨 재난 유형</label>
                        <select name="disasterType" class="form-control">
                            <option value="화재" ${vo.disasterType == '화재' ? 'selected' : ''}>화재</option>
                            <option value="태풍" ${vo.disasterType == '태풍' ? 'selected' : ''}>태풍</option>
                            <option value="침수" ${vo.disasterType == '침수' ? 'selected' : ''}>침수</option>
                            <option value="지진" ${vo.disasterType == '지진' ? 'selected' : ''}>지진</option>
                        </select>
                    </div>
                    <div class="form-group col-md-6">
                        <label>📍 지역</label>
                        <input type="text" name="region" class="form-control" value="${vo.region}" required>
                    </div>
                </div>

                <div class="form-group">
                    <label>📢 재난 명칭</label>
                    <input type="text" name="disasterName" class="form-control" value="${vo.disasterName}" required>
                </div>

                <div class="form-group">
                    <label>🏠 상세 주소 (지도 반영용)</label>
                    <div class="input-group">
                        <input type="text" id="address" name="address" class="form-control" value="${vo.address}" required>
                        <div class="input-group-append">
                            <button type="button" class="btn btn-secondary" onclick="previewMap()">지도 확인</button>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label>📝 상세 내용</label>
                    <textarea name="content" class="form-control" rows="5" required>${vo.content}</textarea>
                </div>

                <div id="map-preview-box">
                    <label>🗺️ 위치 미리보기</label>
                    <iframe id="map-preview" src="https://maps.google.com/maps?q=$${vo.address}&t=&z=15&ie=UTF8&iwloc=&output=embed" width="100%" height="300" style="border:0;"></iframe>
                </div>

                <div class="text-right mt-4">
                    <button type="submit" class="btn btn-success px-4 font-weight-bold">수정 완료</button>
                    <button type="button" class="btn btn-outline-secondary" onclick="history.back()">취소</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
// 주소를 입력하고 '지도 확인'을 누르면 iframe을 갱신하는 함수
function previewMap() {
    var addr = document.getElementById('address').value;
    if(!addr) {
        alert("주소를 입력해주세요!");
        return;
    }
    // 구글 맵 iframe 주소 업데이트
    var newSrc = "https://maps.google.com/maps?q=$" + encodeURIComponent(addr) + "&t=&z=15&ie=UTF8&iwloc=&output=embed";
    document.getElementById('map-preview').src = newSrc;
}
</script>

</body>
</html>