<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재난 안전 기관 정보 수정</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">
    <div class="card">
        <div class="card-header bg-primary text-white">
            <h3>🏢 기관 정보 수정</h3>
        </div>
        <div class="card-body">
            <form action="update.do" method="post">
                
                <input type="hidden" name="agencyId" value="${vo.agencyId}">

                <div class="form-group">
                    <label for="agencyName">기관명</label>
                    <input type="text" class="form-control" id="agencyName" name="agencyName" 
                           value="${vo.agencyName}" required>
                </div>

                <div class="form-group">
                    <label for="agencyType">기관 유형</label>
                    <select class="form-control" id="agencyType" name="agencyType">
                        <option value="소방" ${vo.agencyType == '소방' ? 'selected' : ''}>소방</option>
                        <option value="경찰" ${vo.agencyType == '경찰' ? 'selected' : ''}>경찰</option>
                        <option value="병원" ${vo.agencyType == '병원' ? 'selected' : ''}>병원</option>
                        <option value="기타" ${vo.agencyType == '기타' ? 'selected' : ''}>기타</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="phone">연락처</label>
                    <input type="text" class="form-control" id="phone" name="phone" 
                           value="${vo.phone}">
                </div>

                <div class="form-group">
                    <label for="address">주소</label>
                    <input type="text" class="form-control" id="address" name="address" 
                           value="${vo.address}">
                </div>

                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="latitude">위도(Latitude)</label>
                            <input type="number" step="any" class="form-control" id="latitude" name="latitude" 
                                   value="${vo.latitude}">
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="longitude">경도(Longitude)</label>
                            <input type="number" step="any" class="form-control" id="longitude" name="longitude" 
                                   value="${vo.longitude}">
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label for="operatingHours">운영 시간</label>
                    <input type="text" class="form-control" id="operatingHours" name="operatingHours" 
                           value="${vo.operatingHours}">
                </div>

                <div class="text-center mt-4">
                    <button type="submit" class="btn btn-primary px-5">수정 완료</button>
                    <a href="view.do?agencyId=${vo.agencyId}" class="btn btn-secondary px-5">취소</a>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>
</html>