<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>새 기관 등록</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<style>
    body { background-color: #f8f9fa; font-family: 'Noto Sans KR', sans-serif; color: #333; }
    
    .container { max-width: 600px; }

    .header-section { margin-top: 60px; margin-bottom: 30px; text-align: center; }
    .header-section h2 { font-weight: 700; font-size: 28px; }
    .header-section p { color: #888; }

    /* 등록 카드 박스 (원래 디자인 유지) */
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
    
    .form-control, .custom-select {
        height: 50px;
        border-radius: 10px;
        border: 1px solid #ddd;
        padding: 10px 15px;
        transition: all 0.3s;
    }
    
    .form-control:focus {
        border-color: #4361ee;
        box-shadow: 0 0 0 0.2rem rgba(67, 97, 238, 0.1);
    }

    /* 하단 버튼 영역 */
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

    /* 목록/취소 버튼 스타일 유지 */
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
        <h2>📝 기관 정보 등록</h2>
        <p>새로운 재난 안전 기관의 정보를 정확히 입력해 주세요.</p>
    </div>

    <div class="write-card">
        <form action="write.do" method="post">
            
            <div class="form-row">
                <div class="form-group col-md-8">
                    <label for="agencyName">기관 명칭 <span class="required">*</span></label>
                    <input type="text" name="agencyName" id="agencyName" class="form-control" placeholder="예: 서울 강남소방서" required>
                </div>
                <div class="form-group col-md-4">
                    <label for="agencyType">유형 <span class="required">*</span></label>
                    <select name="agencyType" id="agencyType" class="custom-select" required>
                        <option value="" disabled selected>선택</option>
                        <option value="소방">소방</option>
                        <option value="경찰">경찰</option>
                        <option value="병원">병원</option>
                        <option value="재난">재난센터</option>
                    </select>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group col-md-6">
                    <label for="phone">비상 연락처 <span class="required">*</span></label>
                    <input type="text" name="phone" id="phone" class="form-control" placeholder="02-123-4567" required>
                </div>
                <div class="form-group col-md-6">
                    <label for="operatingHours">운영 시간</label>
                    <input type="text" name="operatingHours" id="operatingHours" class="form-control" placeholder="예: 24시간 또는 09:00~18:00">
                </div>
            </div>

            <div class="form-group">
                <label for="address">상세 주소 <span class="required">*</span></label>
                <input type="text" name="address" id="address" class="form-control" placeholder="서울특별시 강남구..." required>
            </div>

            <div class="form-row">
                <div class="form-group col-md-6">
                    <label for="latitude">위도 (Latitude)</label>
                    <input type="number" step="any" name="latitude" id="latitude" class="form-control" placeholder="37.XXXX">
                </div>
                <div class="form-group col-md-6">
                    <label for="longitude">경도 (Longitude)</label>
                    <input type="number" step="any" name="longitude" id="longitude" class="form-control" placeholder="127.XXXX">
                </div>
            </div>

            <div class="btn-group-custom">
                <button type="submit" class="btn-submit">
                    <i class="fa-solid fa-check me-1"></i> 등록하기
                </button>
                <a href="list.do" class="btn-cancel">
                    <i class="fa-solid fa-list me-1"></i> 목록으로
                </a>
            </div>
        </form>
    </div>
    
    <div class="text-center mt-4 mb-5">
        <small class="text-muted">입력하신 정보는 즉시 리스트에 반영됩니다.</small>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>