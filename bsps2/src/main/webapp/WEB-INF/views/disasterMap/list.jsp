<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>실시간 재난 현황 지도</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">

<style>
    body { background-color: #f4f7f6; font-family: 'Noto Sans KR', sans-serif; color: #333; }
    .container { max-width: 1100px; padding: 50px 20px; }

    // 요약
    .header-box { margin-bottom: 30px; text-align: center; }
    .header-box h2 { font-weight: 700; color: #1a1a1a; margin-bottom: 15px; }
    
    .summary-container { 
        display: flex; justify-content: center; gap: 15px; margin-bottom: 40px; 
    }
    .summary-badge {
        background: white; padding: 10px 20px; border-radius: 50px;
        box-shadow: 0 4px 10px rgba(0,0,0,0.03); font-weight: 600; font-size: 14px;
        display: flex; align-items: center; border: 1px solid #eee;
    }

    // 지도
    .map-section { margin-bottom: 40px; }
    .map-card { 
        background: white; padding: 15px; border-radius: 30px; 
        box-shadow: 0 20px 40px rgba(0,0,0,0.08); border: none;
    }
    .map-wrapper { 
        width: 100%; height: 500px; border-radius: 20px; 
        overflow: hidden; position: relative;
    }

    //리스트
    .list-card { 
        background: white; border-radius: 25px; padding: 35px; 
        box-shadow: 0 10px 30px rgba(0,0,0,0.04); border: none;
    }
    .table thead th { border: none; color: #999; font-weight: 500; font-size: 13px; text-transform: uppercase; }
    .table tbody tr { transition: 0.2s; cursor: pointer; }
    .table tbody tr:hover { background-color: #f8f9ff; }
    .table td { vertical-align: middle !important; border-top: 1px solid #f1f3f5; padding: 18px 10px; }

    //배지 스타일
    .badge-custom { padding: 5px 12px; border-radius: 6px; font-weight: 700; font-size: 11px; }
    .badge-fire { background-color: #fff0f0; color: #ff4d4d; }
    .badge-flood { background-color: #eef2ff; color: #4361ee; }
    
    .selected-row { background-color: #f0f4ff !important; }
    .selected-row td:first-child { border-left: 4px solid #4361ee; border-top-left-radius: 10px; border-bottom-left-radius: 10px; }

    .btn-view-detail { 
        background-color: #4361ee; color: white; border-radius: 8px; 
        font-size: 12px; padding: 6px 12px; border: none; transition: 0.2s;
    }
    .btn-view-detail:hover { background-color: #3049c9; transform: translateY(-1px); }
</style>
</head>
<body>

<div class="container">
    <div class="header-box">
        <h2>🚨 실시간 재난 모니터링</h2>
        <div class="summary-container">
            <div class="summary-badge"><span class="text-danger mr-2">●</span> 화재 3건</div>
            <div class="summary-badge"><span class="text-primary mr-2">●</span> 침수 2건</div>
            <div class="summary-badge"><span class="text-dark mr-2">●</span> 총 ${list.size()}건 발생</div>
        </div>
    </div>

    <div class="map-section">
        <div class="map-card">
            <div class="map-wrapper">
                <iframe
                  id="googleMap"
                  width="100%"
                  height="100%"
                  style="border:0"
                  loading="lazy"
                  allowfullscreen
                  src="https://maps.google.com/maps?q=${list[0].address}&t=&z=14&ie=UTF8&iwloc=&output=embed">
                </iframe>
            </div>
        </div>
        <div class="text-center mt-3">
            <p class="text-muted" style="font-size: 14px;">📍 현재 지도 위치: <span id="currentAddr" class="font-weight-bold text-dark">${list[0].address}</span></p>
        </div>
    </div>

    <div class="list-card">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h5 class="m-0 font-weight-bold">최근 발생 내역</h5>
            
            <c:if test="${!empty login && login.gradeName == '관리자'}">
                <a href="writeForm.do" class="btn btn-sm btn-outline-primary" style="border-radius: 8px;">+ 새 재난 등록</a>
            </c:if>
        </div>
        
        <table class="table text-center">
            <thead>
                <tr>
                    <th style="width: 15%">유형</th>
                    <th class="text-left">재난 명칭 / 일시</th>
                    <th style="width: 30%">지역 주소</th>
                    <th style="width: 15%">상세보기</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${list}" var="vo" varStatus="vs">
                    <tr onclick="changeMap('${vo.address}', this)" class="${vs.first ? 'selected-row' : ''}">
                        <td>
                            <span class="badge-custom ${vo.disasterType == '화재' ? 'badge-fire' : 'badge-flood'}">
                                ${vo.disasterType}
                            </span>
                        </td>
                        <td class="text-left">
                            <span class="font-weight-bold d-block" style="font-size: 15px;">${vo.disasterName}</span>
                            <small class="text-muted">${vo.createdAt}</small>
                        </td>
                        <td><small class="text-secondary">${vo.address}</small></td>
                        <td>
                            <button class="btn-view-detail" 
                                    onclick="event.stopPropagation(); location.href='view.do?disasterId=${vo.disasterId}'">
                                내용 보기
                            </button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<script>
function changeMap(address, element) {
    var mapIframe = document.getElementById('googleMap');
    // 구글 지도 임베드 URL 표준 형식으로 수정
    var newSrc = "https://maps.google.com/maps?q=" + encodeURIComponent(address) + "&t=&z=15&ie=UTF8&iwloc=&output=embed";
    mapIframe.src = newSrc;
    
    document.getElementById('currentAddr').innerText = address;
    
    var rows = document.querySelectorAll('tr');
    rows.forEach(r => r.classList.remove('selected-row'));
    element.classList.add('selected-row');
    
    window.scrollTo({top: 0, behavior: 'smooth'});
}
</script>

</body>
</html>