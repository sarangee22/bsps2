<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재난 안전 기관 목록</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">

<style>

    body { background-color: #f8f9fa; font-family: 'Noto Sans KR', sans-serif; color: #333; }
    
    .header-section { display: flex; justify-content: space-between; align-items: center; margin-top: 50px; margin-bottom: 30px; }
    .title-box h2 { font-weight: 700; font-size: 28px; margin-bottom: 5px; }
    .title-box p { color: #888; font-size: 14px; }

    .content-card { background: white; border-radius: 20px; padding: 30px; box-shadow: 0 8px 30px rgba(0, 0, 0, 0.05); border: none; }

    .search-filter-box {
        background-color: #fcfcfc;
        border: 1px solid #eee;
        padding: 20px;
        border-radius: 15px;
        margin-bottom: 25px;
    }
    
    .form-control, .custom-select {
        height: 45px;
        border-radius: 8px;
        border: 1px solid #ddd;
        font-size: 14px;
    }

    .table { border-collapse: separate; border-spacing: 0 10px; }
    .table thead th { border: none; color: #888; font-size: 13px; padding-bottom: 15px; }
    .table tbody tr { background-color: white; transition: all 0.2s; cursor: pointer; }
    .table tbody tr:hover { transform: translateY(-3px); box-shadow: 0 5px 15px rgba(0,0,0,0.08); background-color: #fff !important; }
    .table td { vertical-align: middle !important; border-top: 1px solid #f1f3f5; border-bottom: 1px solid #f1f3f5; padding: 20px 10px; }
    .table td:first-child { border-left: 1px solid #f1f3f5; border-top-left-radius: 12px; border-bottom-left-radius: 12px; }
    .table td:last-child { border-right: 1px solid #f1f3f5; border-top-right-radius: 12px; border-bottom-right-radius: 12px; }

   
    .badge-custom { padding: 6px 14px; border-radius: 20px; font-weight: 500; font-size: 12px; display: inline-block; min-width: 70px; }
    .badge-fire { background-color: #fff0f0; color: #ff4d4d; }
    .badge-police { background-color: #eef2ff; color: #4361ee; }
    .badge-hospital { background-color: #effaf3; color: #2ecc71; }
    .badge-center { background-color: #fff9db; color: #f39c12; }
    .badge-etc { background-color: #f1f3f5; color: #868e96; }

    .btn-search { background-color: #333; color: white; border-radius: 8px; font-weight: 500; padding: 0 25px; }
    .btn-reset { background-color: #eee; color: #666; border-radius: 8px; font-weight: 500; padding: 0 20px; margin-left: 10px; display: flex; align-items: center; justify-content: center; text-decoration: none !important; }
    .btn-reset:hover { background-color: #ddd; color: #333; }
    .btn-add { background-color: #4361ee; border: none; border-radius: 10px; padding: 10px 25px; font-weight: 600; color: white; text-decoration: none !important; }
</style>
</head>
<body>

<div class="container">
    <div class="header-section">
        <div class="title-box">
            <h2>🏢 재난 안전 기관</h2>
            <p>유형별 기관 연락처를 빠르게 조회하고 검색할 수 있습니다.</p>
        </div>
        <c:if test="${!empty login && login.gradeName == '관리자' }">
        	<a href="writeForm.do" class="btn-add"> + 새 기관 등록</a>
        </c:if>
    </div>

    <div class="content-card">
        <div class="search-filter-box">
            <form action="list.do" method="get" class="form-inline justify-content-start">
                <select name="key" class="custom-select mr-2" style="width: 150px;">
                    <option value="">전체 유형</option>
                    <option value="소방" ${pageObject.key == '소방' ? 'selected' : ''}>소방</option>
                    <option value="경찰" ${pageObject.key == '경찰' ? 'selected' : ''}>경찰</option>
                    <option value="병원" ${pageObject.key == '병원' ? 'selected' : ''}>병원/보건소</option>
                    <option value="재난" ${pageObject.key == '재난' ? 'selected' : ''}>재난센터</option>
                    <option value="기타" ${pageObject.key == '기타' ? 'selected' : ''}>기타</option>
                </select>

                <input type="text" name="word" class="form-control mr-2" placeholder="기관명을 입력하세요" value="${pageObject.word}" style="flex: 1; max-width: 400px;">
                
                <button class="btn btn-search h-100" type="submit">검색</button>
                
                <a href="list.do" class="btn-reset h-100" title="검색 초기화">초기화</a>
            </form>
        </div>

        <table class="table text-center">
            <thead>
                <tr>
                    <th style="width: 10%">번호</th>
                    <th style="width: 45%" class="text-left">기관 명칭</th>
                    <th style="width: 20%">기관 유형</th>
                    <th style="width: 25%">비상 연락처</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${list}" var="vo">
                    <tr onclick="location='view.do?agencyId=${vo.agencyId}'">
                        <td class="text-muted">${vo.rnum}</td> 
                        <td class="text-left font-weight-bold" style="font-size: 16px; color: #2c3e50;">
                            ${vo.agencyName}
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${vo.agencyType == '소방' || vo.agencyType == '소방서'}">
                                    <span class="badge-custom badge-fire">소방</span>
                                </c:when>
                                <c:when test="${vo.agencyType == '경찰' || vo.agencyType == '경찰서'}">
                                    <span class="badge-custom badge-police">경찰</span>
                                </c:when>
                                <c:when test="${vo.agencyType == '병원' || vo.agencyType == '보건소'}">
                                    <span class="badge-custom badge-hospital">병원</span>
                                </c:when>
                                <c:when test="${vo.agencyType == '재난' || vo.agencyType == '재난센터'}">
                                    <span class="badge-custom badge-center">재난센터</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge-custom badge-etc">${vo.agencyType}</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td class="text-primary font-weight-bold" style="letter-spacing: 0.5px;">
                            ${vo.phone}
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty list}">
                    <tr>
                        <td colspan="4" class="py-5 text-muted">검색된 기관이 없습니다.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>

        <div class="d-flex justify-content-center mt-5">
            <pageNav:pageNav listURI="list.do" pageObject="${pageObject}" />
        </div>
    </div>
</div>

</body>
</html>