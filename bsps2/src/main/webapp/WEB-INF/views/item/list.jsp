<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
    <title>비상물품 체크리스트</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #F9FAFB; }
        .priority-high { background-color: #FEE2E2; color: #991B1B; } 
        .priority-mid { background-color: #FEF3C7; color: #92400E; }  
        .priority-low { background-color: #E0F2FE; color: #075985; }  
    </style>
</head>
<body class="p-6 md:p-10">

    <div class="flex items-center justify-between mb-8">
        <div class="flex items-center gap-3">
            <div class="p-3 bg-blue-600 rounded-xl text-white">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-3 7h3m-3 4h3m-6-4h.01M9 16h.01"></path></svg>
            </div>
            <div>
                <h1 class="text-2xl font-bold text-gray-900">비상물품 체크리스트</h1>
                <p class="text-gray-500 text-sm">등록된 모든 비상물품을 관리하고 확인하세요.</p>
            </div>
        </div>
        <a href="writeForm.do?perPageNum=${pageObject.perPageNum}" class="px-5 py-2 bg-blue-600 text-white rounded-lg font-semibold flex items-center gap-2 hover:bg-blue-700">
            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"></path></svg>
            새 물품 추가
        </a>
    </div>

    <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-10">
        <div class="bg-white p-6 rounded-2xl border border-gray-100 shadow-sm flex items-center justify-between">
            <div><p class="text-xs font-medium text-gray-400 uppercase">전체 물품</p><p class="text-4xl font-black text-gray-900 mt-1">${meta.total}</p></div>
            <div class="p-3 bg-blue-50 text-blue-500 rounded-xl"><svg class="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 11m8 4L4 11m16 4v10l-8 4m0-10v10"></path></svg></div>
        </div>
        <div class="bg-white p-6 rounded-2xl border border-gray-100 shadow-sm flex items-center justify-between">
            <div><p class="text-xs font-medium text-gray-400 uppercase">확인 완료</p><p class="text-4xl font-black text-green-600 mt-1">${meta.ready}</p></div>
            <div class="p-3 bg-green-50 text-green-500 rounded-xl"><svg class="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg></div>
        </div>
        <div class="bg-white p-6 rounded-2xl border border-gray-100 shadow-sm flex items-center justify-between">
            <div><p class="text-xs font-medium text-gray-400 uppercase">미확인</p><p class="text-4xl font-black text-orange-600 mt-1">${meta.notReady}</p></div>
            <div class="p-3 bg-orange-50 text-orange-500 rounded-xl"><svg class="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg></div>
        </div>
    </div>

    <div class="bg-white rounded-2xl border border-gray-100 shadow-sm overflow-hidden">
        <table class="w-full text-sm text-left">
            <thead class="bg-gray-50 text-gray-500 font-medium border-b border-gray-100">
                <tr>
                    <th class="px-6 py-4 w-16 text-center">상태</th>
                    <th class="px-6 py-4">물품명</th>
                    <th class="px-6 py-4">카테고리</th>
                    <th class="px-6 py-4">수량</th>
                    <th class="px-6 py-4 text-center">우선순위</th>
                    <th class="px-6 py-4">유효기한</th>
                    <th class="px-6 py-4 text-center">작업</th>
                </tr>
            </thead>
            <tbody class="divide-y divide-gray-50">
                <c:forEach var="vo" items="${list}">
                    <tr class="hover:bg-gray-50 cursor-pointer" onclick="location='view.do?no=${vo.no}&page=${pageObject.page}&perPageNum=${pageObject.perPageNum}'">
                        <td class="px-6 py-4 text-center" onclick="event.stopPropagation();">
                            <input type="checkbox" ${vo.isReady == 'Y' ? 'checked' : ''} class="w-5 h-5 accent-gray-900 rounded border-gray-300 pointer-events-none">
                        </td>
                        <td class="px-6 py-4 font-bold text-gray-900">${vo.name}</td>
                        <td class="px-6 py-4 text-gray-500">${vo.category}</td>
                        <td class="px-6 py-4 font-medium">${vo.quantity} ${vo.unit}</td>
                        <td class="px-6 py-4 text-center">
                            <c:set var="pClass" value="${vo.priority == '높음' ? 'priority-high' : (vo.priority == '낮음' ? 'priority-low' : 'priority-mid')}" />
                            <span class="px-3 py-1 text-xs font-bold rounded-full ${pClass}">${vo.priority}</span>
                        </td>
                        <td class="px-6 py-4 text-gray-400">${vo.expiryDate}</td>
                        <td class="px-6 py-4 text-center" onclick="event.stopPropagation();">
                            <div class="flex items-center justify-center gap-3">
                                <a href="updateForm.do?no=${vo.no}" class="text-gray-400 hover:text-blue-600"><svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"></path></svg></a>
                                <a href="delete.do?no=${vo.no}" class="text-gray-400 hover:text-red-600" onclick="return confirm('삭제하시겠습니까?')"><svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path></svg></a>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <div class="py-10 text-center border-t border-gray-50">
            <pageNav:pageNav listURI="list.do" pageObject="${pageObject}" />
        </div>
    </div>
</body>
</html>