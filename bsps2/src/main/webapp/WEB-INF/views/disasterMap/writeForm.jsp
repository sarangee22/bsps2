<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>재난 정보 등록</title>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<style>
    body { background-color: #f8f9fa; font-family: 'Noto Sans KR', sans-serif; color: #333; }
    
    .container { max-width: 650px; } /* 중앙 집중형 레이아웃을 위해 너비 제한 */

    .header-section { margin-top: 60px; margin-bottom: 30px; text-align: center; }
    .header-section h2 { font-weight: 700; font-size: 28px; }
    .header-section p { color: #888; }

    /* 등록 카드 박스 (사용자 선호 스타일) */
    .write-card { 
        background: white; 
        border-radius: 20px; 
        padding: 40px; 
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08); 
        border: none; 
    }

    /* 입력창 스타일 */
    .form-group label { 
        font-weight: 600; 
        color: #555; 
        margin-bottom: 8px; 
        font-size: 14px;
    }
    
    .form-control {
        height: 50px;
        border-radius: 10px;
        border: 1px solid #ddd;
        padding: 10px 15px;
        font-size: 14px;
        transition: all 0.3s;
    }
    
    .form-control:focus {
        border-color: #4361ee;
        box-shadow: 0 0 0 0.2rem rgba(67, 97, 238, 0.1);
    }

    textarea.form-control {
        height: auto !important;
        min-height: 120px;
    }

    /* 하단 버튼 영역 (나란히 배치) */
    .btn-group-custom { display: flex; gap: 10px; margin-top: 30px; }
    
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
        cursor: pointer;
    }
    .btn-submit:hover { background-color: #3049c9; transform: translateY(-2px); text-decoration: none; color: white; }

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
        transition: 0.3s;
    }
    .btn-cancel:hover { background-color: #e9ecef; color: #333; transform: translateY(-2px); }

    .required { color: #ff4d4d; margin-left: 3px; }
</style>
</head>

<body>

<div class="container">
    <div class="header-section">
        <h2>🚨 재난 정보 등록</h2>
        <p>발생한 재난 상황을 정확하게 기록해 주세요.</p>
    </div>

    <div class="write-card">
        <form action="write.do" method="post">
            
            <div class="form-row">
                <div class="form-group col-md-6">
                    <label for="disasterName">재난 이름 <span class="required">*</span></label>
                    <input type="text" name="disasterName" id="disasterName" class="form-control" placeholder="예: 한강 범람 위험" required>
                </div>
                <div class="form-group col-md-6">
                    <label for="disasterType">재난 유형 <span class="required">*</span></label>
                    <input type="text" name="disasterType" id="disasterType" class="form-control" placeholder="예: 호우/홍수" required>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group col-md-6">
                    <label for="region">발생 지역</label>
                    <input type="text" name="region" id="region" class="form-control" placeholder="예: 서울 마포구">
                </div>
                <div class="col-md-6 form-group">
                    <label for="address">상세 주소</label>
                    <input type="text" name="address" id="address" class="form-control" placeholder="상세 위치 입력">
                </div>
            </div>

            <div class="form-row">
                <div class="form-group col-md-6">
                    <label for="latitude">위도 (Latitude)</label>
                    <input type="number" step="any" name="latitude" id="latitude" class="form-control" placeholder="37.XXXX">
                </div>
                <div class="form-group col-md-6">
                    <label for="longitude">경도 (Longitude)</label>
                    <input type="number" step="any" name="longitude" id="longitude" class="form-control" placeholder="126.XXXX">
                </div>
            </div>

            <div class="form-group">
                <label for="content">상세 내용 및 조치 사항</label>
                <textarea name="content" id="content" class="form-control" placeholder="현재 상황을 상세히 입력해 주세요."></textarea>
            </div>

            <div class="btn-group-custom">
                <button type="submit" class="btn-submit">
                    <i class="fa-solid fa-paper-plane me-1"></i> 등록하기
                </button>
                <a href="list.do" class="btn-cancel">
                    <i class="fa-solid fa-list me-1"></i> 목록으로
                </a>
            </div>
        </form>
    </div>
    
    <div class="text-center mt-4 mb-5">
        <small class="text-muted">입력하신 데이터는 실시간 재난 지도에 반영됩니다.</small>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>