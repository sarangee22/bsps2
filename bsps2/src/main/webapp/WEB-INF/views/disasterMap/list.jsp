<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>실시간 재난 현황 지도</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">

<style>
    /* 1. 배경 및 폰트 */
    body { background-color: #f4f7f9; font-family: 'Noto Sans KR', sans-serif; color: #333; }
    
    /* 2. 상단 메뉴바와의 간격 통일 (150px) */
    .container { 
        margin-top: 150px !important; 
        padding-bottom: 80px; 
        max-width: 1100px; 
    }

    /* 3. 헤더 섹션 (중앙 정렬 핵심) */
    .header-box { 
        margin-bottom: 50px; 
        text-align: center; /* ⭐ 모든 텍스트 중앙 정렬 */
        display: flex;
        flex-direction: column;
        align-items: center;
    }
    .header-box h2 { 
        font-weight: 700; 
        color: #1A237E; 
        margin-bottom: 20px; 
        font-size: 34px; 
        letter-spacing: -1px;
    }
    
    /* 요약 배지 중앙 정렬 */
    .summary-container { 
        display: flex; 
        justify-content: center; 
        gap: 15px; 
        margin-bottom: 10px; 
    }
    .summary-badge {
        background: white; padding: 12px 25px; border-radius: 50px;
        box-shadow: 0 4px 15px rgba(0,0,0,0.05); font-weight: 700; font-size: 14px;
        display: flex; align-items: center; border: 1px solid #edf2f7;
    }

    /* 4. 지도 섹션 */
    .map-section { margin-bottom: 50px; }
    .map-card { 
        background: white; padding: 15px; border-radius: 30px; 
        box-shadow: 0 20px 40px rgba(0,0,0,0.08); border: none;
    }
    .map-wrapper { 
        width: 100%; height: 500px; border-radius: 20px; 
        overflow: hidden; border: 1px solid #eee;
    }

    /* 5. 리스트 섹션 */
    .list-card { 
        background: white; border-radius: 25px; padding: 40px; 
        box-shadow: 0 10px 30px rgba(0,0,0,0.04); border: none;
    }
    .list-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 25px;
    }
    .list-title { font-weight: 700; color: #1A237E; font-size: 22px; margin: 0; }

    .table thead th { border: none; color: #888; font-weight: 700; font-size: 14px; padding-bottom: 20px; }
    .table tbody tr { transition: 0.3s; cursor: pointer; }
    .table tbody tr:hover { background-color: #f8faff; }
    .table td { vertical-align: middle !important; border-top: 1px solid #f1f3f5; padding: 22px 15px; }

    /* 6. 배지 및 버튼 */
    .badge-custom { padding: 6px 14px; border-radius: 8px; font-weight: 700; font-size: 12px; }
    .badge-fire { background-color: #fff0f0; color: #ff4d4d; }
    .badge-flood { background-color: #eef2ff; color: #4361ee; }
    
    .selected-row { background-color: #f0f4ff !important; }
    .selected-row td:first-child { border-left: 5px solid #1A237E; border-top-left-radius: 12px; border-bottom-left-radius: 12px; }

    .btn-view-detail { 
        background-color: #1A237E; color: white; border-radius: 10px; 
        font-size: 13px; padding: 8px 16px; border: none; font-weight: 600;
    }
    .btn-view-detail:hover { background-color: #0d145a; color: white; }
    
    .btn-add { background-color: #1A237E; color: white !important; border-radius: 10px; padding: 10px 20px; font-weight: 600; text-decoration: none !important; }
</style>
</head>
<body>

<div class="container">
    <div class="header-box">
        <h2>🚨 실시간 재난 모니터링</h2>
        <div class="summary-container">
            <div class="summary-badge"><i class="fas fa-fire text-danger mr-2"></i> 화재 3건</div>
            <div class="summary-badge"><i class="fas fa-water text-primary mr-2"></i> 침수 2건</div>
            <div class="summary-badge"><i class="fas fa-info-circle text-dark mr-2"></i> 총 ${list.size()}건 발생</div>
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
                  src="https://maps.google.com/maps?q={list[0].address}&t=&z=14&ie=UTF8&iwloc=&output=embed">
                </iframe>
            </div>
        </div>
        <div class="text-center mt-4">
            <p style="color: #6c7a89; font-size: 15px;">📍 현재 지도 위치: <span id="currentAddr" class="font-weight-bold" style="color: #1A237E;">${list[0].address}</span></p>
        </div>
    </div>

    <div class="list-card">
        <div class="list-header">
            <h5 class="list-title"><i class="fas fa-list-ul mr-2"></i> 최근 발생 내역</h5>
            <c:if test="${!empty login && login.gradeName == '관리자'}">
                <a href="writeForm.do" class="btn-add">+ 새 재난 등록</a>
            </c:if>
        </div>
        
        <table class="table text-center">
            <thead>
                <tr>
                    <th style="width: 15%">유형</th>
                    <th class="text-left">재난 명칭 / 일시</th>
                    <th style="width: 35%">지역 주소</th>
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
                            <span class="font-weight-bold d-block" style="font-size: 16px; color: #1e293b;">${vo.disasterName}</span>
                            <small style="color: #94a3b8;">${vo.createdAt}</small>
                        </td>
                        <td><small style="color: #64748b; font-weight: 500;">${vo.address}</small></td>
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
    var newSrc = "https://maps.google.com/maps?q=" + encodeURIComponent(address) + "&t=&z=15&ie=UTF8&iwloc=&output=embed";
    mapIframe.src = newSrc;
    
    document.getElementById('currentAddr').innerText = address;
    
    var rows = document.querySelectorAll('tr');
    rows.forEach(r => r.classList.remove('selected-row'));
    element.classList.add('selected-row');
}
</script>

</body>
</html>