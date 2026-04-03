<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>

<decorator:head>
    <style>
        /* 1. 배경 및 전체 톤 설정 */
        body { background-color: #f4f7f9; font-family: 'Noto Sans KR', sans-serif; }
        
        /* 2. 컨테이너 여백 (상단바 고정 고려) */
        .main-content-wrapper { margin-top: 130px; padding-bottom: 80px; max-width: 1200px; margin-left: auto; margin-right: auto; }

        /* 3. 상단 헤더 영역 */
        .header-section { display: flex; justify-content: space-between; align-items: center; margin-bottom: 40px; }
        .header-title h1 { font-weight: 700; color: #1A237E; font-size: 32px; margin-bottom: 5px; }
        .header-title p { color: #6c7a89; font-size: 16px; }

        /* 4. 등록 버튼 (네이비 톤) */
        .btn-add { 
            background-color: #1A237E; color: white; padding: 12px 25px; 
            border-radius: 12px; font-weight: 600; transition: 0.3s; text-decoration: none !important;
        }
        .btn-add:hover { background-color: #0d145a; color: white; transform: translateY(-2px); }

        /* 5. 요약 카드 디자인 */
        .stat-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 25px; margin-bottom: 40px; }
        .stat-card { background: white; padding: 30px; border-radius: 20px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); text-align: center; }
        .stat-label { color: #888; font-size: 13px; font-weight: 700; text-transform: uppercase; margin-bottom: 10px; display: block; }
        .stat-value { font-size: 36px; font-weight: 800; color: #1A237E; }
        .stat-value.ready { color: #2ecc71; }
        .stat-value.pending { color: #e67e22; }

        /* 6. 테이블 디자인 */
        .table-container { background: white; border-radius: 25px; box-shadow: 0 10px 30px rgba(0,0,0,0.05); overflow: hidden; }
        .custom-table { width: 100%; border-collapse: collapse; }
        .custom-table th { background: #f8f9fa; padding: 18px; text-align: center; color: #555; font-size: 14px; border-bottom: 2px solid #edf2f7; }
        .custom-table td { padding: 20px; border-bottom: 1px solid #f1f4f8; vertical-align: middle; }
        .custom-table tr:hover { background-color: #fcfdfe; cursor: pointer; }

        /* 7. 우선순위 배지 스타일 */
        .badge-p { padding: 6px 12px; border-radius: 8px; font-size: 12px; font-weight: 700; }
        .p-high { background-color: #fff0f0; color: #ff4d4d; }
        .p-mid { background-color: #fff9e6; color: #f39c12; }
        .p-low { background-color: #eef2ff; color: #4361ee; }

        /* 8. 체크박스 및 액션 버튼 */
        .check-custom { width: 20px; height: 20px; cursor: pointer; }
        .action-link { color: #ccc; margin: 0 8px; font-size: 18px; transition: 0.3s; }
        .action-link.edit:hover { color: #4361ee; }
        .action-link.delete:hover { color: #ff4d4d; }
    </style>
</decorator:head>

<div class="main-content-wrapper">

    <div class="header-section">
        <div class="header-title">
            <h1>📋 비상물품 체크리스트</h1>
            <p>재난 대비를 위한 필수 물품을 점검하고 관리하세요.</p>
        </div>
        <a href="writeForm.do?perPageNum=${pageObject.perPageNum}" class="btn-add">
            <i class="fa fa-plus mr-2"></i> 새 물품 추가
        </a>
    </div>

    <div class="stat-grid">
        <div class="stat-card">
            <span class="stat-label">전체 물품</span>
            <div class="stat-value">${meta.total}</div>
        </div>
        <div class="stat-card">
            <span class="stat-label">준비 완료</span>
            <div class="stat-value ready">${meta.ready}</div>
        </div>
        <div class="stat-card">
            <span class="stat-label">준비 필요</span>
            <div class="stat-value pending">${meta.notReady}</div>
        </div>
    </div>

    <div class="table-container">
        <table class="custom-table text-center">
            <thead>
                <tr>
                    <th>상태</th>
                    <th class="text-left">물품명</th>
                    <th>카테고리</th>
                    <th>수량</th>
                    <th>우선순위</th>
                    <th>유효기간</th>
                    <th>관리</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="vo" items="${list}">
                    <tr onclick="location='view.do?no=${vo.no}'">
                        <td onclick="event.stopPropagation();">
                            <input type="checkbox" ${vo.isReady == 'Y' ? 'checked' : ''} class="check-custom">
                        </td>
                        <td class="text-left" style="font-weight: 700; color: #333;">${vo.name}</td>
                        <td style="color: #666;">${vo.category}</td>
                        <td style="font-weight: 700;">${vo.quantity} ${vo.unit}</td>
                        <td>
                            <c:set var="pClass" value="${vo.priority == '높음' ? 'p-high' : (vo.priority == '낮음' ? 'p-low' : 'p-mid')}" />
                            <span class="badge-p ${pClass}">${vo.priority}</span>
                        </td>
                        <td style="color: #999; font-size: 13px;">${vo.expiryDate}</td>
                        <td onclick="event.stopPropagation();">
                            <a href="updateForm.do?no=${vo.no}" class="action-link edit"><i class="fa fa-pencil"></i></a>
                            <a href="delete.do?no=${vo.no}" class="action-link delete" onclick="return confirm('삭제할까요?')"><i class="fa fa-trash"></i></a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        
        <div style="padding: 40px 0; background: #fafbfc;">
            <pageNav:pageNav listURI="list.do" pageObject="${pageObject}" />
        </div>
    </div>
</div>