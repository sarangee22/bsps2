<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>기관 상세 정보</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<style>
    .card { border-radius: 15px; overflow: hidden; box-shadow: 0 4px 15px rgba(0,0,0,0.1); }
    .card-header { font-weight: bold; }

    .map-box { border-radius: 10px; width:100%; height:450px; border: 1px solid #ddd; overflow: hidden; }
</style>
</head>
<body>
<div class="container mt-5 mb-5">
    <div class="card">
        <div class="card-header bg-dark text-white d-flex justify-content-between align-items-center">
            <h3 class="mb-0">🏢 ${vo.agencyName} 상세 정보</h3>
            <span class="badge badge-warning p-2" style="font-size: 0.9rem;">${vo.agencyType}</span>
        </div>
        <div class="card-body">
            <table class="table table-bordered">
                <tr>
                    <th class="bg-light" style="width: 20%;">연락처</th>
                    <td style="width: 30%;">${vo.phone}</td>
                    <th class="bg-light" style="width: 20%;">운영 상태</th>
                    <td><span class="text-success">● 정상 운영 중</span></td>
                </tr>
                <tr>
                    <th class="bg-light">주소</th>
                    <td colspan="3">${vo.address}</td>
                </tr>
                <tr>
                    <th class="bg-light">운영 시간</th>
                    <td colspan="3">${vo.operatingHours}</td>
                </tr>
            </table>

            <h5 class="mt-4">📍 위치 지도 (Google Maps)</h5>
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
        
        <div class="card-footer bg-light text-right">
            <a href="updateForm.do?agencyId=${vo.agencyId}" class="btn btn-outline-primary mr-1">수정하기</a>
            <button type="button" class="btn btn-outline-danger mr-1" onclick="deleteAgency()">삭제하기</button>
            <a href="list.do" class="btn btn-dark">목록으로</a>
        </div>
    </div>
</div>

<script>
// 삭제 확인 함수
function deleteAgency() {
    if(confirm("정말 이 기관 정보를 삭제하시겠습니까?")) {
        location.href = "delete.do?agencyId=${vo.agencyId}";
    }
}
</script>
</body>
</html>