<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재난 안전 기관 정보 수정</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">

<style>
    body { background-color: #f8f9fa; font-family: 'Noto Sans KR', sans-serif; color: #333; }
    
    .container { max-width: 700px; }

    .header-section { margin-top: 50px; margin-bottom: 30px; text-align: center; }
    .header-section h2 { font-weight: 700; font-size: 28px; color: #2c3e50; }
    .header-section p { color: #888; font-size: 15px; }

    /* 수정 카드 박스 */
    .update-card { 
        background: white; 
        border-radius: 20px; 
        padding: 40px; 
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05); 
        border: none; 
    }

    /* 입력창 라벨 스타일 */
    .form-group label { 
        font-weight: 600; 
        color: #555; 
        margin-bottom: 8px; 
        font-size: 14px;
        display: flex;
        align-items: center;
    }
    
    .form-group label i { margin-right: 5px; color: #4361ee; }

    /* 인풋 박스 스타일 */
    .form-control, .custom-select {
        height: 50px;
        border-radius: 12px;
        border: 1px solid #e9ecef;
        background-color: #fcfcfc;
        padding: 10px 15px;
        transition: all 0.3s;
        font-size: 15px;
    }
    
    .form-control:focus {
        background-color: #fff;
        border-color: #4361ee;
        box-shadow: 0 0 0 4px rgba(67, 97, 238, 0.05);
        outline: none;
    }

    /* 위도/경도 입력칸 배경색 살짝 다르게 (강조) */
    .location-input { background-color: #f0f4ff; border-color: #dbe4ff; }

    /* 버튼 스타일 */
    .btn-group-custom { display: flex; gap: 12px; margin-top: 40px; }
    
    .btn-submit { 
        flex: 2;
        background-color: #4361ee; 
        color: white; 
        border: none; 
        border-radius: 12px; 
        height: 55px; 
        font-weight: 700; 
        font-size: 16px;
        transition: 0.3s;
        box-shadow: 0 4px 12px rgba(67, 97, 238, 0.2);
    }
    .btn-submit:hover { background-color: #3049c9; transform: translateY(-2px); box-shadow: 0 6px 15px rgba(67, 97, 238, 0.3); }

    .btn-cancel { 
        flex: 1;
        background-color: #f1f3f5; 
        color: #666; 
        border: none; 
        border-radius: 12px; 
        height: 55px; 
        font-weight: 600; 
        display: flex;
        align-items: center;
        justify-content: center;
        text-decoration: none !important;
        transition: 0.2s;
    }
    .btn-cancel:hover { background-color: #e9ecef; color: #333; }

    .required { color: #ff4d4d; margin-left: 4px; }
</style>
</head>
<body>

<div class="container">
    <div class="header-section">
        <h2>🛠 기관 정보 수정</h2>
        <p>선택하신 재난 안전 기관의 정보를 최신 상태로 유지해 주세요.</p>
    </div>

    <div class="update-card">
        <form action="update.do" method="post">
            <input type="hidden" name="agencyId" value="${vo.agencyId}">

            <div class="form-row">
                <div class="form-group col-md-8">
                    <label for="agencyName">기관 명칭 <span class="required">*</span></label>
                    <input type="text" class="form-control" id="agencyName" name="agencyName" 
                           value="${vo.agencyName}" required placeholder="기관 이름을 입력하세요">
                </div>

                <div class="form-group col-md-4">
                    <label for="agencyType">유형 <span class="required">*</span></label>
                    <select class="custom-select" id="agencyType" name="agencyType">
                        <option value="소방" ${vo.agencyType == '소방' ? 'selected' : ''}>소방</option>
                        <option value="경찰" ${vo.agencyType == '경찰' ? 'selected' : ''}>경찰</option>
                        <option value="병원" ${vo.agencyType == '병원' ? 'selected' : ''}>병원</option>
                        <option value="재난" ${vo.agencyType == '재난' ? 'selected' : ''}>재난센터</option>
                        <option value="기타" ${vo.agencyType == '기타' ? 'selected' : ''}>기타</option>
                    </select>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group col-md-6">
                    <label for="phone">비상 연락처 <span class="required">*</span></label>
                    <input type="text" class="form-control" id="phone" name="phone" 
                           value="${vo.phone}" placeholder="02-123-4567">
                </div>
                <div class="form-group col-md-6">
                    <label for="operatingHours">운영 시간</label>
                    <input type="text" class="form-control" id="operatingHours" name="operatingHours" 
                           value="${vo.operatingHours}" placeholder="예: 24시간">
                </div>
            </div>

            <div class="form-group">
                <label for="address">기관 상세 주소 <span class="required">*</span></label>
                <input type="text" class="form-control" id="address" name="address" 
                       value="${vo.address}" placeholder="주소를 입력해 주세요">
            </div>

            <div class="form-row">
                <div class="form-group col-md-6">
                    <label for="latitude">위도 (Latitude)</label>
                    <input type="number" step="any" class="form-control location-input" id="latitude" name="latitude" 
                           value="${vo.latitude}" placeholder="37.XXXX">
                </div>
                <div class="form-group col-md-6">
                    <label for="longitude">경도 (Longitude)</label>
                    <input type="number" step="any" class="form-control location-input" id="longitude" name="longitude" 
                           value="${vo.longitude}" placeholder="127.XXXX">
                </div>
            </div>

            <div class="btn-group-custom">
                <button type="submit" class="btn-submit">변경사항 저장</button>
                <a href="view.do?agencyId=${vo.agencyId}" class="btn-cancel">취소</a>
            </div>
        </form>
    </div>
    
    <div class="text-center mt-4 mb-5 text-muted" style="font-size: 13px;">
        ID: <span class="font-weight-bold">${vo.agencyId}</span> 기관 정보를 수정 중입니다.
    </div>
</div>

</body>
</html>